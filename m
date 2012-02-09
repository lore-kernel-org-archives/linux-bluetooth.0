Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/8] Bluetooth: Update and rename mgmt_remove_keys to mgmt_unpair_device
Date: Thu,  9 Feb 2012 17:23:43 +0200
Message-Id: <1328801030-24274-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1328801030-24274-1-git-send-email-johan.hedberg@gmail.com>
References: <1328801030-24274-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch renames the mgmt_remove_keys command to mgmt_unpair_device
and updates its parameters to match the latest API (specifically, it
adds an address type parameter to the command and its response).

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/mgmt.h |   34 ++++++++++++------------
 net/bluetooth/mgmt.c         |   60 +++++++++++++++++++++++------------------
 2 files changed, 51 insertions(+), 43 deletions(-)

diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 72975fd..4c18cd5 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -175,17 +175,7 @@ struct mgmt_cp_load_long_term_keys {
 	struct mgmt_ltk_info keys[0];
 } __packed;
 
-#define MGMT_OP_REMOVE_KEYS		0x0014
-struct mgmt_cp_remove_keys {
-	bdaddr_t bdaddr;
-	__u8 disconnect;
-} __packed;
-struct mgmt_rp_remove_keys {
-	bdaddr_t bdaddr;
-	__u8 status;
-};
-
-#define MGMT_OP_DISCONNECT		0x0015
+#define MGMT_OP_DISCONNECT		0x0014
 struct mgmt_cp_disconnect {
 	bdaddr_t bdaddr;
 } __packed;
@@ -194,13 +184,13 @@ struct mgmt_rp_disconnect {
 	__u8 status;
 } __packed;
 
-#define MGMT_OP_GET_CONNECTIONS		0x0016
+#define MGMT_OP_GET_CONNECTIONS		0x0015
 struct mgmt_rp_get_connections {
 	__le16 conn_count;
 	struct mgmt_addr_info addr[0];
 } __packed;
 
