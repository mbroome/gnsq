.PHONY: clean-pyc clean-build clean-pyc clean-docs clean-coverage clean-tox docs clean

help:
	@echo "clean-build - remove build artifacts"
	@echo "clean-pyc - remove Python file artifacts"
	@echo "lint - check style with flake8"
	@echo "test - run tests quickly with the default Python"
	@echo "test-all - run tests on every Python version with tox"
	@echo "coverage - check code coverage quickly with the default Python"
	@echo "docs - generate Sphinx HTML documentation, including API docs"
	@echo "release - package and upload a release"
	@echo "dist - package"

clean: clean-build clean-pyc clean-docs clean-coverage clean-tox

clean-build:
	rm -fr build/
	rm -fr dist/
	rm -fr *.egg-info

clean-pyc:
	find . -type f -name "*.py[co]" -delete
	find . -type f -name '*~' -delete
	find . -type d -name "__pycache__" -delete

clean-docs:
	rm -f docs/gnsq.rst
	rm -f docs/gnsq.stream.rst
	rm -f docs/modules.rst
	$(MAKE) -C docs clean

clean-coverage:
	rm -f .coverage
	rm -fr htmlcov/

clean-tox:
	rm -fr .tox

lint:
	flake8 gnsq tests

test:
	py.test tests

test-fast:
	py.test --fast tests

test-all:
	tox

coverage:
	py.test --cov gnsq --cov-report html tests
	open htmlcov/index.html

docs: clean-docs
	sphinx-apidoc -o docs/ gnsq
	$(MAKE) -C docs html
	open docs/_build/html/index.html

release: clean
	python setup.py sdist upload
	python setup.py bdist_wheel upload

dist: clean
	python setup.py sdist
	python setup.py bdist_wheel
	ls -l dist
