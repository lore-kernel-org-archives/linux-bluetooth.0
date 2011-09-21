Return-Path: <cyrus@holtmann.org>
From: Oliver Neukum <oneukum@suse.de>
To: Jesse Sung <jesse.sung@canonical.com>
Subject: Re: [PATCH] Bluetooth: Add support for Broadcom BCM20702A0.
Date: Wed, 21 Sep 2011 10:45:22 +0200
Cc: Marcel Holtmann <marcel@holtmann.org>,
	linux-bluetooth@vger.kernel.org, 854399@bugs.launchpad.net
References: <4E7840CF.5010805@canonical.com> <1316523932.1937.102.camel@aeonflux> <4E794037.6090809@canonical.com>
In-Reply-To: <4E794037.6090809@canonical.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Message-Id: <201109211045.22997.oneukum@suse.de>
List-ID: <linux-bluetooth.vger.kernel.org>

Am Mittwoch, 21. September 2011, 03:39:03 schrieb Jesse Sung:
> > please prove that this is needed. What does usb-devices tell you about
> > this device?
>=20
> Hi Marcel,
>=20
> Currently I only have the output of lsusb -v at hand:
>=20
> Bus 001 Device 003: ID 413c:8197 Dell Computer Corp.
> Device Descriptor:
>    bLength                18
>    bDescriptorType         1
>    bcdUSB               2.00
>    bDeviceClass          255 Vendor Specific Class
>    bDeviceSubClass         1
>    bDeviceProtocol         1
>    bMaxPacketSize0        64
>    idVendor           0x413c Dell Computer Corp.
>    idProduct          0x8197
>    bcdDevice            1.12
>    iManufacturer           1 Broadcom Corp
>    iProduct                2 BCM20702A0
[..]
>      Interface Descriptor:
>        bLength                 9
>        bDescriptorType         4
>        bInterfaceNumber        0
>        bAlternateSetting       0
>        bNumEndpoints           3
>        bInterfaceClass       255 Vendor Specific Class

Hi,

this is really all you need. As soon as it reports that class, you need to =
have
the vendor:device in the driver to bind. Otherwise usbcore won't even probe.

	Regards
		Oliver

=2D-=20
=2D - -=20
SUSE LINUX Products GmbH, GF: Jeff Hawn, Jennifer Guild, Felix Imend=C3=B6r=
ffer, HRB 16746 (AG N=C3=BCrnberg)=20
Maxfeldstra=C3=9Fe 5                        =20
90409 N=C3=BCrnberg=20
Germany=20
=2D - -=20
