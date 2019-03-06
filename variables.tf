#--------------------------------------------------------------
# Beanstalk Environment Variables
#--------------------------------------------------------------

variable "name" {
  description = "Elastic Beanstalk environment name."
}

variable "description" {
  description = "Elastic Beanstalk environment description."
}

variable "application" {
  description = "Elastic Beanstalk application id."
}

variable "solution_stack_name" {
  default     = "64bit Amazon Linux 2018.03 v2.12.8 running Docker 18.06.1-ce"
  description = "Elastic Beanstalk stack, e.g. Docker, Go, Node, Java, IIS. [Read more](http://docs.aws.amazon.com/elasticbeanstalk/latest/dg/concepts.platforms.html)"
}

variable "wait_for_ready_timeout" {
  default     = "20m"
  description = "The maximum duration that Terraform should wait for an Elastic Beanstalk Environment to be in a ready state before timing out."
}

variable "tier" {
  default     = "WebServer"
  description = "Elastic Beanstalk Environment tier. [WebServer, Worker]"
}

variable "version_label" {
  default     = ""
  description = "Elastic Beanstalk Application version to deploy."
}

#===================== Software =====================#

variable "enable_log_publication_control" {
  default     = "true"
  description = "Copy the log files for your application's Amazon EC2 instances to the Amazon S3 bucket associated with your application."
}

variable "enable_stream_logs" {
  default     = "true"
  description = "Whether to create groups in CloudWatch Logs for proxy and deployment logs, and stream logs from each instance in your environment."
}

variable "logs_delete_on_terminate" {
  default     = "false"
  description = "Whether to delete the log groups when the environment is terminated. If false, the logs are kept RetentionInDays days."
}

variable "logs_retention_in_days" {
  default     = "7"
  description = "The number of days to keep log events before they expire."
}

variable "env_variables" {
  default     = {}
  type        = "map"
  description = "Map of custom environment variables to be provided to the application running on Elastic Beanstalk, e.g. `env_vars = { environment = 'production' debug = 'false' }`"
}

#===================== Instances =====================#

variable "instance_type" {
  default     = "t2.micro"
  description = "The instance type used to run your application in an Elastic Beanstalk environment."
}

variable "monitoring_interval" {
  default     = "1 minute"
  description = "Interval at which you want Amazon CloudWatch metrics returned. [1 minute, 5 minute]"
}

variable "root_volume_type" {
  default     = "gp2"
  description = "Volume type (magnetic, general purpose SSD or provisioned IOPS SSD) to use for the root Amazon EBS volume attached to your environment's EC2 instances. [standard, gp2, io1]"
}

variable "root_volume_size" {
  default     = "8"
  description = "Storage capacity of the root Amazon EBS volume in whole GB."
}

variable "security_groups" {
  type        = "list"
  default     = []
  description = "Lists the Amazon EC2 security groups to assign to the EC2 instances in the Auto Scaling group in order to define firewall rules for the instances"
}

variable "ssh_source_restriction" {
  default     = "0.0.0.0/0"
  description = "Used to lock down SSH access to the EC2 instances."
}

variable "env_app_env" {
  default = "production"
  description = ""
}

#===================== Capacity =====================#

variable "environment_type" {
  default     = "LoadBalanced"
  description = "Environment type, e.g. 'LoadBalanced' or 'SingleInstance'.  If setting to 'SingleInstance', `rolling_update_type` must be set to 'Time', `updating_min_in_service` must be set to 0, and `public_subnets` will be unused (it applies to the ELB, which does not exist in SingleInstance environments)"
}

variable "autoscale_min" {
  default     = "1"
  description = "The minimum instance count to apply when the action runs."
}

variable "autoscale_max" {
  default     = "1"
  description = "The maximum instance count to apply when the action runs."
}

variable "availability_zones" {
  default     = "Any 2"
  description = "Choose the number of AZs for your instances."
}

