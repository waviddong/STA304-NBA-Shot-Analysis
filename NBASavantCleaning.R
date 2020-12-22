library(tidyverse)
library(broom)
library(here)
library(skimr)
library(kableExtra)

setwd("C:/Users/David Wong/OneDrive/Desktop/sta304 final rpoj/nba shots")

nbashots10 <- read.csv("2010.csv")
nbashots11 <- read.csv("2011.csv")
nbashots12 <- read.csv("2012.csv")
nbashots13 <- read.csv("2013.csv")
nbashots14 <- read.csv("2014.csv")
nbashots15 <- read.csv("2015.csv")
nbashots16 <- read.csv("2016.csv")
nbashots17 <- read.csv("2017.csv")

# https://stackoverflow.com/questions/16666643/merging-more-than-2-dataframes-in-r-by-rownames


#15-17, 10-15? 
# 12-13 or 13-14 was steph curry's breakout season

# nbashots10$rn <- rownames(nbashots10)
# nbashots11$rn <- rownames(nbashots11)
# nbashots12$rn <- rownames(nbashots12)
# nbashots13$rn <- rownames(nbashots13)
# nbashots14$rn <- rownames(nbashots14)
# nbashots15$rn <- rownames(nbashots15)
# nbashots16$rn <- rownames(nbashots16)
# nbashots17$rn <- rownames(nbashots17)

# df1011 <- merge(nbashots10,nbashots11,by="name",all=T)


# require(plyr)
# 
# df1 <- join_all(list(nbashots10, nbashots11), by = 'team_name', type = 'full')
# df2 <- join_all(list(nbashots12,nbashots13), by = 'team_name', type = 'full')
# df3 <- join_all(list(nbashots14, nbashots15), by = 'team_name', type = 'full')
# df4 <- join_all(list(nbashots16,nbashots17), by = 'team_name', type = 'full')

# MyMerge <- function(x, y){
#   df <- merge(x, y, by= "team_name", all.x= TRUE, all.y= TRUE)
#   return(df)
# }
# 
# new.df <- Reduce(MyMerge, list(nbashots10, nbashots11, nbashots12,nbashots13,nbashots14, nbashots15,nbashots16,nbashots17))

# https://www.theringer.com/nba/2019/2/27/18240583/3-point-boom-nba-daryl-morey
# https://www.reddit.com/r/nba/comments/7u1dfu/did_steph_curry_basically_have_2_breakout_seasons/

# name, team_name, period, shot_made_flag, opponent, action_type, shot_type


#data cleaning
# nbashots10 <- nbashots10[complete.cases(nbashots10),] #removed 199761-190913 =8848 rows
# nbashots11 <- nbashots11[complete.cases(nbashots11),] #removed 161205-159710 =1495 rows
# nbashots12 <- nbashots12[complete.cases(nbashots12),] #removed 201579-199614 =1965 rows
# nbashots13 <- nbashots13[complete.cases(nbashots13),] #removed 204126-202222 =1904 rows
# nbashots14 <- nbashots14[complete.cases(nbashots14),] #removed 205550-199905 =5645 rows
# nbashots15 <- nbashots15[complete.cases(nbashots15),] #removed 200540-196695 =3845 rows
# nbashots16<-select(nbashots16, -c(defender_name))
# nbashots16 <- nbashots16[complete.cases(nbashots16),] #removed 184635-179684 =4951 rows
# nbashots17 <- nbashots17[complete.cases(nbashots17),] #removed 187712-163792 =23920 rows
# 
# sum(c(8848,1495,1965,1904,5645,3845,4951,23920)) #52573 total data points lost

#assigning random ids for unique players
# nbashots10$player_ids <- cumsum(!duplicated(nbashots10[1]))
# nbashots11$player_ids <- cumsum(!duplicated(nbashots11[1]))
# nbashots12$player_ids <- cumsum(!duplicated(nbashots12[1]))
# nbashots13$player_ids <- cumsum(!duplicated(nbashots13[1]))
# nbashots14$player_ids <- cumsum(!duplicated(nbashots14[1]))
# nbashots15$player_ids <- cumsum(!duplicated(nbashots15[1]))
# nbashots16$player_ids <- cumsum(!duplicated(nbashots16[1]))
# nbashots17$player_ids <- cumsum(!duplicated(nbashots17[1]))
df10_action <- nbashots10 %>%
  group_by(name, action_type) %>%
  tally()

df10_shot <- nbashots10 %>%
  group_by(name, shot_type) %>%
  tally()


df11_action <- nbashots11 %>%
  group_by(name, action_type) %>%
  tally()

df11_shot <- nbashots11 %>%
  group_by(name, shot_type) %>%
  tally()


df12_action <- nbashots12 %>%
  group_by(name, action_type) %>%
  tally()

df12_shot <- nbashots12 %>%
  group_by(name, shot_type) %>%
  tally()


df13_action <- nbashots13 %>%
  group_by(name, action_type) %>%
  tally()

df13_shot <- nbashots13 %>%
  group_by(name, shot_type) %>%
  tally()


df14_action <- nbashots14 %>%
  group_by(name, action_type) %>%
  tally()

df14_shot <- nbashots14 %>%
  group_by(name, shot_type) %>%
  tally()


df15_action <- nbashots15 %>%
  group_by(name, action_type) %>%
  tally()

df15_shot <- nbashots15 %>%
  group_by(name, shot_type) %>%
  tally()


df16_action <- nbashots16 %>%
  group_by(name, action_type) %>%
  tally()

df16_shot <- nbashots16 %>%
  group_by(name, shot_type) %>%
  tally()


df17_action <- nbashots17 %>%
  group_by(name, action_type) %>%
  tally()

df17_shot <- nbashots17 %>%
  group_by(name, shot_type) %>%
  tally()

tot_action <- rbind(df10_action,df11_action,df12_action,df13_action,df14_action,df15_action,df16_action,df17_action)

#export csv to extract shot action types via filter
write.csv(tot_action,'tot_action.csv')


tot_shot <- rbind(df10_shot,df11_shot,df12_shot,df13_shot,df14_shot,df15_shot,df16_shot,df17_shot)
# tot_shot <- tot_shot[complete.cases(tot_shot),] #removed 9 NA rows, the error was one had add_tally() instead of tally()

write.csv(tot_shot,'tot_shot.csv')



nbashots10 <- nbashots10 %>% 
  mutate(player_ids = group_indices(nbashots10, .dots=c("name", "team_name"))) 

nbashots11 <- nbashots11 %>% 
  mutate(player_ids = group_indices(nbashots11, .dots=c("name", "team_name"))) 

nbashots12 <- nbashots12 %>% 
  mutate(player_ids = group_indices(nbashots12, .dots=c("name", "team_name"))) 

nbashots13 <- nbashots13 %>% 
  mutate(player_ids = group_indices(nbashots13, .dots=c("name", "team_name"))) 

nbashots14 <- nbashots14 %>% 
  mutate(player_ids = group_indices(nbashots14, .dots=c("name", "team_name"))) 

nbashots15 <- nbashots15 %>% 
  mutate(player_ids = group_indices(nbashots15, .dots=c("name", "team_name"))) 

nbashots16 <- nbashots16 %>% 
  mutate(player_ids = group_indices(nbashots16, .dots=c("name", "team_name"))) 

nbashots17 <- nbashots17 %>% 
  mutate(player_ids = group_indices(nbashots17, .dots=c("name", "team_name"))) 





nbashots10 <- nbashots10 %>% 
  select(c(name, player_ids, team_name, period, shot_made_flag, opponent, action_type, shot_type))

nbashots11 <- nbashots11 %>% 
  select(c(name, player_ids, team_name, period, shot_made_flag, opponent, action_type, shot_type))

nbashots12 <- nbashots12 %>% 
  select(c(name, player_ids, team_name, period, shot_made_flag, opponent, action_type, shot_type))

nbashots13 <- nbashots13 %>% 
  select(c(name, player_ids, team_name, period, shot_made_flag, opponent, action_type, shot_type))

nbashots14 <- nbashots14 %>% 
  select(c(name, player_ids, team_name, period, shot_made_flag, opponent, action_type, shot_type))

nbashots15 <- nbashots15 %>% 
  select(c(name, player_ids, team_name, period, shot_made_flag, opponent, action_type, shot_type))

nbashots16 <- nbashots16 %>% 
  select(c(name, player_ids, team_name, period, shot_made_flag, opponent, action_type, shot_type))

nbashots17 <- nbashots17 %>% 
  select(c(name, player_ids, team_name, period, shot_made_flag, opponent, action_type, shot_type))

# https://www.quora.com/What-are-all-the-NBA-teams-listed-in-alphabetical-order
nbashots10<-
  nbashots10 %>%
  mutate(team_name_new = case_when(
    team_name=="Atlanta Hawks" ~ 1,
    team_name=="Boston Celtics" ~ 2,
    team_name=="Brooklyn Nets" ~ 3,
    team_name=="Charlotte Hornets" ~ 4,
    team_name=="Chicago Bulls" ~ 5,
    team_name=="Cleveland Cavaliers" ~ 6,
    team_name=="Dallas Mavericks" ~ 7,
    team_name=="Denver Nuggets" ~ 8,
    team_name=="Detroit Pistons" ~ 9,
    team_name=="Golden State Warriors" ~ 10,
    team_name=="Houston Rockets" ~ 11,
    team_name=="Indiana Pacers" ~ 12,
    team_name=="Los Angeles Clippers" ~ 13,
    team_name=="Los Angeles Lakers" ~ 14,
    team_name=="Memphis Grizzlies" ~ 15,
    team_name=="Miami Heat" ~ 16,
    team_name=="Milwaukee Bucks" ~ 17,
    team_name=="Minnesota Timberwolves" ~ 18,
    team_name=="New Orleans Pelicans" ~ 19,
    team_name=="New York Knicks" ~ 20,
    team_name=="Oklahoma City Thunder" ~ 21,
    team_name=="Orlando Magic" ~ 22,
    team_name=="Philadelphia 76ers" ~ 23,
    team_name=="Phoenix Suns" ~ 24,
    team_name=="Portland Trail Blazers" ~ 25,
    team_name=="Sacramento Kings" ~ 26,
    team_name=="San Antonio Spurs" ~ 27,
    team_name=="Toronto Raptors" ~ 28,
    team_name=="Utah Jazz" ~ 29,
    team_name=="Washington Wizards" ~ 30,
    team_name=="New Jersey Nets" ~ 31
  ))

