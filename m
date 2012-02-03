Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH v2 1/7] Bluetooth: Fix doing some useless casts when receiving MGMT commands
Date: Thu,  2 Feb 2012 21:07:59 -0300
Message-Id: <1328227685-27245-2-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1328227685-27245-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1328227685-27245-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Every command handler of mgmt does a cast to the command structure
so it can properly interpreted. So we can avoid that cast if we
make those functions receive a void * directly.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
---
 net/bluetooth/mgmt.c |  210 +++++++++++++++++++++-----------------------------
 1 files changed, 88 insertions(+), 122 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 00ab083..f8720de 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -611,15 +611,13 @@ static int send_settings_rsp(struct sock *sk, u16 opcode, struct hci_dev *hdev)
 	return cmd_complete(sk, hdev->id, opcode, &settings, sizeof(settings));
 }
 
-static int set_powered(struct sock *sk, u16 index, unsigned char *data, u16 len)
+static int set_powered(struct sock *sk, u16 index, void *cp_data, u16 len)
 {
-	struct mgmt_mode *cp;
+	struct mgmt_mode *cp = cp_data;
 	struct hci_dev *hdev;
 	struct pending_cmd *cmd;
 	int err, up;
 
-	cp = (void *) data;
-
 	BT_DBG("request for hci%u", index);
 
 	if (len != sizeof(*cp))
@@ -645,7 +643,7 @@ static int set_powered(struct sock *sk, u16 index, unsigned char *data, u16 len)
 		goto failed;
 	}
 
-	cmd = mgmt_pending_add(sk, MGMT_OP_SET_POWERED, hdev, data, len);
+	cmd = mgmt_pending_add(sk, MGMT_OP_SET_POWERED, hdev, cp_data, len);
 	if (!cmd) {
 		err = -ENOMEM;
 		goto failed;
@@ -664,17 +662,14 @@ failed:
 	return err;
 }
 
