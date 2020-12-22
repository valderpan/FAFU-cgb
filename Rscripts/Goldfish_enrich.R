# ��װclusterprofiler���R��
if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

BiocManager::install("clusterProfiler")

setwd("C:/Users/dell/Desktop/Goldfish/enrich")
# ��ȡGOע���ļ�
go <- read.csv("go_annot_gene.csv",sep=",",quote = "",header = F)
# ��ȡKEGGע���ļ�
kegg <- read.table("suger_kegg_annot.txt",sep="\t",quote="")
# ��ȡ��������б�
gene <- read.table("B12-C.id")
head(go)
head(kegg)
head(gene)
# ����TERM2GENE
go_term2gene <- data.frame(go$V1,go$V4)
kegg_term2gene <- data.frame(kegg$V2,kegg$V1)
# ����TERM2NAME
go_term2name <- data.frame(go$V1,go$V2)
names(go_term2gene) <- c("go_term","gene")
names(go_term2name) <- c("go_term","name")
kegg_term2name <- data.frame(kegg$V2,kegg$V3)
names(kegg_term2gene) <- c("ko_term","gene")
names(kegg_term2name) <- c("ko_term","name")
# �鿴����
head(go_term2gene)
head(go_term2name)
head(kegg_term2gene)
head(kegg_term2name)
gene <- as.vector(gene$V1)
head(gene)
# ʹ��enrichr��������GO��������
library(clusterProfiler)
go_enrich <- enricher(gene=gene,pvalueCutoff = 0.05,pAdjustMethod = "BH",TERM2GENE = go_term2gene,TERM2NAME = go_term2name)
head(as.data.frame(go_enrich))
write.csv(as.data.frame(go_enrich),"Bite-12h_vs_C0h_GO_enrichment.csv",row.names = F)
barplot(go_enrich,showCategory=20)
dotplot(go_enrich,showCategory=20)
## categorySize can be scaled by 'pvalue' or 'geneNum'
cnetplot(go_enrich, categorySize="pvalue")


# ʹ��enrichr��������KEGG�ĸ�������
kegg_enrich <- enricher(gene=gene,pvalueCutoff = 0.05,pAdjustMethod = "BH",TERM2GENE = kegg_term2gene,TERM2NAME = kegg_term2name)
head(as.data.frame(kegg_enrich))
write.csv(as.data.frame(kegg_enrich),"MeTA-12h_vs_MeTA-24h_KEGG_enrichment.csv",row.names = F)
barplot(kegg_enrich,showCategory=20)
dotplot(kegg_enrich,showCategory=20)
## categorySize can be scaled by 'pvalue' or 'geneNum'
cnetplot(kegg_enrich, categorySize="pvalue", foldChange = 0.01, fixed = TRUE)



###��һ���汾��
library(clusterProfiler)
# install.packages('colorspace')
# library(clusterProfiler)
setwd("C:/Users/dell/Desktop/Goldfish/enrich")
# go <- read.csv("go_annotation.csv",sep = ',',quote="",header = F)
# gene <- read.csv("gene_diffgene.csv")
go <- read.table("go_annotation.txt",sep ='\t',quote="")
gene <- read.table("gene_diffgene.txt")
head(go)
head(gene)
go_term2gene <- data.frame(go$V1,go$V4)
go_term2name <- data.frame(go$V1,go$V2)
names(go_term2gene) <- c("go_term","gene")
names(go_term2name) <- c("go_term","name")
gene <- as.vector(gene$V1)
go_enrich <- enricher(gene=gene,pvalueCutoff = 0.1,pAdjustMethod = "BH",TERM2GENE = go_term2gene,TERM2NAME = go_term2name)
head(as.data.frame(go_enrich))
write.csv(as.data.frame(go_enrich),"Bite-12h_vs_C0h_GO_enrichment.csv",row.names = F)
# go_enrich <- enricher(gene=gene,pvalueCutoff = 0.1,pAdjustMethod = "BH",TERM2GENE = go_term2gene,TERM2NAME = go_term2name)
barplot(go_enrich,showCategory=20)
dotplot(go_enrich,showCategory=20)
## categorySize can be scaled by 'pvalue' or 'geneNum'
cnetplot(go_enrich, categorySize="pvalue")