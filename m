Return-Path: <akarwar@marvell.com>
From: Amitkumar Karwar <akarwar@marvell.com>
To: Marcel Holtmann <marcel@holtmann.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Cathy Luo" <cluo@marvell.com>,
        Nishant Sarmukadam <nishants@marvell.com>,
        "Ganapathi Bhat" <gbhat@marvell.com>
Subject: RE: [PATCH] hciattach: Add support for Marvell Bluetooth device
Date: Wed, 3 Feb 2016 04:05:50 +0000
Message-ID: <e386cf083e8346c6a5952ee5d3e8512d@SC-EXCH04.marvell.com>
References: <1453906359-13314-1-git-send-email-akarwar@marvell.com>
 <D0F8D775-5B3A-49C4-AE19-CB82D991666E@holtmann.org>
In-Reply-To: <D0F8D775-5B3A-49C4-AE19-CB82D991666E@holtmann.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

> -----Original Message-----
> From: Marcel Holtmann [mailto:marcel@holtmann.org]
> Sent: Friday, January 29, 2016 4:50 PM
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
> >

Thanks for your review comments.
We have decided to push firmware download support in hci_uart driver first.
We will address your comments and come up with V2 patch later.

Regards,
Amitkumar Karwar
