## Task: Policy network comparison
## Author: LB
## Date: first created: March, 17; last changed: December, 21
## Data: Data collected by Florence Metz, 2013-2014

################################################################################
################################################################################
################################################################################

## clear workspace
rm(list = ls())

## set workspace
setwd("ReplicationMaterials/")

## load libraries
require(devtools)
require(reshape2)
#install_version("network", version = "1.16.1", repos = "http://cran.us.r-project.org", upgrade = 'never')
library(network)
#install_version("sna", version = "2.6", repos = "http://cran.us.r-project.org", upgrade = 'never')
library(sna)
#install_version("ergm", version = "3.11.0", repos = "http://cran.us.r-project.org", upgrade = 'never')
library(ergm)
# install_version("btergm", version = "1.9.13", repos = "http://cran.us.r-project.org", upgrade = 'never', dependencies = FALSE)
library(btergm)
#install_version("ggplot2", version = "3.3.3", repos = "http://cran.us.r-project.org", upgrade = 'never')
library(ggplot2)
#install_version("GGally", version = "2.1.0", repos = "http://cran.us.r-project.org", upgrade = 'never')
library(GGally)
#install_version("tidyverse", version = "1.3.0", repos = "http://cran.us.r-project.org", upgrade = 'never')
library(tidyverse)
#install_version("mice", version = "2.25", repos = "http://cran.us.r-project.org", upgrade = 'never')
library(mice)
#install_version("texreg", version = "1.37.5", repos = "http://cran.us.r-project.org", upgrade = 'never')
library(texreg)
#install_version("readxl", version = "1.3.1", repos = "http://cran.us.r-project.org", upgrade = 'never')
library(readxl)
#install_version("latticeExtra", version = "0.6-29", repos = "http://cran.us.r-project.org", upgrade = 'never')
library(latticeExtra)
#install_version("scales", version = "1.1.1", repos = "http://cran.us.r-project.org", upgrade = 'never')
library(scales)
#install_version("gridExtra", version = "2.3", repos = "http://cran.us.r-project.org", upgrade = 'never')
library(gridExtra)
#install_version("cowplot", version = "1.1.1", repos = "http://cran.us.r-project.org", upgrade = 'never')
library(cowplot)
#install_version("boot", version = "1.3-27", repos = "http://cran.us.r-project.org", upgrade = 'never')
library(boot)
#install_version("combinat", version = "0.0-8", repos = "http://cran.us.r-project.org", upgrade = 'never')
library(combinat)

sessionInfo()
# R version 4.0.3 (2020-10-10)
# Platform: x86_64-apple-darwin17.0 (64-bit)
# Running under: macOS Catalina 10.15.6
# 
# Matrix products: default
# BLAS:   /System/Library/Frameworks/Accelerate.framework/Versions/A/Frameworks/vecLib.framework/Versions/A/libBLAS.dylib
# LAPACK: /Library/Frameworks/R.framework/Versions/4.0/Resources/lib/libRlapack.dylib
# 
# Random number generation:
#   RNG:     Mersenne-Twister 
# Normal:  Inversion 
# Sample:  Rounding 
# 
# locale:
#   [1] en_US.UTF-8/en_US.UTF-8/en_US.UTF-8/C/en_US.UTF-8/en_US.UTF-8
# 
# attached base packages:
#   [1] stats     graphics  grDevices utils     datasets  methods   base     
# 
# other attached packages:
#   [1] combinat_0.0-8       boot_1.3-27          cowplot_1.1.1        gridExtra_2.3        scales_1.1.1         latticeExtra_0.6-29 
# [7] lattice_0.20-41      readxl_1.3.1         texreg_1.37.5        mice_2.25            Rcpp_1.0.6           forcats_0.5.1       
# [13] stringr_1.4.0        dplyr_1.0.4          purrr_0.3.4          readr_1.4.0          tidyr_1.1.2          tibble_3.0.6        
# [19] tidyverse_1.3.0      GGally_2.1.0         btergm_1.9.13        ggplot2_3.3.3        xergm.common_1.7.8   ergm_3.11.0         
# [25] sna_2.6              statnet.common_4.4.1 network_1.16.1       devtools_2.3.2       usethis_2.0.1       
# 
# loaded via a namespace (and not attached):
#   [1] colorspace_2.0-0   ellipsis_0.3.1     rprojroot_2.0.2    fs_1.5.0           rstudioapi_0.13    farver_2.0.3      
# [7] remotes_2.2.0      lubridate_1.7.9.2  xml2_1.3.2         splines_4.0.3      cachem_1.0.4       robustbase_0.93-7 
# [13] pkgload_1.1.0      jsonlite_1.7.2     speedglm_0.3-3     broom_0.7.4        dbplyr_2.1.0       png_0.1-7         
# [19] compiler_4.0.3     httr_1.4.2         backports_1.2.1    assertthat_0.2.1   Matrix_1.3-2       fastmap_1.1.0     
# [25] cli_2.3.0          prettyunits_1.1.1  tools_4.0.3        igraph_1.2.6       coda_0.19-4        gtable_0.3.0      
# [31] glue_1.4.2         reshape2_1.4.4     rle_0.9.2          cellranger_1.1.0   vctrs_0.3.6        nlme_3.1-152      
# [37] RSiena_1.2-23      ps_1.5.0           testthat_3.0.2     trust_0.1-8        rvest_0.3.6        lpSolve_5.6.15    
# [43] lifecycle_1.0.0    DEoptimR_1.0-8     MASS_7.3-53.1      hms_1.0.0          parallel_4.0.3     RColorBrewer_1.1-2
# [49] memoise_2.0.0      rpart_4.1-15       reshape_0.8.8      stringi_1.5.3      desc_1.2.0         pkgbuild_1.2.0    
# [55] rlang_0.4.10       pkgconfig_2.0.3    ROCR_1.0-11        labeling_0.4.2     processx_3.4.5     tidyselect_1.1.0  
# [61] plyr_1.8.6         magrittr_2.0.1     R6_2.5.0           generics_0.1.0     DBI_1.1.1          mgcv_1.8-33       
# [67] pillar_1.4.7       haven_2.3.1        withr_2.4.1        survival_3.2-7     nnet_7.3-15        modelr_0.1.8      
# [73] crayon_1.4.1       jpeg_0.1-8.1       grid_4.0.3         callr_3.5.1        digest_0.6.27      reprex_1.0.0      
# [79] xtable_1.8-4       stats4_4.0.3       munsell_0.5.0      tcltk_4.0.3        sessioninfo_1.1.1 

## set seed to facilitate replication
this.seed <- 123
set.seed(this.seed)
# For exact replications (of ERGM models estimated using MCMC make sure you 
# follow the above specifications exactly and use the above specified R-version.
# The following command: sample(LETTERS, 15) should yield the following vector: 
# ("H" "T" "J" "U" "W" "A" "K" "Q" "X" "Z" "P" "G" "R" "S" "B")).
# To ensure smooth running of our code, we create a logical (simpleReplication) 
# to speed up replication processes:
if(identical(sample(LETTERS, 15), c("H", "T", "J", "U", "W", "A", "K", "Q", "X", "Z", "P", "G", "R", "S", "B")) & 
   packageVersion("network") == '1.16.1' &  packageVersion("sna") == '2.6' & 
   packageVersion("ergm") == '3.11.0' &  packageVersion("btergm") == '1.9.13' &  
   packageVersion("mice") == '2.25' &  packageVersion("boot") == '1.3-27'){simpleReplication <- FALSE}else{simpleReplication <- TRUE}

## bootstrap replications for ci-bars
nboot <- 10000 

## save publication theme for ggplot2-figures
publicationtheme <- theme(plot.title = element_text(face = "bold", size = rel(1.2), hjust = 0.5),
                          text = element_text(),
                          panel.background =  element_blank(), #element_rect(colour = NA),
                          plot.background = element_rect(colour = NA, fill = NA),
                          axis.title = element_text(face = "bold",size = rel(1)),
                          axis.title.y = element_text(angle=90,vjust =2),
                          axis.title.x = element_text(vjust = -0.2),
                          axis.text = element_text(), 
                          axis.line = element_line(colour="black"),
                          axis.ticks = element_line(),
                          panel.grid.major.y = element_line(colour="#f0f0f0"),
                          panel.grid.major.x = element_blank(),
                          panel.grid.minor = element_blank(),
                          legend.key = element_rect(colour = NA),
                          legend.position = "bottom",
                          legend.key.size= unit(1, "cm"),
                          legend.text = element_text(face = "bold",size = rel(1)),
                          legend.background = element_blank(),
                          plot.margin=unit(c(10,5,5,5),"mm"),
                          strip.background=element_rect(colour="#f0f0f0",fill="#f0f0f0"),
                          strip.text = element_text(face="bold") )

################################################################################
## Load prepared data (see Codebook for detailed information on variables)
################################################################################

load('0_Data/data_prepared.RData')

################################################################################
## Impute missing observations
################################################################################

## Swiss policy network
# impute few answers to policy belief questions
imp <- cbind(as.factor(attCH$actor), attCH$source, attCH$endofpipe, attCH$prevent,
             attCH$wait, attCH$eliminate)
imp <- mice(imp, seed = this.seed)
imp <- complete(imp)
attCH$source_imp <- imp[,2]
attCH$endofpipe_imp <- imp[,3]
attCH$prevent_imp <- imp[,4]
attCH$wait_imp <- imp[,5]
attCH$eliminate_imp <- imp[,6]
# impute few answers to instrument selection question
imp <- cbind(as.factor(attCH$actor), attCH$q1, attCH$q3, attCH$q4, attCH$q7, attCH$q8, 
             attCH$q9, attCH$q10, attCH$q13, attCH$q14)
imp <- mice(imp, seed = this.seed)
imp <- complete(imp)
attCH$q1_imp <- imp[,2]
attCH$q3_imp <- imp[,3]
attCH$q4_imp <- imp[,4]
attCH$q7_imp <- imp[,5]
attCH$q8_imp <- imp[,6]
attCH$q9_imp <- imp[,7]
attCH$q10_imp <- imp[,8]
attCH$q13_imp <- imp[,9]
attCH$q14_imp <- imp[,10]

## German policy network: 
# impute few answers to policy belief questions
imp <- cbind(as.factor(attDE$actor), attDE$source, attDE$endofpipe, attDE$prevent,
             attDE$wait, attDE$eliminate)
imp <- mice(imp, seed = this.seed)
imp <- complete(imp)
attDE$source_imp <- imp[,2]
attDE$endofpipe_imp <- imp[,3]
attDE$prevent_imp <- imp[,4]
attDE$wait_imp <- imp[,5]
attDE$eliminate_imp <- imp[,6]
# impute few answers to instrument selection question
imp <- cbind(as.factor(attDE$actor), attDE$q1, attDE$q3, attDE$q4, attDE$q7, attDE$q8, 
             attDE$q9, attDE$q10, attDE$q13, attDE$q14)
imp <- mice(imp, seed = this.seed)
imp <- complete(imp)
attDE$q1_imp <- imp[,2]
attDE$q3_imp <- imp[,3]
attDE$q4_imp <- imp[,4]
attDE$q7_imp <- imp[,5]
attDE$q8_imp <- imp[,6]
attDE$q9_imp <- imp[,7]
attDE$q10_imp <- imp[,8]
attDE$q13_imp <- imp[,9]
attDE$q14_imp <- imp[,10]


## French policy network: 
# impute few answers to policy belief questions
imp <- cbind(as.factor(attFR$actor), attFR$source, attFR$endofpipe, attFR$prevent,
             attFR$wait, attFR$eliminate)
imp <- mice(imp, seed = this.seed)
imp <- complete(imp)
attFR$source_imp <- ifelse(is.na(attFR$source), 4, attFR$source) # all have 4, so give it a 4
attFR$endofpipe_imp <- imp[,3]
attFR$prevent_imp <- imp[,4]
attFR$wait_imp <- imp[,5]
attFR$eliminate_imp <- imp[,6]
# impute few answers to instrument selection question
imp <- cbind(as.factor(attFR$actor), attFR$q1, attFR$q3, attFR$q4, attFR$q7, attFR$q8, 
             attFR$q9, attFR$q10, attFR$q13, attFR$q14)
imp <- mice(imp, seed = this.seed)
imp <- complete(imp)
attFR$q1_imp <- imp[,2]
attFR$q3_imp <- imp[,3]
attFR$q4_imp <- imp[,4]
attFR$q7_imp <- imp[,5]
attFR$q8_imp <- imp[,6]
attFR$q9_imp <- imp[,7]
attFR$q10_imp <- imp[,8]
attFR$q13_imp <- imp[,9]
attFR$q14_imp <- imp[,10]

## Dutch policy network: 
# impute few answers to policy belief questions
imp <- cbind(as.factor(attNL$actor), attNL$source, attNL$endofpipe, attNL$prevent,
             attNL$wait, attNL$eliminate)
imp <- mice(imp, seed = this.seed)
imp <- complete(imp)
attNL$source_imp <- imp[,2]
attNL$endofpipe_imp <- imp[,3]
attNL$prevent_imp <- imp[,4]
attNL$wait_imp <- imp[,5]
attNL$eliminate_imp  <- imp[,6]
attNL$eliminate_imp 
# impute few answers to instrument selection question
imp <- cbind(as.factor(attNL$actor), attNL$q1, attNL$q3, attNL$q4, attNL$q7, attNL$q8, 
             attNL$q9, attNL$q10, attNL$q13, attNL$q14)
imp <- mice(imp, seed = this.seed)
imp <- complete(imp)
attNL$q1_imp <- imp[,2]
attNL$q3_imp <- imp[,3]
attNL$q4_imp <- imp[,4]
attNL$q7_imp <- imp[,5]
attNL$q8_imp <- imp[,6]
attNL$q9_imp <- imp[,7]
attNL$q10_imp <- imp[,8]
attNL$q13_imp <- imp[,9]
attNL$q14_imp <- imp[,10]

## save data
#save(attCH, attDE, attFR, attNL, file = "1_Analysis/output/attributeData.RData")
## Replication: if simpleReplication == TRUE, load attribute data sets
if(simpleReplication){
  load("1_Analysis/output/attributeData.RData")
}

################################################################################
## Create network objects and add attributes
################################################################################

## create network object
nwCH <- network(collabCH, directed = TRUE)
nwDE <- network(collabDE, directed = TRUE)
nwFR <- network(collabFR, directed = TRUE)
nwNL <- network(collabNL, directed = TRUE)
# add actor type
nwCH %v% "actorType" = as.character(attCH$actorTypesChar)
nwDE %v% "actorType" = as.character(attDE$actorTypesChar)
nwFR %v% "actorType" = as.character(attFR$actorTypesChar)
nwNL %v% "actorType" = as.character(attNL$actorTypesChar)
# add reputation
nwCH %v% 'repuTarget' = attCH$reputation
nwDE %v% 'repuTarget' = attDE$reputation
nwFR %v% 'repuTarget' = attFR$reputation
nwNL %v% 'repuTarget' = attNL$reputation

################################################################################
## Create covariate: Belief similarity
################################################################################

## create empty matrix
beliefsimCH_noNA <- matrix(0, nrow = nrow(collabCH), ncol = ncol(collabCH))
rownames(beliefsimCH_noNA) <- rownames(collabCH)
colnames(beliefsimCH_noNA) <- colnames(collabCH)
beliefsimDE_noNA <- matrix(0, nrow = nrow(collabDE), ncol = ncol(collabDE))
rownames(beliefsimDE_noNA) <- rownames(collabDE)
colnames(beliefsimDE_noNA) <- colnames(collabDE)
beliefsimFR_noNA <- matrix(0, nrow = nrow(collabFR), ncol = ncol(collabFR))
rownames(beliefsimFR_noNA) <- rownames(collabFR)
colnames(beliefsimFR_noNA) <- colnames(collabFR)
beliefsimNL_noNA <- matrix(0, nrow = nrow(collabNL), ncol = ncol(collabNL))
rownames(beliefsimNL_noNA) <- rownames(collabNL)
colnames(beliefsimNL_noNA) <- colnames(collabNL)

