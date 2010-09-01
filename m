Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 1/2] hid/hid-sony: Apply sixaxis quirks only to sixaxis
From: Bastien Nocera <hadess@hadess.net>
To: Antonio Ospite <ospite@studenti.unina.it>
Cc: linux-input@vger.kernel.org, linux-bluetooth@vger.kernel.org,
	cbe-oss-dev@lists.ozlabs.org
In-Reply-To: <1272917756-31098-2-git-send-email-ospite@studenti.unina.it>
References: <1272917756-31098-1-git-send-email-ospite@studenti.unina.it>
	 <1272917756-31098-2-git-send-email-ospite@studenti.unina.it>
Content-Type: text/plain; charset="ISO-8859-1"
Date: Wed, 01 Sep 2010 17:13:35 +0100
Message-ID: <1283357615.2361.20.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, 2010-05-03 at 22:15 +0200, Antonio Ospite wrote:
> Be more explicit and avoid calling sony_set_operational_usb() when we
> have USB_DEVICE_ID_SONY_VAIO_VGX_MOUSE.
> 
> While at it, rename the sony_set_operational routines to
> sixaxis_set_operational as they are sixaxis specific.
> 
> This is also in preparation for the sysfs interface to set and get bdaddr
> over usb and for some other Sixaxis report fixup.
> 
> Signed-off-by: Antonio Ospite <ospite@studenti.unina.it>

Signed-off-by: Bastien Nocera <hadess@hadess.net>

> ---
>  drivers/hid/hid-sony.c |   28 ++++++++++++++--------------
>  1 files changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
> index 402d557..d61f268 100644
> --- a/drivers/hid/hid-sony.c
> +++ b/drivers/hid/hid-sony.c
> @@ -24,7 +24,9 @@
>  
>  #include "hid-ids.h"
>  
> -#define VAIO_RDESC_CONSTANT 0x0001
> +#define VAIO_RDESC_CONSTANT     (1 << 0)
> +#define SIXAXIS_CONTROLLER_USB  (1 << 1)
> +#define SIXAXIS_CONTROLLER_BT   (1 << 2)
>  
>  struct sony_sc {
>  	unsigned long quirks;
> @@ -49,7 +51,7 @@ static void sony_report_fixup(struct hid_device *hdev, __u8 *rdesc,
>   * to "operational".  Without this, the ps3 controller will not report any
>   * events.
>   */
> -static int sony_set_operational_usb(struct hid_device *hdev)
> +static int sixaxis_set_operational_usb(struct hid_device *hdev)
>  {
>  	struct usb_interface *intf = to_usb_interface(hdev->dev.parent);
>  	struct usb_device *dev = interface_to_usbdev(intf);
> @@ -74,7 +76,7 @@ static int sony_set_operational_usb(struct hid_device *hdev)
>  	return ret;
>  }
>  
> -static int sony_set_operational_bt(struct hid_device *hdev)
> +static int sixaxis_set_operational_bt(struct hid_device *hdev)
>  {
>  	unsigned char buf[] = { 0xf4,  0x42, 0x03, 0x00, 0x00 };
>  	return hdev->hid_output_raw_report(hdev, buf, sizeof(buf), HID_FEATURE_REPORT);
> @@ -108,16 +110,12 @@ static int sony_probe(struct hid_device *hdev, const struct hid_device_id *id)
>  		goto err_free;
>  	}
>  
> -	switch (hdev->bus) {
> -	case BUS_USB:
> -		ret = sony_set_operational_usb(hdev);
> -		break;
> -	case BUS_BLUETOOTH:
> -		ret = sony_set_operational_bt(hdev);
> -		break;
> -	default:
> +	if (sc->quirks & SIXAXIS_CONTROLLER_USB)
> +		ret = sixaxis_set_operational_usb(hdev);
> +	else if (sc->quirks & SIXAXIS_CONTROLLER_BT)
> +		ret = sixaxis_set_operational_bt(hdev);
> +	else
>  		ret = 0;
> -	}
>  
>  	if (ret < 0)
>  		goto err_stop;
> @@ -137,8 +135,10 @@ static void sony_remove(struct hid_device *hdev)
>  }
>  
>  static const struct hid_device_id sony_devices[] = {
> -	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS3_CONTROLLER) },
> -	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS3_CONTROLLER) },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS3_CONTROLLER),
> +		.driver_data = SIXAXIS_CONTROLLER_USB },
> +	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS3_CONTROLLER),
> +		.driver_data = SIXAXIS_CONTROLLER_BT },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_VAIO_VGX_MOUSE),
>  		.driver_data = VAIO_RDESC_CONSTANT },
>  	{ }


