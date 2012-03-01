Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/5] Bluetooth: mgmt: Move command handlers into a table
Date: Thu,  1 Mar 2012 12:33:30 -0800
Message-Id: <1330634012-4502-3-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1330634012-4502-1-git-send-email-johan.hedberg@gmail.com>
References: <1330634012-4502-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

By moving the command handlers into a table (the index being equal to
the opcode) the lookup is made a bit more efficient. Having a struct to
describe each handler also paves the way to add more meta-data for each
handler, e.g. the minimum message size for the command and allow
handling of common tasks like this in a centralized place.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c |  219 ++++++++++++++++++--------------------------------
 1 files changed, 79 insertions(+), 140 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index cf8c840..88a342a 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -267,7 +267,8 @@ static int cmd_complete(struct sock *sk, u16 index, u16 cmd, u8 status,
 	return err;
 }
 
-static int read_version(struct sock *sk)
+static int read_version(struct sock *sk, struct hci_dev *hdev,
+						void *data, u16 data_len)
 {
 	struct mgmt_rp_read_version rp;
 
@@ -280,7 +281,8 @@ static int read_version(struct sock *sk)
 								sizeof(rp));
 }
 
-static int read_commands(struct sock *sk)
+static int read_commands(struct sock *sk, struct hci_dev *hdev,
+						void *data, u16 data_len)
 {
 	struct mgmt_rp_read_commands *rp;
 	u16 num_commands = ARRAY_SIZE(mgmt_commands);
@@ -313,7 +315,8 @@ static int read_commands(struct sock *sk)
 	return err;
 }
 
-static int read_index_list(struct sock *sk)
+static int read_index_list(struct sock *sk, struct hci_dev *hdev,
+						void *data, u16 data_len)
 {
 	struct mgmt_rp_read_index_list *rp;
 	struct list_head *p;
@@ -627,7 +630,8 @@ static void mgmt_init_hdev(struct sock *sk, struct hci_dev *hdev)
 	}
 }
 
-static int read_controller_info(struct sock *sk, struct hci_dev *hdev)
+static int read_controller_info(struct sock *sk, struct hci_dev *hdev,
+						void *data, u16 data_len)
 {
 	struct mgmt_rp_read_info rp;
 
@@ -1689,7 +1693,8 @@ static u8 link_to_mgmt(u8 link_type, u8 addr_type)
 	}
 }
 
-static int get_connections(struct sock *sk, struct hci_dev *hdev)
+static int get_connections(struct sock *sk, struct hci_dev *hdev,
+						void *data, u16 data_len)
 {
 	struct mgmt_rp_get_connections *rp;
 	struct hci_conn *c;
@@ -2015,9 +2020,9 @@ unlock:
 }
 
 static int cancel_pair_device(struct sock *sk, struct hci_dev *hdev,
-						unsigned char *data, u16 len)
+							void *data, u16 len)
 {
-	struct mgmt_addr_info *addr = (void *) data;
+	struct mgmt_addr_info *addr = data;
 	struct pending_cmd *cmd;
 	struct hci_conn *conn;
 	int err;
@@ -2240,7 +2245,8 @@ failed:
 	return err;
 }
 
