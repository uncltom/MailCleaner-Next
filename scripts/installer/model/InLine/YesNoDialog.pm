#!/usr/bin/env perl
#
#   Mailcleaner - SMTP Antivirus/Antispam Gateway
#   Copyright (C) 2004 Olivier Diserens <olivier@diserens.ch>
#   Copyright (C) 2023 John Mertz <git@john.me.tz>
#
#   This program is free software; you can redistribute it and/or modify
#   it under the terms of the GNU General Public License as published by
#   the Free Software Foundation; either version 2 of the License, or
#   (at your option) any later version.
#
#   This program is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
#   GNU General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with this program; if not, write to the Free Software
#   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA

package model::InLine::YesNoDialog ;

use v5.36;
use strict;
use warnings;
use utf8;

require Exporter;
use Term::ReadKey;

our @ISA = qw(Exporter);
our @EXPORT = qw(build display);
our $VERSION = 1.0;

sub get
{
    my $text = '';
    my $default = '';

    my $this =  {
        text => $text,
        default => $default
    };

    bless $this, "model::InLine::YesNoDialog";
    return $this;
}

sub build($this, $text, $default='')
{
    $this->{text} = $text;
    $this->{default} = $this->getYesNo($default);

    return $this;
}

sub display($this)
{
    print $this->{text}."\n";
    print "Enter \"y\" or \"n\" [".$this->{default}."]: ";
    ReadMode 'normal';
    my $result = ReadLine(0);
    chomp $result;
    if ( $result eq "") {
        $result = $this->{default};
    }
    return $this->getYesNo($result);
}

sub clear($this)
{
    system('clear');
}

sub getYesNo($this, $value='no')
{
    return 'yes' if ($value =~ m/^(y|yes)$/i);
    return 'no';
}

1;
