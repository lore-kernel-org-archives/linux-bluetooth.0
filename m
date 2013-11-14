Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.0 \(1822\))
Subject: Re: [PATCH] Enable autosuspend for Intel Bluetooth device
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20131112131641.76cd6c5f@han1-desk-dev>
Date: Thu, 14 Nov 2013 17:19:51 +0900
Cc: "linux-bluetooth@vger.kernel.org development"
	<linux-bluetooth@vger.kernel.org>, Don Fry <don.fry@intel.com>
Message-Id: <A5E1C194-6EBD-43D9-8B93-C97077165229@holtmann.org>
References: <20131112131641.76cd6c5f@han1-desk-dev>
To: Tedd Ho-Jeong An <tedd.an@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Tedd,

> This patch enables autosuspend for Intel Bluetooth device.
> 
> After btusb is loaded for Intel Bluetooth device, the power/control
> attribute contains "on" value by default which disables the autosuspend.
> Based on the USB PM document(Documentation/usb/power-management.txt),
> kernel disabled the autosuspend for all devices other than hub by default.
> 
> "The USB specification states that all USB devices must support power
> management.  Nevertheless, the sad fact is that many devices do not
> support it very well.  You can suspend them all right, but when you
> try to resume them they disconnect themselves from the USB bus or
> they stop working entirely.  This seems to be especially prevalent
> among printers and scanners, but plenty of other types of device have
> the same deficiency.
> 
> For this reason, by default the kernel disables autosuspend (the
> power/control attribute is initialized to "on") for all devices other
> than hubs.  Hubs, at least, appear to be reasonably well-behaved in
> this regard."
> 
> This document also described how the driver can enables the autosuspend
> by using an USB api.
> 
> "Drivers can enable autosuspend for their devices by calling
> 
> 	usb_enable_autosuspend(struct usb_device *udev);
> 
> in their probe() routine, if they know that the device is capable of
> suspending and resuming correctly.  This is exactly equivalent to
> writing "auto" to the device's power/control attribute."
> 
> For Intel Bluetooth device, the autosuspend needs to be enabled so the
> device can transit to LPM(Low Power Mode) and ULPM(Ultra LPM) states after
> receiving suspend message from the host.
> 
> Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
> ---
> drivers/bluetooth/btusb.c |    4 +++-
> 1 file changed, 3 insertions(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