## fill matrix
for(i in 1:nrow(beliefsimCH_noNA)){
  for(j in 1:ncol(beliefsimCH_noNA)){
    countNA = 0
    difftotal = 0
    for(w in 19:23){ # for each 
      if(is.na(attCH[i,w]) | is.na(attCH[j, w])){
        ## one of the two are missing
        countNA <- countNA + 1
      }else{
        difftemp <- abs(attCH[i,w] - attCH[j,w])
        difftotal <- difftotal + difftemp
      }
    }
    if(countNA == 5){
      beliefsimCH_noNA[i, j] <- NA
    }else{
      beliefsimCH_noNA[i, j] <- difftotal/(5-countNA)
    }
  }
}
for(i in 1:nrow(beliefsimDE_noNA)){
  for(j in 1:ncol(beliefsimDE_noNA)){
    countNA = 0
    difftotal = 0
    for(w in 19:23){ # for each 
      if(is.na(attDE[i,w]) | is.na(attDE[j, w])){
        ## one of the two are missing
        countNA <- countNA + 1
      }else{
        difftemp <- abs(attDE[i,w] - attDE[j,w])
        difftotal <- difftotal + difftemp
      }
    }
    if(countNA == 5){
      beliefsimDE_noNA[i, j] <- NA
    }else{
      beliefsimDE_noNA[i, j] <- difftotal/(5-countNA)
    }
  }
}
for(i in 1:nrow(beliefsimFR_noNA)){
  for(j in 1:ncol(beliefsimFR_noNA)){
    countNA = 0
    difftotal = 0
    for(w in 19:23){ # for each 
      if(is.na(attFR[i,w]) | is.na(attFR[j, w])){
        ## one of the two are missing
        countNA <- countNA + 1
      }else{
        difftemp <- abs(attFR[i,w] - attFR[j,w])
        difftotal <- difftotal + difftemp
      }
    }
    if(countNA == 5){
      beliefsimFR_noNA[i, j] <- NA
    }else{
      beliefsimFR_noNA[i, j] <- difftotal/(5-countNA)
    }
  }
}
for(i in 1:nrow(beliefsimNL_noNA)){
  for(j in 1:ncol(beliefsimNL_noNA)){
    countNA = 0
    difftotal = 0
    for(w in 19:23){ # for each 
      if(is.na(attNL[i,w]) | is.na(attNL[j, w])){
        ## one of the two are missing
        countNA <- countNA + 1
      }else{
        difftemp <- abs(attNL[i,w] - attNL[j,w])
        difftotal <- difftotal + difftemp
      }
    }
    if(countNA == 5){
      beliefsimNL_noNA[i, j] <- NA
    }else{
      beliefsimNL_noNA[i, j] <- difftotal/(5-countNA)
    }
  }
}

################################################################################
## Create covariate: Instrument preference similarity
################################################################################

## create empty matrix
instrumentprefCH_noNA <- matrix(0, nrow = nrow(collabCH), ncol = ncol(collabCH))
rownames(instrumentprefCH_noNA) <- rownames(collabCH)
colnames(instrumentprefCH_noNA) <- colnames(collabCH)
instrumentprefDE_noNA <- matrix(0, nrow = nrow(collabDE), ncol = ncol(collabDE))
rownames(instrumentprefDE_noNA) <- rownames(collabDE)
colnames(instrumentprefDE_noNA) <- colnames(collabDE)
instrumentprefFR_noNA <- matrix(0, nrow = nrow(collabFR), ncol = ncol(collabFR))
rownames(instrumentprefFR_noNA) <- rownames(collabFR)
colnames(instrumentprefFR_noNA) <- colnames(collabFR)
instrumentprefNL_noNA <- matrix(0, nrow = nrow(collabNL), ncol = ncol(collabNL))
rownames(instrumentprefNL_noNA) <- rownames(collabNL)
colnames(instrumentprefNL_noNA) <- colnames(collabNL)

## fill matrix
for(i in 1:nrow(instrumentprefCH_noNA)){
  for(j in 1:ncol(instrumentprefCH_noNA)){
    countNA = 0
    difftotal = 0
    for(w in 24:32){ # for each 
      if(is.na(attCH[i,w]) | is.na(attCH[j, w])){
        ## one of the two are missing
        countNA <- countNA + 1
      }else{
        difftemp <- abs(attCH[i,w] - attCH[j,w])
        difftotal <- difftotal + difftemp
      }
    }
    if(countNA == 9){
      instrumentprefCH_noNA[i, j] <- NA
    }else{
      instrumentprefCH_noNA[i, j] <- difftotal/(9-countNA)
    }
  }
}
for(i in 1:nrow(instrumentprefDE_noNA)){
  for(j in 1:ncol(instrumentprefDE_noNA)){
    countNA = 0
    difftotal = 0
    for(w in 24:32){ # for each 
      if(is.na(attDE[i,w]) | is.na(attDE[j, w])){
        ## one of the two are missing
        countNA <- countNA + 1
      }else{
        difftemp <- abs(attDE[i,w] - attDE[j,w])
        difftotal <- difftotal + difftemp
      }
    }
    if(countNA == 9){
      instrumentprefDE_noNA[i, j] <- NA
    }else{
      instrumentprefDE_noNA[i, j] <- difftotal/(9-countNA)
    }
  }
}
for(i in 1:nrow(instrumentprefFR_noNA)){
  for(j in 1:ncol(instrumentprefFR_noNA)){
    countNA = 0
    difftotal = 0
    for(w in 24:32){ # for each 
      if(is.na(attFR[i,w]) | is.na(attFR[j, w])){
        ## one of the two are missing
        countNA <- countNA + 1
      }else{
        difftemp <- abs(attFR[i,w] - attFR[j,w])
        difftotal <- difftotal + difftemp
      }
    }
    if(countNA == 9){
      instrumentprefFR_noNA[i, j] <- NA
    }else{
      instrumentprefFR_noNA[i, j] <- difftotal/(9-countNA)
    }
  }
}
for(i in 1:nrow(instrumentprefNL_noNA)){
  for(j in 1:ncol(instrumentprefNL_noNA)){
    countNA = 0
    difftotal = 0
    for(w in 24:32){ # for each 
      if(is.na(attNL[i,w]) | is.na(attNL[j, w])){
        ## one of the two are missing
        countNA <- countNA + 1
      }else{
        difftemp <- abs(attNL[i,w] - attNL[j,w])
        difftotal <- difftotal + difftemp
      }
    }
    if(countNA == 9){
      instrumentprefNL_noNA[i, j] <- NA
    }else{
      instrumentprefNL_noNA[i, j] <- difftotal/(9-countNA)
    }
  }
}

################################################################################
## Check correlations
################################################################################

## check correlation between beliefsim X instrumentpref
# CH = 0.4387425
cor((reshape2::melt(beliefsimCH_noNA)$value), 
    (reshape2::melt(instrumentprefCH_noNA)$value))
# DE = 0.4442615
cor((reshape2::melt(beliefsimDE_noNA)$value), 
    (reshape2::melt(instrumentprefDE_noNA)$value))
# FR = 0.3125362
cor((reshape2::melt(beliefsimFR_noNA)$value), 
    (reshape2::melt(instrumentprefFR_noNA)$value))
# NL = 0.31029
cor((reshape2::melt(beliefsimNL_noNA)$value), 
    (reshape2::melt(instrumentprefNL_noNA)$value))

################################################################################
## Graph: Belief differences
################################################################################

## create edge lists for Swiss case
el_beliefsimCH <- reshape2::melt(beliefsimCH_noNA)
el_collabCH <- reshape2::melt(as.matrix(collabCH))
identical(paste(el_beliefsimCH$Var1, el_beliefsimCH$Var2), 
          paste(el_collabCH$Var1, el_collabCH$Var2))
el_beliefsimCH$collab <- el_collabCH$value
ggplot(el_beliefsimCH, aes(x = factor(collab), y = value))+
  geom_boxplot()
el_beliefsim <- subset(el_beliefsimCH, el_beliefsimCH$collab == 1)
el_beliefsim$country <- 'Switzerland'

##
el_beliefsimDE <- reshape2::melt(beliefsimDE_noNA)
el_collabDE <- reshape2::melt(as.matrix(collabDE))
identical(paste(el_beliefsimDE$Var1, el_beliefsimDE$Var2), 
          paste(el_collabDE$Var1, el_collabDE$Var2))
el_beliefsimDE$collab <- el_collabDE$value
ggplot(el_beliefsimDE, aes(x = factor(collab), y = value))+
  geom_boxplot()
el_beliefsimDE <- subset(el_beliefsimDE, el_beliefsimDE$collab == 1)
el_beliefsimDE$country <- 'Germany'
el_beliefsim <- rbind(el_beliefsim, el_beliefsimDE)

##
el_beliefsimFR <- reshape2::melt(beliefsimFR_noNA)
el_collabFR <- reshape2::melt(as.matrix(collabFR))
identical(paste(el_beliefsimFR$Var1, el_beliefsimFR$Var2), 
          paste(el_collabFR$Var1, el_collabFR$Var2))
el_beliefsimFR$collab <- el_collabFR$value
ggplot(el_beliefsimFR, aes(x = factor(collab), y = value))+
  geom_boxplot()
el_beliefsimFR <- subset(el_beliefsimFR, el_beliefsimFR$collab == 1)
el_beliefsimFR$country <- 'France'
el_beliefsim <- rbind(el_beliefsim, el_beliefsimFR)

##
el_beliefsimNL <- reshape2::melt(beliefsimNL_noNA)
el_collabNL <- reshape2::melt(as.matrix(collabNL))
## add in values on collaboration
identical(paste(el_beliefsimNL$Var1, el_beliefsimNL$Var2), 
          paste(el_collabNL$Var1, el_collabNL$Var2))
el_beliefsimNL$collab <- el_collabNL$value
ggplot(el_beliefsimNL, aes(x = factor(collab), y = value))+
  geom_boxplot()
el_beliefsimNL <- subset(el_beliefsimNL, el_beliefsimNL$collab == 1)
el_beliefsimNL$country <- 'Netherlands'
el_beliefsim <- rbind(el_beliefsim, el_beliefsimNL)

## overall plot
pbeliefdif <- ggplot(el_beliefsim, aes(x = factor(country, levels = c('Switzerland', 'Germany', 'France', 'Netherlands')), y = value))+
  geom_boxplot() +
  stat_summary(fun.y=mean, colour="darkred", geom="point", size=2.5, show.legend = FALSE)+
  #stat_summary(fun.y=mean, colour="darkred", geom="text", show.legend = FALSE, 
  #             vjust=2.75, aes( label=round(..y.., digits=2)), size=2.5)+
  ylab("Average differences in policy beliefs") +
  xlab("")+
  publicationtheme+
  theme(axis.text.x = element_text(angle=45,vjust=1,hjust=1))
#ggsave(pbeliefdif, file = '1_Analysis/output/fig_boxplot_beliefdif.pdf', width = 8, height = 12, units = 'cm')

## T-test
# el_beliefsim$CHvsFR <- ifelse(el_beliefsim$country == 'France' | 
#                                 el_beliefsim$country == 'Switzerland', el_beliefsim$country, NA)
# t.test(el_beliefsim$value ~ el_beliefsim$CHvsFR) 
# #
# el_beliefsim$DEvsFR <- ifelse(el_beliefsim$country == 'France' | 
#                                 el_beliefsim$country == 'Germany', el_beliefsim$country, NA)
# t.test(el_beliefsim$value ~ el_beliefsim$DEvsFR)
# #
# el_beliefsim$NLvsFR <- ifelse(el_beliefsim$country == 'France' | 
#                                 el_beliefsim$country == 'Netherlands', el_beliefsim$country, NA)
# t.test(el_beliefsim$value ~ el_beliefsim$NLvsFR)
#
el_beliefsim$allvsFR <- ifelse(el_beliefsim$country == 'France', 1, 0)
t.test(el_beliefsim$value ~ el_beliefsim$allvsFR)
#
# el_beliefsim$CHDEvsNL <- ifelse(el_beliefsim$country == 'France', NA, 
#                                 ifelse(el_beliefsim$country == 'Switzerland' | el_beliefsim$country == 'Germany', 1, 0))
# t.test(el_beliefsim$value ~ el_beliefsim$CHDEvsNL)

################################################################################
## Graph: Differences in instrument preferences
################################################################################

## create edge lists for Swiss case
el_instrumentprefCH <- reshape2::melt(instrumentprefCH_noNA)
el_collabCH <- reshape2::melt(as.matrix(collabCH))
identical(paste(el_instrumentprefCH$Var1, el_instrumentprefCH$Var2), 
          paste(el_collabCH$Var1, el_collabCH$Var2))
el_instrumentprefCH$collab <- el_collabCH$value
ggplot(el_instrumentprefCH, aes(x = factor(collab), y = value))+
  geom_boxplot()
el_instrumentpref <- subset(el_instrumentprefCH, el_instrumentprefCH$collab == 1)
el_instrumentpref$country <- 'Switzerland'

##
el_instrumentprefDE <- reshape2::melt(instrumentprefDE_noNA)
el_collabDE <- reshape2::melt(as.matrix(collabDE))
identical(paste(el_instrumentprefDE$Var1, el_instrumentprefDE$Var2), 
          paste(el_collabDE$Var1, el_collabDE$Var2))
el_instrumentprefDE$collab <- el_collabDE$value
ggplot(el_instrumentprefDE, aes(x = factor(collab), y = value))+
  geom_boxplot()
el_instrumentprefDE <- subset(el_instrumentprefDE, el_instrumentprefDE$collab == 1)
el_instrumentprefDE$country <- 'Germany'
el_instrumentpref <- rbind(el_instrumentpref, el_instrumentprefDE)

##
el_instrumentprefFR <- reshape2::melt(instrumentprefFR_noNA)
el_collabFR <- reshape2::melt(as.matrix(collabFR))
identical(paste(el_instrumentprefFR$Var1, el_instrumentprefFR$Var2), 
          paste(el_collabFR$Var1, el_collabFR$Var2))
el_instrumentprefFR$collab <- el_collabFR$value
ggplot(el_instrumentprefFR, aes(x = factor(collab), y = value))+
  geom_boxplot()
el_instrumentprefFR <- subset(el_instrumentprefFR, el_instrumentprefFR$collab == 1)
el_instrumentprefFR$country <- 'France'
el_instrumentpref <- rbind(el_instrumentpref, el_instrumentprefFR)

##
el_instrumentprefNL <- reshape2::melt(instrumentprefNL_noNA)
el_collabNL <- reshape2::melt(as.matrix(collabNL))
## add in values on collaboration
identical(paste(el_instrumentprefNL$Var1, el_instrumentprefNL$Var2), 
          paste(el_collabNL$Var1, el_collabNL$Var2))
el_instrumentprefNL$collab <- el_collabNL$value
ggplot(el_instrumentprefNL, aes(x = factor(collab), y = value))+
  geom_boxplot()
el_instrumentprefNL <- subset(el_instrumentprefNL, el_instrumentprefNL$collab == 1)
el_instrumentprefNL$country <- 'Netherlands'
el_instrumentpref <- rbind(el_instrumentpref, el_instrumentprefNL)

## overall plot
pinstrdif <- ggplot(el_instrumentpref, aes(x = factor(country, levels = c('Switzerland', 'Germany', 'France', 'Netherlands')), y = value))+
  geom_boxplot() +
  stat_summary(fun.y=mean, colour="darkred", geom="point", size=2.5, show.legend = FALSE)+
  #stat_summary(fun.y=mean, colour="darkred", geom="text", show.legend = FALSE, 
  #             vjust=2.75, aes( label=round(..y.., digits=2)), size=2.5)+
  ylab("Average differences in instrument preferences") +
  xlab("")+
  publicationtheme+
  theme(axis.text.x = element_text(angle=45,vjust=1,hjust=1))
#ggsave(pinstrdif, file = '1_Analysis/output/fig_boxplot_instrumentdif.pdf', width = 8, height = 12, units = 'cm')

## t-tests
el_instrumentpref$allvsCH <- ifelse(el_instrumentpref$country == 'Switzerland', 1, 0)
t.test(el_instrumentpref$value ~ el_instrumentpref$allvsCH)

################################################################################
## Interaction effect: opponents X beliefdissimilarity - descriptives and build matrixes
################################################################################

## run t-tests 
# CH
el_oppCH <- reshape2::melt(oppCH)
el_beliefsimCH <- reshape2::melt(beliefsimCH_noNA)
el_instrumentprefCH <- reshape2::melt(instrumentprefCH_noNA)
identical(paste(el_beliefsimCH$Var1, el_beliefsimCH$Var2), 
          paste(el_oppCH$Var1, el_oppCH$Var2))
t.test(el_beliefsimCH$value ~ el_oppCH$value)
t.test(el_instrumentprefCH$value ~ el_oppCH$value)
# DE
el_oppDE <- reshape2::melt(oppDE)
el_beliefsimDE <- reshape2::melt(beliefsimDE_noNA)
el_instrumentprefDE <- reshape2::melt(instrumentprefDE_noNA)
identical(paste(el_beliefsimDE$Var1, el_beliefsimDE$Var2), 
          paste(el_oppDE$Var1, el_oppDE$Var2))
t.test(el_beliefsimDE$value ~ el_oppDE$value)
t.test(el_instrumentprefDE$value ~ el_oppDE$value)
# FR
el_oppFR <- reshape2::melt(oppFR)
el_beliefsimFR <- reshape2::melt(beliefsimFR_noNA)
el_instrumentprefFR <- reshape2::melt(instrumentprefFR_noNA)
identical(paste(el_beliefsimFR$Var1, el_beliefsimFR$Var2), 
          paste(el_oppFR$Var1, el_oppFR$Var2))
t.test(el_beliefsimFR$value ~ el_oppFR$value)
t.test(el_instrumentprefFR$value ~ el_oppFR$value)
# NL
el_oppNL <- reshape2::melt(oppNL)
el_beliefsimNL <- reshape2::melt(beliefsimNL_noNA)
el_instrumentprefNL <- reshape2::melt(instrumentprefNL_noNA)
identical(paste(el_beliefsimNL$Var1, el_beliefsimNL$Var2), 
          paste(el_oppNL$Var1, el_oppNL$Var2))
t.test(el_beliefsimNL$value ~ el_oppNL$value)
t.test(el_instrumentprefNL$value ~ el_oppNL$value)

