Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ] emulator: Fix Remote Name Request Cancel command complete
Date: Wed,  5 Jun 2013 17:04:53 -0400
Message-Id: <1370466293-14471-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The Command Complete event for this HCI command contains two parameters,
status and bd_addr.
---
 emulator/btdev.c |    6 ++++--
 monitor/bt.h     |    4 ++++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index 6e00cc6..cc209db 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -874,6 +874,7 @@ static void default_cmd(struct btdev *btdev, uint16_t opcode,
 	struct bt_hci_rsp_le_read_adv_tx_power lratp;
 	struct bt_hci_rsp_le_read_supported_states lrss;
 	struct bt_hci_rsp_le_read_white_list_size lrwls;
+	struct bt_hci_rsp_remote_name_request_cancel rnrc_rsp;
 	uint8_t status, page;
 
 	switch (opcode) {
@@ -941,8 +942,9 @@ static void default_cmd(struct btdev *btdev, uint16_t opcode,
 		if (btdev->type == BTDEV_TYPE_LE)
 			goto unsupported;
 		rnrc = data;
-		status = BT_HCI_ERR_SUCCESS;
-		cmd_complete(btdev, opcode, &status, sizeof(status));
+		rnrc_rsp.status = BT_HCI_ERR_SUCCESS;
+		memcpy(rnrc_rsp.bdaddr, rnrc->bdaddr, 6);
+		cmd_complete(btdev, opcode, &rnrc_rsp, sizeof(rnrc_rsp));
 		name_request_complete(btdev, rnrc->bdaddr,
 						BT_HCI_ERR_UNKNOWN_CONN_ID);
 		break;
diff --git a/monitor/bt.h b/monitor/bt.h
index 7bd439f..996668f 100644
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

