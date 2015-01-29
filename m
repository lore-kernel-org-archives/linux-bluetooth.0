Return-Path: <cyrus@holtmann.org>
From: Jakub Pawlowski <jpawlowski@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Pawlowski <jpawlowski@google.com>
Subject: [PATCH] Bluetooth: Set HCI_QUIRK_STRICT_DUPLICATE_FILTER for BTUSB_ATH3012
Date: Thu, 29 Jan 2015 10:38:34 -0800
Message-Id: <1422556714-12493-1-git-send-email-jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The Bluetooth controllers from Atheros use a strict scanning filter
policy that filters based on Bluetooth device addresses and not on
RSSI. So tell the core about this.

Signed-off-by: Jakub Pawlowski <jpawlowski@google.com>
---
 drivers/bluetooth/btusb.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index d114786..3aa4b3c 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2731,8 +2731,10 @@ static int btusb_probe(struct usb_interface *intf,
 	if (id->driver_info & BTUSB_INTEL_BOOT)
 		set_bit(HCI_QUIRK_RAW_DEVICE, &hdev->quirks);
 
-	if (id->driver_info & BTUSB_ATH3012)
+	if (id->driver_info & BTUSB_ATH3012) {
 		hdev->set_bdaddr = btusb_set_bdaddr_ath3012;
+		set_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks);
+	}
 
 	if (id->driver_info & BTUSB_AMP) {
 		/* AMP controllers do not support SCO packets */
-- 
2.2.0.rc0.207.ga3a616c

