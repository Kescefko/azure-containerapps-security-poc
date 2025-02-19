resource "null_resource" "acr_push_image" {
  depends_on = [azurerm_container_registry.acr]

  provisioner "local-exec" {
    command = <<EOT
      az acr login --name ${azurerm_container_registry.acr.name}
      docker pull nginx:latest
      docker tag nginx:latest ${azurerm_container_registry.acr.login_server}/secure-app:latest
      docker push ${azurerm_container_registry.acr.login_server}/secure-app:latest
    EOT
  }
}
