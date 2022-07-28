provider "aws" {

region = "us-east-1"

access_key = "AKIA4YS2DRZWYASK7NFA"

secret_key = "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"


}

resource "aws_security_group" "sg" {
name = "allow_tls12345"
description = "Allow TLS inbound traffic"


ingress {
description = "SSH"
from_port = 22
to_port = 22
protocol = "tcp"
cidr_blocks = ["0.0.0.0/0"]

}
/*ingress {
description = "HTTP"
from_port = 8080
to_port = 8080
protocol = "tcp"
cidr_blocks = ["0.0.0.0/0"]
}*/

egress {
from_port = 22
to_port = 22
protocol = "tcp"
cidr_blocks = ["0.0.0.0/0"]

}

tags = {
Name = "allow_tls1234"
}
}


resource "aws_instance" "instance"{
ami = "ami-052efd3df9dad4825"
instance_type = "t2.micro"
key_name = "Devops"

 tags = {
    Name = "jenkins-master01"
  }
  user_data = file("userdata.sh")

}



resource "aws_network_interface_sg_attachment" "sg_attachment" {
security_group_id = aws_security_group.sg.id
network_interface_id = aws_instance.instance.primary_network_interface_id
}
