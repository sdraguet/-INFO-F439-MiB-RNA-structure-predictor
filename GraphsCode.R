setwd("./Data")

library(ggplot2)
library(wesanderson)
library(dplyr)
library(hrbrthemes)
library(viridis)
library(ggExtra)

tRNAsizeValues <- read.csv("RF00005_sizeValues.csv", sep=';')
rRNAsizeValues <- read.csv("RF00001_sizeValues.csv", sep=';')
riboSizeValues <- read.csv("RF01739_sizeValues.csv", sep=';')

tRNAsizeStat <- read.csv("RF00005_sizeValuesStat.csv", sep=';')
rRNAsizeStat <- read.csv("RF00001_sizeValuesStat.csv", sep=';')
riboSizeStat <- read.csv("RF01739_sizeValuesStat.csv", sep=';')


# Bp per MSA size

df1 <- data.frame(Nseq = c(tRNAsizeStat$Nbre.seq, rRNAsizeStat$Nbre.seq, riboSizeStat$Nbre.seq),
                  Nbp = c(tRNAsizeStat$Nbre.paires, rRNAsizeStat$Nbre.paires, riboSizeStat$Nbre.paires),
                  Name = c(rep("tRNA", length(tRNAsizeStat$Nbre.seq)), 
                           rep("rRNA", length(rRNAsizeStat$Nbre.seq)), 
                           rep("Riboswitch", length(riboSizeStat$Nbre.seq))))

ggplot(df1, aes(x=Nseq, y=Nbp, color=Name, shape=Name)) +
  geom_point() + 
  geom_smooth(method=lm, se=FALSE, fullrange=TRUE)+
  scale_shape_manual(values=c(3, 16, 17))+ 
  scale_color_manual(values= c('#999999','#E69F00', '#56B4E9')) +
  #ggtitle("Influence of the dataset size on the number of positive basepairs") +
  ylab("Number of positive basepairs") +
  xlab("Number of sequences in the dataset") +
  scale_y_continuous(limits = c(0, 40), breaks = c(seq(0,40,10))) +
  scale_x_continuous(limits = c(0, 1000), breaks = c(seq(0,1000,200)))


### Size tRNA

# tRNAsize heatmap

df2 <- data.frame(Rbase = tRNAsizeValues$Right.base,
                  Lbase = tRNAsizeValues$Left.base)

df2b <- df2 %>%
  count(Rbase, Lbase) #new df with number of occ of bp

ggplot(df2b, aes(Rbase, Lbase, fill = n)) + 
  geom_tile() +
  scale_fill_gradient(low='deepskyblue', high='red') +
  ggtitle("A) tRNA") +
  ylab("Left base position") +
  xlab("Right base position") +
  labs(fill = "Occurence") +
  scale_y_continuous(limits = c(0, 150), breaks = c(seq(0,150,25))) +
  scale_x_continuous(limits = c(10, 190), breaks = c(seq(10,190,20)))

# tRNAsize distribution

df3 <- data.frame(Rbase = tRNAsizeValues$Right.base,
                  Lbase = tRNAsizeValues$Left.base,
                  Perc = as.factor(tRNAsizeValues$Sequence..))

p1 <- ggplot(df3, aes(x=Rbase, y=Lbase, color=Perc)) +
  geom_point(shape=0) + 
  ggtitle("A) tRNA") + #attention titre
  ylab("Left base position") +
  xlab("Right base position") +
  scale_y_continuous(limits = c(0, 150), breaks = c(seq(0,150,25))) +
  scale_x_continuous(limits = c(10, 190), breaks = c(seq(10,190,20))) +
  theme(legend.position="left", plot.title = element_text(size = 15)) 

ggMarginal(p1, type="histogram", color = "grey",fill = "lightgrey",
           xparams = list(bins=100), yparams = list(bins=100))

# boxplot eval tRNA

df4 <- data.frame(Evalues = tRNAsizeValues$E.value,
                  Perc = as.factor(tRNAsizeValues$Sequence..))

