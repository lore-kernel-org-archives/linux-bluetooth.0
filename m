Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1465652610-1293-1-git-send-email-yvain.thonnart@m4x.org>
References: <1465652610-1293-1-git-send-email-yvain.thonnart@m4x.org>
From: Yvain Thonnart <yvain.thonnart@m4x.org>
Date: Thu, 23 Jun 2016 22:36:17 +0200
Message-ID: <CAET37tFHBznA1bYjgxLT6eheQsb3_2SobuG2ONsNvQ_cDrNrqQ@mail.gmail.com>
Subject: Re: [PATCH] bluetooth: add support for device 0489:e092
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
To: unlisted-recipients:; (no To-header on input)
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Dear bluetooth subsystem maintainers,

May I ask some feedback about the patch I sent a few days ago for the
integration of my bluetooth chipset ?
Is the information I provided insufficient for integration ?
Do I need to compile a full mainline kernel for verification instead
of an extra module for the vanilla 4.4.0 kernel from ubuntu ?

I upgraded yesterday to 4.4.0-24-generic and recompiled the btusb.ko
module successfully.
Obviously I will need to do that quite often before the ubuntu
packages catch-up with the future kernel releases.

The sticker on the back of the laptop indicates: Wlan+bluetooth module QCNFA344

After modprobing my extra module dmesg output is as follows:
[  371.497775] usbcore: registered new interface driver btusb
[  371.553625] Bluetooth: hci0: using rampatch file:
qca/rampatch_usb_00000200.bin
[  371.553627] Bluetooth: hci0: QCA: patch rome 0x200 build 0x299,
firmware rome 0x200 build 0x111
[  371.602628] Bluetooth: hci0: using NVM file: qca/nvm_usb_00000200.bin
[  374.788095] Bluetooth: hci0: Failed to send body at 4 of 1859 (-110)
[  379.787651] Bluetooth: hci0: Failed to access otp area (-110)
[  381.896683] usb 3-10: USB disconnect, device number 6
[  382.271408] usb 3-10: new full-speed USB device number 7 using xhci_hcd
[  382.400415] usb 3-10: New USB device found, idVendor=0489, idProduct=e092
[  382.400418] usb 3-10: New USB device strings: Mfr=0, Product=0,
SerialNumber=0
[  382.401747] Bluetooth: hci0: using NVM file: qca/nvm_usb_00000200.bin

With many thanks for your dedication to this huge project,
Best regards,

Yvain Thonnart

2016-06-11 15:43 GMT+02:00 Yvain THONNART <yvain.thonnart@m4x.org>:
> With current btusb.ko kernel module, Bluetooth pretends to be active
> but there is no real activity.
>
> I'm using an Acer Aspire VN7-791.
>
> Output of lsusb:
> Bus 003 Device 007: ID 0489:e092 Foxconn / Hon Hai
>
> On my laptop, this device is actually used as a combo with wifi chipset
> Atheros Qualcomm Killer N1525 Wireless-AC [168c:003e],
>
> * Fix by adding a declaration in kernel sources drivers/bluetooth/btusb.c
>
>         { USB_DEVICE(0x0489, 0xe092), .driver_info = BTUSB_QCA_ROME },
>
> * Compiled extra module /lib/modules/4.4.0-22-generic/extra/btusb.ko
>
> * Successfully tested against my phone (obex file transfer)
>
> DistroRelease: Ubuntu 16.04
> Package: linux-image-4.4.0-22-generic 4.4.0-22.40
> ProcVersionSignature: Ubuntu 4.4.0-22.40-generic 4.4.8
> Uname: Linux 4.4.0-22-generic x86_64
> Signed-off-by: Yvain THONNART <yvain.thonnart@m4x.org>
> ---
>  drivers/bluetooth/btusb.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index a191e31..74b52bb 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -244,6 +244,7 @@ static const struct usb_device_id blacklist_table[] = {
>         { USB_DEVICE(0x0cf3, 0xe007), .driver_info = BTUSB_QCA_ROME },
>         { USB_DEVICE(0x0cf3, 0xe300), .driver_info = BTUSB_QCA_ROME },
>         { USB_DEVICE(0x0cf3, 0xe360), .driver_info = BTUSB_QCA_ROME },
> +       { USB_DEVICE(0x0489, 0xe092), .driver_info = BTUSB_QCA_ROME },
>
>         /* Broadcom BCM2035 */
>         { USB_DEVICE(0x0a5c, 0x2009), .driver_info = BTUSB_BCM92035 },
> --
> 2.7.4
>
