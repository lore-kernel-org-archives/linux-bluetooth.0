Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 5/5] Bluetooth: mgmt: Centralize message length checks
Date: Thu,  1 Mar 2012 12:33:32 -0800
Message-Id: <1330634012-4502-5-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1330634012-4502-1-git-send-email-johan.hedberg@gmail.com>
References: <1330634012-4502-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch moves the command length information into the command handler
table allowing the removal of length checks from the handler functions
and doing the check in a single place before calling the handler
function.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c |  220 ++++++++++++--------------------------------------
 1 files changed, 52 insertions(+), 168 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 88a342a..7bd7d57 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -751,10 +751,6 @@ static int set_powered(struct sock *sk, struct hci_dev *hdev, void *data,
 
 	BT_DBG("request for %s", hdev->name);
 
-	if (len != sizeof(*cp))
-		return cmd_status(sk, hdev->id, MGMT_OP_SET_POWERED,
-						MGMT_STATUS_INVALID_PARAMS);
-
 	hci_dev_lock(hdev);
 
 	if (test_and_clear_bit(HCI_AUTO_OFF, &hdev->dev_flags)) {
@@ -846,10 +842,6 @@ static int set_discoverable(struct sock *sk, struct hci_dev *hdev, void *data,
 
 	BT_DBG("request for %s", hdev->name);
 
-	if (len != sizeof(*cp))
-		return cmd_status(sk, hdev->id, MGMT_OP_SET_DISCOVERABLE,
-						MGMT_STATUS_INVALID_PARAMS);
-
 	timeout = get_unaligned_le16(&cp->timeout);
 	if (!cp->val && timeout > 0)
 		return cmd_status(sk, hdev->id, MGMT_OP_SET_DISCOVERABLE,
@@ -945,10 +937,6 @@ static int set_connectable(struct sock *sk, struct hci_dev *hdev, void *data,
 
 	BT_DBG("request for %s", hdev->name);
 
-	if (len != sizeof(*cp))
-		return cmd_status(sk, hdev->id, MGMT_OP_SET_CONNECTABLE,
-						MGMT_STATUS_INVALID_PARAMS);
-
 	hci_dev_lock(hdev);
 
 	if (!hdev_is_powered(hdev)) {
@@ -1019,10 +1007,6 @@ static int set_pairable(struct sock *sk, struct hci_dev *hdev, void *data,
 
 	BT_DBG("request for %s", hdev->name);
 
-	if (len != sizeof(*cp))
-		return cmd_status(sk, hdev->id, MGMT_OP_SET_PAIRABLE,
-						MGMT_STATUS_INVALID_PARAMS);
-
 	hci_dev_lock(hdev);
 
 	if (cp->val)
@@ -1051,10 +1035,6 @@ static int set_link_security(struct sock *sk, struct hci_dev *hdev,
 
 	BT_DBG("request for %s", hdev->name);
 
-	if (len != sizeof(*cp))
-		return cmd_status(sk, hdev->id, MGMT_OP_SET_LINK_SECURITY,
-						MGMT_STATUS_INVALID_PARAMS);
-
 	hci_dev_lock(hdev);
 
 	if (!hdev_is_powered(hdev)) {
@@ -1115,10 +1095,6 @@ static int set_ssp(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 
 	BT_DBG("request for %s", hdev->name);
 
-	if (len != sizeof(*cp))
-		return cmd_status(sk, hdev->id, MGMT_OP_SET_SSP,
-						MGMT_STATUS_INVALID_PARAMS);
-
 	hci_dev_lock(hdev);
 
 	if (!(hdev->features[6] & LMP_SIMPLE_PAIR)) {
@@ -1181,10 +1157,6 @@ static int set_hs(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 
 	BT_DBG("request for %s", hdev->name);
 
-	if (len != sizeof(*cp))
-		return cmd_status(sk, hdev->id, MGMT_OP_SET_HS,
-						MGMT_STATUS_INVALID_PARAMS);
-
 	if (!enable_hs)
 		return cmd_status(sk, hdev->id, MGMT_OP_SET_HS,
 						MGMT_STATUS_NOT_SUPPORTED);
@@ -1207,10 +1179,6 @@ static int set_le(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 
 	BT_DBG("request for %s", hdev->name);
 
-	if (len != sizeof(*cp))
-		return cmd_status(sk, hdev->id, MGMT_OP_SET_LE,
-						MGMT_STATUS_INVALID_PARAMS);
-
 	hci_dev_lock(hdev);
 
 	if (!enable_le || !(hdev->features[4] & LMP_LE)) {
@@ -1280,10 +1248,6 @@ static int add_uuid(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 
 	BT_DBG("request for %s", hdev->name);
 
-	if (len != sizeof(*cp))
-		return cmd_status(sk, hdev->id, MGMT_OP_ADD_UUID,
-						MGMT_STATUS_INVALID_PARAMS);
-
 	hci_dev_lock(hdev);
 
 	if (test_bit(HCI_PENDING_CLASS, &hdev->dev_flags)) {
@@ -1353,10 +1317,6 @@ static int remove_uuid(struct sock *sk, struct hci_dev *hdev, void *data,
 
 	BT_DBG("request for %s", hdev->name);
 
-	if (len != sizeof(*cp))
-		return cmd_status(sk, hdev->id, MGMT_OP_REMOVE_UUID,
-						MGMT_STATUS_INVALID_PARAMS);
-
 	hci_dev_lock(hdev);
 
 	if (test_bit(HCI_PENDING_CLASS, &hdev->dev_flags)) {
@@ -1430,10 +1390,6 @@ static int set_dev_class(struct sock *sk, struct hci_dev *hdev, void *data,
 
 	BT_DBG("request for %s", hdev->name);
 
-	if (len != sizeof(*cp))
-		return cmd_status(sk, hdev->id, MGMT_OP_SET_DEV_CLASS,
-						MGMT_STATUS_INVALID_PARAMS);
-
 	hci_dev_lock(hdev);
 
 	if (test_bit(HCI_PENDING_CLASS, &hdev->dev_flags)) {
@@ -1486,10 +1442,6 @@ static int load_link_keys(struct sock *sk, struct hci_dev *hdev, void *data,
 	u16 key_count, expected_len;
 	int i;
 
-	if (len < sizeof(*cp))
-		return cmd_status(sk, hdev->id, MGMT_OP_LOAD_LINK_KEYS,
-						MGMT_STATUS_INVALID_PARAMS);
-
 	key_count = get_unaligned_le16(&cp->key_count);
 
 	expected_len = sizeof(*cp) + key_count *
@@ -1551,10 +1503,6 @@ static int unpair_device(struct sock *sk, struct hci_dev *hdev, void *data,
 	struct hci_conn *conn;
 	int err;
 
-	if (len != sizeof(*cp))
-		return cmd_status(sk, hdev->id, MGMT_OP_UNPAIR_DEVICE,
-						MGMT_STATUS_INVALID_PARAMS);
-
 	hci_dev_lock(hdev);
 
 	memset(&rp, 0, sizeof(rp));
@@ -1627,10 +1575,6 @@ static int disconnect(struct sock *sk, struct hci_dev *hdev, void *data,
 
 	BT_DBG("");
 
-	if (len != sizeof(*cp))
-		return cmd_status(sk, hdev->id, MGMT_OP_DISCONNECT,
-						MGMT_STATUS_INVALID_PARAMS);
-
 	hci_dev_lock(hdev);
 
 	if (!test_bit(HCI_UP, &hdev->flags)) {
@@ -1781,10 +1725,6 @@ static int pin_code_reply(struct sock *sk, struct hci_dev *hdev, void *data,
 
 	BT_DBG("");
 
-	if (len != sizeof(*cp))
-		return cmd_status(sk, hdev->id, MGMT_OP_PIN_CODE_REPLY,
-						MGMT_STATUS_INVALID_PARAMS);
-
 	hci_dev_lock(hdev);
 
 	if (!hdev_is_powered(hdev)) {
@@ -1842,10 +1782,6 @@ static int pin_code_neg_reply(struct sock *sk, struct hci_dev *hdev,
 
 	BT_DBG("");
 
-	if (len != sizeof(*cp))
-		return cmd_status(sk, hdev->id, MGMT_OP_PIN_CODE_NEG_REPLY,
-						MGMT_STATUS_INVALID_PARAMS);
-
 	hci_dev_lock(hdev);
 
 	if (!hdev_is_powered(hdev)) {
@@ -1868,10 +1804,6 @@ static int set_io_capability(struct sock *sk, struct hci_dev *hdev,
 
 	BT_DBG("");
 
-	if (len != sizeof(*cp))
-		return cmd_status(sk, hdev->id, MGMT_OP_SET_IO_CAPABILITY,
-						MGMT_STATUS_INVALID_PARAMS);
-
 	hci_dev_lock(hdev);
 
 	hdev->io_capability = cp->io_capability;
@@ -1949,10 +1881,6 @@ static int pair_device(struct sock *sk, struct hci_dev *hdev, void *data,
 
 	BT_DBG("");
 
-	if (len != sizeof(*cp))
-		return cmd_status(sk, hdev->id, MGMT_OP_PAIR_DEVICE,
-						MGMT_STATUS_INVALID_PARAMS);
-
 	hci_dev_lock(hdev);
 
 	if (!hdev_is_powered(hdev)) {
@@ -2029,10 +1957,6 @@ static int cancel_pair_device(struct sock *sk, struct hci_dev *hdev,
 
 	BT_DBG("");
 
-	if (len != sizeof(*addr))
-		return cmd_status(sk, hdev->id, MGMT_OP_CANCEL_PAIR_DEVICE,
-						MGMT_STATUS_INVALID_PARAMS);
-
 	hci_dev_lock(hdev);
 
 	if (!hdev_is_powered(hdev)) {
@@ -2153,10 +2077,6 @@ static int user_confirm_neg_reply(struct sock *sk, struct hci_dev *hdev,
 
 	BT_DBG("");
 
-	if (len != sizeof(*cp))
-		return cmd_status(sk, hdev->id, MGMT_OP_USER_CONFIRM_NEG_REPLY,
-						MGMT_STATUS_INVALID_PARAMS);
-
 	return user_pairing_resp(sk, hdev, &cp->addr.bdaddr, cp->addr.type,
 					MGMT_OP_USER_CONFIRM_NEG_REPLY,
 					HCI_OP_USER_CONFIRM_NEG_REPLY, 0);
@@ -2169,10 +2089,6 @@ static int user_passkey_reply(struct sock *sk, struct hci_dev *hdev,
 
 	BT_DBG("");
 
-	if (len != sizeof(*cp))
-		return cmd_status(sk, hdev->id, MGMT_OP_USER_PASSKEY_REPLY,
-									EINVAL);
-
 	return user_pairing_resp(sk, hdev, &cp->addr.bdaddr, cp->addr.type,
 						MGMT_OP_USER_PASSKEY_REPLY,
 						HCI_OP_USER_PASSKEY_REPLY,
@@ -2186,10 +2102,6 @@ static int user_passkey_neg_reply(struct sock *sk, struct hci_dev *hdev,
 
 	BT_DBG("");
 
-	if (len != sizeof(*cp))
-		return cmd_status(sk, hdev->id, MGMT_OP_USER_PASSKEY_NEG_REPLY,
-								EINVAL);
-
 	return user_pairing_resp(sk, hdev, &cp->addr.bdaddr, cp->addr.type,
 					MGMT_OP_USER_PASSKEY_NEG_REPLY,
 					HCI_OP_USER_PASSKEY_NEG_REPLY, 0);
@@ -2205,10 +2117,6 @@ static int set_local_name(struct sock *sk, struct hci_dev *hdev, void *data,
 
 	BT_DBG("");
 
-	if (len != sizeof(*mgmt_cp))
-		return cmd_status(sk, hdev->id, MGMT_OP_SET_LOCAL_NAME,
-						MGMT_STATUS_INVALID_PARAMS);
-
 	hci_dev_lock(hdev);
 
 	memcpy(hdev->short_name, mgmt_cp->short_name,
@@ -2297,10 +2205,6 @@ static int add_remote_oob_data(struct sock *sk, struct hci_dev *hdev,
 
 	BT_DBG("%s ", hdev->name);
 
-	if (len != sizeof(*cp))
-		return cmd_status(sk, hdev->id, MGMT_OP_ADD_REMOTE_OOB_DATA,
-						MGMT_STATUS_INVALID_PARAMS);
-
 	hci_dev_lock(hdev);
 
 	if (!hdev_is_powered(hdev)) {
@@ -2334,10 +2238,6 @@ static int remove_remote_oob_data(struct sock *sk, struct hci_dev *hdev,
 
 	BT_DBG("%s", hdev->name);
 
-	if (len != sizeof(*cp))
-		return cmd_status(sk, hdev->id, MGMT_OP_REMOVE_REMOTE_OOB_DATA,
-						MGMT_STATUS_INVALID_PARAMS);
-
 	hci_dev_lock(hdev);
 
 	if (!hdev_is_powered(hdev)) {
@@ -2388,10 +2288,6 @@ static int start_discovery(struct sock *sk, struct hci_dev *hdev,
 
 	BT_DBG("%s", hdev->name);
 
-	if (len != sizeof(*cp))
-		return cmd_status(sk, hdev->id, MGMT_OP_START_DISCOVERY,
-						MGMT_STATUS_INVALID_PARAMS);
-
 	hci_dev_lock(hdev);
 
 	if (!hdev_is_powered(hdev)) {
@@ -2463,10 +2359,6 @@ static int stop_discovery(struct sock *sk, struct hci_dev *hdev, void *data,
 
 	BT_DBG("%s", hdev->name);
 
-	if (len != sizeof(*mgmt_cp))
-		return cmd_status(sk, hdev->id, MGMT_OP_STOP_DISCOVERY,
-						MGMT_STATUS_INVALID_PARAMS);
-
 	hci_dev_lock(hdev);
 
 	if (!hci_discovery_active(hdev)) {
@@ -2529,10 +2421,6 @@ static int confirm_name(struct sock *sk, struct hci_dev *hdev, void *data,
 
 	BT_DBG("%s", hdev->name);
 
-	if (len != sizeof(*cp))
-		return cmd_status(sk, hdev->id, MGMT_OP_CONFIRM_NAME,
-						MGMT_STATUS_INVALID_PARAMS);
-
 	hci_dev_lock(hdev);
 
 	if (!hci_discovery_active(hdev)) {
@@ -2572,10 +2460,6 @@ static int block_device(struct sock *sk, struct hci_dev *hdev, void *data,
 
 	BT_DBG("%s", hdev->name);
 
-	if (len != sizeof(*cp))
-		return cmd_status(sk, hdev->id, MGMT_OP_BLOCK_DEVICE,
-						MGMT_STATUS_INVALID_PARAMS);
-
 	hci_dev_lock(hdev);
 
 	err = hci_blacklist_add(hdev, &cp->addr.bdaddr, cp->addr.type);
@@ -2601,10 +2485,6 @@ static int unblock_device(struct sock *sk, struct hci_dev *hdev, void *data,
 
 	BT_DBG("%s", hdev->name);
 
-	if (len != sizeof(*cp))
-		return cmd_status(sk, hdev->id, MGMT_OP_UNBLOCK_DEVICE,
-						MGMT_STATUS_INVALID_PARAMS);
-
 	hci_dev_lock(hdev);
 
 	err = hci_blacklist_del(hdev, &cp->addr.bdaddr, cp->addr.type);
@@ -2631,10 +2511,6 @@ static int set_fast_connectable(struct sock *sk, struct hci_dev *hdev,
 
 	BT_DBG("%s", hdev->name);
 
-	if (len != sizeof(*cp))
-		return cmd_status(sk, hdev->id, MGMT_OP_SET_FAST_CONNECTABLE,
-						MGMT_STATUS_INVALID_PARAMS);
-
 	if (!hdev_is_powered(hdev))
 		return cmd_status(sk, hdev->id, MGMT_OP_SET_FAST_CONNECTABLE,
 						MGMT_STATUS_NOT_POWERED);
@@ -2684,10 +2560,6 @@ static int load_long_term_keys(struct sock *sk, struct hci_dev *hdev,
 	u16 key_count, expected_len;
 	int i;
 
-	if (len < sizeof(*cp))
-		return cmd_status(sk, hdev->id, MGMT_OP_LOAD_LONG_TERM_KEYS,
-								EINVAL);
-
 	key_count = get_unaligned_le16(&cp->key_count);
 
 	expected_len = sizeof(*cp) + key_count *
@@ -2727,47 +2599,49 @@ static int load_long_term_keys(struct sock *sk, struct hci_dev *hdev,
 struct mgmt_handler {
 	int (*func) (struct sock *sk, struct hci_dev *hdev,
 						void *data, u16 data_len);
+	bool var_len;
+	size_t data_len;
 } mgmt_handlers[] = {
 	{ NULL }, /* 0x0000 (no command) */
-	{ read_version, },
-	{ read_commands, },
-	{ read_index_list, },
-	{ read_controller_info, },
-	{ set_powered, },
-	{ set_discoverable, },
-	{ set_connectable, },
-	{ set_fast_connectable, },
-	{ set_pairable,	},
-	{ set_link_security, },
-	{ set_ssp, },
-	{ set_hs, },
-	{ set_le, },
-	{ set_dev_class, },
-	{ set_local_name, },
-	{ add_uuid, },
-	{ remove_uuid, },
-	{ load_link_keys, },
-	{ load_long_term_keys, },
-	{ disconnect, },
-	{ get_connections, },
-	{ pin_code_reply, },
-	{ pin_code_neg_reply, },
-	{ set_io_capability, },
-	{ pair_device, },
-	{ cancel_pair_device, },
-	{ unpair_device, },
-	{ user_confirm_reply, },
-	{ user_confirm_neg_reply, },
-	{ user_passkey_reply, },
-	{ user_passkey_neg_reply, },
-	{ read_local_oob_data, },
-	{ add_remote_oob_data, },
-	{ remove_remote_oob_data, },
-	{ start_discovery, },
-	{ stop_discovery, },
-	{ confirm_name, },
-	{ block_device, },
-	{ unblock_device, },
+	{ read_version,           false, MGMT_READ_VERSION_SIZE },
+	{ read_commands,          false, MGMT_READ_COMMANDS_SIZE },
+	{ read_index_list,        false, MGMT_READ_INDEX_LIST_SIZE },
+	{ read_controller_info,   false, MGMT_READ_INFO_SIZE },
+	{ set_powered,            false, MGMT_SETTING_SIZE },
+	{ set_discoverable,       false, MGMT_SET_DISCOVERABLE_SIZE },
+	{ set_connectable,        false, MGMT_SETTING_SIZE },
+	{ set_fast_connectable,   false, MGMT_SETTING_SIZE },
+	{ set_pairable,           false, MGMT_SETTING_SIZE },
+	{ set_link_security,      false, MGMT_SETTING_SIZE },
+	{ set_ssp,                false, MGMT_SETTING_SIZE },
+	{ set_hs,                 false, MGMT_SETTING_SIZE },
+	{ set_le,                 false, MGMT_SETTING_SIZE },
+	{ set_dev_class,          false, MGMT_SET_DEV_CLASS_SIZE },
+	{ set_local_name,         false, MGMT_SET_LOCAL_NAME_SIZE },
+	{ add_uuid,               false, MGMT_ADD_UUID_SIZE },
+	{ remove_uuid,            false, MGMT_REMOVE_UUID_SIZE },
+	{ load_link_keys,         true,  MGMT_LOAD_LINK_KEYS_SIZE },
+	{ load_long_term_keys,    true,  MGMT_LOAD_LONG_TERM_KEYS_SIZE },
+	{ disconnect,             false, MGMT_DISCONNECT_SIZE },
+	{ get_connections,        false, MGMT_GET_CONNECTIONS_SIZE },
+	{ pin_code_reply,         false, MGMT_PIN_CODE_REPLY_SIZE },
+	{ pin_code_neg_reply,     false, MGMT_PIN_CODE_NEG_REPLY_SIZE },
+	{ set_io_capability,      false, MGMT_SET_IO_CAPABILITY_SIZE },
+	{ pair_device,            false, MGMT_PAIR_DEVICE_SIZE },
+	{ cancel_pair_device,     false, MGMT_CANCEL_PAIR_DEVICE_SIZE },
+	{ unpair_device,          false, MGMT_UNPAIR_DEVICE_SIZE },
+	{ user_confirm_reply,     false, MGMT_USER_CONFIRM_REPLY_SIZE },
+	{ user_confirm_neg_reply, false, MGMT_USER_CONFIRM_NEG_REPLY_SIZE },
+	{ user_passkey_reply,     false, MGMT_USER_PASSKEY_REPLY_SIZE },
+	{ user_passkey_neg_reply, false, MGMT_USER_PASSKEY_NEG_REPLY_SIZE },
+	{ read_local_oob_data,    false, MGMT_READ_LOCAL_OOB_DATA_SIZE },
+	{ add_remote_oob_data,    false, MGMT_ADD_REMOTE_OOB_DATA_SIZE },
+	{ remove_remote_oob_data, false, MGMT_REMOVE_REMOTE_OOB_DATA_SIZE },
+	{ start_discovery,        false, MGMT_START_DISCOVERY_SIZE },
+	{ stop_discovery,         false, MGMT_STOP_DISCOVERY_SIZE },
+	{ confirm_name,           false, MGMT_CONFIRM_NAME_SIZE },
+	{ block_device,           false, MGMT_BLOCK_DEVICE_SIZE },
+	{ unblock_device,         false, MGMT_UNBLOCK_DEVICE_SIZE },
 };
 
 
@@ -2778,6 +2652,7 @@ int mgmt_control(struct sock *sk, struct msghdr *msg, size_t msglen)
 	struct mgmt_hdr *hdr;
 	u16 opcode, index, len;
 	struct hci_dev *hdev = NULL;
+	struct mgmt_handler *handler;
 	int err;
 
 	BT_DBG("got %zu bytes", msglen);
@@ -2828,12 +2703,21 @@ int mgmt_control(struct sock *sk, struct msghdr *msg, size_t msglen)
 		goto done;
 	}
 
+	handler = &mgmt_handlers[opcode];
+
+	if ((handler->var_len && len < handler->data_len) ||
+			(!handler->var_len && len != handler->data_len)) {
+		err = cmd_status(sk, index, opcode,
+						MGMT_STATUS_INVALID_PARAMS);
+		goto done;
+	}
+
 	if (hdev)
 		mgmt_init_hdev(sk, hdev);
 
 	cp = buf + sizeof(*hdr);
 
-	err = mgmt_handlers[opcode].func(sk, hdev, cp, len);
+	err = handler->func(sk, hdev, cp, len);
 	if (err < 0)
 		goto done;
 
-- 
1.7.9.1

