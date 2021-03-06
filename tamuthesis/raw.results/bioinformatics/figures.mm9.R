## edgeR figures plotting
## Clear workspace
rm(list=ls(all=T))

## Load libraries
library(ggplot2)
library(gplots)
library(dplyr)
library(devtools)

## Unstranded analysis
## Load data

heartVhippo <- read.table("DE.unstranded_heartVShippo.mm9.csv", header = T, sep="\t")
heartVliver <- read.table("DE.unstranded_heartVSliver.mm9.csv", header = T, sep="\t")
heartVlung  <- read.table("DE.unstranded_heartVSlung.mm9.csv", header = T, sep="\t")
hippoVliver <- read.table("DE.unstranded_hippoVSliver.mm9.csv", header = T, sep="\t")
hippoVlung  <- read.table("DE.unstranded_hippoVSlung.mm9.csv", header = T, sep="\t")

## Select data by strand and omit antisense transcript 8 from analysis
anti.hehi  <- subset(heartVhippo, Strand=="-", select=c(GeneID,logFC,logCPM,PValue,FDR))
anti.hehi  <- anti.hehi[ which(anti.hehi$GeneID != "MSTRG.2448.8"),]
sense.hehi <- subset(heartVhippo, Strand=="+", select=c(GeneID,logFC,logCPM,PValue,FDR))
sense.hehi <- sense.hehi[ which(sense.hehi$GeneID != "MSTRG.2451.1" &
                                sense.hehi$GeneID != "MSTRG.2451.2" &
                                sense.hehi$GeneID != "MSTRG.2451.3" &
                                sense.hehi$GeneID != "MSTRG.2451.4" &
                                sense.hehi$GeneID != "MSTRG.2451.6"),]
anti.hehi$logFC  <- anti.hehi$logFC * -1

anti.heli  <- subset(heartVliver, Strand=="-", select=c(GeneID,logFC,logCPM,PValue,FDR))
anti.heli  <- anti.heli[ which(anti.heli$GeneID != "MSTRG.2448.8"),]
sense.heli <- subset(heartVliver, Strand=="+", select=c(GeneID,logFC,logCPM,PValue,FDR))
sense.heli <- sense.heli[ which(sense.heli$GeneID != "MSTRG.2451.1" &
                                sense.heli$GeneID != "MSTRG.2451.2" &
                                sense.heli$GeneID != "MSTRG.2451.3" &
                                sense.heli$GeneID != "MSTRG.2451.4" &
                                sense.heli$GeneID != "MSTRG.2451.6"),]

anti.helu  <- subset(heartVlung, Strand=="-", select=c(GeneID,logFC,logCPM,PValue,FDR))
anti.helu  <- anti.helu[ which(anti.helu$GeneID != "MSTRG.2448.8"),]
sense.helu <- subset(heartVlung, Strand=="+", select=c(GeneID,logFC,logCPM,PValue,FDR))
sense.helu <- sense.helu[ which(sense.helu$GeneID != "MSTRG.2451.1" &
                                sense.helu$GeneID != "MSTRG.2451.2" &
                                sense.helu$GeneID != "MSTRG.2451.3" &
                                sense.helu$GeneID != "MSTRG.2451.4" &
                                sense.helu$GeneID != "MSTRG.2451.6"),]

anti.hili  <- subset(hippoVliver, Strand=="-", select=c(GeneID,logFC,logCPM,PValue,FDR))
anti.hili  <- anti.hili[ which(anti.hili$GeneID != "MSTRG.2448.8"),]
sense.hili <- subset(hippoVliver, Strand=="+", select=c(GeneID,logFC,logCPM,PValue,FDR))
sense.hili <- sense.hili[ which(sense.hili$GeneID != "MSTRG.2451.1" &
                                sense.hili$GeneID != "MSTRG.2451.2" &
                                sense.hili$GeneID != "MSTRG.2451.3" &
                                sense.hili$GeneID != "MSTRG.2451.4" &
                                sense.hili$GeneID != "MSTRG.2451.6"),]

