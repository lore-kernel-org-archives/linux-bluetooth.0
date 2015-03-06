Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 4/7] Bluetooth: Rename cmd_status() to mgmt_cmd_status()
Date: Fri,  6 Mar 2015 14:10:17 +0200
Message-Id: <1425643820-7644-5-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1425643820-7644-1-git-send-email-johan.hedberg@gmail.com>
References: <1425643820-7644-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch renames the cmd_status() function to mgmt_cmd_status() in
preparation of making it a generic helper for other modules to use too.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c | 459 ++++++++++++++++++++++++++-------------------------
 1 file changed, 230 insertions(+), 229 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 77b2165d1faf..bcfb713b1f87 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -249,7 +249,7 @@ static int mgmt_event(u16 event, struct hci_dev *hdev, void *data, u16 data_len,
 	return 0;
 }
 
-static int cmd_status(struct sock *sk, u16 index, u16 cmd, u8 status)
+static int mgmt_cmd_status(struct sock *sk, u16 index, u16 cmd, u8 status)
 {
 	struct sk_buff *skb;
 	struct mgmt_hdr *hdr;
@@ -1376,14 +1376,14 @@ static int set_powered(struct sock *sk, struct hci_dev *hdev, void *data,
 	BT_DBG("request for %s", hdev->name);
 
 	if (cp->val != 0x00 && cp->val != 0x01)
-		return cmd_status(sk, hdev->id, MGMT_OP_SET_POWERED,
-				  MGMT_STATUS_INVALID_PARAMS);
+		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_POWERED,
+				       MGMT_STATUS_INVALID_PARAMS);
 
 	hci_dev_lock(hdev);
 
 	if (mgmt_pending_find(MGMT_OP_SET_POWERED, hdev)) {
-		err = cmd_status(sk, hdev->id, MGMT_OP_SET_POWERED,
-				 MGMT_STATUS_BUSY);
+		err = mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_POWERED,
+				      MGMT_STATUS_BUSY);
 		goto failed;
 	}
 
@@ -1472,7 +1472,7 @@ static void cmd_status_rsp(struct pending_cmd *cmd, void *data)
 {
 	u8 *status = data;
 
-	cmd_status(cmd->sk, cmd->index, cmd->opcode, *status);
+	mgmt_cmd_status(cmd->sk, cmd->index, cmd->opcode, *status);
 	mgmt_pending_remove(cmd);
 }
 
@@ -1540,7 +1540,7 @@ static void set_discoverable_complete(struct hci_dev *hdev, u8 status,
 
 	if (status) {
 		u8 mgmt_err = mgmt_status(status);
-		cmd_status(cmd->sk, cmd->index, cmd->opcode, mgmt_err);
+		mgmt_cmd_status(cmd->sk, cmd->index, cmd->opcode, mgmt_err);
 		clear_bit(HCI_LIMITED_DISCOVERABLE, &hdev->dev_flags);
 		goto remove_cmd;
 	}
@@ -1596,12 +1596,12 @@ static int set_discoverable(struct sock *sk, struct hci_dev *hdev, void *data,
 
 	if (!test_bit(HCI_LE_ENABLED, &hdev->dev_flags) &&
 	    !test_bit(HCI_BREDR_ENABLED, &hdev->dev_flags))
-		return cmd_status(sk, hdev->id, MGMT_OP_SET_DISCOVERABLE,
-				  MGMT_STATUS_REJECTED);
+		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_DISCOVERABLE,
+				       MGMT_STATUS_REJECTED);
 
 	if (cp->val != 0x00 && cp->val != 0x01 && cp->val != 0x02)
-		return cmd_status(sk, hdev->id, MGMT_OP_SET_DISCOVERABLE,
-				  MGMT_STATUS_INVALID_PARAMS);
+		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_DISCOVERABLE,
+				       MGMT_STATUS_INVALID_PARAMS);
 
 	timeout = __le16_to_cpu(cp->timeout);
 
@@ -1610,27 +1610,27 @@ static int set_discoverable(struct sock *sk, struct hci_dev *hdev, void *data,
 	 */
 	if ((cp->val == 0x00 && timeout > 0) ||
 	    (cp->val == 0x02 && timeout == 0))
-		return cmd_status(sk, hdev->id, MGMT_OP_SET_DISCOVERABLE,
-				  MGMT_STATUS_INVALID_PARAMS);
+		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_DISCOVERABLE,
+				       MGMT_STATUS_INVALID_PARAMS);
 
 	hci_dev_lock(hdev);
 
 	if (!hdev_is_powered(hdev) && timeout > 0) {
-		err = cmd_status(sk, hdev->id, MGMT_OP_SET_DISCOVERABLE,
-				 MGMT_STATUS_NOT_POWERED);
+		err = mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_DISCOVERABLE,
+				      MGMT_STATUS_NOT_POWERED);
 		goto failed;
 	}
 
 	if (mgmt_pending_find(MGMT_OP_SET_DISCOVERABLE, hdev) ||
 	    mgmt_pending_find(MGMT_OP_SET_CONNECTABLE, hdev)) {
-		err = cmd_status(sk, hdev->id, MGMT_OP_SET_DISCOVERABLE,
-				 MGMT_STATUS_BUSY);
+		err = mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_DISCOVERABLE,
+				      MGMT_STATUS_BUSY);
 		goto failed;
 	}
 
 	if (!test_bit(HCI_CONNECTABLE, &hdev->dev_flags)) {
-		err = cmd_status(sk, hdev->id, MGMT_OP_SET_DISCOVERABLE,
-				 MGMT_STATUS_REJECTED);
+		err = mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_DISCOVERABLE,
+				      MGMT_STATUS_REJECTED);
 		goto failed;
 	}
 
@@ -1799,7 +1799,7 @@ static void set_connectable_complete(struct hci_dev *hdev, u8 status,
 
 	if (status) {
 		u8 mgmt_err = mgmt_status(status);
-		cmd_status(cmd->sk, cmd->index, cmd->opcode, mgmt_err);
+		mgmt_cmd_status(cmd->sk, cmd->index, cmd->opcode, mgmt_err);
 		goto remove_cmd;
 	}
 
@@ -1874,12 +1874,12 @@ static int set_connectable(struct sock *sk, struct hci_dev *hdev, void *data,
 
 	if (!test_bit(HCI_LE_ENABLED, &hdev->dev_flags) &&
 	    !test_bit(HCI_BREDR_ENABLED, &hdev->dev_flags))
-		return cmd_status(sk, hdev->id, MGMT_OP_SET_CONNECTABLE,
-				  MGMT_STATUS_REJECTED);
+		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_CONNECTABLE,
+				       MGMT_STATUS_REJECTED);
 
 	if (cp->val != 0x00 && cp->val != 0x01)
-		return cmd_status(sk, hdev->id, MGMT_OP_SET_CONNECTABLE,
-				  MGMT_STATUS_INVALID_PARAMS);
+		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_CONNECTABLE,
+				       MGMT_STATUS_INVALID_PARAMS);
 
 	hci_dev_lock(hdev);
 
