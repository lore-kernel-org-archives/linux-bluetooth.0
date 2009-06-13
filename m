Return-Path: <cyrus@holtmann.org>
Subject: RE: [PATCH 1/4 v3] bluetooth: add btmrvl driver to support Marvell
 bluetooth devices
From: Marcel Holtmann <marcel@holtmann.org>
To: Bing Zhao <bzhao@marvell.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
In-Reply-To: <477F20668A386D41ADCC57781B1F704301EDD86CDF@SC-VEXCH1.marvell.com>
References: <1243978178-3403-1-git-send-email-bzhao@marvell.com>
	 <1244560807.3068.12.camel@localhost.localdomain>
	 <477F20668A386D41ADCC57781B1F704301EDD86A59@SC-VEXCH1.marvell.com>
	 <1244617643.3068.26.camel@localhost.localdomain>
	 <477F20668A386D41ADCC57781B1F704301EDD86CDF@SC-VEXCH1.marvell.com>
Content-Type: text/plain
Date: Sat, 13 Jun 2009 08:24:03 +0200
Message-Id: <1244874243.10845.3.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bing,

> > > > > This driver provides basic definitions and library functions to
> > > > > support Marvell Bluetooth enabled devices, such as 88W8688 WLAN/BT
> > > > > combo chip.
> > > >
> > > > so I created a bluetooth-mrvl-2.6 tree with your patches and already a
> > > > major collection of cleanup patches.
> > >
> > > Thanks for the cleanups.
> > >
> > > > The biggest problem right now is that your driver spits out casting
> > > > warnings like crazy. This is not acceptable. So please send me a patch
> > > > to fix these based on bluetooth-mrvl-2.6.
> > >
> > > Could you please let me know how to catch these casting warnings? I'm using GCC 4.3.2 with sparse
> > on x86 laptop (Fedora 8) but I couldn't get the warnings.
> >
> > let me guess, you are running a 32-bit kernel. Just run a 64-bit kernel
> > and you will see them. I am using Fedora 10.
> 
> Yes, I'm running 32-bit kernel. I'll try to install a 64-bit system and fix those warnings.

seriously don't do that. There is so many 32-bit stuff in the code that
I am afraid it will fall over on 64-bit machines. I have cleaned up
almost everything, but in btmrvl_sdio.c you have some nasty alignment
thing going on. Please fix that and test it on 64-bit systems since it
looks really scary.

Can you explain how the firmware loading process is suppose to work. The
code looks way too complicated for what I can make out of it. We have to
make this more readable.

> The whole btmrvl driver was ported from Marvell SD8688 Bluetooth reference driver. The Enter/Leave debug messages have been in there since very beginning. Sometimes these Enter/Leave things are useful for customers to debug when our reference driver is ported onto their own platform/OS.
> 
> 
> To make it easier to upstream kernel, I'm sending a patch to remove all Enter/Leave debug messages except for an Enter message with parameters passed in.

I removed them by myself since your patch was breaking with my cleanups.
It is pushed now and to please test the latest bluetooth-mrvl-2.6.git
tree.

> > And again, after that you are not done since the whole driver needs more
> > cleanups. That is just in a shape I consider merging it upstream so we
> > can start fixing it there. I still consider it a little bit too
> > complicated for what is really needed to drive your hardware.
> 
> That's understood. Several items are remaining:
> 
> 1) Proper handling of vendor commands/events
> 2) "rmmod" flag in exit_module()
> 3) more cleanups
> 
> Should you have any suggestions on any of these, I'd be happy to try.

I will work with you on them, but first we have to fix this alignment
mess. So please go through your SDIO code and run it also on a 64-bit
system.

Regards

Marcel


