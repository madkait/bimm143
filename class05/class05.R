#install.packages("ggplot2")
library(ggplot2)
ggplot(cars) +
  aes(x = speed, y =dist) +
  geom_point()

ggplot(cars) +
  aes(x = speed, y =dist) +
  geom_point() + 
  geom_smooth() + #adds a trend line
  labs(title = "Speed and Stopping Distances of Cars",
       x = "Speed (MPH)",
       y = "Stopping Distance (ft)",
       subtitle = "informative subtitle",
       caption = "Dataset: 'cars'") +
  theme_bw()

url <- "https://bioboot.github.io/bimm143_S20/class-material/up_down_expression.txt"
genes <- read.delim(url)
head(genes)
nrow(genes)
colnames(genes)
ncol(genes)
table(genes$State)

p <- ggplot(genes) + 
  aes(x = Condition1, y = Condition2, col = State) + 
  geom_point()

p + scale_color_manual(values = c("green", "grey", "pink")) +
  labs(title = "Gene Expression Changes Upon Drug Treatment",
       x = "Control (no drug)", y = "Drug Treatment")

url2 <-"https://raw.githubusercontent.com/jennybc/gapminder/master/inst/extdata/gapminder.tsv"
gapminder <- read.delim(url2)
#install.packages("dplyr")
library(dplyr)
gapminder_2007 <- gapminder %>% filter(year==2007)
ggplot(gapminder_2007) +
  aes(x=gdpPercap, y=lifeExp, color = continent, size = pop) +
  geom_point(alpha=0.5) +
  scale_size_area(max_size = 10)

gapminder_1957 <- gapminder %>% filter(year == 1957)
ggplot(gapminder_1957) +
  aes(x = gdpPercap, y =lifeExp, color = continent, size = pop) +
  geom_point(alpha = 0.7)+
  scale_size_area(max_size = 15)

gapminder_comp <- gapminder %>% filter(year == 1957 | year == 2007)
ggplot(gapminder_comp) + 
  geom_point(aes(x = gdpPercap, y = lifeExp, color = continent, size = pop),
                 alpha = 0.7) +
  scale_size_area(max_size = 10) + 
  facet_wrap(~year)

#bar charts
gapminder_top_5 <- gapminder %>% 
  filter(year == 2007) %>%
  arrange(desc(pop)) %>%
  top_n(5,pop)

ggplot(gapminder_top_5) +
  geom_col(aes(x = country, y = pop, fill = lifeExp)) 

#plot pop size by country
ggplot(gapminder_top_5) + 
  aes(x = reorder(country, -pop), y = pop, fill = country) +
  geom_col(col = "gray30") +
  guides(fill = "none") 

#install.packages("patchwork")
library(patchwork)
p1 <- ggplot(mtcars) + geom_point(aes(mpg, disp))
p2 <- ggplot(mtcars) + geom_boxplot(aes(gear, disp, group = gear))
p3 <- ggplot(mtcars) + geom_smooth(aes(disp, qsec))
p4 <- ggplot(mtcars) + geom_bar(aes(carb))

#patchwork
(p1 | p2 | p3) / 
  p4
