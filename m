Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: Handle Intel USB bootloader with buggy interrupt
Date: Sun,  6 Jul 2014 14:53:54 +0200
Message-Id: <1404651235-51172-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The interrupt interface for the Intel USB bootloader devices is only
enabled after receiving SetInterface(0, AltSetting=0). When this USB
command is not send, then no HCI events will be received.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/btusb.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 14314a12babe..fe24f600ed65 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -1807,6 +1807,18 @@ static int btusb_probe(struct usb_interface *intf,
 		data->isoc = NULL;
 	}
 
+	if (id->driver_info & BTUSB_INTEL_BOOT) {
+		/* A bug in the bootloader causes that interrupt interface is
+		 * only enabled after receiving SetInterface(0, AltSetting=0).
+		 */
+		err = usb_set_interface(data->udev, 0, 0);
+		if (err < 0) {
+			BT_ERR("failed to set interface 0, alt 0 %d", err);
+			hci_free_dev(hdev);
+			return err;
+		}
+	}
+
 	if (data->isoc) {
 		err = usb_driver_claim_interface(&btusb_driver,
 							data->isoc, data);
-- 
1.9.3

