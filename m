Return-Path: <cyrus@holtmann.org>
Date: Tue, 12 Nov 2013 13:16:41 -0800
From: Tedd Ho-Jeong An <tedd.an@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: don.fry@intel.com, marcel@holtmann.org, tedd.an@intel.com
Subject: [PATCH] Enable autosuspend for Intel Bluetooth device
Message-ID: <20131112131641.76cd6c5f@han1-desk-dev>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-bluetooth.vger.kernel.org>

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch enables autosuspend for Intel Bluetooth device.

After btusb is loaded for Intel Bluetooth device, the power/control
attribute contains "on" value by default which disables the autosuspend.
Based on the USB PM document(Documentation/usb/power-management.txt),
kernel disabled the autosuspend for all devices other than hub by default.

"The USB specification states that all USB devices must support power
management.  Nevertheless, the sad fact is that many devices do not
support it very well.  You can suspend them all right, but when you
try to resume them they disconnect themselves from the USB bus or
they stop working entirely.  This seems to be especially prevalent
among printers and scanners, but plenty of other types of device have
the same deficiency.

For this reason, by default the kernel disables autosuspend (the
power/control attribute is initialized to "on") for all devices other
than hubs.  Hubs, at least, appear to be reasonably well-behaved in
this regard."

This document also described how the driver can enables the autosuspend
by using an USB api.

"Drivers can enable autosuspend for their devices by calling

	usb_enable_autosuspend(struct usb_device *udev);

in their probe() routine, if they know that the device is capable of
suspending and resuming correctly.  This is exactly equivalent to
writing "auto" to the device's power/control attribute."

For Intel Bluetooth device, the autosuspend needs to be enabled so the
device can transit to LPM(Low Power Mode) and ULPM(Ultra LPM) states after
receiving suspend message from the host.

Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
---
 drivers/bluetooth/btusb.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index c206091..0dc9409 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -1437,8 +1437,10 @@ static int btusb_probe(struct usb_interface *intf,
 	if (id->driver_info & BTUSB_BCM92035)
 		hdev->setup = btusb_setup_bcm92035;
 
-	if (id->driver_info & BTUSB_INTEL)
+	if (id->driver_info & BTUSB_INTEL) {
+		usb_enable_autosuspend(data->udev);
 		hdev->setup = btusb_setup_intel;
+	}
 
 	/* Interface numbers are hardcoded in the specification */
 	data->isoc = usb_ifnum_to_if(data->udev, 1);
-- 
1.7.9.5
