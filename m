Return-Path: <cyrus@holtmann.org>
From: Gene Heskett <gene.heskett@verizon.net>
To: linux-bluetooth@vger.kernel.org
Subject: need understanding about bt
Date: Tue, 05 Jan 2010 19:10:08 -0500
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Message-id: <201001051910.08204.gene.heskett@verizon.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Greetings all;

I have a usb dongle that my system finds ok I guess, and when I run blueman-
manager, it shows the remote device, an EB-101 that is presently powered up, 
as 'trusted and bonded'.  Kewl I'm thinking.  But /dev/rfcomm0 is not being 
created, so while it appears the devices are talking ok, this box is 
apparently incapable of using it.

The EB-101 has a shell running against it on the other end, and when rfcomm0 
is properly made, then I can start a minicom session that is effectively a 
terminal on the other system.

So, how do I reliably get this /dev/rfcomm0 device created?  Running kernels 
in the 2.6.32.x range here.

Thanks.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)

Taxes are going up so fast, the government is likely to price itself
out of the market.