## prepare interaction matrices
# CH
oppCH_12 <- ifelse(oppCH == 0, 1, 2)
beliefsim_opp_CH <- beliefsimCH_noNA * oppCH_12
instrumentpref_opp_CH <- instrumentprefCH_noNA * oppCH_12
# DE
oppDE_12 <- ifelse(oppDE == 0, 1, 2)
beliefsim_opp_DE <- beliefsimDE_noNA * oppDE_12
# FR
oppFR_12 <- ifelse(oppFR == 0, 1, 2)
beliefsim_opp_FR <- beliefsimFR_noNA * oppFR_12
# NL
oppNL_12 <- ifelse(oppNL == 0, 1, 2)
beliefsim_opp_NL <- beliefsimNL_noNA * oppNL_12


################################################################################
## ERGMs without interaction effect - as reported in the SI Online
################################################################################

##
tryCatch(expr = {
  fit1CH <- ergm(nwCH ~ edges 
                 + edgecov(oppCH) 
                 + gwesp(.25, fixed = TRUE)  
                 + gwidegree(1.4, fixed = TRUE) 
                 + edgecov(beliefsimCH_noNA)
                 + edgecov(instrumentprefCH_noNA)
                 ## Controls
                 + mutual
                 + nodeofactor('actorType', base = -3)
                 + nodeifactor('actorType', base = -3)
                 + nodeocov('repuTarget')
                 + absdiff('repuTarget')
                 ,control = control.ergm(seed = this.seed))
  # save(fit1CH, file = '1_Analysis/output/ERGM_estimates/fit1CH.RData')
}, error = function(e){print(paste0("Estimation error: ", e, " -- Load model"))})
if(!("fit1CH" %in% ls()) | simpleReplication){load('1_Analysis/output/ERGM_estimates/fit1CH.RData')}
# In case you run into an estimation error, you can load the saved model to 
# continue with the replication (see README for details on why you may be getting
# estimation errors and what seeds are used for). If you are not interested in 
# exact replication (i.e., to the decimal point), remove the seed option or
# try a different seed. 

## DE
tryCatch(expr = {
  fit1DE <- ergm(nwDE ~ edges 
                 + edgecov(oppDE) 
                 + gwesp(.25, fixed = TRUE) 
                 + gwidegree(1.4, fixed = TRUE) 
                 + edgecov(beliefsimDE_noNA)
                 + edgecov(instrumentprefDE_noNA)
                 ## Controls
                 + mutual
                 + nodeofactor('actorType', base = -3)
                 + nodeifactor('actorType', base = -3)
                 + nodeocov('repuTarget')
                 + absdiff('repuTarget')
                 ,control = control.ergm(seed = this.seed))
  # save(fit1DE, file = '1_Analysis/output/ERGM_estimates/fit1DE.RData')
}, error = function(e){print(paste0("Estimation error: ", e, " -- Load model"))})
if(!("fit1DE" %in% ls()) | simpleReplication){load('1_Analysis/output/ERGM_estimates/fit1DE.RData')}

## FR
tryCatch(expr = {
  fit1FR <- ergm(nwFR ~ edges 
                 + edgecov(oppFR) 
                 + gwesp(.25, fixed = TRUE)  
                 + gwidegree(1.4, fixed = TRUE)
                 + edgecov(beliefsimFR_noNA)
                 + edgecov(instrumentprefFR_noNA)
                 ## Control
                 + mutual
                 + nodeofactor('actorType', base = -2)
                 + nodeifactor('actorType', base = -2)
                 + nodeocov('repuTarget')
                 + absdiff('repuTarget')
                 ,control = control.ergm(seed = this.seed))
  #save(fit1FR, file = '1_Analysis/output/ERGM_estimates/fit1FR.RData')
}, error = function(e){print(paste0("Estimation error: ", e, " -- Load model"))})
if(!("fit1FR" %in% ls()) | simpleReplication){load('1_Analysis/output/ERGM_estimates/fit1FR.RData')}

##
tryCatch(expr = {
  fit1NL <- ergm(nwNL ~ edges 
                 + edgecov(oppNL) 
                 + gwesp(.25, fixed = TRUE) 
                 + gwidegree(1.4, fixed = TRUE) 
                 + edgecov(beliefsimNL_noNA)
                 + edgecov(instrumentprefNL_noNA)
                 ## Controls
                 + mutual
                 + nodeofactor('actorType', base = -3)
                 + nodeifactor('actorType', base = -3)
                 + nodeocov('repuTarget')
                 + absdiff('repuTarget')
                 ,control = control.ergm(seed = this.seed))
  # save(fit1NL, file = '1_Analysis/output/ERGM_estimates/fit1NL.RData')
}, error = function(e){print(paste0("Estimation error: ", e, " -- Load model"))})
if(!("fit1NL" %in% ls()) | simpleReplication){load('1_Analysis/output/ERGM_estimates/fit1NL.RData')}

## save models
coefnames <- c('Edges', 
               'Collaboration with opponents (H2)',
               'Clustering (gwesp, H2)',
               'Power concentration (gwidegree, H1)', 
               'Collaboration across belief dissimilarity (H2)',
               'Instrument preference dissimilarity',
               'Reciprocity',
               'Outdegree: Governmental actors', 
               'Indegree: Governmental actors', 
               'Outdegree: high reputation',
               'Difference in reputation',
               'Collaboration with opponents (H2)',
               'Collaboration across belief dissimilarity (H2)',
               'Instrument preference dissimilarity',
               'Collaboration with opponents (H2)',
               'Collaboration across belief dissimilarity (H2)',
               'Instrument preference dissimilarity',
               'Collaboration with opponents (H2)',
               'Collaboration across belief dissimilarity (H2)',
               'Instrument preference dissimilarity')

## tex-file
texreg(list(fit1CH, fit1DE, fit1FR, fit1NL), 
       stars = c(0.05, 0.01, 0.001),
       booktabs = TRUE, dcolumn = TRUE, 
       use.packages = FALSE, fontsize = 'scriptsize',
       caption.above = TRUE,
       label = 'tab_ergm',
       caption = 'Results on network structure using exponential random graph models for each of the four policy networks',
       custom.model.names = c('CH', 'DE', 'FR', 'NL'), 
       custom.coef.names = coefnames,
       file = '1_Analysis/output/SITAB4_ergms.tex', 
       reorder.coef = c(4,2:3,5, 7, 6, 8:11,1),
       #      custom.note = "$^{∗∗∗}$ $p < 0.001$, $^{∗∗}$ $p < 0.01$,$^∗$ $p < 0.05$,$^·$ $p < 0.1$; Coefficients are reported as log odds."
       groups = list('Hypotheses' = 1:4, 'Controls' = 5:11))
##output: Table 4 in the SI Online

################################################################################
## ERGMs with interaction effect -- as reported in the article
################################################################################

## run models
## CH
tryCatch(expr = {
  fit2CH <- ergm(nwCH ~ edges 
                 + gwidegree(1.4, fixed = TRUE) 
                 + gwesp(.25, fixed = TRUE)   
                 + edgecov(oppCH_12) 
                 + edgecov(beliefsimCH_noNA)
                 + edgecov(beliefsim_opp_CH)
                 ## Controls
                 + mutual
                 + edgecov(instrumentprefCH_noNA)
                 + nodeofactor('actorType', base = -3)
                 + nodeifactor('actorType', base = -3)
                 + nodeocov('repuTarget')
                 + absdiff('repuTarget')
                 ,control = control.ergm(seed = this.seed))
  #save(fit2CH, file = '1_Analysis/output/ERGM_estimates/fit2CH.RData')
}, error = function(e){print(paste0("Estimation error: ", e, " -- Load model"))})
if(!("fit2CH" %in% ls()) | simpleReplication){load('1_Analysis/output/ERGM_estimates/fit2CH.RData')}
# mcmc.diagnostics(fit2CH)
goffit2CH <- btergm::gof(fit2CH, statistics = c(deg, dsp, istar, geodesic, triad.directed, rocpr), nsim = 500)

## DE
tryCatch(expr = {
  fit2DE <- ergm(nwDE ~ edges 
                 + gwidegree(1.4, fixed = TRUE) 
                 + gwesp(.25, fixed = TRUE) 
                 + edgecov(oppDE_12) 
                 + edgecov(beliefsimDE_noNA)
                 + edgecov(beliefsim_opp_DE)
                 ## Controls
                 + mutual
                 + edgecov(instrumentprefDE_noNA)
                 + nodeofactor('actorType', base = -3)
                 + nodeifactor('actorType', base = -3)
                 + nodeocov('repuTarget')
                 + absdiff('repuTarget')
                 ,control = control.ergm(seed = this.seed))
  # save(fit2DE, file = '1_Analysis/output/ERGM_estimates/fit2DE.RData')
}, error = function(e){print(paste0("Estimation error: ", e, " -- Load model"))})
if(!("fit2DE" %in% ls()) | simpleReplication){load('1_Analysis/output/ERGM_estimates/fit2DE.RData')}
# summary(fit2DE) 
# mcmc.diagnostics(fit2DE)
goffit2DE <- btergm::gof(fit2DE, statistics = c(deg, dsp, istar, geodesic, triad.directed, rocpr), nsim = 500)

## FR
tryCatch(expr = {
  fit2FR <- ergm(nwFR ~ edges 
                 + gwidegree(1.4, fixed = TRUE)
                 + gwesp(.25, fixed = TRUE)  
                 + edgecov(oppFR_12) 
                 + edgecov(beliefsimFR_noNA)
                 #+ edgecov(beliefsim_opp_FR)
                 ## Control
                 + mutual
                 + edgecov(instrumentprefFR_noNA)
                 + nodeofactor('actorType', base = -2)
                 + nodeifactor('actorType', base = -2)
                 + nodeocov('repuTarget')
                 + absdiff('repuTarget')
                 ,control = control.ergm(seed = 1234))
  # save(fit2FR, file = '1_Analysis/output/ERGM_estimates/fit2FR.RData')
}, error = function(e){print(paste0("Estimation error: ", e, " -- Load model"))})
if(!("fit2FR" %in% ls()) | simpleReplication){load('1_Analysis/output/ERGM_estimates/fit2FR.RData')}
# summary(fit2FR) 
# mcmc.diagnostics(fit2FR)
goffit2FR <- btergm::gof(fit2FR, statistics = c(deg, dsp, istar, geodesic, triad.directed, rocpr), nsim = 500)

##
tryCatch(expr = {
  fit2NL <- ergm(nwNL ~ edges 
                 + gwidegree(1.4, fixed = TRUE) 
                 + gwesp(.25, fixed = TRUE) 
                 + edgecov(oppNL_12) 
                 + edgecov(beliefsimNL_noNA)
                 + edgecov(beliefsim_opp_NL)
                 ## Controls
                 + mutual
                 + edgecov(instrumentprefNL_noNA)
                 + nodeofactor('actorType', base = -3)
                 + nodeifactor('actorType', base = -3)
                 + nodeocov('repuTarget')
                 + absdiff('repuTarget')
                 ,control = control.ergm(seed = 1234))
  # save(fit2NL, file = '1_Analysis/output/ERGM_estimates/fit2NL.RData')
}, error = function(e){print(paste0("Estimation error: ", e, " -- Load model"))})
if(!("fit2NL" %in% ls()) | simpleReplication){load('1_Analysis/output/ERGM_estimates/fit2NL.RData')}
# summary(fit2NL) 
# mcmc.diagnostics(fit2NL)
goffit2NL <- btergm::gof(fit2NL, statistics = c(deg, dsp, istar, geodesic, triad.directed, rocpr), nsim = 500)

## Combine GOF-Figures
pdf(file = '1_Analysis/output/FIG2_fit_ergmint.pdf', width = 26, height = 18)
par(mfrow = c(4, 6), mar = c(7,6,10,2)) #mar = c(lower, left,top,right), default = c(5, 4, 4, 2)
plot(goffit2CH, mfrow = FALSE, cex.lab=2.5, cex.axis=2, cex.main=2.6, cex.sub=2) #, roc.col = 'black', pr.col = 'grey')
plot(goffit2DE, mfrow = FALSE, cex.lab=2.5, cex.axis=2, cex.main=2.6, cex.sub=2) #, roc.col = 'black', pr.col = 'grey')
plot(goffit2FR, mfrow = FALSE, cex.lab=2.5, cex.axis=2, cex.main=2.6, cex.sub=2) #, roc.col = 'black', pr.col = 'grey') 
plot(goffit2NL, mfrow = FALSE, cex.lab=2.5, cex.axis=2, cex.main=2.6, cex.sub=2) #, roc.col = 'black', pr.col = 'grey') 
mtext("Switzerland", side = 3, line = -3, outer = TRUE, cex = 3)
mtext("Germany", side = 3, line = -37, outer = TRUE, cex = 3)
mtext("France", side = 3, line = -72, outer = TRUE, cex = 3)
mtext("Netherlands", side = 3, line = -106, outer = TRUE, cex = 3)
dev.off()
## output: Figure 2 in the article

## save models
coefnames <- c('Edges', 
               'Power concentration (gwidegree, H1)', 
               'Clustering (gwesp, H2)', 
               'Collaboration with opponents (H2)',
               'Collaboration across belief dissimilarity (H2)', 
               'Interaction: Collab with opp. X belief dissim.',
               #Controls
               'Reciprocity',
               'Instrument preference dissimilarity',
               'Outdegree: Governmental actors', 
               'Indegree: Governmental actors', 
               'Outdegree: high reputation',
               'Difference in reputation',
               # DE
               'Collaboration with opponents (H2)',
               'Collaboration across belief dissimilarity (H2)', 
               'Interaction: Collab with opp. X belief dissim.',
               'Instrument preference dissimilarity',
               # FR
               'Collaboration with opponents (H2)',
               'Collaboration across belief dissimilarity (H2)', 
               'Instrument preference dissimilarity',
               # NL
               'Collaboration with opponents (H2)',
               'Collaboration across belief dissimilarity (H2)', 
               'Interaction: Collab with opp. X belief dissim.',
               'Instrument preference dissimilarity')

## tex-file
texreg(list(fit2CH, fit2DE, fit2FR, fit2NL), 
       stars = c(0.05, 0.01, 0.001),
       booktabs = TRUE, dcolumn = TRUE, 
       use.packages = FALSE, fontsize = 'scriptsize',
       caption.above = TRUE,
       label = 'tab_ergm',
       caption = 'Results on network structure using exponential random graph models for each of the four policy networks',
       custom.model.names = c('CH', 'DE', 'FR', 'NL'), 
       custom.coef.names = coefnames,
       reorder.coef = c(2:12, 1),
       groups = list('Hypotheses' = 1:5, 'Controls' = 6:12),
       file = '1_Analysis/output/SITAB3_ergms_interaction.tex') 
#       custom.note = "$^{∗∗∗}$ $p < 0.001$, $^{∗∗}$ $p < 0.01$,$^∗$ $p < 0.05$,$^·$ $p < 0.1$; Coefficients are reported as log odds."
##output: Table 3 in the SI Online

## create coefplot here
temp <- summary(fit2CH)
temp2 <- summary(fit2DE)
temp3 <- summary(fit2FR)
temp4 <- summary(fit2NL)
# create data frame for plot (by hand, not that elegant but effective)
dtfit <- data.frame(coefname = c(names(fit2CH$coef), names(fit2DE$coef), names(fit2FR$coef),  names(fit2NL$coef)), 
                    model = c(rep("CH (consensual-federal)", 12),
                              rep("DE (consensual-federal)", 12), 
                              rep("FR (majoritarian-unitary)", 11),
                              rep("NL (federal-unitary)", 12)), 
                    coef = c(as.numeric(temp$coefs[,1]), 
                             as.numeric(temp2$coefs[,1]), 
                             as.numeric(temp3$coefs[,1]),
                             as.numeric(temp4$coefs[,1])),
                    se = c(as.numeric(temp$coefs[,2]), 
                           as.numeric(temp2$coefs[,2]),
                           as.numeric(temp3$coefs[,2]),
                           as.numeric(temp4$coefs[,2])), 
                    conf.lower = c(as.numeric(confint(fit2CH)[,1]),
                                   as.numeric(confint(fit2DE)[,1]),
                                   as.numeric(confint(fit2FR)[,1]),
                                   as.numeric(confint(fit2NL)[,1])), 
                    conf.higher = c(as.numeric(confint(fit2CH)[,2]),
                                    as.numeric(confint(fit2DE)[,2]),
                                    as.numeric(confint(fit2FR)[,2]),
                                    as.numeric(confint(fit2NL)[,2])) )
dtfit$coefname_formatted <- NA
dtfit$coefname_formatted[dtfit$coefname == 'edges'] <- 'Edges'
dtfit$coefname_formatted[dtfit$coefname == 'gwideg.fixed.1.4'] <- 'Power concentration (gwidegree, H1)'
dtfit$coefname_formatted[dtfit$coefname == 'gwesp.fixed.0.25'] <- 'Clustering (gwesp, H2)'
dtfit$coefname_formatted[dtfit$coefname == 'edgecov.oppCH_12' |
                           dtfit$coefname == 'edgecov.oppDE_12' |
                           dtfit$coefname == 'edgecov.oppFR_12' |
                           dtfit$coefname == 'edgecov.oppNL_12' ] <- 'Collaboration with opponents (H2)'
