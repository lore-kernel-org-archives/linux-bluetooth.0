Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] ath3k: add support for new firmware
From: Marcel Holtmann <marcel@holtmann.org>
To: Vikram <vkandukuri@atheros.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <1275564023.19511.31.camel@ATH-LT-538>
References: <1275564023.19511.31.camel@ATH-LT-538>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 03 Jun 2010 10:34:12 -0700
Message-ID: <1275586452.2182.30.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vikram,

> updated new firmware has few critical bug fixes and shared antenna
> support.
> 
> Signed-off-by: Vikram Kandukuri <vkandukuri@atheros.com>
> ---
>  drivers/bluetooth/ath3k.c |    9 ++++++---
>  1 files changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/bluetooth/ath3k.c b/drivers/bluetooth/ath3k.c
> index 128cae4..7bda549 100644
> --- a/drivers/bluetooth/ath3k.c
> +++ b/drivers/bluetooth/ath3k.c
> @@ -122,9 +122,12 @@ static int ath3k_probe(struct usb_interface *intf,
>  
>  	data->udev = udev;
>  
> -	if (request_firmware(&firmware, "ath3k-1.fw", &udev->dev) < 0) {
> -		kfree(data);
> -		return -EIO;
> +	if (request_firmware(&firmware, "ath3k-2.fw", &udev->dev) < 0) {
> +		BT_DBG("requesting old firmware");
> +		if (request_firmware(&firmware, "ath3k-1.fw", &udev->dev) < 0) {
> +			kfree(data);
> +			return -EIO;
> +		}
>  	}
>  
>  	size = max_t(uint, firmware->size, 4096);

can we just have a list of supported firmware in a table instead of just
hardcoding this. I think something similar to what iwlwifi for WiFi has
beend doing would be nice.

Regards

Marcel


