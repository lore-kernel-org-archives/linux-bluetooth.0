Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/5] Bluetooth: mgmt: Add defines for command sizes
Date: Thu,  1 Mar 2012 12:33:31 -0800
Message-Id: <1330634012-4502-4-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1330634012-4502-1-git-send-email-johan.hedberg@gmail.com>
References: <1330634012-4502-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

These defines are shorter than "sizeof(struct mgmt_cp_foo_bar...)" and
will be helpful when extending the command lookup table to contain the
expected command size information.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/mgmt.h |   34 ++++++++++++++++++++++++++++++++++
 1 files changed, 34 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 7aab53e..d33457d 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -52,14 +52,17 @@ struct mgmt_addr_info {
 	bdaddr_t bdaddr;
 	__u8 type;
 } __packed;
+#define MGMT_ADDR_INFO_SIZE		7
 
 #define MGMT_OP_READ_VERSION		0x0001
+#define MGMT_READ_VERSION_SIZE		0
 struct mgmt_rp_read_version {
 	__u8 version;
 	__le16 revision;
 } __packed;
 
 #define MGMT_OP_READ_COMMANDS		0x0002
+#define MGMT_READ_COMMANDS_SIZE		0
 struct mgmt_rp_read_commands {
 	__le16 num_commands;
 	__le16 num_events;
@@ -67,6 +70,7 @@ struct mgmt_rp_read_commands {
 } __packed;
 
 #define MGMT_OP_READ_INDEX_LIST		0x0003
+#define MGMT_READ_INDEX_LIST_SIZE	0
 struct mgmt_rp_read_index_list {
 	__le16 num_controllers;
 	__le16 index[0];
@@ -89,6 +93,7 @@ struct mgmt_rp_read_index_list {
 #define MGMT_SETTING_LE			0x00000200
 
 #define MGMT_OP_READ_INFO		0x0004
+#define MGMT_READ_INFO_SIZE		0
 struct mgmt_rp_read_info {
 	bdaddr_t bdaddr;
 	__u8 version;
@@ -104,6 +109,8 @@ struct mgmt_mode {
 	__u8 val;
 } __packed;
 
+#define MGMT_SETTING_SIZE		1
+
 #define MGMT_OP_SET_POWERED		0x0005
 
 #define MGMT_OP_SET_DISCOVERABLE	0x0006
@@ -111,6 +118,7 @@ struct mgmt_cp_set_discoverable {
 	__u8 val;
 	__u16 timeout;
 } __packed;
+#define MGMT_SET_DISCOVERABLE_SIZE	3
 
 #define MGMT_OP_SET_CONNECTABLE		0x0007
 
@@ -131,23 +139,27 @@ struct mgmt_cp_set_dev_class {
 	__u8 major;
 	__u8 minor;
 } __packed;
+#define MGMT_SET_DEV_CLASS_SIZE		2
 
 #define MGMT_OP_SET_LOCAL_NAME		0x000F
 struct mgmt_cp_set_local_name {
 	__u8 name[MGMT_MAX_NAME_LENGTH];
 	__u8 short_name[MGMT_MAX_SHORT_NAME_LENGTH];
 } __packed;
+#define MGMT_SET_LOCAL_NAME_SIZE	260
 
 #define MGMT_OP_ADD_UUID		0x0010
 struct mgmt_cp_add_uuid {
 	__u8 uuid[16];
 	__u8 svc_hint;
 } __packed;
+#define MGMT_ADD_UUID_SIZE		17
 
 #define MGMT_OP_REMOVE_UUID		0x0011
 struct mgmt_cp_remove_uuid {
 	__u8 uuid[16];
 } __packed;
+#define MGMT_REMOVE_UUID_SIZE		16
 
 struct mgmt_link_key_info {
 	struct mgmt_addr_info addr;
@@ -162,6 +174,7 @@ struct mgmt_cp_load_link_keys {
 	__le16 key_count;
 	struct mgmt_link_key_info keys[0];
 } __packed;
+#define MGMT_LOAD_LINK_KEYS_SIZE	3
 
 struct mgmt_ltk_info {
 	struct mgmt_addr_info addr;
@@ -178,16 +191,19 @@ struct mgmt_cp_load_long_term_keys {
 	__le16 key_count;
 	struct mgmt_ltk_info keys[0];
 } __packed;
+#define MGMT_LOAD_LONG_TERM_KEYS_SIZE	2
 
 #define MGMT_OP_DISCONNECT		0x0014
 struct mgmt_cp_disconnect {
 	struct mgmt_addr_info addr;
 } __packed;
+#define MGMT_DISCONNECT_SIZE		MGMT_ADDR_INFO_SIZE
 struct mgmt_rp_disconnect {
 	struct mgmt_addr_info addr;
 } __packed;
 
 #define MGMT_OP_GET_CONNECTIONS		0x0015
+#define MGMT_GET_CONNECTIONS_SIZE	0
 struct mgmt_rp_get_connections {
 	__le16 conn_count;
 	struct mgmt_addr_info addr[0];
@@ -199,6 +215,7 @@ struct mgmt_cp_pin_code_reply {
 	__u8 pin_len;
 	__u8 pin_code[16];
 } __packed;
+#define MGMT_PIN_CODE_REPLY_SIZE	(MGMT_ADDR_INFO_SIZE + 17)
 struct mgmt_rp_pin_code_reply {
 	struct mgmt_addr_info addr;
 } __packed;
@@ -207,28 +224,33 @@ struct mgmt_rp_pin_code_reply {
 struct mgmt_cp_pin_code_neg_reply {
 	struct mgmt_addr_info addr;
 } __packed;
+#define MGMT_PIN_CODE_NEG_REPLY_SIZE	MGMT_ADDR_INFO_SIZE
 
 #define MGMT_OP_SET_IO_CAPABILITY	0x0018
 struct mgmt_cp_set_io_capability {
 	__u8 io_capability;
 } __packed;
+#define MGMT_SET_IO_CAPABILITY_SIZE	1
 
 #define MGMT_OP_PAIR_DEVICE		0x0019
 struct mgmt_cp_pair_device {
 	struct mgmt_addr_info addr;
 	__u8 io_cap;
 } __packed;
+#define MGMT_PAIR_DEVICE_SIZE		(MGMT_ADDR_INFO_SIZE + 1)
 struct mgmt_rp_pair_device {
 	struct mgmt_addr_info addr;
 } __packed;
 
 #define MGMT_OP_CANCEL_PAIR_DEVICE	0x001A
+#define MGMT_CANCEL_PAIR_DEVICE_SIZE	MGMT_ADDR_INFO_SIZE
 
 #define MGMT_OP_UNPAIR_DEVICE		0x001B
 struct mgmt_cp_unpair_device {
 	struct mgmt_addr_info addr;
 	__u8 disconnect;
 } __packed;
+#define MGMT_UNPAIR_DEVICE_SIZE		(MGMT_ADDR_INFO_SIZE + 1)
 struct mgmt_rp_unpair_device {
 	struct mgmt_addr_info addr;
 };
@@ -237,6 +259,7 @@ struct mgmt_rp_unpair_device {
 struct mgmt_cp_user_confirm_reply {
 	struct mgmt_addr_info addr;
 } __packed;
+#define MGMT_USER_CONFIRM_REPLY_SIZE	MGMT_ADDR_INFO_SIZE
 struct mgmt_rp_user_confirm_reply {
 	struct mgmt_addr_info addr;
 } __packed;
@@ -245,12 +268,14 @@ struct mgmt_rp_user_confirm_reply {
 struct mgmt_cp_user_confirm_neg_reply {
 	struct mgmt_addr_info addr;
 } __packed;
+#define MGMT_USER_CONFIRM_NEG_REPLY_SIZE MGMT_ADDR_INFO_SIZE
 
 #define MGMT_OP_USER_PASSKEY_REPLY	0x001E
 struct mgmt_cp_user_passkey_reply {
 	struct mgmt_addr_info addr;
 	__le32 passkey;
 } __packed;
+#define MGMT_USER_PASSKEY_REPLY_SIZE	(MGMT_ADDR_INFO_SIZE + 4)
 struct mgmt_rp_user_passkey_reply {
 	struct mgmt_addr_info addr;
 } __packed;
@@ -259,8 +284,10 @@ struct mgmt_rp_user_passkey_reply {
 struct mgmt_cp_user_passkey_neg_reply {
 	struct mgmt_addr_info addr;
 } __packed;
+#define MGMT_USER_PASSKEY_NEG_REPLY_SIZE MGMT_ADDR_INFO_SIZE
 
 #define MGMT_OP_READ_LOCAL_OOB_DATA	0x0020
+#define MGMT_READ_LOCAL_OOB_DATA_SIZE	0
 struct mgmt_rp_read_local_oob_data {
 	__u8 hash[16];
 	__u8 randomizer[16];
@@ -272,27 +299,32 @@ struct mgmt_cp_add_remote_oob_data {
 	__u8 hash[16];
 	__u8 randomizer[16];
 } __packed;
+#define MGMT_ADD_REMOTE_OOB_DATA_SIZE	(MGMT_ADDR_INFO_SIZE + 32)
 
 #define MGMT_OP_REMOVE_REMOTE_OOB_DATA	0x0022
 struct mgmt_cp_remove_remote_oob_data {
 	struct mgmt_addr_info addr;
 } __packed;
+#define MGMT_REMOVE_REMOTE_OOB_DATA_SIZE MGMT_ADDR_INFO_SIZE
 
 #define MGMT_OP_START_DISCOVERY		0x0023
 struct mgmt_cp_start_discovery {
 	__u8 type;
 } __packed;
+#define MGMT_START_DISCOVERY_SIZE	1
 
 #define MGMT_OP_STOP_DISCOVERY		0x0024
 struct mgmt_cp_stop_discovery {
 	__u8 type;
 } __packed;
+#define MGMT_STOP_DISCOVERY_SIZE	1
 
 #define MGMT_OP_CONFIRM_NAME		0x0025
 struct mgmt_cp_confirm_name {
 	struct mgmt_addr_info addr;
 	__u8 name_known;
 } __packed;
+#define MGMT_CONFIRM_NAME_SIZE		(MGMT_ADDR_INFO_SIZE + 1)
 struct mgmt_rp_confirm_name {
 	struct mgmt_addr_info addr;
 } __packed;
@@ -301,11 +333,13 @@ struct mgmt_rp_confirm_name {
 struct mgmt_cp_block_device {
 	struct mgmt_addr_info addr;
 } __packed;
+#define MGMT_BLOCK_DEVICE_SIZE		MGMT_ADDR_INFO_SIZE
 
 #define MGMT_OP_UNBLOCK_DEVICE		0x0027
 struct mgmt_cp_unblock_device {
 	struct mgmt_addr_info addr;
 } __packed;
+#define MGMT_UNBLOCK_DEVICE_SIZE	MGMT_ADDR_INFO_SIZE
 
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
-- 
1.7.9.1

