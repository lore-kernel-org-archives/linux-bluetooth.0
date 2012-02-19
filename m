Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/6] Bluetooth: mgmt: Move status parameters into the cmd_complete header
Date: Sun, 19 Feb 2012 13:54:25 +0200
Message-Id: <1329652469-28973-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1329652469-28973-1-git-send-email-johan.hedberg@gmail.com>
References: <1329652469-28973-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Instead of having status paramters part of each individual command
response it's simpler to just have the status as part of the command
complete header. This patch updates the code to follow this convention
and thereby also ensures compliance with the latest mgmt API
specification.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/mgmt.h |    8 +---
 net/bluetooth/mgmt.c         |  107 +++++++++++++++++++++--------------------
 2 files changed, 56 insertions(+), 59 deletions(-)

diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 36e68b4..7e3d38b 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -184,7 +184,6 @@ struct mgmt_cp_disconnect {
 } __packed;
 struct mgmt_rp_disconnect {
 	struct mgmt_addr_info addr;
-	__u8 status;
 } __packed;
 
 #define MGMT_OP_GET_CONNECTIONS		0x0015
@@ -201,7 +200,6 @@ struct mgmt_cp_pin_code_reply {
 } __packed;
 struct mgmt_rp_pin_code_reply {
 	struct mgmt_addr_info addr;
-	uint8_t status;
 } __packed;
 
 #define MGMT_OP_PIN_CODE_NEG_REPLY	0x0017
@@ -221,7 +219,6 @@ struct mgmt_cp_pair_device {
 } __packed;
 struct mgmt_rp_pair_device {
 	struct mgmt_addr_info addr;
-	__u8 status;
 } __packed;
 
 #define MGMT_OP_CANCEL_PAIR_DEVICE	0x001A
@@ -233,7 +230,6 @@ struct mgmt_cp_unpair_device {
 } __packed;
 struct mgmt_rp_unpair_device {
 	struct mgmt_addr_info addr;
-	__u8 status;
 };
 
 #define MGMT_OP_USER_CONFIRM_REPLY	0x001C
@@ -242,7 +238,6 @@ struct mgmt_cp_user_confirm_reply {
 } __packed;
 struct mgmt_rp_user_confirm_reply {
 	struct mgmt_addr_info addr;
-	__u8 status;
 } __packed;
 
 #define MGMT_OP_USER_CONFIRM_NEG_REPLY	0x001D
@@ -257,7 +252,6 @@ struct mgmt_cp_user_passkey_reply {
 } __packed;
 struct mgmt_rp_user_passkey_reply {
 	struct mgmt_addr_info addr;
-	__u8 status;
 } __packed;
 
 #define MGMT_OP_USER_PASSKEY_NEG_REPLY	0x001F
@@ -297,7 +291,6 @@ struct mgmt_cp_confirm_name {
 } __packed;
 struct mgmt_rp_confirm_name {
 	struct mgmt_addr_info addr;
-	__u8 status;
 } __packed;
 
 #define MGMT_OP_BLOCK_DEVICE		0x0026
@@ -313,6 +306,7 @@ struct mgmt_cp_unblock_device {
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
 	__le16 opcode;
+	__u8 status;
 	__u8 data[0];
 } __packed;
 
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 89754bb..61d0250 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -227,8 +227,8 @@ static int cmd_status(struct sock *sk, u16 index, u16 cmd, u8 status)
 	return err;
 }
 