nbashots10<-
  nbashots10 %>%
  mutate(opponent_new = case_when(
    opponent=="Atlanta Hawks" ~ 1,
    opponent=="Boston Celtics" ~ 2,
    opponent=="Brooklyn Nets" ~ 3,
    opponent=="Charlotte Hornets" ~ 4,
    opponent=="Chicago Bulls" ~ 5,
    opponent=="Cleveland Cavaliers" ~ 6,
    opponent=="Dallas Mavericks" ~ 7,
    opponent=="Denver Nuggets" ~ 8,
    opponent=="Detroit Pistons" ~ 9,
    opponent=="Golden State Warriors" ~ 10,
    opponent=="Houston Rockets" ~ 11,
    opponent=="Indiana Pacers" ~ 12,
    opponent=="Los Angeles Clippers" ~ 13,
    opponent=="Los Angeles Lakers" ~ 14,
    opponent=="Memphis Grizzlies" ~ 15,
    opponent=="Miami Heat" ~ 16,
    opponent=="Milwaukee Bucks" ~ 17,
    opponent=="Minnesota Timberwolves" ~ 18,
    opponent=="New Orleans Pelicans" ~ 19,
    opponent=="New York Knicks" ~ 20,
    opponent=="Oklahoma City Thunder" ~ 21,
    opponent=="Orlando Magic" ~ 22,
    opponent=="Philadelphia 76ers" ~ 23,
    opponent=="Phoenix Suns" ~ 24,
    opponent=="Portland Trail Blazers" ~ 25,
    opponent=="Sacramento Kings" ~ 26,
    opponent=="San Antonio Spurs" ~ 27,
    opponent=="Toronto Raptors" ~ 28,
    opponent=="Utah Jazz" ~ 29,
    opponent=="Washington Wizards" ~ 30
    opponent=="New Jersey Nets" ~ 31
  ))

nbashots10<-
  nbashots10 %>%
  mutate(shot_type_new = case_when(
    shot_type=="2PT Field Goal" ~ 1,
    shot_type=="3PT Field Goal" ~ 2
    ))


nbashots10<-
  nbashots10 %>%
  mutate(action_type_new = case_when(
    action_type=="Alley Oop Dunk Shot" ~ 1,
    action_type=="Alley Oop Layup shot" ~ 3,
    action_type=="Cutting Dunk Shot" ~ 1,
    action_type=="Cutting Finger Roll Layup Shot" ~ 3,
    action_type=="Cutting Layup Shot" ~ 3,
    action_type=="Driving Bank Hook Shot" ~ 4,
    action_type=="Driving Bank shot" ~ 3,
    action_type=="Driving Dunk Shot" ~ 1,
    action_type=="Driving Finger Roll Layup Shot" ~ 3,
    action_type=="Driving Floating Bank Jump Shot" ~ 2,
    action_type=="Driving Floating Jump Shot" ~ 2,
    action_type=="Driving Hook Shot" ~ 4,
    action_type=="Driving Jump shot" ~ 2,
    action_type=="Driving Layup Shot" ~ 3,
    action_type=="Driving Reverse Dunk Shot" ~ 1,
    action_type=="Driving Reverse Layup Shot" ~ 3,
    action_type=="Driving Slam Dunk Shot" ~ 1,
    action_type=="Dunk Shot" ~ 1,
    action_type=="Fadeaway Bank shot" ~ 2,
    action_type=="Fadeaway Jump Shot" ~ 2,
    action_type=="Finger Roll Layup Shot" ~ 3,
    action_type=="Floating Jump shot" ~ 2,
    action_type=="Hook Bank Shot" ~ 4,
    action_type=="Hook Shot" ~ 4,
    action_type=="Jump Bank Hook Shot" ~ 2,
    action_type=="Jump Bank Shot" ~ 2,
    action_type=="Jump Hook Shot" ~ 2,
    action_type=="Jump Shot" ~ 2,
    action_type=="Layup Shot" ~ 3,
    action_type=="No Shot" ~ 6,
    action_type=="Pullup Bank shot" ~ 2,
    action_type=="Pullup Jump shot" ~ 2,
    action_type=="Putback Dunk Shot" ~ 1,
    action_type=="Putback Layup Shot" ~ 3,
    action_type=="Putback Reverse Dunk Shot" ~ 1,
    action_type=="Putback Slam Dunk Shot" ~ 1,
    action_type=="Reverse Dunk Shot" ~ 1,
    action_type=="Reverse Layup Shot" ~ 3,
    action_type=="Reverse Slam Dunk Shot" ~ 1,
    action_type=="Running Alley Oop Dunk Shot" ~ 1,
    action_type=="Running Alley Oop Layup Shot" ~ 3,
    action_type=="Running Bank Hook Shot" ~ 4,
    action_type=="Running Bank shot" ~ 3,
    action_type=="Running Finger Roll Layup Shot" ~ 3,
    action_type=="Running Hook Shot" ~ 4,
    action_type=="Running Jump Shot" ~ 2,
    action_type=="Running Layup Shot" ~ 3,
    action_type=="Running Pull-Up Jump Shot" ~ 2,
    action_type=="Running Reverse Dunk Shot" ~ 1,
    action_type=="Running Reverse Layup Shot" ~ 3,
    action_type=="Running Slam Dunk Shot" ~ 1,
    action_type=="Running Tip Shot" ~ 1,
    action_type=="Slam Dunk Shot" ~ 1,
    action_type=="Step Back Bank Jump Shot" ~ 2,
    action_type=="Step Back Jump shot" ~ 2,
    action_type=="Tip Dunk Shot" ~ 1,
    action_type=="Tip Layup Shot" ~ 3,
    action_type=="Tip Shot" ~ 1,
    action_type=="Turnaround Bank Hook Shot" ~ 4,
    action_type=="Turnaround Bank shot" ~ 2,
    action_type=="Turnaround Fadeaway Bank Jump Shot" ~ 2,
    action_type=="Turnaround Fadeaway shot" ~ 2,
    action_type=="Turnaround Hook Shot" ~ 4,
    action_type=="Turnaround Jump Shot" ~ 2,
  ))


nbashots11<-
  nbashots11 %>%
  mutate(team_name_new = case_when(
    team_name=="Atlanta Hawks" ~ 1,
    team_name=="Boston Celtics" ~ 2,
    team_name=="Brooklyn Nets" ~ 3,
    team_name=="Charlotte Hornets" ~ 4,
    team_name=="Chicago Bulls" ~ 5,
    team_name=="Cleveland Cavaliers" ~ 6,
    team_name=="Dallas Mavericks" ~ 7,
    team_name=="Denver Nuggets" ~ 8,
    team_name=="Detroit Pistons" ~ 9,
    team_name=="Golden State Warriors" ~ 10,
    team_name=="Houston Rockets" ~ 11,
    team_name=="Indiana Pacers" ~ 12,
    team_name=="Los Angeles Clippers" ~ 13,
    team_name=="Los Angeles Lakers" ~ 14,
    team_name=="Memphis Grizzlies" ~ 15,
    team_name=="Miami Heat" ~ 16,
    team_name=="Milwaukee Bucks" ~ 17,
    team_name=="Minnesota Timberwolves" ~ 18,
    team_name=="New Orleans Pelicans" ~ 19,
    team_name=="New York Knicks" ~ 20,
    team_name=="Oklahoma City Thunder" ~ 21,
    team_name=="Orlando Magic" ~ 22,
    team_name=="Philadelphia 76ers" ~ 23,
    team_name=="Phoenix Suns" ~ 24,
    team_name=="Portland Trail Blazers" ~ 25,
    team_name=="Sacramento Kings" ~ 26,
    team_name=="San Antonio Spurs" ~ 27,
    team_name=="Toronto Raptors" ~ 28,
    team_name=="Utah Jazz" ~ 29,
    team_name=="Washington Wizards" ~ 30,
    team_name=="New Jersey Nets" ~ 31
  ))

nbashots11<-
  nbashots11 %>%
  mutate(opponent_new = case_when(
    opponent=="Atlanta Hawks" ~ 1,
    opponent=="Boston Celtics" ~ 2,
    opponent=="Brooklyn Nets" ~ 3,
    opponent=="Charlotte Hornets" ~ 4,
    opponent=="Chicago Bulls" ~ 5,
    opponent=="Cleveland Cavaliers" ~ 6,
    opponent=="Dallas Mavericks" ~ 7,
    opponent=="Denver Nuggets" ~ 8,
    opponent=="Detroit Pistons" ~ 9,
    opponent=="Golden State Warriors" ~ 10,
    opponent=="Houston Rockets" ~ 11,
    opponent=="Indiana Pacers" ~ 12,
    opponent=="Los Angeles Clippers" ~ 13,
    opponent=="Los Angeles Lakers" ~ 14,
    opponent=="Memphis Grizzlies" ~ 15,
    opponent=="Miami Heat" ~ 16,
    opponent=="Milwaukee Bucks" ~ 17,
    opponent=="Minnesota Timberwolves" ~ 18,
    opponent=="New Orleans Pelicans" ~ 19,
    opponent=="New York Knicks" ~ 20,
    opponent=="Oklahoma City Thunder" ~ 21,
    opponent=="Orlando Magic" ~ 22,
    opponent=="Philadelphia 76ers" ~ 23,
    opponent=="Phoenix Suns" ~ 24,
    opponent=="Portland Trail Blazers" ~ 25,
    opponent=="Sacramento Kings" ~ 26,
    opponent=="San Antonio Spurs" ~ 27,
    opponent=="Toronto Raptors" ~ 28,
    opponent=="Utah Jazz" ~ 29,
    opponent=="Washington Wizards" ~ 30
    opponent=="New Jersey Nets" ~ 31
  ))

