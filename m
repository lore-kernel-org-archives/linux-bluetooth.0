Return-Path: <cyrus@holtmann.org>
From: Bruna Moreira <bruna.moreira@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [RFC BlueZ 27/35] emulator: Fix Remote Name Request Cancel command complete
Date: Wed, 12 Jun 2013 08:57:13 -0400
Message-Id: <1371041841-21793-28-git-send-email-bruna.moreira@openbossa.org>
In-Reply-To: <1371041841-21793-1-git-send-email-bruna.moreira@openbossa.org>
References: <1371041841-21793-1-git-send-email-bruna.moreira@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Anderson Lizardo <anderson.lizardo@openbossa.org>

The Command Complete event for this HCI command contains two parameters,
status and bd_addr.
---
 emulator/btdev.c |    8 ++++++--
 monitor/bt.h     |    4 ++++
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index 6d71ce2..2e099b9 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -1093,6 +1093,7 @@ static void default_cmd(struct btdev *btdev, uint16_t opcode,
 	const struct bt_hci_cmd_le_set_adv_enable *lsae;
 	const struct bt_hci_cmd_le_set_scan_enable *lsse;
 	const struct bt_hci_cmd_le_create_conn *lcc;
+	const struct bt_hci_cmd_remote_name_request_cancel *rnrc_cmd;
 	struct bt_hci_rsp_read_default_link_policy rdlp;
 	struct bt_hci_rsp_read_stored_link_key rslk;
 	struct bt_hci_rsp_write_stored_link_key wslk;
@@ -1127,6 +1128,7 @@ static void default_cmd(struct btdev *btdev, uint16_t opcode,
 	struct bt_hci_rsp_le_read_adv_tx_power lratp;
 	struct bt_hci_rsp_le_read_supported_states lrss;
 	struct bt_hci_rsp_le_read_white_list_size lrwls;
+	struct bt_hci_rsp_remote_name_request_cancel rnrc;
 	uint8_t status, page;
 
 	switch (opcode) {
@@ -1180,8 +1182,10 @@ static void default_cmd(struct btdev *btdev, uint16_t opcode,
 	case BT_HCI_CMD_REMOTE_NAME_REQUEST_CANCEL:
 		if (btdev->type == BTDEV_TYPE_LE)
 			goto unsupported;
-		status = BT_HCI_ERR_SUCCESS;
-		cmd_complete(btdev, opcode, &status, sizeof(status));
+		rnrc_cmd = data;
+		rnrc.status = BT_HCI_ERR_SUCCESS;
+		memcpy(rnrc.bdaddr, rnrc_cmd->bdaddr, 6);
+		cmd_complete(btdev, opcode, &rnrc, sizeof(rnrc));
 		break;
 
 	case BT_HCI_CMD_READ_REMOTE_FEATURES:
diff --git a/monitor/bt.h b/monitor/bt.h
index e900525..0f1c1d8 100644
--- a/monitor/bt.h
+++ b/monitor/bt.h
@@ -167,6 +167,10 @@ struct bt_hci_cmd_remote_name_request {
 struct bt_hci_cmd_remote_name_request_cancel {
 	uint8_t  bdaddr[6];
 } __attribute__ ((packed));
+struct bt_hci_rsp_remote_name_request_cancel {
+	uint8_t  status;
+	uint8_t  bdaddr[6];
+} __attribute__ ((packed));
 
 #define BT_HCI_CMD_READ_REMOTE_FEATURES		0x041b
 struct bt_hci_cmd_read_remote_features {
-- 
1.7.9.5

