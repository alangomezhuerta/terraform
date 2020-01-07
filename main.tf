terraform {
    required_version = ">= 0.12, < 0.13"
}

provider "aws" {
    profile = "default"
    region = "us-east-2"

}

resource "aws_instance" "example" {
    ami = "ami-0c55b159cbfafe1f0"
    instance_type = "t2.micro"
    vpc_security_group_ids = [aws_security_group.instance.id]

    tags =    {
        Name = "terraform-example"
    }


    user_data  = <<-EOF
    #!/bin/bash
    echo "Just another Hello World statement ha" > index.html
    nohup busybox httpd -f -p 8080 &
    EOF

}

resource "aws_security_group" "instance" {
    name = "terraform-example-instance"
    ingress {
        from_port = 8080
        to_port = 8080
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]

    }

}