anti.hilu  <- subset(hippoVlung, Strand=="-", select=c(GeneID,logFC,logCPM,PValue,FDR))
anti.hilu  <- anti.hilu[ which(anti.hilu$GeneID != "MSTRG.2448.8"),]
sense.hilu <- subset(hippoVlung, Strand=="+", select=c(GeneID,logFC,logCPM,PValue,FDR))
sense.hilu <- sense.hilu[ which(sense.hilu$GeneID != "MSTRG.2451.1" &
                                sense.hilu$GeneID != "MSTRG.2451.2" &
                                sense.hilu$GeneID != "MSTRG.2451.3" &
                                sense.hilu$GeneID != "MSTRG.2451.4" &
                                sense.hilu$GeneID != "MSTRG.2451.6"),]

## Open device for figure output.
pdf(file="unstranded_output2.mm9.pdf", width=12, height=7)

## Set margins for graph
par(mar=c(8.2,4.5,3.8,1))

## par(mfrow=c(1,3))
barplot(anti.hehi$logFC, main = "DE: Hippocampus VS Heart", pch = 19, ylab = "log2(FC)", ylim=c(-3,0), names.arg=anti.hehi$GeneID, las = 2, col=1)
abline(h=-2,lty=3)
barplot(anti.hili$logFC, main = "DE: Hippocampus VS Liver", pch = 19, ylab = "log2(FC)", ylim=c(-3,0), names.arg=anti.hili$GeneID, las = 2, col=3)
abline(h=-2,lty=3)
barplot(anti.hilu$logFC, main = "DE: Hippocampus VS Lung", pch = 19, ylab = "log2(FC)", ylim=c(-3,0), names.arg=anti.hilu$GeneID, las = 2, col=4)
abline(h=-2,lty=3)

## ## par(mfrow=c(1,2))
## barplot(anti.heli$logFC, main = "DE: Heart VS Liver", pch = 19, ylab = "log2(FC)", ylim=c(-2,0), names.arg=anti.heli$GeneID, las = 2, col=2)
## abline(h=-2,lty=3)
## barplot(anti.helu$logFC, main = "DE: Heart VS Lung", pch = 19, ylab = "log2(FC)", ylim=c(-2,0), names.arg=anti.helu$GeneID, las = 2, col=5)
## abline(h=-2,lty=3)

## ## par(mfrow=c(1,3))
## barplot(sense.hehi$logFC, main = "DE: Heart VS Hippocampus", pch = 19, ylab = "log2(FC)", ylim=c(0,4), names.arg=sense.hehi$GeneID, las = 2, col=1)
## abline(h=2,lty=3)
## barplot(sense.hili$logFC, main = "DE: Hippocampus VS Liver", pch = 19, ylab = "log2(FC)", ylim=c(-4,0), names.arg=sense.hili$GeneID, las = 2, col=3)
## abline(h=-2,lty=3)
## barplot(sense.hilu$logFC, main = "DE: Hippocampus VS Lung", pch = 19, ylab = "log2(FC)", ylim=c(-4,0), names.arg=sense.hilu$GeneID, las = 2, col=4)
## abline(h=-2,lty=3)

## ## par(mfrow=c(1,2))
## barplot(sense.heli$logFC, main = "DE: Heart VS Liver", pch = 19, ylab = "log2(FC)", ylim=c(-2,0), names.arg=sense.heli$GeneID, las = 2, col=2)
## abline(h=-2,lty=3)
## barplot(sense.helu$logFC, main = "DE: Heart VS Lung", pch = 19, ylab = "log2(FC)", ylim=c(-2,0), names.arg=sense.helu$GeneID, las = 2, col=5)
## abline(h=-2,lty=3)

dev.off()

## ## Stranded analysis
## ## Load data

## corVcere    <- read.table("DE_stranded_cortexVScerebellum_full.tsv", header = T, sep="\t")
## corVfrtlob  <- read.table("DE_stranded_cortexVSfrt.lobe_full.tsv", header = T, sep="\t")
## frtlobVcere <- read.table("DE_stranded_frt.lobeVScerebellum_full.tsv", header = T, sep="\t")