nbashots11<-
  nbashots11 %>%
  mutate(shot_type_new = case_when(
    shot_type=="2PT Field Goal" ~ 1,
    shot_type=="3PT Field Goal" ~ 2
  ))


nbashots11<-
  nbashots11 %>%
  mutate(action_type_new = case_when(
    action_type=="Alley Oop Dunk Shot" ~ 1,
    action_type=="Alley Oop Layup shot" ~ 3,
    action_type=="Cutting Dunk Shot" ~ 1,
    action_type=="Cutting Finger Roll Layup Shot" ~ 3,
    action_type=="Cutting Layup Shot" ~ 3,
    action_type=="Driving Bank Hook Shot" ~ 4,
    action_type=="Driving Bank shot" ~ 3,
    action_type=="Driving Dunk Shot" ~ 1,
    action_type=="Driving Finger Roll Layup Shot" ~ 3,
    action_type=="Driving Floating Bank Jump Shot" ~ 2,
    action_type=="Driving Floating Jump Shot" ~ 2,
    action_type=="Driving Hook Shot" ~ 4,
    action_type=="Driving Jump shot" ~ 2,
    action_type=="Driving Layup Shot" ~ 3,
    action_type=="Driving Reverse Dunk Shot" ~ 1,
    action_type=="Driving Reverse Layup Shot" ~ 3,
    action_type=="Driving Slam Dunk Shot" ~ 1,
    action_type=="Dunk Shot" ~ 1,
    action_type=="Fadeaway Bank shot" ~ 2,
    action_type=="Fadeaway Jump Shot" ~ 2,
    action_type=="Finger Roll Layup Shot" ~ 3,
    action_type=="Floating Jump shot" ~ 2,
    action_type=="Hook Bank Shot" ~ 4,
    action_type=="Hook Shot" ~ 4,
    action_type=="Jump Bank Hook Shot" ~ 2,
    action_type=="Jump Bank Shot" ~ 2,
    action_type=="Jump Hook Shot" ~ 2,
    action_type=="Jump Shot" ~ 2,
    action_type=="Layup Shot" ~ 3,
    action_type=="No Shot" ~ 6,
    action_type=="Pullup Bank shot" ~ 2,
    action_type=="Pullup Jump shot" ~ 2,
    action_type=="Putback Dunk Shot" ~ 1,
    action_type=="Putback Layup Shot" ~ 3,
    action_type=="Putback Reverse Dunk Shot" ~ 1,
    action_type=="Putback Slam Dunk Shot" ~ 1,
    action_type=="Reverse Dunk Shot" ~ 1,
    action_type=="Reverse Layup Shot" ~ 3,
    action_type=="Reverse Slam Dunk Shot" ~ 1,
    action_type=="Running Alley Oop Dunk Shot" ~ 1,
    action_type=="Running Alley Oop Layup Shot" ~ 3,
    action_type=="Running Bank Hook Shot" ~ 4,
    action_type=="Running Bank shot" ~ 3,
    action_type=="Running Finger Roll Layup Shot" ~ 3,
    action_type=="Running Hook Shot" ~ 4,
    action_type=="Running Jump Shot" ~ 2,
    action_type=="Running Layup Shot" ~ 3,
    action_type=="Running Pull-Up Jump Shot" ~ 2,
    action_type=="Running Reverse Dunk Shot" ~ 1,
    action_type=="Running Reverse Layup Shot" ~ 3,
    action_type=="Running Slam Dunk Shot" ~ 1,
    action_type=="Running Tip Shot" ~ 1,
    action_type=="Slam Dunk Shot" ~ 1,
    action_type=="Step Back Bank Jump Shot" ~ 2,
    action_type=="Step Back Jump shot" ~ 2,
    action_type=="Tip Dunk Shot" ~ 1,
    action_type=="Tip Layup Shot" ~ 3,
    action_type=="Tip Shot" ~ 1,
    action_type=="Turnaround Bank Hook Shot" ~ 4,
    action_type=="Turnaround Bank shot" ~ 2,
    action_type=="Turnaround Fadeaway Bank Jump Shot" ~ 2,
    action_type=="Turnaround Fadeaway shot" ~ 2,
    action_type=="Turnaround Hook Shot" ~ 4,
    action_type=="Turnaround Jump Shot" ~ 2,
  ))

nbashots12<-
  nbashots12 %>%
  mutate(team_name_new = case_when(
    team_name=="Atlanta Hawks" ~ 1,
    team_name=="Boston Celtics" ~ 2,
    team_name=="Brooklyn Nets" ~ 3,
    team_name=="Charlotte Hornets" ~ 4,
    team_name=="Chicago Bulls" ~ 5,
    team_name=="Cleveland Cavaliers" ~ 6,
    team_name=="Dallas Mavericks" ~ 7,
    team_name=="Denver Nuggets" ~ 8,
    team_name=="Detroit Pistons" ~ 9,
    team_name=="Golden State Warriors" ~ 10,
    team_name=="Houston Rockets" ~ 11,
    team_name=="Indiana Pacers" ~ 12,
    team_name=="Los Angeles Clippers" ~ 13,
    team_name=="Los Angeles Lakers" ~ 14,
    team_name=="Memphis Grizzlies" ~ 15,
    team_name=="Miami Heat" ~ 16,
    team_name=="Milwaukee Bucks" ~ 17,
    team_name=="Minnesota Timberwolves" ~ 18,
    team_name=="New Orleans Pelicans" ~ 19,
    team_name=="New York Knicks" ~ 20,
    team_name=="Oklahoma City Thunder" ~ 21,
    team_name=="Orlando Magic" ~ 22,
    team_name=="Philadelphia 76ers" ~ 23,
    team_name=="Phoenix Suns" ~ 24,
    team_name=="Portland Trail Blazers" ~ 25,
    team_name=="Sacramento Kings" ~ 26,
    team_name=="San Antonio Spurs" ~ 27,
    team_name=="Toronto Raptors" ~ 28,
    team_name=="Utah Jazz" ~ 29,
    team_name=="Washington Wizards" ~ 30,
    team_name=="New Jersey Nets" ~ 31
  ))

nbashots12<-
  nbashots12 %>%
  mutate(opponent_new = case_when(
    opponent=="Atlanta Hawks" ~ 1,
    opponent=="Boston Celtics" ~ 2,
    opponent=="Brooklyn Nets" ~ 3,
    opponent=="Charlotte Hornets" ~ 4,
    opponent=="Chicago Bulls" ~ 5,
    opponent=="Cleveland Cavaliers" ~ 6,
    opponent=="Dallas Mavericks" ~ 7,
    opponent=="Denver Nuggets" ~ 8,
    opponent=="Detroit Pistons" ~ 9,
    opponent=="Golden State Warriors" ~ 10,
    opponent=="Houston Rockets" ~ 11,
    opponent=="Indiana Pacers" ~ 12,
    opponent=="Los Angeles Clippers" ~ 13,
    opponent=="Los Angeles Lakers" ~ 14,
    opponent=="Memphis Grizzlies" ~ 15,
    opponent=="Miami Heat" ~ 16,
    opponent=="Milwaukee Bucks" ~ 17,
    opponent=="Minnesota Timberwolves" ~ 18,
    opponent=="New Orleans Pelicans" ~ 19,
    opponent=="New York Knicks" ~ 20,
    opponent=="Oklahoma City Thunder" ~ 21,
    opponent=="Orlando Magic" ~ 22,
    opponent=="Philadelphia 76ers" ~ 23,
    opponent=="Phoenix Suns" ~ 24,
    opponent=="Portland Trail Blazers" ~ 25,
    opponent=="Sacramento Kings" ~ 26,
    opponent=="San Antonio Spurs" ~ 27,
    opponent=="Toronto Raptors" ~ 28,
    opponent=="Utah Jazz" ~ 29,
    opponent=="Washington Wizards" ~ 30
    opponent=="New Jersey Nets" ~ 31
  ))

nbashots12<-
  nbashots12 %>%
  mutate(shot_type_new = case_when(
    shot_type=="2PT Field Goal" ~ 1,
    shot_type=="3PT Field Goal" ~ 2
  ))


nbashots12<-
  nbashots12 %>%
  mutate(action_type_new = case_when(
    action_type=="Alley Oop Dunk Shot" ~ 1,
    action_type=="Alley Oop Layup shot" ~ 3,
    action_type=="Cutting Dunk Shot" ~ 1,
    action_type=="Cutting Finger Roll Layup Shot" ~ 3,
    action_type=="Cutting Layup Shot" ~ 3,
    action_type=="Driving Bank Hook Shot" ~ 4,
    action_type=="Driving Bank shot" ~ 3,
    action_type=="Driving Dunk Shot" ~ 1,
    action_type=="Driving Finger Roll Layup Shot" ~ 3,
    action_type=="Driving Floating Bank Jump Shot" ~ 2,
    action_type=="Driving Floating Jump Shot" ~ 2,
    action_type=="Driving Hook Shot" ~ 4,
    action_type=="Driving Jump shot" ~ 2,
    action_type=="Driving Layup Shot" ~ 3,
    action_type=="Driving Reverse Dunk Shot" ~ 1,
    action_type=="Driving Reverse Layup Shot" ~ 3,
    action_type=="Driving Slam Dunk Shot" ~ 1,
    action_type=="Dunk Shot" ~ 1,
    action_type=="Fadeaway Bank shot" ~ 2,
    action_type=="Fadeaway Jump Shot" ~ 2,
    action_type=="Finger Roll Layup Shot" ~ 3,
    action_type=="Floating Jump shot" ~ 2,
    action_type=="Hook Bank Shot" ~ 4,
    action_type=="Hook Shot" ~ 4,
    action_type=="Jump Bank Hook Shot" ~ 2,
    action_type=="Jump Bank Shot" ~ 2,
    action_type=="Jump Hook Shot" ~ 2,
    action_type=="Jump Shot" ~ 2,
    action_type=="Layup Shot" ~ 3,
    action_type=="No Shot" ~ 6,
    action_type=="Pullup Bank shot" ~ 2,
    action_type=="Pullup Jump shot" ~ 2,
    action_type=="Putback Dunk Shot" ~ 1,
    action_type=="Putback Layup Shot" ~ 3,
    action_type=="Putback Reverse Dunk Shot" ~ 1,
    action_type=="Putback Slam Dunk Shot" ~ 1,
    action_type=="Reverse Dunk Shot" ~ 1,
    action_type=="Reverse Layup Shot" ~ 3,
    action_type=="Reverse Slam Dunk Shot" ~ 1,
    action_type=="Running Alley Oop Dunk Shot" ~ 1,
    action_type=="Running Alley Oop Layup Shot" ~ 3,
    action_type=="Running Bank Hook Shot" ~ 4,
    action_type=="Running Bank shot" ~ 3,
    action_type=="Running Finger Roll Layup Shot" ~ 3,
    action_type=="Running Hook Shot" ~ 4,
    action_type=="Running Jump Shot" ~ 2,
    action_type=="Running Layup Shot" ~ 3,
    action_type=="Running Pull-Up Jump Shot" ~ 2,
    action_type=="Running Reverse Dunk Shot" ~ 1,
    action_type=="Running Reverse Layup Shot" ~ 3,
    action_type=="Running Slam Dunk Shot" ~ 1,
    action_type=="Running Tip Shot" ~ 1,
    action_type=="Slam Dunk Shot" ~ 1,
    action_type=="Step Back Bank Jump Shot" ~ 2,
    action_type=="Step Back Jump shot" ~ 2,
    action_type=="Tip Dunk Shot" ~ 1,
    action_type=="Tip Layup Shot" ~ 3,
    action_type=="Tip Shot" ~ 1,
    action_type=="Turnaround Bank Hook Shot" ~ 4,
    action_type=="Turnaround Bank shot" ~ 2,
    action_type=="Turnaround Fadeaway Bank Jump Shot" ~ 2,
    action_type=="Turnaround Fadeaway shot" ~ 2,
    action_type=="Turnaround Hook Shot" ~ 4,
    action_type=="Turnaround Jump Shot" ~ 2,
  ))

