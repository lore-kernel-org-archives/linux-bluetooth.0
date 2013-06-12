Return-Path: <cyrus@holtmann.org>
From: Bruna Moreira <bruna.moreira@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Eder Ruiz Maria <eder.ruiz@openbossa.org>
Subject: [RFC BlueZ 17/35] emulator: Split default_cmd() for better command and event handler
Date: Wed, 12 Jun 2013 08:57:03 -0400
Message-Id: <1371041841-21793-18-git-send-email-bruna.moreira@openbossa.org>
In-Reply-To: <1371041841-21793-1-git-send-email-bruna.moreira@openbossa.org>
References: <1371041841-21793-1-git-send-email-bruna.moreira@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Eder Ruiz Maria <eder.ruiz@openbossa.org>

Now except for command complete event and command status event, all
other are handled by default_cmd_completion(). With this we can easily
add hooks in some points.
---
 emulator/btdev.c |  131 ++++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 97 insertions(+), 34 deletions(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index 13f99bc..c12103d 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -1031,16 +1031,6 @@ static void le_conn_request(struct btdev *btdev, const uint8_t *bdaddr)
 static void default_cmd(struct btdev *btdev, uint16_t opcode,
 						const void *data, uint8_t len)
 {
-	const struct bt_hci_cmd_create_conn *cc;
-	const struct bt_hci_cmd_disconnect *dc;
-	const struct bt_hci_cmd_create_conn_cancel *ccc;
-	const struct bt_hci_cmd_accept_conn_request *acr;
-	const struct bt_hci_cmd_reject_conn_request *rcr;
-	const struct bt_hci_cmd_remote_name_request *rnr;
-	const struct bt_hci_cmd_remote_name_request_cancel *rnrc;
-	const struct bt_hci_cmd_read_remote_features *rrf;
-	const struct bt_hci_cmd_read_remote_ext_features *rref;
-	const struct bt_hci_cmd_read_remote_version *rrv;
 	const struct bt_hci_cmd_write_default_link_policy *wdlp;
 	const struct bt_hci_cmd_set_event_mask *sem;
 	const struct bt_hci_cmd_set_event_filter *sef;
@@ -1105,7 +1095,6 @@ static void default_cmd(struct btdev *btdev, uint16_t opcode,
 		if (btdev->type == BTDEV_TYPE_LE)
 			goto unsupported;
 		cmd_status(btdev, BT_HCI_ERR_SUCCESS, opcode);
-		inquiry_complete(btdev, BT_HCI_ERR_SUCCESS);
 		break;
 
 	case BT_HCI_CMD_INQUIRY_CANCEL:
@@ -1118,80 +1107,58 @@ static void default_cmd(struct btdev *btdev, uint16_t opcode,
 	case BT_HCI_CMD_CREATE_CONN:
 		if (btdev->type == BTDEV_TYPE_LE)
 			goto unsupported;
-		cc = data;
 		cmd_status(btdev, BT_HCI_ERR_SUCCESS, opcode);
-		conn_request(btdev, cc->bdaddr);
 		break;
 
 	case BT_HCI_CMD_DISCONNECT:
-		dc = data;
 		cmd_status(btdev, BT_HCI_ERR_SUCCESS, opcode);
-		disconnect_complete(btdev, le16_to_cpu(dc->handle), dc->reason);
 		break;
 
 	case BT_HCI_CMD_CREATE_CONN_CANCEL:
 		if (btdev->type == BTDEV_TYPE_LE)
 			goto unsupported;
-		ccc = data;
 		cmd_status(btdev, BT_HCI_ERR_SUCCESS, opcode);
-		conn_complete(btdev, ccc->bdaddr, BT_HCI_ERR_UNKNOWN_CONN_ID);
 		break;
 
 	case BT_HCI_CMD_ACCEPT_CONN_REQUEST:
 		if (btdev->type == BTDEV_TYPE_LE)
 			goto unsupported;
-		acr = data;
 		cmd_status(btdev, BT_HCI_ERR_SUCCESS, opcode);
-		conn_complete(btdev, acr->bdaddr, BT_HCI_ERR_SUCCESS);
 		break;
 
 	case BT_HCI_CMD_REJECT_CONN_REQUEST:
 		if (btdev->type == BTDEV_TYPE_LE)
 			goto unsupported;
-		rcr = data;
 		cmd_status(btdev, BT_HCI_ERR_SUCCESS, opcode);
-		conn_complete(btdev, rcr->bdaddr, BT_HCI_ERR_UNKNOWN_CONN_ID);
 		break;
 
 	case BT_HCI_CMD_REMOTE_NAME_REQUEST:
 		if (btdev->type == BTDEV_TYPE_LE)
 			goto unsupported;
-		rnr = data;
 		cmd_status(btdev, BT_HCI_ERR_SUCCESS, opcode);
-		name_request_complete(btdev, rnr->bdaddr, BT_HCI_ERR_SUCCESS);
 		break;
 
 	case BT_HCI_CMD_REMOTE_NAME_REQUEST_CANCEL:
 		if (btdev->type == BTDEV_TYPE_LE)
 			goto unsupported;
-		rnrc = data;
 		status = BT_HCI_ERR_SUCCESS;
 		cmd_complete(btdev, opcode, &status, sizeof(status));
-		name_request_complete(btdev, rnrc->bdaddr,
-						BT_HCI_ERR_UNKNOWN_CONN_ID);
 		break;
 
 	case BT_HCI_CMD_READ_REMOTE_FEATURES:
 		if (btdev->type == BTDEV_TYPE_LE)
 			goto unsupported;
-		rrf = data;
 		cmd_status(btdev, BT_HCI_ERR_SUCCESS, opcode);
-		remote_features_complete(btdev, le16_to_cpu(rrf->handle));
 		break;
 
 	case BT_HCI_CMD_READ_REMOTE_EXT_FEATURES:
 		if (btdev->type == BTDEV_TYPE_LE)
 			goto unsupported;
-		rref = data;
 		cmd_status(btdev, BT_HCI_ERR_SUCCESS, opcode);
-		remote_ext_features_complete(btdev, le16_to_cpu(rref->handle),
-								rref->page);
 		break;
 
 	case BT_HCI_CMD_READ_REMOTE_VERSION:
-		rrv = data;
 		cmd_status(btdev, BT_HCI_ERR_SUCCESS, opcode);
-		remote_version_complete(btdev, le16_to_cpu(rrv->handle));
 		break;
 
 	case BT_HCI_CMD_READ_DEFAULT_LINK_POLICY:
@@ -1772,6 +1739,97 @@ unsupported:
 	cmd_status(btdev, BT_HCI_ERR_UNKNOWN_COMMAND, opcode);
 }
 
+static void default_cmd_completion(struct btdev *btdev, uint16_t opcode,
+						const void *data, uint8_t len)
+{
+	const struct bt_hci_cmd_create_conn *cc;
+	const struct bt_hci_cmd_disconnect *dc;
+	const struct bt_hci_cmd_create_conn_cancel *ccc;
+	const struct bt_hci_cmd_accept_conn_request *acr;
+	const struct bt_hci_cmd_reject_conn_request *rcr;
+	const struct bt_hci_cmd_remote_name_request *rnr;
+	const struct bt_hci_cmd_remote_name_request_cancel *rnrc;
+	const struct bt_hci_cmd_read_remote_features *rrf;
+	const struct bt_hci_cmd_read_remote_ext_features *rref;
+	const struct bt_hci_cmd_read_remote_version *rrv;
+
+	switch (opcode) {
+	case BT_HCI_CMD_INQUIRY:
+		if (btdev->type == BTDEV_TYPE_LE)
+			return;
+		inquiry_complete(btdev, BT_HCI_ERR_SUCCESS);
+		break;
+
+	case BT_HCI_CMD_CREATE_CONN:
+		if (btdev->type == BTDEV_TYPE_LE)
+			return;
+		cc = data;
+		conn_request(btdev, cc->bdaddr);
+		break;
+
+	case BT_HCI_CMD_DISCONNECT:
+		dc = data;
+		disconnect_complete(btdev, le16_to_cpu(dc->handle), dc->reason);
+		break;
+
+	case BT_HCI_CMD_CREATE_CONN_CANCEL:
+		if (btdev->type == BTDEV_TYPE_LE)
+			return;
+		ccc = data;
+		conn_complete(btdev, ccc->bdaddr, BT_HCI_ERR_UNKNOWN_CONN_ID);
+		break;
+
+	case BT_HCI_CMD_ACCEPT_CONN_REQUEST:
+		if (btdev->type == BTDEV_TYPE_LE)
+			return;
+		acr = data;
+		conn_complete(btdev, acr->bdaddr, BT_HCI_ERR_SUCCESS);
+		break;
+
+	case BT_HCI_CMD_REJECT_CONN_REQUEST:
+		if (btdev->type == BTDEV_TYPE_LE)
+			return;
+		rcr = data;
+		conn_complete(btdev, rcr->bdaddr, BT_HCI_ERR_UNKNOWN_CONN_ID);
+		break;
+
+	case BT_HCI_CMD_REMOTE_NAME_REQUEST:
+		if (btdev->type == BTDEV_TYPE_LE)
+			return;
+		rnr = data;
+		name_request_complete(btdev, rnr->bdaddr, BT_HCI_ERR_SUCCESS);
+		break;
+
+	case BT_HCI_CMD_REMOTE_NAME_REQUEST_CANCEL:
+		if (btdev->type == BTDEV_TYPE_LE)
+			return;
+		rnrc = data;
+		name_request_complete(btdev, rnrc->bdaddr,
+						BT_HCI_ERR_UNKNOWN_CONN_ID);
+		break;
+
+	case BT_HCI_CMD_READ_REMOTE_FEATURES:
+		if (btdev->type == BTDEV_TYPE_LE)
+			return;
+		rrf = data;
+		remote_features_complete(btdev, le16_to_cpu(rrf->handle));
+		break;
+
+	case BT_HCI_CMD_READ_REMOTE_EXT_FEATURES:
+		if (btdev->type == BTDEV_TYPE_LE)
+			return;
+		rref = data;
+		remote_ext_features_complete(btdev, le16_to_cpu(rref->handle),
+								rref->page);
+		break;
+
+	case BT_HCI_CMD_READ_REMOTE_VERSION:
+		rrv = data;
+		remote_version_complete(btdev, le16_to_cpu(rrv->handle));
+		break;
+	}
+}
+
 struct btdev_callback {
 	void (*function)(btdev_callback callback, uint8_t response,
 				uint8_t status, const void *data, uint8_t len);
@@ -1796,6 +1854,8 @@ static void handler_callback(btdev_callback callback, uint8_t response,
 	case BTDEV_RESPONSE_DEFAULT:
 		default_cmd(btdev, callback->opcode,
 					callback->data, callback->len);
+		default_cmd_completion(btdev, callback->opcode,
+					callback->data, callback->len);
 		break;
 	case BTDEV_RESPONSE_COMMAND_STATUS:
 		cmd_status(btdev, status, callback->opcode);
@@ -1828,9 +1888,12 @@ static void process_cmd(struct btdev *btdev, const void *data, uint16_t len)
 		btdev->command_handler(callback.opcode,
 					callback.data, callback.len,
 					&callback, btdev->command_data);
-	else
+	else {
 		default_cmd(btdev, callback.opcode,
 					callback.data, callback.len);
+		default_cmd_completion(btdev, callback.opcode,
+					callback.data, callback.len);
+	}
 }
 
 void btdev_receive_h4(struct btdev *btdev, const void *data, uint16_t len)
-- 
1.7.9.5

