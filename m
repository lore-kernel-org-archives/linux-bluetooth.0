Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=US-ASCII
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: [PATCH] bluetooth: ath3k: added Atheros AR3012 with ID 0x0b05:0x17d0
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <530FB0CA.4070309@gmail.com>
Date: Thu, 27 Feb 2014 14:43:46 -0800
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <613439C8-AFCE-4B23-81FE-AD4B91A27768@holtmann.org>
References: <530FB0CA.4070309@gmail.com>
To: Bela Hausmann <bela.hausmann@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bela,

> This adds support for the Atheros AR3012 chipset on the ASUS Z87-Pro (C2) mainboard (ID 0x0b05:0x17d0).

include the content of /sys/kernel/debug/usb/devices for this controller.

> 
> Signed-off-by: Bela Hausmann <bela.hausmann@gmail.com>
> ---
> diff -uprN -X linux-3.13.5-gentoo/Documentation/dontdiff linux-3.13.5-gentoo/drivers/bluetooth/ath3k.c linux-3.13.5-gentoo-bela/drivers/bluetooth/ath3k.c
> --- linux-3.13.5-gentoo/drivers/bluetooth/ath3k.c    2014-01-20 03:40:07.000000000 +0100
> +++ linux-3.13.5-gentoo-bela/drivers/bluetooth/ath3k.c    2014-02-27 20:09:33.047878117 +0100
> @@ -97,6 +97,7 @@ static const struct usb_device_id ath3k_
>     { USB_DEVICE(0x13d3, 0x3402) },
>     { USB_DEVICE(0x0cf3, 0x3121) },
>     { USB_DEVICE(0x0cf3, 0xe003) },
> +    { USB_DEVICE(0x0b05, 0x17d0) },

Make sure that you email client does not screw up tabs. This looks pretty much like it is messed up.

Regards

Marcel


