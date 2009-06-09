Return-Path: <cyrus@holtmann.org>
From: Bing Zhao <bzhao@marvell.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Tue, 9 Jun 2009 16:39:23 -0700
Subject: RE: [PATCH 1/4 v3] bluetooth: add btmrvl driver to support Marvell
 bluetooth devices
Message-ID: <477F20668A386D41ADCC57781B1F704301EDD86A59@SC-VEXCH1.marvell.com>
References: <1243978178-3403-1-git-send-email-bzhao@marvell.com>
 <1244560807.3068.12.camel@localhost.localdomain>
In-Reply-To: <1244560807.3068.12.camel@localhost.localdomain>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

> -----Original Message-----
> From: Marcel Holtmann [mailto:marcel@holtmann.org]
> Sent: Tuesday, June 09, 2009 8:20 AM
> To: Bing Zhao
> Cc: linux-bluetooth@vger.kernel.org
> Subject: Re: [PATCH 1/4 v3] bluetooth: add btmrvl driver to support Marve=
ll bluetooth devices
>=20
> Hi Bing,
>=20
> > This driver provides basic definitions and library functions to
> > support Marvell Bluetooth enabled devices, such as 88W8688 WLAN/BT
> > combo chip.
>=20
> so I created a bluetooth-mrvl-2.6 tree with your patches and already a
> major collection of cleanup patches.

Thanks for the cleanups.

> The biggest problem right now is that your driver spits out casting
> warnings like crazy. This is not acceptable. So please send me a patch
> to fix these based on bluetooth-mrvl-2.6.

Could you please let me know how to catch these casting warnings? I'm using=
 GCC 4.3.2 with sparse on x86 laptop (Fedora 8) but I couldn't get the warn=
ings.

> I did fix the firmware non-sense you had in there, but I haven't had
> time to test it with real hardware. So please do so.

Thanks for the fix and it works well.

> Also I am considering to just remove all this Enter/Leave debug
> non-sense since it makes the code really hard to read.

I can remove those Enter/Leave debug, if you prefer.

> Regards
>=20
> Marcel
>=20

Thanks,

Bing
