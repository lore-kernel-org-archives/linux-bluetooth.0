Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: [PATCH] add new device for fixed bug 60901
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <2051896.tGxFBs1H7o@it1765>
Date: Sun, 3 May 2015 08:38:38 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <65A90F2F-1E02-486F-9CE6-C1CFE45502BA@holtmann.org>
References: <2051896.tGxFBs1H7o@it1765>
To: Volkov Aleksey <avv@kupivip.ru>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Aleksei,

the subject line needs to read "[PATCH] Bluetooth: btusb: " as prefix so we can clearly identify where this belong to. Also stating a random bug number in the subject is useless, refer to the device in question.

> That patch fix bug https://bugzilla.kernel.org/show_bug.cgi?id=60901 for my Roper Class 1 dongle

You need to include the output of /sys/kernel/debug/usb/devices for this specific device in the commit message. I also prefer that instead of just referring to a bug number, you explain why this patch is needed. For example output of hcidump or btmon showing the problem here.

> Signed-off-by: Aleksei Volkov <info@dv2c.ru>
> ---
> drivers/bluetooth/btusb.c | 1+
> 1 file changed, 1 insertion(+), 0 deletion(-)
> 
> diff -up linux-4.0.0-gentoo/drivers/bluetooth/btusb.c.orig linux-4.0.0-gentoo/drivers/bluetooth/btusb.c 
> --- linux-4.0.0/drivers/bluetooth/btusb.c.orig	2015-05-01 12:06:59.000000000 +0300
> +++ linux-4.0.0/drivers/bluetooth/btusb.c	2015-05-01 12:02:00.000000000 +0300
> @@ -254,6 +254,7 @@ static const struct usb_device_id blackl
> 
> 	/* Roper Class 1 Bluetooth Dongle (Silicon Wave based) */
> 	{ USB_DEVICE(0x1300, 0x0001), .driver_info = BTUSB_SWAVE },
> +	{ USB_DEVICE(0x1310, 0x0001), .driver_info = BTUSB_SWAVE },

Did I wrong used 0x1300 originally and meant actually 0x1310 or does Roper really have two USB Vendor IDs this close to each other?

> 	/* Digianswer devices */
> 	{ USB_DEVICE(0x08fd, 0x0001), .driver_info = BTUSB_DIGIANSWER },

Regards

Marcel