variable "autoscale_measure_name" {
  default     = "CPUUtilization"
  description = "Metric used for your Auto Scaling trigger. [CPUUtilization, NetworkIn, NetworkOut, DiskWriteOps, DiskReadBytes, DiskReadOps, DiskWriteBytes, Latency, RequestCount, HealthyHostCount, UnhealthyHostCount, TargetResponseTime]"
}

variable "autoscale_statistic" {
  default     = "Average"
  description = "Statistic the trigger should use. [Minimum, Maximum, Sum, Average]"
}

variable "autoscale_unit" {
  default     = "Percent"
  description = "Unit for the trigger measurement. [Seconds, Percent, Bytes, Bits, Count, Bytes/Second, Bits/Second, Count/Second, None]"
}

variable "autoscale_lower_bound" {
  default     = "20"
  description = "If the measurement falls below this number for the breach duration, a trigger is fired. 0 to 20000000"
}

variable "autoscale_lower_increment" {
  default     = "-1"
  description = "How many Amazon EC2 instances to remove when performing a scaling activity."
}

variable "autoscale_upper_bound" {
  default     = "80"
  description = "If the measurement is higher than this number for the breach duration, a trigger is fired. 0 to 20000000"
}

variable "autoscale_upper_increment" {
  default     = "1"
  description = "How many Amazon EC2 instances to add when performing a scaling activity."
}

#===================== Load balancer =====================#

variable "loadbalancer_type" {
  default     = "classic"
  description = "The type of load balancer for your environment. [classic, application, network]"
}

variable "loadbalancer_certificate_arn" {
  default     = ""
  description = "The ARN of the SSL certificate to bind to the listener. This option is only applicable to environments with an application load balancer and the certificate must be active in AWS Certificate Manager"
}

variable "loadbalancer_ssl_policy" {
  default     = ""
  description = "Specify a security policy to apply to the listener. This option is only applicable to environments with an application load balancer."
}

variable "loadbalancer_cross_zone" {
  default     = "true"
  description = "Configure the load balancer to route traffic evenly across all instances in all Availability Zones rather than only within each zone."
}

variable "connection_draining_enabled" {
  default     = "true"
  description = "Specifies whether the load balancer maintains existing connections to instances that have become unhealthy or deregistered to complete in-progress requests."
}

variable "connection_setting_idle_timeout" {
  default     = "60"
  description = "Number of seconds that the load balancer waits for any data to be sent or received over the connection."
}

variable "http_listener_enabled" {
  default     = "true"
  description = "Enable port 80 (http)"
}

variable "application_port" {
  default     = "80"
  description = "Port application (EC2 Instance) is listening on."
}

variable "loadbalancer_security_groups" {
  type        = "list"
  default     = []
  description = "List of security groups to attach to the load balancer"
}

variable "loadbalancer_managed_security_group" {
  default     = ""
  description = "Assign an existing security group to your environment’s load balancer, instead of creating a new one."
}

variable "access_logs_s3_enabled" {
  default     = "true"
  description = "Enable access log storage."
}

variable "access_logs_s3_bucket" {
  default     = ""
  description = "Amazon S3 bucket in which to store access logs. The bucket must be in the same region as the environment and allow the load balancer write access."
}

#===================== Rolling updates and deployments =====================#

variable "deployment_policy" {
  default     = "Rolling"
  description = "Choose a deployment policy for application version deployments. [AllAtOnce, Rolling, RollingWithAdditionalBatch, Immutable]"
}

variable "batch_size_type" {
  default     = "Fixed"
  description = "The type of number that is specified in BatchSize. [Fixed, Percentage]"
}

variable "batch_size" {
  default     = "1"
  description = "Percentage or fixed number of Amazon EC2 instances in the Auto Scaling group on which to simultaneously perform deployments"
}

variable "rolling_update_enabled" {
  default     = "true"
  description = "If true, enables rolling updates for an environment. Rolling updates are useful when you need to make small, frequent updates to your Elastic Beanstalk software application and you want to avoid application downtime"
}

