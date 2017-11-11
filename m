Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.1 \(3445.4.7\))
Subject: Re: [PATCH] bluetooth: btusb: Add device ID for RTL8822BE
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20171111174326.9243-1-Larry.Finger@lwfinger.net>
Date: Sat, 11 Nov 2017 19:51:36 +0100
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-bluetooth@vger.kernel.org,
        Hon Weng Chong <honwchong@gmail.com>
Message-Id: <82ACB0CF-DD2F-4A44-A2F0-75D1C1B3DA9C@holtmann.org>
References: <20171111174326.9243-1-Larry.Finger@lwfinger.net>
To: Larry Finger <Larry.Finger@lwfinger.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Larry,

> The Asus Z370-I contains a Realtek RTL8822BE device with an associated
> BT chip using a USB ID of 0b05:185c. This device is added to the driver.
> 
> Signed-off-by: Hon Weng Chong <honwchong@gmail.com>
> Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
> ---
> drivers/bluetooth/btusb.c | 3 +++
> 1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 7a5c06aaa181..c265ef63cab7 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -373,6 +373,9 @@ static const struct usb_device_id blacklist_table[] = {
> 	{ USB_DEVICE(0x13d3, 0x3461), .driver_info = BTUSB_REALTEK },
> 	{ USB_DEVICE(0x13d3, 0x3462), .driver_info = BTUSB_REALTEK },
> 
> +	/* Additional Realtek 8822BE Bluetooth devices */
> +	{ USB_DEVICE(0x0b05, 0x1185c), .driver_info = BTUSB_REALTEK },
> +

I prefer to have /sys/kernel/debug/usb/devices for the device included in the commit message.

Regards

Marcel

