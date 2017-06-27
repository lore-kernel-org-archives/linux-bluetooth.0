Return-Path: <linux-kernel-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] Bluetooth: btusb: Add device ID for Realtek RTL8723BU
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20170626184245.2701-1-Larry.Finger@lwfinger.net>
Date: Tue, 27 Jun 2017 02:02:03 +0200
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-bluetooth@vger.kernel.org
Message-Id: <0567ACA4-7DB7-454B-A5B9-CA70E6D95F26@holtmann.org>
References: <20170626184245.2701-1-Larry.Finger@lwfinger.net>
To: Larry Finger <Larry.Finger@lwfinger.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Larry,

> This device is not recognized by the driver.
> 
> Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
> ---
> drivers/bluetooth/btusb.c | 3 +++
> 1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 7fa373b428f8..5eb4a7446426 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -356,6 +356,9 @@ static const struct usb_device_id blacklist_table[] = {
> 	{ USB_DEVICE(0x13d3, 0x3416), .driver_info = BTUSB_REALTEK },
> 	{ USB_DEVICE(0x13d3, 0x3459), .driver_info = BTUSB_REALTEK },
> 
> +	/* Additional Realtek 8723BU Bluetooth devices */
> +	{ USB_DEVICE(0x7392, 0xa611), .driver_info = BTUSB_REALTEK },
> +
> 	/* Additional Realtek 8821AE Bluetooth devices */
> 	{ USB_DEVICE(0x0b05, 0x17dc), .driver_info = BTUSB_REALTEK },
> 	{ USB_DEVICE(0x13d3, 0x3414), .driver_info = BTUSB_REALTEK },

can you include /sys/kernel/debug/usb/devices for this device into the commit message?

Regards

Marcel
