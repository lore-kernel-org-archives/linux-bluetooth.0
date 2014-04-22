Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Revert "Bluetooth: Enable autosuspend for Intel Bluetooth device"
Date: Tue, 22 Apr 2014 14:04:16 -0700
Message-Id: <1398200656-55480-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This reverts commit d2bee8fb6e18f6116aada39851918473761f7ab1.

Enabling autosuspend for Intel Bluetooth devices has been shown to not
work reliable. It does work for some people with certain combinations
of USB host controllers, but for others it puts the device to sleep and
it will not wake up for any event.

These events can be important ones like HCI Inquiry Complete or HCI
Connection Request. The events will arrive as soon as you poke the
device with a new command, but that is not something we can do in
these cases.

Initially there were patches to the xHCI USB controller that fixed
this for some people, but not for all. This could be well a problem
somewhere in the USB subsystem or in the USB host controllers or
just plain a hardware issue somewhere. At this moment we just do
not know and the only safe action is to revert this patch.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Cc: Tedd Ho-Jeong An <tedd.an@intel.com>
Cc: stable@vger.kernel.org
---
 drivers/bluetooth/btusb.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index f338b0c5a8de..dc99eff2a4de 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -1485,10 +1485,8 @@ static int btusb_probe(struct usb_interface *intf,
 	if (id->driver_info & BTUSB_BCM92035)
 		hdev->setup = btusb_setup_bcm92035;
 
-	if (id->driver_info & BTUSB_INTEL) {
-		usb_enable_autosuspend(data->udev);
+	if (id->driver_info & BTUSB_INTEL)
 		hdev->setup = btusb_setup_intel;
-	}
 
 	/* Interface numbers are hardcoded in the specification */
 	data->isoc = usb_ifnum_to_if(data->udev, 1);
-- 
1.9.0

