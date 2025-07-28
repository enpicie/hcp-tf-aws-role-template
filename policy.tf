resource "aws_iam_policy" "lambda_apigw_full_access" {
  name        = "Terraform-FullAccess-<Resources>"
  description = "Allows HCP Terraform to provision <Resources> resources"
  path        = "/"

  policy = jsonencode({
    Version = "2012-10-17",
    # Statement for Lambda access as an example.
    # Replace with actual resources as needed.
    Statement = [
      {
        Sid    = "LambdaFullAccess",
        Effect = "Allow",
        Action = [
          "lambda:*"
        ],
        Resource = "*"
      }
    ]
  })
}