## ## Select data by strand and omit antisense transcript 8 from analysis
## anti.coce  <- subset(corVcere, Strand=="-", select=c(GeneID,logFC,logCPM,PValue,FDR))
## anti.coce  <- anti.coce[ which(anti.coce$GeneID != "MSTRG.2448.8"),]
## sense.coce <- subset(corVcere, Strand=="+", select=c(GeneID,logFC,logCPM,PValue,FDR))
## sense.coce <- sense.coce[ which(sense.coce$GeneID != "MSTRG.2451.1" &
##                                 sense.coce$GeneID != "MSTRG.2451.2" &
##                                 sense.coce$GeneID != "MSTRG.2451.3" &
##                                 sense.coce$GeneID != "MSTRG.2451.4" &
##                                 sense.coce$GeneID != "MSTRG.2451.6"),]

## anti.cofl  <- subset(corVfrtlob, Strand=="-", select=c(GeneID,logFC,logCPM,PValue,FDR))
## anti.cofl  <- anti.cofl[ which(anti.cofl$GeneID != "MSTRG.2448.8"),]
## sense.cofl <- subset(corVfrtlob, Strand=="+", select=c(GeneID,logFC,logCPM,PValue,FDR))
## sense.cofl <- sense.cofl[ which(sense.cofl$GeneID != "MSTRG.2451.1" &
##                                 sense.cofl$GeneID != "MSTRG.2451.2" &
##                                 sense.cofl$GeneID != "MSTRG.2451.3" &
##                                 sense.cofl$GeneID != "MSTRG.2451.4" &
##                                 sense.cofl$GeneID != "MSTRG.2451.6"),]

## anti.flce  <- subset(frtlobVcere, Strand=="-", select=c(GeneID,logFC,logCPM,PValue,FDR))
## anti.flce  <- anti.flce[ which(anti.flce$GeneID != "MSTRG.2448.8"),]
## sense.flce <- subset(frtlobVcere, Strand=="+", select=c(GeneID,logFC,logCPM,PValue,FDR))
## sense.flce <- sense.flce[ which(sense.flce$GeneID != "MSTRG.2451.1" &
##                                 sense.flce$GeneID != "MSTRG.2451.2" &
##                                 sense.flce$GeneID != "MSTRG.2451.3" &
##                                 sense.flce$GeneID != "MSTRG.2451.4" &
##                                 sense.flce$GeneID != "MSTRG.2451.6"),]

## ## Open device for figure output.
## pdf(file="stranded_output.mm9.pdf")

## ## Set margins for graph
## par(mar=c(8.2,4.5,3.8,1))

## ## par(mfrow=c(1,3))
## barplot(anti.coce$logFC, main = "DE: Cortex VS Cerebellum", pch = 19, ylab = "log2(FC)", ylim=c(-2,2), names.arg=anti.coce$GeneID, las = 2, col=1)
## barplot(anti.cofl$logFC, main = "DE: Cortex VS Frontal Lobe", pch = 19, ylab = "log2(FC)", ylim=c(-2,2), names.arg=anti.cofl$GeneID, las = 2, col=2)
## barplot(anti.flce$logFC, main = "DE: Frontal Lobe VS Cerebellum", pch = 19, ylab = "log2(FC)", ylim=c(-2,2), names.arg=anti.flce$GeneID, las = 2, col=5)

## ## par(mfrow=c(1,3))
## barplot(sense.coce$logFC, main = "DE: Cortex VS Cerebellum", pch = 19, ylab = "log2(FC)", ylim=c(-3,3), names.arg=sense.coce$GeneID, las = 2, col=1)
## barplot(sense.cofl$logFC, main = "DE: Cortex VS Frontal Lobe", pch = 19, ylab = "log2(FC)", ylim=c(-2,2), names.arg=sense.cofl$GeneID, las = 2, col=2)
## barplot(sense.flce$logFC, main = "DE: Frontal Lobe VS Cerebellum", pch = 19, ylab = "log2(FC)", ylim=c(-2,2), names.arg=sense.flce$GeneID, las = 2, col=5)

