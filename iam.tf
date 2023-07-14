provider "aws" {
  region     = "eu-north-1"
  access_key = ""
  secret_key = ""
}
resource "aws_iam_user" "my_user" {
  name = "kuzmauser"
}

// Attach IAM user to the group
resource "aws_iam_group_membership" "my_membership" {
  name  = "my-membership"
  users = [aws_iam_user.my_user.name]
  group = aws_iam_group.my_group.name
}

// Create IAM group
resource "aws_iam_group" "my_group" {
  name = "kuzmagroup"
}

// Create IAM group policy
resource "aws_iam_policy" "my_group_policy" {
  name        = "my-group-policy"
  description = "My IAM group policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = ["ec2:Describe*"]
        Resource = "*"
      }
    ]
  })
}

// Attach policy to the IAM group
resource "aws_iam_group_policy_attachment" "my_attachment" {
  group      = aws_iam_group.my_group.name
  policy_arn = aws_iam_policy.my_group_policy.arn
}
