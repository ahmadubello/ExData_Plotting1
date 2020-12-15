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

windows(width = 480, height = 480,bg = "white")
# plot
with(all_data_date, plot(DateTime, Sub_metering_1, type = "n", ylab = "Energy sub metering", xlab = ""))
with(all_data_date, lines(DateTime, Sub_metering_1))
with(all_data_date, lines(DateTime, Sub_metering_2, col = "red"))
with(all_data_date, lines(DateTime, Sub_metering_3, col = "blue"))
legend("topright", lty = 1, legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"))

# save plot as png
dev.copy(png, file = "plot3.png", width = 480, height = 480, unit = "px")
dev.off()

