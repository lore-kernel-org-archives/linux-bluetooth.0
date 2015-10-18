Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: btbcm: Fix firmware version number calculation
Date: Sun, 18 Oct 2015 22:37:56 +0200
Message-Id: <1445200676-123943-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The calculation for the firmware version number is off by one bit.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/btbcm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
index 2fc363a0393d..40ad0e1ccf75 100644
--- a/drivers/bluetooth/btbcm.c
+++ b/drivers/bluetooth/btbcm.c
@@ -323,7 +323,7 @@ int btbcm_initialize(struct hci_dev *hdev, char *fw_name, size_t len)
 	}
 
 	BT_INFO("%s: %s (%3.3u.%3.3u.%3.3u) build %4.4u", hdev->name,
-		hw_name ? : "BCM", (subver & 0x7000) >> 13,
+		hw_name ? : "BCM", (subver & 0xe000) >> 13,
 		(subver & 0x1f00) >> 8, (subver & 0x00ff), rev & 0x0fff);
 
 	return 0;
@@ -353,7 +353,7 @@ int btbcm_finalize(struct hci_dev *hdev)
 	kfree_skb(skb);
 
 	BT_INFO("%s: BCM (%3.3u.%3.3u.%3.3u) build %4.4u", hdev->name,
-		(subver & 0x7000) >> 13, (subver & 0x1f00) >> 8,
+		(subver & 0xe000) >> 13, (subver & 0x1f00) >> 8,
 		(subver & 0x00ff), rev & 0x0fff);
 
 	btbcm_check_bdaddr(hdev);
@@ -461,7 +461,7 @@ int btbcm_setup_patchram(struct hci_dev *hdev)
 	}
 
 	BT_INFO("%s: %s (%3.3u.%3.3u.%3.3u) build %4.4u", hdev->name,
-		hw_name ? : "BCM", (subver & 0x7000) >> 13,
+		hw_name ? : "BCM", (subver & 0xe000) >> 13,
 		(subver & 0x1f00) >> 8, (subver & 0x00ff), rev & 0x0fff);
 
 	err = request_firmware(&fw, fw_name, &hdev->dev);
@@ -490,7 +490,7 @@ int btbcm_setup_patchram(struct hci_dev *hdev)
 	kfree_skb(skb);
 
 	BT_INFO("%s: %s (%3.3u.%3.3u.%3.3u) build %4.4u", hdev->name,
-		hw_name ? : "BCM", (subver & 0x7000) >> 13,
+		hw_name ? : "BCM", (subver & 0xe000) >> 13,
 		(subver & 0x1f00) >> 8, (subver & 0x00ff), rev & 0x0fff);
 
 	/* Read Local Name */
-- 
2.4.3

