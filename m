Return-Path: <cyrus@holtmann.org>
Message-ID: <1351130193.1785.86.camel@aeonflux>
Subject: Re: [PATCH] Bluetooth: Add support for Atheros [04ca:3004]
From: Marcel Holtmann <marcel@holtmann.org>
To: Dwaine Garden VE3GIF <dwainegarden@rogers.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Wed, 24 Oct 2012 18:56:33 -0700
In-Reply-To: <1351129589.50995.YahooMailNeo@web125405.mail.ne1.yahoo.com>
References: <1351129589.50995.YahooMailNeo@web125405.mail.ne1.yahoo.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dwaine,

> Add another vendor specific ID for Atheros AR3012 device.
> This chip is wrapped by Lite-On Technology Corp.
> 
> output of usb-devices:
> 
> Bus 001 Device 008: ID 04ca:3004 Lite-On Technology Corp. 
> Device Descriptor:
>   bLength                18
>   bDescriptorType         1
>   bcdUSB               1.10
>   bDeviceClass          224 Wireless
>   bDeviceSubClass         1 Radio Frequency
>   bDeviceProtocol         1 Bluetooth

I want /sys/kernel/debug/usb/devices for this device and nothing else.

> diff --git a/drivers/bluetooth/ath3k.c b/drivers/bluetooth/ath3k.c
> index fc2de55..1486f15 100644
> --- a/drivers/bluetooth/ath3k.c
> +++ b/drivers/bluetooth/ath3k.c
> @@ -75,6 +75,7 @@ static struct usb_device_id ath3k_table[] = {
>         { USB_DEVICE(0x0CF3, 0x3004) },
>         { USB_DEVICE(0x0CF3, 0x311D) },
>         { USB_DEVICE(0x13d3, 0x3375) },
> +      { USB_DEVICE(0x04CA, 0x3004) },
>         { USB_DEVICE(0x04CA, 0x3005) },

This is still broken.

Regards

Marcel


