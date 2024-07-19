provider "google" {
    credentials = "hashi.json"
    project = "hashicorp-317612"
    region = "us-central1"
}

resource "google_compute_instance" "vm_instance" {
    name         = "gcpvm-instance"
    machine_type = "e2-small"
    zone         = "us-central1-f"
    tags = ["gcpvm-instance","http-server", "https-server", "ssh-server", "port-8200"]
    boot_disk {
        initialize_params {
            image = "ubuntu-2004-focal-v20240229"
        }
    }
    network_interface {
        network    = google_compute_network.my_vpc_network.self_link
        subnetwork = google_compute_subnetwork.public_subnet.self_link
    }
    metadata_startup_script = file("nginx.sh")
}

