provider "aws" {
  region = var.aws_region
}

resource "aws_s3_bucket" "techmarket_site" {
  bucket = var.bucket_name
  # Nota: En entornos estudiantiles, asegúrate de que el nombre sea único
}

resource "aws_s3_bucket_website_configuration" "site_config" {
  bucket = aws_s3_bucket.techmarket_site.id

  index_document {
    suffix = "index.html"
  }
}

resource "aws_s3_bucket_public_access_block" "public_block" {
  bucket = aws_s3_bucket.techmarket_site.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}