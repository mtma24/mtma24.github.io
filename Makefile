SHELL := /bin/bash

#PAGES_OVERVIEW = index.html projects.html venue.html organization.html past.html registration.html program-in-prep.html
PAGES_OVERVIEW = index.html venue.html organization.html past.html registration.html projects.html

.PHONY: all build clean publish

build: $(PAGES_OVERVIEW)

publish: build
	git add *.html assets/
	git push origin main

%.html: %.vars _template.html
	./paste.pl _template.html < $< > $@

clean:
	rm -f $(PAGES_OVERVIEW)
