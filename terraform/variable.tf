variable "aws_region" {
  description = "AWS region"
  default     = "us-east-1"
}

variable "ami_id" {
  description = "Red Hat Enterprise Linux"
  default     = "ami-0220d79f3f480ecf5" # us-east-1 RHEL 9 (update for your region)
}

variable "instance_type" {
  description = "EC2 instance type"
  default     = "t3.micro"
}

variable "key_name" {
  description = "terraform-ansible-key"
  type        = string
}

variable "your_ip" {
  description = "81.220.54.97"
  type        = string
}