-static int set_discoverable(struct sock *sk, u16 index, unsigned char *data,
-									u16 len)
+static int set_discoverable(struct sock *sk, u16 index, void *cp_data, u16 len)
 {
-	struct mgmt_cp_set_discoverable *cp;
+	struct mgmt_cp_set_discoverable *cp = cp_data;
 	struct hci_dev *hdev;
 	struct pending_cmd *cmd;
 	u8 scan;
 	int err;
 
-	cp = (void *) data;
-
 	BT_DBG("request for hci%u", index);
 
 	if (len != sizeof(*cp))
@@ -707,7 +702,7 @@ static int set_discoverable(struct sock *sk, u16 index, unsigned char *data,
 		goto failed;
 	}
 
-	cmd = mgmt_pending_add(sk, MGMT_OP_SET_DISCOVERABLE, hdev, data, len);
+	cmd = mgmt_pending_add(sk, MGMT_OP_SET_DISCOVERABLE, hdev, cp_data, len);
 	if (!cmd) {
 		err = -ENOMEM;
 		goto failed;
@@ -734,17 +729,14 @@ failed:
 	return err;
 }
 
-static int set_connectable(struct sock *sk, u16 index, unsigned char *data,
-									u16 len)
+static int set_connectable(struct sock *sk, u16 index, void *cp_data, u16 len)
 {
-	struct mgmt_mode *cp;
+	struct mgmt_mode *cp = cp_data;
 	struct hci_dev *hdev;
 	struct pending_cmd *cmd;
 	u8 scan;
 	int err;
 
-	cp = (void *) data;
-
 	BT_DBG("request for hci%u", index);
 
 	if (len != sizeof(*cp))
@@ -776,7 +768,7 @@ static int set_connectable(struct sock *sk, u16 index, unsigned char *data,
 		goto failed;
 	}
 
-	cmd = mgmt_pending_add(sk, MGMT_OP_SET_CONNECTABLE, hdev, data, len);
+	cmd = mgmt_pending_add(sk, MGMT_OP_SET_CONNECTABLE, hdev, cp_data, len);
 	if (!cmd) {
 		err = -ENOMEM;
 		goto failed;
@@ -827,16 +819,13 @@ static int mgmt_event(u16 event, struct hci_dev *hdev, void *data,
 	return 0;
 }
 
-static int set_pairable(struct sock *sk, u16 index, unsigned char *data,
-									u16 len)
+static int set_pairable(struct sock *sk, u16 index, void *cp_data, u16 len)
 {
-	struct mgmt_mode *cp;
+	struct mgmt_mode *cp = cp_data;
 	struct hci_dev *hdev;
 	__le32 ev;
 	int err;
 
-	cp = (void *) data;
-
 	BT_DBG("request for hci%u", index);
 
 	if (len != sizeof(*cp))
@@ -870,15 +859,13 @@ failed:
 	return err;
 }
 
-static int add_uuid(struct sock *sk, u16 index, unsigned char *data, u16 len)
+static int add_uuid(struct sock *sk, u16 index, void *cp_data, u16 len)
 {
-	struct mgmt_cp_add_uuid *cp;
+	struct mgmt_cp_add_uuid *cp = cp_data;
 	struct hci_dev *hdev;
 	struct bt_uuid *uuid;
 	int err;
 
-	cp = (void *) data;
-
 	BT_DBG("request for hci%u", index);
 
 	if (len != sizeof(*cp))
@@ -920,16 +907,14 @@ failed:
 	return err;
 }
 
-static int remove_uuid(struct sock *sk, u16 index, unsigned char *data, u16 len)
+static int remove_uuid(struct sock *sk, u16 index, void *cp_data, u16 len)
 {
+	struct mgmt_cp_remove_uuid *cp = cp_data;
 	struct list_head *p, *n;
-	struct mgmt_cp_remove_uuid *cp;
 	struct hci_dev *hdev;
 	u8 bt_uuid_any[] = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
 	int err, found;
 
-	cp = (void *) data;
-
 	BT_DBG("request for hci%u", index);
 
 	if (len != sizeof(*cp))
@@ -983,15 +968,12 @@ unlock:
 	return err;
 }
 
-static int set_dev_class(struct sock *sk, u16 index, unsigned char *data,
-									u16 len)
+static int set_dev_class(struct sock *sk, u16 index, void *cp_data, u16 len)
 {
 	struct hci_dev *hdev;
-	struct mgmt_cp_set_dev_class *cp;
+	struct mgmt_cp_set_dev_class *cp = cp_data;
 	int err;
 
-	cp = (void *) data;
-
 	BT_DBG("request for hci%u", index);
 
 	if (len != sizeof(*cp))
@@ -1026,16 +1008,13 @@ static int set_dev_class(struct sock *sk, u16 index, unsigned char *data,
 	return err;
 }
 
-static int load_link_keys(struct sock *sk, u16 index, unsigned char *data,
-								u16 len)
+static int load_link_keys(struct sock *sk, u16 index, void *cp_data, u16 len)
 {
 	struct hci_dev *hdev;
-	struct mgmt_cp_load_link_keys *cp;
+	struct mgmt_cp_load_link_keys *cp = cp_data;
 	u16 key_count, expected_len;
 	int i;
 
-	cp = (void *) data;
-
 	if (len < sizeof(*cp))
 		return cmd_status(sk, index, MGMT_OP_LOAD_LINK_KEYS,
 						MGMT_STATUS_INVALID_PARAMS);
@@ -1085,19 +1064,16 @@ static int load_link_keys(struct sock *sk, u16 index, unsigned char *data,
 	return 0;
 }
 
-static int remove_keys(struct sock *sk, u16 index, unsigned char *data,
-								u16 len)
+static int remove_keys(struct sock *sk, u16 index, void *cp_data, u16 len)
 {
 	struct hci_dev *hdev;
-	struct mgmt_cp_remove_keys *cp;
+	struct mgmt_cp_remove_keys *cp = cp_data;
 	struct mgmt_rp_remove_keys rp;
 	struct hci_cp_disconnect dc;
 	struct pending_cmd *cmd;
 	struct hci_conn *conn;
 	int err;
 
-	cp = (void *) data;
-
 	if (len != sizeof(*cp))
 		return cmd_status(sk, index, MGMT_OP_REMOVE_KEYS,
 						MGMT_STATUS_INVALID_PARAMS);
@@ -1154,10 +1130,10 @@ unlock:
 	return err;
 }
 
-static int disconnect(struct sock *sk, u16 index, unsigned char *data, u16 len)
+static int disconnect(struct sock *sk, u16 index, void *cp_data, u16 len)
 {
 	struct hci_dev *hdev;
-	struct mgmt_cp_disconnect *cp;
+	struct mgmt_cp_disconnect *cp = cp_data;
 	struct hci_cp_disconnect dc;
 	struct pending_cmd *cmd;
 	struct hci_conn *conn;
@@ -1165,8 +1141,6 @@ static int disconnect(struct sock *sk, u16 index, unsigned char *data, u16 len)
 
 	BT_DBG("");
 
-	cp = (void *) data;
-
 	if (len != sizeof(*cp))
 		return cmd_status(sk, index, MGMT_OP_DISCONNECT,
 						MGMT_STATUS_INVALID_PARAMS);
@@ -1200,7 +1174,7 @@ static int disconnect(struct sock *sk, u16 index, unsigned char *data, u16 len)
 		goto failed;
 	}
 
-	cmd = mgmt_pending_add(sk, MGMT_OP_DISCONNECT, hdev, data, len);
+	cmd = mgmt_pending_add(sk, MGMT_OP_DISCONNECT, hdev, cp_data, len);
 	if (!cmd) {
 		err = -ENOMEM;
 		goto failed;
@@ -1314,12 +1288,12 @@ static int send_pin_code_neg_reply(struct sock *sk, u16 index,
 	return err;
 }
 
-static int pin_code_reply(struct sock *sk, u16 index, unsigned char *data,
+static int pin_code_reply(struct sock *sk, u16 index, void *cp_data,
 									u16 len)
 {
 	struct hci_dev *hdev;
 	struct hci_conn *conn;
-	struct mgmt_cp_pin_code_reply *cp;
+	struct mgmt_cp_pin_code_reply *cp = cp_data;
 	struct mgmt_cp_pin_code_neg_reply ncp;
 	struct hci_cp_pin_code_reply reply;
 	struct pending_cmd *cmd;
@@ -1327,8 +1301,6 @@ static int pin_code_reply(struct sock *sk, u16 index, unsigned char *data,
 
 	BT_DBG("");
 
-	cp = (void *) data;
-
 	if (len != sizeof(*cp))
 		return cmd_status(sk, index, MGMT_OP_PIN_CODE_REPLY,
 						MGMT_STATUS_INVALID_PARAMS);
@@ -1366,7 +1338,8 @@ static int pin_code_reply(struct sock *sk, u16 index, unsigned char *data,
 		goto failed;
 	}
 
-	cmd = mgmt_pending_add(sk, MGMT_OP_PIN_CODE_REPLY, hdev, data, len);
+	cmd = mgmt_pending_add(sk, MGMT_OP_PIN_CODE_REPLY, hdev, cp_data,
+									len);
 	if (!cmd) {
 		err = -ENOMEM;
 		goto failed;
@@ -1387,17 +1360,15 @@ failed:
 	return err;
 }
 
-static int pin_code_neg_reply(struct sock *sk, u16 index, unsigned char *data,
+static int pin_code_neg_reply(struct sock *sk, u16 index, void *cp_data,
 									u16 len)
 {
 	struct hci_dev *hdev;
-	struct mgmt_cp_pin_code_neg_reply *cp;
+	struct mgmt_cp_pin_code_neg_reply *cp = cp_data;
 	int err;
 
 	BT_DBG("");
 
-	cp = (void *) data;
-
 	if (len != sizeof(*cp))
 		return cmd_status(sk, index, MGMT_OP_PIN_CODE_NEG_REPLY,
 						MGMT_STATUS_INVALID_PARAMS);
@@ -1424,16 +1395,14 @@ failed:
 	return err;
 }
 
-static int set_io_capability(struct sock *sk, u16 index, unsigned char *data,
+static int set_io_capability(struct sock *sk, u16 index, void *cp_data,
 									u16 len)
 {
 	struct hci_dev *hdev;
-	struct mgmt_cp_set_io_capability *cp;
+	struct mgmt_cp_set_io_capability *cp = cp_data;
 
 	BT_DBG("");
 
-	cp = (void *) data;
-
 	if (len != sizeof(*cp))
 		return cmd_status(sk, index, MGMT_OP_SET_IO_CAPABILITY,
 						MGMT_STATUS_INVALID_PARAMS);
@@ -1508,10 +1477,10 @@ static void pairing_complete_cb(struct hci_conn *conn, u8 status)
 		pairing_complete(cmd, status);
 }
 
-static int pair_device(struct sock *sk, u16 index, unsigned char *data, u16 len)
+static int pair_device(struct sock *sk, u16 index, void *cp_data, u16 len)
 {
 	struct hci_dev *hdev;
-	struct mgmt_cp_pair_device *cp;
+	struct mgmt_cp_pair_device *cp = cp_data;
 	struct mgmt_rp_pair_device rp;
 	struct pending_cmd *cmd;
 	u8 sec_level, auth_type;
@@ -1520,8 +1489,6 @@ static int pair_device(struct sock *sk, u16 index, unsigned char *data, u16 len)
 
 	BT_DBG("");
 
-	cp = (void *) data;
-
 	if (len != sizeof(*cp))
 		return cmd_status(sk, index, MGMT_OP_PAIR_DEVICE,
 						MGMT_STATUS_INVALID_PARAMS);
@@ -1565,7 +1532,7 @@ static int pair_device(struct sock *sk, u16 index, unsigned char *data, u16 len)
 		goto unlock;
 	}
 
-	cmd = mgmt_pending_add(sk, MGMT_OP_PAIR_DEVICE, hdev, data, len);
+	cmd = mgmt_pending_add(sk, MGMT_OP_PAIR_DEVICE, hdev, cp_data, len);
 	if (!cmd) {
 		err = -ENOMEM;
 		hci_conn_put(conn);
@@ -1721,7 +1688,7 @@ done:
 
 static int user_confirm_reply(struct sock *sk, u16 index, void *data, u16 len)
 {
-	struct mgmt_cp_user_confirm_reply *cp = (void *) data;
+	struct mgmt_cp_user_confirm_reply *cp = data;
 
 	BT_DBG("");
 
@@ -1752,7 +1719,7 @@ static int user_confirm_neg_reply(struct sock *sk, u16 index, void *data,
 
 static int user_passkey_reply(struct sock *sk, u16 index, void *data, u16 len)
 {
-	struct mgmt_cp_user_passkey_reply *cp = (void *) data;
+	struct mgmt_cp_user_passkey_reply *cp = data;
 
 	BT_DBG("");
 
@@ -1768,7 +1735,7 @@ static int user_passkey_reply(struct sock *sk, u16 index, void *data, u16 len)
 static int user_passkey_neg_reply(struct sock *sk, u16 index, void *data,
 									u16 len)
 {
-	struct mgmt_cp_user_passkey_neg_reply *cp = (void *) data;
+	struct mgmt_cp_user_passkey_neg_reply *cp = data;
 
 	BT_DBG("");
 
@@ -1781,10 +1748,10 @@ static int user_passkey_neg_reply(struct sock *sk, u16 index, void *data,
 			HCI_OP_USER_PASSKEY_NEG_REPLY, 0);
 }
 
-static int set_local_name(struct sock *sk, u16 index, unsigned char *data,
+static int set_local_name(struct sock *sk, u16 index, void *cp_data,
 								u16 len)
 {
-	struct mgmt_cp_set_local_name *mgmt_cp = (void *) data;
+	struct mgmt_cp_set_local_name *mgmt_cp = cp_data;
 	struct hci_cp_write_local_name hci_cp;
 	struct hci_dev *hdev;
 	struct pending_cmd *cmd;
@@ -1803,7 +1770,8 @@ static int set_local_name(struct sock *sk, u16 index, unsigned char *data,
 
 	hci_dev_lock(hdev);
 
-	cmd = mgmt_pending_add(sk, MGMT_OP_SET_LOCAL_NAME, hdev, data, len);
+	cmd = mgmt_pending_add(sk, MGMT_OP_SET_LOCAL_NAME, hdev, cp_data,
+									len);
 	if (!cmd) {
 		err = -ENOMEM;
 		goto failed;
@@ -1872,11 +1840,11 @@ unlock:
 	return err;
 }
 
-static int add_remote_oob_data(struct sock *sk, u16 index, unsigned char *data,
-									u16 len)
+static int add_remote_oob_data(struct sock *sk, u16 index, void *cp_data,
+								u16 len)
 {
 	struct hci_dev *hdev;
-	struct mgmt_cp_add_remote_oob_data *cp = (void *) data;
+	struct mgmt_cp_add_remote_oob_data *cp = cp_data;
 	int err;
 
 	BT_DBG("hci%u ", index);
@@ -1908,10 +1876,10 @@ static int add_remote_oob_data(struct sock *sk, u16 index, unsigned char *data,
 }
 
 static int remove_remote_oob_data(struct sock *sk, u16 index,
-						unsigned char *data, u16 len)
+						void *cp_data, u16 len)
 {
 	struct hci_dev *hdev;
-	struct mgmt_cp_remove_remote_oob_data *cp = (void *) data;
+	struct mgmt_cp_remove_remote_oob_data *cp = cp_data;
 	int err;
 
 	BT_DBG("hci%u ", index);
@@ -1942,9 +1910,9 @@ static int remove_remote_oob_data(struct sock *sk, u16 index,
 }
 
 static int start_discovery(struct sock *sk, u16 index,
-						unsigned char *data, u16 len)
+						void *cp_data, u16 len)
 {
-	struct mgmt_cp_start_discovery *cp = (void *) data;
+	struct mgmt_cp_start_discovery *cp = cp_data;
 	struct pending_cmd *cmd;
 	struct hci_dev *hdev;
 	int err;
@@ -2054,10 +2022,10 @@ unlock:
 	return err;
 }
 
-static int confirm_name(struct sock *sk, u16 index, unsigned char *data,
+static int confirm_name(struct sock *sk, u16 index, void *cp_data,
 								u16 len)
 {
-	struct mgmt_cp_confirm_name *cp = (void *) data;
+	struct mgmt_cp_confirm_name *cp = cp_data;
 	struct inquiry_entry *e;
 	struct hci_dev *hdev;
 	int err;
@@ -2104,11 +2072,11 @@ failed:
 	return err;
 }
 
-static int block_device(struct sock *sk, u16 index, unsigned char *data,
+static int block_device(struct sock *sk, u16 index, void *cp_data,
 								u16 len)
 {
 	struct hci_dev *hdev;
-	struct mgmt_cp_block_device *cp = (void *) data;
+	struct mgmt_cp_block_device *cp = cp_data;
 	int err;
 
 	BT_DBG("hci%u", index);
@@ -2138,11 +2106,10 @@ static int block_device(struct sock *sk, u16 index, unsigned char *data,
 	return err;
 }
 
-static int unblock_device(struct sock *sk, u16 index, unsigned char *data,
-								u16 len)
+static int unblock_device(struct sock *sk, u16 index, void *cp_data, u16 len)
 {
 	struct hci_dev *hdev;
-	struct mgmt_cp_unblock_device *cp = (void *) data;
+	struct mgmt_cp_unblock_device *cp = cp_data;
 	int err;
 
 	BT_DBG("hci%u", index);
@@ -2174,10 +2141,10 @@ static int unblock_device(struct sock *sk, u16 index, unsigned char *data,
 }
 
 static int set_fast_connectable(struct sock *sk, u16 index,
-					unsigned char *data, u16 len)
+					void *cp_data, u16 len)
 {
 	struct hci_dev *hdev;
-	struct mgmt_mode *cp = (void *) data;
+	struct mgmt_mode *cp = cp_data;
 	struct hci_cp_write_page_scan_activity acp;
 	u8 type;
 	int err;
@@ -2231,7 +2198,8 @@ done:
 
 int mgmt_control(struct sock *sk, struct msghdr *msg, size_t msglen)
 {
-	unsigned char *buf;
+	void *buf;
+	u8 *cp;
 	struct mgmt_hdr *hdr;
 	u16 opcode, index, len;
 	int err;
@@ -2250,7 +2218,7 @@ int mgmt_control(struct sock *sk, struct msghdr *msg, size_t msglen)
 		goto done;
 	}
 
-	hdr = (struct mgmt_hdr *) buf;
+	hdr = buf;
 	opcode = get_unaligned_le16(&hdr->opcode);
 	index = get_unaligned_le16(&hdr->index);
 	len = get_unaligned_le16(&hdr->len);
@@ -2260,6 +2228,8 @@ int mgmt_control(struct sock *sk, struct msghdr *msg, size_t msglen)
 		goto done;
 	}
 
+	cp = buf + sizeof(*hdr);
+
 	switch (opcode) {
 	case MGMT_OP_READ_VERSION:
 		err = read_version(sk);
@@ -2271,98 +2241,94 @@ int mgmt_control(struct sock *sk, struct msghdr *msg, size_t msglen)
 		err = read_controller_info(sk, index);
 		break;
 	case MGMT_OP_SET_POWERED:
-		err = set_powered(sk, index, buf + sizeof(*hdr), len);
+		err = set_powered(sk, index, cp, len);
 		break;
 	case MGMT_OP_SET_DISCOVERABLE:
-		err = set_discoverable(sk, index, buf + sizeof(*hdr), len);
+		err = set_discoverable(sk, index, cp, len);
 		break;
 	case MGMT_OP_SET_CONNECTABLE:
-		err = set_connectable(sk, index, buf + sizeof(*hdr), len);
+		err = set_connectable(sk, index, cp, len);
 		break;
 	case MGMT_OP_SET_FAST_CONNECTABLE:
-		err = set_fast_connectable(sk, index, buf + sizeof(*hdr),
-								len);
+		err = set_fast_connectable(sk, index, cp, len);
 		break;
 	case MGMT_OP_SET_PAIRABLE:
-		err = set_pairable(sk, index, buf + sizeof(*hdr), len);
+		err = set_pairable(sk, index, cp, len);
 		break;
 	case MGMT_OP_ADD_UUID:
-		err = add_uuid(sk, index, buf + sizeof(*hdr), len);
+		err = add_uuid(sk, index, cp, len);
 		break;
 	case MGMT_OP_REMOVE_UUID:
-		err = remove_uuid(sk, index, buf + sizeof(*hdr), len);
+		err = remove_uuid(sk, index, cp, len);
 		break;
 	case MGMT_OP_SET_DEV_CLASS:
-		err = set_dev_class(sk, index, buf + sizeof(*hdr), len);
+		err = set_dev_class(sk, index, cp, len);
 		break;
 	case MGMT_OP_LOAD_LINK_KEYS:
-		err = load_link_keys(sk, index, buf + sizeof(*hdr), len);
+		err = load_link_keys(sk, index, cp, len);
 		break;
 	case MGMT_OP_REMOVE_KEYS:
-		err = remove_keys(sk, index, buf + sizeof(*hdr), len);
+		err = remove_keys(sk, index, cp, len);
 		break;
 	case MGMT_OP_DISCONNECT:
-		err = disconnect(sk, index, buf + sizeof(*hdr), len);
+		err = disconnect(sk, index, cp, len);
 		break;
 	case MGMT_OP_GET_CONNECTIONS:
 		err = get_connections(sk, index);
 		break;
 	case MGMT_OP_PIN_CODE_REPLY:
-		err = pin_code_reply(sk, index, buf + sizeof(*hdr), len);
+		err = pin_code_reply(sk, index, cp, len);
 		break;
 	case MGMT_OP_PIN_CODE_NEG_REPLY:
-		err = pin_code_neg_reply(sk, index, buf + sizeof(*hdr), len);
+		err = pin_code_neg_reply(sk, index, cp, len);
 		break;
 	case MGMT_OP_SET_IO_CAPABILITY:
-		err = set_io_capability(sk, index, buf + sizeof(*hdr), len);
+		err = set_io_capability(sk, index, cp, len);
 		break;
 	case MGMT_OP_PAIR_DEVICE:
-		err = pair_device(sk, index, buf + sizeof(*hdr), len);
+		err = pair_device(sk, index, cp, len);
 		break;
 	case MGMT_OP_CANCEL_PAIR_DEVICE:
 		err = cancel_pair_device(sk, index, buf + sizeof(*hdr), len);
 		break;
 	case MGMT_OP_USER_CONFIRM_REPLY:
-		err = user_confirm_reply(sk, index, buf + sizeof(*hdr), len);
+		err = user_confirm_reply(sk, index, cp, len);
 		break;
 	case MGMT_OP_USER_CONFIRM_NEG_REPLY:
-		err = user_confirm_neg_reply(sk, index, buf + sizeof(*hdr),
-									len);
+		err = user_confirm_neg_reply(sk, index, cp, len);
 		break;
 	case MGMT_OP_USER_PASSKEY_REPLY:
-		err = user_passkey_reply(sk, index, buf + sizeof(*hdr), len);
+		err = user_passkey_reply(sk, index, cp, len);
 		break;
 	case MGMT_OP_USER_PASSKEY_NEG_REPLY:
-		err = user_passkey_neg_reply(sk, index, buf + sizeof(*hdr),
-									len);
+		err = user_passkey_neg_reply(sk, index, cp, len);
 		break;
 	case MGMT_OP_SET_LOCAL_NAME:
-		err = set_local_name(sk, index, buf + sizeof(*hdr), len);
+		err = set_local_name(sk, index, cp, len);
 		break;
 	case MGMT_OP_READ_LOCAL_OOB_DATA:
 		err = read_local_oob_data(sk, index);
 		break;
 	case MGMT_OP_ADD_REMOTE_OOB_DATA:
-		err = add_remote_oob_data(sk, index, buf + sizeof(*hdr), len);
+		err = add_remote_oob_data(sk, index, cp, len);
 		break;
 	case MGMT_OP_REMOVE_REMOTE_OOB_DATA:
-		err = remove_remote_oob_data(sk, index, buf + sizeof(*hdr),
-									len);
+		err = remove_remote_oob_data(sk, index, cp, len);
 		break;
 	case MGMT_OP_START_DISCOVERY:
-		err = start_discovery(sk, index, buf + sizeof(*hdr), len);
+		err = start_discovery(sk, index, cp, len);
 		break;
 	case MGMT_OP_STOP_DISCOVERY:
 		err = stop_discovery(sk, index);
 		break;
 	case MGMT_OP_CONFIRM_NAME:
-		err = confirm_name(sk, index, buf + sizeof(*hdr), len);
+		err = confirm_name(sk, index, cp, len);
 		break;
 	case MGMT_OP_BLOCK_DEVICE:
-		err = block_device(sk, index, buf + sizeof(*hdr), len);
+		err = block_device(sk, index, cp, len);
 		break;
 	case MGMT_OP_UNBLOCK_DEVICE:
-		err = unblock_device(sk, index, buf + sizeof(*hdr), len);
+		err = unblock_device(sk, index, cp, len);
 		break;
 	default:
 		BT_DBG("Unknown op %u", opcode);
-- 
1.7.8.1