@@ -1890,8 +1890,8 @@ static int set_connectable(struct sock *sk, struct hci_dev *hdev, void *data,
 
 	if (mgmt_pending_find(MGMT_OP_SET_DISCOVERABLE, hdev) ||
 	    mgmt_pending_find(MGMT_OP_SET_CONNECTABLE, hdev)) {
-		err = cmd_status(sk, hdev->id, MGMT_OP_SET_CONNECTABLE,
-				 MGMT_STATUS_BUSY);
+		err = mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_CONNECTABLE,
+				      MGMT_STATUS_BUSY);
 		goto failed;
 	}
 
@@ -1976,8 +1976,8 @@ static int set_bondable(struct sock *sk, struct hci_dev *hdev, void *data,
 	BT_DBG("request for %s", hdev->name);
 
 	if (cp->val != 0x00 && cp->val != 0x01)
-		return cmd_status(sk, hdev->id, MGMT_OP_SET_BONDABLE,
-				  MGMT_STATUS_INVALID_PARAMS);
+		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_BONDABLE,
+				       MGMT_STATUS_INVALID_PARAMS);
 
 	hci_dev_lock(hdev);
 
@@ -2010,12 +2010,12 @@ static int set_link_security(struct sock *sk, struct hci_dev *hdev, void *data,
 
 	status = mgmt_bredr_support(hdev);
 	if (status)
-		return cmd_status(sk, hdev->id, MGMT_OP_SET_LINK_SECURITY,
-				  status);
+		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_LINK_SECURITY,
+				       status);
 
 	if (cp->val != 0x00 && cp->val != 0x01)
-		return cmd_status(sk, hdev->id, MGMT_OP_SET_LINK_SECURITY,
-				  MGMT_STATUS_INVALID_PARAMS);
+		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_LINK_SECURITY,
+				       MGMT_STATUS_INVALID_PARAMS);
 
 	hci_dev_lock(hdev);
 
@@ -2039,8 +2039,8 @@ static int set_link_security(struct sock *sk, struct hci_dev *hdev, void *data,
 	}
 
 	if (mgmt_pending_find(MGMT_OP_SET_LINK_SECURITY, hdev)) {
-		err = cmd_status(sk, hdev->id, MGMT_OP_SET_LINK_SECURITY,
-				 MGMT_STATUS_BUSY);
+		err = mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_LINK_SECURITY,
+				      MGMT_STATUS_BUSY);
 		goto failed;
 	}
 
@@ -2079,15 +2079,15 @@ static int set_ssp(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 
 	status = mgmt_bredr_support(hdev);
 	if (status)
-		return cmd_status(sk, hdev->id, MGMT_OP_SET_SSP, status);
+		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_SSP, status);
 
 	if (!lmp_ssp_capable(hdev))
-		return cmd_status(sk, hdev->id, MGMT_OP_SET_SSP,
-				  MGMT_STATUS_NOT_SUPPORTED);
+		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_SSP,
+				       MGMT_STATUS_NOT_SUPPORTED);
 
 	if (cp->val != 0x00 && cp->val != 0x01)
-		return cmd_status(sk, hdev->id, MGMT_OP_SET_SSP,
-				  MGMT_STATUS_INVALID_PARAMS);
+		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_SSP,
+				       MGMT_STATUS_INVALID_PARAMS);
 
 	hci_dev_lock(hdev);
 
@@ -2118,8 +2118,8 @@ static int set_ssp(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 	}
 
 	if (mgmt_pending_find(MGMT_OP_SET_SSP, hdev)) {
-		err = cmd_status(sk, hdev->id, MGMT_OP_SET_SSP,
-				 MGMT_STATUS_BUSY);
+		err = mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_SSP,
+				      MGMT_STATUS_BUSY);
 		goto failed;
 	}
 
@@ -2160,25 +2160,25 @@ static int set_hs(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 
 	status = mgmt_bredr_support(hdev);
 	if (status)
-		return cmd_status(sk, hdev->id, MGMT_OP_SET_HS, status);
+		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_HS, status);
 
 	if (!lmp_ssp_capable(hdev))
-		return cmd_status(sk, hdev->id, MGMT_OP_SET_HS,
-				  MGMT_STATUS_NOT_SUPPORTED);
+		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_HS,
+				       MGMT_STATUS_NOT_SUPPORTED);
 
 	if (!test_bit(HCI_SSP_ENABLED, &hdev->dev_flags))
-		return cmd_status(sk, hdev->id, MGMT_OP_SET_HS,
-				  MGMT_STATUS_REJECTED);
+		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_HS,
+				       MGMT_STATUS_REJECTED);
 
 	if (cp->val != 0x00 && cp->val != 0x01)
-		return cmd_status(sk, hdev->id, MGMT_OP_SET_HS,
-				  MGMT_STATUS_INVALID_PARAMS);
+		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_HS,
+				       MGMT_STATUS_INVALID_PARAMS);
 
 	hci_dev_lock(hdev);
 
 	if (mgmt_pending_find(MGMT_OP_SET_SSP, hdev)) {
-		err = cmd_status(sk, hdev->id, MGMT_OP_SET_HS,
-				 MGMT_STATUS_BUSY);
+		err = mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_HS,
+				      MGMT_STATUS_BUSY);
 		goto unlock;
 	}
 
@@ -2186,8 +2186,8 @@ static int set_hs(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 		changed = !test_and_set_bit(HCI_HS_ENABLED, &hdev->dev_flags);
 	} else {
 		if (hdev_is_powered(hdev)) {
-			err = cmd_status(sk, hdev->id, MGMT_OP_SET_HS,
-					 MGMT_STATUS_REJECTED);
+			err = mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_HS,
+					      MGMT_STATUS_REJECTED);
 			goto unlock;
 		}
 
@@ -2258,17 +2258,17 @@ static int set_le(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 	BT_DBG("request for %s", hdev->name);
 
 	if (!lmp_le_capable(hdev))
-		return cmd_status(sk, hdev->id, MGMT_OP_SET_LE,
-				  MGMT_STATUS_NOT_SUPPORTED);
+		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_LE,
+				       MGMT_STATUS_NOT_SUPPORTED);
 
 	if (cp->val != 0x00 && cp->val != 0x01)
-		return cmd_status(sk, hdev->id, MGMT_OP_SET_LE,
-				  MGMT_STATUS_INVALID_PARAMS);
+		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_LE,
+				       MGMT_STATUS_INVALID_PARAMS);
 
 	/* LE-only devices do not allow toggling LE on/off */
 	if (!test_bit(HCI_BREDR_ENABLED, &hdev->dev_flags))
-		return cmd_status(sk, hdev->id, MGMT_OP_SET_LE,
-				  MGMT_STATUS_REJECTED);
+		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_LE,
+				       MGMT_STATUS_REJECTED);
 
 	hci_dev_lock(hdev);
 
