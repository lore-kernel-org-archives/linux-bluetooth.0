Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Aleksey <info@dv2c.ru>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: btusb: add one more device to fixed Invalid initialization bug for kernel since 3.x
Date: Fri, 08 May 2015 09:11:58 +0200
Message-ID: <1588358.UJXQXaaSbI@leonov>
In-Reply-To: <1849903.jsc2NzCIHo@vwd-1>
References: <1849903.jsc2NzCIHo@vwd-1>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Aleksey,

On Friday 08 of May 2015 02:11:27 Aleksey wrote:
> In "Roper Class 1 Bluetooth Dongle" since 3.x kernel preset bug with invalid
> device initialization.
> 
> In earlyer version
> $> hciconfig hci0 up
> Can't init device hci0: Connection timed out (110)
> 
> In new kernel
> $> hciconfig hci0 up
> Can't init device hci0: Invalid request code (56)
> 
> with my device
> [    3.359071] usb 5-1: New USB device found, idVendor=1310, idProduct=0001
> [    3.359075] usb 5-1: New USB device strings: Mfr=1, Product=2,
> SerialNumber=3 [    3.359078] usb 5-1: Product: SiW
> [    3.359080] usb 5-1: Manufacturer: SiW
> [    3.359083] usb 5-1: SerialNumber: E7BB050D0B00
> 
> 
> Full diskussion about that problem present in
> https://bugzilla.kernel.org/show_bug.cgi?id=60901 "- [PATCH]Roper Class 1
> Bluetooth Dongle / TRENDnet TBW-102UB not working with all kernel 3.x
> tested"
> 
> After "Introducing HCI_QUIRK_BROKEN_LOCAL_COMMANDS constant" from Marcel
> Holtmann that bug been proper fixed, but my "Silicon Wave based" device not
> been included in list with BTUSB_SWAVE.
> 
> Don't know about other device - i have only one dongle with that problem,
> but adding BTUSB_SWAVE to driver_info for my 0x1310, 0x0001 dongle full
> fixed that problem, and now my device can bee in UP state..
> 
> More over, i check http://www.linux-usb.org/usb-ids.html and not find 1300
> device - i find only "1310 Name: Roper"
> 
> I think, what used 0x1300 wrong and meant actually 0x1310

Checking http://www.linux-usb.org/usb.ids confirm that 0x1300 instead of 
0x1310 is a typo.

> 
> If belive a bug "stopped work bluetooth"
> https://bugzilla.kernel.org/show_bug.cgi?id=51831 in "all worked" karnel
> 2.6.38 i can't fined 1300, But 1310 in this kernel works well.
> 
> 
> 
> Signed-off-by: Aleksei Volkov <info@dv2c.ru>
> ---
>  drivers/bluetooth/btusb.c | 1+-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff -up linux-4.0.0-gentoo/drivers/bluetooth/btusb.c.orig
> linux-4.0.0-gentoo/drivers/bluetooth/btusb.c ---
> linux-4.0.0/drivers/bluetooth/btusb.c.orig	2015-05-01 12:06:59.000000000
> +0300 +++ linux-4.0.0/drivers/bluetooth/btusb.c	2015-05-07
> 22:22:13.000000000 +0300 @@ -254,6 +254,6 @@ static const struct
> usb_device_id blackl
> 
>  	/* Roper Class 1 Bluetooth Dongle (Silicon Wave based) */
> -	{ USB_DEVICE(0x1300, 0x0001), .driver_info = BTUSB_SWAVE },
> +	{ USB_DEVICE(0x1310, 0x0001), .driver_info = BTUSB_SWAVE },
> 
>  	/* Digianswer devices */
>  	{ USB_DEVICE(0x08fd, 0x0001), .driver_info = BTUSB_DIGIANSWER },

-- 
BR
Szymon Janc
