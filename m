Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Bluetooth: Add new PID for Atheros 3011
From: Marcel Holtmann <marcel@holtmann.org>
To: Bala Shanmugam <sbalashanmugam@atheros.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <1290766393-3801-1-git-send-email-sbalashanmugam@atheros.com>
References: <1290766393-3801-1-git-send-email-sbalashanmugam@atheros.com>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 26 Nov 2010 12:22:39 +0100
Message-ID: <1290770560.4795.12.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bala,

> Atheros 3011 has small sflash firmware and needs to be
> blacklisted in transport driver to load actual firmware
> in DFU driver.

please add an empty line here. The signed-off line should always be
separated from the commit message. The git am takes it literal as it is
and does not modify it.

> Signed-off-by: Bala Shanmugam <sbalashanmugam@atheros.com>
> ---
>  drivers/bluetooth/ath3k.c |    2 ++
>  drivers/bluetooth/btusb.c |    3 +++
>  2 files changed, 5 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/bluetooth/ath3k.c b/drivers/bluetooth/ath3k.c
> index 128cae4..c70fb0b 100644
> --- a/drivers/bluetooth/ath3k.c
> +++ b/drivers/bluetooth/ath3k.c
> @@ -35,6 +35,8 @@
>  static struct usb_device_id ath3k_table[] = {
>  	/* Atheros AR3011 */
>  	{ USB_DEVICE(0x0CF3, 0x3000) },

For the sake of readability add another empty line here as well.

> +	/* Atheros AR3011 with sflash firmware*/
> +	{ USB_DEVICE(0x0CF3, 0x3002) },

And for consistency, add another empty line here as well.

>  	{ }	/* Terminating entry */
>  };
>  
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index ab3894f..ca3fdc1 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -99,6 +99,9 @@ static struct usb_device_id blacklist_table[] = {
>  	/* Broadcom BCM2033 without firmware */
>  	{ USB_DEVICE(0x0a5c, 0x2033), .driver_info = BTUSB_IGNORE },
>  
> +	/* Atheros 3011 with sflash firmware */
> +	{ USB_DEVICE(0x0cf3, 0x3002), .driver_info = BTUSB_IGNORE },
> +
>  	/* Broadcom BCM2035 */
>  	{ USB_DEVICE(0x0a5c, 0x2035), .driver_info = BTUSB_WRONG_SCO_MTU },
>  	{ USB_DEVICE(0x0a5c, 0x200a), .driver_info = BTUSB_WRONG_SCO_MTU },

If this finally solves the mess with the firmware loading, then I am
fine with it. It looks clean and simple now.

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


