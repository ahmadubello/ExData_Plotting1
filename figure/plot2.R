# read the data
unzip("household_power_consumption.zip")
all_data <- read.table("household_power_consumption.txt", sep = ";", header = TRUE,
                       na.strings = "?", stringsAsFactors = FALSE)
# index of the needed date
needed_rows <- all_data$Date == "1/2/2007" | all_data$Date == "2/2/2007"

# select the needed dates from data
all_data_date <- all_data[needed_rows, ]

# create a DateTime colomn from the Date and Time colums
all_data_date$DateTime <- paste(all_data_date$Date, all_data_date$Time, sep = " ")
all_data_date$DateTime <- strptime(all_data_date$DateTime, format = "%d/%m/%Y %H:%M:%S")

# plot
plot(all_data_date$DateTime, all_data_date$Global_active_power, type = "l",
     ylab = "Global Active Power (kilowatts)", xlab = "")

# save plot as png
dev.copy(png, file = "plot2.png", width = 480, height = 480, unit = "px")
dev.off()

