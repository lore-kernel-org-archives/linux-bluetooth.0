Return-Path: <cyrus@holtmann.org>
From: Arron Wang <arron.wang@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Arron Wang <arron.wang@intel.com>
Subject: [PATCH 3/3] Bluetooth: Classify HCI cmd event under corresponding config option
Date: Thu, 20 Aug 2015 17:09:05 +0800
Message-Id: <1440061745-24356-3-git-send-email-arron.wang@intel.com>
In-Reply-To: <1440061745-24356-1-git-send-email-arron.wang@intel.com>
References: <1440061745-24356-1-git-send-email-arron.wang@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Signed-off-by: Arron Wang <arron.wang@intel.com>
---
 net/bluetooth/hci_event.c |  757 +++++++++++++++++++++++----------------------
 1 file changed, 385 insertions(+), 372 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index a4df0fb..4961a3e 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2033,6 +2033,260 @@ unlock:
 }
 #endif
 
+static u8 hci_to_mgmt_reason(u8 err)
+{
+	switch (err) {
+	case HCI_ERROR_CONNECTION_TIMEOUT:
+		return MGMT_DEV_DISCONN_TIMEOUT;
+	case HCI_ERROR_REMOTE_USER_TERM:
+	case HCI_ERROR_REMOTE_LOW_RESOURCES:
+	case HCI_ERROR_REMOTE_POWER_OFF:
+		return MGMT_DEV_DISCONN_REMOTE;
+	case HCI_ERROR_LOCAL_HOST_TERM:
+		return MGMT_DEV_DISCONN_LOCAL_HOST;
+	default:
+		return MGMT_DEV_DISCONN_UNKNOWN;
+	}
+}
+
+static void hci_disconn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	struct hci_ev_disconn_complete *ev = (void *) skb->data;
+	u8 reason = hci_to_mgmt_reason(ev->reason);
+	struct hci_conn_params *params;
+	struct hci_conn *conn;
+	bool mgmt_connected;
+	u8 type;
+
+	BT_DBG("%s status 0x%2.2x", hdev->name, ev->status);
+
+	hci_dev_lock(hdev);
+
+	conn = hci_conn_hash_lookup_handle(hdev, __le16_to_cpu(ev->handle));
+	if (!conn)
+		goto unlock;
+
+	if (ev->status) {
+		mgmt_disconnect_failed(hdev, &conn->dst, conn->type,
+				       conn->dst_type, ev->status);
+		goto unlock;
+	}
+
+	conn->state = BT_CLOSED;
+
+	mgmt_connected = test_and_clear_bit(HCI_CONN_MGMT_CONNECTED,
+					    &conn->flags);
+	mgmt_device_disconnected(hdev, &conn->dst, conn->type, conn->dst_type,
+				 reason, mgmt_connected);
+
+	if (conn->type == ACL_LINK) {
+		if (test_bit(HCI_CONN_FLUSH_KEY, &conn->flags))
+			hci_remove_link_key(hdev, &conn->dst);
+
+		hci_update_page_scan(hdev);
+	}
+
+	params = hci_conn_params_lookup(hdev, &conn->dst, conn->dst_type);
+	if (params) {
+		switch (params->auto_connect) {
+		case HCI_AUTO_CONN_LINK_LOSS:
+			if (ev->reason != HCI_ERROR_CONNECTION_TIMEOUT)
+				break;
+			/* Fall through */
+
+		case HCI_AUTO_CONN_DIRECT:
+		case HCI_AUTO_CONN_ALWAYS:
+			list_del_init(&params->action);
+			list_add(&params->action, &hdev->pend_le_conns);
+			hci_update_background_scan(hdev);
+			break;
+
+		default:
+			break;
+		}
+	}
+
+	type = conn->type;
+
+	hci_disconn_cfm(conn, ev->reason);
+	hci_conn_del(conn);
+
+	/* Re-enable advertising if necessary, since it might
+	 * have been disabled by the connection. From the
+	 * HCI_LE_Set_Advertise_Enable command description in
+	 * the core specification (v4.0):
+	 * "The Controller shall continue advertising until the Host
+	 * issues an LE_Set_Advertise_Enable command with
+	 * Advertising_Enable set to 0x00 (Advertising is disabled)
+	 * or until a connection is created or until the Advertising
+	 * is timed out due to Directed Advertising."
+	 */
+	if (type == LE_LINK)
+		mgmt_reenable_advertising(hdev);
+
+unlock:
+	hci_dev_unlock(hdev);
+}
+
+static void read_enc_key_size_complete(struct hci_dev *hdev, u8 status,
+				       u16 opcode, struct sk_buff *skb)
+{
+	const struct hci_rp_read_enc_key_size *rp;
+	struct hci_conn *conn;
+	u16 handle;
+
+	BT_DBG("%s status 0x%02x", hdev->name, status);
+
+	if (!skb || skb->len < sizeof(*rp)) {
+		BT_ERR("%s invalid HCI Read Encryption Key Size response",
+		       hdev->name);
+		return;
+	}
+
+	rp = (void *)skb->data;
+	handle = le16_to_cpu(rp->handle);
+
+	hci_dev_lock(hdev);
+
+	conn = hci_conn_hash_lookup_handle(hdev, handle);
+	if (!conn)
+		goto unlock;
+
+	/* If we fail to read the encryption key size, assume maximum
+	 * (which is the same we do also when this HCI command isn't
+	 * supported.
+	 */
+	if (rp->status) {
+		BT_ERR("%s failed to read key size for handle %u", hdev->name,
+		       handle);
+		conn->enc_key_size = HCI_LINK_KEY_SIZE;
+	} else {
+		conn->enc_key_size = rp->key_size;
+	}
+
+	if (conn->state == BT_CONFIG) {
+		conn->state = BT_CONNECTED;
+		hci_connect_cfm(conn, 0);
+		hci_conn_drop(conn);
+	} else {
+		u8 encrypt;
+
+		if (!test_bit(HCI_CONN_ENCRYPT, &conn->flags))
+			encrypt = 0x00;
+		else if (test_bit(HCI_CONN_AES_CCM, &conn->flags))
+			encrypt = 0x02;
+		else
+			encrypt = 0x01;
+
+		hci_encrypt_cfm(conn, 0, encrypt);
+	}
+
+unlock:
+	hci_dev_unlock(hdev);
+}
+
+static void hci_encrypt_change_evt(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	struct hci_ev_encrypt_change *ev = (void *) skb->data;
+	struct hci_conn *conn;
+
+	BT_DBG("%s status 0x%2.2x", hdev->name, ev->status);
+
+	hci_dev_lock(hdev);
+
+	conn = hci_conn_hash_lookup_handle(hdev, __le16_to_cpu(ev->handle));
+	if (!conn)
+		goto unlock;
+
+	if (!ev->status) {
+		if (ev->encrypt) {
+			/* Encryption implies authentication */
+			set_bit(HCI_CONN_AUTH, &conn->flags);
+			set_bit(HCI_CONN_ENCRYPT, &conn->flags);
+			conn->sec_level = conn->pending_sec_level;
+
+			/* P-256 authentication key implies FIPS */
+			if (conn->key_type == HCI_LK_AUTH_COMBINATION_P256)
+				set_bit(HCI_CONN_FIPS, &conn->flags);
+
+			if ((conn->type == ACL_LINK && ev->encrypt == 0x02) ||
+			    conn->type == LE_LINK)
+				set_bit(HCI_CONN_AES_CCM, &conn->flags);
+		} else {
+			clear_bit(HCI_CONN_ENCRYPT, &conn->flags);
+			clear_bit(HCI_CONN_AES_CCM, &conn->flags);
+		}
+	}
+
+	/* We should disregard the current RPA and generate a new one
+	 * whenever the encryption procedure fails.
+	 */
+	if (ev->status && conn->type == LE_LINK)
+		hci_dev_set_flag(hdev, HCI_RPA_EXPIRED);
+
+	clear_bit(HCI_CONN_ENCRYPT_PEND, &conn->flags);
+
+	if (ev->status && conn->state == BT_CONNECTED) {
+		hci_disconnect(conn, HCI_ERROR_AUTH_FAILURE);
+		hci_conn_drop(conn);
+		goto unlock;
+	}
+
+	/* In Secure Connections Only mode, do not allow any connections
+	 * that are not encrypted with AES-CCM using a P-256 authenticated
+	 * combination key.
+	 */
+	if (hci_dev_test_flag(hdev, HCI_SC_ONLY) &&
+	    (!test_bit(HCI_CONN_AES_CCM, &conn->flags) ||
+	     conn->key_type != HCI_LK_AUTH_COMBINATION_P256)) {
+		hci_connect_cfm(conn, HCI_ERROR_AUTH_FAILURE);
+		hci_conn_drop(conn);
+		goto unlock;
+	}
+
+	/* Try reading the encryption key size for encrypted ACL links */
+	if (!ev->status && ev->encrypt && conn->type == ACL_LINK) {
+		struct hci_cp_read_enc_key_size cp;
+		struct hci_request req;
+
+		/* Only send HCI_Read_Encryption_Key_Size if the
+		 * controller really supports it. If it doesn't, assume
+		 * the default size (16).
+		 */
+		if (!(hdev->commands[20] & 0x10)) {
+			conn->enc_key_size = HCI_LINK_KEY_SIZE;
+			goto notify;
+		}
+
+		hci_req_init(&req, hdev);
+
+		cp.handle = cpu_to_le16(conn->handle);
+		hci_req_add(&req, HCI_OP_READ_ENC_KEY_SIZE, sizeof(cp), &cp);
+
+		if (hci_req_run_skb(&req, read_enc_key_size_complete)) {
+			BT_ERR("Sending HCI Read Encryption Key Size failed");
+			conn->enc_key_size = HCI_LINK_KEY_SIZE;
+			goto notify;
+		}
+
+		goto unlock;
+	}
+
+notify:
+	if (conn->state == BT_CONFIG) {
+		if (!ev->status)
+			conn->state = BT_CONNECTED;
+
+		hci_connect_cfm(conn, ev->status);
+		hci_conn_drop(conn);
+	} else
+		hci_encrypt_cfm(conn, ev->status, ev->encrypt);
+
+unlock:
+	hci_dev_unlock(hdev);
+}
+
+#if IS_ENABLED(CONFIG_BT_BREDR)
 static void hci_inquiry_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	__u8 status = *((__u8 *) skb->data);
