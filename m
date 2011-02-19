Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/8] Bluetooth: Make pending_add return a pointer to the added entry
Date: Sat, 19 Feb 2011 12:05:55 -0300
Message-Id: <1298127962-18576-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1298127962-18576-1-git-send-email-johan.hedberg@gmail.com>
References: <1298127962-18576-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@nokia.com>

This makes it more convenient to do manipulations on the entry (needed
by later commits).

Signed-off-by: Johan Hedberg <johan.hedberg@nokia.com>
---
 net/bluetooth/mgmt.c |   62 ++++++++++++++++++++++++++++++++-----------------
 1 files changed, 40 insertions(+), 22 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index f5ef7a3..52e5f88 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -219,14 +219,14 @@ static void mgmt_pending_free(struct pending_cmd *cmd)
 	kfree(cmd);
 }
 
-static int mgmt_pending_add(struct sock *sk, u16 opcode, int index,
-							void *data, u16 len)
+static struct pending_cmd *mgmt_pending_add(struct sock *sk, u16 opcode,
+						u16 index, void *data, u16 len)
 {
 	struct pending_cmd *cmd;
 
 	cmd = kmalloc(sizeof(*cmd), GFP_ATOMIC);
 	if (!cmd)
-		return -ENOMEM;
+		return NULL;
 
 	cmd->opcode = opcode;
 	cmd->index = index;
@@ -234,7 +234,7 @@ static int mgmt_pending_add(struct sock *sk, u16 opcode, int index,
 	cmd->cmd = kmalloc(len, GFP_ATOMIC);
 	if (!cmd->cmd) {
 		kfree(cmd);
-		return -ENOMEM;
+		return NULL;
 	}
 
 	memcpy(cmd->cmd, data, len);
@@ -244,7 +244,7 @@ static int mgmt_pending_add(struct sock *sk, u16 opcode, int index,
 
 	list_add(&cmd->list, &cmd_list);
 
-	return 0;
+	return cmd;
 }
 
 static void mgmt_pending_foreach(u16 opcode, int index,
@@ -305,8 +305,9 @@ static int set_powered(struct sock *sk, unsigned char *data, u16 len)
 {
 	struct mgmt_mode *cp;
 	struct hci_dev *hdev;
+	struct pending_cmd *cmd;
 	u16 dev_id;
-	int ret, up;
+	int err, up;
 
 	cp = (void *) data;
 	dev_id = get_unaligned_le16(&cp->index);
@@ -321,36 +322,39 @@ static int set_powered(struct sock *sk, unsigned char *data, u16 len)
 
 	up = test_bit(HCI_UP, &hdev->flags);
 	if ((cp->val && up) || (!cp->val && !up)) {
-		ret = cmd_status(sk, MGMT_OP_SET_POWERED, EALREADY);
+		err = cmd_status(sk, MGMT_OP_SET_POWERED, EALREADY);
 		goto failed;
 	}
 
 	if (mgmt_pending_find(MGMT_OP_SET_POWERED, dev_id)) {
-		ret = cmd_status(sk, MGMT_OP_SET_POWERED, EBUSY);
+		err = cmd_status(sk, MGMT_OP_SET_POWERED, EBUSY);
 		goto failed;
 	}
 
-	ret = mgmt_pending_add(sk, MGMT_OP_SET_POWERED, dev_id, data, len);
-	if (ret < 0)
+	cmd = mgmt_pending_add(sk, MGMT_OP_SET_POWERED, dev_id, data, len);
+	if (!cmd) {
+		err = -ENOMEM;
 		goto failed;
+	}
 
 	if (cp->val)
 		queue_work(hdev->workqueue, &hdev->power_on);
 	else
 		queue_work(hdev->workqueue, &hdev->power_off);
 
-	ret = 0;
+	err = 0;
 
 failed:
 	hci_dev_unlock_bh(hdev);
 	hci_dev_put(hdev);
-	return ret;
+	return err;
 }
 
 static int set_discoverable(struct sock *sk, unsigned char *data, u16 len)
 {
 	struct mgmt_mode *cp;
 	struct hci_dev *hdev;
+	struct pending_cmd *cmd;
 	u16 dev_id;
 	u8 scan;
 	int err;
@@ -383,9 +387,11 @@ static int set_discoverable(struct sock *sk, unsigned char *data, u16 len)
 		goto failed;
 	}
 
-	err = mgmt_pending_add(sk, MGMT_OP_SET_DISCOVERABLE, dev_id, data, len);
-	if (err < 0)
+	cmd = mgmt_pending_add(sk, MGMT_OP_SET_DISCOVERABLE, dev_id, data, len);
+	if (!cmd) {
+		err = -ENOMEM;
 		goto failed;
+	}
 
 	scan = SCAN_PAGE;
 
@@ -407,6 +413,7 @@ static int set_connectable(struct sock *sk, unsigned char *data, u16 len)
 {
 	struct mgmt_mode *cp;
 	struct hci_dev *hdev;
+	struct pending_cmd *cmd;
 	u16 dev_id;
 	u8 scan;
 	int err;
@@ -438,9 +445,11 @@ static int set_connectable(struct sock *sk, unsigned char *data, u16 len)
 		goto failed;
 	}
 
-	err = mgmt_pending_add(sk, MGMT_OP_SET_CONNECTABLE, dev_id, data, len);
-	if (err < 0)
+	cmd = mgmt_pending_add(sk, MGMT_OP_SET_CONNECTABLE, dev_id, data, len);
+	if (!cmd) {
+		err = -ENOMEM;
 		goto failed;
+	}
 
 	if (cp->val)
 		scan = SCAN_PAGE;
@@ -828,6 +837,7 @@ static int disconnect(struct sock *sk, unsigned char *data, u16 len)
 	struct hci_dev *hdev;
 	struct mgmt_cp_disconnect *cp;
 	struct hci_cp_disconnect dc;
+	struct pending_cmd *cmd;
 	struct hci_conn *conn;
 	u16 dev_id;
 	int err;
@@ -859,9 +869,11 @@ static int disconnect(struct sock *sk, unsigned char *data, u16 len)
 		goto failed;
 	}
 
-	err = mgmt_pending_add(sk, MGMT_OP_DISCONNECT, dev_id, data, len);
-	if (err < 0)
+	cmd = mgmt_pending_add(sk, MGMT_OP_DISCONNECT, dev_id, data, len);
+	if (!cmd) {
+		err = -ENOMEM;
 		goto failed;
+	}
 
 	put_unaligned_le16(conn->handle, &dc.handle);
 	dc.reason = 0x13; /* Remote User Terminated Connection */
@@ -938,6 +950,7 @@ static int pin_code_reply(struct sock *sk, unsigned char *data, u16 len)
 	struct hci_dev *hdev;
 	struct mgmt_cp_pin_code_reply *cp;
 	struct hci_cp_pin_code_reply reply;
+	struct pending_cmd *cmd;
 	u16 dev_id;
 	int err;
 
@@ -957,9 +970,11 @@ static int pin_code_reply(struct sock *sk, unsigned char *data, u16 len)
 		goto failed;
 	}
 
-	err = mgmt_pending_add(sk, MGMT_OP_PIN_CODE_REPLY, dev_id, data, len);
-	if (err < 0)
+	cmd = mgmt_pending_add(sk, MGMT_OP_PIN_CODE_REPLY, dev_id, data, len);
+	if (!cmd) {
+		err = -ENOMEM;
 		goto failed;
+	}
 
 	bacpy(&reply.bdaddr, &cp->bdaddr);
 	reply.pin_len = cp->pin_len;
@@ -980,6 +995,7 @@ static int pin_code_neg_reply(struct sock *sk, unsigned char *data, u16 len)
 {
 	struct hci_dev *hdev;
 	struct mgmt_cp_pin_code_neg_reply *cp;
+	struct pending_cmd *cmd;
 	u16 dev_id;
 	int err;
 
@@ -999,10 +1015,12 @@ static int pin_code_neg_reply(struct sock *sk, unsigned char *data, u16 len)
 		goto failed;
 	}
 
-	err = mgmt_pending_add(sk, MGMT_OP_PIN_CODE_NEG_REPLY, dev_id,
+	cmd = mgmt_pending_add(sk, MGMT_OP_PIN_CODE_NEG_REPLY, dev_id,
 								data, len);
-	if (err < 0)
+	if (!cmd) {
+		err = -ENOMEM;
 		goto failed;
+	}
 
 	err = hci_send_cmd(hdev, HCI_OP_PIN_CODE_NEG_REPLY, sizeof(bdaddr_t),
 								&cp->bdaddr);
-- 
1.7.4.1

