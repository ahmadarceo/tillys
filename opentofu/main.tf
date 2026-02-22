terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "5.17.0"
    }
  }
}

variable "zone_id" {
  type      = string
  sensitive = true
}

variable "server_ip" {
  type = string
}

resource "cloudflare_dns_record" "apex" {
  zone_id = var.zone_id
  type    = "A"
  name    = "@"
  content = var.server_ip
  ttl     = 1
  proxied = true
}

resource "cloudflare_dns_record" "www" {
  zone_id = var.zone_id
  type    = "A"
  name    = "www"
  content = var.server_ip
  ttl     = 1
  proxied = true
}

resource "cloudflare_zone_setting" "always_online" {
  zone_id    = var.zone_id
  setting_id = "always_online"
  value      = "on"
}