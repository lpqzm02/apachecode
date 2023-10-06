 #creating the lightsail instance
resource "aws_lightsail_instance" "lightsail_instance" {
  name              = "Centos_apache"
  availability_zone = "us-east-1a"
  blueprint_id      = "centos_7_2009_01"
  bundle_id         = "nano_2_0"
  #Key_pair_name = "centos-key" #Key must already exist in AWS or else it wont work.
  tags = {
    name = "utrains devops"
    env  = "dev"
    work = "project 6"
  }

user_data = <<-EOF
    #!/bin/bash
    sudo yum update -y
    sudo yum install unzip wget httpd -y

    sudo wget https://github.com/utrains/static-resume/archive/refs/heads/main.zip
    sudo unzip main.zip
    sudo cp -r static-resume-main/* /var/www/html/

    sudo systemctl start httpd
    sudo systemctl enable httpd
    EOF
}

output "public_ip" {
  value = aws_lightsail_instance.lightsail_instance.public_ip_address
}