ggplot(df4, aes(x=Perc, y=Evalues, colour=Perc)) +
  geom_boxplot() +
  ggtitle("A) tRNA") +
  xlab("Percentage of sequences") +
  ylab("E-values") +
  theme(legend.position = "None")



### size rRNA

# rRNAsize heatmap

df5 <- data.frame(Rbase = rRNAsizeValues$Right.base,
                  Lbase = rRNAsizeValues$Left.base)

df5b <- df5 %>%
  count(Rbase, Lbase) #new df with number of occ of bp

ggplot(df5b, aes(Rbase, Lbase, fill = n)) + 
  geom_tile() +
  scale_fill_gradient(low='deepskyblue', high='red') +
  ggtitle("B) 5S rRNA") +
  ylab("Left base position") +
  xlab("Right base position") +
  labs(fill = "Occurence") +
  scale_y_continuous(limits = c(0, 180), breaks = c(seq(0,180,20))) +
  scale_x_continuous(limits = c(40, 230), breaks = c(seq(40,230,20)))

# rRNA size distribution

df6 <- data.frame(Rbase = rRNAsizeValues$Right.base,
                  Lbase = rRNAsizeValues$Left.base,
                  Perc = as.factor(rRNAsizeValues$Sequence..))

p2 <- ggplot(df6, aes(x=Rbase, y=Lbase, color=Perc)) +
  geom_point(shape=0) + 
  ggtitle("B) 5S rRNA") + #attention titre
  ylab("Left base position") +
  xlab("Right base position") +
  scale_y_continuous(limits = c(0, 180), breaks = c(seq(0,180,20))) +
  scale_x_continuous(limits = c(40, 230), breaks = c(seq(40,230,20))) +
  theme(legend.position="left", plot.title = element_text(size = 15)) 

ggMarginal(p2, type="histogram", color = "grey",fill = "lightgrey",
           xparams = list(bins=100), yparams = list(bins=100))

# boxplot eval rRNA

df7 <- data.frame(Evalues = rRNAsizeValues$E.value,
                  Perc = as.factor(rRNAsizeValues$Sequence..))

ggplot(df7, aes(x=Perc, y=Evalues, colour=Perc)) +
  geom_boxplot() +
  ggtitle("B) 5S rRNA") +
  xlab("Percentage of sequences") +
  ylab("E-values") +
  theme(legend.position = "None")



### riboswitch size

# ribo size heatmap

df8 <- data.frame(Rbase = riboSizeValues$Right.base,
                  Lbase = riboSizeValues$Left.base)

df8b <- df8 %>%
  count(Rbase, Lbase) #new df with number of occ of bp

ggplot(df8b, aes(Rbase, Lbase, fill = n)) + 
  geom_tile() +
  scale_fill_gradient(low='deepskyblue', high='red') +
  ggtitle("C) Glutamine riboswitch") +
  ylab("Left base position") +
  xlab("Right base position") +
  labs(fill = "Occurence") +
  scale_y_continuous(limits = c(0, 240), breaks = c(seq(0,240,20))) +
  scale_x_continuous(limits = c(40, 240), breaks = c(seq(40,240,20)))

# rRNA size distribution

df9 <- data.frame(Rbase = riboSizeValues$Right.base,
                  Lbase = riboSizeValues$Left.base,
                  Perc = as.factor(riboSizeValues$Sequence..))

p3 <- ggplot(df9, aes(x=Rbase, y=Lbase, color=Perc)) +
  geom_point(shape=0) + 
  ggtitle("C) Glutamine riboswitch") + #attention titre
  ylab("Left base position") +
  xlab("Right base position") +
  scale_y_continuous(limits = c(0, 240), breaks = c(seq(0,240,20))) +
  scale_x_continuous(limits = c(40, 240), breaks = c(seq(40,240,20))) +
  theme(legend.position="left", plot.title = element_text(size = 15)) 

ggMarginal(p3, type="histogram", color = "grey",fill = "lightgrey",
           xparams = list(bins=15), yparams = list(bins=15))

# boxplot eval rRNA

df10 <- data.frame(Evalues = riboSizeValues$E.value,
                  Perc = as.factor(riboSizeValues$Sequence..))

