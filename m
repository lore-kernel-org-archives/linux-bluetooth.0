Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Subject: Re: [PATCH] Bluetooth: btusb: mark 0c10:0000 devices with BTUSB_SWAVE
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1439661555-4729-1-git-send-email-peter.poklop@gmail.com>
Date: Sat, 15 Aug 2015 11:07:40 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <862D4D2C-F36B-490D-9E81-C19E580EF293@holtmann.org>
References: <1439661555-4729-1-git-send-email-peter.poklop@gmail.com>
To: Peter Poklop <peter.poklop@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Peter,

> This patch enables quirk handling for Silicon Wave based devices and
> fixes kernel bug with id 42985.

please include here the content of /sys/kernel/debug/usb/devices that represents your device.

> Signed-off-by: Peter Poklop <peter.poklop@gmail.com>
> ---
> drivers/bluetooth/btusb.c | 3 +++
> 1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index cc92b0f..b3bceb1 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -322,6 +322,9 @@ static const struct usb_device_id blacklist_table[] = {
> 	{ USB_DEVICE(0x13d3, 0x3461), .driver_info = BTUSB_REALTEK },
> 	{ USB_DEVICE(0x13d3, 0x3462), .driver_info = BTUSB_REALTEK },
> 
> +	/* Several Silicon Wave based devices */
> +	{ USB_DEVICE(0x0c10, 0x0000), .driver_info = BTUSB_SWAVE },
> +
> 	{ }	/* Terminating entry */
> };

Regards

Marcel

