Return-Path: <thomae@ei.tum.de>
Message-ID: <401F6549.2020400@ei.tum.de>
Date: Tue, 03 Feb 2004 10:09:29 +0100
From: Matthias Thomae <thomae@ei.tum.de>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] cmtp, capidrv and kernel 2.6
References: <401A269C.7070104@ei.tum.de> <1075562378.2720.8.camel@pegasus>
In-Reply-To: <1075562378.2720.8.camel@pegasus>
Content-Type: text/plain; charset=us-ascii; format=flowed
List-ID: <bluez-users.lists.sourceforge.net>

Hi Marcel,

Marcel Holtmann wrote:
>>could anyone give a hint what changes are necessary from kernel 2.4.X to 
>>2.6.X to get an isdn dialup setup via cmtp and capidrv (i4l)?
> 
> 
> the I4L and CAPI ISDN subsystem of 2.6 must be resynced and I hope
> Karsten Keil is doing this very soon. For now apply the i4l-t9bk22 patch
> and try again.

Thank you for your hint, I tried again and it seems to work now :)))


>>- cmtp and kernelcapi are loaded and connecting to an AP-X works
> 
> You have to load capi.ko by hand and mount the capifs.

Ok, that's one that I missed.

>>- capidrv isn't loaded automatically any more
> 
> Can't tell you why, but simply load it :)

Well, I had to learn that there is the directory /etc/modprobe.d first...

>>- "/etc/init.d/isdnutils start" complains about /dev/isdnctrl (because 
>>of missing capidrv?)
> 
> Maybe the scripts need a little bit 2.6 cleanup.

Don't think so, that was due to the missing capidrv.

>>I use debian/unstable with the latest isdn and capi packages (3.3-7).
> 
> With the i4l-t9bk22 the CAPI part should work perfect.

Seems to :)

>>Do I have to modify the module loading definitions in /etc/modutils?
> 
> Not that I know of.

Well, I copied them to the new /etc/modprobe.d, e.g.:
alias char-major-43 capidrv
alias char-major-44 capidrv
alias char-major-45 capidrv

>>Does pppdcapiplugin work without additional kernel patches?
> 
> No.

But it seems to with the i4l-t9bk22 patch :)

Cheerio
Matthias
