## Process 'bag of words model' for the 8chan 03-12-19 Selection:


install.packages("sentimentr")
library(sentimentr)
install.packages("quanteda")
library(quanteda)
library(socsci)
library(dplyr)
library(extrafont)
font_import()

glimpse(eightch19)
  

glimpse(eightch19_1)

##
##


eightch19_1 <- tokens(eightch19$body)


eightch19_2 <- eightch19_1 %>% 
  tokens_select(stopwords("en"),
                selection = "remove",
                min_nchar = 2)



## If you want min_termfreq:

eightch19_3 <- dfm(eightch19_2)


is.dfm(eightch19_3)

## make everything lower case and make it a dataframe and eliminate stopwords:

library(stopwords)

eightch19_4 <- eightch19_3 %>% 
  dfm(tolower = TRUE)

eightch19_5 <- eightch19_4 %>% 
  dfm_trim(min_termfreq = 900)

eightch19_6 <- eightch19_5 %>% 
  dfm_remove(pattern = c("like", "go", "one", "also",
                         "well", "xt", "way", "now",
                         "just", "get", "want", "even",
                         "thing", "still", "use", "can",
                         "magnet", "tri", "är", "på",
                         "en", "urn:btih", "last", "made",
                         "mani", "det", "actually", "always",
                         "got", "ever", "put", "really"))

eightch19_7 <- dfm(eightch19_6, remove = stopwords(source = "marimo"))
eightch19_7 <- dfm(eightch19_7, remove = stopwords())

nfeat(eightch19_7)
glimpse(eightch19_7)
nfeat(eightch19_7)
dim(eightch19_7)

topfeatures(eightch19_7, 180)

## Here's a wordcloud:

library(stopwords)

textplot_wordcloud(eightch19_7, max_words = 180,
                   font = "Calibri Light", adjust = 0,
                   color = rev(RColorBrewer::brewer.pal(10, "RdBu") 
                   ))

## Let's refine that a bit:

eightch19_9 <- eightch19_7 %>% 
  dfm_remove(pattern = c("like", "go", "one", "also",
                         "well", "xt", "way", "now",
                         "just", "get", "want", "even",
                         "thing", "still", "use", "can",
                         "magnet", "tri", "är", "på",
                         "en", "urn:btih", "att"))

textplot_wordcloud(eightch19_9, max_words = 400,
                   font = "Calibri Light", adjust = TRUE,
                   color = rev(RColorBrewer::brewer.pal(10, "RdBu"))
                   )


library(extrafont)
loadfonts(device = "win")
font_import()

##
##
##
##
##
## 