-static int cmd_complete(struct sock *sk, u16 index, u16 cmd, void *rp,
-								size_t rp_len)
+static int cmd_complete(struct sock *sk, u16 index, u16 cmd, u8 status,
+						void *rp, size_t rp_len)
 {
 	struct sk_buff *skb;
 	struct mgmt_hdr *hdr;
@@ -249,6 +249,7 @@ static int cmd_complete(struct sock *sk, u16 index, u16 cmd, void *rp,
 
 	ev = (void *) skb_put(skb, sizeof(*ev) + rp_len);
 	put_unaligned_le16(cmd, &ev->opcode);
+	ev->status = status;
 
 	if (rp)
 		memcpy(ev->data, rp, rp_len);
@@ -269,7 +270,7 @@ static int read_version(struct sock *sk)
 	rp.version = MGMT_VERSION;
 	put_unaligned_le16(MGMT_REVISION, &rp.revision);
 
-	return cmd_complete(sk, MGMT_INDEX_NONE, MGMT_OP_READ_VERSION, &rp,
+	return cmd_complete(sk, MGMT_INDEX_NONE, MGMT_OP_READ_VERSION, 0, &rp,
 								sizeof(rp));
 }
 
@@ -299,7 +300,7 @@ static int read_commands(struct sock *sk)
 	for (i = 0; i < num_events; i++, opcode++)
 		put_unaligned_le16(mgmt_events[i], opcode);
 
-	err = cmd_complete(sk, MGMT_INDEX_NONE, MGMT_OP_READ_COMMANDS, rp,
+	err = cmd_complete(sk, MGMT_INDEX_NONE, MGMT_OP_READ_COMMANDS, 0, rp,
 								rp_size);
 	kfree(rp);
 
@@ -347,7 +348,7 @@ static int read_index_list(struct sock *sk)
 
 	read_unlock(&hci_dev_list_lock);
 
-	err = cmd_complete(sk, MGMT_INDEX_NONE, MGMT_OP_READ_INDEX_LIST, rp,
+	err = cmd_complete(sk, MGMT_INDEX_NONE, MGMT_OP_READ_INDEX_LIST, 0, rp,
 									rp_len);
 
 	kfree(rp);
@@ -637,7 +638,7 @@ static int read_controller_info(struct sock *sk, u16 index)
 	hci_dev_unlock(hdev);
 	hci_dev_put(hdev);
 
-	return cmd_complete(sk, index, MGMT_OP_READ_INFO, &rp, sizeof(rp));
+	return cmd_complete(sk, index, MGMT_OP_READ_INFO, 0, &rp, sizeof(rp));
 }
 
 static void mgmt_pending_free(struct pending_cmd *cmd)
@@ -717,7 +718,8 @@ static int send_settings_rsp(struct sock *sk, u16 opcode, struct hci_dev *hdev)
 {
 	__le32 settings = cpu_to_le32(get_current_settings(hdev));
 
-	return cmd_complete(sk, hdev->id, opcode, &settings, sizeof(settings));
+	return cmd_complete(sk, hdev->id, opcode, 0, &settings,
+							sizeof(settings));
 }
 
 static int set_powered(struct sock *sk, u16 index, void *data, u16 len)
@@ -1124,7 +1126,7 @@ static int add_uuid(struct sock *sk, u16 index, void *data, u16 len)
 	if (err < 0)
 		goto failed;
 
-	err = cmd_complete(sk, index, MGMT_OP_ADD_UUID, NULL, 0);
+	err = cmd_complete(sk, index, MGMT_OP_ADD_UUID, 0, NULL, 0);
 
 failed:
 	hci_dev_unlock(hdev);
@@ -1185,7 +1187,7 @@ static int remove_uuid(struct sock *sk, u16 index, void *data, u16 len)
 	if (err < 0)
 		goto unlock;
 
-	err = cmd_complete(sk, index, MGMT_OP_REMOVE_UUID, NULL, 0);
+	err = cmd_complete(sk, index, MGMT_OP_REMOVE_UUID, 0, NULL, 0);
 
 unlock:
 	hci_dev_unlock(hdev);
@@ -1226,7 +1228,8 @@ static int set_dev_class(struct sock *sk, u16 index, void *data, u16 len)
 	err = update_class(hdev);
 
 	if (err == 0)
-		err = cmd_complete(sk, index, MGMT_OP_SET_DEV_CLASS, NULL, 0);
+		err = cmd_complete(sk, index, MGMT_OP_SET_DEV_CLASS, 0,
+								NULL, 0);
 
 	hci_dev_unlock(hdev);
 	hci_dev_put(hdev);
@@ -1282,7 +1285,7 @@ static int load_link_keys(struct sock *sk, u16 index, void *data, u16 len)
 						key->type, key->pin_len);
 	}
 
-	cmd_complete(sk, index, MGMT_OP_LOAD_LINK_KEYS, NULL, 0);
+	cmd_complete(sk, index, MGMT_OP_LOAD_LINK_KEYS, 0, NULL, 0);
 
 	hci_dev_unlock(hdev);
 	hci_dev_put(hdev);
@@ -1310,6 +1313,7 @@ static int unpair_device(struct sock *sk, u16 index, void *data, u16 len)
 	struct hci_cp_disconnect dc;
 	struct pending_cmd *cmd;
 	struct hci_conn *conn;
+	u8 status = 0;
 	int err;
 
 	if (len != sizeof(*cp))
@@ -1333,13 +1337,13 @@ static int unpair_device(struct sock *sk, u16 index, void *data, u16 len)
 		err = hci_remove_ltk(hdev, &cp->addr.bdaddr);
 
 	if (err < 0) {
-		rp.status = MGMT_STATUS_NOT_PAIRED;
+		status = MGMT_STATUS_NOT_PAIRED;
 		goto unlock;
 	}
 
 	if (!test_bit(HCI_UP, &hdev->flags) || !cp->disconnect) {
-		err = cmd_complete(sk, index, MGMT_OP_UNPAIR_DEVICE, &rp,
-								sizeof(rp));
+		err = cmd_complete(sk, index, MGMT_OP_UNPAIR_DEVICE, status,
+							&rp, sizeof(rp));
 		device_unpaired(hdev, &cp->addr.bdaddr, cp->addr.type, sk);
 		goto unlock;
 	}
@@ -1352,8 +1356,8 @@ static int unpair_device(struct sock *sk, u16 index, void *data, u16 len)
 							&cp->addr.bdaddr);
 
 	if (!conn) {
-		err = cmd_complete(sk, index, MGMT_OP_UNPAIR_DEVICE, &rp,
-								sizeof(rp));
+		err = cmd_complete(sk, index, MGMT_OP_UNPAIR_DEVICE, status,
+							&rp, sizeof(rp));
 		device_unpaired(hdev, &cp->addr.bdaddr, cp->addr.type, sk);
 		goto unlock;
 	}