@@ -2319,100 +2573,6 @@ static void hci_conn_request_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	}
 }
 
-static u8 hci_to_mgmt_reason(u8 err)
-{
-	switch (err) {
-	case HCI_ERROR_CONNECTION_TIMEOUT:
-		return MGMT_DEV_DISCONN_TIMEOUT;
-	case HCI_ERROR_REMOTE_USER_TERM:
-	case HCI_ERROR_REMOTE_LOW_RESOURCES:
-	case HCI_ERROR_REMOTE_POWER_OFF:
-		return MGMT_DEV_DISCONN_REMOTE;
-	case HCI_ERROR_LOCAL_HOST_TERM:
-		return MGMT_DEV_DISCONN_LOCAL_HOST;
-	default:
-		return MGMT_DEV_DISCONN_UNKNOWN;
-	}
-}
-
-static void hci_disconn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
-{
-	struct hci_ev_disconn_complete *ev = (void *) skb->data;
-	u8 reason = hci_to_mgmt_reason(ev->reason);
-	struct hci_conn_params *params;
-	struct hci_conn *conn;
-	bool mgmt_connected;
-	u8 type;
-
-	BT_DBG("%s status 0x%2.2x", hdev->name, ev->status);
-
-	hci_dev_lock(hdev);
-
-	conn = hci_conn_hash_lookup_handle(hdev, __le16_to_cpu(ev->handle));
-	if (!conn)
-		goto unlock;
-
-	if (ev->status) {
-		mgmt_disconnect_failed(hdev, &conn->dst, conn->type,
-				       conn->dst_type, ev->status);
-		goto unlock;
-	}
-
-	conn->state = BT_CLOSED;
-
-	mgmt_connected = test_and_clear_bit(HCI_CONN_MGMT_CONNECTED, &conn->flags);
-	mgmt_device_disconnected(hdev, &conn->dst, conn->type, conn->dst_type,
-				reason, mgmt_connected);
-
-	if (conn->type == ACL_LINK) {
-		if (test_bit(HCI_CONN_FLUSH_KEY, &conn->flags))
-			hci_remove_link_key(hdev, &conn->dst);
-
-		hci_update_page_scan(hdev);
-	}
-
-	params = hci_conn_params_lookup(hdev, &conn->dst, conn->dst_type);
-	if (params) {
-		switch (params->auto_connect) {
-		case HCI_AUTO_CONN_LINK_LOSS:
-			if (ev->reason != HCI_ERROR_CONNECTION_TIMEOUT)
-				break;
-			/* Fall through */
-
-		case HCI_AUTO_CONN_DIRECT:
-		case HCI_AUTO_CONN_ALWAYS:
-			list_del_init(&params->action);
-			list_add(&params->action, &hdev->pend_le_conns);
-			hci_update_background_scan(hdev);
-			break;
-
-		default:
-			break;
-		}
-	}
-
-	type = conn->type;
-
-	hci_disconn_cfm(conn, ev->reason);
-	hci_conn_del(conn);
-
-	/* Re-enable advertising if necessary, since it might
-	 * have been disabled by the connection. From the
-	 * HCI_LE_Set_Advertise_Enable command description in
-	 * the core specification (v4.0):
-	 * "The Controller shall continue advertising until the Host
-	 * issues an LE_Set_Advertise_Enable command with
-	 * Advertising_Enable set to 0x00 (Advertising is disabled)
-	 * or until a connection is created or until the Advertising
-	 * is timed out due to Directed Advertising."
-	 */
-	if (type == LE_LINK)
-		mgmt_reenable_advertising(hdev);
-
-unlock:
-	hci_dev_unlock(hdev);
-}
-
 static void hci_auth_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct hci_ev_auth_complete *ev = (void *) skb->data;
