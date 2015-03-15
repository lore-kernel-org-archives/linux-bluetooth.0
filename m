Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 10/14] Bluetooth: Remove unneeded initializer for management command table
Date: Sat, 14 Mar 2015 19:28:02 -0700
Message-Id: <1426386486-15962-10-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The flags field for the management command table will be always
initialized to zero and thus no need to do that manually.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/mgmt.c | 86 ++++++++++++++++++++++++++--------------------------
 1 file changed, 43 insertions(+), 43 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 484ee8e2b52c..8d67704d6116 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -6261,58 +6261,58 @@ static const struct hci_mgmt_handler mgmt_handlers[] = {
 						HCI_MGMT_UNTRUSTED },
 	{ read_controller_info,    MGMT_READ_INFO_SIZE,
 						HCI_MGMT_UNTRUSTED },
-	{ set_powered,             MGMT_SETTING_SIZE,                   0 },
-	{ set_discoverable,        MGMT_SET_DISCOVERABLE_SIZE,          0 },
-	{ set_connectable,         MGMT_SETTING_SIZE,                   0 },
-	{ set_fast_connectable,    MGMT_SETTING_SIZE,                   0 },
-	{ set_bondable,            MGMT_SETTING_SIZE,                   0 },
-	{ set_link_security,       MGMT_SETTING_SIZE,                   0 },
-	{ set_ssp,                 MGMT_SETTING_SIZE,                   0 },
-	{ set_hs,                  MGMT_SETTING_SIZE,                   0 },
-	{ set_le,                  MGMT_SETTING_SIZE,                   0 },
-	{ set_dev_class,           MGMT_SET_DEV_CLASS_SIZE,             0 },
-	{ set_local_name,          MGMT_SET_LOCAL_NAME_SIZE,            0 },
-	{ add_uuid,                MGMT_ADD_UUID_SIZE,                  0 },
-	{ remove_uuid,             MGMT_REMOVE_UUID_SIZE,               0 },
+	{ set_powered,             MGMT_SETTING_SIZE },
+	{ set_discoverable,        MGMT_SET_DISCOVERABLE_SIZE },
+	{ set_connectable,         MGMT_SETTING_SIZE },
+	{ set_fast_connectable,    MGMT_SETTING_SIZE },
+	{ set_bondable,            MGMT_SETTING_SIZE },
+	{ set_link_security,       MGMT_SETTING_SIZE },
+	{ set_ssp,                 MGMT_SETTING_SIZE },
+	{ set_hs,                  MGMT_SETTING_SIZE },
+	{ set_le,                  MGMT_SETTING_SIZE },
+	{ set_dev_class,           MGMT_SET_DEV_CLASS_SIZE },
+	{ set_local_name,          MGMT_SET_LOCAL_NAME_SIZE },
+	{ add_uuid,                MGMT_ADD_UUID_SIZE },
+	{ remove_uuid,             MGMT_REMOVE_UUID_SIZE },
 	{ load_link_keys,          MGMT_LOAD_LINK_KEYS_SIZE,
 						HCI_MGMT_VAR_LEN },
 	{ load_long_term_keys,     MGMT_LOAD_LONG_TERM_KEYS_SIZE,
 						HCI_MGMT_VAR_LEN },
-	{ disconnect,              MGMT_DISCONNECT_SIZE,                0 },
-	{ get_connections,         MGMT_GET_CONNECTIONS_SIZE,           0 },
-	{ pin_code_reply,          MGMT_PIN_CODE_REPLY_SIZE,            0 },
-	{ pin_code_neg_reply,      MGMT_PIN_CODE_NEG_REPLY_SIZE,        0 },
-	{ set_io_capability,       MGMT_SET_IO_CAPABILITY_SIZE,         0 },
-	{ pair_device,             MGMT_PAIR_DEVICE_SIZE,               0 },
-	{ cancel_pair_device,      MGMT_CANCEL_PAIR_DEVICE_SIZE,        0 },
-	{ unpair_device,           MGMT_UNPAIR_DEVICE_SIZE,             0 },
-	{ user_confirm_reply,      MGMT_USER_CONFIRM_REPLY_SIZE,        0 },
-	{ user_confirm_neg_reply,  MGMT_USER_CONFIRM_NEG_REPLY_SIZE,    0 },
-	{ user_passkey_reply,      MGMT_USER_PASSKEY_REPLY_SIZE,        0 },
-	{ user_passkey_neg_reply,  MGMT_USER_PASSKEY_NEG_REPLY_SIZE,    0 },
+	{ disconnect,              MGMT_DISCONNECT_SIZE },
+	{ get_connections,         MGMT_GET_CONNECTIONS_SIZE },
+	{ pin_code_reply,          MGMT_PIN_CODE_REPLY_SIZE },
+	{ pin_code_neg_reply,      MGMT_PIN_CODE_NEG_REPLY_SIZE },
+	{ set_io_capability,       MGMT_SET_IO_CAPABILITY_SIZE },
+	{ pair_device,             MGMT_PAIR_DEVICE_SIZE },
+	{ cancel_pair_device,      MGMT_CANCEL_PAIR_DEVICE_SIZE },
+	{ unpair_device,           MGMT_UNPAIR_DEVICE_SIZE },
+	{ user_confirm_reply,      MGMT_USER_CONFIRM_REPLY_SIZE },
+	{ user_confirm_neg_reply,  MGMT_USER_CONFIRM_NEG_REPLY_SIZE },
+	{ user_passkey_reply,      MGMT_USER_PASSKEY_REPLY_SIZE },
+	{ user_passkey_neg_reply,  MGMT_USER_PASSKEY_NEG_REPLY_SIZE },
 	{ read_local_oob_data,     MGMT_READ_LOCAL_OOB_DATA_SIZE },
 	{ add_remote_oob_data,     MGMT_ADD_REMOTE_OOB_DATA_SIZE,
 						HCI_MGMT_VAR_LEN },
