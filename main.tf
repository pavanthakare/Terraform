# main.tf

provider "aws" {
  region = "us-east-2"  # Change this to your preferred AWS region
  access_key = "AKIAR4GK6WTVUKUV6FXK"
  secret_key = "yB6w1JVa4oYQFSbygV1gG8bvAGCOPfCxCyckgSF/"
}

resource "aws_vpc" "example" {
  cidr_block = "172.16.5.0/24"
  tags = {
    Name = "example-vpc"
  }
}

resource "aws_subnet" "example" {
  vpc_id            = aws_vpc.example.id
  cidr_block        = "172.16.5.0/24"
  availability_zone = "us-east-2a"  # Ensure this matches your region's AZ
  tags = {
    Name = "example-subnet"
  }
}

resource "aws_security_group" "example" {
  name_prefix = "example-sg"
  description = "Example security group"
  vpc_id      = aws_vpc.example.id

  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "example-sg"
  }
}

resource "aws_instance" "example" {
  ami                    = "ami-09040d770ffe2224f"  
  instance_type          = "t3.large"  
  key_name               = "perringvpc"  
  subnet_id              = aws_subnet.example.id
  associate_public_ip_address = false  # Since it's a private subnet
  private_ip             = "172.16.5.240"
  
  root_block_device {
    volume_size = 100
    volume_type = "gp2"
  }

  vpc_security_group_ids = [aws_security_group.example.id]

  tags = {
    Name = "RKONIVM05"
  }
}
