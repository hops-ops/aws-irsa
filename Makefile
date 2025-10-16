clean:
	rm -rf _output
	rm -rf .up

build:
	up project build

render: render-example

render-all: render-example

render-example:
	up composition render apis/xirsas/composition.yaml examples/xirsas/example.yaml

test:
	up test run tests/*

validate: validate-composition validate-example

validate-composition:
	up composition render apis/xirsas/composition.yaml examples/xirsas/example.yaml --include-full-xr --quiet | crossplane beta validate apis/xirsas --error-on-missing-schemas -

validate-example:
	crossplane beta validate apis/xirsas examples/xirsas

publish:
	@if [ -z "$(tag)" ]; then echo "Error: tag is not set. Usage: make publish tag=<version>"; exit 1; fi
	up project build --push --tag $(tag)

generate-definitions:
	up xrd generate examples/xirsas/example.yaml

generate-function:
	up function generate --language=go-templating render apis/xirsas/composition.yaml