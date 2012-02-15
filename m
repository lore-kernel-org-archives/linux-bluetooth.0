Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Implement Read Supported Commands commands for mgmt
Date: Wed, 15 Feb 2012 14:05:04 +0200
Message-Id: <1329307504-28250-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch implements the Read Supported Commands mgmt command which was
recently added to the API specification. It returns a list of supported
commands and events to user space.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/mgmt.h |    7 +++
 net/bluetooth/mgmt.c         |  101 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 108 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 5b5edee..255a996 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -63,6 +63,13 @@ struct mgmt_rp_read_version {
 	__le16 revision;
 } __packed;
 
+#define MGMT_OP_READ_COMMANDS		0x0002
+struct mgmt_rp_read_commands {
+	__le16 num_commands;
+	__le16 num_events;
+	__le16 opcodes[0];
+} __packed;
+
 #define MGMT_OP_READ_INDEX_LIST		0x0003
 struct mgmt_rp_read_index_list {
 	__le16 num_controllers;
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index a2c2e12..dbd521d 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -35,6 +35,71 @@
 #define MGMT_VERSION	0
 #define MGMT_REVISION	1
 
+static u16 mgmt_commands[] = {
+	MGMT_OP_READ_INDEX_LIST,
+	MGMT_OP_READ_INFO,
+	MGMT_OP_SET_POWERED,
+	MGMT_OP_SET_DISCOVERABLE,
+	MGMT_OP_SET_CONNECTABLE,
+	MGMT_OP_SET_FAST_CONNECTABLE,
+	MGMT_OP_SET_PAIRABLE,
+	MGMT_OP_SET_LINK_SECURITY,
+	MGMT_OP_SET_SSP,
+	MGMT_OP_SET_HS,
+	MGMT_OP_SET_LE,
+	MGMT_OP_SET_DEV_CLASS,
+	MGMT_OP_SET_LOCAL_NAME,
+	MGMT_OP_ADD_UUID,
+	MGMT_OP_REMOVE_UUID,
+	MGMT_OP_LOAD_LINK_KEYS,
+	MGMT_OP_LOAD_LONG_TERM_KEYS,
+	MGMT_OP_DISCONNECT,
+	MGMT_OP_GET_CONNECTIONS,
+	MGMT_OP_PIN_CODE_REPLY,
+	MGMT_OP_PIN_CODE_NEG_REPLY,
+	MGMT_OP_SET_IO_CAPABILITY,
+	MGMT_OP_PAIR_DEVICE,
+	MGMT_OP_CANCEL_PAIR_DEVICE,
+	MGMT_OP_UNPAIR_DEVICE,
+	MGMT_OP_USER_CONFIRM_REPLY,
+	MGMT_OP_USER_CONFIRM_NEG_REPLY,
+	MGMT_OP_USER_PASSKEY_REPLY,
+	MGMT_OP_USER_PASSKEY_NEG_REPLY,
+	MGMT_OP_READ_LOCAL_OOB_DATA,
+	MGMT_OP_ADD_REMOTE_OOB_DATA,
+	MGMT_OP_REMOVE_REMOTE_OOB_DATA,
+	MGMT_OP_START_DISCOVERY,
+	MGMT_OP_STOP_DISCOVERY,
+	MGMT_OP_CONFIRM_NAME,
+	MGMT_OP_BLOCK_DEVICE,
+	MGMT_OP_UNBLOCK_DEVICE,
+};
+
+static u16 mgmt_events[] = {
+	MGMT_EV_CMD_COMPLETE,
+	MGMT_EV_CMD_STATUS,
+	MGMT_EV_CONTROLLER_ERROR,
+	MGMT_EV_INDEX_ADDED,
+	MGMT_EV_INDEX_REMOVED,
+	MGMT_EV_NEW_SETTINGS,
+	MGMT_EV_CLASS_OF_DEV_CHANGED,
+	MGMT_EV_LOCAL_NAME_CHANGED,
+	MGMT_EV_NEW_LINK_KEY,
+	MGMT_EV_NEW_LONG_TERM_KEY,
+	MGMT_EV_DEVICE_CONNECTED,
+	MGMT_EV_DEVICE_DISCONNECTED,
+	MGMT_EV_CONNECT_FAILED,
+	MGMT_EV_PIN_CODE_REQUEST,
+	MGMT_EV_USER_CONFIRM_REQUEST,
+	MGMT_EV_USER_PASSKEY_REQUEST,
+	MGMT_EV_AUTH_FAILED,
+	MGMT_EV_DEVICE_FOUND,
+	MGMT_EV_DISCOVERING,
+	MGMT_EV_DEVICE_BLOCKED,
+	MGMT_EV_DEVICE_UNBLOCKED,
+	MGMT_EV_DEVICE_UNPAIRED,
+};
+
 /*
  * These LE scan and inquiry parameters were chosen according to LE General
  * Discovery Procedure specification.
@@ -206,6 +271,39 @@ static int read_version(struct sock *sk)
 								sizeof(rp));
 }
 
+static int read_commands(struct sock *sk)
+{
+	struct mgmt_rp_read_commands *rp;
+	u16 num_commands = ARRAY_SIZE(mgmt_commands);
+	u16 num_events = ARRAY_SIZE(mgmt_events);
+	u16 *opcode;
+	size_t rp_size;
+	int i, err;
+
+	BT_DBG("sock %p", sk);
+
+	rp_size = sizeof(*rp) + ((num_commands + num_events) * sizeof(u16));
+
+	rp = kmalloc(rp_size, GFP_KERNEL);
+	if (!rp)
+		return -ENOMEM;
+
+	put_unaligned_le16(num_commands, &rp->num_commands);
+	put_unaligned_le16(num_events, &rp->num_events);
+
+	for (i = 0, opcode = rp->opcodes; i < num_commands; i++, opcode++)
+		put_unaligned_le16(mgmt_commands[i], opcode);
+
+	for (i = 0; i < num_events; i++, opcode++)
+		put_unaligned_le16(mgmt_events[i], opcode);
+
+	err = cmd_complete(sk, MGMT_INDEX_NONE, MGMT_OP_READ_COMMANDS, rp,
+								rp_size);
+	kfree(rp);
+
+	return err;
+}
+
 static int read_index_list(struct sock *sk)
 {
 	struct mgmt_rp_read_index_list *rp;
@@ -2323,6 +2421,9 @@ int mgmt_control(struct sock *sk, struct msghdr *msg, size_t msglen)
 	case MGMT_OP_READ_VERSION:
 		err = read_version(sk);
 		break;
+	case MGMT_OP_READ_COMMANDS:
+		err = read_commands(sk);
+		break;
 	case MGMT_OP_READ_INDEX_LIST:
 		err = read_index_list(sk);
 		break;
-- 
1.7.9