@@ -2300,8 +2300,8 @@ static int set_le(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 
 	if (mgmt_pending_find(MGMT_OP_SET_LE, hdev) ||
 	    mgmt_pending_find(MGMT_OP_SET_ADVERTISING, hdev)) {
-		err = cmd_status(sk, hdev->id, MGMT_OP_SET_LE,
-				 MGMT_STATUS_BUSY);
+		err = mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_LE,
+				      MGMT_STATUS_BUSY);
 		goto unlock;
 	}
 
@@ -2416,8 +2416,8 @@ static int add_uuid(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 	hci_dev_lock(hdev);
 
 	if (pending_eir_or_class(hdev)) {
-		err = cmd_status(sk, hdev->id, MGMT_OP_ADD_UUID,
-				 MGMT_STATUS_BUSY);
+		err = mgmt_cmd_status(sk, hdev->id, MGMT_OP_ADD_UUID,
+				      MGMT_STATUS_BUSY);
 		goto failed;
 	}
 
@@ -2497,8 +2497,8 @@ static int remove_uuid(struct sock *sk, struct hci_dev *hdev, void *data,
 	hci_dev_lock(hdev);
 
 	if (pending_eir_or_class(hdev)) {
-		err = cmd_status(sk, hdev->id, MGMT_OP_REMOVE_UUID,
-				 MGMT_STATUS_BUSY);
+		err = mgmt_cmd_status(sk, hdev->id, MGMT_OP_REMOVE_UUID,
+				      MGMT_STATUS_BUSY);
 		goto unlock;
 	}
 
@@ -2526,8 +2526,8 @@ static int remove_uuid(struct sock *sk, struct hci_dev *hdev, void *data,
 	}
 
 	if (found == 0) {
-		err = cmd_status(sk, hdev->id, MGMT_OP_REMOVE_UUID,
-				 MGMT_STATUS_INVALID_PARAMS);
+		err = mgmt_cmd_status(sk, hdev->id, MGMT_OP_REMOVE_UUID,
+				      MGMT_STATUS_INVALID_PARAMS);
 		goto unlock;
 	}
 
@@ -2578,20 +2578,20 @@ static int set_dev_class(struct sock *sk, struct hci_dev *hdev, void *data,
 	BT_DBG("request for %s", hdev->name);
 
 	if (!lmp_bredr_capable(hdev))
-		return cmd_status(sk, hdev->id, MGMT_OP_SET_DEV_CLASS,
-				  MGMT_STATUS_NOT_SUPPORTED);
+		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_DEV_CLASS,
+				       MGMT_STATUS_NOT_SUPPORTED);
 
 	hci_dev_lock(hdev);
 
 	if (pending_eir_or_class(hdev)) {
-		err = cmd_status(sk, hdev->id, MGMT_OP_SET_DEV_CLASS,
-				 MGMT_STATUS_BUSY);
+		err = mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_DEV_CLASS,
+				      MGMT_STATUS_BUSY);
 		goto unlock;
 	}
 
 	if ((cp->minor & 0x03) != 0 || (cp->major & 0xe0) != 0) {
-		err = cmd_status(sk, hdev->id, MGMT_OP_SET_DEV_CLASS,
-				 MGMT_STATUS_INVALID_PARAMS);
+		err = mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_DEV_CLASS,
+				      MGMT_STATUS_INVALID_PARAMS);
 		goto unlock;
 	}
 
@@ -2651,15 +2651,15 @@ static int load_link_keys(struct sock *sk, struct hci_dev *hdev, void *data,
 	BT_DBG("request for %s", hdev->name);
 
 	if (!lmp_bredr_capable(hdev))
-		return cmd_status(sk, hdev->id, MGMT_OP_LOAD_LINK_KEYS,
-				  MGMT_STATUS_NOT_SUPPORTED);
+		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_LOAD_LINK_KEYS,
+				       MGMT_STATUS_NOT_SUPPORTED);
 
 	key_count = __le16_to_cpu(cp->key_count);
 	if (key_count > max_key_count) {
 		BT_ERR("load_link_keys: too big key_count value %u",
 		       key_count);
-		return cmd_status(sk, hdev->id, MGMT_OP_LOAD_LINK_KEYS,
-				  MGMT_STATUS_INVALID_PARAMS);
+		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_LOAD_LINK_KEYS,
+				       MGMT_STATUS_INVALID_PARAMS);
 	}
 
 	expected_len = sizeof(*cp) + key_count *
@@ -2667,13 +2667,13 @@ static int load_link_keys(struct sock *sk, struct hci_dev *hdev, void *data,
 	if (expected_len != len) {
 		BT_ERR("load_link_keys: expected %u bytes, got %u bytes",
 		       expected_len, len);
-		return cmd_status(sk, hdev->id, MGMT_OP_LOAD_LINK_KEYS,
-				  MGMT_STATUS_INVALID_PARAMS);
+		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_LOAD_LINK_KEYS,
+				       MGMT_STATUS_INVALID_PARAMS);
 	}
 
 	if (cp->debug_keys != 0x00 && cp->debug_keys != 0x01)
-		return cmd_status(sk, hdev->id, MGMT_OP_LOAD_LINK_KEYS,
-				  MGMT_STATUS_INVALID_PARAMS);
+		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_LOAD_LINK_KEYS,
+				       MGMT_STATUS_INVALID_PARAMS);
 
 	BT_DBG("%s debug_keys %u key_count %u", hdev->name, cp->debug_keys,
 	       key_count);
@@ -2682,8 +2682,9 @@ static int load_link_keys(struct sock *sk, struct hci_dev *hdev, void *data,
 		struct mgmt_link_key_info *key = &cp->keys[i];
 
 		if (key->addr.type != BDADDR_BREDR || key->type > 0x08)
-			return cmd_status(sk, hdev->id, MGMT_OP_LOAD_LINK_KEYS,
-					  MGMT_STATUS_INVALID_PARAMS);
+			return mgmt_cmd_status(sk, hdev->id,
+					       MGMT_OP_LOAD_LINK_KEYS,
+					       MGMT_STATUS_INVALID_PARAMS);
 	}
 
 	hci_dev_lock(hdev);
