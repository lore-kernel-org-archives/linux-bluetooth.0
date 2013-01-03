Return-Path: <cyrus@holtmann.org>
Date: Thu, 3 Jan 2013 18:39:01 -0200
From: Gustavo Padovan <gustavo@padovan.org>
To: Sergio Cambra <sergio@enpijama.es>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth device 04ca:3008 should use ath3k
Message-ID: <20130103203901.GD2114@joana>
References: <2070457.EiHL78Yky8@tablet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2070457.EiHL78Yky8@tablet>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sergio,

* Sergio Cambra <sergio@enpijama.es> [2013-01-02 21:52:12 +0100]:

> I'm using kernel 3.6.6 from Chakra, and 04ca:3008 device was using btusb driver. Adapter was found but scan didn't work. Loading ath3k with modprobe didn't fix it.
> 
> After adding 04ca:3008 to ath3k.c and btusb.c, ath3k was loaded on boot and it finds bluetooth devices on scanning. This patch is working in 3.6.6 but it's simple so I did against latest version (3.8-rc1)
> 
> This patch it's for bug https://bugzilla.kernel.org/show_bug.cgi?id=51891
> 
> diff -uprN -X linux-3.8-rc1-vanilla/Documentation/dontdiff linux-3.8-rc1-vanilla/drivers/bluetooth/ath3k.c linux-3.8-rc1/drivers/bluetooth/ath3k.c
> --- linux-3.8-rc1-vanilla/drivers/bluetooth/ath3k.c     2013-01-02 21:41:46.778002039 +0100
> +++ linux-3.8-rc1/drivers/bluetooth/ath3k.c     2013-01-02 21:41:55.501028313 +0100
> @@ -77,6 +77,7 @@ static struct usb_device_id ath3k_table[
>         { USB_DEVICE(0x0CF3, 0x311D) },
>         { USB_DEVICE(0x13d3, 0x3375) },
>         { USB_DEVICE(0x04CA, 0x3005) },
> +       { USB_DEVICE(0x04CA, 0x3008) },
>         { USB_DEVICE(0x13d3, 0x3362) },
>         { USB_DEVICE(0x0CF3, 0xE004) },
>         { USB_DEVICE(0x0930, 0x0219) },
> @@ -104,6 +105,7 @@ static struct usb_device_id ath3k_blist_
>         { USB_DEVICE(0x0cf3, 0x311D), .driver_info = BTUSB_ATH3012 },
>         { USB_DEVICE(0x13d3, 0x3375), .driver_info = BTUSB_ATH3012 },
>         { USB_DEVICE(0x04ca, 0x3005), .driver_info = BTUSB_ATH3012 },
> +       { USB_DEVICE(0x04ca, 0x3008), .driver_info = BTUSB_ATH3012 },
>         { USB_DEVICE(0x13d3, 0x3362), .driver_info = BTUSB_ATH3012 },
>         { USB_DEVICE(0x0cf3, 0xe004), .driver_info = BTUSB_ATH3012 },
>         { USB_DEVICE(0x0930, 0x0219), .driver_info = BTUSB_ATH3012 },
> diff -uprN -X linux-3.8-rc1-vanilla/Documentation/dontdiff linux-3.8-rc1-vanilla/drivers/bluetooth/btusb.c linux-3.8-rc1/drivers/bluetooth/btusb.c
> --- linux-3.8-rc1-vanilla/drivers/bluetooth/btusb.c     2013-01-02 21:41:46.781335256 +0100
> +++ linux-3.8-rc1/drivers/bluetooth/btusb.c     2013-01-02 21:41:55.504361528 +0100
> @@ -135,6 +135,7 @@ static struct usb_device_id blacklist_ta
>         { USB_DEVICE(0x0cf3, 0x311d), .driver_info = BTUSB_ATH3012 },
>         { USB_DEVICE(0x13d3, 0x3375), .driver_info = BTUSB_ATH3012 },
>         { USB_DEVICE(0x04ca, 0x3005), .driver_info = BTUSB_ATH3012 },
> +       { USB_DEVICE(0x04ca, 0x3008), .driver_info = BTUSB_ATH3012 },
>         { USB_DEVICE(0x13d3, 0x3362), .driver_info = BTUSB_ATH3012 },
>         { USB_DEVICE(0x0cf3, 0xe004), .driver_info = BTUSB_ATH3012 },
>         { USB_DEVICE(0x0930, 0x0219), .driver_info = BTUSB_ATH3012 },

Please provide a patch rebased against bluetooth.git[0] and with your
Signed-off-by: line.
Also, we require the output of /sys/kernel/debug/usb/devices for this device
in the commit message.

[0] http://git.kernel.org/?p=linux/kernel/git/bluetooth/bluetooth.git

	Gustavo
