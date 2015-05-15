Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 5/8] btdev: Add LE Read Local Public Key cmd to emulator
Date: Fri, 15 May 2015 16:46:23 +0300
Message-Id: <1431697586-20611-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1431697586-20611-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1431697586-20611-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Support LE Read Local P-256 Public Key Command introduced in Bluetooth
Spec 4.2. The Controller shall generate a new P-256 public/private key
pair upon receipt of this command so private key is saved to btdev.
---
 emulator/btdev.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index f4108b3..354cf04 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -40,6 +40,7 @@
 #include "src/shared/util.h"
 #include "src/shared/timeout.h"
 #include "src/shared/crypto.h"
+#include "src/shared/ecc.h"
 #include "monitor/bt.h"
 #include "btdev.h"
 
@@ -138,6 +139,8 @@ struct btdev {
 	uint8_t  le_adv_enable;
 	uint8_t  le_ltk[16];
 
+	uint8_t le_local_sk256[32];
+
 	uint16_t sync_train_interval;
 	uint32_t sync_train_timeout;
 	uint8_t  sync_train_service_data;
@@ -773,6 +776,23 @@ static void cmd_status(struct btdev *btdev, uint8_t status, uint16_t opcode)
 	send_cmd(btdev, BT_HCI_EVT_CMD_STATUS, opcode, &iov, 1);
 }
 
+static void le_meta_event(struct btdev *btdev, uint8_t event,
+						void *data, uint8_t len)
+{
+	void *pkt_data;
+
+	pkt_data = alloca(1 + len);
+	if (!pkt_data)
+		return;
+
+	((uint8_t *) pkt_data)[0] = event;
+
+	if (len > 0)
+		memcpy(pkt_data + 1, data, len);
+
+	send_event(btdev, BT_HCI_EVT_LE_META_EVENT, pkt_data, 1 + len);
+}
+
 static void num_completed_packets(struct btdev *btdev)
 {
 	if (btdev->conn) {
@@ -1988,6 +2008,7 @@ static void default_cmd(struct btdev *btdev, uint16_t opcode,
 	struct bt_hci_rsp_user_confirm_request_neg_reply ucrnr_rsp;
 	struct bt_hci_rsp_read_rssi rrssi_rsp;
 	struct bt_hci_rsp_read_tx_power rtxp_rsp;
+	struct bt_hci_evt_le_read_local_pk256_complete pk_evt;
 	uint8_t status, page;
 
 	switch (opcode) {
@@ -2908,6 +2929,21 @@ static void default_cmd(struct btdev *btdev, uint16_t opcode,
 		cmd_complete(btdev, opcode, &lr, sizeof(lr));
 		break;
 
+	case BT_HCI_CMD_LE_READ_LOCAL_PK256:
+		if (btdev->type == BTDEV_TYPE_BREDR)
+			goto unsupported;
+		if (!ecc_make_key(pk_evt.local_pk256, btdev->le_local_sk256)) {
+			cmd_status(btdev, BT_HCI_ERR_COMMAND_DISALLOWED,
+									opcode);
+			break;
+		}
+		cmd_status(btdev, BT_HCI_ERR_SUCCESS,
+						BT_HCI_CMD_LE_READ_LOCAL_PK256);
+		pk_evt.status = BT_HCI_ERR_SUCCESS;
+		le_meta_event(btdev, BT_HCI_EVT_LE_READ_LOCAL_PK256_COMPLETE,
+						&pk_evt, sizeof(pk_evt));
+		break;
+
 	case BT_HCI_CMD_LE_READ_SUPPORTED_STATES:
 		if (btdev->type == BTDEV_TYPE_BREDR)
 			goto unsupported;
-- 
2.1.4