dtfit$coefname_formatted[dtfit$coefname == 'edgecov.beliefsimCH_noNA' | 
                           dtfit$coefname == 'edgecov.beliefsimDE_noNA' | 
                           dtfit$coefname == 'edgecov.beliefsimFR_noNA' | 
                           dtfit$coefname == 'edgecov.beliefsimNL_noNA' ] <- 'Collaboration across belief dissimilarity (H2)'
dtfit$coefname_formatted[dtfit$coefname == 'edgecov.beliefsim_opp_CH' | 
                           dtfit$coefname == 'edgecov.beliefsim_opp_DE' | 
                           dtfit$coefname == 'edgecov.beliefsim_opp_FR' | 
                           dtfit$coefname == 'edgecov.beliefsim_opp_NL'] <- 'Interaction: Collab with opp. X belief dissim.'
dtfit$coefname_formatted[dtfit$coefname == 'mutual'] <- 'Reciprocity'
dtfit$coefname_formatted[dtfit$coefname == 'edgecov.instrumentprefCH_noNA' | 
                           dtfit$coefname == 'edgecov.instrumentprefDE_noNA' | 
                           dtfit$coefname == 'edgecov.instrumentprefFR_noNA' | 
                           dtfit$coefname == 'edgecov.instrumentprefNL_noNA'] <- 'Instrument preference dissimilarity'
dtfit$coefname_formatted[dtfit$coefname == 'nodeofactor.actorType.national'] <- 'Outdegree: Governmental actors'
dtfit$coefname_formatted[dtfit$coefname == 'nodeifactor.actorType.national'] <- 'Indegree: Governmental actors'
dtfit$coefname_formatted[dtfit$coefname == 'nodeocov.repuTarget'] <- 'Outdegree: high reputation'
dtfit$coefname_formatted[dtfit$coefname == 'absdiff.repuTarget'] <- 'Difference in reputation'
dtfit$coefname_formatted <- factor(dtfit$coefname_formatted, levels = rev(c('Edges', 
                                                                            'Power concentration (gwidegree, H1)', 
                                                                            'Clustering (gwesp, H2)', 
                                                                            'Collaboration with opponents (H2)',
                                                                            'Collaboration across belief dissimilarity (H2)', 
                                                                            'Interaction: Collab with opp. X belief dissim.',
                                                                            #Controls
                                                                            'Reciprocity',
                                                                            'Instrument preference dissimilarity',
                                                                            'Outdegree: Governmental actors', 
                                                                            'Indegree: Governmental actors', 
                                                                            'Outdegree: high reputation',
                                                                            'Difference in reputation')))
dtfit$country <- NA
dtfit$country[dtfit$model == 'CH (consensual-federal)'] <- 'CH'
dtfit$country[dtfit$model == 'DE (consensual-federal)'] <- 'DE'
dtfit$country[dtfit$model == 'FR (majoritarian-unitary)'] <- 'FR'
dtfit$country[dtfit$model == 'NL (federal-unitary)'] <- 'NL'

#
ggplot(subset(dtfit, dtfit$coefname != 'edges'), aes(x = coefname_formatted, y = coef, color = model))+
  geom_hline(aes(yintercept = 0), color = 'grey80') +
  coord_flip() +
  geom_point(aes(x = coefname_formatted, y = coef, color = model, group = model, 
                 shape = model), position=position_dodge(width=0.6)) +
  geom_errorbar(aes(ymin = conf.lower, ymax = conf.higher, color = model), position=position_dodge(width=0.6)) + 
  publicationtheme + 
  xlab("") + ylab("Log odds (confidence intervals)") +
  scale_color_manual("", values = c('CH (consensual-federal)' = "#D7191C", #'firebrick1',
                                    'DE (consensual-federal)' = '#FDAE61', #'gold',
                                    'FR (majoritarian-unitary)' = '#2B83BA', #'dodgerblue2',
                                    'NL (federal-unitary)' = 'springgreen3')) +
  scale_shape_manual("", labels = c('CH (consensual-federal)',
                                    'DE (consensual-federal)',
                                    'FR (majoritarian-unitary)',
                                    'NL (federal-unitary)'), 
                     values = c(15, 16, 17, 18))+
  guides(color=guide_legend(nrow=2, byrow = TRUE)) +
  geom_text(aes(label = country, y = conf.higher, group = model),  colour = 'grey50',
            position=position_dodge(.7),  hjust=-.5, size = 2) +
  ggsave(file = '1_Analysis/output/FIG3_ERGM_interaction.pdf', 
         width = 24, height = 16, units = 'cm')
##output: Figure 3 in the Article

################################################################################
## Get predicted probabilities for all four models
################################################################################

## Calculate predicted probabilities for each dyad
dyadsCH <- suppressWarnings(edgeprob(fit2CH)) 
dyadsDE <- suppressWarnings(edgeprob(fit2DE))
dyadsFR <- suppressWarnings(edgeprob(fit2FR))
dyadsNL <- suppressWarnings(edgeprob(fit2NL))

## change col-names + add additional columns so they can be merged easily
names(dyadsCH) <- c('tie', 'edges', 'gwideg', 'gwesp', 'opp', 
                    'beliefsim', 'interaction', 'mutual', 'instrumentpref', 
                    'national_outdeg', 'national_indeg', 'repu_outdeg', 'repu_absdiff',
                    'i', 'j', 't', 'i.name', 'j.name', 'probability')
names(dyadsDE) <- c('tie', 'edges', 'gwideg', 'gwesp', 'opp', 
                    'beliefsim', 'interaction', 'mutual', 'instrumentpref', 
                    'national_outdeg', 'national_indeg', 'repu_outdeg', 'repu_absdiff',
                    'i', 'j', 't', 'i.name', 'j.name', 'probability')
names(dyadsFR) <- c('tie', 'edges', 'gwideg', 'gwesp', 'opp', 
                    'beliefsim', 'mutual', 'instrumentpref', 
                    'national_outdeg', 'national_indeg', 'repu_outdeg', 'repu_absdiff',
                    'i', 'j', 't', 'i.name', 'j.name', 'probability')
dyadsFR$interaction <- NA
names(dyadsNL) <- c('tie', 'edges', 'gwideg', 'gwesp', 'opp', 
                    'beliefsim', 'interaction', 'mutual', 'instrumentpref', 
                    'national_outdeg', 'national_indeg', 'repu_outdeg', 'repu_absdiff',
                    'i', 'j', 't', 'i.name', 'j.name', 'probability')

## add countries variable
dyadsCH$country <- 'CH'
dyadsDE$country <- 'DE'
dyadsFR$country <- 'FR'
dyadsNL$country <- 'NL'

## combine predicted probability data frames
dyads <- rbind(dyadsCH, dyadsDE, dyadsFR, dyadsNL)
#save(dyads, file = "1_Analysis/output/edgeprobabilities.RData")
if(simpleReplication){
  load("1_Analysis/output/edgeprobabilities.RData")
}

################################################################################
## Popularity
## This graph was produced with code adapted from the replication files for
## Desmarais, Cranmer, 2012: Micro-Level Interpretation of Exponential Random 
## Graph Models with Application to Estuary Networks, PSJ, Vol 40, No 3.
################################################################################

## load pNode function
source("1_Analysis/InterpretationFunctions_Desmarais_Cranmer_2012.R")

# Also, the “Popularity Effect” is computed by (i) randomly selecting a target node,
# (ii) randomly fixing a number of ingoing ties corresponding to the x-axis in 
# the “Popularity Effect” plot, and (iii) using pNode to compute the average
# probability that the nonfixed ingoing ties to that node exist.
probmatCH <- matrix(0,500,10)
probmatDE <- matrix(0,500,10)
probmatFR <- matrix(0,500,10)
probmatNL <- matrix(0,500,10)
additionaledges <- c(0,1,2,3,4,5,6,7,8,9)
pb <- txtProgressBar(0, 500, style = 3) 
for(i in 1:500){
  setTxtProgressBar(pb, i)
  # pick a node
  set.seed(100+i)
  nodeiCH <- sample(1:nrow(collabCH), 1)
  set.seed(101+i)
  nodeiDE <- sample(1:nrow(collabDE), 1)
  set.seed(102+i)
  nodeiFR <- sample(1:nrow(collabFR), 1)
  set.seed(103+i)
  nodeiNL <- sample(1:nrow(collabNL), 1)
  # pick 5 other nodes (nr 5 chosen by LB after Desmarais, Cranmer, 2012)
  set.seed(104+i)
  nodeothersCH <- sample((1:nrow(collabCH))[-nodeiCH], 5)
  set.seed(105+i)
  nodeothersDE <- sample((1:nrow(collabDE))[-nodeiDE], 5)
  set.seed(106+i)
  nodeothersFR <- sample((1:nrow(collabFR))[-nodeiFR], 5)
  set.seed(107+i)
  nodeothersNL <- sample((1:nrow(collabNL))[-nodeiNL], 5)
  # for every k from 0:6
  for(k in additionaledges){
    netwCH <- nwCH
    netwDE <- nwDE
    netwFR <- nwFR
    netwNL <- nwNL
    if(k > 0){ 
      ## get the network, change nr of edges
      set.seed(108+i+k)
      nodeschangedtooneCH <- sample((1:nrow(collabCH))[-c(nodeiCH, nodeothersCH)], k)
      set.seed(109+i+k)
      nodeschangedtooneDE <- sample((1:nrow(collabDE))[-c(nodeiDE, nodeothersDE)], k)
      set.seed(110+i+k)
      nodeschangedtooneFR <- sample((1:nrow(collabFR))[-c(nodeiFR, nodeothersFR)], k)
      set.seed(111+i+k)
      nodeschangedtooneNL <- sample((1:nrow(collabNL))[-c(nodeiNL, nodeothersNL)], k)
      netwCH[nodeschangedtooneCH, nodeiCH] <- 1
      netwDE[nodeschangedtooneDE, nodeiDE] <- 1
      netwFR[nodeschangedtooneFR, nodeiFR] <- 1
      netwNL[nodeschangedtooneNL, nodeiNL] <- 1
      #netwCH[nodeiCH, nodeschangedtooneCH] <- 1 # for undirected networks
      #netwFR[nodeiFR, nodeschangedtooneFR] <- 1
      #netwDE[nodeiDE, nodeschangedtooneDE] <- 1
      #netwNL[nodeiNL, nodeschangedtooneNL] <- 1
    }
    ## get probability for the 5 chosen nodes
    # dyadsprCH <- interpret(fit1CH,
    #                        coefficients = coef(fit1CH),
    #                        target = netwCH,
    #                        type = 'node', i = nodeothersCH, j = nodeiCH)
    dyadsprCH <- pNode('net ~ edges + edgecov(oppCH) + gwesp(0.25, fixed = TRUE) + gwidegree(1.4, fixed = TRUE) + edgecov(beliefsimCH_noNA) + edgecov(instrumentprefCH_noNA) + mutual + nodeofactor("actorType", base = -3) + nodeifactor("actorType", base = -3) + nodeocov("repuTarget") + absdiff("repuTarget")',
                       theta=coef(fit1CH),node=nodeiCH,others=nodeothersCH,nodeSend=F,net=netwCH)
    # dyadsprDE <- interpret(fit1DE,
    #                        coefficients = coef(fit1DE),
    #                        target = netwDE,
    #                        type = 'node', i = nodeothersDE, j = nodeiDE)
    dyadsprDE <- pNode('net ~ edges + edgecov(oppDE) + gwesp(0.25, fixed = TRUE) + gwidegree(1.4, fixed = TRUE) + edgecov(beliefsimDE_noNA) + edgecov(instrumentprefDE_noNA) + mutual + nodeofactor("actorType", base = -3) + nodeifactor("actorType", base = -3) + nodeocov("repuTarget") + absdiff("repuTarget")',
                       theta=coef(fit1DE),node=nodeiDE,others=nodeothersDE,nodeSend=F,net=netwDE)
    # dyadsprFR <- interpret(fit1FR,
    #                        coefficients = coef(fit1FR),
    #                        target = netwFR,
    #                        type = 'node', i = nodeothersFR, j = nodeiFR)
    dyadsprFR <- pNode('net ~ edges + edgecov(oppFR) + gwesp(0.25, fixed = TRUE) + gwidegree(1.4, fixed = TRUE) + edgecov(beliefsimFR_noNA) + edgecov(instrumentprefFR_noNA) + mutual + nodeofactor("actorType", base = -2) + nodeifactor("actorType", base = -2) + nodeocov("repuTarget") + absdiff("repuTarget")',
                       theta=coef(fit1FR),node=nodeiFR,others=nodeothersFR,nodeSend=F,net=netwFR)
    # dyadsprNL <- interpret(fit1NL,
    #                        coefficients = coef(fit1NL),
    #                        target = netwNL,
    #                        type = 'node', i = nodeothersNL, j = nodeiNL)
    dyadsprNL <- pNode('net ~ edges + edgecov(oppNL) + gwesp(0.25, fixed = TRUE) + gwidegree(1.4, fixed = TRUE) + edgecov(beliefsimNL_noNA) + edgecov(instrumentprefNL_noNA) + mutual + nodeofactor("actorType", base = -3) + nodeifactor("actorType", base = -3) + nodeocov("repuTarget") + absdiff("repuTarget")',
                       theta=coef(fit1NL),node=nodeiNL,others=nodeothersNL,nodeSend=F,net=netwNL)
    ## code from Desmarais, Cranmer 2012
    #dyadspr2 <- pNode('net ~ edges + edgecov(betweencoalCH) + nodefactor("coalition",  base = 1) + edgecov(beliefsimCH_noNA) + nodefactor("actorType", base = 3) + nodematch("actorType") + edgecov(repuCH) + gwdegree(0.5, fixed = TRUE) + gwesp(1, fixed = TRUE)',
    #      theta=coef(fit1CH),node=nodei,others=nodeothers,nodeSend=F,net=netw)
    ## get mean pr of tie with each of the 5 chosen nodes
    averageprsCH <- numeric(5)
    averageprsDE <- numeric(5)
    averageprsFR <- numeric(5)
    averageprsNL <- numeric(5)
    for(j in 1:5){ # for each of the 5 chosen nodes
      averageprsCH[j] <- sum(dyadsprCH[,1]*dyadsprCH[,1+j])
      averageprsDE[j] <- sum(dyadsprDE[,1]*dyadsprDE[,1+j])
      averageprsFR[j] <- sum(dyadsprFR[,1]*dyadsprFR[,1+j])
      averageprsNL[j] <- sum(dyadsprNL[,1]*dyadsprNL[,1+j])
    }
    probmatCH[i,k+1] <- mean(averageprsCH)
    probmatDE[i,k+1] <- mean(averageprsDE)
    probmatFR[i,k+1] <- mean(averageprsFR)
    probmatNL[i,k+1] <- mean(averageprsNL)
  }
}
set.seed(this.seed)

##
mu_ci <- function(x){
  cix <- t.test(x,conf.level=.99)$conf.int
  c(cix[1],mean(x),cix[2])
}
## create mean + ci
mcimatCH <- apply(probmatCH,2,mu_ci)
mcimatDE <- apply(probmatDE,2,mu_ci)
mcimatFR <- apply(probmatFR,2,mu_ci)
mcimatNL <- apply(probmatNL,2,mu_ci)
## transpose matrix
mcimatCH <- as.data.frame(t(mcimatCH))
mcimatDE <- as.data.frame(t(mcimatDE))
mcimatFR <- as.data.frame(t(mcimatFR))
mcimatNL <- as.data.frame(t(mcimatNL))
## label columns
names(mcimatCH) <- c('ci.lower', 'mean', 'ci.higher')
names(mcimatDE) <- c('ci.lower', 'mean', 'ci.higher')
names(mcimatFR) <- c('ci.lower', 'mean', 'ci.higher')
names(mcimatNL) <- c('ci.lower', 'mean', 'ci.higher')
## add nr and country to the data frames
mcimatCH$nr <- 0:9
mcimatCH$country <- 'Switzerland'
mcimatDE$nr <- 0:9
mcimatDE$country <- 'Germany'
mcimatFR$nr <- 0:9
mcimatFR$country <- 'France'
mcimatNL$nr <- 0:9
mcimatNL$country <- 'Netherlands'
##
mcimat <- rbind(mcimatCH, mcimatDE, mcimatFR, mcimatNL)
mcimat$country <- factor(mcimat$country, levels = c('Switzerland', 'Germany', 
                                                    'France', 'Netherlands'))
# ##
# ggplot(mcimat, aes(x = nr, y = mean)) +
#   geom_bar(stat="identity", fill = 'grey45') +
#   geom_errorbar(aes(ymin=ci.lower, ymax=ci.higher)) +
#   facet_wrap(~country, nrow= 1) +
#   publicationtheme +
#   scale_x_continuous(breaks = 0:9) +
#   scale_y_continuous(labels = percent, breaks = seq(0, .7, by = .1)) +
#   ylab("Probability of a new tie") +
#   xlab("Number of existing ties")
# ggsave(file = '1_Analysis/output/fig_popularity.pdf', 
#        width = 16, height = 12, units = 'cm')