-#define MGMT_OP_PIN_CODE_REPLY		0x0017
+#define MGMT_OP_PIN_CODE_REPLY		0x0016
 struct mgmt_cp_pin_code_reply {
 	bdaddr_t bdaddr;
 	__u8 pin_len;
@@ -211,17 +201,17 @@ struct mgmt_rp_pin_code_reply {
 	uint8_t status;
 } __packed;
 
-#define MGMT_OP_PIN_CODE_NEG_REPLY	0x0018
+#define MGMT_OP_PIN_CODE_NEG_REPLY	0x0017
 struct mgmt_cp_pin_code_neg_reply {
 	bdaddr_t bdaddr;
 } __packed;
 
-#define MGMT_OP_SET_IO_CAPABILITY	0x0019
+#define MGMT_OP_SET_IO_CAPABILITY	0x0018
 struct mgmt_cp_set_io_capability {
 	__u8 io_capability;
 } __packed;
 
-#define MGMT_OP_PAIR_DEVICE		0x001A
+#define MGMT_OP_PAIR_DEVICE		0x0019
 struct mgmt_cp_pair_device {
 	struct mgmt_addr_info addr;
 	__u8 io_cap;
@@ -231,7 +221,17 @@ struct mgmt_rp_pair_device {
 	__u8 status;
 } __packed;
 
-#define MGMT_OP_CANCEL_PAIR_DEVICE	0x001B
+#define MGMT_OP_CANCEL_PAIR_DEVICE	0x001A
+
+#define MGMT_OP_UNPAIR_DEVICE		0x001B
+struct mgmt_cp_unpair_device {
+	struct mgmt_addr_info addr;
+	__u8 disconnect;
+} __packed;
+struct mgmt_rp_unpair_device {
+	struct mgmt_addr_info addr;
+	__u8 status;
+};
 
 #define MGMT_OP_USER_CONFIRM_REPLY	0x001C
 struct mgmt_cp_user_confirm_reply {
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 77bc5a4..c64e5db 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1073,57 +1073,63 @@ static int load_link_keys(struct sock *sk, u16 index, void *data, u16 len)
 	return 0;
 }
 
-static int remove_keys(struct sock *sk, u16 index, void *data, u16 len)
+static int unpair_device(struct sock *sk, u16 index, void *data, u16 len)
 {
 	struct hci_dev *hdev;
-	struct mgmt_cp_remove_keys *cp = data;
-	struct mgmt_rp_remove_keys rp;
+	struct mgmt_cp_unpair_device *cp = data;
+	struct mgmt_rp_unpair_device rp;
 	struct hci_cp_disconnect dc;
 	struct pending_cmd *cmd;
 	struct hci_conn *conn;
 	int err;
 
 	if (len != sizeof(*cp))
-		return cmd_status(sk, index, MGMT_OP_REMOVE_KEYS,
+		return cmd_status(sk, index, MGMT_OP_UNPAIR_DEVICE,
 						MGMT_STATUS_INVALID_PARAMS);
 
 	hdev = hci_dev_get(index);
 	if (!hdev)
-		return cmd_status(sk, index, MGMT_OP_REMOVE_KEYS,
+		return cmd_status(sk, index, MGMT_OP_UNPAIR_DEVICE,
 						MGMT_STATUS_INVALID_PARAMS);
 
 	hci_dev_lock(hdev);
 
 	memset(&rp, 0, sizeof(rp));
-	bacpy(&rp.bdaddr, &cp->bdaddr);
+	bacpy(&rp.addr.bdaddr, &cp->addr.bdaddr);
+	rp.addr.type = cp->addr.type;
 	rp.status = MGMT_STATUS_FAILED;
 
-	err = hci_remove_ltk(hdev, &cp->bdaddr);
-	if (err < 0) {
-		err = cmd_status(sk, index, MGMT_OP_REMOVE_KEYS, -err);
-		goto unlock;
-	}
+	if (cp->addr.type == MGMT_ADDR_BREDR)
+		err = hci_remove_link_key(hdev, &cp->addr.bdaddr);
+	else
+		err = hci_remove_ltk(hdev, &cp->addr.bdaddr);
 
-	err = hci_remove_link_key(hdev, &cp->bdaddr);
 	if (err < 0) {
 		rp.status = MGMT_STATUS_NOT_PAIRED;
 		goto unlock;
 	}
 
 	if (!test_bit(HCI_UP, &hdev->flags) || !cp->disconnect) {
-		err = cmd_complete(sk, index, MGMT_OP_REMOVE_KEYS, &rp,
+		err = cmd_complete(sk, index, MGMT_OP_UNPAIR_DEVICE, &rp,
 								sizeof(rp));
 		goto unlock;
 	}
 
-	conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, &cp->bdaddr);
+	if (cp->addr.type == MGMT_ADDR_BREDR)
+		conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK,
+							&cp->addr.bdaddr);
+	else
+		conn = hci_conn_hash_lookup_ba(hdev, LE_LINK,
+							&cp->addr.bdaddr);
+
 	if (!conn) {
-		err = cmd_complete(sk, index, MGMT_OP_REMOVE_KEYS, &rp,
+		err = cmd_complete(sk, index, MGMT_OP_UNPAIR_DEVICE, &rp,
 								sizeof(rp));
 		goto unlock;
 	}
 
-	cmd = mgmt_pending_add(sk, MGMT_OP_REMOVE_KEYS, hdev, cp, sizeof(*cp));
+	cmd = mgmt_pending_add(sk, MGMT_OP_UNPAIR_DEVICE, hdev, cp,
+								sizeof(*cp));
 	if (!cmd) {
 		err = -ENOMEM;
 		goto unlock;
@@ -1137,7 +1143,7 @@ static int remove_keys(struct sock *sk, u16 index, void *data, u16 len)
 
 unlock:
 	if (err < 0)
-		err = cmd_complete(sk, index, MGMT_OP_REMOVE_KEYS, &rp,
+		err = cmd_complete(sk, index, MGMT_OP_UNPAIR_DEVICE, &rp,
 								sizeof(rp));
 	hci_dev_unlock(hdev);
 	hci_dev_put(hdev);
@@ -2340,9 +2346,6 @@ int mgmt_control(struct sock *sk, struct msghdr *msg, size_t msglen)
 	case MGMT_OP_LOAD_LINK_KEYS:
 		err = load_link_keys(sk, index, cp, len);
 		break;
-	case MGMT_OP_REMOVE_KEYS:
-		err = remove_keys(sk, index, cp, len);
-		break;
 	case MGMT_OP_DISCONNECT:
 		err = disconnect(sk, index, cp, len);
 		break;
@@ -2364,6 +2367,9 @@ int mgmt_control(struct sock *sk, struct msghdr *msg, size_t msglen)
 	case MGMT_OP_CANCEL_PAIR_DEVICE:
 		err = cancel_pair_device(sk, index, buf + sizeof(*hdr), len);
 		break;
+	case MGMT_OP_UNPAIR_DEVICE:
+		err = unpair_device(sk, index, cp, len);
+		break;
 	case MGMT_OP_USER_CONFIRM_REPLY:
 		err = user_confirm_reply(sk, index, cp, len);
 		break;
@@ -2624,18 +2630,19 @@ static void disconnect_rsp(struct pending_cmd *cmd, void *data)
 	mgmt_pending_remove(cmd);
 }
 
-static void remove_keys_rsp(struct pending_cmd *cmd, void *data)
+static void unpair_device_rsp(struct pending_cmd *cmd, void *data)
 {
 	u8 *status = data;
-	struct mgmt_cp_remove_keys *cp = cmd->param;
-	struct mgmt_rp_remove_keys rp;
+	struct mgmt_cp_unpair_device *cp = cmd->param;
+	struct mgmt_rp_unpair_device rp;
 
 	memset(&rp, 0, sizeof(rp));
-	bacpy(&rp.bdaddr, &cp->bdaddr);
+	bacpy(&rp.addr.bdaddr, &cp->addr.bdaddr);
+	rp.addr.type = cp->addr.type;
 	if (status != NULL)
 		rp.status = *status;
 
-	cmd_complete(cmd->sk, cmd->index, MGMT_OP_REMOVE_KEYS, &rp,
+	cmd_complete(cmd->sk, cmd->index, MGMT_OP_UNPAIR_DEVICE, &rp,
 								sizeof(rp));
 
 	mgmt_pending_remove(cmd);
@@ -2659,7 +2666,8 @@ int mgmt_device_disconnected(struct hci_dev *hdev, bdaddr_t *bdaddr,
 	if (sk)
 		sock_put(sk);
 
-	mgmt_pending_foreach(MGMT_OP_REMOVE_KEYS, hdev, remove_keys_rsp, NULL);
+	mgmt_pending_foreach(MGMT_OP_UNPAIR_DEVICE, hdev, unpair_device_rsp,
+									NULL);
 
 	return err;
 }
-- 
1.7.9

