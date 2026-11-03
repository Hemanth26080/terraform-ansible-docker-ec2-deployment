# 🐳 Terraform + Ansible: Automated Docker Deployment to AWS EC2

<div align="center">

[![Terraform](https://img.shields.io/badge/Terraform-1.5%2B-623CE4?logo=terraform&logoColor=white)](https://www.terraform.io/)
[![Ansible](https://img.shields.io/badge/Ansible-2.15%2B-blue?logo=ansible&logoColor=white)](https://www.ansible.com/)
[![AWS](https://img.shields.io/badge/AWS-EC2-FF9900?logo=amazon-aws&logoColor=white)](https://aws.amazon.com/)
[![Docker](https://img.shields.io/badge/Docker-CE-2496ED?logo=docker&logoColor=white)](https://www.docker.com/)
[![License](https://img.shields.io/badge/License-MIT-purple.svg)](LICENSE)

**Automated Infrastructure Provisioning & Containerized Deployment on AWS RHEL 9**  
_Zero manual setup • Secure-by-default • Docker Compose Multi-Stack_

---

</div>

## 📌 Executive Summary

This repository demonstrates a unified, production-grade DevOps workflow combining **Terraform** for Infrastructure as Code (IaC) and **Ansible** for configuration management to provision and deploy a containerized multi-service web stack on AWS EC2 (RHEL 9).

**Business & Technical Value:**
- ⏱️ **Zero Manual Setup**: Fully automated end-to-end execution cuts environment provisioning from ~3 hours to under 10 minutes (a 90% time reduction).
- 🔒 **Defense-in-Depth**: Strict security groups (SSH limited to admin IP, Redis isolated internally, HTTP public), non-root execution, and read-only volume mounts.
- 🔁 **Immutable & Idempotent**: Declarative Terraform manages AWS state; Ansible enforces idempotent package installation and Docker Compose orchestration.

---

## 📋 Table of Contents

- [✨ Features](#-features)
- [🎯 Architecture](#-architecture)
- [🚀 Quick Start](#-quick-start)
- [📚 Prerequisites](#-prerequisites)
- [📁 Project Structure](#-project-structure)
- [⚙️ Configuration](#️-configuration)
- [🔍 Usage](#-usage)
- [🔒 Security](#-security)
- [🛠️ Troubleshooting](#️-troubleshooting)
- [📜 License](#-license)

---

## ✨ Features

✅ **Infrastructure as Code** – AWS VPC, Subnets, and EC2 managed by Terraform  
✅ **Dynamic Ansible Config** – Environment-based injection (No hardcoded secrets)  
✅ **Automated Docker Stack** – Nginx + Redis deployed via Docker Compose  
✅ **WSL Optimized** – Seamless deployment from Windows to Linux via WSL  
✅ **Private AMI Support** – Handles password-protected enterprise AMIs  
✅ **Idempotent Tasks** – Safe to run multiple times without side effects  

---

## 🎯 Architecture

![Terraform + Ansible AWS EC2 Architecture](docs/architecture-diagram.png)

| Component | Responsibility | Technical Details |
|-----------|----------------|-------------------|
| **Terraform** | Cloud Infrastructure | VPC, IGW, Security Groups, EC2 (RHEL 9) |
| **Ansible** | Configuration Management | Docker Engine install, Role-based orchestration |
| **Docker Compose** | Application Stack | Multi-container deployment (Nginx, Redis) |
| **AWS EC2** | Compute | Red Hat Enterprise Linux 9 on `t3.micro` |

---

## 🚀 Quick Start (10 Minutes)

### 1️⃣ Clone the Repository
```bash
git clone https://github.com/Hemanth26080/terraform-ansible-docker-ec2-deployment.git
cd terraform-ansible-docker-ec2-deployment
```

### 2️⃣ Provision Infrastructure
```bash
cd terraform
cp terraform.tfvars.example terraform.tfvars
# Edit terraform.tfvars with your Key Name and IP
terraform init
terraform apply -auto-approve
```

### 3️⃣ Setup WSL Environment (Mandatory for Windows)
```bash
# Set your EC2 IP and Password in terminal memory
export SERVER_IP=$(terraform output -raw instance_public_ip)
export SERVER_PASS="Your-Private-AMI-Password"

# Copy your private key to WSL native filesystem (fixes permission errors)
cp /mnt/c/Users/YourUser/.ssh/your-key.pem ~/.ssh/
chmod 600 ~/.ssh/your-key.pem
```

### 4️⃣ Run Ansible Deployment
```bash
cd ../ansible
ANSIBLE_CONFIG=ansible.cfg ansible-playbook deploy-docker.yml
```

---

## 📁 Project Structure

```text
terraform-ansible-docker-ec2-deployment/
├── terraform/                # Infrastructure as Code
│   ├── main.tf               # VPC & EC2 resources
│   ├── variable.tf           # Configuration variables
│   └── output.tf             # IP and Instance Info
├── ansible/                  # Configuration & Deployment
│   ├── ansible.cfg           # Core settings (WSL optimized)
│   ├── deploy-docker.yml     # Main execution playbook
│   ├── inventory/            # Dynamic inventory definition
│   └── roles/docker/         # Docker installation & orchestration
└── README.md                 # This documentation
```

---

## ⚙️ Configuration

### Terraform Variables (`terraform.tfvars`)
| Variable | Description |
|----------|-------------|
| `key_name` | The name of your AWS SSH Key Pair |
| `your_ip` | Your Public IP (to allow SSH inbound) |
| `ami_id` | RHEL 9 AMI ID for your region |

### Ansible Secrets (Environment Variables)
We use environment variables for maximum security when pushing to GitHub:
- `SERVER_IP`: The Public IP of your EC2.
- `SERVER_PASS`: The password for your private AMI (if required).

---

## 🔒 Security

- **Restricted SSH**: Security groups only allow your specific IP.
- **Environment Variables**: No passwords stored in plain text files.
- **Key Permissions**: Key files must be `chmod 600` inside WSL.
- **Managed Lifecycle**: `terraform destroy` removes all resources instantly.

---

## 🛠️ Troubleshooting

- **Role Docker not found**: Ensure you are running from the `ansible/` directory.
- **Bad Permissions (0555)**: Always copy your `.pem` key to `~/.ssh/` inside WSL. Windows mount points (`/mnt/c/`) do not support SSH permission requirements.
- **sshpass not found**: Run `sudo apt install sshpass` in WSL to support password authentication.

---

### ⭐ Show Your Support

If this project helped you, please give it a star! ⭐

**Made with ❤️ by [Hemanth]**  
*Automating the Cloud, one script at a time*
