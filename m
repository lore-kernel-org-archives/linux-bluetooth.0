Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 6/7] Bluetooth: Update ordering and opcodes of mgmt messages
Date: Wed, 14 Dec 2011 23:52:03 +0200
Message-Id: <1323899524-13653-7-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1323899524-13653-1-git-send-email-johan.hedberg@gmail.com>
References: <1323899524-13653-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch updates the ordering and opcodes of mgmt messages to match
the latest API specification.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/mgmt.h |  147 +++++++++++++++++++++++-------------------
 1 files changed, 81 insertions(+), 66 deletions(-)

diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index bdb0a58..2b1059d 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -100,27 +100,40 @@ struct mgmt_cp_set_discoverable {
 
 #define MGMT_OP_SET_CONNECTABLE		0x0007
 
-#define MGMT_OP_SET_FAST_CONNECTABLE	0x001F
+#define MGMT_OP_SET_FAST_CONNECTABLE	0x0008
 
-#define MGMT_OP_SET_PAIRABLE		0x0008
+#define MGMT_OP_SET_PAIRABLE		0x0009
 
-#define MGMT_OP_ADD_UUID		0x0009
+#define MGMT_OP_SET_LINK_SECURITY	0x000A
+
+#define MGMT_OP_SET_SSP			0x000B
+
+#define MGMT_OP_SET_HS			0x000C
+
+#define MGMT_OP_SET_LE			0x000D
+
+#define MGMT_OP_SET_DEV_CLASS		0x000E
+struct mgmt_cp_set_dev_class {
+	__u8 major;
+	__u8 minor;
+} __packed;
+
+#define MGMT_OP_SET_LOCAL_NAME		0x000F
+struct mgmt_cp_set_local_name {
+	__u8 name[MGMT_MAX_NAME_LENGTH];
+} __packed;
+
+#define MGMT_OP_ADD_UUID		0x0010
 struct mgmt_cp_add_uuid {
 	__u8 uuid[16];
 	__u8 svc_hint;
 } __packed;
 
-#define MGMT_OP_REMOVE_UUID		0x000A
+#define MGMT_OP_REMOVE_UUID		0x0011
 struct mgmt_cp_remove_uuid {
 	__u8 uuid[16];
 } __packed;
 
-#define MGMT_OP_SET_DEV_CLASS		0x000B
-struct mgmt_cp_set_dev_class {
-	__u8 major;
-	__u8 minor;
-} __packed;
-
 struct mgmt_link_key_info {
 	bdaddr_t bdaddr;
 	u8 type;
@@ -128,14 +141,14 @@ struct mgmt_link_key_info {
 	u8 pin_len;
 } __packed;
 
-#define MGMT_OP_LOAD_LINK_KEYS		0x000D
+#define MGMT_OP_LOAD_LINK_KEYS		0x0012
 struct mgmt_cp_load_link_keys {
 	__u8 debug_keys;
 	__le16 key_count;
 	struct mgmt_link_key_info keys[0];
 } __packed;
 
-#define MGMT_OP_REMOVE_KEYS		0x000E
+#define MGMT_OP_REMOVE_KEYS		0x0013
 struct mgmt_cp_remove_keys {
 	bdaddr_t bdaddr;
 	__u8 disconnect;
@@ -145,7 +158,7 @@ struct mgmt_rp_remove_keys {
 	__u8 status;
 };
 
-#define MGMT_OP_DISCONNECT		0x000F
+#define MGMT_OP_DISCONNECT		0x0014
 struct mgmt_cp_disconnect {
 	bdaddr_t bdaddr;
 } __packed;
@@ -164,13 +177,13 @@ struct mgmt_addr_info {
 	__u8 type;
 } __packed;
 
-#define MGMT_OP_GET_CONNECTIONS		0x0010
+#define MGMT_OP_GET_CONNECTIONS		0x0015
 struct mgmt_rp_get_connections {
 	__le16 conn_count;
 	struct mgmt_addr_info addr[0];
 } __packed;
 
-#define MGMT_OP_PIN_CODE_REPLY		0x0011
+#define MGMT_OP_PIN_CODE_REPLY		0x0016
 struct mgmt_cp_pin_code_reply {
 	bdaddr_t bdaddr;
 	__u8 pin_len;
@@ -181,17 +194,17 @@ struct mgmt_rp_pin_code_reply {
 	uint8_t status;
 } __packed;
 
-#define MGMT_OP_PIN_CODE_NEG_REPLY	0x0012
+#define MGMT_OP_PIN_CODE_NEG_REPLY	0x0017
 struct mgmt_cp_pin_code_neg_reply {
 	bdaddr_t bdaddr;
 } __packed;
 
-#define MGMT_OP_SET_IO_CAPABILITY	0x0013
+#define MGMT_OP_SET_IO_CAPABILITY	0x0018
 struct mgmt_cp_set_io_capability {
 	__u8 io_capability;
 } __packed;
 
-#define MGMT_OP_PAIR_DEVICE		0x0014
+#define MGMT_OP_PAIR_DEVICE		0x0019
 struct mgmt_cp_pair_device {
 	struct mgmt_addr_info addr;
 	__u8 io_cap;
@@ -201,7 +214,7 @@ struct mgmt_rp_pair_device {
 	__u8 status;
 } __packed;
 
-#define MGMT_OP_USER_CONFIRM_REPLY	0x0015
+#define MGMT_OP_USER_CONFIRM_REPLY	0x001A
 struct mgmt_cp_user_confirm_reply {
 	bdaddr_t bdaddr;
 } __packed;
@@ -210,59 +223,61 @@ struct mgmt_rp_user_confirm_reply {
 	__u8 status;
 } __packed;
 
-#define MGMT_OP_USER_CONFIRM_NEG_REPLY	0x0016
+#define MGMT_OP_USER_CONFIRM_NEG_REPLY	0x001B
+struct mgmt_cp_user_confirm_neg_reply {
+	bdaddr_t bdaddr;
+} __packed;
 
-#define MGMT_OP_SET_LOCAL_NAME		0x0017
-struct mgmt_cp_set_local_name {
-	__u8 name[MGMT_MAX_NAME_LENGTH];
+#define MGMT_OP_USER_PASSKEY_REPLY	0x001C
+struct mgmt_cp_user_passkey_reply {
+	bdaddr_t bdaddr;
+	__le32 passkey;
+} __packed;
+struct mgmt_rp_user_passkey_reply {
+	bdaddr_t bdaddr;
+	__u8 status;
+} __packed;
+
+#define MGMT_OP_USER_PASSKEY_NEG_REPLY	0x001D
+struct mgmt_cp_user_passkey_neg_reply {
+	bdaddr_t bdaddr;
 } __packed;
 
-#define MGMT_OP_READ_LOCAL_OOB_DATA	0x0018
+#define MGMT_OP_READ_LOCAL_OOB_DATA	0x001E
 struct mgmt_rp_read_local_oob_data {
 	__u8 hash[16];
 	__u8 randomizer[16];
 } __packed;
 
-#define MGMT_OP_ADD_REMOTE_OOB_DATA	0x0019
+#define MGMT_OP_ADD_REMOTE_OOB_DATA	0x001F
 struct mgmt_cp_add_remote_oob_data {
 	bdaddr_t bdaddr;
 	__u8 hash[16];
 	__u8 randomizer[16];
 } __packed;
 
-#define MGMT_OP_REMOVE_REMOTE_OOB_DATA	0x001A
+#define MGMT_OP_REMOVE_REMOTE_OOB_DATA	0x0020
 struct mgmt_cp_remove_remote_oob_data {
 	bdaddr_t bdaddr;
 } __packed;
 
-#define MGMT_OP_START_DISCOVERY		0x001B
+#define MGMT_OP_START_DISCOVERY		0x0021
 struct mgmt_cp_start_discovery {
 	__u8 type;
 } __packed;
 
-#define MGMT_OP_STOP_DISCOVERY		0x001C
+#define MGMT_OP_STOP_DISCOVERY		0x0022
 
-#define MGMT_OP_BLOCK_DEVICE		0x001D
+#define MGMT_OP_BLOCK_DEVICE		0x0023
 struct mgmt_cp_block_device {
 	bdaddr_t bdaddr;
 } __packed;
 
-#define MGMT_OP_UNBLOCK_DEVICE		0x001E
+#define MGMT_OP_UNBLOCK_DEVICE		0x0024
 struct mgmt_cp_unblock_device {
 	bdaddr_t bdaddr;
 } __packed;
 
-#define MGMT_OP_USER_PASSKEY_REPLY	0x0020
-struct mgmt_cp_user_passkey_reply {
-	bdaddr_t bdaddr;
-	__le32 passkey;
-} __packed;
-
-#define MGMT_OP_USER_PASSKEY_NEG_REPLY	0x0021
-struct mgmt_cp_user_passkey_neg_reply {
-	bdaddr_t bdaddr;
-} __packed;
-
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
 	__le16 opcode;
@@ -286,53 +301,58 @@ struct mgmt_ev_controller_error {
 
 #define MGMT_EV_NEW_SETTINGS		0x0006
 
-#define MGMT_EV_DISCOVERABLE		0x0007
-
-#define MGMT_EV_CONNECTABLE		0x0008
+#define MGMT_EV_CLASS_OF_DEV_CHANGED	0x0007
+struct mgmt_ev_class_of_dev_changed {
+	__u8 dev_class[3];
+};
 
-#define MGMT_EV_PAIRABLE		0x0009
+#define MGMT_EV_LOCAL_NAME_CHANGED	0x0008
+struct mgmt_ev_local_name_changed {
+	__u8 name[MGMT_MAX_NAME_LENGTH];
+	__u8 short_name[MGMT_MAX_SHORT_NAME_LENGTH];
+} __packed;
 
-#define MGMT_EV_NEW_LINK_KEY		0x000A
+#define MGMT_EV_NEW_LINK_KEY		0x0009
 struct mgmt_ev_new_link_key {
 	__u8 store_hint;
 	struct mgmt_link_key_info key;
 } __packed;
 
-#define MGMT_EV_CONNECTED		0x000B
+#define MGMT_EV_CONNECTED		0x000A
 
-#define MGMT_EV_DISCONNECTED		0x000C
+#define MGMT_EV_DISCONNECTED		0x000B
 
-#define MGMT_EV_CONNECT_FAILED		0x000D
+#define MGMT_EV_CONNECT_FAILED		0x000C
 struct mgmt_ev_connect_failed {
 	struct mgmt_addr_info addr;
 	__u8 status;
 } __packed;
 
-#define MGMT_EV_PIN_CODE_REQUEST	0x000E
+#define MGMT_EV_PIN_CODE_REQUEST	0x000D
 struct mgmt_ev_pin_code_request {
 	bdaddr_t bdaddr;
 	__u8 secure;
 } __packed;
 
-#define MGMT_EV_USER_CONFIRM_REQUEST	0x000F
+#define MGMT_EV_USER_CONFIRM_REQUEST	0x000E
 struct mgmt_ev_user_confirm_request {
 	bdaddr_t bdaddr;
 	__u8 confirm_hint;
 	__le32 value;
 } __packed;
 
+#define MGMT_EV_USER_PASSKEY_REQUEST	0x000F
+struct mgmt_ev_user_passkey_request {
+	bdaddr_t bdaddr;
+} __packed;
+
 #define MGMT_EV_AUTH_FAILED		0x0010
 struct mgmt_ev_auth_failed {
 	bdaddr_t bdaddr;
 	__u8 status;
 } __packed;
 
-#define MGMT_EV_LOCAL_NAME_CHANGED	0x0011
-struct mgmt_ev_local_name_changed {
-	__u8 name[MGMT_MAX_NAME_LENGTH];
-} __packed;
-
-#define MGMT_EV_DEVICE_FOUND		0x0012
+#define MGMT_EV_DEVICE_FOUND		0x0011
 struct mgmt_ev_device_found {
 	struct mgmt_addr_info addr;
 	__u8 dev_class[3];
@@ -340,25 +360,20 @@ struct mgmt_ev_device_found {
 	__u8 eir[HCI_MAX_EIR_LENGTH];
 } __packed;
 
-#define MGMT_EV_REMOTE_NAME		0x0013
+#define MGMT_EV_REMOTE_NAME		0x0012
 struct mgmt_ev_remote_name {
 	bdaddr_t bdaddr;
 	__u8 name[MGMT_MAX_NAME_LENGTH];
 } __packed;
 
-#define MGMT_EV_DISCOVERING		0x0014
+#define MGMT_EV_DISCOVERING		0x0013
 
-#define MGMT_EV_DEVICE_BLOCKED		0x0015
+#define MGMT_EV_DEVICE_BLOCKED		0x0014
 struct mgmt_ev_device_blocked {
 	bdaddr_t bdaddr;
 } __packed;
 
-#define MGMT_EV_DEVICE_UNBLOCKED	0x0016
+#define MGMT_EV_DEVICE_UNBLOCKED	0x0015
 struct mgmt_ev_device_unblocked {
 	bdaddr_t bdaddr;
 } __packed;
-
-#define MGMT_EV_USER_PASSKEY_REQUEST	0x0017
-struct mgmt_ev_user_passkey_request {
-	bdaddr_t bdaddr;
-} __packed;
-- 
1.7.7.3

