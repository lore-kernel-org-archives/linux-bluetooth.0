Return-Path: <cyrus@holtmann.org>
From: Bing Zhao <bzhao@marvell.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Mon, 13 Jul 2009 11:06:06 -0700
Subject: RE: [PATCH] Bluetooth: Fix incorrect alignment in Marvell
 BT-over-SDIO driver
Message-ID: <477F20668A386D41ADCC57781B1F704306CCBCD429@SC-VEXCH1.marvell.com>
References: <1247078654-8666-1-git-send-email-bzhao@marvell.com>
 <1247079256.9709.2.camel@localhost.localdomain>
In-Reply-To: <1247079256.9709.2.camel@localhost.localdomain>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

This patch fixed the alignment issue and the compilation warnings on 64-bit=
 system.
I also tested some basic commands (scan, l2ping, etc.) on my 64-bit HP lapt=
op and they seem working fine.

Should you have any other commands for testing/verification, or items for c=
leanup please let me know.

Thanks much for your help.

Bing

> -----Original Message-----
> From: Marcel Holtmann [mailto:marcel@holtmann.org]
> Sent: Wednesday, July 08, 2009 11:54 AM
> To: Bing Zhao
> Cc: linux-bluetooth@vger.kernel.org
> Subject: Re: [PATCH] Bluetooth: Fix incorrect alignment in Marvell BT-ove=
r-SDIO driver
>=20
> Hi Bing,
>=20
> > The driver uses "u32" for alignment check and calculation which
> > works only on 32-bit system. It will crash the 64-bit system.
> > Replace "u32" with "unsigned long" to fix this issue.
>=20
> I pushed that patch into the bluetooth-mrvl-2.6 tree now.
>=20
> However I am pretty sure that are better "Linux" ways on handling the
> alignment for the SKBs.
>=20
> Regards
>=20
> Marcel
>=20
