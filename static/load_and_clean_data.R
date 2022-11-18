library(tidyverse)
library(readr)

# read the original dataset
HighwayRail<-read_csv(here::here("dataset-ignore", "Highway-Rail_Grade_Crossing_Accident_Data.csv"), show_col_types = FALSE)

# clean the data, only keep data in MA
HighwayRail_MA <- HighwayRail %>% filter(`State Name` == "MASSACHUSETTS") 

# select necessary column names for MA in the original dataset
MA_select <- HighwayRail_MA %>%
  select(`Report Year`, Date,	Month, Day, Hour, Minute, `AM/PM`, Time, `Nearest Station`, 	Subdivision,	`County Name`, `State Name`,`Highway Name`,`Public/Private Code`, `Public/Private`, `Highway User`, `Estimated Vehicle Speed`,`Vehicle Direction`,	`Highway User Position`,`Equipment Involved`, `Equipment Struck`, Temperature, Visibility, `Weather Condition`, `Number of Locomotive Units`, `Number of Cars`, `Train Speed`, `Estimated/Recorded Speed`,	 `Train Direction`, `Crossing Warning Expanded 1`,`Crossing Warning Expanded 2`,`Crossing Warning Expanded 3`,`Crossing Warning Expanded 4`,`Crossing Warning Expanded 5`,`Crossing Warning Expanded 6`,`Crossing Warning Expanded 7`,`Crossing Warning Expanded 8`,`Crossing Warning Expanded 9`, `Crossing Warning Expanded 10`, `Crossing Warning Expanded 11`,	`Crossing Warning Expanded 12`,	`Signaled Crossing Warning Code`, `Signaled Crossing Warning`, `Roadway Condition`,	`Crossing Warning Location`,	`Warning Connected To Signal`, `Crossing Illuminated`,`User Age`,`User Gender`,`User Struck By Second Train`, `Highway User Action`, `View Obstruction`, `Driver Condition`, `Driver In Vehicle`, `Crossing Users Killed For Reporting Railroad`, `Crossing Users Injured For Reporting Railroad`, `Vehicle Damage Cost`,	`Employees Killed For Reporting Railroad`, `Employees Injured For Reporting Railroad`, `Passengers Killed For Reporting Railroad`, `Passengers Injured For Reporting Railroad`, Narrative)

# fixing the typo 
library('stringr')
MA_select$`County Name` <- str_replace_all(MA_select$`County Name`, "WORCHESTER", "WORCESTER")

write_csv(MA_select, file = here::here("dataset", "MA_select.csv"))

save(MA_select, file = here::here("dataset/MA_select.RData"))
