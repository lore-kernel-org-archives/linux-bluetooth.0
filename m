Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: [PATCH 1/7] Bluetooth: Fix coding style in mgmt.c
Date: Thu, 17 May 2012 00:36:20 -0300
Message-Id: <1337225786-11064-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

Follow the coding style of the net subsystem.

Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
---
 net/bluetooth/mgmt.c |   44 ++++++++++++++++++++++----------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 25d2207..6a7e926 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -871,7 +871,7 @@ static int set_discoverable(struct sock *sk, struct hci_dev *hdev, void *data,
 	}
 
 	if (mgmt_pending_find(MGMT_OP_SET_DISCOVERABLE, hdev) ||
-			mgmt_pending_find(MGMT_OP_SET_CONNECTABLE, hdev)) {
+	    mgmt_pending_find(MGMT_OP_SET_CONNECTABLE, hdev)) {
 		err = cmd_status(sk, hdev->id, MGMT_OP_SET_DISCOVERABLE,
 				 MGMT_STATUS_BUSY);
 		goto failed;
@@ -978,7 +978,7 @@ static int set_connectable(struct sock *sk, struct hci_dev *hdev, void *data,
 	}
 
 	if (mgmt_pending_find(MGMT_OP_SET_DISCOVERABLE, hdev) ||
-			mgmt_pending_find(MGMT_OP_SET_CONNECTABLE, hdev)) {
+	    mgmt_pending_find(MGMT_OP_SET_CONNECTABLE, hdev)) {
 		err = cmd_status(sk, hdev->id, MGMT_OP_SET_CONNECTABLE,
 				 MGMT_STATUS_BUSY);
 		goto failed;
@@ -1001,7 +1001,7 @@ static int set_connectable(struct sock *sk, struct hci_dev *hdev, void *data,
 		scan = 0;
 
 		if (test_bit(HCI_ISCAN, &hdev->flags) &&
-						hdev->discov_timeout > 0)
+		    hdev->discov_timeout > 0)
 			cancel_delayed_work(&hdev->discov_off);
 	}
 
@@ -1056,7 +1056,7 @@ static int set_link_security(struct sock *sk, struct hci_dev *hdev, void *data,
 		bool changed = false;
 
 		if (!!cp->val != test_bit(HCI_LINK_SECURITY,
-							&hdev->dev_flags)) {
+					  &hdev->dev_flags)) {
 			change_bit(HCI_LINK_SECURITY, &hdev->dev_flags);
 			changed = true;
 		}
@@ -1317,7 +1317,7 @@ static bool enable_service_cache(struct hci_dev *hdev)
 }
 
 static int remove_uuid(struct sock *sk, struct hci_dev *hdev, void *data,
-								u16 len)
+		       u16 len)
 {
 	struct mgmt_cp_remove_uuid *cp = data;
 	struct pending_cmd *cmd;
@@ -1442,7 +1442,7 @@ unlock:
 }
 
 static int load_link_keys(struct sock *sk, struct hci_dev *hdev, void *data,
-								u16 len)
+			  u16 len)
 {
 	struct mgmt_cp_load_link_keys *cp = data;
 	u16 key_count, expected_len;
@@ -1454,13 +1454,13 @@ static int load_link_keys(struct sock *sk, struct hci_dev *hdev, void *data,
 					sizeof(struct mgmt_link_key_info);
 	if (expected_len != len) {
 		BT_ERR("load_link_keys: expected %u bytes, got %u bytes",
-							len, expected_len);
+		       len, expected_len);
 		return cmd_status(sk, hdev->id, MGMT_OP_LOAD_LINK_KEYS,
 				  MGMT_STATUS_INVALID_PARAMS);
 	}
 
 	BT_DBG("%s debug_keys %u key_count %u", hdev->name, cp->debug_keys,
-								key_count);
+	       key_count);
 
 	hci_dev_lock(hdev);
 
@@ -1535,10 +1535,10 @@ static int unpair_device(struct sock *sk, struct hci_dev *hdev, void *data,
 	if (cp->disconnect) {
 		if (cp->addr.type == BDADDR_BREDR)
 			conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK,
-							&cp->addr.bdaddr);
+						       &cp->addr.bdaddr);
 		else
 			conn = hci_conn_hash_lookup_ba(hdev, LE_LINK,
-							&cp->addr.bdaddr);
+						       &cp->addr.bdaddr);
 	} else {
 		conn = NULL;
 	}
@@ -1813,7 +1813,7 @@ static int set_io_capability(struct sock *sk, struct hci_dev *hdev, void *data,
 	hdev->io_capability = cp->io_capability;
 
 	BT_DBG("%s IO capability set to 0x%02x", hdev->name,
-							hdev->io_capability);
+	       hdev->io_capability);
 
 	hci_dev_unlock(hdev);
 
