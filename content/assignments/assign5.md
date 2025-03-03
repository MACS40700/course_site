---
title: "Assignment 5"
date: 2025-03-05T13:30:00-06:00  # Schedule page publish date
publishDate: 2019-03-01T12:25:00-05:00
draft: false

summary: "Interactive graphics using Shiny or animation"
---

# Assignment 5: Interactive/Animated graphics (with Gapminder)

[Gapminder](http://www.gapminder.org/data/) compiles detailed indicators of global development. For this assignment, you should build an interactive visualization to tell a story about the data. **This assignment requires you to develop both the visualization as well as a written narrative.**

-   You do not need to analyze all 500+ variables. You can focus on a small set of variables (whichever ones you wish, though check the indicator's coverage for all the countries and the time period available)
-   You can build either a highly linear or non-linear structure to your visualization. Note that if you design a non-linear interactive visualization, you still need to situate it using an introduction or text description (a la [America's Public Bible](http://americaspublicbible.org/)[^1]. See FA ch 9 for more details.)
-   Note: [gapminder](https://cran.r-project.org/web/packages/gapminder/index.html) only contains data on three variables. You will need to obtain additional indicators from Gapminder's [data page](http://www.gapminder.org/data/). Unfortunately they don't have a friendly API to access their database - each variable has to be downloaded manually as an Excel spreadsheet and imported into R. The following basic function should allow you to import a downloaded spreadsheet into R,[^2] and tidy:

``` r
library(tidyverse)
library(readxl)

import_gapminder <- function(filename, inc_name = NA){
  # import file
  indicator <- read_excel(filename)
  
  # rename first column to country, store indicator name for later
  inc_fullname <- names(indicator)[[1]]
  names(indicator)[[1]] <- "country"
  
  # tidy data frame and add indicator name as variable
  indicator <- indicator %>%
    gather(year, value, -1, convert = TRUE) %>%
    mutate(value = as.numeric(value),
           variable = ifelse(!is.na(inc_name), inc_name, inc_fullname)) %>%
    select(country, year, variable, value)
}

# use default name
# (import_gapminder("data/indicator hiv estimated prevalence% 15-49 (1).xlsx"))
# 
# # use custom label
# (import_gapminder("data/indicator hiv estimated prevalence% 15-49 (1).xlsx",
#                   inc_name = "hiv_15_49"))
```

## Can I use some different data?

YES! If you have another dataset around which you want to build an interactive visualization, go ahead! Just check in with me before you proceed.

# Requirements for a sucessful app:

-   Need either multiple tabs (content in Shiny part I) or a dashboard (content in Shiny part II) with multiple plots.
-   Ideally at least three plots with some narrative component connecting them to one another.
-   All plots should adhere to the same principles of design we have discussed over the quarter
-   Ideally you have some variety in plot types (e.g. not all bar plots)
-   Prefer you use a Shiny theme to make it a little more polished than the baseline shiny app using [Shiny Themes](https://rstudio.github.io/shinythemes/) (discussed in class) or other theme approaches like [thematic](https://rstudio.github.io/thematic/?_gl=1*10f2rmo*_ga*MTk0NTgzNTU1NS4xNzM1MjM4NzAx*_ga_8QJS108GF1*MTc0MTAxNzM0OS4xMy4wLjE3NDEwMTczNTQuMC4wLjA.*_ga_2C0WZ1JHG0*MTc0MTAxNzM0OS4yMS4wLjE3NDEwMTczNTQuMC4wLjA.) or (advanced) [theming (bslib)](https://rstudio.github.io/bslib/articles/theming/index.html?_gl=1*10f2rmo*_ga*MTk0NTgzNTU1NS4xNzM1MjM4NzAx*_ga_8QJS108GF1*MTc0MTAxNzM0OS4xMy4wLjE3NDEwMTczNTQuMC4wLjA.*_ga_2C0WZ1JHG0*MTc0MTAxNzM0OS4yMS4wLjE3NDEwMTczNTQuMC4wLjA.).

# What do I submit?

Submit the link to your shiny app!

## Grading

Your visualization will be evaluated using the following criteria:

-   Is it truthful?
-   Is it functional?
-   Is it beautiful?
-   Is it insightful?
-   Is it enlightening?

In addition to the visualization and accompanying narrative, write an approximately 500 word explanation defending your design choices. This includes (but is not limited to):

-   What is the story?
-   Why did you select this graphical form?
-   What is the role of interactivity? How does it enhance your ability to tell the story and communicate the data?

## Submission details

Submit your visualization and analysis as a single R Markdown document rendered using the `html_document` output format. If you build a Shiny app, deploy it on [shinyapps.io](http://www.shinyapps.io) and include a link to it in your submission on [github classroom](https://classroom.github.com/a/QiYvVFqi). Include your design explanation in a separate tab in the shiny app.

[^1]: Though with far less detail

[^2]: You could also rewrite it to directly import from Google Sheets using the `googlesheets` package, making it fully reproducible.