@@ -2941,8 +2942,8 @@ static int get_connections(struct sock *sk, struct hci_dev *hdev, void *data,
 	hci_dev_lock(hdev);
 
 	if (!hdev_is_powered(hdev)) {
-		err = cmd_status(sk, hdev->id, MGMT_OP_GET_CONNECTIONS,
-				 MGMT_STATUS_NOT_POWERED);
+		err = mgmt_cmd_status(sk, hdev->id, MGMT_OP_GET_CONNECTIONS,
+				      MGMT_STATUS_NOT_POWERED);
 		goto unlock;
 	}
 
@@ -3018,15 +3019,15 @@ static int pin_code_reply(struct sock *sk, struct hci_dev *hdev, void *data,
 	hci_dev_lock(hdev);
 
 	if (!hdev_is_powered(hdev)) {
-		err = cmd_status(sk, hdev->id, MGMT_OP_PIN_CODE_REPLY,
-				 MGMT_STATUS_NOT_POWERED);
+		err = mgmt_cmd_status(sk, hdev->id, MGMT_OP_PIN_CODE_REPLY,
+				      MGMT_STATUS_NOT_POWERED);
 		goto failed;
 	}
 
 	conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, &cp->addr.bdaddr);
 	if (!conn) {
-		err = cmd_status(sk, hdev->id, MGMT_OP_PIN_CODE_REPLY,
-				 MGMT_STATUS_NOT_CONNECTED);
+		err = mgmt_cmd_status(sk, hdev->id, MGMT_OP_PIN_CODE_REPLY,
+				      MGMT_STATUS_NOT_CONNECTED);
 		goto failed;
 	}
 
@@ -3039,8 +3040,8 @@ static int pin_code_reply(struct sock *sk, struct hci_dev *hdev, void *data,
 
 		err = send_pin_code_neg_reply(sk, hdev, &ncp);
 		if (err >= 0)
-			err = cmd_status(sk, hdev->id, MGMT_OP_PIN_CODE_REPLY,
-					 MGMT_STATUS_INVALID_PARAMS);
+			err = mgmt_cmd_status(sk, hdev->id, MGMT_OP_PIN_CODE_REPLY,
+					      MGMT_STATUS_INVALID_PARAMS);
 
 		goto failed;
 	}
@@ -3324,23 +3325,23 @@ static int cancel_pair_device(struct sock *sk, struct hci_dev *hdev, void *data,
 	hci_dev_lock(hdev);
 
 	if (!hdev_is_powered(hdev)) {
-		err = cmd_status(sk, hdev->id, MGMT_OP_CANCEL_PAIR_DEVICE,
-				 MGMT_STATUS_NOT_POWERED);
+		err = mgmt_cmd_status(sk, hdev->id, MGMT_OP_CANCEL_PAIR_DEVICE,
+				      MGMT_STATUS_NOT_POWERED);
 		goto unlock;
 	}
 
 	cmd = mgmt_pending_find(MGMT_OP_PAIR_DEVICE, hdev);
 	if (!cmd) {
-		err = cmd_status(sk, hdev->id, MGMT_OP_CANCEL_PAIR_DEVICE,
-				 MGMT_STATUS_INVALID_PARAMS);
+		err = mgmt_cmd_status(sk, hdev->id, MGMT_OP_CANCEL_PAIR_DEVICE,
+				      MGMT_STATUS_INVALID_PARAMS);
 		goto unlock;
 	}
 
 	conn = cmd->user_data;
 
 	if (bacmp(&addr->bdaddr, &conn->dst) != 0) {
-		err = cmd_status(sk, hdev->id, MGMT_OP_CANCEL_PAIR_DEVICE,
-				 MGMT_STATUS_INVALID_PARAMS);
+		err = mgmt_cmd_status(sk, hdev->id, MGMT_OP_CANCEL_PAIR_DEVICE,
+				      MGMT_STATUS_INVALID_PARAMS);
 		goto unlock;
 	}
 
@@ -3444,8 +3445,8 @@ static int user_confirm_reply(struct sock *sk, struct hci_dev *hdev, void *data,
 	BT_DBG("");
 
 	if (len != sizeof(*cp))
-		return cmd_status(sk, hdev->id, MGMT_OP_USER_CONFIRM_REPLY,
-				  MGMT_STATUS_INVALID_PARAMS);
+		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_USER_CONFIRM_REPLY,
+				       MGMT_STATUS_INVALID_PARAMS);
 
 	return user_pairing_resp(sk, hdev, &cp->addr,
 				 MGMT_OP_USER_CONFIRM_REPLY,
@@ -3514,8 +3515,8 @@ static void set_name_complete(struct hci_dev *hdev, u8 status, u16 opcode)
 	cp = cmd->param;
 
 	if (status)
-		cmd_status(cmd->sk, hdev->id, MGMT_OP_SET_LOCAL_NAME,
-			   mgmt_status(status));
+		mgmt_cmd_status(cmd->sk, hdev->id, MGMT_OP_SET_LOCAL_NAME,
+			        mgmt_status(status));
 	else
 		cmd_complete(cmd->sk, hdev->id, MGMT_OP_SET_LOCAL_NAME, 0,
 			     cp, sizeof(*cp));
@@ -3606,20 +3607,20 @@ static int read_local_oob_data(struct sock *sk, struct hci_dev *hdev,
 	hci_dev_lock(hdev);
 
 	if (!hdev_is_powered(hdev)) {
-		err = cmd_status(sk, hdev->id, MGMT_OP_READ_LOCAL_OOB_DATA,
-				 MGMT_STATUS_NOT_POWERED);
+		err = mgmt_cmd_status(sk, hdev->id, MGMT_OP_READ_LOCAL_OOB_DATA,
+				      MGMT_STATUS_NOT_POWERED);
 		goto unlock;
 	}
 
 	if (!lmp_ssp_capable(hdev)) {
-		err = cmd_status(sk, hdev->id, MGMT_OP_READ_LOCAL_OOB_DATA,
-				 MGMT_STATUS_NOT_SUPPORTED);
+		err = mgmt_cmd_status(sk, hdev->id, MGMT_OP_READ_LOCAL_OOB_DATA,
+				      MGMT_STATUS_NOT_SUPPORTED);
 		goto unlock;
 	}
 
 	if (mgmt_pending_find(MGMT_OP_READ_LOCAL_OOB_DATA, hdev)) {
-		err = cmd_status(sk, hdev->id, MGMT_OP_READ_LOCAL_OOB_DATA,
-				 MGMT_STATUS_BUSY);
+		err = mgmt_cmd_status(sk, hdev->id, MGMT_OP_READ_LOCAL_OOB_DATA,
+				      MGMT_STATUS_BUSY);
 		goto unlock;
 	}
 
@@ -3738,8 +3739,8 @@ static int add_remote_oob_data(struct sock *sk, struct hci_dev *hdev,
 				   status, &cp->addr, sizeof(cp->addr));
 	} else {
 		BT_ERR("add_remote_oob_data: invalid length of %u bytes", len);
-		err = cmd_status(sk, hdev->id, MGMT_OP_ADD_REMOTE_OOB_DATA,
-				 MGMT_STATUS_INVALID_PARAMS);
+		err = mgmt_cmd_status(sk, hdev->id, MGMT_OP_ADD_REMOTE_OOB_DATA,
+				      MGMT_STATUS_INVALID_PARAMS);
 	}
 
 unlock:
@@ -4332,8 +4333,8 @@ static int set_device_id(struct sock *sk, struct hci_dev *hdev, void *data,
 	source = __le16_to_cpu(cp->source);
 
 	if (source > 0x0002)
-		return cmd_status(sk, hdev->id, MGMT_OP_SET_DEVICE_ID,
-				  MGMT_STATUS_INVALID_PARAMS);
+		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_DEVICE_ID,
+				       MGMT_STATUS_INVALID_PARAMS);
 
 	hci_dev_lock(hdev);
 
@@ -4398,12 +4399,12 @@ static int set_advertising(struct sock *sk, struct hci_dev *hdev, void *data,
 
 	status = mgmt_le_support(hdev);
 	if (status)
-		return cmd_status(sk, hdev->id, MGMT_OP_SET_ADVERTISING,
-				  status);
+		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_ADVERTISING,
+				       status);
 
 	if (cp->val != 0x00 && cp->val != 0x01)
-		return cmd_status(sk, hdev->id, MGMT_OP_SET_ADVERTISING,
-				  MGMT_STATUS_INVALID_PARAMS);
+		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_ADVERTISING,
+				       MGMT_STATUS_INVALID_PARAMS);
 
 	hci_dev_lock(hdev);
 
@@ -4438,8 +4439,8 @@ static int set_advertising(struct sock *sk, struct hci_dev *hdev, void *data,
 
 	if (mgmt_pending_find(MGMT_OP_SET_ADVERTISING, hdev) ||
 	    mgmt_pending_find(MGMT_OP_SET_LE, hdev)) {
-		err = cmd_status(sk, hdev->id, MGMT_OP_SET_ADVERTISING,
-				 MGMT_STATUS_BUSY);
+		err = mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_ADVERTISING,
+				      MGMT_STATUS_BUSY);
 		goto unlock;
 	}
 
@@ -4474,24 +4475,24 @@ static int set_static_address(struct sock *sk, struct hci_dev *hdev,
 	BT_DBG("%s", hdev->name);
 
 	if (!lmp_le_capable(hdev))
-		return cmd_status(sk, hdev->id, MGMT_OP_SET_STATIC_ADDRESS,
-				  MGMT_STATUS_NOT_SUPPORTED);
+		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_STATIC_ADDRESS,
+				       MGMT_STATUS_NOT_SUPPORTED);
 
 	if (hdev_is_powered(hdev))
-		return cmd_status(sk, hdev->id, MGMT_OP_SET_STATIC_ADDRESS,
-				  MGMT_STATUS_REJECTED);
+		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_STATIC_ADDRESS,
+				       MGMT_STATUS_REJECTED);
 
 	if (bacmp(&cp->bdaddr, BDADDR_ANY)) {
 		if (!bacmp(&cp->bdaddr, BDADDR_NONE))
-			return cmd_status(sk, hdev->id,
-					  MGMT_OP_SET_STATIC_ADDRESS,
-					  MGMT_STATUS_INVALID_PARAMS);
+			return mgmt_cmd_status(sk, hdev->id,
+					       MGMT_OP_SET_STATIC_ADDRESS,
+					       MGMT_STATUS_INVALID_PARAMS);
 
 		/* Two most significant bits shall be set */
 		if ((cp->bdaddr.b[5] & 0xc0) != 0xc0)
-			return cmd_status(sk, hdev->id,
-					  MGMT_OP_SET_STATIC_ADDRESS,
-					  MGMT_STATUS_INVALID_PARAMS);
+			return mgmt_cmd_status(sk, hdev->id,
+					       MGMT_OP_SET_STATIC_ADDRESS,
+					       MGMT_STATUS_INVALID_PARAMS);
 	}
 
 	hci_dev_lock(hdev);
@@ -4515,24 +4516,24 @@ static int set_scan_params(struct sock *sk, struct hci_dev *hdev,
 	BT_DBG("%s", hdev->name);
 
 	if (!lmp_le_capable(hdev))
-		return cmd_status(sk, hdev->id, MGMT_OP_SET_SCAN_PARAMS,
-				  MGMT_STATUS_NOT_SUPPORTED);
+		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_SCAN_PARAMS,
+				       MGMT_STATUS_NOT_SUPPORTED);
 
 	interval = __le16_to_cpu(cp->interval);
 
 	if (interval < 0x0004 || interval > 0x4000)
-		return cmd_status(sk, hdev->id, MGMT_OP_SET_SCAN_PARAMS,
-				  MGMT_STATUS_INVALID_PARAMS);
+		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_SCAN_PARAMS,
+				       MGMT_STATUS_INVALID_PARAMS);
 
 	window = __le16_to_cpu(cp->window);
 
 	if (window < 0x0004 || window > 0x4000)
