Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 1/8] btdev: Add LE Encrypt command support to emulator
Date: Fri, 15 May 2015 16:46:19 +0300
Message-Id: <1431697586-20611-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Add basic crypto support to btdev using Linux crypto infrastructure.
---
 emulator/btdev.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index d9a0c5d..18edac6 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -39,6 +39,7 @@
 
 #include "src/shared/util.h"
 #include "src/shared/timeout.h"
+#include "src/shared/crypto.h"
 #include "monitor/bt.h"
 #include "btdev.h"
 
@@ -79,6 +80,8 @@ struct btdev {
 
 	struct hook *hook_list[MAX_HOOK_ENTRIES];
 
+	struct bt_crypto *crypto;
+
         uint16_t manufacturer;
         uint8_t  version;
 	uint16_t revision;
@@ -418,6 +421,7 @@ static void set_le_commands(struct btdev *btdev)
 	btdev->commands[26] |= 0x04;	/* LE Set Scan Parameters */
 	btdev->commands[26] |= 0x08;	/* LE Set Scan Enable */
 	btdev->commands[26] |= 0x40;	/* LE Read White List Size */
+	btdev->commands[27] |= 0x40;	/* LE Encrypt */
 	btdev->commands[27] |= 0x80;	/* LE Rand */
 	btdev->commands[28] |= 0x08;	/* LE Read Supported States */
 	btdev->commands[28] |= 0x10;	/* LE Receiver Test */
@@ -555,6 +559,15 @@ struct btdev *btdev_create(enum btdev_type type, uint16_t id)
 		return NULL;
 
 	memset(btdev, 0, sizeof(*btdev));
+
+	if (type == BTDEV_TYPE_BREDRLE || type == BTDEV_TYPE_LE) {
+		btdev->crypto = bt_crypto_new();
+		if (!btdev->crypto) {
+			free(btdev);
+			return NULL;
+		}
+	}
+
 	btdev->type = type;
 
 	btdev->manufacturer = 63;
@@ -603,6 +616,7 @@ struct btdev *btdev_create(enum btdev_type type, uint16_t id)
 
 	index = add_btdev(btdev);
 	if (index < 0) {
+		bt_crypto_unref(btdev->crypto);
 		free(btdev);
 		return NULL;
 	}
@@ -620,6 +634,7 @@ void btdev_destroy(struct btdev *btdev)
 	if (btdev->inquiry_id > 0)
 		timeout_remove(btdev->inquiry_id);
 
+	bt_crypto_unref(btdev->crypto);
 	del_btdev(btdev);
 
 	free(btdev);
@@ -1914,6 +1929,7 @@ static void default_cmd(struct btdev *btdev, uint16_t opcode,
 	const struct bt_hci_cmd_le_set_scan_enable *lsse;
 	const struct bt_hci_cmd_le_start_encrypt *lse;
 	const struct bt_hci_cmd_le_ltk_req_reply *llrr;
+	const struct bt_hci_cmd_le_encrypt *lenc_cmd;
 	const struct bt_hci_cmd_read_local_amp_assoc *rlaa_cmd;
 	const struct bt_hci_cmd_read_rssi *rrssi;
 	const struct bt_hci_cmd_read_tx_power *rtxp;
@@ -1960,6 +1976,7 @@ static void default_cmd(struct btdev *btdev, uint16_t opcode,
 	struct bt_hci_rsp_le_read_adv_tx_power lratp;
 	struct bt_hci_rsp_le_read_supported_states lrss;
 	struct bt_hci_rsp_le_read_white_list_size lrwls;
+	struct bt_hci_rsp_le_encrypt lenc;
 	struct bt_hci_rsp_le_rand lr;
 	struct bt_hci_rsp_le_test_end lte;
 	struct bt_hci_rsp_remote_name_request_cancel rnrc_rsp;
@@ -2864,6 +2881,20 @@ static void default_cmd(struct btdev *btdev, uint16_t opcode,
 		cmd_complete(btdev, opcode, &status, sizeof(status));
 		break;
 
+	case BT_HCI_CMD_LE_ENCRYPT:
+		if (btdev->type == BTDEV_TYPE_BREDR)
+			goto unsupported;
+		lenc_cmd = data;
+		if (!bt_crypto_e(btdev->crypto, lenc_cmd->key,
+				 lenc_cmd->plaintext, lenc.data)) {
+			cmd_status(btdev, BT_HCI_ERR_COMMAND_DISALLOWED,
+				   opcode);
+			break;
+		}
+		lenc.status = BT_HCI_ERR_SUCCESS;
+		cmd_complete(btdev, opcode, &lenc, sizeof(lenc));
+		break;
+
 	case BT_HCI_CMD_LE_READ_SUPPORTED_STATES:
 		if (btdev->type == BTDEV_TYPE_BREDR)
 			goto unsupported;
-- 
2.1.4

