Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix location of TX power field in LE advertising data
Date: Fri,  3 Apr 2015 13:23:12 -0700
Message-Id: <1428092592-8588-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The TX power field in the LE advertising data should be placed last
since it needs to be possible to enable kernel controlled TX power,
but still allow for userspace provided flags field.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/mgmt.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 20a7765680df..845dfcc43a20 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1043,6 +1043,14 @@ static u8 create_instance_adv_data(struct hci_dev *hdev, u8 instance, u8 *ptr)
 		}
 	}
 
+	if (instance) {
+		memcpy(ptr, hdev->adv_instance.adv_data,
+		       hdev->adv_instance.adv_data_len);
+
+		ad_len += hdev->adv_instance.adv_data_len;
+		ptr += hdev->adv_instance.adv_data_len;
+	}
+
 	/* Provide Tx Power only if we can provide a valid value for it */
 	if (hdev->adv_tx_power != HCI_TX_POWER_INVALID &&
 	    (instance_flags & MGMT_ADV_FLAG_TX_POWER)) {
@@ -1054,12 +1062,6 @@ static u8 create_instance_adv_data(struct hci_dev *hdev, u8 instance, u8 *ptr)
 		ptr += 3;
 	}
 
-	if (instance) {
-		memcpy(ptr, hdev->adv_instance.adv_data,
-		       hdev->adv_instance.adv_data_len);
-		ad_len += hdev->adv_instance.adv_data_len;
-	}
-
 	return ad_len;
 }
 
-- 
2.1.0