@@ -2483,196 +2643,38 @@ static void hci_remote_name_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	struct hci_ev_remote_name *ev = (void *) skb->data;
 	struct hci_conn *conn;
 
-	BT_DBG("%s", hdev->name);
-
-	hci_conn_check_pending(hdev);
-
-	hci_dev_lock(hdev);
-
-	conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, &ev->bdaddr);
-
-	if (!hci_dev_test_flag(hdev, HCI_MGMT))
-		goto check_auth;
-
-	if (ev->status == 0)
-		hci_check_pending_name(hdev, conn, &ev->bdaddr, ev->name,
-				       strnlen(ev->name, HCI_MAX_NAME_LENGTH));
-	else
-		hci_check_pending_name(hdev, conn, &ev->bdaddr, NULL, 0);
-
-check_auth:
-	if (!conn)
-		goto unlock;
-
-	if (!hci_outgoing_auth_needed(hdev, conn))
-		goto unlock;
-
-	if (!test_and_set_bit(HCI_CONN_AUTH_PEND, &conn->flags)) {
-		struct hci_cp_auth_requested cp;
-
-		set_bit(HCI_CONN_AUTH_INITIATOR, &conn->flags);
-
-		cp.handle = __cpu_to_le16(conn->handle);
-		hci_send_cmd(hdev, HCI_OP_AUTH_REQUESTED, sizeof(cp), &cp);
-	}
-
-unlock:
-	hci_dev_unlock(hdev);
-}
-
-static void read_enc_key_size_complete(struct hci_dev *hdev, u8 status,
-				       u16 opcode, struct sk_buff *skb)
-{
-	const struct hci_rp_read_enc_key_size *rp;
-	struct hci_conn *conn;
-	u16 handle;
-
-	BT_DBG("%s status 0x%02x", hdev->name, status);
-
-	if (!skb || skb->len < sizeof(*rp)) {
-		BT_ERR("%s invalid HCI Read Encryption Key Size response",
-		       hdev->name);
-		return;
-	}
-
-	rp = (void *)skb->data;
-	handle = le16_to_cpu(rp->handle);
-
-	hci_dev_lock(hdev);
-
-	conn = hci_conn_hash_lookup_handle(hdev, handle);
-	if (!conn)
-		goto unlock;
-
-	/* If we fail to read the encryption key size, assume maximum
-	 * (which is the same we do also when this HCI command isn't
-	 * supported.
-	 */
-	if (rp->status) {
-		BT_ERR("%s failed to read key size for handle %u", hdev->name,
-		       handle);
-		conn->enc_key_size = HCI_LINK_KEY_SIZE;
-	} else {
-		conn->enc_key_size = rp->key_size;
-	}
-
-	if (conn->state == BT_CONFIG) {
-		conn->state = BT_CONNECTED;
-		hci_connect_cfm(conn, 0);
-		hci_conn_drop(conn);
-	} else {
-		u8 encrypt;
-
-		if (!test_bit(HCI_CONN_ENCRYPT, &conn->flags))
-			encrypt = 0x00;
-		else if (test_bit(HCI_CONN_AES_CCM, &conn->flags))
-			encrypt = 0x02;
-		else
-			encrypt = 0x01;
-
-		hci_encrypt_cfm(conn, 0, encrypt);
-	}
-
-unlock:
-	hci_dev_unlock(hdev);
-}
-
-static void hci_encrypt_change_evt(struct hci_dev *hdev, struct sk_buff *skb)
-{
-	struct hci_ev_encrypt_change *ev = (void *) skb->data;
-	struct hci_conn *conn;
-
-	BT_DBG("%s status 0x%2.2x", hdev->name, ev->status);
-
-	hci_dev_lock(hdev);
-
-	conn = hci_conn_hash_lookup_handle(hdev, __le16_to_cpu(ev->handle));
-	if (!conn)
-		goto unlock;
-
-	if (!ev->status) {
-		if (ev->encrypt) {
-			/* Encryption implies authentication */
-			set_bit(HCI_CONN_AUTH, &conn->flags);
-			set_bit(HCI_CONN_ENCRYPT, &conn->flags);
-			conn->sec_level = conn->pending_sec_level;
-
-			/* P-256 authentication key implies FIPS */
-			if (conn->key_type == HCI_LK_AUTH_COMBINATION_P256)
-				set_bit(HCI_CONN_FIPS, &conn->flags);
-
-			if ((conn->type == ACL_LINK && ev->encrypt == 0x02) ||
-			    conn->type == LE_LINK)
-				set_bit(HCI_CONN_AES_CCM, &conn->flags);
-		} else {
-			clear_bit(HCI_CONN_ENCRYPT, &conn->flags);
-			clear_bit(HCI_CONN_AES_CCM, &conn->flags);
-		}
-	}
-
-	/* We should disregard the current RPA and generate a new one
-	 * whenever the encryption procedure fails.
-	 */
-	if (ev->status && conn->type == LE_LINK)
-		hci_dev_set_flag(hdev, HCI_RPA_EXPIRED);
-
-	clear_bit(HCI_CONN_ENCRYPT_PEND, &conn->flags);
-
-	if (ev->status && conn->state == BT_CONNECTED) {
-		hci_disconnect(conn, HCI_ERROR_AUTH_FAILURE);
-		hci_conn_drop(conn);
-		goto unlock;
-	}
-
-	/* In Secure Connections Only mode, do not allow any connections
-	 * that are not encrypted with AES-CCM using a P-256 authenticated
-	 * combination key.
-	 */
-	if (hci_dev_test_flag(hdev, HCI_SC_ONLY) &&
-	    (!test_bit(HCI_CONN_AES_CCM, &conn->flags) ||
-	     conn->key_type != HCI_LK_AUTH_COMBINATION_P256)) {
-		hci_connect_cfm(conn, HCI_ERROR_AUTH_FAILURE);
-		hci_conn_drop(conn);
-		goto unlock;
-	}
-
-	/* Try reading the encryption key size for encrypted ACL links */
-	if (!ev->status && ev->encrypt && conn->type == ACL_LINK) {
-		struct hci_cp_read_enc_key_size cp;
-		struct hci_request req;
+	BT_DBG("%s", hdev->name);
 
-		/* Only send HCI_Read_Encryption_Key_Size if the
-		 * controller really supports it. If it doesn't, assume
-		 * the default size (16).
-		 */
-		if (!(hdev->commands[20] & 0x10)) {
-			conn->enc_key_size = HCI_LINK_KEY_SIZE;
-			goto notify;
-		}
+	hci_conn_check_pending(hdev);
 
-		hci_req_init(&req, hdev);
+	hci_dev_lock(hdev);
 
-		cp.handle = cpu_to_le16(conn->handle);
-		hci_req_add(&req, HCI_OP_READ_ENC_KEY_SIZE, sizeof(cp), &cp);
+	conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, &ev->bdaddr);
 
-		if (hci_req_run_skb(&req, read_enc_key_size_complete)) {
-			BT_ERR("Sending HCI Read Encryption Key Size failed");
-			conn->enc_key_size = HCI_LINK_KEY_SIZE;
-			goto notify;
-		}
+	if (!hci_dev_test_flag(hdev, HCI_MGMT))
+		goto check_auth;
+
+	if (ev->status == 0)
+		hci_check_pending_name(hdev, conn, &ev->bdaddr, ev->name,
+				       strnlen(ev->name, HCI_MAX_NAME_LENGTH));
+	else
+		hci_check_pending_name(hdev, conn, &ev->bdaddr, NULL, 0);
 
+check_auth:
+	if (!conn)
 		goto unlock;
-	}
 
