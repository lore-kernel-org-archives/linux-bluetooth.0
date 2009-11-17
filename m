Return-Path: <cyrus@holtmann.org>
Date: Tue, 17 Nov 2009 09:45:33 -0800
From: "Luis R. Rodriguez" <lrodriguez@atheros.com>
To: Marcel Holtmann <marcel@holtmann.org>
CC: Vikram Kandukuri <Vikram.Kandukuri@Atheros.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, Luis
 Rodriguez <Luis.Rodriguez@Atheros.com>
Subject: Re: [PATCH] DFU Driver and firmware for Atheros bluetooth chipset
	AR3011
Message-ID: <20091117174533.GB11382@tux>
References: <20091117143613.GA29705@atheros-laptop> <1258469940.2003.25.camel@violet>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1258469940.2003.25.camel@violet>
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Nov 17, 2009 at 06:59:00AM -0800, Marcel Holtmann wrote:
> > diff --git a/firmware/atherosbt.bin b/firmware/atherosbt.bin
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..4a5ffb8de898fab1595662742f287493689e2b3b
> > GIT binary patch
> 
> What license is on this firmware. We can't include it into the Linux
> kernel unless it us under GPL.

Actually GPL-compatible.

> If it is a binary license and has a
> proper distribution license then it can go to the linux-firmware tree
> once you fixed the name of it of course.

Vikram, you can use this firmware if you are not opening up the firmware:

http://kernel.org/pub/linux/kernel/people/mcgrof/firmware/LICENCE.atheros_firmware

Our legal department has given us the blessing to use this for our firmware for
802.11 when we don't open it up and release it under a GPL-compatible license.

  Luis
