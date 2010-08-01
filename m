Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] bluetooth: Add support Bluetooth controller of Macbook
 Pro  6,2 and 7,1
From: Marcel Holtmann <marcel@holtmann.org>
To: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: linux-bluetooth@vger.kernel.org, stable@kernel.org
In-Reply-To: <AANLkTimcf8nmrad8BP8aLw4OefAr1vNZANNRf7rPMrrG@mail.gmail.com>
References: <AANLkTimcf8nmrad8BP8aLw4OefAr1vNZANNRf7rPMrrG@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 01 Aug 2010 16:47:46 -0700
Message-ID: <1280706466.12579.11.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Nobuhiro,

> Bluetooth controller of Macbook Pro 6,2 and 7,1 does not work.
> Because Device Class of these controllers was set 255 (Vendor Sepecific Class).
> 
> Macbook Pro 7,1 :
> Bus 004 Device 005: ID 05ac:8213 Apple, Inc.
> Device Descriptor:
>   bLength                18
>   bDescriptorType         1
>   bcdUSB               2.00
>   bDeviceClass          255 Vendor Specific Class
>   bDeviceSubClass         1
>   bDeviceProtocol         1
>   bMaxPacketSize0        64
>   idVendor           0x05ac Apple, Inc.
>   idProduct          0x8213
>   bcdDevice            1.86
>   iManufacturer           1 Apple Inc.
>   iProduct                2 Bluetooth USB Host Controller
>   iSerial                 3 5C5948C81B99
>   bNumConfigurations      1

I prefer the details of /proc/bus/usb/devices or usb-devices.sh script.
And I do prefer one patch with it for each MacBook.

> Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> ---
>  drivers/bluetooth/btusb.c |    6 ++++++
>  1 files changed, 6 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 5d9cc53..00a6639 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -75,6 +75,12 @@ static struct usb_device_id btusb_table[] = {
>  	/* Canyon CN-BTU1 with HID interfaces */
>  	{ USB_DEVICE(0x0c10, 0x0000) },
> 
> +	/* Apple MacBookPro 6,2 */
> +	{ USB_DEVICE(0x05ac, 0x8218) },
> +
> +	/* Apple MacBookPro 7,2 */
> +	{ USB_DEVICE(0x05ac, 0x8213) },
> +
>  	{ }	/* Terminating entry */
>  };

Please sort them along the entry for the iMac11,1 and make sure it is
smaller PID first.

Regards

Marcel