-notify:
-	if (conn->state == BT_CONFIG) {
-		if (!ev->status)
-			conn->state = BT_CONNECTED;
+	if (!hci_outgoing_auth_needed(hdev, conn))
+		goto unlock;
 
-		hci_connect_cfm(conn, ev->status);
-		hci_conn_drop(conn);
-	} else
-		hci_encrypt_cfm(conn, ev->status, ev->encrypt);
+	if (!test_and_set_bit(HCI_CONN_AUTH_PEND, &conn->flags)) {
+		struct hci_cp_auth_requested cp;
+
+		set_bit(HCI_CONN_AUTH_INITIATOR, &conn->flags);
+
+		cp.handle = __cpu_to_le16(conn->handle);
+		hci_send_cmd(hdev, HCI_OP_AUTH_REQUESTED, sizeof(cp), &cp);
+	}
 
 unlock:
 	hci_dev_unlock(hdev);
@@ -2749,6 +2751,7 @@ static void hci_remote_features_evt(struct hci_dev *hdev,
 unlock:
 	hci_dev_unlock(hdev);
 }
+#endif
 
 static void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *skb,
 				 u16 *opcode, u8 *status,
@@ -3171,28 +3174,6 @@ static void hci_hardware_error_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	queue_work(hdev->req_workqueue, &hdev->error_reset);
 }
 
