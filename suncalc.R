library(suncalc)
library(lubridate)
library(dplyr)
library(tidyr)
library(ggplot2)

current_dt = as.POSIXct(format(Sys.time()),tz="CET")
current_date = as.Date(Sys.Date(),tz="CET")
dates_in_2021 = seq.Date(from = dmy("01-01-2021"),to = dmy("31-12-2021"),by = "1 day")

suncalc::getSunlightPosition(date = current_dt,lat = 56.1572,lon = 10.2107)

suncalc::getSunlightTimes(date = current_date,
                          lat = 56.1572,
                          lon = 10.2107,
                          tz = "CET",
                          keep = c("solarNoon", 
                                   "sunrise", 
                                   "sunset", 
                                   "sunriseEnd",
                                   "sunsetStart", 
                                   "dawn", 
                                   "dusk", 
                                   "nauticalDawn", 
                                   "nauticalDusk",
                                   "night", 
                                   "goldenHourEnd", 
                                   "goldenHour")) %>% 
  gather(EventName,EventTime,solarNoon:goldenHour) %>% 
  arrange(EventTime)


### 2021 Dates
df.dates_2021 =
  suncalc::getSunlightTimes(date = dates_in_2021,
                            lat = 56.1572,
                            lon = 10.2107,
                            tz = "CET",
                            keep = c("solarNoon", 
                                     "sunrise", 
                                     "sunset", 
                                     "sunriseEnd",
                                     "sunsetStart", 
                                     "dawn", 
                                     "dusk", 
                                     "nauticalDawn", 
                                     "nauticalDusk",
                                     "night", 
                                     "goldenHourEnd", 
                                     "goldenHour")) %>% 
  gather(EventName,EventTime,solarNoon:goldenHour)

ggplot(df.dates_2021,aes(x=date,y = EventTime_M)) +
  geom_point(aes(color=EventName))
