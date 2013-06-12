Return-Path: <cyrus@holtmann.org>
From: Bruna Moreira <bruna.moreira@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Jefferson Delfes <jefferson.delfes@openbossa.org>
Subject: [RFC BlueZ 03/35] emulator: Implement basic LE set adv enable command
Date: Wed, 12 Jun 2013 08:56:49 -0400
Message-Id: <1371041841-21793-4-git-send-email-bruna.moreira@openbossa.org>
In-Reply-To: <1371041841-21793-1-git-send-email-bruna.moreira@openbossa.org>
References: <1371041841-21793-1-git-send-email-bruna.moreira@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Jefferson Delfes <jefferson.delfes@openbossa.org>

Store advertising state of virtual controller in btdev struct.
---
 emulator/btdev.c |   15 +++++++++++++++
 monitor/bt.h     |    1 +
 2 files changed, 16 insertions(+)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index 1555e2f..316d816 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -89,6 +89,7 @@ struct btdev {
 	uint8_t  le_event_mask[8];
 	uint8_t  le_adv_data[31];
 	uint8_t  le_adv_data_len;
+	uint8_t  le_adv_enable;
 
 	uint16_t sync_train_interval;
 	uint32_t sync_train_timeout;
@@ -906,6 +907,7 @@ static void default_cmd(struct btdev *btdev, uint16_t opcode,
 	const struct bt_hci_cmd_set_event_mask_page2 *semp2;
 	const struct bt_hci_cmd_le_set_event_mask *lsem;
 	const struct bt_hci_cmd_le_set_adv_data *lsad;
+	const struct bt_hci_cmd_le_set_adv_enable *lsae;
 	struct bt_hci_rsp_read_default_link_policy rdlp;
 	struct bt_hci_rsp_read_stored_link_key rslk;
 	struct bt_hci_rsp_write_stored_link_key wslk;
@@ -1517,6 +1519,19 @@ static void default_cmd(struct btdev *btdev, uint16_t opcode,
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
index 220cb0c..9f237ee 100644
--- a/monitor/bt.h
+++ b/monitor/bt.h
@@ -1475,6 +1475,7 @@ struct bt_hci_evt_le_long_term_key_request {
 #define BT_HCI_ERR_UNKNOWN_CONN_ID		0x02
 #define BT_HCI_ERR_HARDWARE_FAILURE		0x03
 #define BT_HCI_ERR_PAGE_TIMEOUT			0x04
+#define BT_HCI_ERR_COMMAND_DISALLOWED		0x0c
 #define BT_HCI_ERR_INVALID_PARAMETERS		0x12
 
 struct bt_l2cap_hdr {
-- 
1.7.9.5