nbashots13<-
  nbashots13 %>%
  mutate(team_name_new = case_when(
    team_name=="Atlanta Hawks" ~ 1,
    team_name=="Boston Celtics" ~ 2,
    team_name=="Brooklyn Nets" ~ 3,
    team_name=="Charlotte Hornets" ~ 4,
    team_name=="Chicago Bulls" ~ 5,
    team_name=="Cleveland Cavaliers" ~ 6,
    team_name=="Dallas Mavericks" ~ 7,
    team_name=="Denver Nuggets" ~ 8,
    team_name=="Detroit Pistons" ~ 9,
    team_name=="Golden State Warriors" ~ 10,
    team_name=="Houston Rockets" ~ 11,
    team_name=="Indiana Pacers" ~ 12,
    team_name=="Los Angeles Clippers" ~ 13,
    team_name=="Los Angeles Lakers" ~ 14,
    team_name=="Memphis Grizzlies" ~ 15,
    team_name=="Miami Heat" ~ 16,
    team_name=="Milwaukee Bucks" ~ 17,
    team_name=="Minnesota Timberwolves" ~ 18,
    team_name=="New Orleans Pelicans" ~ 19,
    team_name=="New York Knicks" ~ 20,
    team_name=="Oklahoma City Thunder" ~ 21,
    team_name=="Orlando Magic" ~ 22,
    team_name=="Philadelphia 76ers" ~ 23,
    team_name=="Phoenix Suns" ~ 24,
    team_name=="Portland Trail Blazers" ~ 25,
    team_name=="Sacramento Kings" ~ 26,
    team_name=="San Antonio Spurs" ~ 27,
    team_name=="Toronto Raptors" ~ 28,
    team_name=="Utah Jazz" ~ 29,
    team_name=="Washington Wizards" ~ 30,
    team_name=="New Jersey Nets" ~ 31
  ))

nbashots13<-
  nbashots13 %>%
  mutate(opponent_new = case_when(
    opponent=="Atlanta Hawks" ~ 1,
    opponent=="Boston Celtics" ~ 2,
    opponent=="Brooklyn Nets" ~ 3,
    opponent=="Charlotte Hornets" ~ 4,
    opponent=="Chicago Bulls" ~ 5,
    opponent=="Cleveland Cavaliers" ~ 6,
    opponent=="Dallas Mavericks" ~ 7,
    opponent=="Denver Nuggets" ~ 8,
    opponent=="Detroit Pistons" ~ 9,
    opponent=="Golden State Warriors" ~ 10,
    opponent=="Houston Rockets" ~ 11,
    opponent=="Indiana Pacers" ~ 12,
    opponent=="Los Angeles Clippers" ~ 13,
    opponent=="Los Angeles Lakers" ~ 14,
    opponent=="Memphis Grizzlies" ~ 15,
    opponent=="Miami Heat" ~ 16,
    opponent=="Milwaukee Bucks" ~ 17,
    opponent=="Minnesota Timberwolves" ~ 18,
    opponent=="New Orleans Pelicans" ~ 19,
    opponent=="New York Knicks" ~ 20,
    opponent=="Oklahoma City Thunder" ~ 21,
    opponent=="Orlando Magic" ~ 22,
    opponent=="Philadelphia 76ers" ~ 23,
    opponent=="Phoenix Suns" ~ 24,
    opponent=="Portland Trail Blazers" ~ 25,
    opponent=="Sacramento Kings" ~ 26,
    opponent=="San Antonio Spurs" ~ 27,
    opponent=="Toronto Raptors" ~ 28,
    opponent=="Utah Jazz" ~ 29,
    opponent=="Washington Wizards" ~ 30
    opponent=="New Jersey Nets" ~ 31
  ))

nbashots13<-
  nbashots13 %>%
  mutate(shot_type_new = case_when(
    shot_type=="2PT Field Goal" ~ 1,
    shot_type=="3PT Field Goal" ~ 2
  ))


nbashots13<-
  nbashots13 %>%
  mutate(action_type_new = case_when(
    action_type=="Alley Oop Dunk Shot" ~ 1,
    action_type=="Alley Oop Layup shot" ~ 3,
    action_type=="Cutting Dunk Shot" ~ 1,
    action_type=="Cutting Finger Roll Layup Shot" ~ 3,
    action_type=="Cutting Layup Shot" ~ 3,
    action_type=="Driving Bank Hook Shot" ~ 4,
    action_type=="Driving Bank shot" ~ 3,
    action_type=="Driving Dunk Shot" ~ 1,
    action_type=="Driving Finger Roll Layup Shot" ~ 3,
    action_type=="Driving Floating Bank Jump Shot" ~ 2,
    action_type=="Driving Floating Jump Shot" ~ 2,
    action_type=="Driving Hook Shot" ~ 4,
    action_type=="Driving Jump shot" ~ 2,
    action_type=="Driving Layup Shot" ~ 3,
    action_type=="Driving Reverse Dunk Shot" ~ 1,
    action_type=="Driving Reverse Layup Shot" ~ 3,
    action_type=="Driving Slam Dunk Shot" ~ 1,
    action_type=="Dunk Shot" ~ 1,
    action_type=="Fadeaway Bank shot" ~ 2,
    action_type=="Fadeaway Jump Shot" ~ 2,
    action_type=="Finger Roll Layup Shot" ~ 3,
    action_type=="Floating Jump shot" ~ 2,
    action_type=="Hook Bank Shot" ~ 4,
    action_type=="Hook Shot" ~ 4,
    action_type=="Jump Bank Hook Shot" ~ 2,
    action_type=="Jump Bank Shot" ~ 2,
    action_type=="Jump Hook Shot" ~ 2,
    action_type=="Jump Shot" ~ 2,
    action_type=="Layup Shot" ~ 3,
    action_type=="No Shot" ~ 6,
    action_type=="Pullup Bank shot" ~ 2,
    action_type=="Pullup Jump shot" ~ 2,
    action_type=="Putback Dunk Shot" ~ 1,
    action_type=="Putback Layup Shot" ~ 3,
    action_type=="Putback Reverse Dunk Shot" ~ 1,
    action_type=="Putback Slam Dunk Shot" ~ 1,
    action_type=="Reverse Dunk Shot" ~ 1,
    action_type=="Reverse Layup Shot" ~ 3,
    action_type=="Reverse Slam Dunk Shot" ~ 1,
    action_type=="Running Alley Oop Dunk Shot" ~ 1,
    action_type=="Running Alley Oop Layup Shot" ~ 3,
    action_type=="Running Bank Hook Shot" ~ 4,
    action_type=="Running Bank shot" ~ 3,
    action_type=="Running Finger Roll Layup Shot" ~ 3,
    action_type=="Running Hook Shot" ~ 4,
    action_type=="Running Jump Shot" ~ 2,
    action_type=="Running Layup Shot" ~ 3,
    action_type=="Running Pull-Up Jump Shot" ~ 2,
    action_type=="Running Reverse Dunk Shot" ~ 1,
    action_type=="Running Reverse Layup Shot" ~ 3,
    action_type=="Running Slam Dunk Shot" ~ 1,
    action_type=="Running Tip Shot" ~ 1,
    action_type=="Slam Dunk Shot" ~ 1,
    action_type=="Step Back Bank Jump Shot" ~ 2,
    action_type=="Step Back Jump shot" ~ 2,
    action_type=="Tip Dunk Shot" ~ 1,
    action_type=="Tip Layup Shot" ~ 3,
    action_type=="Tip Shot" ~ 1,
    action_type=="Turnaround Bank Hook Shot" ~ 4,
    action_type=="Turnaround Bank shot" ~ 2,
    action_type=="Turnaround Fadeaway Bank Jump Shot" ~ 2,
    action_type=="Turnaround Fadeaway shot" ~ 2,
    action_type=="Turnaround Hook Shot" ~ 4,
    action_type=="Turnaround Jump Shot" ~ 2,
  ))

