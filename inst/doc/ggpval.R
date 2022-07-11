## ---- echo = FALSE------------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----gh-instalqlation, eval = FALSE-------------------------------------------
#  # Install `ggpval` from CRAN:
#  install.packages("ggpval")
#  
#  # You can install the lastest ggpval from github with:
#  # install.packages("devtools")
#  devtools::install_github("s6juncheng/ggpval")

## ---- message=FALSE-----------------------------------------------------------
library(ggpval)
library(data.table)
library(ggplot2)
A <- rnorm(200, 0, 3)
B <- rnorm(200, 2, 4)
G <- rep(c("G1", "G2"), each = 100)
dt <- data.table(A, B, G)
dt <- melt(dt, id.vars = "G")

## ---- echo=TRUE---------------------------------------------------------------
plt <- ggplot(dt, aes(variable, value)) +
  geom_boxplot() +
  geom_jitter()

add_pval(plt, pairs = list(c(1, 2)), fold_change=TRUE)

## ---- echo=TRUE---------------------------------------------------------------
plt <- ggplot(dt, aes(variable, value)) +
  geom_boxplot() +
  geom_jitter() +
  facet_wrap(~G)
add_pval(plt, pairs = list(c(1, 2)))

## ---- echo=TRUE---------------------------------------------------------------
dt[, mu := mean(value),
   by = c("G", "variable")]

dt[, se := sd(value) / .N,
   by = c("G", "variable")]

plt_bar <- ggplot(dt, aes(x=variable, y=mu, fill = variable)) +
  geom_bar(stat = "identity", position = 'dodge') +
  geom_errorbar(aes(ymin=mu-se, ymax=mu+se),
                width = .2) +
  facet_wrap(~G)

add_pval(plt_bar, pairs = list(c(1, 2)), response = 'value')

## ---- echo=TRUE, results='asis'-----------------------------------------------
add_pval(plt_bar, pairs = list(c(1, 2)), 
         test = 't.test',
         alternative = "less",
         response = 'value',
         pval_star = T)

## ---- echo=TRUE, results='asis'-----------------------------------------------
add_pval(plt, pairs = list(c(1, 2)), annotation = "Awesome")

## ---- echo=TRUE, results='asis'-----------------------------------------------
add_pval(plt, pairs = list(c(1, 2)), annotation = list("Awesome1", "Awesome2"))

