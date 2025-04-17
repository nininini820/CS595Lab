
use dep::std::hash::pedersen_hash;

fn hash_pair(a: Field, b: Field) -> Field {
    pedersen_hash([a, b])
}

fn compute_merkle_root<let N: u32>(leaf: Field, index: Field, hash_path: [Field; N]) -> Field {
    let index_bits: [u1; N] = index.to_le_bits();
    let mut current = leaf;
    for i in 0..N {
        let path_bit = index_bits[i] as bool;
        let (hash_left, hash_right) = if path_bit {
            (hash_path[i], current)
        } else {
            (current, hash_path[i])
        };
        current = pedersen_hash([hash_left, hash_right]);
    }
    current
}



fn main(
    // Private
    r: Field,
    index: Field,
    path: [Field; 8],

    // Public
    root: Field,
    id: Field
) {

    let commitment = hash_pair(id, r);           // This is the actual Merkle leaf
    let computed_root = compute_merkle_root(commitment, index, path);
    assert(computed_root == root);               // Verify root correctness
    let nullifier = id;     
}
