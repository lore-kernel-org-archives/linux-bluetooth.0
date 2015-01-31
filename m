Return-Path: <cyrus@holtmann.org>
From: Jakub Pawlowski <jpawlowski@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Pawlowski <jpawlowski@google.com>
Subject: [PATCH] Bluetooth: Set HCI_QUIRK_STRICT_DUPLICATE_FILTER for BTUSB_INTEL
Date: Fri, 30 Jan 2015 18:55:58 -0800
Message-Id: <1422672958-17279-1-git-send-email-jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The Bluetooth controllers from Intel use a strict scanning filter
policy that filters based on Bluetooth device addresses and not on
RSSI. So tell the core about this.

Signed-off-by: Jakub Pawlowski <jpawlowski@google.com>
---
 drivers/bluetooth/btusb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index a3a47c5..d084856 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2705,6 +2705,7 @@ static int btusb_probe(struct usb_interface *intf,
 	if (id->driver_info & BTUSB_INTEL) {
 		hdev->setup = btusb_setup_intel;
 		hdev->set_bdaddr = btusb_set_bdaddr_intel;
+		set_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks);
 	}
 
 	if (id->driver_info & BTUSB_INTEL_NEW) {
-- 
2.2.0.rc0.207.ga3a616c

