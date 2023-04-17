locals {
  nginx_namespace   = "nginx-ingress-controller"
  metrics_namespace = "kube-prometheus-stack"

}

module "crds" {
  source   = "./modules/crds"
  crd_urls = var.crd_urls
}

module "helm" {
  source = "./modules/helm"

  domain_name = var.domain_name


  feature_flag_nginx                       = var.feature_flag_nginx
  nginx_ingress_controller_value_overrides = var.nginx_ingress_controller_value_overrides
  nginx_namespace                          = local.nginx_namespace

  // kube-prometheus-stack
  metrics_namespace                     = local.metrics_namespace
  feature_flag_prometheus               = var.feature_flag_prometheus
  kube_prometheus_stack_value_overrides = var.kube_prometheus_stack_value_overrides

  depends_on = [module.crds]

}
