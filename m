Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Subject: Re: [PATCH v2] ath3k: Add support of MCI 13d3:3408 bt device
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CANoib0HW2umPpzzerYNq1fMMnkYxOa78o5X90-K=eNEnTGSO1w@mail.gmail.com>
Date: Wed, 19 Nov 2014 07:56:05 +0900
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org
Message-Id: <F01422F2-5F7C-406A-A06B-2C2CE96B9E3A@holtmann.org>
References: <CANoib0HW2umPpzzerYNq1fMMnkYxOa78o5X90-K=eNEnTGSO1w@mail.gmail.com>
To: Dmitry Tunin <hanipouspilot@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dmitry,

> Add support for bluetooth MCI WB335 (AR9565) Wi-Fi+bt module.
> It is AR3011 device according to iProduct == 0.
> So btusb should be blacklisted
> I submitted a wrong patch before asif  it was an AR3012 device,
> but it works both ways. This is the right one.

include the device details from /sys/kernel/debug/usb/devices.

> 
> Signed-off-by: Dmitry Tunin <hanipouspilot@gmail.com>
> are */

No idea what this are */ is.

> 
> ---
> 
> diff --git a/drivers/bluetooth/ath3k.c b/drivers/bluetooth/ath3k.c
> index d85ced2..3b53116 100644
> --- a/drivers/bluetooth/ath3k.c
> +++ b/drivers/bluetooth/ath3k.c
> @@ -69,6 +69,7 @@ static const struct usb_device_id ath3k_table[] = {
>  { USB_DEVICE(0x0CF3, 0x3002) },
>  { USB_DEVICE(0x0CF3, 0xE019) },
>  { USB_DEVICE(0x13d3, 0x3304) },
> + { USB_DEVICE(0x13d3, 0x3408) },
> 
>  /* Atheros AR9285 Malbec with sflash firmware */
>  { USB_DEVICE(0x03F0, 0x311D) },
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index edfc17b..bbf5c1c 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -146,6 +146,7 @@ static const struct usb_device_id blacklist_table[] = {
>  { USB_DEVICE(0x0cf3, 0x3002), .driver_info = BTUSB_IGNORE },
>  { USB_DEVICE(0x0cf3, 0xe019), .driver_info = BTUSB_IGNORE },
>  { USB_DEVICE(0x13d3, 0x3304), .driver_info = BTUSB_IGNORE },
> + { USB_DEVICE(0x13d3, 0x3408), .driver_info = BTUSB_IGNORE },

Fix whitespace here or use a proper mail client.

Regards

Marcel

