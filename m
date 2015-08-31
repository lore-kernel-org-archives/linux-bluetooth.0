Return-Path: <cyrus@holtmann.org>
From: Mariusz Skamra <mariusz.skamra@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: johan.hedberg@gmail.com, Mariusz Skamra <mariusz.skamra@tieto.com>
Subject: [PATCH] emulator: Improve le set scan enable command handler
Date: Mon, 31 Aug 2015 12:09:05 +0200
Message-Id: <1441015750-22650-1-git-send-email-mariusz.skamra@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

le_set_scan_enable_complete should be called as post hook action.
Moreover, depending on Filter Duplicates parameter, scan results
can be duplicated while scanning is enabled.
---
 emulator/btdev.c | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index e4c85f8..bab695b 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -134,6 +134,7 @@ struct btdev {
 	uint8_t  le_scan_data[31];
 	uint8_t  le_scan_data_len;
 	uint8_t  le_scan_enable;
+	unsigned int le_adv_results_timeout;
 	uint8_t  le_scan_type;
 	uint8_t  le_scan_own_addr_type;
 	uint8_t  le_filter_dup;
@@ -1801,8 +1802,9 @@ static void le_set_adv_enable_complete(struct btdev *btdev)
 	}
 }
 
-static void le_set_scan_enable_complete(struct btdev *btdev)
+static bool le_set_scan_enable_complete(void *user_data)
 {
+	struct btdev *btdev = user_data;
 	int i;
 
 	for (i = 0; i < MAX_BTDEV_ENTRIES; i++) {
@@ -1828,6 +1830,11 @@ static void le_set_scan_enable_complete(struct btdev *btdev)
 					btdev_list[i]->le_adv_type == 0x02)
 			le_send_adv_report(btdev, btdev_list[i], 0x04);
 	}
+
+	if (!btdev->le_filter_dup)
+		return true;
+
+	return false;
 }
 
 static void le_read_remote_features_complete(struct btdev *btdev)
@@ -2939,8 +2946,6 @@ static void default_cmd(struct btdev *btdev, uint16_t opcode,
 			status = BT_HCI_ERR_SUCCESS;
 		}
 		cmd_complete(btdev, opcode, &status, sizeof(status));
-		if (status == BT_HCI_ERR_SUCCESS && btdev->le_scan_enable)
-			le_set_scan_enable_complete(btdev);
 		break;
 
 	case BT_HCI_CMD_LE_CREATE_CONN:
@@ -3170,6 +3175,7 @@ static void default_cmd_completion(struct btdev *btdev, uint16_t opcode,
 	const struct bt_hci_cmd_read_clock_offset *rco;
 	const struct bt_hci_cmd_le_create_conn *lecc;
 	const struct bt_hci_cmd_le_conn_update *lecu;
+	const struct bt_hci_cmd_le_set_scan_enable *lsse;
 
 	switch (opcode) {
 	case BT_HCI_CMD_INQUIRY:
@@ -3329,6 +3335,20 @@ static void default_cmd_completion(struct btdev *btdev, uint16_t opcode,
 				le16_to_cpu(lecu->min_length),
 				le16_to_cpu(lecu->max_length));
 		break;
+		break;
+	case BT_HCI_CMD_LE_SET_SCAN_ENABLE:
+		if (btdev->type == BTDEV_TYPE_BREDR)
+			return;
+		lsse = data;
+		if (btdev->le_scan_enable && lsse->enable)
+			btdev->le_adv_results_timeout = timeout_add(1000,
+				le_set_scan_enable_complete, btdev, NULL);
+
+		if (!btdev->le_scan_enable && !lsse->enable &&
+						btdev->le_adv_results_timeout) {
+			timeout_remove(btdev->le_adv_results_timeout);
+		}
+
 	}
 }
 
-- 
2.4.3

