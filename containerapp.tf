resource "azurerm_container_app" "aca" {
  name                         = "secure-container-app"
  container_app_environment_id = azurerm_container_app_environment.aca_env.id
  resource_group_name          = azurerm_resource_group.rg.name
  revision_mode                = "Single"
  identity {
    type = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.aca_identity.id]
  }

  template {
    container {
      name   = "secure-app"
      image  = "${azurerm_container_registry.acr.login_server}/secure-app:latest"
      cpu    = 0.5
      memory = "1Gi"
      env {
        name  = "AQUA_SEC_AGENT"
        value = "enabled"
      }
    }
  }
}
