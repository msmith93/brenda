.PHONY: buckets run format echo
BRENDA_CONFIG ?= $(HOME)/.brenda.conf
include $(BRENDA_CONFIG)
export

buckets: project-bucket render-bucket

project-bucket:
	s3cmd mb $(PROJECT_BUCKET)

render-bucket:
	s3cmd mb $(RENDER_OUTPUT)

package:
	tar cfzv $(BLENDER_PROJECT).tar.gz $(BLENDER_PROJECT)

push:
	s3cmd put $(BLENDER_PROJECT).tar.gz $(PROJECT_BUCKET)

format:
	pipenv run black myapp/

echo:
	env