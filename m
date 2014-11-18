Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.0 \(1990.1\))
Subject: Re: [PATCH] Add support for bluetooth BCM20702A1 variant
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <5469F727.7030403@gmail.com>
Date: Tue, 18 Nov 2014 10:12:51 +0900
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <5CE47F19-5225-4DB7-99E7-CD613DFF41B2@holtmann.org>
References: <5469F727.7030403@gmail.com>
To: Fabio K <healthkit@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Fabio,

> On Nov 17, 2014, at 22:24, Fabio K <healthkit@gmail.com> wrote:
> 
> Linux 3.18-rc5 (from git commit fc14f9c)
> 
> This variant requires the flag BTUSB_BCM_PATCHRAM to work.

please include the device details from /sys/kernel/debug/usb/devices in the commit message and preferable some manufacture information including where you can obtain the firmware file from.

> 
> Signed-off-by: Fabio K <healthkit@gmail.com>
> ---
> drivers/bluetooth/btusb.c | 2 ++
> 1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index edfc17b..7c0fdd2 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -106,6 +106,8 @@ static const struct usb_device_id btusb_table[] = {
>     { USB_DEVICE(0x0b05, 0x17b5) },
>     { USB_DEVICE(0x0b05, 0x17cb) },
>     { USB_DEVICE(0x413c, 0x8197) },
> +    { USB_DEVICE(0x13d3, 0x3404),
> +      .driver_info = BTUSB_BCM_PATCHRAM },

I think your patch has a whitespace damage here.

> 
>     /* Foxconn - Hon Hai */
>     { USB_VENDOR_AND_INTERFACE_INFO(0x0489, 0xff, 0x01, 0x01) },

Regards

Marcel

