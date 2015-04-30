Return-Path: <cyrus@holtmann.org>
From: "Reizer, Eyal" <eyalr@ti.com>
To: Marcel Holtmann <marcel@holtmann.org>,
        One Thousand Gnomes
	<gnomes@lxorguk.ukuu.org.uk>
CC: Eyal Reizer <eyalreizer@gmail.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        Pavan Savoy <pavan_savoy@ti.com>, "Mahaveer,
 Vishal" <vishalm@ti.com>,
        "linux-bluetooth@vger.kernel.org"
	<linux-bluetooth@vger.kernel.org>,
        "Ziv, Dotan" <dotanz@ti.com>
Subject: RE: [PATCH] Bluetooth: Add tty HCI driver
Date: Thu, 30 Apr 2015 14:38:49 +0000
Message-ID: <8665E2433BC68541A24DFFCA87B70F5B2365DFEB@DFRE01.ent.ti.com>
References: <1430380089-2395-1-git-send-email-eyalr@ti.com>
 <20150430113103.3ad0bfac@lxorguk.ukuu.org.uk>
 <2A731A0F-6BEB-4614-94E8-90B28BEE2DD9@holtmann.org>
In-Reply-To: <2A731A0F-6BEB-4614-94E8-90B28BEE2DD9@holtmann.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

> -----Original Message-----
> From: Marcel Holtmann [mailto:marcel@holtmann.org]
> Sent: Thursday, April 30, 2015 5:25 PM
> To: One Thousand Gnomes
> Cc: Eyal Reizer; linux-kernel@vger.kernel.org; Reizer, Eyal; Pavan Savoy;
> Mahaveer, Vishal; linux-bluetooth@vger.kernel.org
> Subject: Re: [PATCH] Bluetooth: Add tty HCI driver
>=20
> Hi,
>=20
> >> tty_hci driver exposes a /dev/hci_tty character device node, that
> >> intends to emulate a generic /dev/ttyX device that would be used by
> >> the user-space Bluetooth stacks to send/receive data to/from the WL
> >> combo-connectivity chipsets.
> >
> > We have an in kernel bluetooth stack, why do we care about this - how
> > will people test and debug driver interactions with binary only
> > bluetooth stacks in userspace ?
>=20
> NAK to this driver.
>=20
> If you want to run an external Bluetooth stack, then use HCI User Channel=
. The
> functionality already exists.

This is a pretty old driver that has been written a couple of years back an=
d is being used by customers (including android that use a userspace based =
stack).
If there is another driver already available that provides same functionali=
ty, of course we will be happy to use it instead.=20
Any idea of where we can get info on the HCI User Channel?

>=20
> We do not want to have two drivers for the same hardware. Work with the
> Bluetooth stack that is present in the kernel and please stop hacking aro=
und it.
>=20
There are in fact quite a few products that use commercial user space based=
 Bluetooth stacks.
One reason is that bluez has not been certified but I assume they have othe=
r reasons as well.

Best Regards,
Eyal
