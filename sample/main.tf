provider "aws" {
 region ="eu-west-1"
}

# Create the root API gateway function
#
resource "aws_api_gateway_rest_api" "main" {
  name = "ExampleAPI"
  description = "Example Rest Api"
}

# Create GET on / 
#
resource "aws_api_gateway_method" "root" {
  rest_api_id   = "${aws_api_gateway_rest_api.main.id}"
  resource_id   = "${aws_api_gateway_rest_api.main.root_resource_id}"
  http_method   = "GET"
  authorization = "NONE"
}

# Integration request = MOCK
# http://docs.aws.amazon.com/apigateway/latest/developerguide/how-to-mock-integration.html
#
resource "aws_api_gateway_integration" "root" {
  depends_on  = ["aws_api_gateway_method.root"]
  rest_api_id = "${aws_api_gateway_rest_api.main.id}"
  resource_id = "${aws_api_gateway_rest_api.main.root_resource_id}"
  http_method = "${aws_api_gateway_method.root.http_method}"
  type        = "MOCK"

  request_templates = {
    "application/json" = "{\"statusCode\": 200}"
  }
}

resource "aws_api_gateway_integration_response" "200" {
  rest_api_id = "${aws_api_gateway_rest_api.main.id}"
  resource_id = "${aws_api_gateway_rest_api.main.root_resource_id}"
  http_method = "${aws_api_gateway_method.root.http_method}"
  status_code = "${aws_api_gateway_method_response.200.status_code}"
}

resource "aws_api_gateway_method_response" "200" {
  rest_api_id = "${aws_api_gateway_rest_api.main.id}"
  resource_id = "${aws_api_gateway_rest_api.main.root_resource_id}"
  http_method = "${aws_api_gateway_method.root.http_method}"
  status_code = "200"
}

