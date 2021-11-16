# BSDBigot's Random Data Generator

## Requirements
1. PERL 5.10 or greater

## Usage
1. Edit mix.pl to set your initialization values:
   - $id: this is the start of the sequence to provide a primary key
   - $max: this is the number of records you want to generate
   - sub is_male: this is a placeholder which attempts to land a gender (and a gender-based name) using 2020 Census figures
2. Optionally add or remove values from the various source files.
3. Run mix.pl.  Data will be provided on STDOUT.

## Data Considerations
All data, input and output, is UNIX-formatted (newline only (ASCII 10)) with no trailing newline on the last record.

### Output Data
Data is output to STDOUT in CSV format.  There are no internal commas in the stock source data, except for the cities.csv file, which is handled internally by basically pretending it's not.
Format: ID,FIRST,LAST,EMAIL,GENDER,VERTICAL,JOBTITLE,CITY,STATE

### Source Data
This dataset comprises the values that will be combined randomly to generate a new output record.  You may add or remove values from these lists without affecting the operation of the program.  Internal duplicates are discouraged, attempt to use the weighting feature, instead.
* cities.csv - top 100 most populous cities in USA
  - format: City Name,State Name|weight
* female.csv - top 100 female names
  - format: Name|weight
* jobtitles.csv - top 100 job titles
  - format: Name|weight
* lastnames.csv - top 100 surnames
  - format: Name|weight
* male.csv - top 100 male names
  - format: Name|weight
* verticals.csv - list of 5 industry categories
  - format: Name|weight

### Weighting
The weighting algorithm is a placeholder.  The way it currently works is to re-spin the dice for a given column if a random integer up to 100 is greater than the specified weight, until it satisfies the condition.  You will have to play around with the values, the stock files are all set to 100.

## Gender decisioning
There is a subroutine called is_male() that can be tweaked to provide a different split on gender populations.  As it is currently just a random, there is a distinct possibility that the percentages will be skewed on smaller output datasets.  To correct this, rerun as many times as you want until you get a representative dataset for your use case.  Or, feel free to write a different algorithm.

## License
BSD
