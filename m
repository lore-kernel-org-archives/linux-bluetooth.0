Return-Path: <akarwar@marvell.com>
From: Amitkumar Karwar <akarwar@marvell.com>
To: Marcel Holtmann <marcel@holtmann.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Cathy Luo" <cluo@marvell.com>,
        Nishant Sarmukadam <nishants@marvell.com>,
        "Ganapathi Bhat" <gbhat@marvell.com>
Subject: RE: [PATCH] hciattach: Add support for Marvell Bluetooth device
Date: Wed, 27 Jan 2016 15:33:24 +0000
Message-ID: <db9c4548d95b481f924514b89008670c@SC-EXCH04.marvell.com>
References: <1453906359-13314-1-git-send-email-akarwar@marvell.com>
 <0AD94556-3D4D-40E7-AB21-CAD84F8869FD@holtmann.org>
In-Reply-To: <0AD94556-3D4D-40E7-AB21-CAD84F8869FD@holtmann.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

> From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-
> owner@vger.kernel.org] On Behalf Of Marcel Holtmann
> Sent: Wednesday, January 27, 2016 8:51 PM
> To: Amitkumar Karwar
> Cc: linux-bluetooth@vger.kernel.org; Cathy Luo; Nishant Sarmukadam;
> Ganapathi Bhat
> Subject: Re: [PATCH] hciattach: Add support for Marvell Bluetooth device
>=20
> Hi Amitkumar,
>=20
> > This patch enables the Marvell Bluetooth device (UART sku) over the H4
> > protocol. It configures the baudrate and download firmware to bring up
> > the device.
> >
> > Command syntax: hciattach /dev/ttyUSB0 marvell
> >
> > Make sure to place the marvell_hci_uart.conf file in
> > /lib/firmware/mrvl/
> >
> > This file should contain below info:
> > HELPER_FILE_PATH=3D<full path of helper binary> FIRMWARE_FILE_PATH=3D<f=
ull
> > path of firmware binary> FIRMWARE_DOWNLOAD_BAUD_RATE=3D<firmware
> > download baud rate>
>=20
> I would prefer if you create a drivers/bluetooth/hci_mrvl.c kernel
> driver that works with btattach. We are trying to phase out hciattach
> and not add more vendor specifics.
>=20
> For at least Intel and Broadcom hardware we have full in kernel support
> for firmware loading and configuration. And the benefit is that code can
> be shared between UART and USB.
>=20

Thanks for the quick reply.
We are working on in kernel firmware download support as well by adding hci=
_mrvl.c file. We will submit the driver patch in couple of days.

This hciattach enhancement would be really useful for the users having olde=
r kernel. Both the approaches can work independently, as here H4 UART proto=
col is being used instead of MRVL.
Could you please considered this patch?

Regards,
Amitkumar