-		return cmd_status(sk, hdev->id, MGMT_OP_SET_SCAN_PARAMS,
-				  MGMT_STATUS_INVALID_PARAMS);
+		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_SCAN_PARAMS,
+				       MGMT_STATUS_INVALID_PARAMS);
 
 	if (window > interval)
-		return cmd_status(sk, hdev->id, MGMT_OP_SET_SCAN_PARAMS,
-				  MGMT_STATUS_INVALID_PARAMS);
+		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_SCAN_PARAMS,
+				       MGMT_STATUS_INVALID_PARAMS);
 
 	hci_dev_lock(hdev);
 
@@ -4575,8 +4576,8 @@ static void fast_connectable_complete(struct hci_dev *hdev, u8 status,
 		goto unlock;
 
 	if (status) {
-		cmd_status(cmd->sk, hdev->id, MGMT_OP_SET_FAST_CONNECTABLE,
-			   mgmt_status(status));
+		mgmt_cmd_status(cmd->sk, hdev->id, MGMT_OP_SET_FAST_CONNECTABLE,
+			        mgmt_status(status));
 	} else {
 		struct mgmt_mode *cp = cmd->param;
 
@@ -4607,26 +4608,26 @@ static int set_fast_connectable(struct sock *sk, struct hci_dev *hdev,
 
 	if (!test_bit(HCI_BREDR_ENABLED, &hdev->dev_flags) ||
 	    hdev->hci_ver < BLUETOOTH_VER_1_2)
-		return cmd_status(sk, hdev->id, MGMT_OP_SET_FAST_CONNECTABLE,
-				  MGMT_STATUS_NOT_SUPPORTED);
+		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_FAST_CONNECTABLE,
+				       MGMT_STATUS_NOT_SUPPORTED);
 
 	if (cp->val != 0x00 && cp->val != 0x01)
-		return cmd_status(sk, hdev->id, MGMT_OP_SET_FAST_CONNECTABLE,
-				  MGMT_STATUS_INVALID_PARAMS);
+		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_FAST_CONNECTABLE,
+				       MGMT_STATUS_INVALID_PARAMS);
 
 	if (!hdev_is_powered(hdev))
-		return cmd_status(sk, hdev->id, MGMT_OP_SET_FAST_CONNECTABLE,
-				  MGMT_STATUS_NOT_POWERED);
+		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_FAST_CONNECTABLE,
+				       MGMT_STATUS_NOT_POWERED);
 
 	if (!test_bit(HCI_CONNECTABLE, &hdev->dev_flags))