@@ -1373,8 +1377,8 @@ static int unpair_device(struct sock *sk, u16 index, void *data, u16 len)
 
 unlock:
 	if (err < 0)
-		err = cmd_complete(sk, index, MGMT_OP_UNPAIR_DEVICE, &rp,
-								sizeof(rp));
+		err = cmd_complete(sk, index, MGMT_OP_UNPAIR_DEVICE, status,
+							&rp, sizeof(rp));
 	hci_dev_unlock(hdev);
 	hci_dev_put(hdev);
 
@@ -1512,7 +1516,7 @@ static int get_connections(struct sock *sk, u16 index)
 	/* Recalculate length in case of filtered SCO connections, etc */
 	rp_len = sizeof(*rp) + (i * sizeof(struct mgmt_addr_info));
 
-	err = cmd_complete(sk, index, MGMT_OP_GET_CONNECTIONS, rp, rp_len);
+	err = cmd_complete(sk, index, MGMT_OP_GET_CONNECTIONS, 0, rp, rp_len);
 
 unlock:
 	kfree(rp);
@@ -1672,7 +1676,7 @@ static int set_io_capability(struct sock *sk, u16 index, void *data, u16 len)
 	hci_dev_unlock(hdev);
 	hci_dev_put(hdev);
 
-	return cmd_complete(sk, index, MGMT_OP_SET_IO_CAPABILITY, NULL, 0);
+	return cmd_complete(sk, index, MGMT_OP_SET_IO_CAPABILITY, 0, NULL, 0);
 }
 
 static inline struct pending_cmd *find_pairing(struct hci_conn *conn)
@@ -1700,9 +1704,9 @@ static void pairing_complete(struct pending_cmd *cmd, u8 status)
 
 	bacpy(&rp.addr.bdaddr, &conn->dst);
 	rp.addr.type = link_to_mgmt(conn->type, conn->dst_type);
-	rp.status = status;
 
-	cmd_complete(cmd->sk, cmd->index, MGMT_OP_PAIR_DEVICE, &rp, sizeof(rp));
+	cmd_complete(cmd->sk, cmd->index, MGMT_OP_PAIR_DEVICE, status,
+							&rp, sizeof(rp));
 
 	/* So we don't get further callbacks for this connection */
 	conn->connect_cfm_cb = NULL;
@@ -1735,6 +1739,7 @@ static int pair_device(struct sock *sk, u16 index, void *data, u16 len)
 	struct pending_cmd *cmd;
 	u8 sec_level, auth_type;
 	struct hci_conn *conn;
+	u8 status = 0;
 	int err;
 
 	BT_DBG("");