## dev.off()

## ## Neurons analysis
## ## Load data

## vehVtopo1 <- read.table("DE.neurons_vehicleVStopotecan.csv", header = T, sep="\t")
## vehVtopo2 <- read.table("DE.neurons_compare.csv", header = T, sep="\t")

## ## Select data by strand and omit antisense transcript 8 from analysis
## anti.veto1  <- subset(vehVtopo1, Strand=="-", select=c(GeneID,logFC,logCPM,PValue,FDR))
## anti.veto1  <- anti.veto1[ which(anti.veto1$GeneID != "MSTRG.2448.8"),]
## sense.veto1 <- subset(vehVtopo1, Strand=="+", select=c(GeneID,logFC,logCPM,PValue,FDR))
## sense.veto1 <- sense.veto1[ which(sense.veto1$GeneID != "MSTRG.2451.1" &
##                                 sense.veto1$GeneID != "MSTRG.2451.2" &
##                                 sense.veto1$GeneID != "MSTRG.2451.3" &
##                                 sense.veto1$GeneID != "MSTRG.2451.4" &
##                                 sense.veto1$GeneID != "MSTRG.2451.6"),]

## anti.veto2  <- subset(vehVtopo2, Strand=="-", select=c(GeneID,logFC,logCPM,PValue,FDR))
## anti.veto2  <- anti.veto2[ which(anti.veto2$GeneID != "MSTRG.2448.8"),]
## sense.veto2 <- subset(vehVtopo2, Strand=="+", select=c(GeneID,logFC,logCPM,PValue,FDR))
## sense.veto2 <- sense.veto2[ which(sense.veto2$GeneID != "MSTRG.2451.1" &
##                                 sense.veto2$GeneID != "MSTRG.2451.2" &
##                                 sense.veto2$GeneID != "MSTRG.2451.3" &
##                                 sense.veto2$GeneID != "MSTRG.2451.4" &
##                                 sense.veto2$GeneID != "MSTRG.2451.6"),]

## ## Open device for figure output.
## pdf(file="neurons_output.mm9.pdf")

## ## Set margins for graph
## par(mar=c(8.2,4.5,3.8,1))

## barplot(anti.veto1$logFC, main = "DE: Vehicle VS Topotecan", pch = 19, ylab = "log2(FC)", ylim=c(-3,0), names.arg=anti.veto1$GeneID, las = 2, col=1)
## abline(h=-2,lty=3)
## barplot(anti.veto2$logFC, main = "DE: Vehicle VS Topotecan - Direct Compare", pch = 19, ylab = "log2(FC)", ylim=c(-3,0), names.arg=anti.veto2$GeneID, las = 2, col=2)
## abline(h=-2,lty=3)

## barplot(sense.veto1$logFC, main = "DE: Vehicle VS Topotecan", pch = 19, ylab = "log2(FC)", ylim=c(-3,0), names.arg=sense.veto1$GeneID, las = 2, col=1)
## abline(h=-2,lty=3)
## barplot(sense.veto2$logFC, main = "DE: Vehicle VS Topotecan - Direct Compare", pch = 19, ylab = "log2(FC)", ylim=c(-3,0), names.arg=sense.veto2$GeneID, las = 2, col=2)
## abline(h=-2,lty=3)

## dev.off()

## Celltype analysis
## Load data

## neunVastro  <- read.table("DE_celltype_neuronsVSastro_full.tsv", header = T, sep="\t")
## neunVopc    <- read.table("DE_celltype_neuronsVSopc_full.tsv", header = T, sep="\t")
## neunVnfo    <- read.table("DE_celltype_neuronsVSnfo_full.tsv", header = T, sep="\t")
## neunVmo     <- read.table("DE_celltype_neuronsVSmo_full.tsv", header = T, sep="\t")
## neunVmuglia <- read.table("DE_celltype_neuronsVSmicroglia_full.tsv", header = T, sep="\t")
## neunVendo   <- read.table("DE_celltype_neuronsVSendo_full.tsv", header = T, sep="\t")

