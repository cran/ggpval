## ---- fig.show='hold'----------------------------------------------------
library(ggpval)
library(data.table)
library(ggplot2)
A <- rnorm(200, 0, 3)
B <- rnorm(200, 2, 4)
G <- rep(c("G1", "G2"), each = 100)
dt <- data.table(A, B, G)
dt <- melt(dt, id.vars = "G")

## ---- echo=FALSE, results='asis'-----------------------------------------
plt <- ggplot(dt, aes(variable, value)) +
  geom_boxplot() +
  geom_jitter()

add_pval(plt, pairs = list(c(1, 2)))

## ---- echo=FALSE, results='asis'-----------------------------------------
plt_facet <- ggplot(dt, aes(variable, value)) +
  geom_boxplot() +
  geom_jitter() +
  facet_wrap(~G)
add_pval(plt_facet, pairs = list(c(1, 2)))

## ---- echo=FALSE, results='asis'-----------------------------------------
add_pval(plt_facet, pairs = list(c(1, 2)), annotation = "Awesome")