@@ -1768,16 +1773,16 @@ static int pair_device(struct sock *sk, u16 index, void *data, u16 len)
 	rp.addr.type = cp->addr.type;
 
 	if (IS_ERR(conn)) {
-		rp.status = -PTR_ERR(conn);
-		err = cmd_complete(sk, index, MGMT_OP_PAIR_DEVICE,
+		status = -PTR_ERR(conn);
+		err = cmd_complete(sk, index, MGMT_OP_PAIR_DEVICE, status,
 							&rp, sizeof(rp));
 		goto unlock;
 	}
 
 	if (conn->connect_cfm_cb) {
 		hci_conn_put(conn);
-		rp.status = EBUSY;
-		err = cmd_complete(sk, index, MGMT_OP_PAIR_DEVICE,
+		status = EBUSY;
+		err = cmd_complete(sk, index, MGMT_OP_PAIR_DEVICE, status,
 							&rp, sizeof(rp));
 		goto unlock;
 	}
@@ -1850,7 +1855,7 @@ static int cancel_pair_device(struct sock *sk, u16 index,
 
 	pairing_complete(cmd, MGMT_STATUS_CANCELLED);
 
-	err = cmd_complete(sk, index, MGMT_OP_CANCEL_PAIR_DEVICE, addr,
+	err = cmd_complete(sk, index, MGMT_OP_CANCEL_PAIR_DEVICE, 0, addr,
 								sizeof(*addr));
 unlock:
 	hci_dev_unlock(hdev);
@@ -2112,8 +2117,8 @@ static int add_remote_oob_data(struct sock *sk, u16 index, void *data,
 		err = cmd_status(sk, index, MGMT_OP_ADD_REMOTE_OOB_DATA,
 							MGMT_STATUS_FAILED);
 	else
-		err = cmd_complete(sk, index, MGMT_OP_ADD_REMOTE_OOB_DATA, NULL,
-									0);
+		err = cmd_complete(sk, index, MGMT_OP_ADD_REMOTE_OOB_DATA, 0,
+								NULL, 0);
 
 	hci_dev_unlock(hdev);
 	hci_dev_put(hdev);
@@ -2147,7 +2152,7 @@ static int remove_remote_oob_data(struct sock *sk, u16 index,
 						MGMT_STATUS_INVALID_PARAMS);
 	else
 		err = cmd_complete(sk, index, MGMT_OP_REMOVE_REMOTE_OOB_DATA,
-								NULL, 0);
+								0, NULL, 0);
 
 	hci_dev_unlock(hdev);
 	hci_dev_put(hdev);
@@ -2307,7 +2312,8 @@ static int stop_discovery(struct sock *sk, u16 index)
 	e = hci_inquiry_cache_lookup_resolve(hdev, BDADDR_ANY, NAME_PENDING);
 	if (!e) {
 		mgmt_pending_remove(cmd);
-		err = cmd_complete(sk, index, MGMT_OP_STOP_DISCOVERY, NULL, 0);
+		err = cmd_complete(sk, index, MGMT_OP_STOP_DISCOVERY, 0,
+								NULL, 0);
 		hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
 		goto unlock;
 	}
@@ -2400,8 +2406,8 @@ static int block_device(struct sock *sk, u16 index, void *data, u16 len)
 		err = cmd_status(sk, index, MGMT_OP_BLOCK_DEVICE,
 							MGMT_STATUS_FAILED);
 	else
-		err = cmd_complete(sk, index, MGMT_OP_BLOCK_DEVICE,
-							NULL, 0);
+		err = cmd_complete(sk, index, MGMT_OP_BLOCK_DEVICE, 0,
+								NULL, 0);
 
 	hci_dev_unlock(hdev);
 	hci_dev_put(hdev);
@@ -2434,7 +2440,7 @@ static int unblock_device(struct sock *sk, u16 index, void *data, u16 len)
 		err = cmd_status(sk, index, MGMT_OP_UNBLOCK_DEVICE,
 						MGMT_STATUS_INVALID_PARAMS);
 	else
-		err = cmd_complete(sk, index, MGMT_OP_UNBLOCK_DEVICE,
+		err = cmd_complete(sk, index, MGMT_OP_UNBLOCK_DEVICE, 0,
 								NULL, 0);
 
 	hci_dev_unlock(hdev);
@@ -2490,8 +2496,8 @@ static int set_fast_connectable(struct sock *sk, u16 index,
 		goto done;
 	}
 
-	err = cmd_complete(sk, index, MGMT_OP_SET_FAST_CONNECTABLE,
-							NULL, 0);
+	err = cmd_complete(sk, index, MGMT_OP_SET_FAST_CONNECTABLE, 0,
+								NULL, 0);
 done:
 	hci_dev_unlock(hdev);
 	hci_dev_put(hdev);
@@ -2908,9 +2914,9 @@ static void disconnect_rsp(struct pending_cmd *cmd, void *data)
 
 	bacpy(&rp.addr.bdaddr, &cp->addr.bdaddr);
 	rp.addr.type = cp->addr.type;
-	rp.status = 0;
 
-	cmd_complete(cmd->sk, cmd->index, MGMT_OP_DISCONNECT, &rp, sizeof(rp));
+	cmd_complete(cmd->sk, cmd->index, MGMT_OP_DISCONNECT, 0, &rp,
+								sizeof(rp));
 
 	*sk = cmd->sk;
 	sock_hold(*sk);
@@ -2930,7 +2936,7 @@ static void unpair_device_rsp(struct pending_cmd *cmd, void *data)
 
 	device_unpaired(hdev, &cp->addr.bdaddr, cp->addr.type, cmd->sk);
 
-	cmd_complete(cmd->sk, cmd->index, cmd->opcode, &rp, sizeof(rp));
+	cmd_complete(cmd->sk, cmd->index, cmd->opcode, 0, &rp, sizeof(rp));
 
 	mgmt_pending_remove(cmd);
 }
@@ -2972,10 +2978,9 @@ int mgmt_disconnect_failed(struct hci_dev *hdev, bdaddr_t *bdaddr,
 
 	bacpy(&rp.addr.bdaddr, bdaddr);
 	rp.addr.type = link_to_mgmt(link_type, addr_type);
-	rp.status = mgmt_status(status);
 
 	err = cmd_complete(cmd->sk, cmd->index, MGMT_OP_DISCONNECT,
-							&rp, sizeof(rp));
+					mgmt_status(status), &rp, sizeof(rp));
 
 	mgmt_pending_remove(cmd);
 
@@ -3021,10 +3026,9 @@ int mgmt_pin_code_reply_complete(struct hci_dev *hdev, bdaddr_t *bdaddr,
 
 	bacpy(&rp.addr.bdaddr, bdaddr);
 	rp.addr.type = MGMT_ADDR_BREDR;
-	rp.status = mgmt_status(status);
 
-	err = cmd_complete(cmd->sk, hdev->id, MGMT_OP_PIN_CODE_REPLY, &rp,
-								sizeof(rp));
+	err = cmd_complete(cmd->sk, hdev->id, MGMT_OP_PIN_CODE_REPLY,
+					mgmt_status(status), &rp, sizeof(rp));
 
 	mgmt_pending_remove(cmd);
 
@@ -3044,10 +3048,9 @@ int mgmt_pin_code_neg_reply_complete(struct hci_dev *hdev, bdaddr_t *bdaddr,
 
 	bacpy(&rp.addr.bdaddr, bdaddr);
 	rp.addr.type = MGMT_ADDR_BREDR;
-	rp.status = mgmt_status(status);
 
-	err = cmd_complete(cmd->sk, hdev->id, MGMT_OP_PIN_CODE_NEG_REPLY, &rp,
-								sizeof(rp));
+	err = cmd_complete(cmd->sk, hdev->id, MGMT_OP_PIN_CODE_NEG_REPLY,
+					mgmt_status(status), &rp, sizeof(rp));
 
 	mgmt_pending_remove(cmd);
 
@@ -3099,8 +3102,8 @@ static int user_pairing_resp_complete(struct hci_dev *hdev, bdaddr_t *bdaddr,
 
 	bacpy(&rp.addr.bdaddr, bdaddr);
 	rp.addr.type = link_to_mgmt(link_type, addr_type);
-	rp.status = mgmt_status(status);
-	err = cmd_complete(cmd->sk, hdev->id, opcode, &rp, sizeof(rp));
+	err = cmd_complete(cmd->sk, hdev->id, opcode, mgmt_status(status),
+							&rp, sizeof(rp));
 
 	mgmt_pending_remove(cmd);
 
@@ -3217,7 +3220,7 @@ int mgmt_set_local_name_complete(struct hci_dev *hdev, u8 *name, u8 status)
 
 	update_eir(hdev);
 
-	err = cmd_complete(cmd->sk, hdev->id, MGMT_OP_SET_LOCAL_NAME, &ev,
+	err = cmd_complete(cmd->sk, hdev->id, MGMT_OP_SET_LOCAL_NAME, 0, &ev,
 								sizeof(ev));
 	if (err < 0)
 		goto failed;
@@ -3256,7 +3259,7 @@ int mgmt_read_local_oob_data_reply_complete(struct hci_dev *hdev, u8 *hash,
 
 		err = cmd_complete(cmd->sk, hdev->id,
 						MGMT_OP_READ_LOCAL_OOB_DATA,
-						&rp, sizeof(rp));
+						0, &rp, sizeof(rp));
 	}
 
 	mgmt_pending_remove(cmd);
@@ -3365,7 +3368,7 @@ int mgmt_discovering(struct hci_dev *hdev, u8 discovering)
 		cmd = mgmt_pending_find(MGMT_OP_STOP_DISCOVERY, hdev);
 
 	if (cmd != NULL) {
-		cmd_complete(cmd->sk, hdev->id, cmd->opcode, NULL, 0);
+		cmd_complete(cmd->sk, hdev->id, cmd->opcode, 0, NULL, 0);
 		mgmt_pending_remove(cmd);
 	}
 
-- 
1.7.9

