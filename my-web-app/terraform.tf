provider "aws" {
  region = "us-east-1" # Change to your preferred AWS region
}

# Create a Security Group
resource "aws_security_group" "inbound_rules" {
  name        = "aws_security-group"
  description = "Allow ports 8080 and 9000"

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
  }

  ingress {
    from_port   = 9000
    to_port     = 9000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
  }

  ingress {
     from_port = 22
     to_port = 22
     protocol = "tcp"
     cidr_blocks = ["0.0.0.0/0"]
    }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" 
    cidr_blocks = ["0.0.0.0/0"]
  }

  }


resource "aws_instance" "web_instance" {
  ami           = "ami-0c02fb55956c7d316"
  instance_type = "t2.micro"              
  key_name      = "key"
  vpc_security_groups_ids = [
    aws_security_group.inbound_rules.id
  ]

  tags = {
    Name = "web application" # Instance Name
  }
}
