Terraform module to provision AWS Elastic Beanstalk Environment.

## Module Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
|name|Elastic Beanstalk environment name.|string|-|yes|
|description|Elastic Beanstalk environment description.|string|-|yes|
|application|Elastic Beanstalk application id.|string|-|yes|
|solution_stack_name|Elastic Beanstalk stack, e.g. Docker, Go, Node, Java, IIS. [Read more](http://docs.aws.amazon.com/elasticbeanstalk/latest/dg/concepts.platforms.html)|string|64bit Amazon Linux 2018.03 v2.12.8 running Docker 18.06.1-ce|no|
|wait_for_ready_timeout|The maximum duration that Terraform should wait for an Elastic Beanstalk Environment to be in a ready state before timing out.|string|20m|no|
|tier|Elastic Beanstalk Environment tier. [WebServer, Worker]|string|WebServer|no|
|version_label|Elastic Beanstalk Application version to deploy.|string|-|no|
|enable_log_publication_control|Copy the log files for your application's Amazon EC2 instances to the Amazon S3 bucket associated with your application.|string|true|no|
|enable_stream_logs|Whether to create groups in CloudWatch Logs for proxy and deployment logs, and stream logs from each instance in your environment.|string|true|no|
|logs_delete_on_terminate|Whether to delete the log groups when the environment is terminated. If false, the logs are kept RetentionInDays days.|string|false|no|
|logs_retention_in_days|The number of days to keep log events before they expire.|string|7|no|
|env_variables|Map of custom environment variables to be provided to the application running on Elastic Beanstalk, e.g. `env_vars = { environment = 'production' debug = 'false' }`|map|-|no|
|instance_type|The instance type used to run your application in an Elastic Beanstalk environment.|string|t2.micro|no|
|root_volume_type|Volume type (magnetic, general purpose SSD or provisioned IOPS SSD) to use for the root Amazon EBS volume attached to your environment's EC2 instances. [standard, gp2, io1]|string|gp2|no|
|root_volume_size|Storage capacity of the root Amazon EBS volume in whole GB.|string|8|no|
|security_groupsstring|Lists the Amazon EC2 security groups to assign to the EC2 instances in the Auto Scaling group in order to define firewall rules for the instances|list|-|no|
|ssh_source_restriction|Used to lock down SSH access to the EC2 instances.|string|0.0.0.0/0|no|
|environment_type|Environment type, e.g. 'LoadBalanced' or 'SingleInstance'.  If setting to 'SingleInstance', `rolling_update_type` must be set to 'Time', `updating_min_in_service` must be set to 0, and `public_subnets` will be unused (it applies to the ELB, which does not exist in SingleInstance environments)|string|LoadBalanced|no|
|autoscale_min|The minimum instance count to apply when the action runs.|string|1|no|
|autoscale_max|The maximum instance count to apply when the action runs.|string|1|no|
|availability_zones|Choose the number of AZs for your instances.|string|Any 2|no|
|autoscale_measure_name|Metric used for your Auto Scaling trigger. [CPUUtilization, NetworkIn, NetworkOut, DiskWriteOps, DiskReadBytes, DiskReadOps, DiskWriteBytes, Latency, RequestCount, HealthyHostCount, UnhealthyHostCount, TargetResponseTime]|string|CPUUtilization|no|
|autoscale_statistic|Statistic the trigger should use. [Minimum, Maximum, Sum, Average]|string|Average|no|
|autoscale_unit|Unit for the trigger measurement. [Seconds, Percent, Bytes, Bits, Count, Bytes/Second, Bits/Second, Count/Second, None]|string|Percent|no|
|autoscale_lower_bound|If the measurement falls below this number for the breach duration, a trigger is fired. 0 to 20000000|string|20|no|
|autoscale_lower_increment|How many Amazon EC2 instances to remove when performing a scaling activity.|string|-1|no|
|autoscale_upper_bound|If the measurement is higher than this number for the breach duration, a trigger is fired. 0 to 20000000|string|80|no|
|autoscale_upper_increment|How many Amazon EC2 instances to add when performing a scaling activity.|string|1|no|
|loadbalancer_type|The type of load balancer for your environment. [classic, application, network]|string|classic|no|
|loadbalancer_certificate_arn|The ARN of the SSL certificate to bind to the listener. This option is only applicable to environments with an application load balancer and the certificate must be active in AWS Certificate Manager|string|false|no|
|loadbalancer_ssl_policy|Specify a security policy to apply to the listener. This option is only applicable to environments with an application load balancer.|string|-|no|
|loadbalancer_cross_zone|Configure the load balancer to route traffic evenly across all instances in all Availability Zones rather than only within each zone.|string|true|no|
|connection_draining_enabled|Specifies whether the load balancer maintains existing connections to instances that have become unhealthy or deregistered to complete in-progress requests.|string|true|no|
|connection_setting_idle_timeout|Number of seconds that the load balancer waits for any data to be sent or received over the connection.|string|60|no|
|http_listener_enabled|Enable port 80 (http)|string|true|no|
|application_port|Port application (EC2 Instance) is listening on.|string|80|no|
|loadbalancer_security_groupsstring|List of security groups to attach to the load balancer|list|-|no|
|loadbalancer_managed_security_group|Assign an existing security group to your environment’s load balancer, instead of creating a new one.|string|-|no|
|access_logs_s3_enabled|Enable access log storage.|string|true|no|
|access_logs_s3_bucket|Amazon S3 bucket in which to store access logs. The bucket must be in the same region as the environment and allow the load balancer write access.|string|-|no|
|deployment_policy|Choose a deployment policy for application version deployments. [AllAtOnce, Rolling, RollingWithAdditionalBatch, Immutable]|string|Rolling|no|
|batch_size_type|The type of number that is specified in BatchSize. [Fixed, Percentage]|string|Fixed|no|
|batch_size|Percentage or fixed number of Amazon EC2 instances in the Auto Scaling group on which to simultaneously perform deployments|string|1|no|
|rolling_update_enabled|If true, enables rolling updates for an environment. Rolling updates are useful when you need to make small, frequent updates to your Elastic Beanstalk software application and you want to avoid application downtime|string|true|no|
|rolling_update_type|Choose a deployment policy for application version deployments. [Time, Health]|string|Health|no|
|updating_min_in_service|The minimum number of instances that must be in service within the autoscaling group while other instances are terminated. 0 to 9999|string|0|no|
|updating_max_batch|The number of instances included in each batch of the rolling update. 1 to 10000|string|1|no|
|keypair|Name of key pair. This key pair must exist in AWS.|string|-|yes|
|config_document|A JSON document describing the environment and instance metrics to publish to CloudWatch.|string|{ "CloudWatchMetrics": {}, "Version": 1}|no|
|enhanced_reporting_enabled|Health reporting system (basic or enhanced)|string|enhanced|no|
|health_streaming_enabled|For environments with enhanced health reporting enabled, whether to create a group in CloudWatch Logs for environment health and archive Elastic Beanstalk environment health data. For information about enabling enhanced health, see aws:elasticbeanstalk:healthreporting:system.|string|true|no|
|health_streaming_delete_on_terminate|Whether to delete the log group when the environment is terminated. If false, the health data is kept RetentionInDays days.|string|false|no|
|health_streaming_retention_in_days|The number of days to keep the archived health data before it expires.|string|14|no|
|healthcheck_url|Path to which to send HTTP requests for health checks.|string|/|no|
|enable_managed_actions|Enable managed platform updates. When you set this to true, you must also specify a `PreferredStartTime` and `UpdateLevel`|string|true|no|
|preferred_start_time|Configure a maintenance window for managed actions in UTC|string|Tus:15:15|no|
|update_level|The highest level of update to apply with managed platform updates. [patch, minor]|string|minor|no|
|instance_refresh_enabled|Enable weekly instance replacement. Requires ManagedActionsEnabled to be set to true.|string|true|no|
|notification_protocol|Protocol used to send notifications to your endpoint. [http, https, email, email-json, sqs]|string|email|no|
|notification_endpoint|Endpoint where you want to be notified of important events affecting your application.|string|-|no|
|notification_topic_arn|Amazon Resource Name for the topic you subscribed to.|string|-|no|
|notification_topic_name|Name of the topic you subscribed to.|string|-|no|
|vpc_id|The ID for your Amazon VPC.|string|-|yes|
|elb_scheme|Specify `internal` if you want to create an internal load balancer in your Amazon VPC so that your Elastic Beanstalk application cannot be accessed from outside your Amazon VPC.|string|public|no|
|public_subnets|The IDs of the subnet or subnets for the elastic load balancer.|list|-|yes|
|associate_public_ip_address|Specifies whether to launch instances with public IP addresses in your Amazon VPC.|string|false|no|
|private_subnets|The IDs of the Auto Scaling group subnet or subnets.|list|-|no|
|tags|Additional tags (e.g. `tags = { application_type = 'website' environment = 'production' }|map|-|no

## Module Outputs

| Name | Description |
|------|-------------|
|id|ID of the Elastic Beanstalk environment.|
|name|Name of the Elastic Beanstalk Environment.|
|description|Description of the Elastic Beanstalk Environment.|
|tier|The environment tier specified.|
|application|The Elastic Beanstalk Application specified for this environment.|
|all_settings|List of all option settings configured in the Environment. These are a combination of default settings and their overrides from setting in the configuration.|
|cname|Fully qualified DNS name for the Environment.|
|autoscaling_groups|The autoscaling groups used by this environment.|
|instances|Instances used by this environment.|
|launch_configurations|Launch configurations in use by this environment.|
|load_balancers|Elastic load balancers in use by this environment.|
|queues|SQS queues in use by this environment.|
|triggers|Autoscaling triggers in use by this environment.|