-static void hci_role_change_evt(struct hci_dev *hdev, struct sk_buff *skb)
-{
-	struct hci_ev_role_change *ev = (void *) skb->data;
-	struct hci_conn *conn;
-
-	BT_DBG("%s status 0x%2.2x", hdev->name, ev->status);
-
-	hci_dev_lock(hdev);
-
-	conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, &ev->bdaddr);
-	if (conn) {
-		if (!ev->status)
-			conn->role = ev->role;
-
-		clear_bit(HCI_CONN_RSWITCH_PEND, &conn->flags);
-
-		hci_role_switch_cfm(conn, ev->status, ev->role);
-	}
-
-	hci_dev_unlock(hdev);
-}
-
 static void hci_num_comp_pkts_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct hci_ev_num_comp_pkts *ev = (void *) skb->data;
@@ -3259,6 +3240,79 @@ static void hci_num_comp_pkts_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	queue_work(hdev->workqueue, &hdev->tx_work);
 }
 
+static void hci_key_refresh_complete_evt(struct hci_dev *hdev,
+					 struct sk_buff *skb)
+{
+	struct hci_ev_key_refresh_complete *ev = (void *) skb->data;
+	struct hci_conn *conn;
+
+	BT_DBG("%s status 0x%2.2x handle 0x%4.4x", hdev->name, ev->status,
+	       __le16_to_cpu(ev->handle));
+
+	hci_dev_lock(hdev);
+
+	conn = hci_conn_hash_lookup_handle(hdev, __le16_to_cpu(ev->handle));
+	if (!conn)
+		goto unlock;
+
+	/* For BR/EDR the necessary steps are taken through the
+	 * auth_complete event.
+	 */
+	if (conn->type != LE_LINK)
+		goto unlock;
+
+	if (!ev->status)
+		conn->sec_level = conn->pending_sec_level;
+
+	clear_bit(HCI_CONN_ENCRYPT_PEND, &conn->flags);
+
+	if (ev->status && conn->state == BT_CONNECTED) {
+		hci_disconnect(conn, HCI_ERROR_AUTH_FAILURE);
+		hci_conn_drop(conn);
+		goto unlock;
+	}
+
+	if (conn->state == BT_CONFIG) {
+		if (!ev->status)
+			conn->state = BT_CONNECTED;
+
+		hci_connect_cfm(conn, ev->status);
+		hci_conn_drop(conn);
+	} else {
+		hci_auth_cfm(conn, ev->status);
+
+		hci_conn_hold(conn);
+		conn->disc_timeout = HCI_DISCONN_TIMEOUT;
+		hci_conn_drop(conn);
+	}
+
+unlock:
+	hci_dev_unlock(hdev);
+}
+
+#if IS_ENABLED(CONFIG_BT_BREDR)
+static void hci_role_change_evt(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	struct hci_ev_role_change *ev = (void *) skb->data;
+	struct hci_conn *conn;
+
+	BT_DBG("%s status 0x%2.2x", hdev->name, ev->status);
+
+	hci_dev_lock(hdev);
+
+	conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, &ev->bdaddr);
+	if (conn) {
+		if (!ev->status)
+			conn->role = ev->role;
+
+		clear_bit(HCI_CONN_RSWITCH_PEND, &conn->flags);
+
+		hci_role_switch_cfm(conn, ev->status, ev->role);
+	}
+
+	hci_dev_unlock(hdev);
+}
+
 static struct hci_conn *__hci_conn_lookup_handle(struct hci_dev *hdev,
 						 __u16 handle)
 {
@@ -3859,56 +3913,6 @@ static void hci_extended_inquiry_result_evt(struct hci_dev *hdev,
 	hci_dev_unlock(hdev);
 }
 
-static void hci_key_refresh_complete_evt(struct hci_dev *hdev,
-					 struct sk_buff *skb)
-{
-	struct hci_ev_key_refresh_complete *ev = (void *) skb->data;
-	struct hci_conn *conn;
-
-	BT_DBG("%s status 0x%2.2x handle 0x%4.4x", hdev->name, ev->status,
-	       __le16_to_cpu(ev->handle));
-
-	hci_dev_lock(hdev);
-
-	conn = hci_conn_hash_lookup_handle(hdev, __le16_to_cpu(ev->handle));
-	if (!conn)
-		goto unlock;
-
-	/* For BR/EDR the necessary steps are taken through the
-	 * auth_complete event.
-	 */
-	if (conn->type != LE_LINK)
-		goto unlock;
-
-	if (!ev->status)
-		conn->sec_level = conn->pending_sec_level;
-
-	clear_bit(HCI_CONN_ENCRYPT_PEND, &conn->flags);
-
-	if (ev->status && conn->state == BT_CONNECTED) {
-		hci_disconnect(conn, HCI_ERROR_AUTH_FAILURE);
-		hci_conn_drop(conn);
-		goto unlock;
-	}
-
-	if (conn->state == BT_CONFIG) {
-		if (!ev->status)
-			conn->state = BT_CONNECTED;
-
-		hci_connect_cfm(conn, ev->status);
-		hci_conn_drop(conn);
-	} else {
-		hci_auth_cfm(conn, ev->status);
-
-		hci_conn_hold(conn);
-		conn->disc_timeout = HCI_DISCONN_TIMEOUT;
-		hci_conn_drop(conn);
-	}
-
-unlock:
-	hci_dev_unlock(hdev);
-}
-
 static u8 hci_get_auth_req(struct hci_conn *conn)
 {
 	/* If remote requests no-bonding follow that lead */
@@ -4309,6 +4313,7 @@ static void hci_remote_oob_data_request_evt(struct hci_dev *hdev,
 unlock:
 	hci_dev_unlock(hdev);
 }
+#endif
 
 #if IS_ENABLED(CONFIG_BT_HS)
 static void hci_chan_selected_evt(struct hci_dev *hdev, struct sk_buff *skb)
@@ -4452,6 +4457,7 @@ static void hci_disconn_phylink_complete_evt(struct hci_dev *hdev,
 }
 #endif
 
+#if IS_ENABLED(CONFIG_BT_LE)
 static void hci_le_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct hci_ev_le_conn_complete *ev = (void *) skb->data;
@@ -5141,6 +5147,7 @@ static void hci_le_meta_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		break;
 	}
 }
