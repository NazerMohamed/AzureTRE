locals {
  short_service_id               = substr(var.tre_resource_id, -4, -1)
  short_workspace_id             = substr(var.workspace_id, -4, -1)
  short_parent_id                = substr(var.parent_service_id, -4, -1)
  workspace_resource_name_suffix = "${var.tre_id}-ws-${local.short_workspace_id}"
  service_resource_name_suffix   = "${var.tre_id}-ws-${local.short_workspace_id}-svc-${local.short_service_id}"
  core_vnet                      = "vnet-${var.tre_id}"
  core_resource_group_name       = "rg-${var.tre_id}"
  vm_name                        = "windowsvm${local.short_service_id}"
  keyvault_name                  = lower("kv-${substr(local.workspace_resource_name_suffix, -20, -1)}")
  storage_name                   = lower(replace("stg${substr(local.workspace_resource_name_suffix, -8, -1)}", "-", ""))
  nexus_proxy_url                = "https://nexus-${var.tre_id}.azurewebsites.net"
  vm_size = {
    "1 CPU | 3.5GB RAM" = { value = "Standard_DS1_v2" },
    "2 CPU | 7GB RAM"   = { value = "Standard_DS2_v2" },
    "4 CPU | 14GB RAM"  = { value = "Standard_DS3_v2" },
    "8 CPU | 28GB RAM"  = { value = "Standard_DS4_v2" },
    "16 CPU | 56GB RAM" = { value = "Standard_DS5_v2" }
  }
  image_ref = {
    "Windows 10" = {
      "publisher"    = "MicrosoftWindowsDesktop"
      "offer"        = "windows-10"
      "sku"          = "20h2-pro-g2"
      "version"      = "latest"
      "conda_config" = false
    },
    "Server 2019 Data Science VM" = {
      "publisher"    = "microsoft-dsvm"
      "offer"        = "dsvm-win-2019"
      "sku"          = "server-2019"
      "version"      = "latest"
      "conda_config" = true
    }
  }
}
