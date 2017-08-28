Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] Add a new 04ca:3015 QCA_ROME device
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <63e310ac-c932-2792-da81-b17ad11bb4f9@gmail.com>
Date: Mon, 28 Aug 2017 16:19:04 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <913AF3FF-0C88-4D93-9C0B-622EDEFF722E@holtmann.org>
References: <63e310ac-c932-2792-da81-b17ad11bb4f9@gmail.com>
To: Ioan Moldovan <ioan.moldovan1999@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ioan,

> This patch adds the 04ca:3015 (from a QCA9377 board) Bluetooth device to the btusb blacklist and makes the kernel use the btqca module instead of btusb.
> 
> This patch is necessary because, without it the 04ca:3015 device defaults to using the btusb driver, which makes the WIFI side of the QCA9377 board unusable (obtains 0 MBps in speedtest, when the 04ca:3015 bluetooth is used with an audio headset).
> 
> --- btusb.c.orig	2017-08-28 15:46:22.584644604 +0300
> +++ btusb.c	2017-08-28 15:48:22.989042129 +0300
> @@ -268,6 +268,7 @@ static const struct usb_device_id blackl
> 	{ USB_DEVICE(0x0489, 0xe092), .driver_info = BTUSB_QCA_ROME },
> 	{ USB_DEVICE(0x0489, 0xe0a2), .driver_info = BTUSB_QCA_ROME },
> 	{ USB_DEVICE(0x04ca, 0x3011), .driver_info = BTUSB_QCA_ROME },
> +	{ USB_DEVICE(0x04ca, 0x3015), .driver_info = BTUSB_QCA_ROME },
> 
> 	/* Broadcom BCM2035 */
> 	{ USB_DEVICE(0x0a5c, 0x2009), .driver_info = BTUSB_BCM92035 },

please include the content of /sys/kernel/debug/usb/devices for this hardware and format the commit message correct and use git format-patch to create correct patches.

Regards

Marcel