## ## Select data by strand and omit antisense transcript 8 from analysis
## anti.neas  <- subset(neunVastro, Strand=="-", select=c(GeneID,logFC,logCPM,PValue,FDR))
## anti.neas  <- anti.neas[ which(anti.neas$GeneID != "MSTRG.2448.8"),]
## sense.neas <- subset(neunVastro, Strand=="+", select=c(GeneID,logFC,logCPM,PValue,FDR))
## sense.neas <- sense.neas[ which(sense.neas$GeneID != "MSTRG.2451.1" &
##                                 sense.neas$GeneID != "MSTRG.2451.2" &
##                                 sense.neas$GeneID != "MSTRG.2451.3" &
##                                 sense.neas$GeneID != "MSTRG.2451.4" &
##                                 sense.neas$GeneID != "MSTRG.2451.6"),]

## anti.neop  <- subset(neunVopc, Strand=="-", select=c(GeneID,logFC,logCPM,PValue,FDR))
## anti.neop  <- anti.neop[ which(anti.neop$GeneID != "MSTRG.2448.8"),]
## sense.neop <- subset(neunVopc, Strand=="+", select=c(GeneID,logFC,logCPM,PValue,FDR))
## sense.neop <- sense.neop[ which(sense.neop$GeneID != "MSTRG.2451.1" &
##                                 sense.neop$GeneID != "MSTRG.2451.2" &
##                                 sense.neop$GeneID != "MSTRG.2451.3" &
##                                 sense.neop$GeneID != "MSTRG.2451.4" &
##                                 sense.neop$GeneID != "MSTRG.2451.6"),]

## anti.nenf  <- subset(neunVnfo, Strand=="-", select=c(GeneID,logFC,logCPM,PValue,FDR))
## anti.nenf  <- anti.nenf[ which(anti.nenf$GeneID != "MSTRG.2448.8"),]
## sense.nenf <- subset(neunVnfo, Strand=="+", select=c(GeneID,logFC,logCPM,PValue,FDR))
## sense.nenf <- sense.nenf[ which(sense.nenf$GeneID != "MSTRG.2451.1" &
##                                 sense.nenf$GeneID != "MSTRG.2451.2" &
##                                 sense.nenf$GeneID != "MSTRG.2451.3" &
##                                 sense.nenf$GeneID != "MSTRG.2451.4" &
##                                 sense.nenf$GeneID != "MSTRG.2451.6"),]

## anti.nemo  <- subset(neunVmo, Strand=="-", select=c(GeneID,logFC,logCPM,PValue,FDR))
## anti.nemo  <- anti.nemo[ which(anti.nemo$GeneID != "MSTRG.2448.8"),]
## sense.nemo <- subset(neunVmo, Strand=="+", select=c(GeneID,logFC,logCPM,PValue,FDR))
## sense.nemo <- sense.nemo[ which(sense.nemo$GeneID != "MSTRG.2451.1" &
##                                 sense.nemo$GeneID != "MSTRG.2451.2" &
##                                 sense.nemo$GeneID != "MSTRG.2451.3" &
##                                 sense.nemo$GeneID != "MSTRG.2451.4" &
##                                 sense.nemo$GeneID != "MSTRG.2451.6"),]

## anti.nemg  <- subset(neunVmuglia, Strand=="-", select=c(GeneID,logFC,logCPM,PValue,FDR))
## anti.nemg  <- anti.nemg[ which(anti.nemg$GeneID != "MSTRG.2448.8"),]
## sense.nemg <- subset(neunVmuglia, Strand=="+", select=c(GeneID,logFC,logCPM,PValue,FDR))
## sense.nemg <- sense.nemg[ which(sense.nemg$GeneID != "MSTRG.2451.1" &
##                                 sense.nemg$GeneID != "MSTRG.2451.2" &
##                                 sense.nemg$GeneID != "MSTRG.2451.3" &
##                                 sense.nemg$GeneID != "MSTRG.2451.4" &
##                                 sense.nemg$GeneID != "MSTRG.2451.6"),]

