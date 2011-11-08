Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/3] Bluetooth: Move pending management command list into struct hci_dev
Date: Tue,  8 Nov 2011 20:40:15 +0200
Message-Id: <1320777616-15794-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1320777616-15794-1-git-send-email-johan.hedberg@gmail.com>
References: <1320777616-15794-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch moves the pending management command list (previously global
to mgmt.c) into struct hci_dev. This makes it possible to do proper
locking when accessing it (through the existing hci_dev locks) and
thereby avoid race conditions.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h |    2 +
 net/bluetooth/hci_core.c         |    6 +++
 net/bluetooth/mgmt.c             |   79 +++++++++++++++++++-------------------
 3 files changed, 47 insertions(+), 40 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 0f35a39..0a5a05d 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -217,6 +217,8 @@ struct hci_dev {
 
 	__u16			init_last_cmd;
 
+	struct list_head	mgmt_pending;
+
 	struct inquiry_cache	inq_cache;
 	struct hci_conn_hash	conn_hash;
 	struct list_head	blacklist;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index e4b5c63..e5cf013 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1481,6 +1481,8 @@ int hci_register_dev(struct hci_dev *hdev)
 
 	hci_conn_hash_init(hdev);
 
+	INIT_LIST_HEAD(&hdev->mgmt_pending);
+
 	INIT_LIST_HEAD(&hdev->blacklist);
 
 	INIT_LIST_HEAD(&hdev->uuids);
@@ -1562,6 +1564,10 @@ void hci_unregister_dev(struct hci_dev *hdev)
 					!test_bit(HCI_SETUP, &hdev->flags))
 		mgmt_index_removed(hdev);
 
