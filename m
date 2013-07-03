Return-Path: <cyrus@holtmann.org>
From: Jefferson Delfes <jefferson.delfes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Jefferson Delfes <jefferson.delfes@openbossa.org>
Subject: [PATCH BlueZ 3/6] emulator: Store LE scan state of virtual controller
Date: Wed,  3 Jul 2013 16:54:53 -0400
Message-Id: <1372884896-11419-4-git-send-email-jefferson.delfes@openbossa.org>
In-Reply-To: <1372884896-11419-1-git-send-email-jefferson.delfes@openbossa.org>
References: <1372884896-11419-1-git-send-email-jefferson.delfes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The LE command set scan enable can change the scan state of virtual
controller.
---
 emulator/btdev.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index 060347d..925eaf7 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -91,6 +91,8 @@ struct btdev {
 	uint8_t  le_event_mask[8];
 	uint8_t  le_adv_data[31];
 	uint8_t  le_adv_data_len;
+	uint8_t  le_scan_enable;
+	uint8_t  le_filter_dup;
 	uint8_t  le_adv_enable;
 
 	uint16_t sync_train_interval;
@@ -843,6 +845,7 @@ static void default_cmd(struct btdev *btdev, uint16_t opcode,
 	const struct bt_hci_cmd_le_set_event_mask *lsem;
 	const struct bt_hci_cmd_le_set_adv_data *lsad;
 	const struct bt_hci_cmd_le_set_adv_enable *lsae;
+	const struct bt_hci_cmd_le_set_scan_enable *lsse;
 	struct bt_hci_rsp_read_default_link_policy rdlp;
 	struct bt_hci_rsp_read_stored_link_key rslk;
 	struct bt_hci_rsp_write_stored_link_key wslk;
@@ -1479,7 +1482,14 @@ static void default_cmd(struct btdev *btdev, uint16_t opcode,
 	case BT_HCI_CMD_LE_SET_SCAN_ENABLE:
 		if (btdev->type == BTDEV_TYPE_BREDR)
 			goto unsupported;
-		status = BT_HCI_ERR_SUCCESS;
+		lsse = data;
+		if (btdev->le_scan_enable == lsse->enable)
+			status = BT_HCI_ERR_COMMAND_DISALLOWED;
+		else {
+			btdev->le_scan_enable = lsse->enable;
+			btdev->le_filter_dup = lsse->filter_dup;
+			status = BT_HCI_ERR_SUCCESS;
+		}
 		cmd_complete(btdev, opcode, &status, sizeof(status));
 		break;
 
-- 
1.8.3.2

