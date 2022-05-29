#!/usr/bin/perl

use strict;

my $templatef = shift;

die "$0 template-file < varsfile > output" if ! -e $templatef;

my %vars;

# learn vars
while (<>) {
  if (/^<<\s*([a-z][a-z0-9_]*)$/i) {
    my $varname = $1;
    die "Redefining $varname" if defined $vars{$varname};
    my $val = "";
    
    VAL: while (<>) {
      last VAL if /^>>\s*($varname)?$/;
      $val .= $_;
    }
    $vars{$varname} = $val;
    next;
  }

  die "Unused: $_" if ! /^\s*$/;
}


# read the template, paste the vars

sub replvar {
  my $var = shift;
  print STDERR "Undefined variable $var\n" if !defined $vars{$var};
  return $vars{$var};
}

open INF, $templatef or die "Can't read $templatef";
while (<INF>) {
  s/<<([a-z][a-z0-9_]*)>>/replvar $1/gie;
  print;
}
close INF;
  
