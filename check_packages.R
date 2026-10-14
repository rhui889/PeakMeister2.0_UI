#Checks that every package PeakMeister needs is installed, and installs any that are missing.
#Run from the project folder: Rscript check_packages.R
pkgs <- c("shiny","shinyBS","waiter","shinyFiles","RColorBrewer",
          "shinycssloaders","shinydashboard","DT","shinyalert","ggpubr",
          "plotly","hash","pracma","tidyverse","DescTools","xcms","rlang",
          "markdown","openxlsx","readxl","writexl","fontawesome","MSnbase",
          "mzR","shinyjs","FactoMineR","factoextra","jsonlite","remotes",
          "dbparser","R.utils","RSQLite","DBI","shinyWidgets")

missing <- pkgs[!sapply(pkgs, requireNamespace, quietly = TRUE)]
cat("\nMissing packages:", if (length(missing)) missing else "none", "\n\n")

if (length(missing)) {
  repos <- "https://cloud.r-project.org"
  if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager", repos = repos)
  bioc <- intersect(missing, c("xcms", "MSnbase", "mzR"))
  cran <- setdiff(missing, bioc)
  if (length(cran)) install.packages(cran, repos = repos)
  if (length(bioc)) BiocManager::install(bioc, update = FALSE, ask = FALSE)

  still <- pkgs[!sapply(pkgs, requireNamespace, quietly = TRUE)]
  cat("\nStill missing after install:", if (length(still)) still else "none", "\n")
}
