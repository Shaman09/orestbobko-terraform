provider "google" {
  credentials = "/home/shaman/terraform/prod-266512-021d1f424b3a.json" //file("account.json")
  project     = "prod-266512"
  region      = "us-central1"
  zone        = "us-central1-a"
}

resource "google_compute_instance" "vm_instance" {
  count        = "2"
  name         = "orestbobko-instance-${count.index +1}"
  machine_type = "e2-small"

  boot_disk {
    initialize_params {
      image = "centos-cloud/centos-7"
    }
  }

  metadata {
    ssh_key = "shaman:${file("gcp-terraform.pub")}"
  }

  provisioner "remote-exec" {
    inline = [
      "yum install update",
    ]
  }

  //wget -qO- icanhazup.com ~/IP-adresses.txt"
  //metadata_startup_script = "echo ${google_compute_instance.vm_instance.*.self_link.network_interface.0.access_config.0.nat_ip} > ~/IP-adresses.txt"
  network_interface {
    network       = "my-network-122"
    access_config = {}
  }
}

resource "google_compute_network" "vpc_network" {
  name                    = "my-network-122"
  auto_create_subnetworks = "true"
}

resource "google_compute_firewall" "my-network-122" {
  name    = "web-firewall"
  network = "my-network-122"

  allow {
    protocol = "tcp"
    ports    = ["22", "80-9090"]
  }
}

output "ip" {
  value = "${google_compute_instance.vm_instance.*.network_interface.0.access_config.0.nat_ip}"
}