nbashots14<-
  nbashots14 %>%
  mutate(team_name_new = case_when(
    team_name=="Atlanta Hawks" ~ 1,
    team_name=="Boston Celtics" ~ 2,
    team_name=="Brooklyn Nets" ~ 3,
    team_name=="Charlotte Hornets" ~ 4,
    team_name=="Chicago Bulls" ~ 5,
    team_name=="Cleveland Cavaliers" ~ 6,
    team_name=="Dallas Mavericks" ~ 7,
    team_name=="Denver Nuggets" ~ 8,
    team_name=="Detroit Pistons" ~ 9,
    team_name=="Golden State Warriors" ~ 10,
    team_name=="Houston Rockets" ~ 11,
    team_name=="Indiana Pacers" ~ 12,
    team_name=="Los Angeles Clippers" ~ 13,
    team_name=="Los Angeles Lakers" ~ 14,
    team_name=="Memphis Grizzlies" ~ 15,
    team_name=="Miami Heat" ~ 16,
    team_name=="Milwaukee Bucks" ~ 17,
    team_name=="Minnesota Timberwolves" ~ 18,
    team_name=="New Orleans Pelicans" ~ 19,
    team_name=="New York Knicks" ~ 20,
    team_name=="Oklahoma City Thunder" ~ 21,
    team_name=="Orlando Magic" ~ 22,
    team_name=="Philadelphia 76ers" ~ 23,
    team_name=="Phoenix Suns" ~ 24,
    team_name=="Portland Trail Blazers" ~ 25,
    team_name=="Sacramento Kings" ~ 26,
    team_name=="San Antonio Spurs" ~ 27,
    team_name=="Toronto Raptors" ~ 28,
    team_name=="Utah Jazz" ~ 29,
    team_name=="Washington Wizards" ~ 30,
    team_name=="New Jersey Nets" ~ 31
  ))

nbashots14<-
  nbashots14 %>%
  mutate(opponent_new = case_when(
    opponent=="Atlanta Hawks" ~ 1,
    opponent=="Boston Celtics" ~ 2,
    opponent=="Brooklyn Nets" ~ 3,
    opponent=="Charlotte Hornets" ~ 4,
    opponent=="Chicago Bulls" ~ 5,
    opponent=="Cleveland Cavaliers" ~ 6,
    opponent=="Dallas Mavericks" ~ 7,
    opponent=="Denver Nuggets" ~ 8,
    opponent=="Detroit Pistons" ~ 9,
    opponent=="Golden State Warriors" ~ 10,
    opponent=="Houston Rockets" ~ 11,
    opponent=="Indiana Pacers" ~ 12,
    opponent=="Los Angeles Clippers" ~ 13,
    opponent=="Los Angeles Lakers" ~ 14,
    opponent=="Memphis Grizzlies" ~ 15,
    opponent=="Miami Heat" ~ 16,
    opponent=="Milwaukee Bucks" ~ 17,
    opponent=="Minnesota Timberwolves" ~ 18,
    opponent=="New Orleans Pelicans" ~ 19,
    opponent=="New York Knicks" ~ 20,
    opponent=="Oklahoma City Thunder" ~ 21,
    opponent=="Orlando Magic" ~ 22,
    opponent=="Philadelphia 76ers" ~ 23,
    opponent=="Phoenix Suns" ~ 24,
    opponent=="Portland Trail Blazers" ~ 25,
    opponent=="Sacramento Kings" ~ 26,
    opponent=="San Antonio Spurs" ~ 27,
    opponent=="Toronto Raptors" ~ 28,
    opponent=="Utah Jazz" ~ 29,
    opponent=="Washington Wizards" ~ 30
    opponent=="New Jersey Nets" ~ 31
  ))

nbashots14<-
  nbashots14 %>%
  mutate(shot_type_new = case_when(
    shot_type=="2PT Field Goal" ~ 1,
    shot_type=="3PT Field Goal" ~ 2
  ))


nbashots14<-
  nbashots14 %>%
  mutate(action_type_new = case_when(
    action_type=="Alley Oop Dunk Shot" ~ 1,
    action_type=="Alley Oop Layup shot" ~ 3,
    action_type=="Cutting Dunk Shot" ~ 1,
    action_type=="Cutting Finger Roll Layup Shot" ~ 3,
    action_type=="Cutting Layup Shot" ~ 3,
    action_type=="Driving Bank Hook Shot" ~ 4,
    action_type=="Driving Bank shot" ~ 3,
    action_type=="Driving Dunk Shot" ~ 1,
    action_type=="Driving Finger Roll Layup Shot" ~ 3,
    action_type=="Driving Floating Bank Jump Shot" ~ 2,
    action_type=="Driving Floating Jump Shot" ~ 2,
    action_type=="Driving Hook Shot" ~ 4,
    action_type=="Driving Jump shot" ~ 2,
    action_type=="Driving Layup Shot" ~ 3,
    action_type=="Driving Reverse Dunk Shot" ~ 1,
    action_type=="Driving Reverse Layup Shot" ~ 3,
    action_type=="Driving Slam Dunk Shot" ~ 1,
    action_type=="Dunk Shot" ~ 1,
    action_type=="Fadeaway Bank shot" ~ 2,
    action_type=="Fadeaway Jump Shot" ~ 2,
    action_type=="Finger Roll Layup Shot" ~ 3,
    action_type=="Floating Jump shot" ~ 2,
    action_type=="Hook Bank Shot" ~ 4,
    action_type=="Hook Shot" ~ 4,
    action_type=="Jump Bank Hook Shot" ~ 2,
    action_type=="Jump Bank Shot" ~ 2,
    action_type=="Jump Hook Shot" ~ 2,
    action_type=="Jump Shot" ~ 2,
    action_type=="Layup Shot" ~ 3,
    action_type=="No Shot" ~ 6,
    action_type=="Pullup Bank shot" ~ 2,
    action_type=="Pullup Jump shot" ~ 2,
    action_type=="Putback Dunk Shot" ~ 1,
    action_type=="Putback Layup Shot" ~ 3,
    action_type=="Putback Reverse Dunk Shot" ~ 1,
    action_type=="Putback Slam Dunk Shot" ~ 1,
    action_type=="Reverse Dunk Shot" ~ 1,
    action_type=="Reverse Layup Shot" ~ 3,
    action_type=="Reverse Slam Dunk Shot" ~ 1,
    action_type=="Running Alley Oop Dunk Shot" ~ 1,
    action_type=="Running Alley Oop Layup Shot" ~ 3,
    action_type=="Running Bank Hook Shot" ~ 4,
    action_type=="Running Bank shot" ~ 3,
    action_type=="Running Finger Roll Layup Shot" ~ 3,
    action_type=="Running Hook Shot" ~ 4,
    action_type=="Running Jump Shot" ~ 2,
    action_type=="Running Layup Shot" ~ 3,
    action_type=="Running Pull-Up Jump Shot" ~ 2,
    action_type=="Running Reverse Dunk Shot" ~ 1,
    action_type=="Running Reverse Layup Shot" ~ 3,
    action_type=="Running Slam Dunk Shot" ~ 1,
    action_type=="Running Tip Shot" ~ 1,
    action_type=="Slam Dunk Shot" ~ 1,
    action_type=="Step Back Bank Jump Shot" ~ 2,
    action_type=="Step Back Jump shot" ~ 2,
    action_type=="Tip Dunk Shot" ~ 1,
    action_type=="Tip Layup Shot" ~ 3,
    action_type=="Tip Shot" ~ 1,
    action_type=="Turnaround Bank Hook Shot" ~ 4,
    action_type=="Turnaround Bank shot" ~ 2,
    action_type=="Turnaround Fadeaway Bank Jump Shot" ~ 2,
    action_type=="Turnaround Fadeaway shot" ~ 2,
    action_type=="Turnaround Hook Shot" ~ 4,
    action_type=="Turnaround Jump Shot" ~ 2,
  ))

nbashots15<-
  nbashots15 %>%
  mutate(team_name_new = case_when(
    team_name=="Atlanta Hawks" ~ 1,
    team_name=="Boston Celtics" ~ 2,
    team_name=="Brooklyn Nets" ~ 3,
    team_name=="Charlotte Hornets" ~ 4,
    team_name=="Chicago Bulls" ~ 5,
    team_name=="Cleveland Cavaliers" ~ 6,
    team_name=="Dallas Mavericks" ~ 7,
    team_name=="Denver Nuggets" ~ 8,
    team_name=="Detroit Pistons" ~ 9,
    team_name=="Golden State Warriors" ~ 10,
    team_name=="Houston Rockets" ~ 11,
    team_name=="Indiana Pacers" ~ 12,
    team_name=="Los Angeles Clippers" ~ 13,
    team_name=="Los Angeles Lakers" ~ 14,
    team_name=="Memphis Grizzlies" ~ 15,
    team_name=="Miami Heat" ~ 16,
    team_name=="Milwaukee Bucks" ~ 17,
    team_name=="Minnesota Timberwolves" ~ 18,
    team_name=="New Orleans Pelicans" ~ 19,
    team_name=="New York Knicks" ~ 20,
    team_name=="Oklahoma City Thunder" ~ 21,
    team_name=="Orlando Magic" ~ 22,
    team_name=="Philadelphia 76ers" ~ 23,
    team_name=="Phoenix Suns" ~ 24,
    team_name=="Portland Trail Blazers" ~ 25,
    team_name=="Sacramento Kings" ~ 26,
    team_name=="San Antonio Spurs" ~ 27,
    team_name=="Toronto Raptors" ~ 28,
    team_name=="Utah Jazz" ~ 29,
    team_name=="Washington Wizards" ~ 30,
    team_name=="New Jersey Nets" ~ 31
  ))

