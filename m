Return-Path: <cyrus@holtmann.org>
Date: Wed, 29 Feb 2012 20:44:14 -0300
From: Gustavo Padovan <padovan@profusion.mobi>
To: =?iso-8859-1?Q?Jo=E3o?= Paulo Rechi Vita <jprvita@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: btusb: Add USB device ID "0a5c 21e8"
Message-ID: <20120229234414.GA19829@joana>
References: <1330557201-13762-1-git-send-email-jprvita@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1330557201-13762-1-git-send-email-jprvita@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi João,

* João Paulo Rechi Vita <jprvita@openbossa.org> [2012-02-29 20:13:21 -0300]:

> One more vendor-specific ID for BCM20702A0.
> 
> Signed-off-by: João Paulo Rechi Vita <jprvita@openbossa.org>
> ---
>  drivers/bluetooth/btusb.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index c5606ef..b4d9d2f 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -102,6 +102,7 @@ static struct usb_device_id btusb_table[] = {
>  
>  	/* Broadcom BCM20702A0 */
>  	{ USB_DEVICE(0x0a5c, 0x21e3) },
> +	{ USB_DEVICE(0x0a5c, 0x21e8) },
>  	{ USB_DEVICE(0x0a5c, 0x21f3) },
>  	{ USB_DEVICE(0x413c, 0x8197) },

Please add the output of usb-devices without this patch applied to the commit
message. Otherwise,

Acked-by: Gustavo F. Padovan <padovan@profusion.mobi>

	Gustavo
