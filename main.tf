terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "2.15.0"
    }
  }
}

provider "docker" {
  host = "npipe:////.//pipe//docker_engine"
}

# Pulls the image
resource "docker_image" "ubuntu" {
  name = "ubuntu:latest"
}

# Create a container
resource "docker_container" "my_container" {
  image   = docker_image.ubuntu.latest
  name    = "my_container"
}

# Create a service
resource "docker_service" "my_service" {
  name = "my_service"
  task_spec {
    container_spec {
      image = docker_image.ubuntu.latest
      command = ["echo", "hello world"]
    }
  }
  endpoint_spec {
    ports {
      published_port = "8080"
      target_port = "8080"
    }
  }
}
