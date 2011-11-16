Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Bluetooth: btusb: Add Qualcomm Atheros AR3006 in
 blacklist_table
From: Marcel Holtmann <marcel@holtmann.org>
To: "Yao, Costa" <cqyao@qca.qualcomm.com>
Cc: "padovan@profusion.mobi" <padovan@profusion.mobi>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Wed, 16 Nov 2011 22:29:10 +0900
In-Reply-To: <07BBB2AAB1A10A488A2AD166C7CB8B0DEF3A49@nasanexd02b.na.qualcomm.com>
References: <07BBB2AAB1A10A488A2AD166C7CB8B0DEF3A49@nasanexd02b.na.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1321450153.15441.548.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Costa,

> Signed-off-by: Costa Yao <cqyao@qca.qualcomm.com>
> ---
>  drivers/bluetooth/btusb.c |    5 ++++-
>  1 files changed, 4 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 39dd65c..94124ad 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -55,6 +55,7 @@ static struct usb_driver btusb_driver;
>  #define BTUSB_BROKEN_ISOC	0x20
>  #define BTUSB_WRONG_SCO_MTU	0x40
>  #define BTUSB_ATH3012		0x80
> +#define BTUSB_ATH3006		0x0100
>  
>  static struct usb_device_id btusb_table[] = {
>  	/* Bluetooth USB interface */
> @@ -125,6 +126,7 @@ static struct usb_device_id blacklist_table[] = {
>  
>  	/* Atheros 3012 with sflash firmware */
>  	{ USB_DEVICE(0x0cf3, 0x3004), .driver_info = BTUSB_ATH3012 },
> +	{ USB_DEVICE(0x0cf3, 0x3006), .driver_info = BTUSB_ATH3006 },
>  
>  	/* Atheros AR5BBU12 with sflash firmware */
>  	{ USB_DEVICE(0x0489, 0xe02c), .driver_info = BTUSB_IGNORE },
> @@ -937,7 +939,8 @@ static int btusb_probe(struct usb_interface *intf,
>  	if (ignore_sniffer && id->driver_info & BTUSB_SNIFFER)
>  		return -ENODEV;
>  
> -	if (id->driver_info & BTUSB_ATH3012) {
> +	if ((id->driver_info & BTUSB_ATH3012) ||
> +				(id->driver_info & BTUSB_ATH3006)) {
>  		struct usb_device *udev = interface_to_usbdev(intf);
>  
>  		/* Old firmware would otherwise let ath3k driver load

        if (id->driver_info & BTUSB_ATH3012) {
                struct usb_device *udev = interface_to_usbdev(intf);

                /* Old firmware would otherwise let ath3k driver load
                 * patch and sysconfig files */
                if (le16_to_cpu(udev->descriptor.bcdDevice) <= 0x0001)
                        return -ENODEV;
        }

are you sure this is true for the 3006 as well? Otherwise just using the
BTUSB_IGNORE quirk to blacklist a device would be enough.

And start writing detailed commit message that explains why this quirk
is correct and needed.

Regards

Marcel


