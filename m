Return-Path: <noring@nocrew.org>
Subject: Re: [Bluez-devel] D-Bus interfaces
From: Fredrik Noring <noring@nocrew.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1076324584.6869.109.camel@pegasus>
References: <1076265358.2670.36.camel@pegasus>
	 <1076266267.14742.38.camel@akka.yeti.nocrew.org>
	 <1076267396.2670.58.camel@pegasus>
	 <1076275689.14742.93.camel@akka.yeti.nocrew.org>
	 <1076277250.6869.24.camel@pegasus>
	 <1076278554.14742.112.camel@akka.yeti.nocrew.org>
	 <1076279508.6869.54.camel@pegasus>
	 <1076280612.14742.147.camel@akka.yeti.nocrew.org>
	 <1076282343.6869.65.camel@pegasus>
	 <1076284317.14742.179.camel@akka.yeti.nocrew.org>
	 <1076287085.6869.70.camel@pegasus>
	 <1076311376.14742.202.camel@akka.yeti.nocrew.org>
	 <1076321200.6869.75.camel@pegasus>
	 <1076322129.5263.28.camel@kalkyl.roxen.com>
	 <1076323138.6869.93.camel@pegasus>
	 <1076323602.5263.41.camel@kalkyl.roxen.com>
	 <1076324584.6869.109.camel@pegasus>
Content-Type: text/plain; charset=iso-8859-1
Message-Id: <1076327592.5263.64.camel@kalkyl.roxen.com>
Mime-Version: 1.0
Date: Mon, 09 Feb 2004 12:53:12 +0100
List-ID: <bluez-devel.lists.sourceforge.net>

Marcel,

mån 2004-02-09 klockan 12.03 skrev Marcel Holtmann:
> I don't wanna support a config file which is intend to be editable by a
> user and changable by a program. This is always a mess.

That's actually the way many other configuration tools in Linux works...
Like it or not, it's the simplest and most robust way to have it working
because you will have to trust the administrator of the system for
certain things anyway. 

If the administrator decides to edit a system file, it's very likely
because something really needs to be done. Hiding the real configuration
files behind special binary databases is a true nightmare when stuff
simply isn't working.

> We need to write a command line utility with full support anyway, because
> the interface must be tested.

Emacs/grep/awk/perl et. al. are much more powerful than most special 
tools. The user interfaces, DBus interfaces and tools only need to 
support the common cases when plain text files are used. This shouldn't 
stop anyone from actually implementing _all_ configuration features in some 
tool, but the advanced stuff can be also be left to the administrator.

Fredrik