## anti.neen  <- subset(neunVendo, Strand=="-", select=c(GeneID,logFC,logCPM,PValue,FDR))
## anti.neen  <- anti.neen[ which(anti.neen$GeneID != "MSTRG.2448.8"),]
## sense.neen <- subset(neunVendo, Strand=="+", select=c(GeneID,logFC,logCPM,PValue,FDR))
## sense.neen <- sense.neen[ which(sense.neen$GeneID != "MSTRG.2451.1" &
##                                 sense.neen$GeneID != "MSTRG.2451.2" &
##                                 sense.neen$GeneID != "MSTRG.2451.3" &
##                                 sense.neen$GeneID != "MSTRG.2451.4" &
##                                 sense.neen$GeneID != "MSTRG.2451.6"),]

## ## Open device for figure output.
## pdf(file="celltype_output.mm9.pdf")

## ## Set margins for graph
## par(mar=c(8.2,4.5,3.8,1))

## barplot(anti.neas$logFC, main = "DE: Neurons VS Astrocytes", pch = 19, ylab = "log2(FC)", ylim=c(-4,0), names.arg=anti.neas$GeneID, las = 2, col="burlywood4")
## abline(h=-2,lty=3)
## barplot(anti.neop$logFC, main = "DE: Neurons VS OPC", pch = 19, ylab = "log2(FC)", ylim=c(-4,0), names.arg=anti.neop$GeneID, las = 2, col="seagreen")
## abline(h=-2,lty=3)
## barplot(anti.nenf$logFC, main = "DE: Neurons VS NFO", pch = 19, ylab = "log2(FC)", ylim=c(-4,0), names.arg=anti.nenf$GeneID, las = 2, col="royalblue")
## abline(h=-2,lty=3)
## barplot(anti.nemo$logFC, main = "DE: Neurons VS MO", pch = 19, ylab = "log2(FC)", ylim=c(-4,0), names.arg=anti.nemo$GeneID, las = 2, col="firebrick")
## abline(h=-2,lty=3)
## barplot(anti.nemg$logFC, main = "DE: Neurons VS Microglia", pch = 19, ylab = "log2(FC)", ylim=c(-4,0), names.arg=anti.nemg$GeneID, las = 2, col="orange")
## abline(h=-2,lty=3)
## barplot(anti.neen$logFC, main = "DE: Neurons VS Endothelial", pch = 19, ylab = "log2(FC)", ylim=c(-4,0), names.arg=anti.neen$GeneID, las = 2, col="plum4")
## abline(h=-2,lty=3)

## barplot(sense.neas$logFC, main = "DE: Neurons VS Astrocytes", pch = 19, ylab = "log2(FC)", ylim=c(-4,0), names.arg=sense.neas$GeneID, las = 2, col="burlywood4")
## abline(h=-2,lty=3)
## barplot(sense.neop$logFC, main = "DE: Neurons VS OPC", pch = 19, ylab = "log2(FC)", ylim=c(-4,0), names.arg=sense.neop$GeneID, las = 2, col="seagreen")
## abline(h=-2,lty=3)
## barplot(sense.nenf$logFC, main = "DE: Neurons VS NFO", pch = 19, ylab = "log2(FC)", ylim=c(-4,0), names.arg=sense.nenf$GeneID, las = 2, col="royalblue")
## abline(h=-2,lty=3)
## barplot(sense.nemo$logFC, main = "DE: Neurons VS MO", pch = 19, ylab = "log2(FC)", ylim=c(-4,0), names.arg=sense.nemo$GeneID, las = 2, col="firebrick")
## abline(h=-2,lty=3)
## barplot(sense.nemg$logFC, main = "DE: Neurons VS Microglia", pch = 19, ylab = "log2(FC)", ylim=c(-4,0), names.arg=sense.nemg$GeneID, las = 2, col="orange")
## abline(h=-2,lty=3)
## barplot(sense.neen$logFC, main = "DE: Neurons VS Endothelial", pch = 19, ylab = "log2(FC)", ylim=c(-4,0), names.arg=sense.neen$GeneID, las = 2, col="plum4")
## abline(h=-2,lty=3)

## dev.off()
