#!/usr/bin/perl

#Andrew McLaughlin
#27Sep18
#Phishing Scanner

use strict;
use warnings;

my $tCount = 0;
my $fraction = 0;

#open file listing common phishing words
open(FILE, "phishingWords.txt") or die "could not open phishingWords.txt\n";

#make list of the phishing words and their number of appearances
while(<FILE>)
{
	#make variable word have value of word in phishingWords file
	my $word = $_;

	#open file to be tested for phishing
	open(TEST, "test.txt") or die "could not open test file\n";

	my $count = 0;

	#count instances of each phishing word
	while(<TEST>)
	{
		if ($_ =~ /$word/)
		{
			$count++;
		}
	}

	$tCount += $count;

	chomp($word);

	print("$word = $count\n");

	close (TEST);
}
close(FILE);

#count every word in test file
open(TEST, "test.txt");

my $wordcount = 0;

while(<TEST>)
{
	$wordcount += split(/ /, $_);
}
close(TEST);

#determine the percentage of words in test file that are in phishing words file
$fraction = ($tCount / $wordcount) * 100;

#show percent
printf("%.2f", $fraction);
print("% of file is a phishing word\n");

#make recommendation of file
if ($fraction < 20)
{
	print("This file is likely not phishing\n");
}
else
{
	print("This file is likely a phishing file\n");
}
