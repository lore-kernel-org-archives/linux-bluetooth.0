Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Subject: Re: [PATCH 3/6] Bluetooth: Add BTUSB_BCM_PATCHRAM to Broadcom 413c:8197
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1417589145-30467-3-git-send-email-jesse.sung@canonical.com>
Date: Wed, 3 Dec 2014 10:04:42 +0000
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <429602FA-3D16-49B9-BB01-6A48D63F6D6A@holtmann.org>
References: <1417589145-30467-1-git-send-email-jesse.sung@canonical.com> <1417589145-30467-3-git-send-email-jesse.sung@canonical.com>
To: Wen-chien Jesse Sung <jesse.sung@canonical.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Wen-chien,

> This device needs an external firmware to make HSP and HFP work.
> 
> Signed-off-by: Wen-chien Jesse Sung <jesse.sung@canonical.com>
> ---
> drivers/bluetooth/btusb.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 5b8e029..c92f59f 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -105,7 +105,8 @@ static const struct usb_device_id btusb_table[] = {
> 	{ USB_DEVICE(0x04ca, 0x2003) },
> 	{ USB_DEVICE(0x0b05, 0x17b5) },
> 	{ USB_DEVICE(0x0b05, 0x17cb) },
> -	{ USB_DEVICE(0x413c, 0x8197) },
> +	{ USB_DEVICE(0x413c, 0x8197),
> +	  .driver_info = BTUSB_BCM_PATCHRAM },
> 
> 	/* Foxconn - Hon Hai */
> 	{ USB_VENDOR_AND_INTERFACE_INFO(0x0489, 0xff, 0x01, 0x01),

so here as well picking USB_VENDOR_AND_INTERFACE_INFO is a good idea. However we might need use the blacklist entries to mark these devices fail if there is no firmware.

Regards

Marcel

