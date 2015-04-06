Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: btbcm: Move firmware info output to correct location
Date: Mon,  6 Apr 2015 11:24:35 -0700
Message-Id: <1428344675-8462-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The variable hw_name gets only set after the firmware info output. That
was not the intention and thus move the output of the firmware info
string after the value for hw_name has been determinated.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/btbcm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
index c9e16b40c3bc..d0741f3ed7ec 100644
--- a/drivers/bluetooth/btbcm.c
+++ b/drivers/bluetooth/btbcm.c
@@ -232,10 +232,6 @@ int btbcm_setup_patchram(struct hci_dev *hdev)
 	BT_INFO("%s: BCM: chip id %u", hdev->name, skb->data[1]);
 	kfree_skb(skb);
 
-	BT_INFO("%s: %s (%3.3u.%3.3u.%3.3u) build %4.4u", hdev->name,
-		hw_name ? : "BCM", (subver & 0x7000) >> 13,
-		(subver & 0x1f00) >> 8, (subver & 0x00ff), rev & 0x0fff);
-
 	switch ((rev & 0xf000) >> 12) {
 	case 0:
 		for (i = 0; bcm_uart_subver_table[i].name; i++) {
@@ -273,6 +269,10 @@ int btbcm_setup_patchram(struct hci_dev *hdev)
 		return 0;
 	}
 
+	BT_INFO("%s: %s (%3.3u.%3.3u.%3.3u) build %4.4u", hdev->name,
+		hw_name ? : "BCM", (subver & 0x7000) >> 13,
+		(subver & 0x1f00) >> 8, (subver & 0x00ff), rev & 0x0fff);
+
 	err = request_firmware(&fw, fw_name, &hdev->dev);
 	if (err < 0) {
 		BT_INFO("%s: BCM: patch %s not found", hdev->name, fw_name);
-- 
2.1.0

