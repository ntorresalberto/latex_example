## full compilation

```console
make clean        # erase most generated files
make distclean    # cleaner
make              # shows pdf
```

#### system dependencies

```console
sudo apt install rubber texlive-full make evince latexmk
```


`robotarm.sty` actually [obtained from here](https://ctan.org/pkg/robotarm?lang=en) and should be packaged with `texlive`, but just in case, it's included in the repo.

---

### About the Thesis template

Github Repo: https://github.com/matteodelucchi/ZHAW_thesis-template

This template was adapted by Matteo Delucchi and others based on a template downloaded from:
[LaTeXTemplates.com](http://www.latextemplates.com/template/masters-doctoral-thesis)

### About the Bordeaux Cover template

Github Repo: https://github.com/cpauvert/latex-template-phd-univ-bordeaux


### About bibliography

original files are all `*.bib` except `manual_all.bib`, which was built using:

```
bibtool -s -d *.bib -o manual_all.bib
```

It doesn't retain capital letters in the references so manual solving is needed, debugging errors from:
```
make biber
```

### About memory limits

you need to modify `main_memory`: https://tex.stackexchange.com/a/24289

```
kpsewhich texmf.cnf
sudo vim /usr/share/texmf/web2c/texmf.cnf
sudo fmtutil-sys --all
```

for some reason it seems to error, but it works with these values:
```
main_memory = 8000000 % words of inimemory available; also applies to inimf&mp
extra_mem_top = 8000000     % extra high memory for chars, tokens, etc.
extra_mem_bot = 8000000     % extra low memory for boxes, glue, breakpoints, etc.

% ConTeXt needs lots of memory.
extra_mem_top.context = 8000000
extra_mem_bot.context = 8000000
```