variable "rolling_update_type" {
  default     = "Health"
  description = "Choose a deployment policy for application version deployments. [Time, Health]"
}

variable "updating_min_in_service" {
  default     = "0"
  description = "The minimum number of instances that must be in service within the autoscaling group while other instances are terminated. 0 to 9999"
}

variable "updating_max_batch" {
  default     = "1"
  description = "The number of instances included in each batch of the rolling update. 1 to 10000"
}

#===================== Security =====================#

variable "keypair" {
  description = "Name of key pair. This key pair must exist in AWS."
}

#===================== Monitoring =====================#

variable "config_document" {
  default     = "{ \"CloudWatchMetrics\": {}, \"Version\": 1}"
  description = "A JSON document describing the environment and instance metrics to publish to CloudWatch."
}

variable "enhanced_reporting_enabled" {
  default     = "enhanced"
  description = "Health reporting system (basic or enhanced)"
}

variable "health_streaming_enabled" {
  default     = "true"
  description = "For environments with enhanced health reporting enabled, whether to create a group in CloudWatch Logs for environment health and archive Elastic Beanstalk environment health data. For information about enabling enhanced health, see aws:elasticbeanstalk:healthreporting:system."
}

variable "health_streaming_delete_on_terminate" {
  default     = "false"
  description = "Whether to delete the log group when the environment is terminated. If false, the health data is kept RetentionInDays days."
}

variable "health_streaming_retention_in_days" {
  default     = "14"
  description = "The number of days to keep the archived health data before it expires."
}

variable "healthcheck_url" {
  default     = "/"
  description = "Path to which to send HTTP requests for health checks."
}

#===================== Managed Updates =====================#

variable "enable_managed_actions" {
  default     = "true"
  description = "Enable managed platform updates. When you set this to true, you must also specify a `PreferredStartTime` and `UpdateLevel`"
}

variable "preferred_start_time" {
  default     = "Tue:15:15"
  #Wednesday 2:15am +1100 GMT
  description = "Configure a maintenance window for managed actions in UTC"
}

variable "update_level" {
  default     = "minor"
  description = "The highest level of update to apply with managed platform updates. [patch, minor]"
}

variable "instance_refresh_enabled" {
  default     = "true"
  description = "Enable weekly instance replacement. Requires ManagedActionsEnabled to be set to true."
}

#===================== Notifications =====================#

variable "notification_protocol" {
  default     = "email"
  description = "Protocol used to send notifications to your endpoint. [http, https, email, email-json, sqs]"
}

variable "notification_endpoint" {
  default     = ""
  description = "Endpoint where you want to be notified of important events affecting your application."
}

variable "notification_topic_arn" {
  default     = ""
  description = "Amazon Resource Name for the topic you subscribed to."
}

variable "notification_topic_name" {
  default     = ""
  description = "Name of the topic you subscribed to."
}

#===================== Network =====================#

variable "vpc_id" {
  description = "The ID for your Amazon VPC."
}

variable "elb_scheme" {
  default     = "public"
  description = "Specify `internal` if you want to create an internal load balancer in your Amazon VPC so that your Elastic Beanstalk application cannot be accessed from outside your Amazon VPC."
}

variable "public_subnets" {
  type        = "list"
  default     = []
  description = "The IDs of the subnet or subnets for the elastic load balancer."
}

variable "associate_public_ip_address" {
  default     = "false"
  description = "Specifies whether to launch instances with public IP addresses in your Amazon VPC."
}

variable "private_subnets" {
  type        = "list"
  default     = []
  description = "The IDs of the Auto Scaling group subnet or subnets."
}

#===================== Database =====================#

#===================== Tags =====================#

variable "tags" {
  type        = "map"
  default     = {}
  description = "Additional tags (e.g. `tags = { application_type = 'website' environment = 'production' }"
}