ggplot(df10, aes(x=Perc, y=Evalues, colour=Perc)) +
  geom_boxplot() +
  ggtitle("C) Glutamine riboswitch") +
  xlab("Percentage of sequences") +
  ylab("E-values") +
  theme(legend.position = "None")




tRNAseqValues <- read.csv("RF00005_seqValues.csv", sep=';')
rRNAseqValues <- read.csv("RF00001_seqValues.csv", sep=';')
riboSeqValues <- read.csv("RF01739_seqValues.csv", sep=';')

tRNAseqStat <- read.csv("RF00005_seqValuesStat.csv", sep=';')
rRNAseqStat <- read.csv("RF00001_seqValuesStat.csv", sep=';')
riboSeqStat <- read.csv("RF01739_seqValuesStat.csv", sep=';')

# Bp per MSA seq identity

df1_2 <- data.frame(Nseq = c(rep(c("A","B","C","D","E","F","G","H","I","J"), 3)),
                  Nbp = c(tRNAseqStat$Nbre.paires, rRNAseqStat$Nbre.paires, riboSeqStat$Nbre.paires),
                  Name = c(rep("tRNA", length(tRNAseqStat$Nbre.seq)), 
                           rep("rRNA", length(rRNAseqStat$Nbre.seq)), 
                           rep("Riboswitch", length(riboSeqStat$Nbre.seq))))

ggplot(df1_2, aes(x=Nseq, y=Nbp, color=Name, shape=Name)) +
  geom_point() +
  scale_shape_manual(values=c(3, 16, 17))+ 
  scale_color_manual(values= c('#999999','#E69F00', '#56B4E9')) +
  #ggtitle("Influence of the sequences on the number of positive basepairs") +
  ylab("Number of positive basepairs") +
  xlab("Index of the dataset") +
  scale_y_continuous(limits = c(0, 35), breaks = c(seq(0,35,10)))


### Seq tRNA

# tRNAsize heatmap

df2_2 <- data.frame(Rbase = tRNAseqValues$Right.base,
                  Lbase = tRNAseqValues$Left.base)

df2b_2 <- df2_2 %>%
  count(Rbase, Lbase) #new df with number of occ of bp

ggplot(df2b_2, aes(Rbase, Lbase, fill = n)) + 
  geom_tile() +
  scale_fill_gradient(low='deepskyblue', high='red') +
  ggtitle("A) tRNA") +
  ylab("Left base position") +
  xlab("Right base position") +
  labs(fill = "Occurence") +
  scale_y_continuous(limits = c(0, 140), breaks = c(seq(0,140,20))) +
  scale_x_continuous(limits = c(20, 170), breaks = c(seq(20,170,20)))

# tRNAsize distribution

df3_2 <- data.frame(Rbase = tRNAseqValues$Right.base,
                  Lbase = tRNAseqValues$Left.base,
                  Set = tRNAseqValues$Name)

p1_2 <- ggplot(df3_2, aes(x=Rbase, y=Lbase, color=Set)) +
  geom_point(shape=0) + 
  ggtitle("A) tRNA") + #attention titre
  ylab("Left base position") +
  xlab("Right base position") +
  scale_y_continuous(limits = c(0, 140), breaks = c(seq(0,140,20))) +
  scale_x_continuous(limits = c(20, 170), breaks = c(seq(20,170,20))) +
  theme(legend.position="left", 
        plot.title = element_text(size = 15, hjust=0),
        plot.title.position = "plot") 

ggMarginal(p1_2, type="histogram", color = "grey",fill = "lightgrey",
           xparams = list(bins=100), yparams = list(bins=100))

# boxplot eval tRNA

df4_2 <- data.frame(Evalues = tRNAseqValues$E.value,
                  Perc = as.factor(tRNAseqValues$Name))

ggplot(df4_2, aes(x=Perc, y=Evalues, colour=Perc)) +
  geom_boxplot() +
  ggtitle("A) tRNA") +
  xlab("Percentage of sequences") +
  ylab("E-values") + 
  theme(legend.position="none")


### seq rRNA

# rRNAsize heatmap

df5_2 <- data.frame(Rbase = rRNAseqValues$Right.base,
                  Lbase = rRNAseqValues$Left.base)