+	/* mgmt_index_removed should take care of emptying the
+	 * pending list */
+	BUG_ON(!list_empty(&hdev->mgmt_pending));
+
 	hci_notify(hdev, HCI_DEV_UNREG);
 
 	if (hdev->rfkill) {
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 2ca7b44..be198f3 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -43,8 +43,6 @@ struct pending_cmd {
 	void *user_data;
 };
 
-static LIST_HEAD(cmd_list);
-
 static int cmd_status(struct sock *sk, u16 index, u16 cmd, u8 status)
 {
 	struct sk_buff *skb;
@@ -227,7 +225,8 @@ static void mgmt_pending_free(struct pending_cmd *cmd)
 }
 
 static struct pending_cmd *mgmt_pending_add(struct sock *sk, u16 opcode,
-						u16 index, void *data, u16 len)
+							struct hci_dev *hdev,
+							void *data, u16 len)
 {
 	struct pending_cmd *cmd;
 
@@ -236,7 +235,7 @@ static struct pending_cmd *mgmt_pending_add(struct sock *sk, u16 opcode,
 		return NULL;
 
 	cmd->opcode = opcode;
-	cmd->index = index;
+	cmd->index = hdev->id;
 
 	cmd->param = kmalloc(len, GFP_ATOMIC);
 	if (!cmd->param) {
@@ -250,7 +249,7 @@ static struct pending_cmd *mgmt_pending_add(struct sock *sk, u16 opcode,
 	cmd->sk = sk;
 	sock_hold(sk);
 
-	list_add(&cmd->list, &cmd_list);
+	list_add(&cmd->list, &hdev->mgmt_pending);
 
 	return cmd;
 }
@@ -261,7 +260,7 @@ static void mgmt_pending_foreach(u16 opcode, struct hci_dev *hdev,
 {
 	struct list_head *p, *n;
 
-	list_for_each_safe(p, n, &cmd_list) {
+	list_for_each_safe(p, n, &hdev->mgmt_pending) {
 		struct pending_cmd *cmd;
 
 		cmd = list_entry(p, struct pending_cmd, list);
@@ -276,15 +275,15 @@ static void mgmt_pending_foreach(u16 opcode, struct hci_dev *hdev,
 	}
 }
 
-static struct pending_cmd *mgmt_pending_find(u16 opcode, int index)
+static struct pending_cmd *mgmt_pending_find(u16 opcode, struct hci_dev *hdev)
 {
 	struct pending_cmd *cmd;
 
-	list_for_each_entry(cmd, &cmd_list, list) {
+	list_for_each_entry(cmd, &hdev->mgmt_pending, list) {
 		if (cmd->opcode != opcode)
 			continue;
 
-		if (index >= 0 && cmd->index != index)
+		if (hdev && cmd->index != hdev->id)
 			continue;
 
 		return cmd;
@@ -325,12 +324,12 @@ static int set_powered(struct sock *sk, u16 index, unsigned char *data, u16 len)
 		goto failed;
 	}
 
-	if (mgmt_pending_find(MGMT_OP_SET_POWERED, index)) {
+	if (mgmt_pending_find(MGMT_OP_SET_POWERED, hdev)) {
 		err = cmd_status(sk, index, MGMT_OP_SET_POWERED, EBUSY);
 		goto failed;
 	}
 
-	cmd = mgmt_pending_add(sk, MGMT_OP_SET_POWERED, index, data, len);
+	cmd = mgmt_pending_add(sk, MGMT_OP_SET_POWERED, hdev, data, len);
 	if (!cmd) {
 		err = -ENOMEM;
 		goto failed;
@@ -376,8 +375,8 @@ static int set_discoverable(struct sock *sk, u16 index, unsigned char *data,
 		goto failed;
 	}
 
-	if (mgmt_pending_find(MGMT_OP_SET_DISCOVERABLE, index) ||
-			mgmt_pending_find(MGMT_OP_SET_CONNECTABLE, index)) {
+	if (mgmt_pending_find(MGMT_OP_SET_DISCOVERABLE, hdev) ||
+			mgmt_pending_find(MGMT_OP_SET_CONNECTABLE, hdev)) {
 		err = cmd_status(sk, index, MGMT_OP_SET_DISCOVERABLE, EBUSY);
 		goto failed;
 	}
@@ -388,7 +387,7 @@ static int set_discoverable(struct sock *sk, u16 index, unsigned char *data,
 		goto failed;
 	}
 
-	cmd = mgmt_pending_add(sk, MGMT_OP_SET_DISCOVERABLE, index, data, len);
+	cmd = mgmt_pending_add(sk, MGMT_OP_SET_DISCOVERABLE, hdev, data, len);
 	if (!cmd) {
 		err = -ENOMEM;
 		goto failed;
@@ -442,8 +441,8 @@ static int set_connectable(struct sock *sk, u16 index, unsigned char *data,
 		goto failed;
 	}
 
-	if (mgmt_pending_find(MGMT_OP_SET_DISCOVERABLE, index) ||
-			mgmt_pending_find(MGMT_OP_SET_CONNECTABLE, index)) {
+	if (mgmt_pending_find(MGMT_OP_SET_DISCOVERABLE, hdev) ||
+			mgmt_pending_find(MGMT_OP_SET_CONNECTABLE, hdev)) {
 		err = cmd_status(sk, index, MGMT_OP_SET_CONNECTABLE, EBUSY);
 		goto failed;
 	}
@@ -453,7 +452,7 @@ static int set_connectable(struct sock *sk, u16 index, unsigned char *data,
 		goto failed;
 	}
 
-	cmd = mgmt_pending_add(sk, MGMT_OP_SET_CONNECTABLE, index, data, len);
+	cmd = mgmt_pending_add(sk, MGMT_OP_SET_CONNECTABLE, hdev, data, len);
 	if (!cmd) {
 		err = -ENOMEM;
 		goto failed;
@@ -1038,7 +1037,7 @@ static int disconnect(struct sock *sk, u16 index, unsigned char *data, u16 len)
 		goto failed;
 	}
 
-	if (mgmt_pending_find(MGMT_OP_DISCONNECT, index)) {
+	if (mgmt_pending_find(MGMT_OP_DISCONNECT, hdev)) {
 		err = cmd_status(sk, index, MGMT_OP_DISCONNECT, EBUSY);
 		goto failed;
 	}
@@ -1052,7 +1051,7 @@ static int disconnect(struct sock *sk, u16 index, unsigned char *data, u16 len)
 		goto failed;
 	}
 
-	cmd = mgmt_pending_add(sk, MGMT_OP_DISCONNECT, index, data, len);
+	cmd = mgmt_pending_add(sk, MGMT_OP_DISCONNECT, hdev, data, len);
 	if (!cmd) {
 		err = -ENOMEM;
 		goto failed;
@@ -1143,7 +1142,7 @@ static int send_pin_code_neg_reply(struct sock *sk, u16 index,
 	struct pending_cmd *cmd;
 	int err;
 
-	cmd = mgmt_pending_add(sk, MGMT_OP_PIN_CODE_NEG_REPLY, index, cp,
+	cmd = mgmt_pending_add(sk, MGMT_OP_PIN_CODE_NEG_REPLY, hdev, cp,
 								sizeof(*cp));
 	if (!cmd)
 		return -ENOMEM;
@@ -1204,7 +1203,7 @@ static int pin_code_reply(struct sock *sk, u16 index, unsigned char *data,
 		goto failed;
 	}
 
-	cmd = mgmt_pending_add(sk, MGMT_OP_PIN_CODE_REPLY, index, data, len);
+	cmd = mgmt_pending_add(sk, MGMT_OP_PIN_CODE_REPLY, hdev, data, len);
 	if (!cmd) {
 		err = -ENOMEM;
 		goto failed;
@@ -1297,7 +1296,7 @@ static inline struct pending_cmd *find_pairing(struct hci_conn *conn)
 	struct hci_dev *hdev = conn->hdev;
 	struct pending_cmd *cmd;
 
-	list_for_each_entry(cmd, &cmd_list, list) {
+	list_for_each_entry(cmd, &hdev->mgmt_pending, list) {
 		if (cmd->opcode != MGMT_OP_PAIR_DEVICE)
 			continue;
 
@@ -1396,7 +1395,7 @@ static int pair_device(struct sock *sk, u16 index, unsigned char *data, u16 len)
 		goto unlock;
 	}
 
-	cmd = mgmt_pending_add(sk, MGMT_OP_PAIR_DEVICE, index, data, len);
+	cmd = mgmt_pending_add(sk, MGMT_OP_PAIR_DEVICE, hdev, data, len);
 	if (!cmd) {
 		err = -ENOMEM;
 		hci_conn_put(conn);
@@ -1458,7 +1457,7 @@ static int user_confirm_reply(struct sock *sk, u16 index, unsigned char *data,
 		goto failed;
 	}
 
-	cmd = mgmt_pending_add(sk, mgmt_op, index, data, len);
+	cmd = mgmt_pending_add(sk, mgmt_op, hdev, data, len);
 	if (!cmd) {
 		err = -ENOMEM;
 		goto failed;
@@ -1495,7 +1494,7 @@ static int set_local_name(struct sock *sk, u16 index, unsigned char *data,
 
 	hci_dev_lock_bh(hdev);
 
-	cmd = mgmt_pending_add(sk, MGMT_OP_SET_LOCAL_NAME, index, data, len);
+	cmd = mgmt_pending_add(sk, MGMT_OP_SET_LOCAL_NAME, hdev, data, len);
 	if (!cmd) {
 		err = -ENOMEM;
 		goto failed;
@@ -1541,12 +1540,12 @@ static int read_local_oob_data(struct sock *sk, u16 index)
 		goto unlock;
 	}
 
-	if (mgmt_pending_find(MGMT_OP_READ_LOCAL_OOB_DATA, index)) {
+	if (mgmt_pending_find(MGMT_OP_READ_LOCAL_OOB_DATA, hdev)) {
 		err = cmd_status(sk, index, MGMT_OP_READ_LOCAL_OOB_DATA, EBUSY);
 		goto unlock;
 	}
 
-	cmd = mgmt_pending_add(sk, MGMT_OP_READ_LOCAL_OOB_DATA, index, NULL, 0);
+	cmd = mgmt_pending_add(sk, MGMT_OP_READ_LOCAL_OOB_DATA, hdev, NULL, 0);
 	if (!cmd) {
 		err = -ENOMEM;
 		goto unlock;
@@ -1650,7 +1649,7 @@ static int start_discovery(struct sock *sk, u16 index)
 		goto failed;
 	}
 
-	cmd = mgmt_pending_add(sk, MGMT_OP_START_DISCOVERY, index, NULL, 0);
+	cmd = mgmt_pending_add(sk, MGMT_OP_START_DISCOVERY, hdev, NULL, 0);
 	if (!cmd) {
 		err = -ENOMEM;
 		goto failed;
@@ -1681,7 +1680,7 @@ static int stop_discovery(struct sock *sk, u16 index)
 
 	hci_dev_lock_bh(hdev);
 
-	cmd = mgmt_pending_add(sk, MGMT_OP_STOP_DISCOVERY, index, NULL, 0);
+	cmd = mgmt_pending_add(sk, MGMT_OP_STOP_DISCOVERY, hdev, NULL, 0);
 	if (!cmd) {
 		err = -ENOMEM;
 		goto failed;
@@ -2147,7 +2146,7 @@ int mgmt_disconnect_failed(struct hci_dev *hdev)
 	struct pending_cmd *cmd;
 	int err;
 
-	cmd = mgmt_pending_find(MGMT_OP_DISCONNECT, hdev->id);
+	cmd = mgmt_pending_find(MGMT_OP_DISCONNECT, hdev);
 	if (!cmd)
 		return -ENOENT;
 
@@ -2188,7 +2187,7 @@ int mgmt_pin_code_reply_complete(struct hci_dev *hdev, bdaddr_t *bdaddr,
 	struct mgmt_rp_pin_code_reply rp;
 	int err;
 
-	cmd = mgmt_pending_find(MGMT_OP_PIN_CODE_REPLY, hdev->id);
+	cmd = mgmt_pending_find(MGMT_OP_PIN_CODE_REPLY, hdev);
 	if (!cmd)
 		return -ENOENT;
 
@@ -2210,7 +2209,7 @@ int mgmt_pin_code_neg_reply_complete(struct hci_dev *hdev, bdaddr_t *bdaddr,
 	struct mgmt_rp_pin_code_reply rp;
 	int err;
 
-	cmd = mgmt_pending_find(MGMT_OP_PIN_CODE_NEG_REPLY, hdev->id);
+	cmd = mgmt_pending_find(MGMT_OP_PIN_CODE_NEG_REPLY, hdev);
 	if (!cmd)
 		return -ENOENT;
 
@@ -2247,7 +2246,7 @@ static int confirm_reply_complete(struct hci_dev *hdev, bdaddr_t *bdaddr,
 	struct mgmt_rp_user_confirm_reply rp;
 	int err;
 
-	cmd = mgmt_pending_find(opcode, hdev->id);
+	cmd = mgmt_pending_find(opcode, hdev);
 	if (!cmd)
 		return -ENOENT;
 
@@ -2293,7 +2292,7 @@ int mgmt_set_local_name_complete(struct hci_dev *hdev, u8 *name, u8 status)
 	memset(&ev, 0, sizeof(ev));
 	memcpy(ev.name, name, HCI_MAX_NAME_LENGTH);
 
-	cmd = mgmt_pending_find(MGMT_OP_SET_LOCAL_NAME, hdev->id);
+	cmd = mgmt_pending_find(MGMT_OP_SET_LOCAL_NAME, hdev);
 	if (!cmd)
 		goto send_event;
 
@@ -2330,7 +2329,7 @@ int mgmt_read_local_oob_data_reply_complete(struct hci_dev *hdev, u8 *hash,
 
 	BT_DBG("%s status %u", hdev->name, status);
 
-	cmd = mgmt_pending_find(MGMT_OP_READ_LOCAL_OOB_DATA, hdev->id);
+	cmd = mgmt_pending_find(MGMT_OP_READ_LOCAL_OOB_DATA, hdev);
 	if (!cmd)
 		return -ENOENT;
 
@@ -2390,7 +2389,7 @@ int mgmt_inquiry_failed(struct hci_dev *hdev, u8 status)
 	struct pending_cmd *cmd;
 	int err;
 
-	cmd = mgmt_pending_find(MGMT_OP_START_DISCOVERY, hdev->id);
+	cmd = mgmt_pending_find(MGMT_OP_START_DISCOVERY, hdev);
 	if (!cmd)
 		return -ENOENT;
 
@@ -2405,9 +2404,9 @@ int mgmt_discovering(struct hci_dev *hdev, u8 discovering)
 	struct pending_cmd *cmd;
 
 	if (discovering)
-		cmd = mgmt_pending_find(MGMT_OP_START_DISCOVERY, hdev->id);
+		cmd = mgmt_pending_find(MGMT_OP_START_DISCOVERY, hdev);
 	else
-		cmd = mgmt_pending_find(MGMT_OP_STOP_DISCOVERY, hdev->id);
+		cmd = mgmt_pending_find(MGMT_OP_STOP_DISCOVERY, hdev);
 
 	if (cmd != NULL) {
 		cmd_complete(cmd->sk, hdev->id, cmd->opcode, NULL, 0);
@@ -2423,7 +2422,7 @@ int mgmt_device_blocked(struct hci_dev *hdev, bdaddr_t *bdaddr)
 	struct pending_cmd *cmd;
 	struct mgmt_ev_device_blocked ev;
 
-	cmd = mgmt_pending_find(MGMT_OP_BLOCK_DEVICE, hdev->id);
+	cmd = mgmt_pending_find(MGMT_OP_BLOCK_DEVICE, hdev);
 
 	bacpy(&ev.bdaddr, bdaddr);
 
@@ -2436,7 +2435,7 @@ int mgmt_device_unblocked(struct hci_dev *hdev, bdaddr_t *bdaddr)
 	struct pending_cmd *cmd;
 	struct mgmt_ev_device_unblocked ev;
 
-	cmd = mgmt_pending_find(MGMT_OP_UNBLOCK_DEVICE, hdev->id);
+	cmd = mgmt_pending_find(MGMT_OP_UNBLOCK_DEVICE, hdev);
 
 	bacpy(&ev.bdaddr, bdaddr);
 
-- 
1.7.7.1

