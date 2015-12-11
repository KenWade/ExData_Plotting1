####
#
#   plot1.R
#
#   Exploratory Data Analysis (class.coursera.org/exdata-035)
#
#   Making Plots
#
#       Our overall goal here is simply to examine how household energy usage varies over a 2-day period in
#       February, 2007. Your task is to reconstruct the following plots below, all of which were constructed using
#       the base plotting system.
#

####
#
#   Setup Libraries
#

library(lubridate)

####
#
#    Read in the Electric power consumption data from the working directory
#
#       As a side detail suggusted in the project description...
#           find the size of the data frame object and consider the implecations.
#
#               Input file size:        132,960,755 bytes ~ 130MB
#               Data Frame object.size: 149,581,752 bytes ~ 142MB
#               Data Frame dimensions:  2075259 obs. of  9 variables
#               Rule of Thumb:          rows * columns * 8 bytes = 149,418,648 bytes ~ 142MB
#
#               Actual:
#                   7.12 bytes per variable per observation in the data file
#                   8.00 bytes per variable per observation in the data frame
#
# Data daken from UCI Machine Learning Repository:
#                   https://archive.ics.uci.edu/ml/datasets/Individual+household+electric+power+consumption
#
# Downloaded from: https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip

get_household_power_consumption_data <- function() {

    hpc_filename   <- "household_power_consumption.txt"
    hpc_colClasses <- c("character",  "character", "numeric", "numeric", "numeric",
                        "numeric", "numeric", "numeric", "numeric")
    hpc_nastrings  <- "?"

    minDate <- as.Date("2007-02-01", "%Y-%m-%d")
    maxDate <- as.Date("2007-02-02", "%Y-%m-%d")

    epcFull <- read.table(hpc_filename, header=TRUE, sep=";", colClasses = hpc_colClasses, na.strings = hpc_nastrings)

    hpc_filesize   <- file.size(hpc_filename)
    hpc_objectsize <- object.size(epcFull)
    bytes_per_variable_per_observation_in_datafile <- hpc_filesize / ncol(epcFull) / nrow(epcFull)
    bytes_per_variable_per_observation_in_object   <- hpc_objectsize / ncol(epcFull) / nrow(epcFull)
    
####
#
#   Convert date and time to R date and time classes and
#

    epcFull$datetime <- strptime(paste(epcFull$Date, epcFull$Time, sep = " "), "%d/%m/%Y %H:%M:%S")

####
#
#   Select only the dates of interest
#

    epc <- subset(epcFull, (as.Date(epcFull$datetime) >= minDate) & (as.Date(epcFull$datetime) <= maxDate))

    return(epc)
}

#######################################################################
#
# Make Plot1
#
#######################################################################

epc <- get_household_power_consumption_data()

png(filename = "plot1.png", width = 480, height = 480, units = "px")
hist(epc$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)",
     col = "red", breaks = 12)
dev.off()