df5b_2 <- df5_2 %>%
  count(Rbase, Lbase) #new df with number of occ of bp

ggplot(df5b_2, aes(Rbase, Lbase, fill = n)) + 
  geom_tile() +
  scale_fill_gradient(low='deepskyblue', high='red') +
  ggtitle("B) 5S rRNA") +
  ylab("Left base position") +
  xlab("Right base position") +
  labs(fill = "Occurence") +
  scale_y_continuous(limits = c(0, 190), breaks = c(seq(0,190,30))) +
  scale_x_continuous(limits = c(60, 220), breaks = c(seq(60,220,20)))

# rRNA size distribution

df6_2 <- data.frame(Rbase = rRNAseqValues$Right.base,
                  Lbase = rRNAseqValues$Left.base,
                  Set = as.factor(rRNAseqValues$Name))

p2_2 <- ggplot(df6_2, aes(x=Rbase, y=Lbase, color=Set)) +
  geom_point(shape=0) + 
  ggtitle("B) 5S rRNA") + #attention titre
  ylab("Left base position") +
  xlab("Right base position") +
  scale_y_continuous(limits = c(0, 190), breaks = c(seq(0,190,30))) +
  scale_x_continuous(limits = c(60, 220), breaks = c(seq(60,220,20))) +
  theme(legend.position="left", plot.title = element_text(size = 15)) 

ggMarginal(p2_2, type="histogram", color = "grey",fill = "lightgrey",
           xparams = list(bins=100), yparams = list(bins=100))

# boxplot eval rRNA

df7_2 <- data.frame(Evalues = rRNAseqValues$E.value,
                  Set = as.factor(rRNAseqValues$Name))

ggplot(df7_2, aes(x=Set, y=Evalues, colour=Set)) +
  geom_boxplot() +
  ggtitle("B) 5S rRNA") +
  xlab("Dataset") +
  ylab("E-values") +
  theme(legend.position = "None")



### riboswitch size

# ribo size heatmap

df8_2 <- data.frame(Rbase = riboSeqValues$Right.base,
                  Lbase = riboSeqValues$Left.base)

df8b_2 <- df8_2 %>%
  count(Rbase, Lbase) #new df with number of occ of bp

ggplot(df8b_2, aes(Rbase, Lbase, fill = n)) + 
  geom_tile() +
  scale_fill_gradient(low='deepskyblue', high='red') +
  ggtitle("C) Glutamine riboswitch") +
  ylab("Left base position") +
  xlab("Right base position") +
  labs(fill = "Occurence") +
  scale_y_continuous(limits = c(0, 190), breaks = c(seq(0,190,20))) +
  scale_x_continuous(limits = c(30, 210), breaks = c(seq(30,210,20)))

# rRNA size distribution

df9_2 <- data.frame(Rbase = riboSeqValues$Right.base,
                  Lbase = riboSeqValues$Left.base,
                  Perc = as.factor(riboSeqValues$Name))

p3_2 <- ggplot(df9_2, aes(x=Rbase, y=Lbase, color=Perc)) +
  geom_point(shape=0) + 
  ggtitle("C) Glutamine riboswitch") + #attention titre
  ylab("Left base position") +
  xlab("Right base position") +
  scale_y_continuous(limits = c(0, 190), breaks = c(seq(0,190,20))) +
  scale_x_continuous(limits = c(30, 210), breaks = c(seq(30,210,20))) +
  theme(legend.position="left", plot.title = element_text(size = 15)) 

ggMarginal(p3_2, type="histogram", color = "grey",fill = "lightgrey",
           xparams = list(bins=15), yparams = list(bins=15))

# boxplot eval rRNA

df10_2 <- data.frame(Evalues = riboSeqValues$E.value,
                   Perc = as.factor(riboSeqValues$Name))

ggplot(df10_2, aes(x=Perc, y=Evalues, colour=Perc)) +
  geom_boxplot() +
  ggtitle("C) Glutamine riboswitch") +
  xlab("Dataset") +
  ylab("E-values") +
  theme(legend.position = "None")
                       