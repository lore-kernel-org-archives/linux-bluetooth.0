Return-Path: <cyrus@holtmann.org>
From: Loic Poulain <loic.poulain@intel.com>
To: marcel@holtmann.org
Cc: linux-bluetooth@vger.kernel.org,
	Loic Poulain <loic.poulain@intel.com>
Subject: [PATCH] Bluetooth: btusb: Fix Intel controller hang after shutdown
Date: Thu, 21 May 2015 13:42:44 +0200
Message-Id: <1432208564-3341-1-git-send-email-loic.poulain@intel.com>
List-ID: <linux-bluetooth.vger.kernel.org>

The vendor command (0xfc3f) in btusb_shutdown_intel causes an internal
reset with old firmware. The controller has a bug with the first HCI
command sent to it. The workaround is to send HCI Reset command first
which will reset the number of completed commands.

This patch adds the HCI_QUIRK_RESET_ON_CLOSE flag for Intel controller
so that a HCI reset command will always follow a intel shutdown.

Signed-off-by: Loic Poulain <loic.poulain@intel.com>
---
 drivers/bluetooth/btusb.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index d21f3b4..36881e8 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -3140,6 +3140,13 @@ static int btusb_probe(struct usb_interface *intf,
 		hdev->set_bdaddr = btintel_set_bdaddr;
 		set_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks);
 		set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks);
+
+		/* The shutdown causes an internal reset with old firmware.
+		 * In order to avoid the Bug with the first HCI command, we have
+		 * to send a HCI reset which will reset the number of completed
+		 * command.
+		 */
+		set_bit(HCI_QUIRK_RESET_ON_CLOSE, &hdev->quirks);
 	}
 
 	if (id->driver_info & BTUSB_INTEL_NEW) {
-- 
1.9.1