-	{ remove_remote_oob_data,  MGMT_REMOVE_REMOTE_OOB_DATA_SIZE,    0 },
-	{ start_discovery,         MGMT_START_DISCOVERY_SIZE,           0 },
-	{ stop_discovery,          MGMT_STOP_DISCOVERY_SIZE,            0 },
-	{ confirm_name,            MGMT_CONFIRM_NAME_SIZE,              0 },
-	{ block_device,            MGMT_BLOCK_DEVICE_SIZE,              0 },
-	{ unblock_device,          MGMT_UNBLOCK_DEVICE_SIZE,            0 },
-	{ set_device_id,           MGMT_SET_DEVICE_ID_SIZE,             0 },
-	{ set_advertising,         MGMT_SETTING_SIZE,                   0 },
-	{ set_bredr,               MGMT_SETTING_SIZE,                   0 },
-	{ set_static_address,      MGMT_SET_STATIC_ADDRESS_SIZE,        0 },
-	{ set_scan_params,         MGMT_SET_SCAN_PARAMS_SIZE,           0 },
-	{ set_secure_conn,         MGMT_SETTING_SIZE,                   0 },
-	{ set_debug_keys,          MGMT_SETTING_SIZE,                   0 },
-	{ set_privacy,             MGMT_SET_PRIVACY_SIZE,               0 },
+	{ remove_remote_oob_data,  MGMT_REMOVE_REMOTE_OOB_DATA_SIZE },
+	{ start_discovery,         MGMT_START_DISCOVERY_SIZE },
+	{ stop_discovery,          MGMT_STOP_DISCOVERY_SIZE },
+	{ confirm_name,            MGMT_CONFIRM_NAME_SIZE },
+	{ block_device,            MGMT_BLOCK_DEVICE_SIZE },
+	{ unblock_device,          MGMT_UNBLOCK_DEVICE_SIZE },
+	{ set_device_id,           MGMT_SET_DEVICE_ID_SIZE },
+	{ set_advertising,         MGMT_SETTING_SIZE },
+	{ set_bredr,               MGMT_SETTING_SIZE },
+	{ set_static_address,      MGMT_SET_STATIC_ADDRESS_SIZE },
+	{ set_scan_params,         MGMT_SET_SCAN_PARAMS_SIZE },
+	{ set_secure_conn,         MGMT_SETTING_SIZE },
+	{ set_debug_keys,          MGMT_SETTING_SIZE },
+	{ set_privacy,             MGMT_SET_PRIVACY_SIZE },
 	{ load_irks,               MGMT_LOAD_IRKS_SIZE,
 						HCI_MGMT_VAR_LEN },
-	{ get_conn_info,           MGMT_GET_CONN_INFO_SIZE,             0 },
-	{ get_clock_info,          MGMT_GET_CLOCK_INFO_SIZE,            0 },
-	{ add_device,              MGMT_ADD_DEVICE_SIZE,                0 },
-	{ remove_device,           MGMT_REMOVE_DEVICE_SIZE,             0 },
+	{ get_conn_info,           MGMT_GET_CONN_INFO_SIZE },
+	{ get_clock_info,          MGMT_GET_CLOCK_INFO_SIZE },
+	{ add_device,              MGMT_ADD_DEVICE_SIZE },
+	{ remove_device,           MGMT_REMOVE_DEVICE_SIZE },
 	{ load_conn_param,         MGMT_LOAD_CONN_PARAM_SIZE,
 						HCI_MGMT_VAR_LEN },
 	{ read_unconf_index_list,  MGMT_READ_UNCONF_INDEX_LIST_SIZE,
-- 
2.1.0

