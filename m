Return-Path: <cyrus@holtmann.org>
Date: Thu, 19 Sep 2013 14:24:03 -0500
From: Gustavo Padovan <gustavo@padovan.org>
To: Ken O'Brien <kernel@kenobrien.org>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bluetooth: btusb: Added support for Belkin F8065bf usb
 bluetooth device
Message-ID: <20130919192403.GH4006@joana>
References: <1379610373-2640-1-git-send-email-kernel@kenobrien.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1379610373-2640-1-git-send-email-kernel@kenobrien.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ken,

2013-09-19 Ken O'Brien <kernel@kenobrien.org>:

> Belkin bluetooth device's usb device id added to generic usb bluetooth driver.
> 
> Signed-off-by: Ken O'Brien <kernel@kenobrien.org>
> ---
>  drivers/bluetooth/btusb.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 8e16f0a..117b90c 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -111,6 +111,9 @@ static struct usb_device_id btusb_table[] = {
>  
>  	/*Broadcom devices with vendor specific id */
>  	{ USB_VENDOR_AND_INTERFACE_INFO(0x0a5c, 0xff, 0x01, 0x01) },
> +
> +	/* Belkin F8T065bf */
> +	{ USB_DEVICE(0x050d, 0x065a) },

Could you please add the output of /sys/kernel/debug/usb/devices for this
bluetooth controller to the commit messages, like we do for any new device id
we add to btusb. Thanks.

	Gustavo