+#endif
 
 static bool hci_get_cmd_complete(struct hci_dev *hdev, u16 opcode,
 				 u8 event, struct sk_buff *skb)
@@ -5216,6 +5223,15 @@ void hci_event_packet(struct hci_dev *hdev, struct sk_buff *skb)
 	skb_pull(skb, HCI_EVENT_HDR_SIZE);
 
 	switch (event) {
+	case HCI_EV_DISCONN_COMPLETE:
+		hci_disconn_complete_evt(hdev, skb);
+		break;
+
+	case HCI_EV_ENCRYPT_CHANGE:
+		hci_encrypt_change_evt(hdev, skb);
+		break;
+
+#if IS_ENABLED(CONFIG_BT_BREDR)
 	case HCI_EV_INQUIRY_COMPLETE:
 		hci_inquiry_complete_evt(hdev, skb);
 		break;
@@ -5232,10 +5248,6 @@ void hci_event_packet(struct hci_dev *hdev, struct sk_buff *skb)
 		hci_conn_request_evt(hdev, skb);
 		break;
 
-	case HCI_EV_DISCONN_COMPLETE:
-		hci_disconn_complete_evt(hdev, skb);
-		break;
-
 	case HCI_EV_AUTH_COMPLETE:
 		hci_auth_complete_evt(hdev, skb);
 		break;
@@ -5244,10 +5256,6 @@ void hci_event_packet(struct hci_dev *hdev, struct sk_buff *skb)
 		hci_remote_name_evt(hdev, skb);
 		break;
 
-	case HCI_EV_ENCRYPT_CHANGE:
-		hci_encrypt_change_evt(hdev, skb);
-		break;
-
 	case HCI_EV_CHANGE_LINK_KEY_COMPLETE:
 		hci_change_link_key_complete_evt(hdev, skb);
 		break;
@@ -5255,6 +5263,7 @@ void hci_event_packet(struct hci_dev *hdev, struct sk_buff *skb)
 	case HCI_EV_REMOTE_FEATURES:
 		hci_remote_features_evt(hdev, skb);
 		break;
+#endif
 
 	case HCI_EV_CMD_COMPLETE:
 		hci_cmd_complete_evt(hdev, skb, &opcode, &status,
@@ -5270,14 +5279,19 @@ void hci_event_packet(struct hci_dev *hdev, struct sk_buff *skb)
 		hci_hardware_error_evt(hdev, skb);
 		break;
 
-	case HCI_EV_ROLE_CHANGE:
-		hci_role_change_evt(hdev, skb);
-		break;
-
 	case HCI_EV_NUM_COMP_PKTS:
 		hci_num_comp_pkts_evt(hdev, skb);
 		break;
 
+	case HCI_EV_KEY_REFRESH_COMPLETE:
+		hci_key_refresh_complete_evt(hdev, skb);
+		break;
+
+#if IS_ENABLED(CONFIG_BT_BREDR)
+	case HCI_EV_ROLE_CHANGE:
+		hci_role_change_evt(hdev, skb);
+		break;
+
 	case HCI_EV_MODE_CHANGE:
 		hci_mode_change_evt(hdev, skb);
 		break;
@@ -5322,10 +5336,6 @@ void hci_event_packet(struct hci_dev *hdev, struct sk_buff *skb)
 		hci_extended_inquiry_result_evt(hdev, skb);
 		break;
 
-	case HCI_EV_KEY_REFRESH_COMPLETE:
-		hci_key_refresh_complete_evt(hdev, skb);
-		break;
-
 	case HCI_EV_IO_CAPA_REQUEST:
 		hci_io_capa_request_evt(hdev, skb);
 		break;
@@ -5358,14 +5368,21 @@ void hci_event_packet(struct hci_dev *hdev, struct sk_buff *skb)
 		hci_remote_host_features_evt(hdev, skb);
 		break;
 
-	case HCI_EV_LE_META:
-		hci_le_meta_evt(hdev, skb);
-		break;
-
 	case HCI_EV_REMOTE_OOB_DATA_REQUEST:
 		hci_remote_oob_data_request_evt(hdev, skb);
 		break;
 
+	case HCI_EV_NUM_COMP_BLOCKS:
+		hci_num_comp_blocks_evt(hdev, skb);
+		break;
+#endif
+
+#if IS_ENABLED(CONFIG_BT_LE)
+	case HCI_EV_LE_META:
+		hci_le_meta_evt(hdev, skb);
+		break;
+#endif
+
 #if IS_ENABLED(CONFIG_BT_HS)
 	case HCI_EV_CHANNEL_SELECTED:
 		hci_chan_selected_evt(hdev, skb);
@@ -5388,10 +5405,6 @@ void hci_event_packet(struct hci_dev *hdev, struct sk_buff *skb)
 		break;
 #endif
 
-	case HCI_EV_NUM_COMP_BLOCKS:
-		hci_num_comp_blocks_evt(hdev, skb);
-		break;
-
 	default:
 		BT_DBG("%s event 0x%2.2x", hdev->name, event);
 		break;
-- 
1.7.9.5

