## Process 'bag of words model' for the 8chan 03-12-19 Selection:
##
## Import the libraries:
##

install.packages("sentimentr")
library(sentimentr)
install.packages("quanteda")
library(quanteda)
library(socsci)
library(dplyr)
library(extrafont)
font_import()
loadfonts(device = "win")

glimpse(eightch19)
  

glimpse(eightch19_1)

##
##

## Lets tokenize this:

eightch19_1 <- tokens(eightch19$body)


## Remove all single letter occurances:

eightch19_2 <- eightch19_1 %>% 
  tokens_select(stopwords("en"),
                selection = "remove",
                min_nchar = 2)



## 
## This is redundant, but do it anyway:

eightch19_3 <- dfm(eightch19_2)
is.dfm(eightch19_3)


## make everything lower case and make it a dataframe and eliminate stopwords:

library(stopwords)


## To lowercase:

eightch19_4 <- eightch19_3 %>% 
  dfm(tolower = TRUE)


## Minimum term frequency:

eightch19_5 <- eightch19_4 %>% 
  dfm_trim(min_termfreq = 900)


## Remove some of the other patterns:

eightch19_6 <- eightch19_5 %>% 
  dfm_remove(pattern = c("like", "go", "one", "also",
                         "well", "xt", "way", "now",
                         "just", "get", "want", "even",
                         "thing", "still", "use", "can",
                         "magnet", "tri", "är", "på",
                         "en", "urn:btih", "last", "made",
                         "mani", "det", "actually", "always",
                         "got", "ever", "put", "really"
                        ))


## Extra stopword refinement:

eightch19_7 <- dfm(eightch19_6, remove = stopwords(source = "marimo"))
eightch19_7 <- dfm(eightch19_7, remove = stopwords())


## Take a look at the data:

nfeat(eightch19_7)
glimpse(eightch19_7)
dim(eightch19_7)

topfeatures(eightch19_7, 180)


## Here's a wordcloud:

library(stopwords)

textplot_wordcloud(eightch19_7, max_words = 180,
                   font = "Calibri Light", adjust = 0,
                   color = rev(RColorBrewer::brewer.pal(10, "RdBu") 
                   ))


## Let's refine that a bit:
## Some redundancy here, but do it anyway:


eightch19_9 <- eightch19_7 %>% 
  dfm_remove(pattern = c("like", "go", "one", "also",
                         "well", "xt", "way", "now",
                         "just", "get", "want", "even",
                         "thing", "still", "use", "can",
                         "magnet", "tri", "är", "på",
                         "en", "urn:btih", "att"
                         ))


## Time for the worst wordcloud you've ever seen!

textplot_wordcloud(eightch19_9, max_words = 400,
                   font = "Calibri Light", adjust = TRUE,
                   color = rev(RColorBrewer::brewer.pal(10, "RdBu")
                   ))

##
##
##
##
##
## 



