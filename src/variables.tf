variable "region" {
  type        = string
  description = "AWS Region"
}

variable "alert_manager_definition" {
  type        = string
  description = "The alert manager definition that you want to be applied."
  default     = ""
}

variable "rule_group_namespaces" {
  type = list(object({
    name = string
    data = string
  }))
  description = "A list of name, data objects for each Amazon Managed Service for Prometheus (AMP) Rule Group Namespace"
  default     = []
}

variable "grafana_account_name" {
  type        = string
  description = "The name of the account allowed to access AMP in this account. If defined, this module will create a cross-account IAM role for accessing AMP. Use this for cross-account Grafana. If not defined, no roles will be created."
  default     = ""
}

variable "account_map_enabled" {
  type        = bool
  description = <<-EOT
    When true, uses the account-map component to look up account IDs dynamically.
    When false, uses the static account_map variable instead. Set to false when
    using static account mappings without the account-map component.
  EOT
  default     = true
}

variable "account_map" {
  type = object({
    full_account_map           = map(string)
    audit_account_account_name = optional(string, "")
    root_account_account_name  = optional(string, "")
  })
  description = <<-EOT
    Static account map used when account_map_enabled is false.
    Provides account name to account ID mapping without requiring the account-map component.
  EOT
  default = {
    full_account_map           = {}
    audit_account_account_name = ""
    root_account_account_name  = ""
  }
}

variable "account_map_tenant" {
  type        = string
  description = "The name of the tenant where `account_map` is provisioned"
  default     = "core"
}

variable "account_map_environment" {
  type        = string
  description = "The name of the environment where `account_map` is provisioned"
  default     = "gbl"
}

variable "account_map_stage" {
  type        = string
  description = "The name of the stage where `account_map` is provisioned"
  default     = "root"
}

variable "vpc_endpoint_enabled" {
  type        = string
  description = "If set to `true`, restrict traffic through a VPC endpoint"
  default     = true
}