## relative probabilities
head(mcimat)
mcimat$mean_relative[mcimat$country == 'Switzerland'] <- mcimat$mean[mcimat$country == 'Switzerland'] - mean(dyads$probability[dyads$country == 'CH'])
mcimat$mean_relative[mcimat$country == 'Germany'] <- mcimat$mean[mcimat$country == 'Germany'] - mean(dyads$probability[dyads$country == 'DE'])
mcimat$mean_relative[mcimat$country == 'France'] <- mcimat$mean[mcimat$country == 'France'] - mean(dyads$probability[dyads$country == 'FR'])
mcimat$mean_relative[mcimat$country == 'Netherlands'] <- mcimat$mean[mcimat$country == 'Netherlands'] - mean(dyads$probability[dyads$country == 'NL'])
mcimat$cilower_relative[mcimat$country == 'Switzerland'] <- mcimat$ci.lower[mcimat$country == 'Switzerland'] - mean(dyads$probability[dyads$country == 'CH'])
mcimat$cilower_relative[mcimat$country == 'Germany'] <- mcimat$ci.lower[mcimat$country == 'Germany'] - mean(dyads$probability[dyads$country == 'DE'])
mcimat$cilower_relative[mcimat$country == 'France'] <- mcimat$ci.lower[mcimat$country == 'France'] - mean(dyads$probability[dyads$country == 'FR'])
mcimat$cilower_relative[mcimat$country == 'Netherlands'] <- mcimat$ci.lower[mcimat$country == 'Netherlands'] - mean(dyads$probability[dyads$country == 'NL'])
mcimat$cihigher_relative[mcimat$country == 'Switzerland'] <- mcimat$ci.higher[mcimat$country == 'Switzerland'] - mean(dyads$probability[dyads$country == 'CH'])
mcimat$cihigher_relative[mcimat$country == 'Germany'] <- mcimat$ci.higher[mcimat$country == 'Germany'] - mean(dyads$probability[dyads$country == 'DE'])
mcimat$cihigher_relative[mcimat$country == 'France'] <- mcimat$ci.higher[mcimat$country == 'France'] - mean(dyads$probability[dyads$country == 'FR'])
mcimat$cihigher_relative[mcimat$country == 'Netherlands'] <- mcimat$ci.higher[mcimat$country == 'Netherlands'] - mean(dyads$probability[dyads$country == 'NL'])
##
ggplot(mcimat, aes(x = nr, y = mean_relative)) +
  geom_bar(stat="identity", fill = 'grey45') +
  geom_errorbar(aes(ymin=cilower_relative, ymax=cihigher_relative)) +
  facet_wrap(~country, nrow= 1) +
  publicationtheme +
  scale_x_continuous(breaks = 0:9) +
  scale_y_continuous(labels = percent, breaks = seq(-.5, .7, by = .025)) +
  ylab("Relative probability of a tie\n(baseline probability of tie held at 0%)") +
  xlab("Number of existing ties")
ggsave(file = '1_Analysis/output/FIG4_popularity_relative_full.pdf', 
       width = 20, height = 18, units = 'cm')
##output: Figure 4 in the Article


################################################################################
## Predicted Probabilities: Opponents X governmental actors (incoming)
## Adapting R-code from the Replication Code for Czarna_Leifeld_Smieja_Dufner_Salovey, 2016
################################################################################

## define statistic for bootstrapping
samplemedian <- function(x, d) {
  return(median(x[d]))
}

## Opponents vs. Non-opponents X governmental actors (incoming)
for(i in c('CH', 'DE', 'FR', 'NL')){
  ##
  dyads.opp.gov <- dyads[dyads$opp == 2 & dyads$national_indeg == 1 & dyads$country == i, 'probability']
  dyads.opp.nongov <- dyads[dyads$opp == 2 & dyads$national_indeg == 0 & dyads$country == i, 'probability']
  dyads.nonopp.gov <- dyads[dyads$opp == 1 & dyads$national_indeg == 1 & dyads$country == i, 'probability']
  dyads.nonopp.nongov <- dyads[dyads$opp == 1 & dyads$national_indeg == 0 & dyads$country == i, 'probability']
  ##
  set.seed(this.seed)
  bs.dyads.opp.gov <- boot(dyads.opp.gov, samplemedian, R = nboot)
  bs.dyads.opp.gov <- c(median(bs.dyads.opp.gov$t[, 1]), boot.ci(bs.dyads.opp.gov, type = "bca")$bca[4:5])
  set.seed(this.seed)
  bs.dyads.opp.nongov <- boot(dyads.opp.nongov, samplemedian, R = nboot)
  bs.dyads.opp.nongov <- c(median(bs.dyads.opp.nongov$t[, 1]), boot.ci(bs.dyads.opp.nongov, type = "bca")$bca[4:5])
  set.seed(this.seed)
  bs.dyads.nonopp.gov <- boot(dyads.nonopp.gov, samplemedian, R = nboot)
  bs.dyads.nonopp.gov <- c(median(bs.dyads.nonopp.gov$t[, 1]), boot.ci(bs.dyads.nonopp.gov, type = "bca")$bca[4:5])
  set.seed(this.seed)
  bs.dyads.nonopp.nongov <- boot(dyads.nonopp.nongov, samplemedian, R = nboot)
  bs.dyads.nonopp.nongov <- c(median(bs.dyads.nonopp.nongov$t[, 1]), boot.ci(bs.dyads.nonopp.nongov, type = "bca")$bca[4:5])
  ##
  if(i == 'CH'){
    temp <- data.frame('name' = c('Opp\nGov', 'Opp\nNon-Gov', 'Non-Opp\nGov', 'Non-Opp\nNon-Gov'), 
                       'mean' = c(bs.dyads.opp.gov[1], bs.dyads.opp.nongov[1], bs.dyads.nonopp.gov[1], bs.dyads.nonopp.nongov[1]), 
                       'ci.lower' = c(bs.dyads.opp.gov[2], bs.dyads.opp.nongov[2], bs.dyads.nonopp.gov[2], bs.dyads.nonopp.nongov[2]), 
                       'ci.higher' = c(bs.dyads.opp.gov[3], bs.dyads.opp.nongov[3], bs.dyads.nonopp.gov[3], bs.dyads.nonopp.nongov[3]),
                       'country' = rep(i, 4) )
    prOppGov <- temp
  }else{
    temp <- data.frame('name' = c('Opp\nGov', 'Opp\nNon-Gov', 'Non-Opp\nGov', 'Non-Opp\nNon-Gov'), 
                       'mean' = c(bs.dyads.opp.gov[1], bs.dyads.opp.nongov[1], bs.dyads.nonopp.gov[1], bs.dyads.nonopp.nongov[1]), 
                       'ci.lower' = c(bs.dyads.opp.gov[2], bs.dyads.opp.nongov[2], bs.dyads.nonopp.gov[2], bs.dyads.nonopp.nongov[2]), 
                       'ci.higher' = c(bs.dyads.opp.gov[3], bs.dyads.opp.nongov[3], bs.dyads.nonopp.gov[3], bs.dyads.nonopp.nongov[3]),
                       'country' = rep(i, 4) )
    prOppGov <- rbind(prOppGov, temp)
  }
}

# ## plot it
# ggplot(prOppGov, aes(x = name, y = mean)) +
#   geom_bar(stat = 'identity') +
#   geom_errorbar(ymin = prOppGov$ci.lower, ymax = prOppGov$ci.higher) +
#   facet_wrap(~country, nrow= 1) +
#   publicationtheme +
#   #theme(axis.text.x = element_text(angle=45,vjust=1,hjust=1))+
#   scale_y_continuous(labels = percent, breaks = seq(0, .9, by = .1)) +
#   ylab("Probability of a tie") +
#   xlab("")
# ggsave(file = '1_Analysis/output/fig_prOpponents.pdf', 
#        width = 40, height = 16, units = 'cm')

## Opponents vs. Non-Opponents
## do not distinguish between governmental actors and non-governmental actors
for(i in c('CH', 'DE', 'FR', 'NL')){
  ##
  dyads.opp <- dyads[dyads$opp == 2 & dyads$country == i, 'probability']
  dyads.nonopp <- dyads[dyads$opp == 1 & dyads$country == i, 'probability']
  ##
  set.seed(this.seed)
  bs.dyads.opp <- boot(dyads.opp, samplemedian, R = nboot)
  bs.dyads.opp <- c(median(bs.dyads.opp$t[, 1]), boot.ci(bs.dyads.opp, type = "bca")$bca[4:5])
  set.seed(this.seed)
  bs.dyads.nonopp <- boot(dyads.nonopp, samplemedian, R = nboot)
  bs.dyads.nonopp <- c(median(bs.dyads.nonopp$t[, 1]), boot.ci(bs.dyads.nonopp, type = "bca")$bca[4:5])
  ##
  if(i == 'CH'){
    temp <- data.frame('name' = c('Collaboration with opponent', 'Collaboration with non-opponent'), 
                       'mean' = c(bs.dyads.opp[1], bs.dyads.nonopp[1]), 
                       'ci.lower' = c(bs.dyads.opp[2], bs.dyads.nonopp[2]), 
                       'ci.higher' = c(bs.dyads.opp[3], bs.dyads.nonopp[3]),
                       'country' = rep(i, 2) )
    prOpp <- temp
  }else{
    temp <- data.frame('name' = c('Collaboration with opponent', 'Collaboration with non-opponent'), 
                       'mean' = c(bs.dyads.opp[1], bs.dyads.nonopp[1]), 
                       'ci.lower' = c(bs.dyads.opp[2], bs.dyads.nonopp[2]), 
                       'ci.higher' = c(bs.dyads.opp[3], bs.dyads.nonopp[3]),
                       'country' = rep(i, 2) )
    prOpp <- rbind(prOpp, temp)
  }
}

## adding baseline probability of a tie
prOpp$baselinepr[prOpp$country == 'CH'] <- mean(dyadsCH$probability)
prOpp$baselinepr[prOpp$country == 'DE'] <- mean(dyadsDE$probability)
prOpp$baselinepr[prOpp$country == 'FR'] <- mean(dyadsFR$probability)
prOpp$baselinepr[prOpp$country == 'NL'] <- mean(dyadsNL$probability)

# ##
# ggplot(prOpp, aes(x = name, y = mean)) +
#   geom_bar(stat = 'identity') +
#   geom_errorbar(ymin = prOpp$ci.lower, ymax = prOpp$ci.higher) +
#   geom_hline(aes(yintercept = baselinepr), color = 'blue') + 
#   facet_wrap(~country, nrow= 1) +
#   publicationtheme +
#   #theme(axis.text.x = element_text(angle=45,vjust=1,hjust=1))+
#   scale_y_continuous(labels = percent, breaks = seq(0, 1, by = .1), limits = 0:1) +
#   ylab("Probability of a tie") +
#   xlab("")
# ggsave(file = '1_Analysis/output/fig_prOpponentsOnly.pdf', 
#        width = 50, height = 16, units = 'cm')

## Opponents X governmental actors (incoming): opponents only
for(i in c('CH', 'DE', 'FR', 'NL')){
  ##
  dyads.opp <- dyads[dyads$opp == 2 & dyads$country == i, 'probability']
  dyads.opp.gov <- dyads[dyads$opp == 2 & dyads$national_indeg == 1 & dyads$country == i, 'probability']
  dyads.opp.nongov <- dyads[dyads$opp == 2 & dyads$national_indeg == 0 & dyads$country == i, 'probability']
  ##
  set.seed(this.seed)
  bs.dyads.opp <- boot(dyads.opp, samplemedian, R = nboot)
  bs.dyads.opp <- c(median(bs.dyads.opp$t[, 1]), boot.ci(bs.dyads.opp, type = "bca")$bca[4:5])
  set.seed(this.seed)
  bs.dyads.opp.gov <- boot(dyads.opp.gov, samplemedian, R = nboot)
  bs.dyads.opp.gov <- c(median(bs.dyads.opp.gov$t[, 1]), boot.ci(bs.dyads.opp.gov, type = "bca")$bca[4:5])
  set.seed(this.seed)
  bs.dyads.opp.nongov <- boot(dyads.opp.nongov, samplemedian, R = nboot)
  bs.dyads.opp.nongov <- c(median(bs.dyads.opp.nongov$t[, 1]), boot.ci(bs.dyads.opp.nongov, type = "bca")$bca[4:5])
  ##
  if(i == 'CH'){
    temp <- data.frame('name' = c('Opponent', 'Opponent\nGov', 'Opponent\nNon-Gov'), 
                       'mean' = c(bs.dyads.opp[1], bs.dyads.opp.gov[1], bs.dyads.opp.nongov[1]), 
                       'ci.lower' = c(bs.dyads.opp[2], bs.dyads.opp.gov[2], bs.dyads.opp.nongov[2]), 
                       'ci.higher' = c(bs.dyads.opp[3], bs.dyads.opp.gov[3], bs.dyads.opp.nongov[3]),
                       'country' = rep(i, 3) )
    prOppOnlyGov <- temp
  }else{
    temp <- data.frame('name' =  c('Opponent', 'Opponent\nGov', 'Opponent\nNon-Gov'), 
                       'mean' = c(bs.dyads.opp[1], bs.dyads.opp.gov[1], bs.dyads.opp.nongov[1]), 
                       'ci.lower' = c(bs.dyads.opp[2], bs.dyads.opp.gov[2], bs.dyads.opp.nongov[2]), 
                       'ci.higher' = c(bs.dyads.opp[3], bs.dyads.opp.gov[3], bs.dyads.opp.nongov[3]),
                       'country' = rep(i, 3) )
    prOppOnlyGov <- rbind(prOppOnlyGov, temp)
  }
}

## adding baseline probability of a tie
prOppOnlyGov$baselinepr[prOppOnlyGov$country == 'CH'] <- mean(dyadsCH$probability)
prOppOnlyGov$baselinepr[prOppOnlyGov$country == 'DE'] <- mean(dyadsDE$probability)
prOppOnlyGov$baselinepr[prOppOnlyGov$country == 'FR'] <- mean(dyadsFR$probability)
prOppOnlyGov$baselinepr[prOppOnlyGov$country == 'NL'] <- mean(dyadsNL$probability)

# ##
# ggplot(prOppOnlyGov, aes(x = name, y = mean)) +
#   geom_bar(stat = 'identity') +
#   geom_errorbar(ymin = prOppOnlyGov$ci.lower, ymax = prOppOnlyGov$ci.higher, color = 'grey30') +
#   geom_hline(aes(yintercept = baselinepr), color = 'blue') + 
#   facet_wrap(~country, nrow= 1) +
#   publicationtheme +
#   #theme(axis.text.x = element_text(angle=45,vjust=1,hjust=1))+
#   scale_y_continuous(labels = percent, breaks = seq(0, 1, by = .1), limits = 0:1) +
#   ylab("Probability of a tie") +
#   xlab("")
# ggsave(file = '1_Analysis/output/fig_prOpponentsOnly_Gov.pdf', 
#        width = 32, height = 16, units = 'cm')

## relative probability
prOppOnlyGov
prOppOnlyGov$mean_relative <- prOppOnlyGov$mean - prOppOnlyGov$baselinepr
prOppOnlyGov$ci.lower_relative <- prOppOnlyGov$ci.lower - prOppOnlyGov$baselinepr
prOppOnlyGov$ci.lower_relative <- ifelse(prOppOnlyGov$ci.lower_relative < 0, 0, prOppOnlyGov$ci.lower_relative)
prOppOnlyGov$ci.higher_relative <- prOppOnlyGov$ci.higher - prOppOnlyGov$baselinepr

# ## all three bars: opponents, opponent-gov, opponent-nongov
# ggplot(prOppOnlyGov, aes(x = name, y = mean_relative)) +
#   geom_bar(stat = 'identity') +
#   geom_errorbar(ymin = prOppOnlyGov$ci.lower_relative, ymax = prOppOnlyGov$ci.higher_relative, color = 'grey30') +
#   #geom_hline(aes(yintercept = baselinepr), color = 'blue') + 
#   facet_wrap(~country, nrow= 1) +
#   publicationtheme +
#   #theme(axis.text.x = element_text(angle=45,vjust=1,hjust=1))+
#   scale_y_continuous(labels = percent, breaks = seq(0, 1, by = .1), limits = 0:1) +
#   ylab("Relative probability of a tie\n(baseline probability of tie held at 0%)") +
#   xlab("")
# ggsave(file = '1_Analysis/output/fig_prOpponentsOnly_Gov_relative.pdf', 
#        width = 32, height = 16, units = 'cm')

## inverse country level
prOppOnlyGov$country_inv <- factor(prOppOnlyGov$country, levels = c('NL', 'FR', 'DE', 'CH'))

## only opponents
# ggplot(subset(prOppOnlyGov, prOppOnlyGov$name == 'Opponent'), aes(x = country_inv, y = mean_relative)) +
#   geom_bar(stat = 'identity') +
#   geom_errorbar(aes(ymin = ci.lower_relative, ymax = ci.higher_relative), color = 'grey30') +
#   publicationtheme +
#   #theme(axis.text.x = element_text(angle=45,vjust=1,hjust=1))+
#   scale_y_continuous(labels = percent, breaks = seq(0, 1, by = .1)) +
#   ylab("Relative probability of a tie\n(baseline probability of tie held at 0%)") +
#   xlab("") +
#   coord_flip() +
#   theme(panel.grid.major.x = element_line(colour="#f0f0f0"), 
#         panel.grid.major.y = element_blank())
# ggsave(file = '1_Analysis/output/fig_prOpponentsOnly_relative.pdf', 
#        width = 22, height = 10, units = 'cm')