nbashots15<-
  nbashots15 %>%
  mutate(opponent_new = case_when(
    opponent=="Atlanta Hawks" ~ 1,
    opponent=="Boston Celtics" ~ 2,
    opponent=="Brooklyn Nets" ~ 3,
    opponent=="Charlotte Hornets" ~ 4,
    opponent=="Chicago Bulls" ~ 5,
    opponent=="Cleveland Cavaliers" ~ 6,
    opponent=="Dallas Mavericks" ~ 7,
    opponent=="Denver Nuggets" ~ 8,
    opponent=="Detroit Pistons" ~ 9,
    opponent=="Golden State Warriors" ~ 10,
    opponent=="Houston Rockets" ~ 11,
    opponent=="Indiana Pacers" ~ 12,
    opponent=="Los Angeles Clippers" ~ 13,
    opponent=="Los Angeles Lakers" ~ 14,
    opponent=="Memphis Grizzlies" ~ 15,
    opponent=="Miami Heat" ~ 16,
    opponent=="Milwaukee Bucks" ~ 17,
    opponent=="Minnesota Timberwolves" ~ 18,
    opponent=="New Orleans Pelicans" ~ 19,
    opponent=="New York Knicks" ~ 20,
    opponent=="Oklahoma City Thunder" ~ 21,
    opponent=="Orlando Magic" ~ 22,
    opponent=="Philadelphia 76ers" ~ 23,
    opponent=="Phoenix Suns" ~ 24,
    opponent=="Portland Trail Blazers" ~ 25,
    opponent=="Sacramento Kings" ~ 26,
    opponent=="San Antonio Spurs" ~ 27,
    opponent=="Toronto Raptors" ~ 28,
    opponent=="Utah Jazz" ~ 29,
    opponent=="Washington Wizards" ~ 30
    opponent=="New Jersey Nets" ~ 31
  ))

nbashots15<-
  nbashots15 %>%
  mutate(shot_type_new = case_when(
    shot_type=="2PT Field Goal" ~ 1,
    shot_type=="3PT Field Goal" ~ 2
  ))


nbashots15<-
  nbashots15 %>%
  mutate(action_type_new = case_when(
    action_type=="Alley Oop Dunk Shot" ~ 1,
    action_type=="Alley Oop Layup shot" ~ 3,
    action_type=="Cutting Dunk Shot" ~ 1,
    action_type=="Cutting Finger Roll Layup Shot" ~ 3,
    action_type=="Cutting Layup Shot" ~ 3,
    action_type=="Driving Bank Hook Shot" ~ 4,
    action_type=="Driving Bank shot" ~ 3,
    action_type=="Driving Dunk Shot" ~ 1,
    action_type=="Driving Finger Roll Layup Shot" ~ 3,
    action_type=="Driving Floating Bank Jump Shot" ~ 2,
    action_type=="Driving Floating Jump Shot" ~ 2,
    action_type=="Driving Hook Shot" ~ 4,
    action_type=="Driving Jump shot" ~ 2,
    action_type=="Driving Layup Shot" ~ 3,
    action_type=="Driving Reverse Dunk Shot" ~ 1,
    action_type=="Driving Reverse Layup Shot" ~ 3,
    action_type=="Driving Slam Dunk Shot" ~ 1,
    action_type=="Dunk Shot" ~ 1,
    action_type=="Fadeaway Bank shot" ~ 2,
    action_type=="Fadeaway Jump Shot" ~ 2,
    action_type=="Finger Roll Layup Shot" ~ 3,
    action_type=="Floating Jump shot" ~ 2,
    action_type=="Hook Bank Shot" ~ 4,
    action_type=="Hook Shot" ~ 4,
    action_type=="Jump Bank Hook Shot" ~ 2,
    action_type=="Jump Bank Shot" ~ 2,
    action_type=="Jump Hook Shot" ~ 2,
    action_type=="Jump Shot" ~ 2,
    action_type=="Layup Shot" ~ 3,
    action_type=="No Shot" ~ 6,
    action_type=="Pullup Bank shot" ~ 2,
    action_type=="Pullup Jump shot" ~ 2,
    action_type=="Putback Dunk Shot" ~ 1,
    action_type=="Putback Layup Shot" ~ 3,
    action_type=="Putback Reverse Dunk Shot" ~ 1,
    action_type=="Putback Slam Dunk Shot" ~ 1,
    action_type=="Reverse Dunk Shot" ~ 1,
    action_type=="Reverse Layup Shot" ~ 3,
    action_type=="Reverse Slam Dunk Shot" ~ 1,
    action_type=="Running Alley Oop Dunk Shot" ~ 1,
    action_type=="Running Alley Oop Layup Shot" ~ 3,
    action_type=="Running Bank Hook Shot" ~ 4,
    action_type=="Running Bank shot" ~ 3,
    action_type=="Running Finger Roll Layup Shot" ~ 3,
    action_type=="Running Hook Shot" ~ 4,
    action_type=="Running Jump Shot" ~ 2,
    action_type=="Running Layup Shot" ~ 3,
    action_type=="Running Pull-Up Jump Shot" ~ 2,
    action_type=="Running Reverse Dunk Shot" ~ 1,
    action_type=="Running Reverse Layup Shot" ~ 3,
    action_type=="Running Slam Dunk Shot" ~ 1,
    action_type=="Running Tip Shot" ~ 1,
    action_type=="Slam Dunk Shot" ~ 1,
    action_type=="Step Back Bank Jump Shot" ~ 2,
    action_type=="Step Back Jump shot" ~ 2,
    action_type=="Tip Dunk Shot" ~ 1,
    action_type=="Tip Layup Shot" ~ 3,
    action_type=="Tip Shot" ~ 1,
    action_type=="Turnaround Bank Hook Shot" ~ 4,
    action_type=="Turnaround Bank shot" ~ 2,
    action_type=="Turnaround Fadeaway Bank Jump Shot" ~ 2,
    action_type=="Turnaround Fadeaway shot" ~ 2,
    action_type=="Turnaround Hook Shot" ~ 4,
    action_type=="Turnaround Jump Shot" ~ 2,
  ))

nbashots16<-
  nbashots16 %>%
  mutate(team_name_new = case_when(
    team_name=="Atlanta Hawks" ~ 1,
    team_name=="Boston Celtics" ~ 2,
    team_name=="Brooklyn Nets" ~ 3,
    team_name=="Charlotte Hornets" ~ 4,
    team_name=="Chicago Bulls" ~ 5,
    team_name=="Cleveland Cavaliers" ~ 6,
    team_name=="Dallas Mavericks" ~ 7,
    team_name=="Denver Nuggets" ~ 8,
    team_name=="Detroit Pistons" ~ 9,
    team_name=="Golden State Warriors" ~ 10,
    team_name=="Houston Rockets" ~ 11,
    team_name=="Indiana Pacers" ~ 12,
    team_name=="Los Angeles Clippers" ~ 13,
    team_name=="Los Angeles Lakers" ~ 14,
    team_name=="Memphis Grizzlies" ~ 15,
    team_name=="Miami Heat" ~ 16,
    team_name=="Milwaukee Bucks" ~ 17,
    team_name=="Minnesota Timberwolves" ~ 18,
    team_name=="New Orleans Pelicans" ~ 19,
    team_name=="New York Knicks" ~ 20,
    team_name=="Oklahoma City Thunder" ~ 21,
    team_name=="Orlando Magic" ~ 22,
    team_name=="Philadelphia 76ers" ~ 23,
    team_name=="Phoenix Suns" ~ 24,
    team_name=="Portland Trail Blazers" ~ 25,
    team_name=="Sacramento Kings" ~ 26,
    team_name=="San Antonio Spurs" ~ 27,
    team_name=="Toronto Raptors" ~ 28,
    team_name=="Utah Jazz" ~ 29,
    team_name=="Washington Wizards" ~ 30,
    team_name=="New Jersey Nets" ~ 31
  ))

nbashots16<-
  nbashots16 %>%
  mutate(opponent_new = case_when(
    opponent=="Atlanta Hawks" ~ 1,
    opponent=="Boston Celtics" ~ 2,
    opponent=="Brooklyn Nets" ~ 3,
    opponent=="Charlotte Hornets" ~ 4,
    opponent=="Chicago Bulls" ~ 5,
    opponent=="Cleveland Cavaliers" ~ 6,
    opponent=="Dallas Mavericks" ~ 7,
    opponent=="Denver Nuggets" ~ 8,
    opponent=="Detroit Pistons" ~ 9,
    opponent=="Golden State Warriors" ~ 10,
    opponent=="Houston Rockets" ~ 11,
    opponent=="Indiana Pacers" ~ 12,
    opponent=="Los Angeles Clippers" ~ 13,
    opponent=="Los Angeles Lakers" ~ 14,
    opponent=="Memphis Grizzlies" ~ 15,
    opponent=="Miami Heat" ~ 16,
    opponent=="Milwaukee Bucks" ~ 17,
    opponent=="Minnesota Timberwolves" ~ 18,
    opponent=="New Orleans Pelicans" ~ 19,
    opponent=="New York Knicks" ~ 20,
    opponent=="Oklahoma City Thunder" ~ 21,
    opponent=="Orlando Magic" ~ 22,
    opponent=="Philadelphia 76ers" ~ 23,
    opponent=="Phoenix Suns" ~ 24,
    opponent=="Portland Trail Blazers" ~ 25,
    opponent=="Sacramento Kings" ~ 26,
    opponent=="San Antonio Spurs" ~ 27,
    opponent=="Toronto Raptors" ~ 28,
    opponent=="Utah Jazz" ~ 29,
    opponent=="Washington Wizards" ~ 30
    opponent=="New Jersey Nets" ~ 31
  ))

nbashots16<-
  nbashots16 %>%
  mutate(shot_type_new = case_when(
    shot_type=="2PT Field Goal" ~ 1,
    shot_type=="3PT Field Goal" ~ 2
  ))


