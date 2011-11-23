Return-Path: <cyrus@holtmann.org>
Date: Wed, 23 Nov 2011 16:05:00 -0300
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: eran <eran@over-here.org>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH] Adding USB device 13d3:3375 (a bluetooth module embedded
 in the Asus UX31) as an Atheros AR3012 device.
Message-ID: <20111123190500.GA7179@samus>
References: <20111123100356.GB9838@over-here.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20111123100356.GB9838@over-here.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Eran,

Just a few cosmetic comments, and a disclaimer: I don't have any
idea why it seems that every new Atheros device needs another
entry in those tables.

Apart from those minor points it looks good.

On 10:03 Wed 23 Nov, eran wrote:
> From: Eran <eran@over-here.org>

Keep the subject line shorter, under 60 or so characters, i.e. remove
the part between parentheses. And prefix your subject with "Bluetooth:".

> 
> The bluetooth module in the Asus UX31/UX21 is based on Atheros AR3012 and requires a firmware to be uploaded before it's usable.

Please break the comment at 70 or so characters.

> 
> Signed-off-by: Eran <eran@over-here.org>
> ---
>  drivers/bluetooth/ath3k.c |    2 ++
>  drivers/bluetooth/btusb.c |    1 +
>  2 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/bluetooth/ath3k.c b/drivers/bluetooth/ath3k.c
> index 106beb1..b94aae6 100644
> --- a/drivers/bluetooth/ath3k.c
> +++ b/drivers/bluetooth/ath3k.c
> @@ -70,6 +70,7 @@ static struct usb_device_id ath3k_table[] = {
>  
>  	/* Atheros AR3012 with sflash firmware*/
>  	{ USB_DEVICE(0x0CF3, 0x3004) },
> +	{ USB_DEVICE(0x13d3, 0x3375) },
>  
>  	/* Atheros AR5BBU12 with sflash firmware */
>  	{ USB_DEVICE(0x0489, 0xE02C) },
> @@ -86,6 +87,7 @@ static struct usb_device_id ath3k_blist_tbl[] = {
>  
>  	/* Atheros AR3012 with sflash firmware*/
>  	{ USB_DEVICE(0x0cf3, 0x3004), .driver_info = BTUSB_ATH3012 },
> +	{ USB_DEVICE(0x13d3, 0x3375), .driver_info = BTUSB_ATH3012 },
>  
>  	{ }	/* Terminating entry */
>  };
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index f9b7260..a64f15a 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -122,6 +122,7 @@ static struct usb_device_id blacklist_table[] = {
>  
>  	/* Atheros 3012 with sflash firmware */
>  	{ USB_DEVICE(0x0cf3, 0x3004), .driver_info = BTUSB_ATH3012 },
> +	{ USB_DEVICE(0x13d3, 0x3375), .driver_info = BTUSB_ATH3012 },
>  
>  	/* Atheros AR5BBU12 with sflash firmware */
>  	{ USB_DEVICE(0x0489, 0xe02c), .driver_info = BTUSB_IGNORE },
> -- 
> 1.7.2.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Cheers,
-- 
Vinicius
