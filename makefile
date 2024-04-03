# https://scaron.info/blog/makefiles-for-latex.html
# LaTeX Makefile v0.33 -- LaTeX only

mycompiler=mkdir -pv pgfplotsfigures \
            && pdflatex -halt-on-error --interaction=nonstopmode -file-line-error $(1).tex \
						&& makeglossaries $(1) \
            && [[ -f $(1).makefile ]] && make -j -f $(1).makefile || echo "==$(1).makefile not found==" \
            && rubber -vvvv --pdf $(1).tex
# mycompiler=mkdir -pv pgfplotsfigures \
#           && pdflatex -halt-on-error --interaction=nonstopmode -file-line-error $(1).tex \
# 					&& makeglossaries $(1) \
#           && [[ -f $(1).makefile ]] && make -j -f $(1).makefile || echo "==$(1).makefile not found==" \
#           && latexmk -verbose -f -pdf $(1).tex

all: main.pdf
	evince main.pdf

mainlight: mainl.pdf

mainl.pdf: main.pdf
	gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.5 \
      -dNOPAUSE -dQUIET -dBATCH -dPrinted=false -sOutputFile=mainl.pdf main.pdf
	@du -h main*.pdf


main.pdf main.toc main.bcf &:\
	  curves/*.tex \
    main.tex \
    preamble.tex \
    preamble2.tex \
		manual_all.bib
	$(call mycompiler,main)

biber: main.bcf \
       *.bib
	biber main.bcf

clean:  ## Clean output files
	rubber --clean *.tex preamble.tex
	latexmk -c
	@bash -c "rm -rfv split_*"
	@bash -c "rm -rfv auto"
	@bash -c "rm -rfv chapter*.tex"
	@bash -c "rm -rfv *.pdf"
	@bash -c "rm -rfv *.aux"
	@bash -c "rm -rfv */*.aux"
	@bash -c "rm -rfv *.dvi"
	@bash -c "rm -rfv *.bbl *.blg *.bcf *.nav *.xml *.out *.snm *.log *.toc"
	@bash -c "rm -rfv *.glo* *.glg* *.gls* *.ist *.lof *.lot"
	@bash -c "rm -rfv *.fls *.fdb_latexmk"
	@bash -c "rm -rfv *.mtc* *.maf"
	@bash -c "rm -rfv *.thm"

distclean: clean
	bash -c "rm -rf pgfplotsfigures/*"
	bash -c "rm -rf tikz/auto"
	bash -c "rm -rf *.makefile *.figlist *.auxlock"

watch:  ## Recompile on updates to the source file
	@while [ 1 ]; do; inotifywait ${texfile}; sleep 0.01; make all; done
	# for Bash users, replace the while loop with the following
	# @while true; do; inotifywait $(PAPER); sleep 0.01; make all; done
