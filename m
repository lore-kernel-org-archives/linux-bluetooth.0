Return-Path: <cyrus@holtmann.org>
Date: Mon, 21 Nov 2011 14:16:20 -0200
From: Gustavo Padovan <padovan@profusion.mobi>
To: "Yao, Costa" <cqyao@qca.qualcomm.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH] Bluetooth: btusb: Add Qualcomm Atheros AR3006 in
 blacklist_table
Message-ID: <20111121161620.GG2552@joana>
References: <07BBB2AAB1A10A488A2AD166C7CB8B0DEF3A49@nasanexd02b.na.qualcomm.com>
 <1321450153.15441.548.camel@aeonflux>
 <07BBB2AAB1A10A488A2AD166C7CB8B0DEF3C48@nasanexd02b.na.qualcomm.com>
 <1321545089.15441.572.camel@aeonflux>
 <07BBB2AAB1A10A488A2AD166C7CB8B0DEF3D67@nasanexd02b.na.qualcomm.com>
 <1321593478.15441.578.camel@aeonflux>
 <07BBB2AAB1A10A488A2AD166C7CB8B0DEF3DD8@nasanexd02b.na.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <07BBB2AAB1A10A488A2AD166C7CB8B0DEF3DD8@nasanexd02b.na.qualcomm.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Costa,

* Yao, Costa <cqyao@qca.qualcomm.com> [2011-11-18 06:15:26 +0000]:

> Add AR3006 entry in blacklist_table in btusb.c for bcdDevice check.
> Then ath3k.c has the chance to download firmware and reset hardware.
> 
> Signed-off-by: Costa Yao <cqyao@qca.qualcomm.com>
> ---
>  drivers/bluetooth/btusb.c |    7 ++++---
>  1 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 39dd65c..4ba4fdf 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -54,7 +54,7 @@ static struct usb_driver btusb_driver;
>  #define BTUSB_BCM92035		0x10
>  #define BTUSB_BROKEN_ISOC	0x20
>  #define BTUSB_WRONG_SCO_MTU	0x40
> -#define BTUSB_ATH3012		0x80
> +#define BTUSB_ATH3K			0x80
>  
>  static struct usb_device_id btusb_table[] = {
>  	/* Bluetooth USB interface */
> @@ -124,7 +124,8 @@ static struct usb_device_id blacklist_table[] = {
>  	{ USB_DEVICE(0x03f0, 0x311d), .driver_info = BTUSB_IGNORE },
>  
>  	/* Atheros 3012 with sflash firmware */
> -	{ USB_DEVICE(0x0cf3, 0x3004), .driver_info = BTUSB_ATH3012 },
> +	{ USB_DEVICE(0x0cf3, 0x3004), .driver_info = BTUSB_ATH3K },
> +	{ USB_DEVICE(0x0cf3, 0x3006), .driver_info = BTUSB_ATH3K },
>  
>  	/* Atheros AR5BBU12 with sflash firmware */
>  	{ USB_DEVICE(0x0489, 0xe02c), .driver_info = BTUSB_IGNORE },
> @@ -937,7 +938,7 @@ static int btusb_probe(struct usb_interface *intf,
>  	if (ignore_sniffer && id->driver_info & BTUSB_SNIFFER)
>  		return -ENODEV;
>  
> -	if (id->driver_info & BTUSB_ATH3012) {
> +	if (id->driver_info & BTUSB_ATH3K) {
>  		struct usb_device *udev = interface_to_usbdev(intf);
>  
>  		/* Old firmware would otherwise let ath3k driver load


Patch does not apply, please send a proper and clean git formatted patch. You
can test if it applies with git am. 

applying: RE: [PATCH] Bluetooth: btusb: Add Qualcomm Atheros AR3006 in blacklist_table
/home/padovan/p/linux-trees/bluetooth/.git/rebase-apply/patch:14: trailing whitespace.
#define BTUSB_ATH3K                     0x80
/home/padovan/p/linux-trees/bluetooth/.git/rebase-apply/patch:23: trailing whitespace.
        { USB_DEVICE(0x0cf3, 0x3004), .driver_info = BTUSB_ATH3K },
/home/padovan/p/linux-trees/bluetooth/.git/rebase-apply/patch:24: trailing whitespace.
        { USB_DEVICE(0x0cf3, 0x3006), .driver_info = BTUSB_ATH3K },
/home/padovan/p/linux-trees/bluetooth/.git/rebase-apply/patch:33: trailing whitespace.
        if (id->driver_info & BTUSB_ATH3K) {


	Gustavo
