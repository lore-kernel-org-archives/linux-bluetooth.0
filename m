Return-Path: <cyrus@holtmann.org>
Date: Sun, 7 Feb 2010 14:30:15 +0100
From: Frank Maas <frank.maas@cheiron-it.nl>
To: linux-bluetooth@vger.kernel.org
Subject: Re: Problem with 'inquiry_cache' in sysfs
Message-ID: <20100207133015.GD28037@xs4all.nl>
References: <20100204220516.GC8556@xs4all.nl> <1265399409.31341.241.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1265399409.31341.241.camel@localhost.localdomain>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Marcel,

> > I am currently developing a system that relies heavily on the Linux 
> > bluetooth stack. That system uses the sysfs interface to the kernel 
> > module and more specifically the entry 'inquiry_cache' of the device 
> > "directory".
> 
> that file should have been moved to debugfs, but we haven't done that
> yet. It really doesn't belong in sysfs at all. And should not be treated
> as an API.

If I can be blunt: please remove it asap. It is very simple to make a 
system crash for a simple user while this is part of the distribution. 
And perhaps even worse options exists.

I'd like to point out that the functionality it offers is of use. As far 
as I have seen the 'hcitool' offers an inquiry functionality, but that 
starts an inquiry itself. The 'benefit' of the current inquire_cache 
file is that one can use it without having to wait for an inquiry to 
finish and while knowing that the cache is pretty recent. Perhaps 
hcitool could be extended with an option for 'inq' that suppresses the 
inquiry itself?

Kind regards,
Frank

