Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Subject: Re: [PATCH 2/6] Bluetooth: Add BTUSB_BCM_PATCHRAM to Broadcom devices 13d3:*
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1417589145-30467-2-git-send-email-jesse.sung@canonical.com>
Date: Wed, 3 Dec 2014 10:04:39 +0000
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <DC9D1F71-3E4F-4566-B194-091C5008EE83@holtmann.org>
References: <1417589145-30467-1-git-send-email-jesse.sung@canonical.com> <1417589145-30467-2-git-send-email-jesse.sung@canonical.com>
To: Wen-chien Jesse Sung <jesse.sung@canonical.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Wen-chien,

> It is known that at least 13d3:3388, 13d3:3389, and 13d3:3404 require
> external firmwares to work properly. Since the firmware loading
> procedure is skipped if there's no firmware file provided, it is safe to
> set BTUSB_BCM_PATCHRAM for 13d3:* instead of adding each module one by
> one.
> 
> Signed-off-by: Wen-chien Jesse Sung <jesse.sung@canonical.com>
> ---
> drivers/bluetooth/btusb.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 5c9eeda..5b8e029 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -122,7 +122,8 @@ static const struct usb_device_id btusb_table[] = {
> 	{ USB_VENDOR_AND_INTERFACE_INFO(0x050d, 0xff, 0x01, 0x01) },
> 
> 	/* IMC Networks - Broadcom based */
> -	{ USB_VENDOR_AND_INTERFACE_INFO(0x13d3, 0xff, 0x01, 0x01) },
> +	{ USB_VENDOR_AND_INTERFACE_INFO(0x13d3, 0xff, 0x01, 0x01),
> +	  .driver_info = BTUSB_BCM_PATCHRAM },
> 
> 	/* Intel Bluetooth USB Bootloader (RAM module) */
> 	{ USB_DEVICE(0x8087, 0x0a5a),

I would prefer adding text in the commit message to explain where the firmware is coming from.

Regards

Marcel

