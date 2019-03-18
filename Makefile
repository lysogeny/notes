################################
# Edit these:
# 
# Configure this to be your name. Used for creating blank markdown files.
user="Bobby Tables"
# Your editor should be set, if it is not set by environment already. Try `echo
# $VISUAL` to see if it is something. You can also override it here.
#VISUAL=vim
#################################

# Gets date, and file markdown file for today. Used for creating blank markdown files.
date:=$(shell date +%F)
date_md=$(date).md

md_files:=$(shell find . -iname '*.md') 
# GNU Find is used to find all markdown files in this dir.
# The targets are defined here: The same as the markdown source files, but with
# appropriate endings and in a type-specific subdir.
pdf_targets=$(md_files:./%.md=pdf/%.pdf)
html_targets=$(md_files:./%.md=html/%.html)
docx_targets=$(md_files:./%.md=docx/%.docx)

# Pandoc executable
P=pandoc -s

# Flags needed for compiling each of the different target types.
flags=$< -o $@ # $< is input, $@ is output
html_flags=$(flags) --self-contained --css css/pandoc.css
pdf_flags=$(flags)
docx_flags=$(flags)

# By default, we build pdf and html files. If you want something else, you can change this.
all: pdf html

pdf: $(pdf_targets)

html: $(html_targets) 

docx: $(docx_targets)

%.pdf: %.md
	$P $(pdf_flags)

%.docx: %.md
	$P $(docx_flags)

%.html: %.md
	$P $(html_flags)

pdf/%.pdf: %.md
	$P $(pdf_flags)

html/%.html: %.md
	$P $(html_flags)

docx/%.docx: %.md
	$P $(docx_flags)

# Target for blank (minus metadata) markdown files. 
# Just echos a header into the current date.
# Conveniently, because of how make works, it will not build if you already
# have a file for the current day. You can still override with the -B argument.
%.md:
	echo -e "---\nauthor: $(user)\ndate: $(date)\ntitle:<++>\n---" >> $@

# Rule for the day.
today: $(date_md)

# Edit target, opens editor in current dir
.PHONY: edit
edit: 
	$(VISUAL) .

# experimental index creation
# Kind of a hack
index.md:
	echo 'Index' > index.md
	echo '-----' >> index.md
	echo '$(html_targets)' | tr ' ' '\n' | sed 's/^.*\/\(.*\)$$/| [\1](\1)/'>> index.md

# Delete all built targets that aren't markdown files.
clean:
	rm -f pdf/*.pdf html/*.html docx/*.docx *.pdf *.html *.docx
