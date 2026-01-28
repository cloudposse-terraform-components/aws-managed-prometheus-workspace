module "account_map" {
  source  = "cloudposse/stack-config/yaml//modules/remote-state"
  version = "1.8.0"

  component   = "account-map"
  tenant      = var.account_map_enabled ? coalesce(var.account_map_tenant, module.this.tenant) : null
  environment = var.account_map_enabled ? var.account_map_environment : null
  stage       = var.account_map_enabled ? var.account_map_stage : null

  context = module.this.context

  # When account_map is disabled, bypass remote state and use the static account_map variable
  bypass   = !var.account_map_enabled
  defaults = var.account_map
}

module "vpc" {
  source  = "cloudposse/stack-config/yaml//modules/remote-state"
  version = "1.8.0"

  count = local.vpc_endpoint_enabled ? 1 : 0

  component = "vpc"

  context = module.this.context
}
