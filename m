Return-Path: <cyrus@holtmann.org>
From: Bing Zhao <bzhao@marvell.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Mon, 13 Jul 2009 21:20:42 -0700
Subject: RE: [PATCH] Bluetooth: Fix incorrect alignment in Marvell
 BT-over-SDIO driver
Message-ID: <477F20668A386D41ADCC57781B1F704306CCBCD5DB@SC-VEXCH1.marvell.com>
References: <1247078654-8666-1-git-send-email-bzhao@marvell.com>
	 <1247079256.9709.2.camel@localhost.localdomain>
	 <477F20668A386D41ADCC57781B1F704306CCBCD429@SC-VEXCH1.marvell.com>
 <1247538404.4549.15.camel@violet>
In-Reply-To: <1247538404.4549.15.camel@violet>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

> -----Original Message-----
> From: Marcel Holtmann [mailto:marcel@holtmann.org]
> Sent: Monday, July 13, 2009 7:27 PM
> To: Bing Zhao
> Cc: linux-bluetooth@vger.kernel.org
> Subject: RE: [PATCH] Bluetooth: Fix incorrect alignment in Marvell BT-ove=
r-SDIO driver
>=20
> Hi Bing,
>=20
> not top-posting please. This is an open source mailing list. We do
> things the right way.

Sorry about that.

> > This patch fixed the alignment issue and the compilation warnings on 64=
-bit system.
> > I also tested some basic commands (scan, l2ping, etc.) on my 64-bit HP =
laptop and they seem working
> fine.
> >
> > Should you have any other commands for testing/verification, or items f=
or cleanup please let me
> know.
>=20
> I pushed bluetooth-mrvl-2.6 into bluetooth-next-2.6 to see if any build
> fallouts come up.

Thanks! I'll clone bluetooth-next-2.6 tree for testing and future changes.

Bing

> Regards
>=20
> Marcel
>=20
