data "aws_ami" "amazon-2" {
  most_recent = true
  
  filter {
    name = "name"
    values = ["amzn2-ami-hvm-*-x86_64-ebs"]
 }
 owners = ["amazon"]

}

 resource "aws_security_group" "allow_jenkins" {
  name        = "allow jenkins"
  description = "Allow inbound traffic"
  vpc_id      = "vpc-0770b07019a94a459"

 ingress {
   description      = "TLS from VPC"
   from_port        = 8080
   to_port          = 8080
   protocol         = "tcp"
   cidr_blocks      = ["0.0.0.0/0"]
 }
 
 ingress {
   description      = "ssh"
   from_port        = 22
   to_port          = 22
   protocol         = "tcp"
   cidr_blocks      = ["0.0.0.0/0"]
 }


 egress {
   from_port        = 0
   to_port          = 0
   protocol         = "-1"
   cidr_blocks      = ["0.0.0.0/0"]
   ipv6_cidr_blocks = ["::/0"]
 }

 tags = {
   Name = "jenkins_sg"
 }
}

resource "aws_instance" "jenkins" {
 ami                         = data.aws_ami.amazon-2.id
 associate_public_ip_address = true
 instance_type               = "t2.micro"
 vpc_security_group_ids      = [aws_security_group.allow_jenkins.id]
 subnet_id                   = "subnet-0c28b77477ca0f7b1"
 tags = { 
    Name = "jenkins_server"
 }
}
