provider "aws" {
  access_key = "<provide access key>"
  secret_key = "<provide secret key>"
  region     = "us-west-2"   # Replace with your desired AWS region
}
variable "instances" {
  type = map(object({
    instance_type = string
    ami           = string
    subnet_id     = string
  }))
  default = {
    instance1 = {
      instance_type = "t2.micro"
      ami           = "ami-0b8987a72eee28c3d"
      subnet_id     = "subnet-0e09953db95a5ac65"
    }
    instance2 = {
      instance_type = "t2.nano"
      ami           = "ami-0b8987a72eee28c3d"
      subnet_id     = "subnet-0e09953db95a5ac65"
    }
  }
}

resource "aws_instance" "example" {
  for_each = var.instances

  ami           = each.value.ami
  instance_type = each.value.instance_type
  subnet_id     = each.value.subnet_id

  tags = {
    Name = each.key
  }
}
