---
output:
  pdf_document: default
---

# Replication files for "Policy networks across political systems"

## Purpose

The folders contain all replication files for the paper:

Metz, Florence and Laurence Brandenberger. 2021. Policy networks across political systems. American Journal of Political Science.

The R script is extensively commented to facilitate replication.
System requirements and package versions are documented in the following section. 

## Setup

### Operating system

The analysis was performed on a macOS 10.15.6 using R-Version 4.0.3.

### R-packages

The following R-packages (and verions) were used for the analysis: 

* network (version 1.16.1)
* sna (version 2.6)
* ergm (version 3.11.0)
* bergm (version 1.9.13)
* ggplot2 (version 3.3.3)
* GGally (version 2.1.0)
* tidyverse (version 1.3.0)
* mice (version 2.25)
* texreg (verion 1.37.5)
* readxl (version 1.3.1)
* latticeExtra (version 0.6-29)
* scales (version 1.1.1)
* gridExtra (version 2.3)
* cowplot (version 1.1.1)
* boot (version 1.3-27)
* combinat (version 0.0-8)

Additional dependencies include

* lattice_0.20-41
* Rcpp_1.0.6
* forcats_0.5.1
* stringr_1.4.0
* dplyr_1.0.4
* purrr_0.3.4
* readr_1.4.0
* tidyr_1.1.2 
* tibble_3.0.6
* xergm.common_1.7.8
* statnet.common_4.4.1
* usethis_2.0.1

To install the packages with the versions used for this analysis, you also need the package `devtools` (version 2.3.2).
The code to load packages with specific version numbers is included in the R-script. Since R-packages change frequently, please replicate with the package versions we used. 

Also: please note that the mice package needs to be loaded after the tidveryse package because in the version 2.25 of mice, there's a function called `complete()` that is also used by tidyverse. If tidyverse is loaded AFTER mice, this function is overwritten (also called `masked`) and the code will return an error. 

### Random seeds

The models we run (Exponential Random Graph Models, short ERGMs) depend on a random seed. This seed can be manually set for each ERGM-run. However, different R-versions have different seed bases. If you replicate without our exact specifications listed above, we cannot guarantee *exact* replication of our estimates. For your convenience, you can check if your random seeds are set differently by running lines 95-107 in the full_script.R. We include all our ERGM-models in case your seed differs, to ensure replication.

## Content

We include this README in three forms: a txt-file (requirement of the AJPS), an md-file as well as a PDF file (for easy readability).

* README_ReplicationMaterial.md
* README_ReplicationMaterial.txt
* README_ReplicationMaterial.pdf

File description are in parenthesis after the file names.

### 0_Data folder

The data folder contains an RData-file with raw data used for this analysis.
The PDF-file `Codebook_MetzBrandenberger2021.pdf` is a codebook and accounts for every data set and variable in the `data_prepared.RDdata`-file.

* 0_Data/data_prepared.RData (RData-file containing raw data)
* 0_Data/Codebook_MetzBrandenberger2021.pdf (codebook)

### 1_Analysis folder

The analysis folder contains: 

* full_script.R (full R script)
* InterpretationFunctions_Desmarais_Cranmer_2012.R (R script with interpretation function for predicted probabilities)
* output-Folder (folder with output files)
	* attributeData.RData (R data frame containing attribute data for every policy network.)
	* coordinates_nwplots.RData (R data frame containing coordinates for the network plots to facilitate exact replication)
	* dataoutput_full.RData (R data frame containing the final output, including processed data, ERGMs, GOFs, etc.)
	* edgeprobabilities.RData (R data frame containing edge probabilities)
	* FIG1_nw_collab_plusbar.pdf (Figure 1 in the article, PDF format)
	* FIG2_fit_ergmint.pdf (Figure 2 in the article, PDF format)
	* FIG3_ERGM_interaction.pdf (Figure 3 in the article, PDF format)
	* FIG4_popularity_relative_full.pdf (Figure 4 in the article, PDF format)
	* FIG5_prOpponentsOnly_relative_noFR.pdf (Figure 5 in the article, PDF format)
	* FIG6_belief_boxplot_predpr_relative_FRonly.pdf (Figure 6 in the article, PDF format)
	* SIFIG1_nw_collabOpponents_all.pdf (Figure 1 in the SI Online, PDF format)
	* SIFIG2_beliefsim_namedasopponents.pdf (Figure 2 in the SI Online, PDF format)
	* SIFIG3_fit_ergm_gof_CH_appendix.pdf (Figure 3 in the SI Online, PDF format)
	* SIFIG4_prOpponents_Gov_relative.pdf (Figure 4 in the SI Online, PDF format)
	* SIFIG5_instrument_boxplot_predpr_relative.pdf (Figure 5 in the SI Online, PDF format)
	* SIFIG6_boxplot_missingObs_Reputation.pdf (Figure 6 in the SI Online, PDF format)
	* SITAB3_ergms_interaction.tex (Table 3 in the SI Online, PDF format)
	* SITAB4_ergms.tex (Table 4 in the SI Online, PDF format)
	* SITAB5_ergms_CHonly.tex (Table 5 in the SI Online, PDF format)
	* SITAB6_ergms_missingObs.tex (Table 6 in the SI Online, PDF format)
	* ERGM_estimates (folder with ERGM outputs)
	  * fit1CH.RData (ERGM output, Swiss policy network, no interaction)
	  * fit1CHb.RData (ERGM output, Swiss policy network, no interaction, alternative specification)
	  * fit1DE.RData (ERGM output, German policy network, no interaction)
	  * fit1FR.RData (ERGM output, French policy network, no interaction)
	  * fit1NL.RData (ERGM output, Dutch policy network, no interaction)
	  * fit2CH_10.RData (ERGM output, Swiss policy network, robustness check missing data, 10% missing)
	  * fit2CH_20.RData (ERGM output, Swiss policy network, robustness check missing data, 20% missing)
	  * fit2CH_30.RData (ERGM output, Swiss policy network, robustness check missing data, 30% missing)
	  * fit2CH_40.RData (ERGM output, Swiss policy network, robustness check missing data, 40% missing)
	  * fit2CH.RData (ERGM output, Swiss policy network, with interaction)
	  * fit2DE.RData (ERGM output, German policy network, with interaction)
	  * fit2FR.RData (ERGM output, French policy network, with interaction)
	  * fit2NL.RData (ERGM output, Dutch policy network, with interaction)
	  
The analysis can be replicated by running the script `full_analysis.R`. Again: note the R and package versions.

We set a seed for every random draw. We set a seed for the mice imputation as well as for all ERGMs and for calculating predicted probabilities. 

The script first runs through the data read-in and data cleaning steps. 
Then we perform descriptive and bivariate analyses. 
Afterwards, we run ERGMs, perform goodness-of-fit tests, calculate predicted probabilities and create main results figures and tables. 
We run extensive robustness tests on our results (reported in the SI Online on the AJPS webpage). 

In addition to the figures and tests reported in the paper, we perform additional t-tests and compile additional figures in the analysis script. We opted for including these code lines as opposed to taking them out because they are not directly reported in the results. Even though the figures are compiled, we do not save these additional figures in the `output`-folder.
That way, the `output`-Folder is reserved for the printed figures and tables. 
Please note that the summary tables in the SI-Online are directly copied into the latex source code and were not written to a file.


## Contact

Analysis was performed by Laurence Brandenberger with data collected by Florence Metz. Please direct any questions regarding the analysis to Laurence Brandenberger (laurencebrandenberger@gmail.com).
