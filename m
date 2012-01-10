Return-Path: <cyrus@holtmann.org>
Message-ID: <1326183061.6454.194.camel@aeonflux>
Subject: Re: [PATCH] Bluetooth: Add support for BCM20702A0 [0489:e031]
From: Marcel Holtmann <marcel@holtmann.org>
To: harv@gmx.de
Cc: linux-bluetooth@vger.kernel.org
Date: Tue, 10 Jan 2012 00:11:01 -0800
In-Reply-To: <4F0BE4CB.30907@gmx.de>
References: <4F0ACADF.1060906@cestona.ro>
	 <1326137984.6454.152.camel@aeonflux> <4F0BE4CB.30907@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Harvey,

> >>    drivers/bluetooth/btusb.c |    1 +
> >>    1 files changed, 1 insertions(+), 0 deletions(-)
> >>
> >> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> >> index 55ac349..07622141a 100644
> >> --- a/drivers/bluetooth/btusb.c
> >> +++ b/drivers/bluetooth/btusb.c
> >> @@ -101,6 +101,7 @@ static struct usb_device_id btusb_table[] = {
> >>        { USB_DEVICE(0x0c10, 0x0000) },
> >>
> >>        /* Broadcom BCM20702A0 */
> >> +    { USB_DEVICE(0x0489, 0xe031) },
> >>        { USB_DEVICE(0x0a5c, 0x21e3) },
> >>        { USB_DEVICE(0x413c, 0x8197) },
> 
> I fear this alone won't be enough. We are discussing this topic here:
> https://bbs.archlinux.org/viewtopic.php?pid=1038521#p1038521
> 
> Short summary:
> The adapter seems to work in first but the log files say:
> 'localhost bluetoothd[1718]: Inquiry Failed with status 0x12'
> while scanning.
> 
>  From a short look in the Windows inf. file:
> Fujitsu is listed there in a separate section called RAMUSBE031. There 
> is also this "BCM20702A0_001.001.024.0023.0055.hex" file copied along 
> with the driver, which is then referenced in the registry as 
> "RAMPatchFileName". There is a long list of other 20702 adapters divided 
> in those that need a 'RAM patch' or not. Maybe you could complete your 
> list of compatible devices bases on this.

this most likely means that your device is a ROM chip that needs some
patching (kinda firmware download) to fix some bugs in the ROM mask.

Have a USB sniffer handy and figure out on how they upload this file
into the chip. Most likely they are some HCI vendor commands.

Regards

Marcel


