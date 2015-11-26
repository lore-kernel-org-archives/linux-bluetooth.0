Return-Path: <akarwar@marvell.com>
From: Amitkumar Karwar <akarwar@marvell.com>
To: Marcel Holtmann <marcel@holtmann.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Cathy Luo" <cluo@marvell.com>, Xinming Hu <huxm@marvell.com>
Subject: RE: [PATCH] Bluetooth: btmrvl: add sysfs commands gpiogap and
 hscfgcmd
Date: Thu, 26 Nov 2015 13:38:36 +0000
Message-ID: <5e4d2f83202448c0bf610f0d9f610719@SC-EXCH04.marvell.com>
References: <1448534238-5508-1-git-send-email-akarwar@marvell.com>
 <B75B5139-479F-4A9E-9C5B-136B883B64D2@holtmann.org>
In-Reply-To: <B75B5139-479F-4A9E-9C5B-136B883B64D2@holtmann.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

> From: Marcel Holtmann [mailto:marcel@holtmann.org]
> Sent: Thursday, November 26, 2015 6:37 PM
> To: Amitkumar Karwar
> Cc: linux-bluetooth@vger.kernel.org; Cathy Luo; Xinming Hu
> Subject: Re: [PATCH] Bluetooth: btmrvl: add sysfs commands gpiogap and
> hscfgcmd
>=20
> Hi Amitkumar,
>=20
> > This patch adds support for driver's internal host sleep configuration
> > via sysfs. gpiogap and hscfgcmd sysfs commands are added for this
> > purpose.
> >
> > Examples.
> > 1. Get current gpiogap
> >   cat /sys/class/bluetooth/hci0/gpiogap 2. Set gpio as 13 and gap as
> > 100msecs
> >   echo "0x0d64" > /sys/class/bluetooth/hci0/gpiogap 3. Download host
> > sleep configuration to firmware.
> >   echo "1" > /sys/class/bluetooth/hci0/hscfgcmd
>=20
> explain to me how this is a good API. Keep in mind this is an userspace
> API and needs to be stable.
>=20
> If you want to expose a GPIO, why not expose it through the standard
> Linux kernel GPIO API. Then it becomes easily discoverable via standard
> sysfs tools. Also you can use standard tools to modify it.
>=20
> I also do not understand why you need something to set host sleep
> configuration. Just do this all the time and be done with it.

Thanks for the review.=20
I wasn't aware about standard linux kernel GPIO API. I will go through belo=
w link and check how we can make use of it.
http://lxr.free-electrons.com/source/Documentation/gpio/sysfs.txt

Basically we have gpiogap and hscfgcmd debugfs commands. As production kern=
el doesn't enable CONFIG_DEBUGFS, we tried to do same thing via sysfs.

Regards,
Amitkumar
