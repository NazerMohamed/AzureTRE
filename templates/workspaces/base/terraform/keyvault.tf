
data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "kv" {
  name                     = "kv-${var.tre_id}${var.tre_resource_id}"
  location                 = azurerm_resource_group.ws.location
  resource_group_name      = azurerm_resource_group.ws.name
  sku_name                 = "standard"
  purge_protection_enabled = true
  tenant_id                = data.azurerm_client_config.current.tenant_id

  lifecycle { ignore_changes = [tags] }
}

resource "azurerm_private_endpoint" "kvpe" {
  name                = "kvpe-${local.workspace_resource_name_suffix}"
  location            = azurerm_resource_group.ws.location
  resource_group_name = azurerm_resource_group.ws.name
  subnet_id           = azurerm_subnet.services.id

  lifecycle { ignore_changes = [tags] }

  private_dns_zone_group {
    name                 = "private-dns-zone-group"
    private_dns_zone_ids = [data.azurerm_private_dns_zone.vaultcore.id]
  }

  private_service_connection {
    name                           = "kvpescv-${local.workspace_resource_name_suffix}"
    private_connection_resource_id = azurerm_key_vault.kv.id
    is_manual_connection           = false
    subresource_names              = ["Vault"]
  }
}
