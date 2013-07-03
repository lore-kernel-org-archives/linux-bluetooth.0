Return-Path: <cyrus@holtmann.org>
From: Jefferson Delfes <jefferson.delfes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Jefferson Delfes <jefferson.delfes@openbossa.org>
Subject: [PATCH BlueZ 2/6] emulator: Implement basic LE set adv enable command
Date: Wed,  3 Jul 2013 16:54:52 -0400
Message-Id: <1372884896-11419-3-git-send-email-jefferson.delfes@openbossa.org>
In-Reply-To: <1372884896-11419-1-git-send-email-jefferson.delfes@openbossa.org>
References: <1372884896-11419-1-git-send-email-jefferson.delfes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Store advertising state of virtual controller in btdev struct.
---
 emulator/btdev.c | 15 +++++++++++++++
 monitor/bt.h     |  1 +
 2 files changed, 16 insertions(+)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index 73174a5..060347d 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -91,6 +91,7 @@ struct btdev {
 	uint8_t  le_event_mask[8];
 	uint8_t  le_adv_data[31];
 	uint8_t  le_adv_data_len;
+	uint8_t  le_adv_enable;
 
 	uint16_t sync_train_interval;
 	uint32_t sync_train_timeout;
@@ -841,6 +842,7 @@ static void default_cmd(struct btdev *btdev, uint16_t opcode,
 	const struct bt_hci_cmd_set_event_mask_page2 *semp2;
 	const struct bt_hci_cmd_le_set_event_mask *lsem;
 	const struct bt_hci_cmd_le_set_adv_data *lsad;
+	const struct bt_hci_cmd_le_set_adv_enable *lsae;
 	struct bt_hci_rsp_read_default_link_policy rdlp;
 	struct bt_hci_rsp_read_stored_link_key rslk;
 	struct bt_hci_rsp_write_stored_link_key wslk;
@@ -1454,6 +1456,19 @@ static void default_cmd(struct btdev *btdev, uint16_t opcode,
 		cmd_complete(btdev, opcode, &lratp, sizeof(lratp));
 		break;
 
+	case BT_HCI_CMD_LE_SET_ADV_ENABLE:
+		if (btdev->type == BTDEV_TYPE_BREDR)
+			goto unsupported;
+		lsae = data;
+		if (btdev->le_adv_enable == lsae->enable)
+			status = BT_HCI_ERR_COMMAND_DISALLOWED;
+		else {
+			btdev->le_adv_enable = lsae->enable;
+			status = BT_HCI_ERR_SUCCESS;
+		}
+		cmd_complete(btdev, opcode, &status, sizeof(status));
+		break;
+
 	case BT_HCI_CMD_LE_SET_SCAN_PARAMETERS:
 		if (btdev->type == BTDEV_TYPE_BREDR)
 			goto unsupported;
diff --git a/monitor/bt.h b/monitor/bt.h
index f8759c7..da62a3d 100644
--- a/monitor/bt.h
+++ b/monitor/bt.h
@@ -1479,6 +1479,7 @@ struct bt_hci_evt_le_long_term_key_request {
 #define BT_HCI_ERR_UNKNOWN_CONN_ID		0x02
 #define BT_HCI_ERR_HARDWARE_FAILURE		0x03
 #define BT_HCI_ERR_PAGE_TIMEOUT			0x04
+#define BT_HCI_ERR_COMMAND_DISALLOWED		0x0c
 #define BT_HCI_ERR_INVALID_PARAMETERS		0x12
 
 struct bt_l2cap_hdr {
-- 
1.8.3.2

