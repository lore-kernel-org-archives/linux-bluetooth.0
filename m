Return-Path: <cyrus@holtmann.org>
From: Gene Heskett <gene.heskett@verizon.net>
To: Stefan Seyfried <stefan.seyfried@googlemail.com>
Subject: Re: need understanding about bt
Date: Wed, 06 Jan 2010 16:10:22 -0500
Cc: linux-bluetooth@vger.kernel.org
References: <201001051910.08204.gene.heskett@verizon.net>
 <20100106092350.47ba4a63@strolchi.home.s3e.de>
In-reply-to: <20100106092350.47ba4a63@strolchi.home.s3e.de>
MIME-version: 1.0
Content-type: Text/Plain; charset=iso-8859-1
Message-id: <201001061610.22914.gene.heskett@verizon.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wednesday 06 January 2010, Stefan Seyfried wrote:
[...]

>Note that the test-serial has a fixed timeout of 1000 seconds and will
>close the link afterwards, but that should be trivial to hack out of
>the script.

I already had a script I'd played the 10,000 monkeys scene writing, so I just 
streamlined that one.  No timeouts in it. ;)

>If you want to use the old-fashioned style, I had written some
>documentation about that in a former life. It's still available through
>http://en.opensuse.org/Bluetooth/rfcomm (it's not SUSE-specific at all,
>if anything, you might need to put a call to "rfcomm bind all" into a
>late-running init script for your distro).

I've done that, except the bind is issued for the bdaddr, enabled the script 
and it works for at least the last reboot.

I think the newer kernels have helped make it dependable now.

Many thanks.

>Hope this helps and Good Luck :-)
>
>	seife
>


-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)

The cable TV sex channels don't expand our horizons, don't make us better
people, and don't come in clearly enough.
		-- Bill Maher
