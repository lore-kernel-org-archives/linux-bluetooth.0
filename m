Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 5/7] Bluetooth: Rename cmd_complete() to mgmt_cmd_complete()
Date: Sun,  1 Mar 2015 09:39:04 +0200
Message-Id: <1425195546-8647-6-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1425195546-8647-1-git-send-email-johan.hedberg@gmail.com>
References: <1425195546-8647-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch renames the cmd_status() function to mgmt_cmd_complete() in
preparation of making it a generic helper for other modules to use too.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c | 445 ++++++++++++++++++++++++++-------------------------
 1 file changed, 231 insertions(+), 214 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 17807e1d6920..7281edb80e90 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -279,8 +279,8 @@ static int mgmt_cmd_status(struct sock *sk, u16 index, u16 cmd, u8 status)
 	return err;
 }
 
-static int cmd_complete(struct sock *sk, u16 index, u16 cmd, u8 status,
-			void *rp, size_t rp_len)
+static int mgmt_cmd_complete(struct sock *sk, u16 index, u16 cmd, u8 status,
+			     void *rp, size_t rp_len)
 {
 	struct sk_buff *skb;
 	struct mgmt_hdr *hdr;
@@ -323,8 +323,8 @@ static int read_version(struct sock *sk, struct hci_dev *hdev, void *data,
 	rp.version = MGMT_VERSION;
 	rp.revision = cpu_to_le16(MGMT_REVISION);
 
-	return cmd_complete(sk, MGMT_INDEX_NONE, MGMT_OP_READ_VERSION, 0, &rp,
-			    sizeof(rp));
+	return mgmt_cmd_complete(sk, MGMT_INDEX_NONE, MGMT_OP_READ_VERSION, 0,
+				 &rp, sizeof(rp));
 }
 
 static int read_commands(struct sock *sk, struct hci_dev *hdev, void *data,
@@ -354,8 +354,8 @@ static int read_commands(struct sock *sk, struct hci_dev *hdev, void *data,
 	for (i = 0; i < num_events; i++, opcode++)
 		put_unaligned_le16(mgmt_events[i], opcode);
 
-	err = cmd_complete(sk, MGMT_INDEX_NONE, MGMT_OP_READ_COMMANDS, 0, rp,
-			   rp_size);
+	err = mgmt_cmd_complete(sk, MGMT_INDEX_NONE, MGMT_OP_READ_COMMANDS, 0,
+				rp, rp_size);
 	kfree(rp);
 
 	return err;
@@ -413,8 +413,8 @@ static int read_index_list(struct sock *sk, struct hci_dev *hdev, void *data,
 
 	read_unlock(&hci_dev_list_lock);
 
-	err = cmd_complete(sk, MGMT_INDEX_NONE, MGMT_OP_READ_INDEX_LIST, 0, rp,
-			   rp_len);
+	err = mgmt_cmd_complete(sk, MGMT_INDEX_NONE, MGMT_OP_READ_INDEX_LIST,
+				0, rp, rp_len);
 
 	kfree(rp);
 
@@ -473,8 +473,8 @@ static int read_unconf_index_list(struct sock *sk, struct hci_dev *hdev,
 
 	read_unlock(&hci_dev_list_lock);
 
-	err = cmd_complete(sk, MGMT_INDEX_NONE, MGMT_OP_READ_UNCONF_INDEX_LIST,
-			   0, rp, rp_len);
+	err = mgmt_cmd_complete(sk, MGMT_INDEX_NONE,
+				MGMT_OP_READ_UNCONF_INDEX_LIST, 0, rp, rp_len);
 
 	kfree(rp);
 
@@ -521,8 +521,8 @@ static int send_options_rsp(struct sock *sk, u16 opcode, struct hci_dev *hdev)
 {
 	__le32 options = get_missing_options(hdev);
 
-	return cmd_complete(sk, hdev->id, opcode, 0, &options,
-			    sizeof(options));
+	return mgmt_cmd_complete(sk, hdev->id, opcode, 0, &options,
+				 sizeof(options));
 }
 
 static int read_config_info(struct sock *sk, struct hci_dev *hdev,
@@ -549,8 +549,8 @@ static int read_config_info(struct sock *sk, struct hci_dev *hdev,
 
 	hci_dev_unlock(hdev);
 
-	return cmd_complete(sk, hdev->id, MGMT_OP_READ_CONFIG_INFO, 0, &rp,
-			    sizeof(rp));
+	return mgmt_cmd_complete(sk, hdev->id, MGMT_OP_READ_CONFIG_INFO, 0,
+				 &rp, sizeof(rp));
 }
 
 static u32 get_supported_settings(struct hci_dev *hdev)
@@ -1186,8 +1186,8 @@ static int read_controller_info(struct sock *sk, struct hci_dev *hdev,
 
 	hci_dev_unlock(hdev);
 
-	return cmd_complete(sk, hdev->id, MGMT_OP_READ_INFO, 0, &rp,
-			    sizeof(rp));
+	return mgmt_cmd_complete(sk, hdev->id, MGMT_OP_READ_INFO, 0, &rp,
+				 sizeof(rp));
 }
 
 static void mgmt_pending_free(struct pending_cmd *cmd)
@@ -1251,8 +1251,8 @@ static int send_settings_rsp(struct sock *sk, u16 opcode, struct hci_dev *hdev)
 {
 	__le32 settings = cpu_to_le32(get_current_settings(hdev));
 
-	return cmd_complete(sk, hdev->id, opcode, 0, &settings,
-			    sizeof(settings));
+	return mgmt_cmd_complete(sk, hdev->id, opcode, 0, &settings,
+				 sizeof(settings));
 }
 
 static void clean_up_hci_complete(struct hci_dev *hdev, u8 status, u16 opcode)
@@ -1492,14 +1492,14 @@ static void cmd_complete_rsp(struct pending_cmd *cmd, void *data)
 
 static int generic_cmd_complete(struct pending_cmd *cmd, u8 status)
 {
-	return cmd_complete(cmd->sk, cmd->index, cmd->opcode, status,
-			    cmd->param, cmd->param_len);
+	return mgmt_cmd_complete(cmd->sk, cmd->index, cmd->opcode, status,
+				 cmd->param, cmd->param_len);
 }
 
 static int addr_cmd_complete(struct pending_cmd *cmd, u8 status)
 {
-	return cmd_complete(cmd->sk, cmd->index, cmd->opcode, status, cmd->param,
-			    sizeof(struct mgmt_addr_info));
+	return mgmt_cmd_complete(cmd->sk, cmd->index, cmd->opcode, status,
+				 cmd->param, sizeof(struct mgmt_addr_info));
 }
 
 static u8 mgmt_bredr_support(struct hci_dev *hdev)
@@ -2387,8 +2387,8 @@ static void mgmt_class_complete(struct hci_dev *hdev, u16 mgmt_op, u8 status)
 	if (!cmd)
 		goto unlock;
 
-	cmd_complete(cmd->sk, cmd->index, cmd->opcode, mgmt_status(status),
-		     hdev->dev_class, 3);
+	mgmt_cmd_complete(cmd->sk, cmd->index, cmd->opcode,
+			  mgmt_status(status), hdev->dev_class, 3);
 
 	mgmt_pending_remove(cmd);
 
@@ -2443,8 +2443,8 @@ static int add_uuid(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 		if (err != -ENODATA)
 			goto failed;
 
-		err = cmd_complete(sk, hdev->id, MGMT_OP_ADD_UUID, 0,
-				   hdev->dev_class, 3);
+		err = mgmt_cmd_complete(sk, hdev->id, MGMT_OP_ADD_UUID, 0,
+					hdev->dev_class, 3);
 		goto failed;
 	}
 
@@ -2506,8 +2506,9 @@ static int remove_uuid(struct sock *sk, struct hci_dev *hdev, void *data,
 		hci_uuids_clear(hdev);
 
 		if (enable_service_cache(hdev)) {
-			err = cmd_complete(sk, hdev->id, MGMT_OP_REMOVE_UUID,
-					   0, hdev->dev_class, 3);
+			err = mgmt_cmd_complete(sk, hdev->id,
+						MGMT_OP_REMOVE_UUID,
+						0, hdev->dev_class, 3);
 			goto unlock;
 		}
 
@@ -2542,8 +2543,8 @@ update_class:
 		if (err != -ENODATA)
 			goto unlock;
 
-		err = cmd_complete(sk, hdev->id, MGMT_OP_REMOVE_UUID, 0,
-				   hdev->dev_class, 3);
+		err = mgmt_cmd_complete(sk, hdev->id, MGMT_OP_REMOVE_UUID, 0,
+					hdev->dev_class, 3);
 		goto unlock;
 	}
 
@@ -2599,8 +2600,8 @@ static int set_dev_class(struct sock *sk, struct hci_dev *hdev, void *data,
 	hdev->minor_class = cp->minor;
 
 	if (!hdev_is_powered(hdev)) {
-		err = cmd_complete(sk, hdev->id, MGMT_OP_SET_DEV_CLASS, 0,
-				   hdev->dev_class, 3);
+		err = mgmt_cmd_complete(sk, hdev->id, MGMT_OP_SET_DEV_CLASS, 0,
+					hdev->dev_class, 3);
 		goto unlock;
 	}
 
@@ -2620,8 +2621,8 @@ static int set_dev_class(struct sock *sk, struct hci_dev *hdev, void *data,
 		if (err != -ENODATA)
 			goto unlock;
 
-		err = cmd_complete(sk, hdev->id, MGMT_OP_SET_DEV_CLASS, 0,
-				   hdev->dev_class, 3);
+		err = mgmt_cmd_complete(sk, hdev->id, MGMT_OP_SET_DEV_CLASS, 0,
+					hdev->dev_class, 3);
 		goto unlock;
 	}
 
@@ -2714,7 +2715,7 @@ static int load_link_keys(struct sock *sk, struct hci_dev *hdev, void *data,
 				 key->type, key->pin_len, NULL);
 	}
 
-	cmd_complete(sk, hdev->id, MGMT_OP_LOAD_LINK_KEYS, 0, NULL, 0);
+	mgmt_cmd_complete(sk, hdev->id, MGMT_OP_LOAD_LINK_KEYS, 0, NULL, 0);
 
 	hci_dev_unlock(hdev);
 
@@ -2748,20 +2749,21 @@ static int unpair_device(struct sock *sk, struct hci_dev *hdev, void *data,
 	rp.addr.type = cp->addr.type;
 
 	if (!bdaddr_type_is_valid(cp->addr.type))
-		return cmd_complete(sk, hdev->id, MGMT_OP_UNPAIR_DEVICE,
-				    MGMT_STATUS_INVALID_PARAMS,
-				    &rp, sizeof(rp));
+		return mgmt_cmd_complete(sk, hdev->id, MGMT_OP_UNPAIR_DEVICE,
+					 MGMT_STATUS_INVALID_PARAMS,
+					 &rp, sizeof(rp));
 
 	if (cp->disconnect != 0x00 && cp->disconnect != 0x01)
-		return cmd_complete(sk, hdev->id, MGMT_OP_UNPAIR_DEVICE,
-				    MGMT_STATUS_INVALID_PARAMS,
-				    &rp, sizeof(rp));
+		return mgmt_cmd_complete(sk, hdev->id, MGMT_OP_UNPAIR_DEVICE,
+					 MGMT_STATUS_INVALID_PARAMS,
+					 &rp, sizeof(rp));
 
 	hci_dev_lock(hdev);
 
 	if (!hdev_is_powered(hdev)) {
-		err = cmd_complete(sk, hdev->id, MGMT_OP_UNPAIR_DEVICE,
-				   MGMT_STATUS_NOT_POWERED, &rp, sizeof(rp));
+		err = mgmt_cmd_complete(sk, hdev->id, MGMT_OP_UNPAIR_DEVICE,
+					MGMT_STATUS_NOT_POWERED, &rp,
+					sizeof(rp));
 		goto unlock;
 	}
 
@@ -2811,8 +2813,9 @@ static int unpair_device(struct sock *sk, struct hci_dev *hdev, void *data,
 	}
 
 	if (err < 0) {
-		err = cmd_complete(sk, hdev->id, MGMT_OP_UNPAIR_DEVICE,
-				   MGMT_STATUS_NOT_PAIRED, &rp, sizeof(rp));
+		err = mgmt_cmd_complete(sk, hdev->id, MGMT_OP_UNPAIR_DEVICE,
+					MGMT_STATUS_NOT_PAIRED, &rp,
+					sizeof(rp));
 		goto unlock;
 	}
 
@@ -2820,8 +2823,8 @@ static int unpair_device(struct sock *sk, struct hci_dev *hdev, void *data,
 	 * link is requested.
 	 */
 	if (!conn) {
-		err = cmd_complete(sk, hdev->id, MGMT_OP_UNPAIR_DEVICE, 0,
-				   &rp, sizeof(rp));
+		err = mgmt_cmd_complete(sk, hdev->id, MGMT_OP_UNPAIR_DEVICE, 0,
+					&rp, sizeof(rp));
 		device_unpaired(hdev, &cp->addr.bdaddr, cp->addr.type, sk);
 		goto unlock;
 	}
@@ -2862,21 +2865,22 @@ static int disconnect(struct sock *sk, struct hci_dev *hdev, void *data,
 	rp.addr.type = cp->addr.type;
 
 	if (!bdaddr_type_is_valid(cp->addr.type))
-		return cmd_complete(sk, hdev->id, MGMT_OP_DISCONNECT,
-				    MGMT_STATUS_INVALID_PARAMS,
-				    &rp, sizeof(rp));
+		return mgmt_cmd_complete(sk, hdev->id, MGMT_OP_DISCONNECT,
+					 MGMT_STATUS_INVALID_PARAMS,
+					 &rp, sizeof(rp));
 
 	hci_dev_lock(hdev);
 
 	if (!test_bit(HCI_UP, &hdev->flags)) {
-		err = cmd_complete(sk, hdev->id, MGMT_OP_DISCONNECT,
-				   MGMT_STATUS_NOT_POWERED, &rp, sizeof(rp));
+		err = mgmt_cmd_complete(sk, hdev->id, MGMT_OP_DISCONNECT,
+					MGMT_STATUS_NOT_POWERED, &rp,
+					sizeof(rp));
 		goto failed;
 	}
 
 	if (mgmt_pending_find(MGMT_OP_DISCONNECT, hdev)) {
-		err = cmd_complete(sk, hdev->id, MGMT_OP_DISCONNECT,
-				   MGMT_STATUS_BUSY, &rp, sizeof(rp));
+		err = mgmt_cmd_complete(sk, hdev->id, MGMT_OP_DISCONNECT,
+					MGMT_STATUS_BUSY, &rp, sizeof(rp));
 		goto failed;
 	}
 
@@ -2887,8 +2891,9 @@ static int disconnect(struct sock *sk, struct hci_dev *hdev, void *data,
 		conn = hci_conn_hash_lookup_ba(hdev, LE_LINK, &cp->addr.bdaddr);
 
 	if (!conn || conn->state == BT_OPEN || conn->state == BT_CLOSED) {
-		err = cmd_complete(sk, hdev->id, MGMT_OP_DISCONNECT,
-				   MGMT_STATUS_NOT_CONNECTED, &rp, sizeof(rp));
+		err = mgmt_cmd_complete(sk, hdev->id, MGMT_OP_DISCONNECT,
+					MGMT_STATUS_NOT_CONNECTED, &rp,
+					sizeof(rp));
 		goto failed;
 	}
 
@@ -2976,8 +2981,8 @@ static int get_connections(struct sock *sk, struct hci_dev *hdev, void *data,
 	/* Recalculate length in case of filtered SCO connections, etc */
 	rp_len = sizeof(*rp) + (i * sizeof(struct mgmt_addr_info));
 
-	err = cmd_complete(sk, hdev->id, MGMT_OP_GET_CONNECTIONS, 0, rp,
-			   rp_len);
+	err = mgmt_cmd_complete(sk, hdev->id, MGMT_OP_GET_CONNECTIONS, 0, rp,
+				rp_len);
 
 	kfree(rp);
 
@@ -3075,8 +3080,8 @@ static int set_io_capability(struct sock *sk, struct hci_dev *hdev, void *data,
 	BT_DBG("");
 
 	if (cp->io_capability > SMP_IO_KEYBOARD_DISPLAY)
-		return cmd_complete(sk, hdev->id, MGMT_OP_SET_IO_CAPABILITY,
-				    MGMT_STATUS_INVALID_PARAMS, NULL, 0);
+		return mgmt_cmd_complete(sk, hdev->id, MGMT_OP_SET_IO_CAPABILITY,
+					 MGMT_STATUS_INVALID_PARAMS, NULL, 0);
 
 	hci_dev_lock(hdev);
 
@@ -3087,8 +3092,8 @@ static int set_io_capability(struct sock *sk, struct hci_dev *hdev, void *data,
 
 	hci_dev_unlock(hdev);
 
-	return cmd_complete(sk, hdev->id, MGMT_OP_SET_IO_CAPABILITY, 0, NULL,
-			    0);
+	return mgmt_cmd_complete(sk, hdev->id, MGMT_OP_SET_IO_CAPABILITY, 0,
+				 NULL, 0);
 }
 
 static struct pending_cmd *find_pairing(struct hci_conn *conn)
@@ -3118,8 +3123,8 @@ static int pairing_complete(struct pending_cmd *cmd, u8 status)
 	bacpy(&rp.addr.bdaddr, &conn->dst);
 	rp.addr.type = link_to_bdaddr(conn->type, conn->dst_type);
 
-	err = cmd_complete(cmd->sk, cmd->index, MGMT_OP_PAIR_DEVICE, status,
-			   &rp, sizeof(rp));
+	err = mgmt_cmd_complete(cmd->sk, cmd->index, MGMT_OP_PAIR_DEVICE,
+				status, &rp, sizeof(rp));
 
 	/* So we don't get further callbacks for this connection */
 	conn->connect_cfm_cb = NULL;
@@ -3202,20 +3207,21 @@ static int pair_device(struct sock *sk, struct hci_dev *hdev, void *data,
 	rp.addr.type = cp->addr.type;
 
 	if (!bdaddr_type_is_valid(cp->addr.type))
-		return cmd_complete(sk, hdev->id, MGMT_OP_PAIR_DEVICE,
-				    MGMT_STATUS_INVALID_PARAMS,
-				    &rp, sizeof(rp));
+		return mgmt_cmd_complete(sk, hdev->id, MGMT_OP_PAIR_DEVICE,
+					 MGMT_STATUS_INVALID_PARAMS,
+					 &rp, sizeof(rp));
 
 	if (cp->io_cap > SMP_IO_KEYBOARD_DISPLAY)
-		return cmd_complete(sk, hdev->id, MGMT_OP_PAIR_DEVICE,
-				    MGMT_STATUS_INVALID_PARAMS,
-				    &rp, sizeof(rp));
+		return mgmt_cmd_complete(sk, hdev->id, MGMT_OP_PAIR_DEVICE,
+					 MGMT_STATUS_INVALID_PARAMS,
+					 &rp, sizeof(rp));
 
 	hci_dev_lock(hdev);
 
 	if (!hdev_is_powered(hdev)) {
-		err = cmd_complete(sk, hdev->id, MGMT_OP_PAIR_DEVICE,
-				   MGMT_STATUS_NOT_POWERED, &rp, sizeof(rp));
+		err = mgmt_cmd_complete(sk, hdev->id, MGMT_OP_PAIR_DEVICE,
+					MGMT_STATUS_NOT_POWERED, &rp,
+					sizeof(rp));
 		goto unlock;
 	}
 
@@ -3263,16 +3269,15 @@ static int pair_device(struct sock *sk, struct hci_dev *hdev, void *data,
 		else
 			status = MGMT_STATUS_CONNECT_FAILED;
 
-		err = cmd_complete(sk, hdev->id, MGMT_OP_PAIR_DEVICE,
-				   status, &rp,
-				   sizeof(rp));
+		err = mgmt_cmd_complete(sk, hdev->id, MGMT_OP_PAIR_DEVICE,
+					status, &rp, sizeof(rp));
 		goto unlock;
 	}
 
 	if (conn->connect_cfm_cb) {
 		hci_conn_drop(conn);
-		err = cmd_complete(sk, hdev->id, MGMT_OP_PAIR_DEVICE,
-				   MGMT_STATUS_BUSY, &rp, sizeof(rp));
+		err = mgmt_cmd_complete(sk, hdev->id, MGMT_OP_PAIR_DEVICE,
+					MGMT_STATUS_BUSY, &rp, sizeof(rp));
 		goto unlock;
 	}
 
@@ -3348,8 +3353,8 @@ static int cancel_pair_device(struct sock *sk, struct hci_dev *hdev, void *data,
 	cmd->cmd_complete(cmd, MGMT_STATUS_CANCELLED);
 	mgmt_pending_remove(cmd);
 
-	err = cmd_complete(sk, hdev->id, MGMT_OP_CANCEL_PAIR_DEVICE, 0,
-			   addr, sizeof(*addr));
+	err = mgmt_cmd_complete(sk, hdev->id, MGMT_OP_CANCEL_PAIR_DEVICE, 0,
+				addr, sizeof(*addr));
 unlock:
 	hci_dev_unlock(hdev);
 	return err;
@@ -3366,9 +3371,9 @@ static int user_pairing_resp(struct sock *sk, struct hci_dev *hdev,
 	hci_dev_lock(hdev);
 
 	if (!hdev_is_powered(hdev)) {
-		err = cmd_complete(sk, hdev->id, mgmt_op,
-				   MGMT_STATUS_NOT_POWERED, addr,
-				   sizeof(*addr));
+		err = mgmt_cmd_complete(sk, hdev->id, mgmt_op,
+					MGMT_STATUS_NOT_POWERED, addr,
+					sizeof(*addr));
 		goto done;
 	}
 
@@ -3378,22 +3383,22 @@ static int user_pairing_resp(struct sock *sk, struct hci_dev *hdev,
 		conn = hci_conn_hash_lookup_ba(hdev, LE_LINK, &addr->bdaddr);
 
 	if (!conn) {
-		err = cmd_complete(sk, hdev->id, mgmt_op,
-				   MGMT_STATUS_NOT_CONNECTED, addr,
-				   sizeof(*addr));
+		err = mgmt_cmd_complete(sk, hdev->id, mgmt_op,
+					MGMT_STATUS_NOT_CONNECTED, addr,
+					sizeof(*addr));
 		goto done;
 	}
 
 	if (addr->type == BDADDR_LE_PUBLIC || addr->type == BDADDR_LE_RANDOM) {
 		err = smp_user_confirm_reply(conn, mgmt_op, passkey);
 		if (!err)
-			err = cmd_complete(sk, hdev->id, mgmt_op,
-					   MGMT_STATUS_SUCCESS, addr,
-					   sizeof(*addr));
+			err = mgmt_cmd_complete(sk, hdev->id, mgmt_op,
+						MGMT_STATUS_SUCCESS, addr,
+						sizeof(*addr));
 		else
-			err = cmd_complete(sk, hdev->id, mgmt_op,
-					   MGMT_STATUS_FAILED, addr,
-					   sizeof(*addr));
+			err = mgmt_cmd_complete(sk, hdev->id, mgmt_op,
+						MGMT_STATUS_FAILED, addr,
+						sizeof(*addr));
 
 		goto done;
 	}
@@ -3518,8 +3523,8 @@ static void set_name_complete(struct hci_dev *hdev, u8 status, u16 opcode)
 		mgmt_cmd_status(cmd->sk, hdev->id, MGMT_OP_SET_LOCAL_NAME,
 			        mgmt_status(status));
 	else
-		cmd_complete(cmd->sk, hdev->id, MGMT_OP_SET_LOCAL_NAME, 0,
-			     cp, sizeof(*cp));
+		mgmt_cmd_complete(cmd->sk, hdev->id, MGMT_OP_SET_LOCAL_NAME, 0,
+				  cp, sizeof(*cp));
 
 	mgmt_pending_remove(cmd);
 
@@ -3545,8 +3550,8 @@ static int set_local_name(struct sock *sk, struct hci_dev *hdev, void *data,
 	if (!memcmp(hdev->dev_name, cp->name, sizeof(hdev->dev_name)) &&
 	    !memcmp(hdev->short_name, cp->short_name,
 		    sizeof(hdev->short_name))) {
-		err = cmd_complete(sk, hdev->id, MGMT_OP_SET_LOCAL_NAME, 0,
-				   data, len);
+		err = mgmt_cmd_complete(sk, hdev->id, MGMT_OP_SET_LOCAL_NAME, 0,
+					data, len);
 		goto failed;
 	}
 
@@ -3555,8 +3560,8 @@ static int set_local_name(struct sock *sk, struct hci_dev *hdev, void *data,
 	if (!hdev_is_powered(hdev)) {
 		memcpy(hdev->dev_name, cp->name, sizeof(hdev->dev_name));
 
-		err = cmd_complete(sk, hdev->id, MGMT_OP_SET_LOCAL_NAME, 0,
-				   data, len);
+		err = mgmt_cmd_complete(sk, hdev->id, MGMT_OP_SET_LOCAL_NAME, 0,
+					data, len);
 		if (err < 0)
 			goto failed;
 
@@ -3653,9 +3658,10 @@ static int add_remote_oob_data(struct sock *sk, struct hci_dev *hdev,
 	BT_DBG("%s ", hdev->name);
 
 	if (!bdaddr_type_is_valid(addr->type))
-		return cmd_complete(sk, hdev->id, MGMT_OP_ADD_REMOTE_OOB_DATA,
-				    MGMT_STATUS_INVALID_PARAMS, addr,
-				    sizeof(*addr));
+		return mgmt_cmd_complete(sk, hdev->id,
+					 MGMT_OP_ADD_REMOTE_OOB_DATA,
+					 MGMT_STATUS_INVALID_PARAMS,
+					 addr, sizeof(*addr));
 
 	hci_dev_lock(hdev);
 
@@ -3664,10 +3670,10 @@ static int add_remote_oob_data(struct sock *sk, struct hci_dev *hdev,
 		u8 status;
 
 		if (cp->addr.type != BDADDR_BREDR) {
-			err = cmd_complete(sk, hdev->id,
-					   MGMT_OP_ADD_REMOTE_OOB_DATA,
-					   MGMT_STATUS_INVALID_PARAMS,
-					   &cp->addr, sizeof(cp->addr));
+			err = mgmt_cmd_complete(sk, hdev->id,
+						MGMT_OP_ADD_REMOTE_OOB_DATA,
+						MGMT_STATUS_INVALID_PARAMS,
+						&cp->addr, sizeof(cp->addr));
 			goto unlock;
 		}
 
@@ -3679,8 +3685,9 @@ static int add_remote_oob_data(struct sock *sk, struct hci_dev *hdev,
 		else
 			status = MGMT_STATUS_SUCCESS;
 
-		err = cmd_complete(sk, hdev->id, MGMT_OP_ADD_REMOTE_OOB_DATA,
-				   status, &cp->addr, sizeof(cp->addr));
+		err = mgmt_cmd_complete(sk, hdev->id,
+					MGMT_OP_ADD_REMOTE_OOB_DATA, status,
+					&cp->addr, sizeof(cp->addr));
 	} else if (len == MGMT_ADD_REMOTE_OOB_EXT_DATA_SIZE) {
 		struct mgmt_cp_add_remote_oob_ext_data *cp = data;
 		u8 *rand192, *hash192, *rand256, *hash256;
@@ -3692,10 +3699,10 @@ static int add_remote_oob_data(struct sock *sk, struct hci_dev *hdev,
 			 */
 			if (memcmp(cp->rand192, ZERO_KEY, 16) ||
 			    memcmp(cp->hash192, ZERO_KEY, 16)) {
-				err = cmd_complete(sk, hdev->id,
-						   MGMT_OP_ADD_REMOTE_OOB_DATA,
-						   MGMT_STATUS_INVALID_PARAMS,
-						   addr, sizeof(*addr));
+				err = mgmt_cmd_complete(sk, hdev->id,
+							MGMT_OP_ADD_REMOTE_OOB_DATA,
+							MGMT_STATUS_INVALID_PARAMS,
+							addr, sizeof(*addr));
 				goto unlock;
 			}
 
@@ -3735,8 +3742,9 @@ static int add_remote_oob_data(struct sock *sk, struct hci_dev *hdev,
 		else
 			status = MGMT_STATUS_SUCCESS;
 
-		err = cmd_complete(sk, hdev->id, MGMT_OP_ADD_REMOTE_OOB_DATA,
-				   status, &cp->addr, sizeof(cp->addr));
+		err = mgmt_cmd_complete(sk, hdev->id,
+					MGMT_OP_ADD_REMOTE_OOB_DATA,
+					status, &cp->addr, sizeof(cp->addr));
 	} else {
 		BT_ERR("add_remote_oob_data: invalid length of %u bytes", len);
 		err = mgmt_cmd_status(sk, hdev->id, MGMT_OP_ADD_REMOTE_OOB_DATA,
@@ -3758,9 +3766,10 @@ static int remove_remote_oob_data(struct sock *sk, struct hci_dev *hdev,
 	BT_DBG("%s", hdev->name);
 
 	if (cp->addr.type != BDADDR_BREDR)
-		return cmd_complete(sk, hdev->id, MGMT_OP_REMOVE_REMOTE_OOB_DATA,
-				    MGMT_STATUS_INVALID_PARAMS,
-				    &cp->addr, sizeof(cp->addr));
+		return mgmt_cmd_complete(sk, hdev->id,
+					 MGMT_OP_REMOVE_REMOTE_OOB_DATA,
+					 MGMT_STATUS_INVALID_PARAMS,
+					 &cp->addr, sizeof(cp->addr));
 
 	hci_dev_lock(hdev);
 
@@ -3777,8 +3786,8 @@ static int remove_remote_oob_data(struct sock *sk, struct hci_dev *hdev,
 		status = MGMT_STATUS_SUCCESS;
 
 done:
-	err = cmd_complete(sk, hdev->id, MGMT_OP_REMOVE_REMOTE_OOB_DATA,
-			   status, &cp->addr, sizeof(cp->addr));
+	err = mgmt_cmd_complete(sk, hdev->id, MGMT_OP_REMOVE_REMOTE_OOB_DATA,
+				status, &cp->addr, sizeof(cp->addr));
 
 	hci_dev_unlock(hdev);
 	return err;
@@ -3962,17 +3971,17 @@ static int start_discovery(struct sock *sk, struct hci_dev *hdev,
 	hci_dev_lock(hdev);
 
 	if (!hdev_is_powered(hdev)) {
-		err = cmd_complete(sk, hdev->id, MGMT_OP_START_DISCOVERY,
-				   MGMT_STATUS_NOT_POWERED,
-				   &cp->type, sizeof(cp->type));
+		err = mgmt_cmd_complete(sk, hdev->id, MGMT_OP_START_DISCOVERY,
+					MGMT_STATUS_NOT_POWERED,
+					&cp->type, sizeof(cp->type));
 		goto failed;
 	}
 
 	if (hdev->discovery.state != DISCOVERY_STOPPED ||
 	    test_bit(HCI_PERIODIC_INQ, &hdev->dev_flags)) {
-		err = cmd_complete(sk, hdev->id, MGMT_OP_START_DISCOVERY,
-				   MGMT_STATUS_BUSY, &cp->type,
-				   sizeof(cp->type));
+		err = mgmt_cmd_complete(sk, hdev->id, MGMT_OP_START_DISCOVERY,
+					MGMT_STATUS_BUSY, &cp->type,
+					sizeof(cp->type));
 		goto failed;
 	}
 
@@ -3995,8 +4004,8 @@ static int start_discovery(struct sock *sk, struct hci_dev *hdev,
 	hci_req_init(&req, hdev);
 
 	if (!trigger_discovery(&req, &status)) {
-		err = cmd_complete(sk, hdev->id, MGMT_OP_START_DISCOVERY,
-				   status, &cp->type, sizeof(cp->type));
+		err = mgmt_cmd_complete(sk, hdev->id, MGMT_OP_START_DISCOVERY,
+					status, &cp->type, sizeof(cp->type));
 		mgmt_pending_remove(cmd);
 		goto failed;
 	}
@@ -4016,8 +4025,8 @@ failed:
 
 static int service_discovery_cmd_complete(struct pending_cmd *cmd, u8 status)
 {
-	return cmd_complete(cmd->sk, cmd->index, cmd->opcode, status,
-			    cmd->param, 1);
+	return mgmt_cmd_complete(cmd->sk, cmd->index, cmd->opcode, status,
+				 cmd->param, 1);
 }
 
 static int start_service_discovery(struct sock *sk, struct hci_dev *hdev,
@@ -4036,19 +4045,19 @@ static int start_service_discovery(struct sock *sk, struct hci_dev *hdev,
 	hci_dev_lock(hdev);
 
 	if (!hdev_is_powered(hdev)) {
-		err = cmd_complete(sk, hdev->id,
-				   MGMT_OP_START_SERVICE_DISCOVERY,
-				   MGMT_STATUS_NOT_POWERED,
-				   &cp->type, sizeof(cp->type));
+		err = mgmt_cmd_complete(sk, hdev->id,
+					MGMT_OP_START_SERVICE_DISCOVERY,
+					MGMT_STATUS_NOT_POWERED,
+					&cp->type, sizeof(cp->type));
 		goto failed;
 	}
 
 	if (hdev->discovery.state != DISCOVERY_STOPPED ||
 	    test_bit(HCI_PERIODIC_INQ, &hdev->dev_flags)) {
-		err = cmd_complete(sk, hdev->id,
-				   MGMT_OP_START_SERVICE_DISCOVERY,
-				   MGMT_STATUS_BUSY, &cp->type,
-				   sizeof(cp->type));
+		err = mgmt_cmd_complete(sk, hdev->id,
+					MGMT_OP_START_SERVICE_DISCOVERY,
+					MGMT_STATUS_BUSY, &cp->type,
+					sizeof(cp->type));
 		goto failed;
 	}
 
@@ -4056,10 +4065,10 @@ static int start_service_discovery(struct sock *sk, struct hci_dev *hdev,
 	if (uuid_count > max_uuid_count) {
 		BT_ERR("service_discovery: too big uuid_count value %u",
 		       uuid_count);
-		err = cmd_complete(sk, hdev->id,
-				   MGMT_OP_START_SERVICE_DISCOVERY,
-				   MGMT_STATUS_INVALID_PARAMS, &cp->type,
-				   sizeof(cp->type));
+		err = mgmt_cmd_complete(sk, hdev->id,
+					MGMT_OP_START_SERVICE_DISCOVERY,
+					MGMT_STATUS_INVALID_PARAMS, &cp->type,
+					sizeof(cp->type));
 		goto failed;
 	}
 
@@ -4067,10 +4076,10 @@ static int start_service_discovery(struct sock *sk, struct hci_dev *hdev,
 	if (expected_len != len) {
 		BT_ERR("service_discovery: expected %u bytes, got %u bytes",
 		       expected_len, len);
-		err = cmd_complete(sk, hdev->id,
-				   MGMT_OP_START_SERVICE_DISCOVERY,
-				   MGMT_STATUS_INVALID_PARAMS, &cp->type,
-				   sizeof(cp->type));
+		err = mgmt_cmd_complete(sk, hdev->id,
+					MGMT_OP_START_SERVICE_DISCOVERY,
+					MGMT_STATUS_INVALID_PARAMS, &cp->type,
+					sizeof(cp->type));
 		goto failed;
 	}
 
@@ -4096,10 +4105,10 @@ static int start_service_discovery(struct sock *sk, struct hci_dev *hdev,
 		hdev->discovery.uuids = kmemdup(cp->uuids, uuid_count * 16,
 						GFP_KERNEL);
 		if (!hdev->discovery.uuids) {
-			err = cmd_complete(sk, hdev->id,
-					   MGMT_OP_START_SERVICE_DISCOVERY,
-					   MGMT_STATUS_FAILED,
-					   &cp->type, sizeof(cp->type));
+			err = mgmt_cmd_complete(sk, hdev->id,
+						MGMT_OP_START_SERVICE_DISCOVERY,
+						MGMT_STATUS_FAILED,
+						&cp->type, sizeof(cp->type));
 			mgmt_pending_remove(cmd);
 			goto failed;
 		}
@@ -4108,9 +4117,9 @@ static int start_service_discovery(struct sock *sk, struct hci_dev *hdev,
 	hci_req_init(&req, hdev);
 
 	if (!trigger_discovery(&req, &status)) {
-		err = cmd_complete(sk, hdev->id,
-				   MGMT_OP_START_SERVICE_DISCOVERY,
-				   status, &cp->type, sizeof(cp->type));
+		err = mgmt_cmd_complete(sk, hdev->id,
+					MGMT_OP_START_SERVICE_DISCOVERY,
+					status, &cp->type, sizeof(cp->type));
 		mgmt_pending_remove(cmd);
 		goto failed;
 	}
@@ -4161,16 +4170,16 @@ static int stop_discovery(struct sock *sk, struct hci_dev *hdev, void *data,
 	hci_dev_lock(hdev);
 
 	if (!hci_discovery_active(hdev)) {
-		err = cmd_complete(sk, hdev->id, MGMT_OP_STOP_DISCOVERY,
-				   MGMT_STATUS_REJECTED, &mgmt_cp->type,
-				   sizeof(mgmt_cp->type));
+		err = mgmt_cmd_complete(sk, hdev->id, MGMT_OP_STOP_DISCOVERY,
+					MGMT_STATUS_REJECTED, &mgmt_cp->type,
+					sizeof(mgmt_cp->type));
 		goto unlock;
 	}
 
 	if (hdev->discovery.type != mgmt_cp->type) {
-		err = cmd_complete(sk, hdev->id, MGMT_OP_STOP_DISCOVERY,
-				   MGMT_STATUS_INVALID_PARAMS, &mgmt_cp->type,
-				   sizeof(mgmt_cp->type));
+		err = mgmt_cmd_complete(sk, hdev->id, MGMT_OP_STOP_DISCOVERY,
+					MGMT_STATUS_INVALID_PARAMS,
+					&mgmt_cp->type, sizeof(mgmt_cp->type));
 		goto unlock;
 	}
 
@@ -4196,8 +4205,8 @@ static int stop_discovery(struct sock *sk, struct hci_dev *hdev, void *data,
 
 	/* If no HCI commands were sent we're done */
 	if (err == -ENODATA) {
-		err = cmd_complete(sk, hdev->id, MGMT_OP_STOP_DISCOVERY, 0,
-				   &mgmt_cp->type, sizeof(mgmt_cp->type));
+		err = mgmt_cmd_complete(sk, hdev->id, MGMT_OP_STOP_DISCOVERY, 0,
+					&mgmt_cp->type, sizeof(mgmt_cp->type));
 		hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
 	}
 
@@ -4218,17 +4227,17 @@ static int confirm_name(struct sock *sk, struct hci_dev *hdev, void *data,
 	hci_dev_lock(hdev);
 
 	if (!hci_discovery_active(hdev)) {
-		err = cmd_complete(sk, hdev->id, MGMT_OP_CONFIRM_NAME,
-				   MGMT_STATUS_FAILED, &cp->addr,
-				   sizeof(cp->addr));
+		err = mgmt_cmd_complete(sk, hdev->id, MGMT_OP_CONFIRM_NAME,
+					MGMT_STATUS_FAILED, &cp->addr,
+					sizeof(cp->addr));
 		goto failed;
 	}
 
 	e = hci_inquiry_cache_lookup_unknown(hdev, &cp->addr.bdaddr);
 	if (!e) {
-		err = cmd_complete(sk, hdev->id, MGMT_OP_CONFIRM_NAME,
-				   MGMT_STATUS_INVALID_PARAMS, &cp->addr,
-				   sizeof(cp->addr));
+		err = mgmt_cmd_complete(sk, hdev->id, MGMT_OP_CONFIRM_NAME,
+					MGMT_STATUS_INVALID_PARAMS, &cp->addr,
+					sizeof(cp->addr));
 		goto failed;
 	}
 
@@ -4240,8 +4249,8 @@ static int confirm_name(struct sock *sk, struct hci_dev *hdev, void *data,
 		hci_inquiry_cache_update_resolve(hdev, e);
 	}
 
-	err = cmd_complete(sk, hdev->id, MGMT_OP_CONFIRM_NAME, 0, &cp->addr,
-			   sizeof(cp->addr));
+	err = mgmt_cmd_complete(sk, hdev->id, MGMT_OP_CONFIRM_NAME, 0,
+				&cp->addr, sizeof(cp->addr));
 
 failed:
 	hci_dev_unlock(hdev);
@@ -4258,9 +4267,9 @@ static int block_device(struct sock *sk, struct hci_dev *hdev, void *data,
 	BT_DBG("%s", hdev->name);
 
 	if (!bdaddr_type_is_valid(cp->addr.type))
-		return cmd_complete(sk, hdev->id, MGMT_OP_BLOCK_DEVICE,
-				    MGMT_STATUS_INVALID_PARAMS,
-				    &cp->addr, sizeof(cp->addr));
+		return mgmt_cmd_complete(sk, hdev->id, MGMT_OP_BLOCK_DEVICE,
+					 MGMT_STATUS_INVALID_PARAMS,
+					 &cp->addr, sizeof(cp->addr));
 
 	hci_dev_lock(hdev);
 
@@ -4276,8 +4285,8 @@ static int block_device(struct sock *sk, struct hci_dev *hdev, void *data,
 	status = MGMT_STATUS_SUCCESS;
 
 done:
-	err = cmd_complete(sk, hdev->id, MGMT_OP_BLOCK_DEVICE, status,
-			   &cp->addr, sizeof(cp->addr));
+	err = mgmt_cmd_complete(sk, hdev->id, MGMT_OP_BLOCK_DEVICE, status,
+				&cp->addr, sizeof(cp->addr));
 
 	hci_dev_unlock(hdev);
 
@@ -4294,9 +4303,9 @@ static int unblock_device(struct sock *sk, struct hci_dev *hdev, void *data,
 	BT_DBG("%s", hdev->name);
 
 	if (!bdaddr_type_is_valid(cp->addr.type))
-		return cmd_complete(sk, hdev->id, MGMT_OP_UNBLOCK_DEVICE,
-				    MGMT_STATUS_INVALID_PARAMS,
-				    &cp->addr, sizeof(cp->addr));
+		return mgmt_cmd_complete(sk, hdev->id, MGMT_OP_UNBLOCK_DEVICE,
+					 MGMT_STATUS_INVALID_PARAMS,
+					 &cp->addr, sizeof(cp->addr));
 
 	hci_dev_lock(hdev);
 
@@ -4312,8 +4321,8 @@ static int unblock_device(struct sock *sk, struct hci_dev *hdev, void *data,
 	status = MGMT_STATUS_SUCCESS;
 
 done:
-	err = cmd_complete(sk, hdev->id, MGMT_OP_UNBLOCK_DEVICE, status,
-			   &cp->addr, sizeof(cp->addr));
+	err = mgmt_cmd_complete(sk, hdev->id, MGMT_OP_UNBLOCK_DEVICE, status,
+				&cp->addr, sizeof(cp->addr));
 
 	hci_dev_unlock(hdev);
 
@@ -4343,7 +4352,8 @@ static int set_device_id(struct sock *sk, struct hci_dev *hdev, void *data,
 	hdev->devid_product = __le16_to_cpu(cp->product);
 	hdev->devid_version = __le16_to_cpu(cp->version);
 
-	err = cmd_complete(sk, hdev->id, MGMT_OP_SET_DEVICE_ID, 0, NULL, 0);
+	err = mgmt_cmd_complete(sk, hdev->id, MGMT_OP_SET_DEVICE_ID, 0,
+				NULL, 0);
 
 	hci_req_init(&req, hdev);
 	update_eir(&req);
@@ -4499,7 +4509,8 @@ static int set_static_address(struct sock *sk, struct hci_dev *hdev,
 
 	bacpy(&hdev->static_addr, &cp->bdaddr);
 
-	err = cmd_complete(sk, hdev->id, MGMT_OP_SET_STATIC_ADDRESS, 0, NULL, 0);
+	err = mgmt_cmd_complete(sk, hdev->id, MGMT_OP_SET_STATIC_ADDRESS, 0,
+				NULL, 0);
 
 	hci_dev_unlock(hdev);
 
@@ -4540,7 +4551,8 @@ static int set_scan_params(struct sock *sk, struct hci_dev *hdev,
 	hdev->le_scan_interval = interval;
 	hdev->le_scan_window = window;
 
-	err = cmd_complete(sk, hdev->id, MGMT_OP_SET_SCAN_PARAMS, 0, NULL, 0);
+	err = mgmt_cmd_complete(sk, hdev->id, MGMT_OP_SET_SCAN_PARAMS, 0,
+				NULL, 0);
 
 	/* If background scan is running, restart it so new parameters are
 	 * loaded.
@@ -5112,7 +5124,7 @@ static int load_irks(struct sock *sk, struct hci_dev *hdev, void *cp_data,
 
 	set_bit(HCI_RPA_RESOLVING, &hdev->dev_flags);
 
-	err = cmd_complete(sk, hdev->id, MGMT_OP_LOAD_IRKS, 0, NULL, 0);
+	err = mgmt_cmd_complete(sk, hdev->id, MGMT_OP_LOAD_IRKS, 0, NULL, 0);
 
 	hci_dev_unlock(hdev);
 
@@ -5222,7 +5234,7 @@ static int load_long_term_keys(struct sock *sk, struct hci_dev *hdev,
 			    key->rand);
 	}
 
-	err = cmd_complete(sk, hdev->id, MGMT_OP_LOAD_LONG_TERM_KEYS, 0,
+	err = mgmt_cmd_complete(sk, hdev->id, MGMT_OP_LOAD_LONG_TERM_KEYS, 0,
 			   NULL, 0);
 
 	hci_dev_unlock(hdev);
@@ -5248,8 +5260,8 @@ static int conn_info_cmd_complete(struct pending_cmd *cmd, u8 status)
 		rp.max_tx_power = HCI_TX_POWER_INVALID;
 	}
 
-	err = cmd_complete(cmd->sk, cmd->index, MGMT_OP_GET_CONN_INFO, status,
-			   &rp, sizeof(rp));
+	err = mgmt_cmd_complete(cmd->sk, cmd->index, MGMT_OP_GET_CONN_INFO,
+				status, &rp, sizeof(rp));
 
 	hci_conn_drop(conn);
 	hci_conn_put(conn);
@@ -5326,15 +5338,16 @@ static int get_conn_info(struct sock *sk, struct hci_dev *hdev, void *data,
 	rp.addr.type = cp->addr.type;
 
 	if (!bdaddr_type_is_valid(cp->addr.type))
-		return cmd_complete(sk, hdev->id, MGMT_OP_GET_CONN_INFO,
-				    MGMT_STATUS_INVALID_PARAMS,
-				    &rp, sizeof(rp));
+		return mgmt_cmd_complete(sk, hdev->id, MGMT_OP_GET_CONN_INFO,
+					 MGMT_STATUS_INVALID_PARAMS,
+					 &rp, sizeof(rp));
 
 	hci_dev_lock(hdev);
 
 	if (!hdev_is_powered(hdev)) {
-		err = cmd_complete(sk, hdev->id, MGMT_OP_GET_CONN_INFO,
-				   MGMT_STATUS_NOT_POWERED, &rp, sizeof(rp));
+		err = mgmt_cmd_complete(sk, hdev->id, MGMT_OP_GET_CONN_INFO,
+					MGMT_STATUS_NOT_POWERED, &rp,
+					sizeof(rp));
 		goto unlock;
 	}
 
@@ -5345,14 +5358,15 @@ static int get_conn_info(struct sock *sk, struct hci_dev *hdev, void *data,
 		conn = hci_conn_hash_lookup_ba(hdev, LE_LINK, &cp->addr.bdaddr);
 
 	if (!conn || conn->state != BT_CONNECTED) {
-		err = cmd_complete(sk, hdev->id, MGMT_OP_GET_CONN_INFO,
-				   MGMT_STATUS_NOT_CONNECTED, &rp, sizeof(rp));
+		err = mgmt_cmd_complete(sk, hdev->id, MGMT_OP_GET_CONN_INFO,
+					MGMT_STATUS_NOT_CONNECTED, &rp,
+					sizeof(rp));
 		goto unlock;
 	}
 
 	if (mgmt_pending_find_data(MGMT_OP_GET_CONN_INFO, hdev, conn)) {
-		err = cmd_complete(sk, hdev->id, MGMT_OP_GET_CONN_INFO,
-				   MGMT_STATUS_BUSY, &rp, sizeof(rp));
+		err = mgmt_cmd_complete(sk, hdev->id, MGMT_OP_GET_CONN_INFO,
+					MGMT_STATUS_BUSY, &rp, sizeof(rp));
 		goto unlock;
 	}
 
@@ -5420,8 +5434,8 @@ static int get_conn_info(struct sock *sk, struct hci_dev *hdev, void *data,
 		rp.tx_power = conn->tx_power;
 		rp.max_tx_power = conn->max_tx_power;
 
-		err = cmd_complete(sk, hdev->id, MGMT_OP_GET_CONN_INFO,
-				   MGMT_STATUS_SUCCESS, &rp, sizeof(rp));
+		err = mgmt_cmd_complete(sk, hdev->id, MGMT_OP_GET_CONN_INFO,
+					MGMT_STATUS_SUCCESS, &rp, sizeof(rp));
 	}
 
 unlock:
@@ -5454,8 +5468,8 @@ static int clock_info_cmd_complete(struct pending_cmd *cmd, u8 status)
 	}
 
 complete:
-	err = cmd_complete(cmd->sk, cmd->index, cmd->opcode, status, &rp,
-			   sizeof(rp));
+	err = mgmt_cmd_complete(cmd->sk, cmd->index, cmd->opcode, status, &rp,
+				sizeof(rp));
 
 	if (conn) {
 		hci_conn_drop(conn);
@@ -5515,15 +5529,16 @@ static int get_clock_info(struct sock *sk, struct hci_dev *hdev, void *data,
 	rp.addr.type = cp->addr.type;
 
 	if (cp->addr.type != BDADDR_BREDR)
-		return cmd_complete(sk, hdev->id, MGMT_OP_GET_CLOCK_INFO,
-				    MGMT_STATUS_INVALID_PARAMS,
-				    &rp, sizeof(rp));
+		return mgmt_cmd_complete(sk, hdev->id, MGMT_OP_GET_CLOCK_INFO,
+					 MGMT_STATUS_INVALID_PARAMS,
+					 &rp, sizeof(rp));
 
 	hci_dev_lock(hdev);
 
 	if (!hdev_is_powered(hdev)) {
-		err = cmd_complete(sk, hdev->id, MGMT_OP_GET_CLOCK_INFO,
-				   MGMT_STATUS_NOT_POWERED, &rp, sizeof(rp));
+		err = mgmt_cmd_complete(sk, hdev->id, MGMT_OP_GET_CLOCK_INFO,
+					MGMT_STATUS_NOT_POWERED, &rp,
+					sizeof(rp));
 		goto unlock;
 	}
 
@@ -5531,10 +5546,10 @@ static int get_clock_info(struct sock *sk, struct hci_dev *hdev, void *data,
 		conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK,
 					       &cp->addr.bdaddr);
 		if (!conn || conn->state != BT_CONNECTED) {
-			err = cmd_complete(sk, hdev->id,
-					   MGMT_OP_GET_CLOCK_INFO,
-					   MGMT_STATUS_NOT_CONNECTED,
-					   &rp, sizeof(rp));
+			err = mgmt_cmd_complete(sk, hdev->id,
+						MGMT_OP_GET_CLOCK_INFO,
+						MGMT_STATUS_NOT_CONNECTED,
+						&rp, sizeof(rp));
 			goto unlock;
 		}
 	} else {
@@ -5675,14 +5690,14 @@ static int add_device(struct sock *sk, struct hci_dev *hdev,
 
 	if (!bdaddr_type_is_valid(cp->addr.type) ||
 	    !bacmp(&cp->addr.bdaddr, BDADDR_ANY))
-		return cmd_complete(sk, hdev->id, MGMT_OP_ADD_DEVICE,
-				    MGMT_STATUS_INVALID_PARAMS,
-				    &cp->addr, sizeof(cp->addr));
+		return mgmt_cmd_complete(sk, hdev->id, MGMT_OP_ADD_DEVICE,
+					 MGMT_STATUS_INVALID_PARAMS,
+					 &cp->addr, sizeof(cp->addr));
 
 	if (cp->action != 0x00 && cp->action != 0x01 && cp->action != 0x02)
-		return cmd_complete(sk, hdev->id, MGMT_OP_ADD_DEVICE,
-				    MGMT_STATUS_INVALID_PARAMS,
-				    &cp->addr, sizeof(cp->addr));
+		return mgmt_cmd_complete(sk, hdev->id, MGMT_OP_ADD_DEVICE,
+					 MGMT_STATUS_INVALID_PARAMS,
+					 &cp->addr, sizeof(cp->addr));
 
 	hci_req_init(&req, hdev);
 
@@ -5994,7 +6009,8 @@ static int load_conn_param(struct sock *sk, struct hci_dev *hdev, void *data,
 
 	hci_dev_unlock(hdev);
 
-	return cmd_complete(sk, hdev->id, MGMT_OP_LOAD_CONN_PARAM, 0, NULL, 0);
+	return mgmt_cmd_complete(sk, hdev->id, MGMT_OP_LOAD_CONN_PARAM, 0,
+				 NULL, 0);
 }
 
 static int set_external_config(struct sock *sk, struct hci_dev *hdev,
@@ -7194,8 +7210,9 @@ void mgmt_read_local_oob_data_complete(struct hci_dev *hdev, u8 *hash192,
 			rp_size -= sizeof(rp.hash256) + sizeof(rp.rand256);
 		}
 
-		cmd_complete(cmd->sk, hdev->id, MGMT_OP_READ_LOCAL_OOB_DATA, 0,
-			     &rp, rp_size);
+		mgmt_cmd_complete(cmd->sk, hdev->id,
+				  MGMT_OP_READ_LOCAL_OOB_DATA, 0,
+				  &rp, rp_size);
 	}
 
 	mgmt_pending_remove(cmd);
-- 
2.1.0

