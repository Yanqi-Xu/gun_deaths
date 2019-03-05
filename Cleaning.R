library(tidyverse)
ownership <- read_csv("Guns_by_state.csv")
deaths<-read_csv("results.csv")

guns <-left_join(deaths,ownership, by="State") %>% 
  select("State","firearms", "Population", "Crude Rate", "Age-Adjusted Rate", "Deaths")

colnames(guns) <- c("State","Firearms", "Population", "Crude_Rate", "Adjusted_Rate", "Deaths")

guns <- guns %>% mutate("Ownership_Rate"=Firearms/Population *100) 
guns <- guns[-c(52), ]



guns %>% select("State","Ownership_Rate","Adjusted_Rate") 

colnames(guns) <- c('state','ownership','death')

write_csv(guns,"guns_output.csv")

ggplot(guns) + geom_point(aes(x=Ownership_Rate,y=Crude_Rate))
