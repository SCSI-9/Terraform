provider "aws" {
  region     = "eu-central-1"
  access_key = "AKIAVZ4KB5KU77IHUAFW"
  secret_key = "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"
}

resource "aws_instance" "jenkins_instances" {
  count = 2
  ami = "ami-009b16df9fcaac611"
  instance_type = "t2.micro"
  user_data = <<-EOF
             #!/bin/bash
             sudo su
             yum -y install httpd
             echo "<p> My Instance! </p>" >> /var/www/html/index.html
             sudo systemctl enable httpd
             sudo systemctl start httpd
EOF

  tags = {
          Name = "Jenkins Test Server"
         }
}