-		return cmd_status(sk, hdev->id, MGMT_OP_SET_FAST_CONNECTABLE,
-				  MGMT_STATUS_REJECTED);
+		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_FAST_CONNECTABLE,
+				       MGMT_STATUS_REJECTED);
 
 	hci_dev_lock(hdev);
 
 	if (mgmt_pending_find(MGMT_OP_SET_FAST_CONNECTABLE, hdev)) {
-		err = cmd_status(sk, hdev->id, MGMT_OP_SET_FAST_CONNECTABLE,
-				 MGMT_STATUS_BUSY);
+		err = mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_FAST_CONNECTABLE,
+				      MGMT_STATUS_BUSY);
 		goto unlock;
 	}
 
@@ -4649,8 +4650,8 @@ static int set_fast_connectable(struct sock *sk, struct hci_dev *hdev,
 
 	err = hci_req_run(&req, fast_connectable_complete);
 	if (err < 0) {
-		err = cmd_status(sk, hdev->id, MGMT_OP_SET_FAST_CONNECTABLE,
-				 MGMT_STATUS_FAILED);
+		err = mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_FAST_CONNECTABLE,
+				      MGMT_STATUS_FAILED);
 		mgmt_pending_remove(cmd);
 	}
 
@@ -4680,7 +4681,7 @@ static void set_bredr_complete(struct hci_dev *hdev, u8 status, u16 opcode)
 		 */
 		clear_bit(HCI_BREDR_ENABLED, &hdev->dev_flags);
 
-		cmd_status(cmd->sk, cmd->index, cmd->opcode, mgmt_err);
+		mgmt_cmd_status(cmd->sk, cmd->index, cmd->opcode, mgmt_err);
 	} else {
 		send_settings_rsp(cmd->sk, MGMT_OP_SET_BREDR, hdev);
 		new_settings(hdev, cmd->sk);
@@ -4702,16 +4703,16 @@ static int set_bredr(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 	BT_DBG("request for %s", hdev->name);
 
 	if (!lmp_bredr_capable(hdev) || !lmp_le_capable(hdev))
-		return cmd_status(sk, hdev->id, MGMT_OP_SET_BREDR,
-				  MGMT_STATUS_NOT_SUPPORTED);
+		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_BREDR,
+				       MGMT_STATUS_NOT_SUPPORTED);
 
 	if (!test_bit(HCI_LE_ENABLED, &hdev->dev_flags))
-		return cmd_status(sk, hdev->id, MGMT_OP_SET_BREDR,
-				  MGMT_STATUS_REJECTED);
+		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_BREDR,
+				       MGMT_STATUS_REJECTED);
 
 	if (cp->val != 0x00 && cp->val != 0x01)
-		return cmd_status(sk, hdev->id, MGMT_OP_SET_BREDR,
-				  MGMT_STATUS_INVALID_PARAMS);
+		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_BREDR,
+				       MGMT_STATUS_INVALID_PARAMS);
 
 	hci_dev_lock(hdev);
 
