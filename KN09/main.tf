provider "aws" {
  region = "us-east-1"
}

# Security Group
resource "aws_security_group" "db_sg" {
  name        = "db-security-group"
  description = "Allow MySQL access"
  
  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# EC2 Instance
resource "aws_instance" "db_instance" {
  ami           = "ami-0e2c8caa4b6378d8c" 
  instance_type = "t2.micro"
  key_name      = "kn05_2"
  
  security_groups = [aws_security_group.db_sg.name]

  user_data = file("C:/Users/piera/OneDrive - bbw.ch/BBW_Schule/346/KN09/cloud-init-db.yaml")

  tags = {
    Name = "DB-Server"
  }
}
