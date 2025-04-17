use dep::std::hash::pedersen;
use dep::std::merkle::{compute_root, insert_leaf};

fn main(
    id: Field,
    r: Field,
    old_path: [Field; 8],
    old_root: Field,
    new_root: Field,
    commitment: Field,
    index: Field
) {
    let computed_commitment: Field = pedersen([id, r]);
    assert(computed_commitment == commitment);

    let computed_old_root: Field = compute_root(old_path, index, 8, 0);
    assert(computed_old_root == old_root);

    let computed_new_root: Field = insert_leaf(old_path, index, commitment, 8, 0);
    assert(computed_new_root == new_root);
}