@@ -4741,8 +4742,8 @@ static int set_bredr(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 
 	/* Reject disabling when powered on */
 	if (!cp->val) {
-		err = cmd_status(sk, hdev->id, MGMT_OP_SET_BREDR,
-				 MGMT_STATUS_REJECTED);
+		err = mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_BREDR,
+				      MGMT_STATUS_REJECTED);
 		goto unlock;
 	} else {
 		/* When configuring a dual-mode controller to operate
@@ -4762,15 +4763,15 @@ static int set_bredr(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 		if (!test_bit(HCI_BREDR_ENABLED, &hdev->dev_flags) &&
 		    (bacmp(&hdev->static_addr, BDADDR_ANY) ||
 		     test_bit(HCI_SC_ENABLED, &hdev->dev_flags))) {
-			err = cmd_status(sk, hdev->id, MGMT_OP_SET_BREDR,
-					 MGMT_STATUS_REJECTED);
+			err = mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_BREDR,
+					      MGMT_STATUS_REJECTED);
 			goto unlock;
 		}
 	}
 
 	if (mgmt_pending_find(MGMT_OP_SET_BREDR, hdev)) {
-		err = cmd_status(sk, hdev->id, MGMT_OP_SET_BREDR,
-				 MGMT_STATUS_BUSY);
+		err = mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_BREDR,
+				      MGMT_STATUS_BUSY);
 		goto unlock;
 	}
 
@@ -4818,8 +4819,8 @@ static void sc_enable_complete(struct hci_dev *hdev, u8 status, u16 opcode)
 		goto unlock;
 
 	if (status) {
-		cmd_status(cmd->sk, cmd->index, cmd->opcode,
-			   mgmt_status(status));
+		mgmt_cmd_status(cmd->sk, cmd->index, cmd->opcode,
+			        mgmt_status(status));
 		goto remove;
 	}
 
@@ -4862,17 +4863,17 @@ static int set_secure_conn(struct sock *sk, struct hci_dev *hdev,
 
 	if (!lmp_sc_capable(hdev) &&
 	    !test_bit(HCI_LE_ENABLED, &hdev->dev_flags))
-		return cmd_status(sk, hdev->id, MGMT_OP_SET_SECURE_CONN,
-				  MGMT_STATUS_NOT_SUPPORTED);
+		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_SECURE_CONN,
+				       MGMT_STATUS_NOT_SUPPORTED);
 
 	if (test_bit(HCI_BREDR_ENABLED, &hdev->dev_flags) &&
 	    lmp_sc_capable(hdev) &&
 	    !test_bit(HCI_SSP_ENABLED, &hdev->dev_flags))
-		return cmd_status(sk, hdev->id, MGMT_OP_SET_SECURE_CONN,
-				  MGMT_STATUS_REJECTED);
+		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_SECURE_CONN,
+				       MGMT_STATUS_REJECTED);
 
 	if (cp->val != 0x00 && cp->val != 0x01 && cp->val != 0x02)
-		return cmd_status(sk, hdev->id, MGMT_OP_SET_SECURE_CONN,
+		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_SECURE_CONN,
 				  MGMT_STATUS_INVALID_PARAMS);
 
 	hci_dev_lock(hdev);
@@ -4905,8 +4906,8 @@ static int set_secure_conn(struct sock *sk, struct hci_dev *hdev,
 	}
 
 	if (mgmt_pending_find(MGMT_OP_SET_SECURE_CONN, hdev)) {
-		err = cmd_status(sk, hdev->id, MGMT_OP_SET_SECURE_CONN,
-				 MGMT_STATUS_BUSY);
+		err = mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_SECURE_CONN,
+				      MGMT_STATUS_BUSY);
 		goto failed;
 	}
 
@@ -4947,8 +4948,8 @@ static int set_debug_keys(struct sock *sk, struct hci_dev *hdev,
 	BT_DBG("request for %s", hdev->name);
 
 	if (cp->val != 0x00 && cp->val != 0x01 && cp->val != 0x02)
-		return cmd_status(sk, hdev->id, MGMT_OP_SET_DEBUG_KEYS,
-				  MGMT_STATUS_INVALID_PARAMS);
+		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_DEBUG_KEYS,
+				       MGMT_STATUS_INVALID_PARAMS);
 
 	hci_dev_lock(hdev);
 
@@ -4995,16 +4996,16 @@ static int set_privacy(struct sock *sk, struct hci_dev *hdev, void *cp_data,
 	BT_DBG("request for %s", hdev->name);
 
 	if (!lmp_le_capable(hdev))
-		return cmd_status(sk, hdev->id, MGMT_OP_SET_PRIVACY,
-				  MGMT_STATUS_NOT_SUPPORTED);
+		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_PRIVACY,
+				       MGMT_STATUS_NOT_SUPPORTED);
 
 	if (cp->privacy != 0x00 && cp->privacy != 0x01)
-		return cmd_status(sk, hdev->id, MGMT_OP_SET_PRIVACY,
-				  MGMT_STATUS_INVALID_PARAMS);
+		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_PRIVACY,
+				       MGMT_STATUS_INVALID_PARAMS);
 
 	if (hdev_is_powered(hdev))
-		return cmd_status(sk, hdev->id, MGMT_OP_SET_PRIVACY,
-				  MGMT_STATUS_REJECTED);
+		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_PRIVACY,
+				       MGMT_STATUS_REJECTED);
 
 	hci_dev_lock(hdev);
 
@@ -5063,22 +5064,22 @@ static int load_irks(struct sock *sk, struct hci_dev *hdev, void *cp_data,
 	BT_DBG("request for %s", hdev->name);
 
 	if (!lmp_le_capable(hdev))
-		return cmd_status(sk, hdev->id, MGMT_OP_LOAD_IRKS,
-				  MGMT_STATUS_NOT_SUPPORTED);
+		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_LOAD_IRKS,
+				       MGMT_STATUS_NOT_SUPPORTED);
 
 	irk_count = __le16_to_cpu(cp->irk_count);
 	if (irk_count > max_irk_count) {
 		BT_ERR("load_irks: too big irk_count value %u", irk_count);
-		return cmd_status(sk, hdev->id, MGMT_OP_LOAD_IRKS,
-				  MGMT_STATUS_INVALID_PARAMS);
+		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_LOAD_IRKS,
+				       MGMT_STATUS_INVALID_PARAMS);
 	}
 
 	expected_len = sizeof(*cp) + irk_count * sizeof(struct mgmt_irk_info);
 	if (expected_len != len) {
 		BT_ERR("load_irks: expected %u bytes, got %u bytes",
 		       expected_len, len);
-		return cmd_status(sk, hdev->id, MGMT_OP_LOAD_IRKS,
-				  MGMT_STATUS_INVALID_PARAMS);
+		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_LOAD_IRKS,
+				       MGMT_STATUS_INVALID_PARAMS);
 	}
 
 	BT_DBG("%s irk_count %u", hdev->name, irk_count);
@@ -5087,9 +5088,9 @@ static int load_irks(struct sock *sk, struct hci_dev *hdev, void *cp_data,
 		struct mgmt_irk_info *key = &cp->irks[i];
 
 		if (!irk_is_valid(key))
-			return cmd_status(sk, hdev->id,
-					  MGMT_OP_LOAD_IRKS,
-					  MGMT_STATUS_INVALID_PARAMS);
+			return mgmt_cmd_status(sk, hdev->id,
+					       MGMT_OP_LOAD_IRKS,
+					       MGMT_STATUS_INVALID_PARAMS);
 	}
 
 	hci_dev_lock(hdev);
@@ -5149,14 +5150,14 @@ static int load_long_term_keys(struct sock *sk, struct hci_dev *hdev,
 	BT_DBG("request for %s", hdev->name);
 
 	if (!lmp_le_capable(hdev))
-		return cmd_status(sk, hdev->id, MGMT_OP_LOAD_LONG_TERM_KEYS,
-				  MGMT_STATUS_NOT_SUPPORTED);
+		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_LOAD_LONG_TERM_KEYS,
+				       MGMT_STATUS_NOT_SUPPORTED);
 
 	key_count = __le16_to_cpu(cp->key_count);
 	if (key_count > max_key_count) {
 		BT_ERR("load_ltks: too big key_count value %u", key_count);
-		return cmd_status(sk, hdev->id, MGMT_OP_LOAD_LONG_TERM_KEYS,
-				  MGMT_STATUS_INVALID_PARAMS);
+		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_LOAD_LONG_TERM_KEYS,
+				       MGMT_STATUS_INVALID_PARAMS);
 	}
 
 	expected_len = sizeof(*cp) + key_count *
@@ -5164,8 +5165,8 @@ static int load_long_term_keys(struct sock *sk, struct hci_dev *hdev,
 	if (expected_len != len) {
 		BT_ERR("load_keys: expected %u bytes, got %u bytes",
 		       expected_len, len);
-		return cmd_status(sk, hdev->id, MGMT_OP_LOAD_LONG_TERM_KEYS,
-				  MGMT_STATUS_INVALID_PARAMS);
+		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_LOAD_LONG_TERM_KEYS,
+				       MGMT_STATUS_INVALID_PARAMS);
 	}
 
 	BT_DBG("%s key_count %u", hdev->name, key_count);
@@ -5174,9 +5175,9 @@ static int load_long_term_keys(struct sock *sk, struct hci_dev *hdev,
 		struct mgmt_ltk_info *key = &cp->keys[i];
 
 		if (!ltk_is_valid(key))
-			return cmd_status(sk, hdev->id,
-					  MGMT_OP_LOAD_LONG_TERM_KEYS,
-					  MGMT_STATUS_INVALID_PARAMS);
+			return mgmt_cmd_status(sk, hdev->id,
+					       MGMT_OP_LOAD_LONG_TERM_KEYS,
+					       MGMT_STATUS_INVALID_PARAMS);
 	}
 
 	hci_dev_lock(hdev);
@@ -5921,15 +5922,15 @@ static int load_conn_param(struct sock *sk, struct hci_dev *hdev, void *data,
 	int i;
 
 	if (!lmp_le_capable(hdev))
-		return cmd_status(sk, hdev->id, MGMT_OP_LOAD_CONN_PARAM,
-				  MGMT_STATUS_NOT_SUPPORTED);
+		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_LOAD_CONN_PARAM,
+				       MGMT_STATUS_NOT_SUPPORTED);
 
 	param_count = __le16_to_cpu(cp->param_count);
 	if (param_count > max_param_count) {
 		BT_ERR("load_conn_param: too big param_count value %u",
 		       param_count);
-		return cmd_status(sk, hdev->id, MGMT_OP_LOAD_CONN_PARAM,
-				  MGMT_STATUS_INVALID_PARAMS);
+		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_LOAD_CONN_PARAM,
+				       MGMT_STATUS_INVALID_PARAMS);
 	}
 
 	expected_len = sizeof(*cp) + param_count *
@@ -5937,8 +5938,8 @@ static int load_conn_param(struct sock *sk, struct hci_dev *hdev, void *data,
 	if (expected_len != len) {
 		BT_ERR("load_conn_param: expected %u bytes, got %u bytes",
 		       expected_len, len);
-		return cmd_status(sk, hdev->id, MGMT_OP_LOAD_CONN_PARAM,
-				  MGMT_STATUS_INVALID_PARAMS);
+		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_LOAD_CONN_PARAM,
+				       MGMT_STATUS_INVALID_PARAMS);
 	}
 
 	BT_DBG("%s param_count %u", hdev->name, param_count);
@@ -6006,16 +6007,16 @@ static int set_external_config(struct sock *sk, struct hci_dev *hdev,
 	BT_DBG("%s", hdev->name);
 
 	if (hdev_is_powered(hdev))
-		return cmd_status(sk, hdev->id, MGMT_OP_SET_EXTERNAL_CONFIG,
-				  MGMT_STATUS_REJECTED);
+		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_EXTERNAL_CONFIG,
+				       MGMT_STATUS_REJECTED);
 
 	if (cp->config != 0x00 && cp->config != 0x01)
-		return cmd_status(sk, hdev->id, MGMT_OP_SET_EXTERNAL_CONFIG,
-				    MGMT_STATUS_INVALID_PARAMS);
+		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_EXTERNAL_CONFIG,
+				         MGMT_STATUS_INVALID_PARAMS);
 
 	if (!test_bit(HCI_QUIRK_EXTERNAL_CONFIG, &hdev->quirks))
-		return cmd_status(sk, hdev->id, MGMT_OP_SET_EXTERNAL_CONFIG,
-				  MGMT_STATUS_NOT_SUPPORTED);
+		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_EXTERNAL_CONFIG,
+				       MGMT_STATUS_NOT_SUPPORTED);
 
 	hci_dev_lock(hdev);
 
@@ -6064,16 +6065,16 @@ static int set_public_address(struct sock *sk, struct hci_dev *hdev,
 	BT_DBG("%s", hdev->name);
 
 	if (hdev_is_powered(hdev))
-		return cmd_status(sk, hdev->id, MGMT_OP_SET_PUBLIC_ADDRESS,
-				  MGMT_STATUS_REJECTED);
+		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_PUBLIC_ADDRESS,
+				       MGMT_STATUS_REJECTED);
 
 	if (!bacmp(&cp->bdaddr, BDADDR_ANY))
-		return cmd_status(sk, hdev->id, MGMT_OP_SET_PUBLIC_ADDRESS,
-				  MGMT_STATUS_INVALID_PARAMS);
+		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_PUBLIC_ADDRESS,
+				       MGMT_STATUS_INVALID_PARAMS);
 
 	if (!hdev->set_bdaddr)
-		return cmd_status(sk, hdev->id, MGMT_OP_SET_PUBLIC_ADDRESS,
-				  MGMT_STATUS_NOT_SUPPORTED);
+		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_PUBLIC_ADDRESS,
+				       MGMT_STATUS_NOT_SUPPORTED);
 
 	hci_dev_lock(hdev);
 
@@ -6220,8 +6221,8 @@ int mgmt_control(struct hci_mgmt_chan *chan, struct sock *sk,
 	if (opcode >= chan->handler_count ||
 	    chan->handlers[opcode].func == NULL) {
 		BT_DBG("Unknown op %u", opcode);
-		err = cmd_status(sk, index, opcode,
-				 MGMT_STATUS_UNKNOWN_COMMAND);
+		err = mgmt_cmd_status(sk, index, opcode,
+				      MGMT_STATUS_UNKNOWN_COMMAND);
 		goto done;
 	}
 
@@ -6230,39 +6231,39 @@ int mgmt_control(struct hci_mgmt_chan *chan, struct sock *sk,
 	if (index != MGMT_INDEX_NONE) {
 		hdev = hci_dev_get(index);
 		if (!hdev) {
-			err = cmd_status(sk, index, opcode,
-					 MGMT_STATUS_INVALID_INDEX);
+			err = mgmt_cmd_status(sk, index, opcode,
+					      MGMT_STATUS_INVALID_INDEX);
 			goto done;
 		}
 
 		if (test_bit(HCI_SETUP, &hdev->dev_flags) ||
 		    test_bit(HCI_CONFIG, &hdev->dev_flags) ||
 		    test_bit(HCI_USER_CHANNEL, &hdev->dev_flags)) {
-			err = cmd_status(sk, index, opcode,
-					 MGMT_STATUS_INVALID_INDEX);
+			err = mgmt_cmd_status(sk, index, opcode,
+					      MGMT_STATUS_INVALID_INDEX);
 			goto done;
 		}
 
 		if (test_bit(HCI_UNCONFIGURED, &hdev->dev_flags) &&
 		    !(handler->flags & HCI_MGMT_UNCONFIGURED)) {
-			err = cmd_status(sk, index, opcode,
-					 MGMT_STATUS_INVALID_INDEX);
+			err = mgmt_cmd_status(sk, index, opcode,
+					      MGMT_STATUS_INVALID_INDEX);
 			goto done;
 		}
 	}
 
 	no_hdev = (handler->flags & HCI_MGMT_NO_HDEV);
 	if (no_hdev != !hdev) {
-		err = cmd_status(sk, index, opcode,
-				 MGMT_STATUS_INVALID_INDEX);
+		err = mgmt_cmd_status(sk, index, opcode,
+				      MGMT_STATUS_INVALID_INDEX);
 		goto done;
 	}
 
 	var_len = (handler->flags & HCI_MGMT_VAR_LEN);
 	if ((var_len && len < handler->data_len) ||
 	    (!var_len && len != handler->data_len)) {
-		err = cmd_status(sk, index, opcode,
-				 MGMT_STATUS_INVALID_PARAMS);
+		err = mgmt_cmd_status(sk, index, opcode,
+				      MGMT_STATUS_INVALID_PARAMS);
 		goto done;
 	}
 
@@ -6502,7 +6503,7 @@ void mgmt_set_powered_failed(struct hci_dev *hdev, int err)
 	else
 		status = MGMT_STATUS_FAILED;
 
-	cmd_status(cmd->sk, hdev->id, MGMT_OP_SET_POWERED, status);
+	mgmt_cmd_status(cmd->sk, hdev->id, MGMT_OP_SET_POWERED, status);
 
 	mgmt_pending_remove(cmd);
 }
@@ -7177,8 +7178,8 @@ void mgmt_read_local_oob_data_complete(struct hci_dev *hdev, u8 *hash192,
 		return;
 
 	if (status) {
-		cmd_status(cmd->sk, hdev->id, MGMT_OP_READ_LOCAL_OOB_DATA,
-			   mgmt_status(status));
+		mgmt_cmd_status(cmd->sk, hdev->id, MGMT_OP_READ_LOCAL_OOB_DATA,
+			        mgmt_status(status));
 	} else {
 		struct mgmt_rp_read_local_oob_data rp;
 		size_t rp_size = sizeof(rp);
-- 
2.1.0

