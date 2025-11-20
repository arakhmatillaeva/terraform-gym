#!/bin/bash
set -e

echo "Installing Terraform, AWS CLI, and Infracost on Debian-based system..."

# Update package list
echo "Updating package list..."
sudo apt-get update

# Install dependencies
echo "Installing dependencies..."
sudo apt-get install -y wget curl unzip gnupg software-properties-common

# Install Terraform
echo "Installing Terraform..."
wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt-get update
sudo apt-get install -y terraform

# Install AWS CLI v2
echo "Installing AWS CLI v2..."
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
rm -rf awscliv2.zip aws/

# Install Infracost
echo "Installing Infracost..."
curl -fsSL https://raw.githubusercontent.com/infracost/infracost/master/scripts/install.sh | sh

# Verify installations
echo "Verifying installations..."
echo "Terraform version:"
terraform version
echo "AWS CLI version:"
aws --version
echo "Infracost version:"
infracost --version

echo "All tools installed successfully!"