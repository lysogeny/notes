---
title: Simple diary makefile thing
author: Lysogeny
date: 2019-03-18
---

This is a simple makefile for keeping a markdown diary thing using pandoc.
I use this to create a project-specific diary directory in a project directory.

Several useful targets are defined:

today
:   create an empty makefile with your name and current date for the current date with a header.

edit
:   opens `$VISUAL` in this folder

pdf, html, docx
:   creates all pdfs, htmls, docxs or whatever. Targets are collected using GNU find.

all
:   creates pdf and html files for all markdown files in this dir.

clean
:   remove all output files (html, pdf, docx, ...).

For html there is a cascading style sheet in `css/` that you can edit to suit
your needs. If you would rather ignore it, modify the `html_flags` variable to
not include the style sheet.

Usage
-----

Edit the makefile with your name and editor choice (if different from `$VISUAL`).

To create an entry for the current day:

    make today

Then edit the file to write your diary.
Creating all of one specific target type:

    make pdf
    make docx
    make html

Make all default targets (pdf, html):

    make

delete output files:

    make clean

______

**Nota Bene:** you should not run `make -B`, as that will try to rebuild the markdown
files as well, and thus place another YAML header at the tail of the file.
If you want to rebuild your pdfs, htmls, or whatever, do the following:

    make clean
    make html

______


Todo
----

### Features ###

- [ ] Feature to edit current day by refering *today*, something like `make edit today` or similar.

### CSS ###

- [ ] Fancier blockquotes
- [ ] Fancier code segments
- [ ] ???

