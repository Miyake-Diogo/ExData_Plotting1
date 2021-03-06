# Exploratory Data Analysis - COURSERA 
# Assignment 1

# I Start Viewing and setting my work directory:
getwd()
setwd("C:/MEGASYNC/Cursos_andamento/Coursera_DataScienceSpecialization_UJH/04_EXPLORATORY_DATA_ANALYSIS/WEEK1/Assignments")

# Import and load data.table Package
install.packages("data.table")
library(data.table)

#Reads in data from file then subsets data for specified dates
powerData <- data.table::fread(input = "Data/household_power_consumption.txt"
                               , na.strings="?")
dim(powerData)
head(powerData)

# Prevents Scientific Notation
powerData[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]

# Making a POSIXct date capable of being filtered and graphed by time of day
powerData[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]

# Filter Dates for 2007-02-01 and 2007-02-02
powerData <- powerData[(dateTime >= "2007-02-01") & (dateTime < "2007-02-03")]

png("plot2.png", width=480, height=480)

## Plot 2
plot(x = powerData[, dateTime]
     , y = powerData[, Global_active_power]
     , type="l", xlab="", ylab="Global Active Power (kilowatts)")

dev.off()
