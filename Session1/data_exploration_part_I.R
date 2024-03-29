###R for biologists
##Irina & Rao, 20/02/2024

# install.packages("tidyverse") # just need to do this once
# install.packages("dplyr") # just need to do this once; also no need to do this 
# if you ran the above line already (i.e. tidyverse is already installed)
library(tidyverse)
library(dplyr)
# DATASET ####
# Our World in Data - COVID dataset
# https://github.com/owid/covid-19-data/tree/master/public/data

# load the csv file directly from the website
# owid_covid = read.csv("https://covid.ourworldindata.org/data/owid-covid-data.csv", 
#                      header = TRUE, stringsAsFactors = FALSE)

# OR load the csv file that is in your Session3/data folder
owid_covid <- read.csv("Session1/data/owid-covid-data.csv", header = TRUE,
                      stringsAsFactors = FALSE)



# LOOK at the data ####
dim(owid_covid)
colnames(owid_covid)
View(owid_covid)
str(owid_covid)
nrow(owid_covid)
owid_covid$location # owid_covid[ , "location"]
unique(owid_covid$location)
table(owid_covid$location)
# DATA TYPES - do all the columns look okay, does anything need to be changed?
# Dates
?Dates
owid_covid$date = as.Date(owid_covid$date)
new_year = "2021-01-01"
class(new_year)
new_year = as.Date(new_year)
class(new_year)
new_year
as.numeric(new_year)
# MISSING DATA - are there any missing data? Do you want to remove/replace them? ####
# No for this dataset, because it's a very clean one already
# Can NAs be substituted with zero, for example in the total_vaccinations column?

# SORT data ####
# arrange(owid_covid, date) -> owid_covid_sorted_by_date
owid_covid %>%
  arrange(date) -> owid_covid_sorted_by_date

# sort by multiple columns

owid_covid %>%
  arrange(date, location) -> owid_covid_sorted_by_date_location

# SUBSET DATA - which columns should we keep? ####

colnames(owid_covid)

owid_covid %>%
  select(total_cases, total_deaths) -> owid_covid_selected
head(owid_covid_selected)
# FILTER DATA - should we filter data? What criteria should we use? ####
# The answer will depend on what you want to get out of the data
owid_covid[owid_covid$location == "United Kingdom", ] # base R
owid_covid %>%
  filter(location == "United Kingdom") -> owid_covid_uk
dim(owid_covid_uk)

owid_covid %>%
  filter(location == "Belgium") -> owid_covid_belgium

plot(x = owid_covid_uk$date, y = owid_covid_uk$total_cases_per_million)
plot(x = owid_covid_uk$date, y = owid_covid_uk$total_cases_per_million, col = "red")
plot(x = owid_covid_uk$date, y = owid_covid_uk$total_cases_per_million, type = "l")

# Q: Plot total deaths in the UK across time
plot(x = owid_covid_uk$date, y = owid_covid_uk$total_deaths, type = "l")


# CREATE new columns based on existing data ####

owid_covid %>%
  mutate(prop_new_deaths_to_cases = new_deaths/new_cases) -> owid_covid_prop_deaths_cases
head(owid_covid_prop_deaths_cases)

# create a new column using conditionals: using the if_else() function
owid_covid %>%
  mutate(hdi_class = if_else(human_development_index < 0.7, "red","blue")) -> owid_covid_hdi_class
View(owid_covid_hdi_class)
plot(x = owid_covid_hdi_class$date, y = owid_covid_hdi_class$total_deaths_per_million, col = owid_covid_hdi_class$hdi_class)

# PROBLEM SET for Part I ####
# Q: Filter the owid_covid dataset for only 4 countries: UK, US, Germany, Belgium

# Q: Plot test positivity rate in the UK across time, as a line graph


# Q: Create a new column in the dataset where the value should be "low" or "high" 
# depending on whether the population is lower or higher than the median population respectively

# We first need to calculate the median population; this can be done using base R or
# using dplyr, either method is fine. We store this value in the variable median_population

median_population = median(              , na.rm = TRUE) # Base R

# or

owid_covid %>%                                                  # dplyr
  

# Now we need to create a new column indicating whether the population for each
# country is lower or higher than the median population, using mutate() and if_else()
?if_else

owid_covid %>%
  mutate(pop_low_or_high = if_else(           ,      ,      )) -> owid_covid_pop_class
  
# Q: For data from Jan 1st 2021, plot the total cases (x) vs total deaths (y)
# How can this graph be improved?
new_year = "2021-01-01"
owid_covid %>%
  filter(date ==        ) -> owid_covid_newyear

plot(x =                    , y =                 )

# plot the same data in log10 scale
plot(x = log10(                               ), 
     y = log10(                               ), xlim = c(0, 4))

#### loop functions ####
# split() to separate every country data
owid_covid_split = split(owid_covid, owid_covid$location)
# Q: what is the data structure of owid_covid_split?

# peak deaths for each country
lapply(owid_covid_split, function(x) {
  max(x[["new_deaths"]])
})

# Q: Why are we getting so many NAs? How can we fix this?

# use sapply() for the above
