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

# Specifies the columns of x to be included in the special symbol .SD 
# which stands for Subset of data.table. May be character column names or numeric positions. 
# This is useful for speed when applying a function through a subset of (possible very many) columns;
# e.g., DT[, lapply(.SD, sum), by="x,y", .SDcols=301:350].
#-----#

# Prevents histogram from printing in scientific notation
powerData[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]

# Change Date Column to Date Type
powerData[, Date := lapply(.SD, as.Date, "%d/%m/%Y"), .SDcols = c("Date")]

# Filter Dates for 2007-02-01 and 2007-02-02
powerData <- powerData[(Date >= "2007-02-01") & (Date <= "2007-02-02")]

png("plot1.png", width=480, height=480)

## Plot 1
hist(powerData[, Global_active_power], main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")

dev.off()

