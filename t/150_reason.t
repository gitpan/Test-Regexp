#!/usr/bin/perl

use strict;
use warnings;
no  warnings 'syntax';

use 5.010;

use Test::Tester;
use Test::Regexp;
use t::Common;

my $match_res;

foreach my $reason (undef, "", 0, "Bla bla bla") {
    foreach my $name ("", "Baz", "Qux Quux") {
        foreach my $match (0, 1) {
            my ($premature, @results) = run_tests sub {
                $match_res = match subject => "Foo",
                                   pattern => $match ? qr {Foo} : qr {Bar},
                                   match   => $match,
                                   reason  => $reason,
                                   test    => $reason,
                                   name    => $name,
            };

            check results   => \@results,
                  premature => $premature,
                  expected  => $match ? 'PPPP' : 'P',
                  match     => $match,
                  match_res => $match_res,
                  pattern   => 'Bar',
                  subject   => "Foo",
                  comment   => $name,
                  keep      => 0,
        $match ? (test      => $reason)
               : (reason    => $reason),
            ;
        }
    }
}


__END__