nbashots16<-
  nbashots16 %>%
  mutate(action_type_new = case_when(
    action_type=="Alley Oop Dunk Shot" ~ 1,
    action_type=="Alley Oop Layup shot" ~ 3,
    action_type=="Cutting Dunk Shot" ~ 1,
    action_type=="Cutting Finger Roll Layup Shot" ~ 3,
    action_type=="Cutting Layup Shot" ~ 3,
    action_type=="Driving Bank Hook Shot" ~ 4,
    action_type=="Driving Bank shot" ~ 3,
    action_type=="Driving Dunk Shot" ~ 1,
    action_type=="Driving Finger Roll Layup Shot" ~ 3,
    action_type=="Driving Floating Bank Jump Shot" ~ 2,
    action_type=="Driving Floating Jump Shot" ~ 2,
    action_type=="Driving Hook Shot" ~ 4,
    action_type=="Driving Jump shot" ~ 2,
    action_type=="Driving Layup Shot" ~ 3,
    action_type=="Driving Reverse Dunk Shot" ~ 1,
    action_type=="Driving Reverse Layup Shot" ~ 3,
    action_type=="Driving Slam Dunk Shot" ~ 1,
    action_type=="Dunk Shot" ~ 1,
    action_type=="Fadeaway Bank shot" ~ 2,
    action_type=="Fadeaway Jump Shot" ~ 2,
    action_type=="Finger Roll Layup Shot" ~ 3,
    action_type=="Floating Jump shot" ~ 2,
    action_type=="Hook Bank Shot" ~ 4,
    action_type=="Hook Shot" ~ 4,
    action_type=="Jump Bank Hook Shot" ~ 2,
    action_type=="Jump Bank Shot" ~ 2,
    action_type=="Jump Hook Shot" ~ 2,
    action_type=="Jump Shot" ~ 2,
    action_type=="Layup Shot" ~ 3,
    action_type=="No Shot" ~ 6,
    action_type=="Pullup Bank shot" ~ 2,
    action_type=="Pullup Jump shot" ~ 2,
    action_type=="Putback Dunk Shot" ~ 1,
    action_type=="Putback Layup Shot" ~ 3,
    action_type=="Putback Reverse Dunk Shot" ~ 1,
    action_type=="Putback Slam Dunk Shot" ~ 1,
    action_type=="Reverse Dunk Shot" ~ 1,
    action_type=="Reverse Layup Shot" ~ 3,
    action_type=="Reverse Slam Dunk Shot" ~ 1,
    action_type=="Running Alley Oop Dunk Shot" ~ 1,
    action_type=="Running Alley Oop Layup Shot" ~ 3,
    action_type=="Running Bank Hook Shot" ~ 4,
    action_type=="Running Bank shot" ~ 3,
    action_type=="Running Finger Roll Layup Shot" ~ 3,
    action_type=="Running Hook Shot" ~ 4,
    action_type=="Running Jump Shot" ~ 2,
    action_type=="Running Layup Shot" ~ 3,
    action_type=="Running Pull-Up Jump Shot" ~ 2,
    action_type=="Running Reverse Dunk Shot" ~ 1,
    action_type=="Running Reverse Layup Shot" ~ 3,
    action_type=="Running Slam Dunk Shot" ~ 1,
    action_type=="Running Tip Shot" ~ 1,
    action_type=="Slam Dunk Shot" ~ 1,
    action_type=="Step Back Bank Jump Shot" ~ 2,
    action_type=="Step Back Jump shot" ~ 2,
    action_type=="Tip Dunk Shot" ~ 1,
    action_type=="Tip Layup Shot" ~ 3,
    action_type=="Tip Shot" ~ 1,
    action_type=="Turnaround Bank Hook Shot" ~ 4,
    action_type=="Turnaround Bank shot" ~ 2,
    action_type=="Turnaround Fadeaway Bank Jump Shot" ~ 2,
    action_type=="Turnaround Fadeaway shot" ~ 2,
    action_type=="Turnaround Hook Shot" ~ 4,
    action_type=="Turnaround Jump Shot" ~ 2,
  ))

nbashots17<-
  nbashots17 %>%
  mutate(team_name_new = case_when(
    team_name=="Atlanta Hawks" ~ 1,
    team_name=="Boston Celtics" ~ 2,
    team_name=="Brooklyn Nets" ~ 3,
    team_name=="Charlotte Hornets" ~ 4,
    team_name=="Chicago Bulls" ~ 5,
    team_name=="Cleveland Cavaliers" ~ 6,
    team_name=="Dallas Mavericks" ~ 7,
    team_name=="Denver Nuggets" ~ 8,
    team_name=="Detroit Pistons" ~ 9,
    team_name=="Golden State Warriors" ~ 10,
    team_name=="Houston Rockets" ~ 11,
    team_name=="Indiana Pacers" ~ 12,
    team_name=="Los Angeles Clippers" ~ 13,
    team_name=="Los Angeles Lakers" ~ 14,
    team_name=="Memphis Grizzlies" ~ 15,
    team_name=="Miami Heat" ~ 16,
    team_name=="Milwaukee Bucks" ~ 17,
    team_name=="Minnesota Timberwolves" ~ 18,
    team_name=="New Orleans Pelicans" ~ 19,
    team_name=="New York Knicks" ~ 20,
    team_name=="Oklahoma City Thunder" ~ 21,
    team_name=="Orlando Magic" ~ 22,
    team_name=="Philadelphia 76ers" ~ 23,
    team_name=="Phoenix Suns" ~ 24,
    team_name=="Portland Trail Blazers" ~ 25,
    team_name=="Sacramento Kings" ~ 26,
    team_name=="San Antonio Spurs" ~ 27,
    team_name=="Toronto Raptors" ~ 28,
    team_name=="Utah Jazz" ~ 29,
    team_name=="Washington Wizards" ~ 30,
    team_name=="New Jersey Nets" ~ 31
  ))

nbashots17<-
  nbashots17 %>%
  mutate(opponent_new = case_when(
    opponent=="Atlanta Hawks" ~ 1,
    opponent=="Boston Celtics" ~ 2,
    opponent=="Brooklyn Nets" ~ 3,
    opponent=="Charlotte Hornets" ~ 4,
    opponent=="Chicago Bulls" ~ 5,
    opponent=="Cleveland Cavaliers" ~ 6,
    opponent=="Dallas Mavericks" ~ 7,
    opponent=="Denver Nuggets" ~ 8,
    opponent=="Detroit Pistons" ~ 9,
    opponent=="Golden State Warriors" ~ 10,
    opponent=="Houston Rockets" ~ 11,
    opponent=="Indiana Pacers" ~ 12,
    opponent=="Los Angeles Clippers" ~ 13,
    opponent=="Los Angeles Lakers" ~ 14,
    opponent=="Memphis Grizzlies" ~ 15,
    opponent=="Miami Heat" ~ 16,
    opponent=="Milwaukee Bucks" ~ 17,
    opponent=="Minnesota Timberwolves" ~ 18,
    opponent=="New Orleans Pelicans" ~ 19,
    opponent=="New York Knicks" ~ 20,
    opponent=="Oklahoma City Thunder" ~ 21,
    opponent=="Orlando Magic" ~ 22,
    opponent=="Philadelphia 76ers" ~ 23,
    opponent=="Phoenix Suns" ~ 24,
    opponent=="Portland Trail Blazers" ~ 25,
    opponent=="Sacramento Kings" ~ 26,
    opponent=="San Antonio Spurs" ~ 27,
    opponent=="Toronto Raptors" ~ 28,
    opponent=="Utah Jazz" ~ 29,
    opponent=="Washington Wizards" ~ 30
    opponent=="New Jersey Nets" ~ 31
  ))

nbashots17<-
  nbashots17 %>%
  mutate(shot_type_new = case_when(
    shot_type=="2PT Field Goal" ~ 1,
    shot_type=="3PT Field Goal" ~ 2
  ))


nbashots17<-
  nbashots17 %>%
  mutate(action_type_new = case_when(
    action_type=="Alley Oop Dunk Shot" ~ 1,
    action_type=="Alley Oop Layup shot" ~ 3,
    action_type=="Cutting Dunk Shot" ~ 1,
    action_type=="Cutting Finger Roll Layup Shot" ~ 3,
    action_type=="Cutting Layup Shot" ~ 3,
    action_type=="Driving Bank Hook Shot" ~ 4,
    action_type=="Driving Bank shot" ~ 3,
    action_type=="Driving Dunk Shot" ~ 1,
    action_type=="Driving Finger Roll Layup Shot" ~ 3,
    action_type=="Driving Floating Bank Jump Shot" ~ 2,
    action_type=="Driving Floating Jump Shot" ~ 2,
    action_type=="Driving Hook Shot" ~ 4,
    action_type=="Driving Jump shot" ~ 2,
    action_type=="Driving Layup Shot" ~ 3,
    action_type=="Driving Reverse Dunk Shot" ~ 1,
    action_type=="Driving Reverse Layup Shot" ~ 3,
    action_type=="Driving Slam Dunk Shot" ~ 1,
    action_type=="Dunk Shot" ~ 1,
    action_type=="Fadeaway Bank shot" ~ 2,
    action_type=="Fadeaway Jump Shot" ~ 2,
    action_type=="Finger Roll Layup Shot" ~ 3,
    action_type=="Floating Jump shot" ~ 2,
    action_type=="Hook Bank Shot" ~ 4,
    action_type=="Hook Shot" ~ 4,
    action_type=="Jump Bank Hook Shot" ~ 2,
    action_type=="Jump Bank Shot" ~ 2,
    action_type=="Jump Hook Shot" ~ 2,
    action_type=="Jump Shot" ~ 2,
    action_type=="Layup Shot" ~ 3,
    action_type=="No Shot" ~ 6,
    action_type=="Pullup Bank shot" ~ 2,
    action_type=="Pullup Jump shot" ~ 2,
    action_type=="Putback Dunk Shot" ~ 1,
    action_type=="Putback Layup Shot" ~ 3,
    action_type=="Putback Reverse Dunk Shot" ~ 1,
    action_type=="Putback Slam Dunk Shot" ~ 1,
    action_type=="Reverse Dunk Shot" ~ 1,
    action_type=="Reverse Layup Shot" ~ 3,
    action_type=="Reverse Slam Dunk Shot" ~ 1,
    action_type=="Running Alley Oop Dunk Shot" ~ 1,
    action_type=="Running Alley Oop Layup Shot" ~ 3,
    action_type=="Running Bank Hook Shot" ~ 4,
    action_type=="Running Bank shot" ~ 3,
    action_type=="Running Finger Roll Layup Shot" ~ 3,
    action_type=="Running Hook Shot" ~ 4,
    action_type=="Running Jump Shot" ~ 2,
    action_type=="Running Layup Shot" ~ 3,
    action_type=="Running Pull-Up Jump Shot" ~ 2,
    action_type=="Running Reverse Dunk Shot" ~ 1,
    action_type=="Running Reverse Layup Shot" ~ 3,
    action_type=="Running Slam Dunk Shot" ~ 1,
    action_type=="Running Tip Shot" ~ 1,
    action_type=="Slam Dunk Shot" ~ 1,
    action_type=="Step Back Bank Jump Shot" ~ 2,
    action_type=="Step Back Jump shot" ~ 2,
    action_type=="Tip Dunk Shot" ~ 1,
    action_type=="Tip Layup Shot" ~ 3,
    action_type=="Tip Shot" ~ 1,
    action_type=="Turnaround Bank Hook Shot" ~ 4,
    action_type=="Turnaround Bank shot" ~ 2,
    action_type=="Turnaround Fadeaway Bank Jump Shot" ~ 2,
    action_type=="Turnaround Fadeaway shot" ~ 2,
    action_type=="Turnaround Hook Shot" ~ 4,
    action_type=="Turnaround Jump Shot" ~ 2,
  ))



