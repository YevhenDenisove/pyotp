SHELL=/bin/bash

env: requirements.txt
	virtualenv --python=python env
	source env/bin/activate; pip install --requirement=requirements.txt
	source env/bin/activate; pip list --outdated

test: env
	-pylint -E src
	source env/bin/activate; ./test.py -v

test3: env
	python3 ./test.py -v

release: docs
	python setup.py sdist bdist_wheel upload --sign

init_docs:
	cd docs; sphinx-quickstart

docs:
	$(MAKE) -C docs html

install:
	./setup.py install

.PHONY: test release docs
