Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Subject: Re: [PATCH] btusb.c add IMC Networks id 13d3:3404 (bcm20702A0)
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1392031617.5601.11.camel@develbox>
Date: Mon, 10 Feb 2014 10:33:13 -0800
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Message-Id: <F0885393-70B7-483B-8F97-C4AB73B451E6@holtmann.org>
References: <1392031617.5601.11.camel@develbox>
To: Jurgen Kramer <gtmkramer@xs4all.nl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

HI Jurgen,

> Attached patch adds support for IMC Networks (13d3:3404) to BCM20702A0
> in btusb.c. This device is used on the Asrock Z87E-ITX motherboard.
> Tested against 3.12.9.
> 
> diff -uNrp
> linux-3.12.9-301.jk1.fc20.x86_64.orig/drivers/bluetooth/btusb.c
> linux-3.12.9-301.jk1.fc20.x86_64.new/drivers/bluetooth/btusb.c
> --- a/drivers/bluetooth/btusb.c	2014-02-10 11:35:08.976975562 +0100
> +++ b/drivers/bluetooth/btusb.c	2014-02-10 11:37:03.864921122 +0100
> @@ -106,6 +106,7 @@ static struct usb_device_id btusb_table[
> 	{ USB_DEVICE(0x04ca, 0x2003) },
> 	{ USB_DEVICE(0x0489, 0xe042) },
> 	{ USB_DEVICE(0x413c, 0x8197) },
> +	{ USB_DEVICE(0x13d3, 0x3404) },
> 
> 	/* Foxconn - Hon Hai */
> 	{ USB_VENDOR_AND_INTERFACE_INFO(0x0489, 0xff, 0x01, 0x01) },
> 
> Signed-off-by: Jurgen Kramer <gtm.kramer@xs4all.nl>
> 
> Jurgen
> <btusb-bcm20702a0-add-imc-networks.patch>

please send patches inline created from git-format-patch and include /sys/kernel/debug/usb/devices details for this device.

Regards

Marcel

