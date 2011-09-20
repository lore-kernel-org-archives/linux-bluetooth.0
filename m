Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Bluetooth: Add support for Broadcom BCM20702A0.
From: Marcel Holtmann <marcel@holtmann.org>
To: Jesse Sung <jesse.sung@canonical.com>
Cc: linux-bluetooth@vger.kernel.org, 854399@bugs.launchpad.net
Date: Tue, 20 Sep 2011 15:05:31 +0200
In-Reply-To: <4E7840CF.5010805@canonical.com>
References: <4E7840CF.5010805@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1316523932.1937.102.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jesse,

> Add a new entry (413c:8197) to device ID table.
> 
> Signed-off-by: Wen-chien Jesse Sung <jesse.sung@canonical.com>
> ---
>   drivers/bluetooth/btusb.c |    3 +++
>   1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 91d13a9..d786bb8 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -91,6 +91,9 @@ static struct usb_device_id btusb_table[] = {
>   	/* Canyon CN-BTU1 with HID interfaces */
>   	{ USB_DEVICE(0x0c10, 0x0000) },
> 
> +	/* Broadcom BCM20702A0 */
> +	{ USB_DEVICE(0x413c, 0x8197) },
> +

please prove that this is needed. What does usb-devices tell you about
this device?

Regards

Marcel


