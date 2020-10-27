provider "github" {
  token = "25a901e0b51faa6221bfa58d60df591335966f3b"
  owner = "Shaman09"
}

resource "github_repository" "orestbobko-terraform" {
  name        = "orestbobko-terraform"
  description = "github-terraform"
}

resource "github_branch" "develop" {
  repository = "orestbobko-terraform"
  branch     = "develop"
}

resource "github_user_ssh_key" "shaman-terraform" {
  title   = "orestbobko-terraform"
  ssh_key = "shaman:${file("id_rsa.pub")}"
}
//resource "github_branch_protection" "orestbobko-terraform" {
  //  repository= github_repository.orestbobko-terraform.node_id
  //  pattern = "main"
  //  enforce_admins = true
}
