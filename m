Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Subject: Re: [PATCH] btusb.c add IMC Networks id 13d3:3404 (bcm20702A0) - retry
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1392370354.2437.2.camel@develbox>
Date: Fri, 14 Feb 2014 13:02:51 -0800
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Message-Id: <ABD36217-AC0A-4585-B591-9DD5796A3AE9@holtmann.org>
References: <1392370354.2437.2.camel@develbox>
To: Jurgen Kramer <gtmkramer@xs4all.nl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jurgen,

> From 343f62050b33972929db749aee296e98332600d6 Mon Sep 17 00:00:00 2001
> From: Jurgen Kramer <gtmkramer@xs4all.nl>
> Date: Fri, 14 Feb 2014 10:22:51 +0100
> Subject: [PATCH] btusb.c add IMC Networks id 13d3:3404 (bcm20702A0)
> 
> ---
> drivers/bluetooth/btusb.c | 1 +
> 1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 3980fd1..5dce16d 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -106,6 +106,7 @@ static const struct usb_device_id btusb_table[] = {
> 	{ USB_DEVICE(0x04ca, 0x2003) },
> 	{ USB_DEVICE(0x0489, 0xe042) },
> 	{ USB_DEVICE(0x413c, 0x8197) },
> +	{ USB_DEVICE(0x13d3, 0x3404) },
> 
> 	/* Foxconn - Hon Hai */
> 	{ USB_VENDOR_AND_INTERFACE_INFO(0x0489, 0xff, 0x01, 0x01) },
> -- 
> 1.8.5.3
> 
> Signed-off-by: Jurgen Kramer <gtm.kramer@xs4all.nl>
> 
> Retry. I've included the relevant part of the
> requested /sys/kernel/debug/usb/devices output.
> 
> Jurgen
> <sys-kernel-debug-usb-devices-0x13d3-0x3404.txt>

can please create a proper patch with git-format-patch and send it with git-send-email. Look at how others have done it. I want the debug/usb/devices part as part of the commit message.

Also since the vendor id 13d3 belongs to IMC networks, you might want to add a comment saying “IMC Networks (Broadcom based)”. Alternative using USB_VENDOR_AND_INTERFACE_INFO might be an option as well.

Regards

Marcel


