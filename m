Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Subject: Re: [PATCH 1/6] Bluetooth: Add BTUSB_BCM_PATCHRAM flag for Broadcom devices 0489:*
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1417589145-30467-1-git-send-email-jesse.sung@canonical.com>
Date: Wed, 3 Dec 2014 10:04:33 +0000
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <E3FDA31E-E9BE-4DB5-BF0C-6F429599A2E9@holtmann.org>
References: <1417589145-30467-1-git-send-email-jesse.sung@canonical.com>
To: Wen-chien Jesse Sung <jesse.sung@canonical.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Wen-chien,

> Most modules of this BCM20702A0 variant are known to require external
> firmware to work properly.
> 
> Signed-off-by: Wen-chien Jesse Sung <jesse.sung@canonical.com>
> ---
> drivers/bluetooth/btusb.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 292c38e..5c9eeda 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -108,7 +108,8 @@ static const struct usb_device_id btusb_table[] = {
> 	{ USB_DEVICE(0x413c, 0x8197) },
> 
> 	/* Foxconn - Hon Hai */
> -	{ USB_VENDOR_AND_INTERFACE_INFO(0x0489, 0xff, 0x01, 0x01) },
> +	{ USB_VENDOR_AND_INTERFACE_INFO(0x0489, 0xff, 0x01, 0x01),
> +	  .driver_info = BTUSB_BCM_PATCHRAM },
> 
> 	/* Broadcom devices with vendor specific id */
> 	{ USB_VENDOR_AND_INTERFACE_INFO(0x0a5c, 0xff, 0x01, 0x01),

lets add information in the commit message on how to retrieve a firmware to use. I also prefer to have the content from /sys/kernel/debug/usb/devices added as well.

Regards

Marcel

