Return-Path: <cyrus@holtmann.org>
Subject: RE: [PATCH 1/4 v3] bluetooth: add btmrvl driver to support Marvell
 bluetooth devices
From: Marcel Holtmann <marcel@holtmann.org>
To: Bing Zhao <bzhao@marvell.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
In-Reply-To: <477F20668A386D41ADCC57781B1F704301EDD86A59@SC-VEXCH1.marvell.com>
References: <1243978178-3403-1-git-send-email-bzhao@marvell.com>
	 <1244560807.3068.12.camel@localhost.localdomain>
	 <477F20668A386D41ADCC57781B1F704301EDD86A59@SC-VEXCH1.marvell.com>
Content-Type: text/plain
Date: Wed, 10 Jun 2009 09:07:23 +0200
Message-Id: <1244617643.3068.26.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bing,

> > > This driver provides basic definitions and library functions to
> > > support Marvell Bluetooth enabled devices, such as 88W8688 WLAN/BT
> > > combo chip.
> > 
> > so I created a bluetooth-mrvl-2.6 tree with your patches and already a
> > major collection of cleanup patches.
> 
> Thanks for the cleanups.
> 
> > The biggest problem right now is that your driver spits out casting
> > warnings like crazy. This is not acceptable. So please send me a patch
> > to fix these based on bluetooth-mrvl-2.6.
> 
> Could you please let me know how to catch these casting warnings? I'm using GCC 4.3.2 with sparse on x86 laptop (Fedora 8) but I couldn't get the warnings.

let me guess, you are running a 32-bit kernel. Just run a 64-bit kernel
and you will see them. I am using Fedora 10.

I also have to compile this at least on one big endian machine. Will use
my Quad G5 once I get home.

> > I did fix the firmware non-sense you had in there, but I haven't had
> > time to test it with real hardware. So please do so.
> 
> Thanks for the fix and it works well.

Good. I wasn't sure I did this right. Stupid driver_data is unsigned
long and that requires casting :(

> > Also I am considering to just remove all this Enter/Leave debug
> > non-sense since it makes the code really hard to read.
> 
> I can remove those Enter/Leave debug, if you prefer.

Tell me what you need them for. I don't mind having the Enter part with
BT_DBG since we are using that anyway to print debug information about
the parameters we give to a function, but the Leave part is cluttering
the code. Can you just follow the style the other drivers are using.

And again, after that you are not done since the whole driver needs more
cleanups. That is just in a shape I consider merging it upstream so we
can start fixing it there. I still consider it a little bit too
complicated for what is really needed to drive your hardware.

Regards

Marcel