write.csv(nbashots10,'nbashots10.csv')
write.csv(nbashots11,'nbashots11.csv')
write.csv(nbashots12,'nbashots12.csv')
write.csv(nbashots13,'nbashots13.csv')
write.csv(nbashots14,'nbashots14.csv')
write.csv(nbashots15,'nbashots15.csv')
write.csv(nbashots16,'nbashots16.csv')
write.csv(nbashots17,'nbashots17.csv')


ps_data <- read.csv("C:/Users/David Wong/OneDrive/Desktop/sta304 final rpoj/nba shots/NBA Shot Locations 1997 - 2020.csv", check.names=TRUE)

# Game_ID,Game_Event_ID,Player_ID,Player_Name,Team_ID,Team_Name,Period,Minutes Remaining,Seconds Remaining,Action_Type,Shot_Type,Shot_Zone_Basic,Shot_Zone_Area,Shot_Zone_Range,Shot_Distance,X_Location,Y_Location,Shot_Made_Flag,Game_Date,Home_Team,Away_Team,Season_Type
# Game ID,Game Event ID,Player ID,Player Name,Team ID,Team Name,Period,Minutes Remaining,Seconds Remaining,Action Type,Shot Type,Shot Zone Basic,Shot Zone Area,Shot Zone Range,Shot Distance,X Location,Y Location,Shot Made Flag,Game Date,Home Team,Away Team,Season Type

ps_data <-
  ps_data %>%
  mutate(team_name_new = case_when(
    Team.Name=="Atlanta Hawks" ~ 1,
    Team.Name=="Boston Celtics" ~ 2,
    Team.Name=="Brooklyn Nets" ~ 3,
    Team.Name=="Charlotte Hornets" ~ 4,
    Team.Name=="Chicago Bulls" ~ 5,
    Team.Name=="Cleveland Cavaliers" ~ 6,
    Team.Name=="Dallas Mavericks" ~ 7,
    Team.Name=="Denver Nuggets" ~ 8,
    Team.Name=="Detroit Pistons" ~ 9,
    Team.Name=="Golden State Warriors" ~ 10,
    Team.Name=="Houston Rockets" ~ 11,
    Team.Name=="Indiana Pacers" ~ 12,
    Team.Name=="Los Angeles Clippers" ~ 13,
    Team.Name=="LA Clippers" ~ 13,
    Team.Name=="Los Angeles Lakers" ~ 14,
    Team.Name=="Memphis Grizzlies" ~ 15,
    Team.Name=="Miami Heat" ~ 16,
    Team.Name=="Milwaukee Bucks" ~ 17,
    Team.Name=="Minnesota Timberwolves" ~ 18,
    Team.Name=="New Orleans Pelicans" ~ 19,
    Team.Name=="New York Knicks" ~ 20,
    Team.Name=="Oklahoma City Thunder" ~ 21,
    Team.Name=="Orlando Magic" ~ 22,
    Team.Name=="Philadelphia 76ers" ~ 23,
    Team.Name=="Phoenix Suns" ~ 24,
    Team.Name=="Portland Trail Blazers" ~ 25,
    Team.Name=="Sacramento Kings" ~ 26,
    Team.Name=="San Antonio Spurs" ~ 27,
    Team.Name=="Toronto Raptors" ~ 28,
    Team.Name=="Utah Jazz" ~ 29,
    Team.Name=="Washington Wizards" ~ 30,
    Team.Name=="New Jersey Nets" ~ 31,
    Team.Name=="Seattle SuperSonics" ~ 32,
    Team.Name=="Charlotte Bobcats" ~ 33,
    Team.Name=="New Orleans Hornets" ~ 34,
    Team.Name=="New Orleans/Oklahoma City Hornets" ~ 34,
    Team.Name=="Vancouver Grizzlies" ~ 35
  ))


ps_data<-
  ps_data %>%
  mutate(shot_type_new = case_when(
    Shot.Type=="2PT Field Goal" ~ 1,
    Shot.Type=="3PT Field Goal" ~ 2
  ))


ps_data<-
  ps_data %>%
  mutate(action_type_new = case_when(
    Action.Type=="Alley Oop Dunk Shot" ~ 1,
    Action.Type=="Alley Oop Layup shot" ~ 3,
    Action.Type=="Cutting Dunk Shot" ~ 1,
    Action.Type=="Cutting Finger Roll Layup Shot" ~ 3,
    Action.Type=="Cutting Layup Shot" ~ 3,
    Action.Type=="Driving Bank Hook Shot" ~ 4,
    Action.Type=="Driving Bank shot" ~ 3,
    Action.Type=="Driving Dunk Shot" ~ 1,
    Action.Type=="Driving Finger Roll Layup Shot" ~ 3,
    Action.Type=="Driving Floating Bank Jump Shot" ~ 2,
    Action.Type=="Driving Floating Jump Shot" ~ 2,
    Action.Type=="Driving Hook Shot" ~ 4,
    Action.Type=="Driving Jump shot" ~ 2,
    Action.Type=="Driving Layup Shot" ~ 3,
    Action.Type=="Driving Reverse Dunk Shot" ~ 1,
    Action.Type=="Driving Reverse Layup Shot" ~ 3,
    Action.Type=="Driving Slam Dunk Shot" ~ 1,
    Action.Type=="Dunk Shot" ~ 1,
    Action.Type=="Fadeaway Bank shot" ~ 2,
    Action.Type=="Fadeaway Jump Shot" ~ 2,
    Action.Type=="Finger Roll Layup Shot" ~ 3,
    Action.Type=="Floating Jump shot" ~ 2,
    Action.Type=="Hook Bank Shot" ~ 4,
    Action.Type=="Hook Shot" ~ 4,
    Action.Type=="Jump Bank Hook Shot" ~ 2,
    Action.Type=="Jump Bank Shot" ~ 2,
    Action.Type=="Jump Hook Shot" ~ 2,
    Action.Type=="Jump Shot" ~ 2,
    Action.Type=="Layup Shot" ~ 3,
    Action.Type=="No Shot" ~ 6,
    Action.Type=="Pullup Bank shot" ~ 2,
    Action.Type=="Pullup Jump shot" ~ 2,
    Action.Type=="Putback Dunk Shot" ~ 1,
    Action.Type=="Putback Layup Shot" ~ 3,
    Action.Type=="Putback Reverse Dunk Shot" ~ 1,
    Action.Type=="Putback Slam Dunk Shot" ~ 1,
    Action.Type=="Reverse Dunk Shot" ~ 1,
    Action.Type=="Reverse Layup Shot" ~ 3,
    Action.Type=="Reverse Slam Dunk Shot" ~ 1,
    Action.Type=="Running Alley Oop Dunk Shot" ~ 1,
    Action.Type=="Running Alley Oop Layup Shot" ~ 3,
    Action.Type=="Running Bank Hook Shot" ~ 4,
    Action.Type=="Running Bank shot" ~ 3,
    Action.Type=="Running Finger Roll Layup Shot" ~ 3,
    Action.Type=="Running Hook Shot" ~ 4,
    Action.Type=="Running Jump Shot" ~ 2,
    Action.Type=="Running Layup Shot" ~ 3,
    Action.Type=="Running Pull-Up Jump Shot" ~ 2,
    Action.Type=="Running Reverse Dunk Shot" ~ 1,
    Action.Type=="Running Reverse Layup Shot" ~ 3,
    Action.Type=="Running Slam Dunk Shot" ~ 1,
    Action.Type=="Running Tip Shot" ~ 1,
    Action.Type=="Slam Dunk Shot" ~ 1,
    Action.Type=="Step Back Bank Jump Shot" ~ 2,
    Action.Type=="Step Back Jump shot" ~ 2,
    Action.Type=="Tip Dunk Shot" ~ 1,
    Action.Type=="Tip Layup Shot" ~ 3,
    Action.Type=="Tip Shot" ~ 1,
    Action.Type=="Turnaround Bank Hook Shot" ~ 4,
    Action.Type=="Turnaround Bank shot" ~ 2,
    Action.Type=="Turnaround Fadeaway Bank Jump Shot" ~ 2,
    Action.Type=="Turnaround Fadeaway shot" ~ 2,
    Action.Type=="Turnaround Hook Shot" ~ 4,
    Action.Type=="Turnaround Jump Shot" ~ 2,
    Action.Type=="Driving Finger Roll Shot" ~ 3,
    Action.Type=="Follow Up Dunk Shot"~ 1,
    Action.Type=="Finger Roll Shot"~ 3,
    Action.Type=="Turnaround Finger Roll Shot"~ 3,
    Action.Type=="Running Finger Roll Shot"~ 3,
    Action.Type=="Running Dunk Shot"~ 1
  ))


# Driving Finger Roll Shot, Follow Up Dunk Shot, Finger Roll Shot, 	
# Turnaround Finger Roll Shot, Running Finger Roll Shot, 	
# Running Dunk Shot
ps_data <- ps_data %>% 
  select(c(Team.Name, Shot.Made.Flag, Action.Type, Shot.Type, shot_type_new, action_type_new))

write.csv(ps_data,'ps_data.csv')

