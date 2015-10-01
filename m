Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Subject: Re: Issues With USB Bluetooth Dongle
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAHkwNT=sQQz11YWsxivxb20mW7rh1U=CXTN7uyBqTzkXvNbXgA@mail.gmail.com>
Date: Thu, 1 Oct 2015 13:18:23 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <37D1ED5D-6FF5-4ABA-BD2A-222261BE1EAA@holtmann.org>
References: <CAHkwNT=sQQz11YWsxivxb20mW7rh1U=CXTN7uyBqTzkXvNbXgA@mail.gmail.com>
To: Anil Nair <anilcoll90@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anil,

> I have a USB Bluetooth Dongle it detects but i am unable to use it,
> Cannot pair with any mobile device or send any file.
> 
> I am using "Ubuntu 14.04 64-bit" with kernel version "3.13.0-65-generic"
> 
> Here is the output of dmesg,
> 
> [ 2920.744043] usb 3-1: new full-speed USB device number 3 using uhci_hcd
> [ 2920.985498] usb 3-1: New USB device found, idVendor=0a12, idProduct=0001
> [ 2920.985504] usb 3-1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
> [ 2920.985507] usb 3-1: Product: Bluetooth V2.0 Dongle
> [ 2920.985510] usb 3-1: Manufacturer: Bluetooth v2.0
> [ 2921.818696] usbcore: registered new interface driver btusb
> 
> And lsusb,
> 
> Bus 003 Device 003: ID 0a12:0001 Cambridge Silicon Radio, Ltd
> Bluetooth Dongle (HCI mode)
> 
> Please let me know if any more information is needed.
> 
> I wanted to know what is the issue with the device.

include /sys/kernel/debug/usb/devices from this device. And you might want to run btmon to see if one of the HCI commands is causing a problem. You could also just call hciconfig and see if the device is actually registered since it seems to load the btusb driver.

Then again, you are running a 3.13 kernel, that is a pretty old kernel.

Regards

Marcel

