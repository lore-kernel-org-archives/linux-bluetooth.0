Return-Path: <cyrus@holtmann.org>
From: Marek Vasut <marex@denx.de>
To: Gustavo Padovan <gustavo@padovan.org>
Subject: Re: [PATCH] ATH3K: Support AR3011 in Acer Iconia Tab W500
Date: Sun, 10 Jun 2012 01:20:10 +0200
Cc: linux-bluetooth@vger.kernel.org,
 Johan Hedberg <johan.hedberg@gmail.com>,
 Marcel Holtmann <marcel@holtmann.org>
References: <1339158771-11818-1-git-send-email-marex@denx.de> <20120609223052.GC1458@joana>
In-Reply-To: <20120609223052.GC1458@joana>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201206100120.10426.marex@denx.de>
List-ID: <linux-bluetooth.vger.kernel.org>

Dear Gustavo Padovan,

> Hi Marek,
> 
> * Marek Vasut <marex@denx.de> [2012-06-08 14:32:50 +0200]:
> > Acer used this chip connected via USB:
> > 
> > Bus 005 Device 005: ID 0cf3:3005 Atheros Communications, Inc. AR3011
> > Bluetooth
> > 
> > Device Descriptor:
> >   bLength                18
> >   bDescriptorType         1
> >   bcdUSB               1.10
> >   bDeviceClass          224 Wireless
> >   bDeviceSubClass         1 Radio Frequency
> >   bDeviceProtocol         1 Bluetooth
> >   bMaxPacketSize0        64
> >   idVendor           0x0cf3 Atheros Communications, Inc.
> >   idProduct          0x3005 AR3011 Bluetooth
> >   bcdDevice            0.01
> >   iManufacturer           0
> >   iProduct                0
> >   iSerial                 0
> >   bNumConfigurations      1
> > 
> > Signed-off-by: Marek Vasut <marex@denx.de>
> > Cc: Gustavo Padovan <gustavo@padovan.org>
> > Cc: Johan Hedberg <johan.hedberg@gmail.com>
> > Cc: Marcel Holtmann <marcel@holtmann.org>
> > To: linux-bluetooth@vger.kernel.org
> > ---
> > 
> >  drivers/bluetooth/ath3k.c |    1 +
> >  drivers/bluetooth/btusb.c |    1 +
> >  2 files changed, 2 insertions(+)
> 
> Patch has been applied to bluetooth.git. It should be in 3.5, thanks.

Thank you :)

> 	Gustavo

Best regards,
Marek Vasut
