#!/usr/bin/perl -w

use strict;
use File::Slurp;

# This is your starting ID in the sequence
my $id = 1;

# This is the number of records you want to generate
my $max = 10000;

my @males = read_file("male.csv", chomp => 1);
my @females = read_file("female.csv", chomp => 1);
my @surnames = read_file("lastnames.csv", chomp => 1);
my @verticals = read_file("verticals.csv", chomp => 1);
my @jobtitles = read_file("jobtitles.csv", chomp => 1);
my @cities = read_file("cities.csv", chomp => 1);

my $outline = "ID,FIRST,LAST,EMAIL,GENDER,VERTICAL,JOBTITLE,CITY,STATE";

print $outline, "\n";

for ( my $i = 0; $i < $max; $i++ )
{
	my ( $first, $last, $rand, $gender, $vertical, $jobtitle, $city );
	$first = $last = $rand = $gender = $vertical = $jobtitle = $city = "";

	while( "" eq $last )
	{
		$rand = int(rand($#surnames+1));
		$last = weight( $surnames[$rand] );
	}

	while( "" eq $city )
	{
		$rand = int(rand($#cities+1));
		$city = weight( $cities[$rand] );
	}

	while ( "" eq $vertical )
	{
		$rand = int(rand($#verticals+1));
		$vertical = weight( $verticals[$rand] );
	}

	while ( "" eq $jobtitle )
	{
		$rand = int(rand($#jobtitles+1));
		$jobtitle = weight( $jobtitles[$rand] );
	}

	if ( is_male( $i ) )
	{
		$gender = "M";
		while ( "" eq $first )
		{
			$rand = int(rand($#males+1));
			$first = weight( $males[$rand] );
		}
	}
	else
	{
		$gender = "F";
		while ( "" eq $first )
		{
			$rand = int(rand($#females+1));
			$first = weight( $females[$rand] );
		}
	}

	$outline = sprintf( "%d,%s,%s,%s.%s.%d\@not-a-real-domain,%s,%s,%s,%s",
		$id,
		$first,
		$last,
		$first,
		$last,
		int(rand($id)),
		$gender,
		$vertical,
		$jobtitle,
		$city
	);
		
	print $outline, "\n";
	$id++;
}

sub is_male
{
	#this could be tweaked - using Census 2020 figures
	my $m = 16226;
	my $f = 16723;
	my $t = $m + $f;
	my $q = int( rand( $t ) );
	if ( $q <= $m )
	{
		return( 1 );
	}
	return ( 0 );
}

sub weight
{
	my ( $input, $weight ) = split( '\|', $_[0] );
	my $test = int(rand(100));
	#printf STDERR ( "%d\t%s\t%d\t%d\n", $id, $input, $weight, $test );
	if ( $test <= $weight )
	{
		return( $input );
	}
	return( "" );
}

__END__
