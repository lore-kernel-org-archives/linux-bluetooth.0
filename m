Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] DFU Driver and firmware for Atheros bluetooth chipset
 AR3011
From: Marcel Holtmann <marcel@holtmann.org>
To: "Luis R. Rodriguez" <lrodriguez@atheros.com>
Cc: Vikram Kandukuri <Vikram.Kandukuri@Atheros.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Luis Rodriguez <Luis.Rodriguez@Atheros.com>
In-Reply-To: <20091117174533.GB11382@tux>
References: <20091117143613.GA29705@atheros-laptop>
	 <1258469940.2003.25.camel@violet>  <20091117174533.GB11382@tux>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 17 Nov 2009 21:29:01 +0100
Message-ID: <1258489741.2003.32.camel@violet>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luis,

> > > diff --git a/firmware/atherosbt.bin b/firmware/atherosbt.bin
> > > new file mode 100644
> > > index 0000000000000000000000000000000000000000..4a5ffb8de898fab1595662742f287493689e2b3b
> > > GIT binary patch
> > 
> > What license is on this firmware. We can't include it into the Linux
> > kernel unless it us under GPL.
> 
> Actually GPL-compatible.

true.

> > If it is a binary license and has a
> > proper distribution license then it can go to the linux-firmware tree
> > once you fixed the name of it of course.
> 
> Vikram, you can use this firmware if you are not opening up the firmware:
> 
> http://kernel.org/pub/linux/kernel/people/mcgrof/firmware/LICENCE.atheros_firmware
> 
> Our legal department has given us the blessing to use this for our firmware for
> 802.11 when we don't open it up and release it under a GPL-compatible license.

I am more than happy to work on getting a fully open source and GPL
compatible firmware into the kernel, but until then, this needs to be
send to the linux-firmware tree with a similar LICENSE file.

Regards

Marcel


