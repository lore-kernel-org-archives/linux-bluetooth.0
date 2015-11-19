Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/3] Bluetooth: Simplify if statements in tlv_data_is_valid function
Date: Thu, 19 Nov 2015 16:16:42 +0100
Message-Id: <1447946203-17620-2-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The if statements for checking the flags parameter could be written a
bit easier to read. This changes this. No functional behavior has been
changed.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/mgmt.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 2c6533a3f937..05370e76feb0 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -6700,17 +6700,19 @@ static bool tlv_data_is_valid(struct hci_dev *hdev, u32 adv_flags, u8 *data,
 	int i, cur_len;
 	bool flags_managed = false;
 	bool tx_power_managed = false;
-	u32 flags_params = MGMT_ADV_FLAG_DISCOV | MGMT_ADV_FLAG_LIMITED_DISCOV |
-			   MGMT_ADV_FLAG_MANAGED_FLAGS;
 
-	if (is_adv_data && (adv_flags & flags_params)) {
-		flags_managed = true;
-		max_len -= 3;
-	}
+	if (is_adv_data) {
+		if (adv_flags & (MGMT_ADV_FLAG_DISCOV |
+				 MGMT_ADV_FLAG_LIMITED_DISCOV |
+				 MGMT_ADV_FLAG_MANAGED_FLAGS)) {
+			flags_managed = true;
+			max_len -= 3;
+		}
 
-	if (is_adv_data && (adv_flags & MGMT_ADV_FLAG_TX_POWER)) {
-		tx_power_managed = true;
-		max_len -= 3;
+		if (adv_flags & MGMT_ADV_FLAG_TX_POWER) {
+			tx_power_managed = true;
+			max_len -= 3;
+		}
 	}
 
 	if (len > max_len)
-- 
2.5.0