## only opponents: no French case: 
ggplot(subset(prOppOnlyGov, prOppOnlyGov$name == 'Opponent' & prOppOnlyGov$country != 'FR') , aes(x = country_inv, y = mean_relative)) +
  geom_bar(stat = 'identity') +
  geom_errorbar(aes(ymin = ci.lower_relative, ymax = ci.higher_relative), color = 'grey30') +
  publicationtheme +
  #theme(axis.text.x = element_text(angle=45,vjust=1,hjust=1))+
  scale_y_continuous(labels = percent, breaks = seq(0, 1, by = .1)) +
  ylab("Relative probability of a tie\n(baseline probability of tie held at 0%)") +
  xlab("") +
  coord_flip() +
  theme(panel.grid.major.x = element_line(colour="#f0f0f0"), 
        panel.grid.major.y = element_blank())
ggsave(file = '1_Analysis/output/FIG5_prOpponentsOnly_relative_noFR.pdf', 
       width = 22, height = 8, units = 'cm')
##output: Figure 5 in the Article

## only opponents-gov or opponents-nongov:
ggplot(subset(prOppOnlyGov, prOppOnlyGov$name != 'Opponent'), aes(x = name, y = mean_relative)) +
  geom_bar(stat = 'identity') +
  geom_errorbar(aes(ymin = ci.lower_relative, ymax = ci.higher_relative), color = 'grey30') +
  publicationtheme +
  facet_wrap(~country, nrow= 1) +
  scale_y_continuous(labels = percent, breaks = seq(0, 1, by = .1)) +
  ylab("Relative probability of a tie\n(baseline probability of tie held at 0%)") +
  xlab("") +
  theme(panel.grid.major.x = element_line(colour="#f0f0f0"), 
        panel.grid.major.y = element_blank())
ggsave(file = '1_Analysis/output/SIFIG4_prOpponents_Gov_relative.pdf', 
       width = 22, height = 16, units = 'cm')
##output: Figure 4 in the SI Online

################################################################################
## Belief similarity: Predicted Probabilities
################################################################################

## Relative probabilities
dyads$pr_relative[dyads$country == 'CH'] <- dyads$probability[dyads$country == 'CH'] - mean(dyads$probability[dyads$country == 'CH'])
dyads$pr_relative[dyads$country == 'DE'] <- dyads$probability[dyads$country == 'DE'] - mean(dyads$probability[dyads$country == 'DE'])
dyads$pr_relative[dyads$country == 'FR'] <- dyads$probability[dyads$country == 'FR'] - mean(dyads$probability[dyads$country == 'FR'])
dyads$pr_relative[dyads$country == 'NL'] <- dyads$probability[dyads$country == 'NL'] - mean(dyads$probability[dyads$country == 'NL'])

# ## plot relative pr
# ggplot(dyads, aes(x = beliefsim, y = pr_relative))+ 
#   #geom_point(alpha = .3, size = 1, fill = 'grey75', color = 'grey75') + 
#   geom_smooth(aes(color = country), method = 'lm', se = TRUE) +
#   scale_color_manual("", values = c('CH' = "#D7191C", #'firebrick1', 
#                                     'DE' = '#FDAE61', #'gold',
#                                     'FR' = '#2B83BA', #'dodgerblue2', 
#                                     'NL' = 'springgreen3')) +
#   ylab("Relative probability of a tie\n(baseline probability of tie held at 0%)") +
#   xlab("Average differences in policy beliefs") +
#   publicationtheme +
#   scale_y_continuous(label = percent) + 
#   theme(panel.grid.major.x = element_line(colour="#f0f0f0")) +
#   theme(legend.key=element_blank()) +
#   guides(color=guide_legend(override.aes=list(fill=NA))) +
#   theme(legend.key = element_blank())
# ggsave(file = '1_Analysis/output/fig_Edgeprob_Beliefdiff_lm_relative.pdf', 
#        width = 22, height = 16, units = 'cm')

# pbeliefpredrel <- ggplot(dyads, aes(x = beliefsim, y = pr_relative))+
#   #geom_point(alpha = .3, size = 1, fill = 'grey75', color = 'grey75') +
#   geom_smooth(aes(color = country), method = 'loess', se = TRUE, span = 3) +
#   scale_color_manual("", values = c('CH' = "#D7191C", #'firebrick1',
#                                     'DE' = '#FDAE61', #'gold',
#                                     'FR' = '#2B83BA', #'dodgerblue2',
#                                     'NL' = 'springgreen3')) +
#   ylab("Relative probability of a tie\n(baseline probability of tie held at 0%)") +
#   xlab("Average differences in policy beliefs") +
#   publicationtheme +
#   scale_y_continuous(label = percent) +
#   theme(panel.grid.major.x = element_line(colour="#f0f0f0")) +
#   theme(legend.key=element_blank()) +
#   guides(color=guide_legend(override.aes=list(fill=NA))) +
#   theme(legend.key = element_blank())
# ggsave(pbeliefpredrel, file = '1_Analysis/output/fig_Edgeprob_Beliefdiff_smoothed_relative.pdf', 
#        width = 22, height = 16, units = 'cm')

## French case only
pbeliefpredrelFR <- ggplot(dyads[dyads$country == 'FR',], aes(x = beliefsim, y = pr_relative))+ 
  #geom_point(alpha = .3, size = 1, fill = 'grey75', color = 'grey75') + 
  geom_smooth(aes(color = country), method = 'loess', se = TRUE, span = 3) +
  scale_color_manual("", values = c('FR' = '#2B83BA')) +
  ylab("Relative probability of a tie\n(baseline probability of tie held at 0%)") +
  xlab("Average differences in policy beliefs\nfor the French network") +
  publicationtheme +
  scale_y_continuous(label = percent) + 
  theme(panel.grid.major.x = element_line(colour="#f0f0f0")) +
  theme(legend.key=element_blank()) +
  guides(color=guide_legend(override.aes=list(fill=NA))) +
  theme(legend.key = element_blank())

## combine the relative plot with the boxplot
# function to save the legend
# legendpbeliefpred <- g_legend(pbeliefpredrel)
# # plot
# pdf('1_Analysis/output/fig_belief_boxplot_predpr_relative.pdf', width = 7, height = 5)
# gridExtra::grid.arrange(cowplot::plot_grid(pbeliefdif, pbeliefpredrel + theme(legend.position = 'none'), 
#                                            nrow=1, rel_widths = c(3,7), align = 'h'),
#                         legendpbeliefpred, nrow=2,heights=c(10, 1))
# dev.off()
## French case only: 
# plot
pdf('1_Analysis/output/FIG6_belief_boxplot_predpr_relative_FRonly.pdf', width = 7, height = 5)
gridExtra::grid.arrange(cowplot::plot_grid(pbeliefdif, pbeliefpredrelFR + theme(legend.position = 'none'), 
                                           nrow=1, rel_widths = c(3,7), align = 'h'), nrow=2,heights=c(10, 1))
dev.off()
##output: Figure 6 in the Article


################################################################################
################################################################################
################################################################################
################################################################################
# APPENDIX FIGURES
################################################################################

################################################################################
## Coordinates for network plots
## Note: We use the Fruchterman-Reingold algorithm to plot our networks. 
## This means that every time the network is re-drawn, the nodes shift around.
## We have been advised to provide exact replications, therefore, 
## we save our layouts in an RData file and import them here to ensure
## every plot looks exactly the same (i.e., no shifting, even if the seed
## is changed or if a different operating system is used than the one we have 
## run our analysis on (see above)).
################################################################################

# for sake of transparency, we leave the code for how we created the coordinates here:
# set.seed(123)
# coordinatescollabCH <-  gplot.layout.fruchtermanreingold(collabCH[-26,-26], NULL)
# coordinatescollabDE <-  gplot.layout.fruchtermanreingold(collabDE[-c(2,6,18),-c(2,6,18)], NULL)
# coordinatescollabFR <-  gplot.layout.fruchtermanreingold(collabFR, NULL)
# coordinatescollabNL <-  gplot.layout.fruchtermanreingold(collabNL[-16, -16], NULL)
# coordinatesoppCH <-  gplot.layout.fruchtermanreingold(nwCHoppcoll, NULL)
# coordinatesoppDE <-  gplot.layout.fruchtermanreingold(nwDEoppcoll, NULL)
# coordinatesoppFR <-  gplot.layout.fruchtermanreingold(nwFRoppcoll, NULL)
# coordinatesoppNL <-  gplot.layout.fruchtermanreingold(nwNLoppcoll, NULL)
# save(coordinatescollabCH, coordinatescollabDE, coordinatescollabFR, coordinatescollabNL, 
#      coordinatesoppCH, coordinatesoppDE, coordinatesoppFR, coordinatesoppNL,
#      file = '1_Analysis/output/coordinates_nwplots.RData')

## load pre-saved coordinates of nodes for exact replication:
load('1_Analysis/output/coordinates_nwplots.RData')

################################################################################
## Network plots with actor types
################################################################################

## change actor type variable
changeActorTypes_clean <- function(var){
  var <- ifelse(var == 1, 'national government', var)
  var <- ifelse(var == 2, 'regional, local government', var)
  var <- ifelse(var == 3, 'water association', var)
  var <- ifelse(var == 4, 'environmental association', var)
  var <- ifelse(var == 5, 'industrial, agricultural association', var)
  var <- ifelse(var == 6, 'science', var)
  var <- ifelse(var == 7, 'political party', var)
  var
}
attCH$actTypes_clean <- changeActorTypes_clean(attCH$actorTypes)
attDE$actTypes_clean <- changeActorTypes_clean(attDE$actorTypes)
attFR$actTypes_clean <- changeActorTypes_clean(attFR$actorTypes)
attNL$actTypes_clean <- changeActorTypes_clean(attNL$actorTypes)

## colors
RColorBrewer::brewer.pal(7, 'Spectral')
colpal <- c('national government (n)' = '#D53E4F', 
            'regional, local government (r)' = '#FC8D59', 
            'water association (w)' = '#3288BD', 
            'environmental association (e)' = '#99D594', 
            'industrial, agricultural association (i)' = '#FEE08B', 
            'science (s)' = '#E6F598', 
            'political party (p)' = '#FFFFBF')

## CH
attCH$indeg <- degree(collabCH, cmode = 'indegree')
pnwCH <- ggnet2(collabCH[-26,-26], label = FALSE, arrow.size = 4, arrow.gap = 0.02, 
                node.color = paste0(attCH$actTypes_clean[-26], " (", substr(attCH$actTypes_clean[-26], 1, 1), ")"),
                palette = colpal, 
                mode = coordinatescollabCH,
                node.label = substr(attCH$actTypes_clean[-26], 1, 1),
                label.size = ifelse(attCH$indeg > 8, 8, ifelse(attCH$indeg == 0, 1, attCH$indeg))[-26],
                size = attCH$indeg[-26])+
  guides(size = FALSE) + ggtitle("Switzerland") +
  theme(plot.title = element_text(face = "bold", size = rel(2), hjust = 0.5, color = 'grey50')) +
  theme(legend.position = 'bottom')
# save the legend
g_legend<-function(a.gplot){
  tmp <- ggplot_gtable(ggplot_build(a.gplot))
  leg <- which(sapply(tmp$grobs, function(x) x$name) == "guide-box")
  legend <- tmp$grobs[[leg]]
  legend
}
legend <- g_legend(pnwCH)

## DE
attDE$indeg <- degree(collabDE, cmode = 'indegree')
pnwDE <- ggnet2(collabDE[-c(2,6,18),-c(2,6,18)], label = FALSE,
                size = attDE$indeg[-c(2,6,18)],
                arrow.size = 4, arrow.gap = 0.02, 
                mode = coordinatescollabDE,
                node.color = paste0(attDE$actTypes_clean[-c(2,6,18)], " (", substr(attDE$actTypes_clean[-c(2,6,18)], 1, 1), ")"),
                node.label = substr(attDE$actTypes_clean[-c(2,6,18)], 1, 1),
                label.size = ifelse(attDE$indeg > 8, 8, ifelse(attDE$indeg == 0, 1, attDE$indeg))[-c(2,6,18)],
                palette = colpal)+
  guides(size = FALSE) + ggtitle("Germany") +
  theme(plot.title = element_text(face = "bold", size = rel(2), hjust = 0.5, color = 'grey50')) +
  theme(legend.position = 'none')

## FR
attFR$indeg <- degree(collabFR, cmode = 'indegree')
pnwFR <- ggnet2(collabFR, label = FALSE,
                size = attFR$indeg,
                mode = coordinatescollabFR,
                arrow.size = 4, arrow.gap = 0.02, 
                node.color = paste0(attFR$actTypes_clean, " (", substr(attFR$actTypes_clean, 1, 1), ")"),
                node.label = substr(attFR$actTypes_clean, 1, 1),
                label.size = ifelse(attFR$indeg >8, 8, ifelse(attFR$indeg==0, 1, attFR$indeg)),
                palette = colpal)+
  guides(size = FALSE) + ggtitle("France") +
  theme(plot.title = element_text(face = "bold", size = rel(2), hjust = 0.5, color = 'grey50')) +
  theme(legend.position = 'none')

## NL
attNL$indeg <- degree(collabNL, cmode = 'indegree')
pnwNL <- ggnet2(collabNL[-16, -16], label = FALSE,
                size = attNL$indeg[-16],
                mode = coordinatescollabNL,
                arrow.size = 4, arrow.gap = 0.02, 
                node.color = paste0(attNL$actTypes_clean[-16], " (", substr(attNL$actTypes_clean[-16], 1, 1), ")"),
                node.label = substr(attNL$actTypes_clean[-16], 1, 1),
                label.size = ifelse(attNL$indeg > 8, 8, ifelse(attNL$indeg == 0, 1, attNL$indeg))[-16],
                palette = colpal)+
  guides(size = FALSE) +  ggtitle("Netherlands") +
  theme(plot.title = element_text(face = "bold", size = rel(2), hjust = 0.5, color = 'grey50')) +
  theme(legend.position = 'none')

## add bar plot below for each country, how many (%) of actors per type
attNL$actTypes_clean
attall <- rbind(as.data.frame(attNL %>% 
                                group_by(actTypes_clean) %>%
                                summarise(country = "NL",
                                          n = n(),
                                          perc = round(n()/16*100,1))), 
                as.data.frame(attCH %>% 
                                group_by(actTypes_clean) %>%
                                summarise(country = "CH",
                                          n = n(),
                                          perc = round(n()/47*100,1))), 
                as.data.frame(attDE %>% 
                                group_by(actTypes_clean) %>%
                                summarise(country = "DE",
                                          n = n(),
                                          perc = round(n()/29*100,1))), 
                as.data.frame(attFR %>% 
                                group_by(actTypes_clean) %>%
                                summarise(country = "FR",
                                          n = n(),
                                          perc = round(n()/18*100,1))) ) 
attall$perc_label <- paste0(attall$perc, "%")
attall$perc_label <- paste0(attall$perc_label, " (", substr(attall$actTypes_clean, 1, 1), ")")
attall$country <- factor(attall$country, levels =c( 'NL', 'FR', 'DE', 'CH'))

## plot bar chart
pnbar <- ggplot(attall, aes(x = country, y = perc, fill = paste0(actTypes_clean, " (", substr(actTypes_clean, 1, 1), ")")))+
  geom_bar(stat = "identity") + 
  coord_flip()+
  publicationtheme +
  scale_fill_manual(values = colpal) +
  xlab("") + ylab("Percentage of actors per actor type") +
  geom_text(aes(label=perc_label),stat="identity",position=position_stack(), hjust = 1.1) +
  theme(legend.position = "none") +
  theme(axis.text.y=element_text(size=rel(2))) +
  theme(panel.grid.major.y = element_blank()) 

## arrange network plots: 
pdf('1_Analysis/output/FIG1_nw_collab_plusbar.pdf', width = 12, height = 12)
gridExtra::grid.arrange(gridExtra::arrangeGrob(pnwCH + theme(legend.position = 'none'), pnwDE, pnwFR, pnwNL,
                                               nrow=2), pnbar, legend, nrow=3, heights=c(10,3, 1))
dev.off()
##output: Figure 1 in the Article 

################################################################################
## Network plots: Collaboration and opponents
################################################################################

## network plot: CH - collaboration - opponents
collabOppCH <- matrix(0, nrow = nrow(collabCH), ncol = ncol(collabCH))
rownames(collabOppCH) <- rownames(collabCH)
colnames(collabOppCH) <- colnames(collabCH)
for(i in 1:nrow(collabOppCH)){
  for(j in 1:ncol(collabOppCH)){
    if(collabCH[i,j] == 1 & oppCH[i,j] == 0) collabOppCH[i,j] <- 1
    if(collabCH[i,j] == 1 & oppCH[i,j] == 1) collabOppCH[i,j] <- 2
    if(collabCH[i,j] == 0 & oppCH[i,j] == 1) collabOppCH[i,j] <- 3
  }
}
table(collabOppCH)
nwCHoppcoll <- network(collabOppCH[-26,-26], directed = TRUE)
nwCHoppcoll %e% 'opponents' = collabOppCH[-26,-26]
set.edge.attribute(nwCHoppcoll, "color", ifelse(nwCHoppcoll %e% "opponents" > 1, ifelse(nwCHoppcoll %e% "opponents" > 2, 'red' , 'blue' ), "grey75"))
nwCHoppcoll %v% 'indeg' = degree(collabCH, cmode = 'indegree')[-26]
## graph
p1CH <- ggnet2(nwCHoppcoll, label = FALSE, arrow.size = 4, arrow.gap = 0.02, 
               mode = coordinatesoppCH,
               node.color = 'grey65',
               edge.color = 'color', 
               size = 'indeg') + ggtitle("Switzerland") + guides(size = FALSE) +
  theme(plot.title = element_text(face = "bold", size = rel(2), hjust = 0.5, color = 'grey50'))

