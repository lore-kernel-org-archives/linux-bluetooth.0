Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH v2] Bluetooth: Latest firmware support for ath3k USB
 device
From: Marcel Holtmann <marcel@holtmann.org>
To: Suraj Sumangala <suraj@atheros.com>
Cc: linux-bluetooth@vger.kernel.org, Jothikumar.Mothilal@Atheros.com
In-Reply-To: <1286353896-8811-1-git-send-email-suraj@atheros.com>
References: <1286353896-8811-1-git-send-email-suraj@atheros.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 06 Oct 2010 10:48:04 +0200
Message-ID: <1286354884.6145.15.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Suraj,

> This patch add support for latest ath3k USB Bluetooth device firmare.
> The firmware implements shared antenna support and
> fixes few critical bugs.
> 
> Signed-off-by: Suraj Sumangala <suraj@atheros.com>
> ---
>  drivers/bluetooth/ath3k.c |   11 ++++++++---
>  1 files changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/bluetooth/ath3k.c b/drivers/bluetooth/ath3k.c
> index 128cae4..6eb4bcf 100644
> --- a/drivers/bluetooth/ath3k.c
> +++ b/drivers/bluetooth/ath3k.c
> @@ -103,6 +103,8 @@ error:
>  	return err;
>  }
>  
> +#define ATH3K_FW	"ath3k-fw.fw"
> +#define ATH3K_FW_LEGACY	"ath3k-1.fw"
>  static int ath3k_probe(struct usb_interface *intf,
>  			const struct usb_device_id *id)
>  {
> @@ -122,9 +124,12 @@ static int ath3k_probe(struct usb_interface *intf,
>  
>  	data->udev = udev;
>  
> -	if (request_firmware(&firmware, "ath3k-1.fw", &udev->dev) < 0) {
> -		kfree(data);
> -		return -EIO;
> +	if (request_firmware(&firmware, ATH3K_FW, &udev->dev) < 0) {
> +		if (request_firmware(&firmware, ATH3K_FW_LEGACY,
> +							&udev->dev) < 0) {
> +			kfree(data);
> +			return -EIO;
> +		}
>  	}
>  
>  	size = max_t(uint, firmware->size, 4096);

if this change is enough and the firmware is API compatible, then why do
you bother with this change. Just copy the new firmware over ath3k.fw
file.

I was under the assumption that the firmware is somehow API incompatible
with the current driver, but if it is not, then we don't need this at
all.

So I would propose to just send a patch against linux-firmware tree to
replace the current ath3k.fw with a newer file. Since only in API
incompatible changes should be reflected with a new name.

Regards

Marcel