-static int read_local_oob_data(struct sock *sk, struct hci_dev *hdev)
+static int read_local_oob_data(struct sock *sk, struct hci_dev *hdev,
+						void *data, u16 data_len)
 {
 	struct pending_cmd *cmd;
 	int err;
@@ -2718,6 +2724,53 @@ static int load_long_term_keys(struct sock *sk, struct hci_dev *hdev,
 	return 0;
 }
 
+struct mgmt_handler {
+	int (*func) (struct sock *sk, struct hci_dev *hdev,
+						void *data, u16 data_len);
+} mgmt_handlers[] = {
+	{ NULL }, /* 0x0000 (no command) */
+	{ read_version, },
+	{ read_commands, },
+	{ read_index_list, },
+	{ read_controller_info, },
+	{ set_powered, },
+	{ set_discoverable, },
+	{ set_connectable, },
+	{ set_fast_connectable, },
+	{ set_pairable,	},
+	{ set_link_security, },
+	{ set_ssp, },
+	{ set_hs, },
+	{ set_le, },
+	{ set_dev_class, },
+	{ set_local_name, },
+	{ add_uuid, },
+	{ remove_uuid, },
+	{ load_link_keys, },
+	{ load_long_term_keys, },
+	{ disconnect, },
+	{ get_connections, },
+	{ pin_code_reply, },
+	{ pin_code_neg_reply, },
+	{ set_io_capability, },
+	{ pair_device, },
+	{ cancel_pair_device, },
+	{ unpair_device, },
+	{ user_confirm_reply, },
+	{ user_confirm_neg_reply, },
+	{ user_passkey_reply, },
+	{ user_passkey_neg_reply, },
+	{ read_local_oob_data, },
+	{ add_remote_oob_data, },
+	{ remove_remote_oob_data, },
+	{ start_discovery, },
+	{ stop_discovery, },
+	{ confirm_name, },
+	{ block_device, },
+	{ unblock_device, },
+};
+
+
 int mgmt_control(struct sock *sk, struct msghdr *msg, size_t msglen)
 {
 	void *buf;
@@ -2751,150 +2804,36 @@ int mgmt_control(struct sock *sk, struct msghdr *msg, size_t msglen)
 		goto done;
 	}
 
-	if (opcode < MGMT_OP_READ_INFO) {
-		if (index != MGMT_INDEX_NONE) {
-			err = cmd_status(sk, index, opcode,
-						MGMT_STATUS_INVALID_PARAMS);
-			goto done;
-		}
-	} else {
+	if (index != MGMT_INDEX_NONE) {
 		hdev = hci_dev_get(index);
 		if (!hdev) {
 			err = cmd_status(sk, index, opcode,
-						MGMT_STATUS_INVALID_PARAMS);
+					MGMT_STATUS_INVALID_PARAMS);
 			goto done;
 		}
-
-		mgmt_init_hdev(sk, hdev);
 	}
 
-	cp = buf + sizeof(*hdr);
-
-	switch (opcode) {
-	case MGMT_OP_READ_VERSION:
-		err = read_version(sk);
-		break;
-	case MGMT_OP_READ_COMMANDS:
-		err = read_commands(sk);
-		break;
-	case MGMT_OP_READ_INDEX_LIST:
-		err = read_index_list(sk);
-		break;
-	case MGMT_OP_READ_INFO:
-		err = read_controller_info(sk, hdev);
-		break;
-	case MGMT_OP_SET_POWERED:
-		err = set_powered(sk, hdev, cp, len);
-		break;
-	case MGMT_OP_SET_DISCOVERABLE:
-		err = set_discoverable(sk, hdev, cp, len);
-		break;
-	case MGMT_OP_SET_CONNECTABLE:
-		err = set_connectable(sk, hdev, cp, len);
-		break;
-	case MGMT_OP_SET_FAST_CONNECTABLE:
-		err = set_fast_connectable(sk, hdev, cp, len);
-		break;
-	case MGMT_OP_SET_PAIRABLE:
-		err = set_pairable(sk, hdev, cp, len);
-		break;
-	case MGMT_OP_SET_LINK_SECURITY:
-		err = set_link_security(sk, hdev, cp, len);
-		break;
-	case MGMT_OP_SET_SSP:
-		err = set_ssp(sk, hdev, cp, len);
-		break;
-	case MGMT_OP_SET_HS:
-		err = set_hs(sk, hdev, cp, len);
-		break;
-	case MGMT_OP_SET_LE:
-		err = set_le(sk, hdev, cp, len);
-		break;
-	case MGMT_OP_ADD_UUID:
-		err = add_uuid(sk, hdev, cp, len);
-		break;
-	case MGMT_OP_REMOVE_UUID:
-		err = remove_uuid(sk, hdev, cp, len);
-		break;
-	case MGMT_OP_SET_DEV_CLASS:
-		err = set_dev_class(sk, hdev, cp, len);
-		break;
-	case MGMT_OP_LOAD_LINK_KEYS:
-		err = load_link_keys(sk, hdev, cp, len);
-		break;
-	case MGMT_OP_DISCONNECT:
-		err = disconnect(sk, hdev, cp, len);
-		break;
-	case MGMT_OP_GET_CONNECTIONS:
-		err = get_connections(sk, hdev);
-		break;
-	case MGMT_OP_PIN_CODE_REPLY:
-		err = pin_code_reply(sk, hdev, cp, len);
-		break;
-	case MGMT_OP_PIN_CODE_NEG_REPLY:
-		err = pin_code_neg_reply(sk, hdev, cp, len);
-		break;
-	case MGMT_OP_SET_IO_CAPABILITY:
-		err = set_io_capability(sk, hdev, cp, len);
-		break;
-	case MGMT_OP_PAIR_DEVICE:
-		err = pair_device(sk, hdev, cp, len);
-		break;
-	case MGMT_OP_CANCEL_PAIR_DEVICE:
-		err = cancel_pair_device(sk, hdev, buf + sizeof(*hdr), len);
-		break;
-	case MGMT_OP_UNPAIR_DEVICE:
-		err = unpair_device(sk, hdev, cp, len);
-		break;
-	case MGMT_OP_USER_CONFIRM_REPLY:
-		err = user_confirm_reply(sk, hdev, cp, len);
-		break;
-	case MGMT_OP_USER_CONFIRM_NEG_REPLY:
-		err = user_confirm_neg_reply(sk, hdev, cp, len);
-		break;
-	case MGMT_OP_USER_PASSKEY_REPLY:
-		err = user_passkey_reply(sk, hdev, cp, len);
-		break;
-	case MGMT_OP_USER_PASSKEY_NEG_REPLY:
-		err = user_passkey_neg_reply(sk, hdev, cp, len);
-		break;
-	case MGMT_OP_SET_LOCAL_NAME:
-		err = set_local_name(sk, hdev, cp, len);
-		break;
-	case MGMT_OP_READ_LOCAL_OOB_DATA:
-		err = read_local_oob_data(sk, hdev);
-		break;
-	case MGMT_OP_ADD_REMOTE_OOB_DATA:
-		err = add_remote_oob_data(sk, hdev, cp, len);
-		break;
-	case MGMT_OP_REMOVE_REMOTE_OOB_DATA:
-		err = remove_remote_oob_data(sk, hdev, cp, len);
-		break;
-	case MGMT_OP_START_DISCOVERY:
-		err = start_discovery(sk, hdev, cp, len);
-		break;
-	case MGMT_OP_STOP_DISCOVERY:
-		err = stop_discovery(sk, hdev, cp, len);
-		break;
-	case MGMT_OP_CONFIRM_NAME:
-		err = confirm_name(sk, hdev, cp, len);
-		break;
-	case MGMT_OP_BLOCK_DEVICE:
-		err = block_device(sk, hdev, cp, len);
-		break;
-	case MGMT_OP_UNBLOCK_DEVICE:
-		err = unblock_device(sk, hdev, cp, len);
-		break;
-	case MGMT_OP_LOAD_LONG_TERM_KEYS:
-		err = load_long_term_keys(sk, hdev, cp, len);
-		break;
-	default:
+	if (opcode >= ARRAY_SIZE(mgmt_handlers) ||
+					mgmt_handlers[opcode].func == NULL) {
 		BT_DBG("Unknown op %u", opcode);
 		err = cmd_status(sk, index, opcode,
 						MGMT_STATUS_UNKNOWN_COMMAND);
-		break;
+		goto done;
+	}
+
+	if ((hdev && opcode < MGMT_OP_READ_INFO) ||
+			(!hdev && opcode >= MGMT_OP_READ_INFO)) {
+		err = cmd_status(sk, index, opcode,
+						MGMT_STATUS_INVALID_PARAMS);
+		goto done;
 	}
 
+	if (hdev)
+		mgmt_init_hdev(sk, hdev);
+
+	cp = buf + sizeof(*hdr);
+
+	err = mgmt_handlers[opcode].func(sk, hdev, cp, len);
 	if (err < 0)
 		goto done;
 
-- 
1.7.9.1

