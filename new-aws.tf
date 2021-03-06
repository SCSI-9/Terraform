
provider "aws" {
  region     = "eu-central-1"
}

resource "aws_instance" "jenkins_instances" {
  count = 2
  ami = "ami-009b16df9fcaac611"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.mysg.id] #обязательно приатачить security group к instance
  user_data = <<EOF
#!/bin/bash
sudo yum -y install httpd
echo "<h2>Welcome to my page</h2>" > /var/www/html/index.html
sudo systemctl enable httpd
sudo systemctl start httpd
EOF

  tags = {
          Name = "Jenkins Test Server"
         }
}

resource "aws_security_group" "mysg" {
  name        = "sample1"
  description = "Create a new SecGroup"


  ingress {
    description = "Open httpd port"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_http"
  }
}