## network plot: DE - collaboration - opponents
collabOppDE <- matrix(0, nrow = nrow(collabDE), ncol = ncol(collabDE))
rownames(collabOppDE) <- rownames(collabDE)
colnames(collabOppDE) <- colnames(collabDE)
for(i in 1:nrow(collabOppDE)){
  for(j in 1:ncol(collabOppDE)){
    if(collabDE[i,j] == 1 & oppDE[i,j] == 0) collabOppDE[i,j] <- 1
    if(collabDE[i,j] == 1 & oppDE[i,j] == 1) collabOppDE[i,j] <- 2
    if(collabDE[i,j] == 0 & oppDE[i,j] == 1) collabOppDE[i,j] <- 3
  }
}
table(collabOppDE)
nwDEoppcoll <- network(collabOppDE[-18,-18], directed = TRUE)
nwDEoppcoll %e% 'opponents' = collabOppDE[-18,-18]
set.edge.attribute(nwDEoppcoll, "color", ifelse(nwDEoppcoll %e% "opponents" > 1, ifelse(nwDEoppcoll %e% "opponents" > 2, 'red' , 'blue' ), "grey75"))
nwDEoppcoll %v% 'indeg' = degree(collabDE, cmode = 'indegree')[-18]
## graph
p1DE <- ggnet2(nwDEoppcoll, label = FALSE, arrow.size = 4, arrow.gap = 0.02, 
               color = "grey65",
               mode = coordinatesoppDE,
               edge.color = 'color', 
               size = 'indeg') + ggtitle("Germany")  + guides(size = FALSE) +
  theme(plot.title = element_text(face = "bold", size = rel(2), hjust = 0.5, color = 'grey50'))

## network plot: FR - collaboration - opponents
collabOppFR <- matrix(0, nrow = nrow(collabFR), ncol = ncol(collabFR))
rownames(collabOppFR) <- rownames(collabFR)
colnames(collabOppFR) <- colnames(collabFR)
for(i in 1:nrow(collabOppFR)){
  for(j in 1:ncol(collabOppFR)){
    if(collabFR[i,j] == 1 & oppFR[i,j] == 0) collabOppFR[i,j] <- 1
    if(collabFR[i,j] == 1 & oppFR[i,j] == 1) collabOppFR[i,j] <- 2
    if(collabFR[i,j] == 0 & oppFR[i,j] == 1) collabOppFR[i,j] <- 3
  }
}
table(collabOppFR)
nwFRoppcoll <- network(collabOppFR, directed = TRUE)
nwFRoppcoll %e% 'opponents' = collabOppFR
set.edge.attribute(nwFRoppcoll, "color", ifelse(nwFRoppcoll %e% "opponents" > 1, ifelse(nwFRoppcoll %e% "opponents" > 2, 'red' , 'blue' ), "grey75"))
nwFRoppcoll %v% 'indeg' = degree(collabFR, cmode = 'indegree')
## graph
p1FR <- ggnet2(nwFRoppcoll, label = FALSE, arrow.size = 4, arrow.gap = 0.02, 
               color = "grey65",
               mode = coordinatesoppFR,
               edge.color = 'color', 
               size = 'indeg') + ggtitle("France")  + guides(size = FALSE) +
  theme(plot.title = element_text(face = "bold", size = rel(2), hjust = 0.5, color = 'grey50'))

## network plot: NL - collaboration - opponents
collabOppNL <- matrix(0, nrow = nrow(collabNL), ncol = ncol(collabNL))
rownames(collabOppNL) <- rownames(collabNL)
colnames(collabOppNL) <- colnames(collabNL)
for(i in 1:nrow(collabOppNL)){
  for(j in 1:ncol(collabOppNL)){
    if(collabNL[i,j] == 1 & oppNL[i,j] == 0) collabOppNL[i,j] <- 1
    if(collabNL[i,j] == 1 & oppNL[i,j] == 1) collabOppNL[i,j] <- 2
    if(collabNL[i,j] == 0 & oppNL[i,j] == 1) collabOppNL[i,j] <- 3
  }
}
table(collabOppNL)
nwNLoppcoll <- network(collabOppNL[-16,-16], directed = TRUE)
nwNLoppcoll %e% 'opponents' = collabOppNL[-16,-16]
set.edge.attribute(nwNLoppcoll, "color", ifelse(nwNLoppcoll %e% "opponents" > 1, ifelse(nwNLoppcoll %e% "opponents" > 2, 'red' , 'blue' ), "grey75"))
nwNLoppcoll %v% 'indeg' = degree(collabNL, cmode = 'indegree')[-16]
## graph
p1NL <- ggnet2(nwNLoppcoll, label = FALSE, arrow.size = 4, arrow.gap = 0.02, 
               color = "grey65",
               mode = coordinatesoppNL,
               edge.color = 'color', 
               size = 'indeg') + ggtitle("Netherlands")  + guides(size = FALSE) +
  theme(plot.title = element_text(face = "bold", size = rel(2), hjust = 0.5, color = 'grey50'))

## arrange four network plots
pdf('1_Analysis/output/SIFIG1_nw_collabOpponents_all.pdf', width = 12, height = 10)
gridExtra::grid.arrange(p1CH, p1DE, p1FR, p1NL, nrow=2)
dev.off()
##output: Figure 1 in the SI Online

################################################################################
## Check missing data
## Two tests: 
## 1) check reputaiton of missing actors
## 2) check if ergm changes if only 50% of data is chosen (Swiss case)
################################################################################

## Test 1: 
# rename variable
indegAll_full <- as.data.frame(indegAll %>% 
                                 group_by(country, missing) %>%
                                 summarise(n=paste0("N = ", n())))
# boxplot 
ggplot(indegAll, aes(x = country, y = indeg, color = factor(missing)))+
  geom_boxplot() +
  publicationtheme +
  ylab("Indegree centrality of nodes") +
  xlab("") +
  ylim(c(-2, 40)) +
  geom_text(data = indegAll_full, aes(label = n, y = -1), position = position_dodge(0.7)) +
  scale_color_manual("", values = c('blue', 'forestgreen'), labels = c('Responded', 'Missing'))
ggsave(file = '1_Analysis/output/SIFIG6_boxplot_missingObs_Reputation.pdf', width = 18, height = 14, units = 'cm')
##output: Figure 6 in the SI Online

## t-tests
t.test(indeg ~ missing, data = indegAll[indegAll$country == 'Switzerland',])
t.test(indeg ~ missing, data = indegAll[indegAll$country == 'Germany',])
t.test(indeg ~ missing, data = indegAll[indegAll$country == 'France',])
t.test(indeg ~ missing, data = indegAll[indegAll$country == 'Netherlands',])

## Test 2: 
# prepare subsample of CH-network (-10%, -20%, -30%, -40%, -50% data)
set.seed(this.seed)
remove10 <- sample(1:47, size = 5, replace = FALSE)
set.seed(this.seed)
remove20 <- sample(1:47, size = 10, replace = FALSE)
set.seed(this.seed)
remove30 <- sample(1:47, size = 15, replace = FALSE)
set.seed(this.seed)
remove40 <- sample(1:47, size = 20, replace = FALSE)
set.seed(this.seed)
remove50 <- sample(1:47, size = 25, replace = FALSE)
## create network object
nwCH10 <- network(collabCH[-remove10, -remove10], directed = TRUE)
nwCH20 <- network(collabCH[-remove20, -remove20], directed = TRUE)
nwCH30 <- network(collabCH[-remove30, -remove30], directed = TRUE)
nwCH40 <- network(collabCH[-remove40, -remove40], directed = TRUE)
nwCH50 <- network(collabCH[-remove50, -remove50], directed = TRUE)
# add actor type
nwCH10 %v% "actorType" = as.character(attCH$actorTypesChar[-remove10])
nwCH20 %v% "actorType" = as.character(attCH$actorTypesChar[-remove20])
nwCH30 %v% "actorType" = as.character(attCH$actorTypesChar[-remove30])
nwCH40 %v% "actorType" = as.character(attCH$actorTypesChar[-remove40])
nwCH50 %v% "actorType" = as.character(attCH$actorTypesChar[-remove50])
# add reputation
nwCH10 %v% 'repuTarget' = attCH$reputation[-remove10]
nwCH20 %v% 'repuTarget' = attCH$reputation[-remove20]
nwCH30 %v% 'repuTarget' = attCH$reputation[-remove30]
nwCH40 %v% 'repuTarget' = attCH$reputation[-remove40]
nwCH50 %v% 'repuTarget' = attCH$reputation[-remove50]

## run the ERGMs
tryCatch(expr = {
  fit2CH_10 <- ergm(nwCH10 ~ edges 
                    + gwidegree(1.4, fixed = TRUE) 
                    + gwesp(.25, fixed = TRUE)   
                    + edgecov(oppCH_12[-remove10, -remove10]) 
                    + edgecov(beliefsimCH_noNA[-remove10, -remove10])
                    + edgecov(beliefsim_opp_CH[-remove10, -remove10])
                    ## Controls
                    + mutual
                    + edgecov(instrumentprefCH_noNA[-remove10, -remove10])
                    + nodeofactor('actorType', base = -3)
                    + nodeifactor('actorType', base = -3)
                    + nodeocov('repuTarget')
                    + absdiff('repuTarget')
                    ,control = control.ergm(seed = this.seed))
  # save(fit2CH_10, file = '1_Analysis/output/ERGM_estimates/fit2CH_10.RData')
}, error = function(e){print(paste0("Estimation error: ", e, " -- Load model"))})
if(!("fit2CH_10" %in% ls()) | simpleReplication){load('1_Analysis/output/ERGM_estimates/fit2CH_10.RData')}

tryCatch(expr = {
  fit2CH_20 <- ergm(nwCH20 ~ edges 
                    + gwidegree(1.4, fixed = TRUE) 
                    + gwesp(.25, fixed = TRUE)   
                    + edgecov(oppCH_12[-remove20, -remove20]) 
                    + edgecov(beliefsimCH_noNA[-remove20, -remove20])
                    + edgecov(beliefsim_opp_CH[-remove20, -remove20])
                    ## Controls
                    + mutual
                    + edgecov(instrumentprefCH_noNA[-remove20, -remove20])
                    + nodeofactor('actorType', base = -3)
                    + nodeifactor('actorType', base = -3)
                    + nodeocov('repuTarget')
                    + absdiff('repuTarget')
                    ,control = control.ergm(seed = this.seed))
  # save(fit2CH_20, file = '1_Analysis/output/ERGM_estimates/fit2CH_20.RData')
}, error = function(e){print(paste0("Estimation error: ", e, " -- Load model"))})
if(!("fit2CH_20" %in% ls()) | simpleReplication){load('1_Analysis/output/ERGM_estimates/fit2CH_20.RData')}

tryCatch(expr = {
  fit2CH_30 <- ergm(nwCH30 ~ edges 
                    + gwidegree(.8, fixed = TRUE) #reduced to .8 converged twice!
                    + gwesp(.25, fixed = TRUE)   
                    + edgecov(oppCH_12[-remove30, -remove30]) 
                    + edgecov(beliefsimCH_noNA[-remove30, -remove30])
                    + edgecov(beliefsim_opp_CH[-remove30, -remove30])
                    ## Controls
                    + mutual
                    + edgecov(instrumentprefCH_noNA[-remove30, -remove30])
                    + nodeofactor('actorType', base = -3)
                    + nodeifactor('actorType', base = -3)
                    + nodeocov('repuTarget')
                    + absdiff('repuTarget')
                    ,control = control.ergm(seed = 1234))
  # save(fit2CH_30, file = '1_Analysis/output/ERGM_estimates/fit2CH_30.RData')
}, error = function(e){print(paste0("Estimation error: ", e, " -- Load model"))})
if(!("fit2CH_30" %in% ls()) | simpleReplication){load('1_Analysis/output/ERGM_estimates/fit2CH_30.RData')}

tryCatch(expr = {
  fit2CH_40 <- ergm(nwCH40 ~ edges 
                    + gwidegree(.4, fixed = TRUE) #reduced to .4, converged twice
                    + gwesp(.25, fixed = TRUE)   
                    + edgecov(oppCH_12[-remove40, -remove40]) 
                    + edgecov(beliefsimCH_noNA[-remove40, -remove40])
                    + edgecov(beliefsim_opp_CH[-remove40, -remove40])
                    ## Controls
                    + mutual
                    + edgecov(instrumentprefCH_noNA[-remove40, -remove40])
                    + nodeofactor('actorType', base = -3)
                    + nodeifactor('actorType', base = -3)
                    + nodeocov('repuTarget')
                    + absdiff('repuTarget')
                    ,control = control.ergm(seed = this.seed))
  # save(fit2CH_40, file = '1_Analysis/output/ERGM_estimates/fit2CH_40.RData')
}, error = function(e){print(paste0("Estimation error: ", e, " -- Load model"))})
if(!("fit2CH_40" %in% ls()) | simpleReplication){load('1_Analysis/output/ERGM_estimates/fit2CH_40.RData')}

# then get table with all models
coefnames_mis <- c('Edges', 
                   'Power concentration (gwidegree, H1)', 
                   'Clustering (gwesp, H2)', 
                   'Collaboration with opponents (H2)',
                   'Collaboration across belief dissimilarity (H2)', 
                   'Interaction: Collab with opp. X belief dissim.',
                   #Controls
                   'Reciprocity',
                   'Instrument preference dissimilarity',
                   'Outdegree: Governmental actors', 
                   'Indegree: Governmental actors', 
                   'Outdegree: high reputation',
                   'Difference in reputation',
                   # 10%
                   'Collaboration with opponents (H2)',
                   'Collaboration across belief dissimilarity (H2)', 
                   'Interaction: Collab with opp. X belief dissim.',
                   'Instrument preference dissimilarity',
                   # 20%
                   'Collaboration with opponents (H2)',
                   'Collaboration across belief dissimilarity (H2)', 
                   'Interaction: Collab with opp. X belief dissim.',
                   'Instrument preference dissimilarity',
                   # 30%
                   'Power concentration (gwidegree, H1)', 
                   'Collaboration with opponents (H2)',
                   'Collaboration across belief dissimilarity (H2)', 
                   'Interaction: Collab with opp. X belief dissim.',
                   'Instrument preference dissimilarity',
                   # 40%
                   'Power concentration (gwidegree, H1)', 
                   'Collaboration with opponents (H2)',
                   'Collaboration across belief dissimilarity (H2)', 
                   'Interaction: Collab with opp. X belief dissim.',
                   'Instrument preference dissimilarity'
)
## text-file
texreg(list(fit2CH, fit2CH_10, fit2CH_20, fit2CH_30, fit2CH_40), 
       stars = c(0.05, 0.01, 0.001),
       booktabs = TRUE, dcolumn = TRUE, 
       use.packages = FALSE, fontsize = 'footnotesize',
       caption.above = TRUE,
       caption = 'Results on network structure using exponential random graph models for the Swiss policy network and subsets thereof. The first model reports the ERGM presented in the article. The second, third, fourth and fifth models are run on a network with 5, 10, 15 or 20 nodes removed (respectfully; removed nodes are randomly selected).',
       label = 'tab_ergmCH_missingObs',
       custom.model.names = c('Original (N=47)', '90% (N=42)', '79% (N=37)', '68% (N=32)', '57% (N=27)'), 
       custom.coef.names = coefnames_mis,
       reorder.coef = c(2:12, 1),
       groups = list('Hypotheses' = 1:5, 'Controls' = 6:12),
       file = '1_Analysis/output/SITAB6_ergms_missingObs.tex')
##output: Table 6 in the SI Online

################################################################################
## Run ERGM for CH-case with better control for incoming k-stars
################################################################################

## CH
tryCatch(expr = {
  fit1CHb <- ergm(nwCH ~ edges 
                  + edgecov(oppCH) 
                  + gwesp(.25, fixed = TRUE)  
                  #+ gwidegree(2, fixed = TRUE) 
                  + istar(2)
                  + edgecov(beliefsimCH_noNA)
                  + edgecov(instrumentprefCH_noNA)
                  ## Controls
                  + mutual
                  + nodeofactor('actorType', base = -3)
                  + nodeifactor('actorType', base = -3)
                  + nodeocov('repuTarget')
                  + absdiff('repuTarget')
                  ,control = control.ergm(seed = this.seed))
  # save(fit1CHb, file = '1_Analysis/output/ERGM_estimates/fit1CHb.RData')
}, error = function(e){print(paste0("Estimation error: ", e, " -- Load model"))})
if(!("fit1CHb" %in% ls()) | simpleReplication){load('1_Analysis/output/ERGM_estimates/fit1CHb.RData')}
# summary(fit1CHb) 
# mcmc.diagnostics(fit1CHb)
goffit1CHb <- btergm::gof(fit1CHb, statistics = c(deg, dsp, istar, geodesic, triad.directed, rocpr), nsim = 500)
pdf(file = '1_Analysis/output/SIFIG3_fit_ergm_gof_CH_appendix.pdf', width = 24, height = 4)
par(mfrow = c(1, 6))
plot(goffit1CHb, mfrow = FALSE)
dev.off()
##output: Figure 3 in the SI Online