@@ -1941,7 +1941,7 @@ static int pair_device(struct sock *sk, struct hci_dev *hdev, void *data,
 	cmd->user_data = conn;
 
 	if (conn->state == BT_CONNECTED &&
-				hci_conn_security(conn, sec_level, auth_type))
+	    hci_conn_security(conn, sec_level, auth_type))
 		pairing_complete(cmd, 0);
 
 	err = 0;
@@ -2238,7 +2238,7 @@ unlock:
 }
 
 static int remove_remote_oob_data(struct sock *sk, struct hci_dev *hdev,
-						void *data, u16 len)
+				  void *data, u16 len)
 {
 	struct mgmt_cp_remove_remote_oob_data *cp = data;
 	u8 status;
@@ -2407,7 +2407,7 @@ static int stop_discovery(struct sock *sk, struct hci_dev *hdev, void *data,
 
 	case DISCOVERY_RESOLVING:
 		e = hci_inquiry_cache_lookup_resolve(hdev, BDADDR_ANY,
-							NAME_PENDING);
+						     NAME_PENDING);
 		if (!e) {
 			mgmt_pending_remove(cmd);
 			err = cmd_complete(sk, hdev->id,
@@ -2629,7 +2629,7 @@ static int load_long_term_keys(struct sock *sk, struct hci_dev *hdev,
 					sizeof(struct mgmt_ltk_info);
 	if (expected_len != len) {
 		BT_ERR("load_keys: expected %u bytes, got %u bytes",
-							len, expected_len);
+		       len, expected_len);
 		return cmd_status(sk, hdev->id, MGMT_OP_LOAD_LONG_TERM_KEYS,
 				  EINVAL);
 	}
@@ -2754,7 +2754,7 @@ int mgmt_control(struct sock *sk, struct msghdr *msg, size_t msglen)
 	}
 
 	if (opcode >= ARRAY_SIZE(mgmt_handlers) ||
-					mgmt_handlers[opcode].func == NULL) {
+	    mgmt_handlers[opcode].func == NULL) {
 		BT_DBG("Unknown op %u", opcode);
 		err = cmd_status(sk, index, opcode,
 				 MGMT_STATUS_UNKNOWN_COMMAND);
@@ -2762,7 +2762,7 @@ int mgmt_control(struct sock *sk, struct msghdr *msg, size_t msglen)
 	}
 
 	if ((hdev && opcode < MGMT_OP_READ_INFO) ||
-			(!hdev && opcode >= MGMT_OP_READ_INFO)) {
+	    (!hdev && opcode >= MGMT_OP_READ_INFO)) {
 		err = cmd_status(sk, index, opcode,
 				 MGMT_STATUS_INVALID_INDEX);
 		goto done;
@@ -2771,7 +2771,7 @@ int mgmt_control(struct sock *sk, struct msghdr *msg, size_t msglen)
 	handler = &mgmt_handlers[opcode];
 
 	if ((handler->var_len && len < handler->data_len) ||
-			(!handler->var_len && len != handler->data_len)) {
+	    (!handler->var_len && len != handler->data_len)) {
 		err = cmd_status(sk, index, opcode,
 				 MGMT_STATUS_INVALID_PARAMS);
 		goto done;
@@ -3090,7 +3090,7 @@ int mgmt_disconnect_failed(struct hci_dev *hdev, bdaddr_t *bdaddr,
 	mgmt_pending_remove(cmd);
 
 	mgmt_pending_foreach(MGMT_OP_UNPAIR_DEVICE, hdev, unpair_device_rsp,
-									hdev);
+			     hdev);
 	return err;
 }
 
@@ -3180,7 +3180,7 @@ int mgmt_user_confirm_request(struct hci_dev *hdev, bdaddr_t *bdaddr,
 }
 
 int mgmt_user_passkey_request(struct hci_dev *hdev, bdaddr_t *bdaddr,
-						u8 link_type, u8 addr_type)
+			      u8 link_type, u8 addr_type)
 {
 	struct mgmt_ev_user_passkey_request ev;
 
@@ -3194,8 +3194,8 @@ int mgmt_user_passkey_request(struct hci_dev *hdev, bdaddr_t *bdaddr,
 }
 
 static int user_pairing_resp_complete(struct hci_dev *hdev, bdaddr_t *bdaddr,
-					u8 link_type, u8 addr_type, u8 status,
-					u8 opcode)
+				      u8 link_type, u8 addr_type, u8 status,
+				      u8 opcode)
 {
 	struct pending_cmd *cmd;
 	struct mgmt_rp_user_confirm_reply rp;
-- 
1.7.10.1

