Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 3/7] Bluetooth: Move all mgmt command quirks to handler table
Date: Fri,  6 Mar 2015 21:08:52 +0200
Message-Id: <1425668936-23234-3-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1425668936-23234-1-git-send-email-johan.hedberg@gmail.com>
References: <1425668936-23234-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

In order to completely generalize the mgmt command handling we need to
move away command-specific information from mgmt_control() into the
actual command table. This patch adds a new 'flags' field to the handler
entries which can now contain the following command specific
information:

 - Command takes variable length parameters
 - Command doesn't target any specific HCI device
 - Command can be sent when the HCI device is unconfigured

After this the mgmt_control() function is completely generic and can
potentially be reused by new HCI channels.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h |   6 +-
 net/bluetooth/mgmt.c             | 170 ++++++++++++++++++++-------------------
 2 files changed, 93 insertions(+), 83 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index b2a183d201b7..afc641c5e55c 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1273,11 +1273,15 @@ void hci_send_to_monitor(struct hci_dev *hdev, struct sk_buff *skb);
 
 void hci_sock_dev_event(struct hci_dev *hdev, int event);
 
+#define HCI_MGMT_VAR_LEN	(1 << 0)
+#define HCI_MGMT_NO_HDEV	(1 << 1)
+#define HCI_MGMT_UNCONFIGURED	(1 << 2)
+
 struct hci_mgmt_handler {
 	int (*func) (struct sock *sk, struct hci_dev *hdev, void *data,
 		     u16 data_len);
-	bool var_len;
 	size_t data_len;
+	unsigned long flags;
 };
 
 struct hci_mgmt_chan {
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index bb02dd1b82bf..f65516420a31 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -6132,64 +6132,77 @@ unlock:
 
 static const struct hci_mgmt_handler mgmt_handlers[] = {
 	{ NULL }, /* 0x0000 (no command) */
-	{ read_version,           false, MGMT_READ_VERSION_SIZE },
-	{ read_commands,          false, MGMT_READ_COMMANDS_SIZE },
-	{ read_index_list,        false, MGMT_READ_INDEX_LIST_SIZE },
-	{ read_controller_info,   false, MGMT_READ_INFO_SIZE },
-	{ set_powered,            false, MGMT_SETTING_SIZE },
-	{ set_discoverable,       false, MGMT_SET_DISCOVERABLE_SIZE },
-	{ set_connectable,        false, MGMT_SETTING_SIZE },
-	{ set_fast_connectable,   false, MGMT_SETTING_SIZE },
-	{ set_bondable,           false, MGMT_SETTING_SIZE },
-	{ set_link_security,      false, MGMT_SETTING_SIZE },
-	{ set_ssp,                false, MGMT_SETTING_SIZE },
-	{ set_hs,                 false, MGMT_SETTING_SIZE },
-	{ set_le,                 false, MGMT_SETTING_SIZE },
-	{ set_dev_class,          false, MGMT_SET_DEV_CLASS_SIZE },
-	{ set_local_name,         false, MGMT_SET_LOCAL_NAME_SIZE },
-	{ add_uuid,               false, MGMT_ADD_UUID_SIZE },
-	{ remove_uuid,            false, MGMT_REMOVE_UUID_SIZE },
-	{ load_link_keys,         true,  MGMT_LOAD_LINK_KEYS_SIZE },
-	{ load_long_term_keys,    true,  MGMT_LOAD_LONG_TERM_KEYS_SIZE },
-	{ disconnect,             false, MGMT_DISCONNECT_SIZE },
-	{ get_connections,        false, MGMT_GET_CONNECTIONS_SIZE },
-	{ pin_code_reply,         false, MGMT_PIN_CODE_REPLY_SIZE },
-	{ pin_code_neg_reply,     false, MGMT_PIN_CODE_NEG_REPLY_SIZE },
-	{ set_io_capability,      false, MGMT_SET_IO_CAPABILITY_SIZE },
-	{ pair_device,            false, MGMT_PAIR_DEVICE_SIZE },
-	{ cancel_pair_device,     false, MGMT_CANCEL_PAIR_DEVICE_SIZE },
-	{ unpair_device,          false, MGMT_UNPAIR_DEVICE_SIZE },
-	{ user_confirm_reply,     false, MGMT_USER_CONFIRM_REPLY_SIZE },
-	{ user_confirm_neg_reply, false, MGMT_USER_CONFIRM_NEG_REPLY_SIZE },
-	{ user_passkey_reply,     false, MGMT_USER_PASSKEY_REPLY_SIZE },
-	{ user_passkey_neg_reply, false, MGMT_USER_PASSKEY_NEG_REPLY_SIZE },
-	{ read_local_oob_data,    false, MGMT_READ_LOCAL_OOB_DATA_SIZE },
-	{ add_remote_oob_data,    true,  MGMT_ADD_REMOTE_OOB_DATA_SIZE },
-	{ remove_remote_oob_data, false, MGMT_REMOVE_REMOTE_OOB_DATA_SIZE },
-	{ start_discovery,        false, MGMT_START_DISCOVERY_SIZE },
-	{ stop_discovery,         false, MGMT_STOP_DISCOVERY_SIZE },
-	{ confirm_name,           false, MGMT_CONFIRM_NAME_SIZE },
-	{ block_device,           false, MGMT_BLOCK_DEVICE_SIZE },
-	{ unblock_device,         false, MGMT_UNBLOCK_DEVICE_SIZE },
-	{ set_device_id,          false, MGMT_SET_DEVICE_ID_SIZE },
-	{ set_advertising,        false, MGMT_SETTING_SIZE },
-	{ set_bredr,              false, MGMT_SETTING_SIZE },
-	{ set_static_address,     false, MGMT_SET_STATIC_ADDRESS_SIZE },
-	{ set_scan_params,        false, MGMT_SET_SCAN_PARAMS_SIZE },
-	{ set_secure_conn,        false, MGMT_SETTING_SIZE },
-	{ set_debug_keys,         false, MGMT_SETTING_SIZE },
-	{ set_privacy,            false, MGMT_SET_PRIVACY_SIZE },
-	{ load_irks,              true,  MGMT_LOAD_IRKS_SIZE },
-	{ get_conn_info,          false, MGMT_GET_CONN_INFO_SIZE },
-	{ get_clock_info,         false, MGMT_GET_CLOCK_INFO_SIZE },
-	{ add_device,             false, MGMT_ADD_DEVICE_SIZE },
-	{ remove_device,          false, MGMT_REMOVE_DEVICE_SIZE },
-	{ load_conn_param,        true,  MGMT_LOAD_CONN_PARAM_SIZE },
-	{ read_unconf_index_list, false, MGMT_READ_UNCONF_INDEX_LIST_SIZE },
-	{ read_config_info,       false, MGMT_READ_CONFIG_INFO_SIZE },
-	{ set_external_config,    false, MGMT_SET_EXTERNAL_CONFIG_SIZE },
-	{ set_public_address,     false, MGMT_SET_PUBLIC_ADDRESS_SIZE },
-	{ start_service_discovery,true,  MGMT_START_SERVICE_DISCOVERY_SIZE },
+	{ read_version,            MGMT_READ_VERSION_SIZE,
+						HCI_MGMT_NO_HDEV },
+	{ read_commands,           MGMT_READ_COMMANDS_SIZE,
+						HCI_MGMT_NO_HDEV },
+	{ read_index_list,         MGMT_READ_INDEX_LIST_SIZE,
+						HCI_MGMT_NO_HDEV },
+	{ read_controller_info,    MGMT_READ_INFO_SIZE,                 0 },
+	{ set_powered,             MGMT_SETTING_SIZE,                   0 },
+	{ set_discoverable,        MGMT_SET_DISCOVERABLE_SIZE,          0 },
+	{ set_connectable,         MGMT_SETTING_SIZE,                   0 },
+	{ set_fast_connectable,    MGMT_SETTING_SIZE,                   0 },
+	{ set_bondable,            MGMT_SETTING_SIZE,                   0 },
+	{ set_link_security,       MGMT_SETTING_SIZE,                   0 },
+	{ set_ssp,                 MGMT_SETTING_SIZE,                   0 },
+	{ set_hs,                  MGMT_SETTING_SIZE,                   0 },
+	{ set_le,                  MGMT_SETTING_SIZE,                   0 },
+	{ set_dev_class,           MGMT_SET_DEV_CLASS_SIZE,             0 },
+	{ set_local_name,          MGMT_SET_LOCAL_NAME_SIZE,            0 },
+	{ add_uuid,                MGMT_ADD_UUID_SIZE,                  0 },
+	{ remove_uuid,             MGMT_REMOVE_UUID_SIZE,               0 },
+	{ load_link_keys,          MGMT_LOAD_LINK_KEYS_SIZE,
+						HCI_MGMT_VAR_LEN },
+	{ load_long_term_keys,     MGMT_LOAD_LONG_TERM_KEYS_SIZE,
+						HCI_MGMT_VAR_LEN },
+	{ disconnect,              MGMT_DISCONNECT_SIZE,                0 },
+	{ get_connections,         MGMT_GET_CONNECTIONS_SIZE,           0 },
+	{ pin_code_reply,          MGMT_PIN_CODE_REPLY_SIZE,            0 },
+	{ pin_code_neg_reply,      MGMT_PIN_CODE_NEG_REPLY_SIZE,        0 },
+	{ set_io_capability,       MGMT_SET_IO_CAPABILITY_SIZE,         0 },
+	{ pair_device,             MGMT_PAIR_DEVICE_SIZE,               0 },
+	{ cancel_pair_device,      MGMT_CANCEL_PAIR_DEVICE_SIZE,        0 },
+	{ unpair_device,           MGMT_UNPAIR_DEVICE_SIZE,             0 },
+	{ user_confirm_reply,      MGMT_USER_CONFIRM_REPLY_SIZE,        0 },
+	{ user_confirm_neg_reply,  MGMT_USER_CONFIRM_NEG_REPLY_SIZE,    0 },
+	{ user_passkey_reply,      MGMT_USER_PASSKEY_REPLY_SIZE,        0 },
+	{ user_passkey_neg_reply,  MGMT_USER_PASSKEY_NEG_REPLY_SIZE,    0 },
+	{ read_local_oob_data,     MGMT_READ_LOCAL_OOB_DATA_SIZE },
+	{ add_remote_oob_data,     MGMT_ADD_REMOTE_OOB_DATA_SIZE,
+						HCI_MGMT_VAR_LEN },
+	{ remove_remote_oob_data,  MGMT_REMOVE_REMOTE_OOB_DATA_SIZE,    0 },
+	{ start_discovery,         MGMT_START_DISCOVERY_SIZE,           0 },
+	{ stop_discovery,          MGMT_STOP_DISCOVERY_SIZE,            0 },
+	{ confirm_name,            MGMT_CONFIRM_NAME_SIZE,              0 },
+	{ block_device,            MGMT_BLOCK_DEVICE_SIZE,              0 },
+	{ unblock_device,          MGMT_UNBLOCK_DEVICE_SIZE,            0 },
+	{ set_device_id,           MGMT_SET_DEVICE_ID_SIZE,             0 },
+	{ set_advertising,         MGMT_SETTING_SIZE,                   0 },
+	{ set_bredr,               MGMT_SETTING_SIZE,                   0 },
+	{ set_static_address,      MGMT_SET_STATIC_ADDRESS_SIZE,        0 },
+	{ set_scan_params,         MGMT_SET_SCAN_PARAMS_SIZE,           0 },
+	{ set_secure_conn,         MGMT_SETTING_SIZE,                   0 },
+	{ set_debug_keys,          MGMT_SETTING_SIZE,                   0 },
+	{ set_privacy,             MGMT_SET_PRIVACY_SIZE,               0 },
+	{ load_irks,               MGMT_LOAD_IRKS_SIZE,
+						HCI_MGMT_VAR_LEN },
+	{ get_conn_info,           MGMT_GET_CONN_INFO_SIZE,             0 },
+	{ get_clock_info,          MGMT_GET_CLOCK_INFO_SIZE,            0 },
+	{ add_device,              MGMT_ADD_DEVICE_SIZE,                0 },
+	{ remove_device,           MGMT_REMOVE_DEVICE_SIZE,             0 },
+	{ load_conn_param,         MGMT_LOAD_CONN_PARAM_SIZE,
+						HCI_MGMT_VAR_LEN },
+	{ read_unconf_index_list,  MGMT_READ_UNCONF_INDEX_LIST_SIZE,
+						HCI_MGMT_NO_HDEV },
+	{ read_config_info,        MGMT_READ_CONFIG_INFO_SIZE,
+						HCI_MGMT_UNCONFIGURED },
+	{ set_external_config,     MGMT_SET_EXTERNAL_CONFIG_SIZE,
+						HCI_MGMT_UNCONFIGURED },
+	{ set_public_address,      MGMT_SET_PUBLIC_ADDRESS_SIZE,
+						HCI_MGMT_UNCONFIGURED },
+	{ start_service_discovery, MGMT_START_SERVICE_DISCOVERY_SIZE,
+						HCI_MGMT_VAR_LEN },
 };
 
 int mgmt_control(struct hci_mgmt_chan *chan, struct sock *sk,
@@ -6201,6 +6214,7 @@ int mgmt_control(struct hci_mgmt_chan *chan, struct sock *sk,
 	u16 opcode, index, len;
 	struct hci_dev *hdev = NULL;
 	const struct hci_mgmt_handler *handler;
+	bool var_len, no_hdev;
 	int err;
 
 	BT_DBG("got %zu bytes", msglen);
@@ -6227,6 +6241,16 @@ int mgmt_control(struct hci_mgmt_chan *chan, struct sock *sk,
 		goto done;
 	}
 
+	if (opcode >= chan->handler_count ||
+	    chan->handlers[opcode].func == NULL) {
+		BT_DBG("Unknown op %u", opcode);
+		err = cmd_status(sk, index, opcode,
+				 MGMT_STATUS_UNKNOWN_COMMAND);
+		goto done;
+	}
+
+	handler = &chan->handlers[opcode];
+
 	if (index != MGMT_INDEX_NONE) {
 		hdev = hci_dev_get(index);
 		if (!hdev) {
@@ -6244,41 +6268,23 @@ int mgmt_control(struct hci_mgmt_chan *chan, struct sock *sk,
 		}
 
 		if (test_bit(HCI_UNCONFIGURED, &hdev->dev_flags) &&
-		    opcode != MGMT_OP_READ_CONFIG_INFO &&
-		    opcode != MGMT_OP_SET_EXTERNAL_CONFIG &&
-		    opcode != MGMT_OP_SET_PUBLIC_ADDRESS) {
+		    !(handler->flags & HCI_MGMT_UNCONFIGURED)) {
 			err = cmd_status(sk, index, opcode,
 					 MGMT_STATUS_INVALID_INDEX);
 			goto done;
 		}
 	}
 
-	if (opcode >= chan->handler_count ||
-	    chan->handlers[opcode].func == NULL) {
-		BT_DBG("Unknown op %u", opcode);
-		err = cmd_status(sk, index, opcode,
-				 MGMT_STATUS_UNKNOWN_COMMAND);
-		goto done;
-	}
-
-	if (hdev && (opcode <= MGMT_OP_READ_INDEX_LIST ||
-		     opcode == MGMT_OP_READ_UNCONF_INDEX_LIST)) {
-		err = cmd_status(sk, index, opcode,
-				 MGMT_STATUS_INVALID_INDEX);
-		goto done;
-	}
-
-	if (!hdev && (opcode > MGMT_OP_READ_INDEX_LIST &&
-		      opcode != MGMT_OP_READ_UNCONF_INDEX_LIST)) {
+	no_hdev = (handler->flags & HCI_MGMT_NO_HDEV);
+	if (no_hdev != !hdev) {
 		err = cmd_status(sk, index, opcode,
 				 MGMT_STATUS_INVALID_INDEX);
 		goto done;
 	}
 
-	handler = &chan->handlers[opcode];
-
-	if ((handler->var_len && len < handler->data_len) ||
-	    (!handler->var_len && len != handler->data_len)) {
+	var_len = (handler->flags & HCI_MGMT_VAR_LEN);
+	if ((var_len && len < handler->data_len) ||
+	    (!var_len && len != handler->data_len)) {
 		err = cmd_status(sk, index, opcode,
 				 MGMT_STATUS_INVALID_PARAMS);
 		goto done;
-- 
2.1.0