## save models
coefnamesCHonly <- c('Edges', 
                     'Collaboration with opponents (H2)',
                     'Clustering (gwesp, H2)', 
                     'Power concentration (gwidegree, H1)', 
                     'Collaboration across belief dissimilarity (H2)', 
                     'Instrument preference dissimilarity',
                     'Reciprocity',
                     'Outdegree: Governmental actors', 
                     'Indegree: Governmental actors', 
                     'Outdegree: high reputation',
                     'Difference in reputation', 
                     'In-2-star')

## tex-file
texreg(list(fit1CH, fit1CHb), 
       stars = c(0.1, 0.05, 0.01, 0.001),
       booktabs = TRUE, dcolumn = TRUE, 
       use.packages = FALSE, fontsize = 'scriptsize',
       caption.above = TRUE, single.row = TRUE,
       label = 'tab_ergmCHonly',
       caption = 'Results on network structure using exponential random graph models for the Swiss policy network',
       custom.model.names = c('CH reported (no interaction)', 'CH adjusted'), 
       custom.coef.names = coefnamesCHonly,
       file = '1_Analysis/output/SITAB5_ergms_CHonly.tex', 
       reorder.coef = c(4, 12, 3,2,5, 7, 6, 8:11, 1), 
       #       custom.note = "$^{∗∗∗}$ $p < 0.001$, $^{∗∗}$ $p < 0.01$,$^∗$ $p < 0.05$,$^·$ $p < 0.1$; Coefficients are reported as log odds."
       groups = list('Hypotheses' = 1:5, 'Controls' = 6:12))
##output: Table 5 in the SI Online

################################################################################
## Instrument Preference: Predicted Probabilities
################################################################################

# ##
# pinstrpred <- ggplot(dyads, aes(x = instrumentpref, y = probability))+ 
#   geom_point(alpha = .3, size = 1, fill = 'grey75', color = 'grey75') + 
#   geom_smooth(aes(color = country), method = 'loess') +
#   scale_color_manual("", values = c('CH' = "#D7191C", #'firebrick1', 
#                                     'DE' = '#FDAE61', #'gold',
#                                     'FR' = '#2B83BA', #'dodgerblue2', 
#                                     'NL' = 'springgreen3')) +
#   ylab("Probability of forming a tie") +
#   xlab("Average differences in instrument preferences") +
#   publicationtheme +
#   theme(panel.grid.major.x = element_line(colour="#f0f0f0")) +
#   theme(legend.key=element_blank()) +
#   guides(color=guide_legend(override.aes=list(fill=NA))) +
#   theme(legend.key = element_blank())
# ggsave(pinstrpred, file = '1_Analysis/output/fig_Edgeprob_InstrPrefdiff.pdf', width = 16, 
#        height = 12, units = 'cm')
# 
# ## combine boxplot and predicted pr plot
# legendpinstrpred <- g_legend(pinstrpred)
# # plot
# pdf('1_Analysis/output/fig_instr_boxplot_predpr.pdf', width = 9, height = 6)
# gridExtra::grid.arrange(cowplot::plot_grid(pinstrdif, pinstrpred + theme(legend.position = 'none'), nrow=1, rel_widths = c(3,7), align = 'h'),legendpinstrpred, nrow=2,heights=c(10, 1))
# dev.off()

## relative plot
pinstrpredrel <- ggplot(dyads, aes(x = instrumentpref, y = pr_relative))+ 
  #geom_point(alpha = .3, size = 1, fill = 'grey75', color = 'grey75') + 
  geom_smooth(aes(color = country), method = 'loess', se = TRUE, span = 3) +
  scale_color_manual("", values = c('CH' = "#D7191C", #'firebrick1', 
                                    'DE' = '#FDAE61', #'gold',
                                    'FR' = '#2B83BA', #'dodgerblue2', 
                                    'NL' = 'springgreen3')) +
  ylab("Relative probability of a tie\n(baseline probability of tie held at 0%)") +
  xlab("Average differences in instrument preferences") +
  publicationtheme +
  scale_y_continuous(label = percent) + 
  theme(panel.grid.major.x = element_line(colour="#f0f0f0")) +
  theme(legend.key=element_blank()) +
  guides(color=guide_legend(override.aes=list(fill=NA))) +
  theme(legend.key = element_blank())
# ggsave(pinstrpredrel, file = '1_Analysis/output/fig_Edgeprob_InstrPrefdiff_smoothed_relative.pdf', 
#        width = 22, height = 16, units = 'cm')

## combine the relative plot with the boxplot
# function to save the legend
legendpbeliefpred <- g_legend(pinstrpredrel)
# plot
pdf('1_Analysis/output/SIFIG5_instrument_boxplot_predpr_relative.pdf', width = 7.8, height = 5.8)
gridExtra::grid.arrange(cowplot::plot_grid(pinstrdif, pinstrpredrel + theme(legend.position = 'none'), 
                                           nrow=1, rel_widths = c(3,7), align = 'h'),
                        legendpbeliefpred, nrow=2,heights=c(10, 1))
dev.off()
##output: Figure 5 in the SI Online

################################################################################
## Summary table for belief variables
################################################################################

tabbeliefs <- data.frame("variables" = c('Measures should address the sources of pollution', 'Measures should be end-of-pipe (waste-water treatment)', 'Preventive measures should be taken to reduce potential risks for humans and the environment (precautionary principle)', 'It is reasonable to wait with policy measures until the impact of micropollution is fully understood', 'Policy measures should aim at completely eliminating pharmaceutical micropollution in waters'), 
                         "min" = c(min(c(attCH$source, attDE$source, attFR$source, attNL$source), na.rm = TRUE), min(c(attCH$endofpipe, attDE$endofpipe, attFR$endofpipe, attNL$endofpipe), na.rm = TRUE), min(c(attCH$prevent, attDE$prevent, attFR$prevent, attNL$prevent), na.rm = TRUE), min(c(attCH$wait, attDE$wait, attFR$wait, attNL$wait), na.rm = TRUE), min(c(attCH$eliminate, attDE$eliminate, attFR$eliminate, attNL$eliminate), na.rm = TRUE)), 
                         "max" = c(max(c(attCH$source, attDE$source, attFR$source, attNL$source), na.rm = TRUE), max(c(attCH$endofpipe, attDE$endofpipe, attFR$endofpipe, attNL$endofpipe), na.rm = TRUE), max(c(attCH$prevent, attDE$prevent, attFR$prevent, attNL$prevent), na.rm = TRUE), max(c(attCH$wait, attDE$wait, attFR$wait, attNL$wait), na.rm = TRUE), max(c(attCH$eliminate, attDE$eliminate, attFR$eliminate, attNL$eliminate), na.rm = TRUE)), 
                         "mean" = c(mean(c(attCH$source, attDE$source, attFR$source, attNL$source), na.rm = TRUE), mean(c(attCH$endofpipe, attDE$endofpipe, attFR$endofpipe, attNL$endofpipe), na.rm = TRUE), mean(c(attCH$prevent, attDE$prevent, attFR$prevent, attNL$prevent), na.rm = TRUE), mean(c(attCH$wait, attDE$wait, attFR$wait, attNL$wait), na.rm = TRUE), mean(c(attCH$eliminate, attDE$eliminate, attFR$eliminate, attNL$eliminate), na.rm = TRUE)), 
                         "mean CH" = c(mean(attCH$source, na.rm = TRUE), mean(attCH$endofpipe, na.rm = TRUE), mean(attCH$prevent, na.rm = TRUE), mean(attCH$wait, na.rm = TRUE), mean(attCH$eliminate, na.rm = TRUE)), 
                         "mean DE" = c(mean(attDE$source, na.rm = TRUE), mean(attDE$endofpipe, na.rm = TRUE), mean(attDE$prevent, na.rm = TRUE), mean(attDE$wait, na.rm = TRUE), mean(attDE$eliminate, na.rm = TRUE)), 
                         "mean FR" = c(mean(attFR$source, na.rm = TRUE), mean(attFR$endofpipe, na.rm = TRUE), mean(attFR$prevent, na.rm = TRUE), mean(attFR$wait, na.rm = TRUE), mean(attFR$eliminate, na.rm = TRUE)), 
                         "mean NL" = c(mean(attNL$source, na.rm = TRUE), mean(attNL$endofpipe, na.rm = TRUE), mean(attNL$prevent, na.rm = TRUE), mean(attNL$wait, na.rm = TRUE), mean(attNL$eliminate, na.rm = TRUE)), 
                         "n missings" = c(sum(is.na(c(attCH$source, attDE$source, attFR$source, attNL$source))), sum(is.na(c(attCH$endofpipe, attDE$endofpipe, attFR$endofpipe, attNL$endofpipe))), sum(is.na(c(attCH$prevent, attDE$prevent, attFR$prevent, attNL$prevent))), sum(is.na(c(attCH$wait, attDE$wait, attFR$wait, attNL$wait))), sum(is.na(c(attCH$eliminate, attDE$eliminate, attFR$eliminate, attNL$eliminate))) )
)
xtable::xtable(tabbeliefs)
## Table 1 in the SI Online

tabbeinstruments<- data.frame("variables" = c('Bans or authorization restrictions of single pharmaceutical substances', 'Discharge requirements for products containing pharmaceutical substances', 'Use of best available technique (BAT) for the elimination of pharmaceutical micropollution (e.g. technically upgrading wastewater treatment plants, treatment of wastewater partial flows in companies or hospitals)', 'Definition of emission limits for micropollutants', 'Product charge for pharmaceuticals', 'Increase of the wastewater charge to fund measures for the reduction of pharmaceutical micropollution', 'Subsidies (e.g. for investments in filtering technology or monitoring technology, optimization of production processes)', 'Information campaigns, consulting', 'Research'), 
                              "min" = c(min(c(attCH$q1, attDE$q1, attFR$q1, attNL$q1), na.rm = TRUE), min(c(attCH$q3, attDE$q3, attFR$q3, attNL$q3), na.rm = TRUE), min(c(attCH$q4, attDE$q4, attFR$q4, attNL$q4), na.rm = TRUE), min(c(attCH$q7, attDE$q7, attFR$q7, attNL$q7), na.rm = TRUE), min(c(attCH$q8, attDE$q8, attFR$q8, attNL$q8), na.rm = TRUE), min(c(attCH$q9, attDE$q9, attFR$q9, attNL$q9), na.rm = TRUE), min(c(attCH$q10, attDE$q10, attFR$q10, attNL$q10), na.rm = TRUE), min(c(attCH$q13, attDE$q13, attFR$q13, attNL$q13), na.rm = TRUE), min(c(attCH$q14, attDE$q14, attFR$q14, attNL$q14), na.rm = TRUE) ), 
                              "max" = c(max(c(attCH$q1, attDE$q1, attFR$q1, attNL$q1), na.rm = TRUE), max(c(attCH$q3, attDE$q3, attFR$q3, attNL$q3), na.rm = TRUE), max(c(attCH$q4, attDE$q4, attFR$q4, attNL$q4), na.rm = TRUE), max(c(attCH$q7, attDE$q7, attFR$q7, attNL$q7), na.rm = TRUE), max(c(attCH$q8, attDE$q8, attFR$q8, attNL$q8), na.rm = TRUE), max(c(attCH$q9, attDE$q9, attFR$q9, attNL$q9), na.rm = TRUE), max(c(attCH$q10, attDE$q10, attFR$q10, attNL$q10), na.rm = TRUE),max(c(attCH$q13, attDE$q13, attFR$q13, attNL$q13), na.rm = TRUE), max(c(attCH$q14, attDE$q14, attFR$q14, attNL$q14), na.rm = TRUE) ), 
                              "mean" = c(mean(c(attCH$q1, attDE$q1, attFR$q1, attNL$q1), na.rm = TRUE), mean(c(attCH$q3, attDE$q3, attFR$q3, attNL$q3), na.rm = TRUE), mean(c(attCH$q4, attDE$q4, attFR$q4, attNL$q4), na.rm = TRUE), mean(c(attCH$q7, attDE$q7, attFR$q7, attNL$q7), na.rm = TRUE), mean(c(attCH$q8, attDE$q8, attFR$q8, attNL$q8), na.rm = TRUE), mean(c(attCH$q9, attDE$q9, attFR$q9, attNL$q9), na.rm = TRUE), mean(c(attCH$q10, attDE$q10, attFR$q10, attNL$q10), na.rm = TRUE),mean(c(attCH$q13, attDE$q13, attFR$q13, attNL$q13), na.rm = TRUE), mean(c(attCH$q14, attDE$q14, attFR$q14, attNL$q14), na.rm = TRUE) ), 
                              "mean CH" = c(mean(attCH$q1, na.rm = TRUE), mean(attCH$q3, na.rm = TRUE), mean(attCH$q4, na.rm = TRUE), mean(attCH$q7, na.rm = TRUE), mean(attCH$q8, na.rm = TRUE), mean(attCH$q9, na.rm = TRUE), mean(attCH$q10, na.rm = TRUE), mean(attCH$q13, na.rm = TRUE), mean(attCH$q14, na.rm = TRUE)), 
                              "mean DE" = c(mean(attDE$q1, na.rm = TRUE), mean(attDE$q3, na.rm = TRUE), mean(attDE$q4, na.rm = TRUE), mean(attDE$q7, na.rm = TRUE), mean(attDE$q8, na.rm = TRUE), mean(attDE$q9, na.rm = TRUE), mean(attDE$q10, na.rm = TRUE), mean(attDE$q13, na.rm = TRUE), mean(attDE$q14, na.rm = TRUE)), 
                              "mean FR" = c(mean(attFR$q1, na.rm = TRUE), mean(attFR$q3, na.rm = TRUE), mean(attFR$q4, na.rm = TRUE), mean(attFR$q7, na.rm = TRUE), mean(attFR$q8, na.rm = TRUE), mean(attFR$q9, na.rm = TRUE), mean(attFR$q10, na.rm = TRUE), mean(attFR$q13, na.rm = TRUE), mean(attFR$q14, na.rm = TRUE)), 
                              "mean NL" = c(mean(attNL$q1, na.rm = TRUE), mean(attNL$q3, na.rm = TRUE), mean(attNL$q4, na.rm = TRUE), mean(attNL$q7, na.rm = TRUE), mean(attNL$q8, na.rm = TRUE), mean(attNL$q9, na.rm = TRUE), mean(attNL$q10, na.rm = TRUE), mean(attNL$q13, na.rm = TRUE), mean(attNL$q14, na.rm = TRUE)), 
                              "n missings" = c(sum(is.na(c(attCH$q1, attDE$q1, attFR$q1, attNL$q1))), sum(is.na(c(attCH$q3, attDE$q3, attFR$q3, attNL$q3))), sum(is.na(c(attCH$q4, attDE$q4, attFR$q4, attNL$q4))), sum(is.na(c(attCH$q7, attDE$q7, attFR$q7, attNL$q7))), sum(is.na(c(attCH$q8, attDE$q8, attFR$q8, attNL$q8))), sum(is.na(c(attCH$q9, attDE$q9, attFR$q9, attNL$q9))),  sum(is.na(c(attCH$q10, attDE$q10, attFR$q10, attNL$q10))), sum(is.na(c(attCH$q13, attDE$q13, attFR$q13, attNL$q13))), sum(is.na(c(attCH$q14, attDE$q14, attFR$q14, attNL$q14))))
)
xtable::xtable(tabbeinstruments)
## Table 2 in the SI Online

################################################################################
## Opponents & Belief-Dissimilarity
################################################################################

dyads$opp_named <- ifelse(dyads$opp == 1, 'collaborator +\nopponent', 'collaborator')
ggplot(dyads[dyads$tie == 1,], aes(x = factor(opp_named), y = beliefsim))+
  geom_boxplot() +
  theme(axis.text.x = element_text(angle=45,vjust=1,hjust=1))+
  facet_wrap(~country, nrow = 1) +
  publicationtheme +
  ylab("Belief dissimilarity\n(absolute difference, 0 = similar beliefs)")+ 
  xlab("")
ggsave(file = '1_Analysis/output/SIFIG2_beliefsim_namedasopponents.pdf', 
       width = 22, height = 16, units = 'cm')
##output: Figure 2 in the SI Online

## t.tests
t.test(beliefsim ~ opp, data = dyads[dyads$country == 'CH' & dyads$tie == 1,])
t.test(beliefsim ~ opp, data = dyads[dyads$country == 'DE' & dyads$tie == 1,])
t.test(beliefsim ~ opp, data = dyads[dyads$country == 'FR' & dyads$tie == 1,])
t.test(beliefsim ~ opp, data = dyads[dyads$country == 'NL' & dyads$tie == 1,])

################################################################################
## Save
################################################################################

save.image(file = '1_Analysis/output/dataoutput_full.RData')
