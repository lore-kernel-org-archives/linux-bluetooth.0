Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 06/11] Bluetooth: Unify mode related management messages to a single struct
Date: Tue,  4 Jan 2011 12:08:47 +0200
Message-Id: <1294135732-26765-6-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1294135732-26765-1-git-send-email-johan.hedberg@gmail.com>
References: <1294135732-26765-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@nokia.com>

The powered, connectable and discoverable messages all have the same
format. By using a single struct for all of them a lot of code can be
simplified and reused.

Signed-off-by: Johan Hedberg <johan.hedberg@nokia.com>
---
 include/net/bluetooth/mgmt.h |   39 +-----------
 net/bluetooth/mgmt.c         |  137 +++++++++---------------------------------
 2 files changed, 32 insertions(+), 144 deletions(-)

diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 008acf5..f61fd67 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -59,35 +59,16 @@ struct mgmt_rp_read_info {
 	__u16 hci_rev;
 } __packed;
 
-#define MGMT_OP_SET_POWERED		0x0005
-struct mgmt_cp_set_powered {
+struct mgmt_mode {
 	__le16 index;
-	__u8 powered;
-} __packed;
-struct mgmt_rp_set_powered {
-	__le16 index;
-	__u8 powered;
+	__u8 val;
 } __packed;
 
+#define MGMT_OP_SET_POWERED		0x0005
+
 #define MGMT_OP_SET_DISCOVERABLE	0x0006
-struct mgmt_cp_set_discoverable {
-	__le16 index;
-	__u8 discoverable;
-} __packed;
-struct mgmt_rp_set_discoverable {
-	__le16 index;
-	__u8 discoverable;
-} __packed;
 
 #define MGMT_OP_SET_CONNECTABLE		0x0007
-struct mgmt_cp_set_connectable {
-	__le16 index;
-	__u8 connectable;
-} __packed;
-struct mgmt_rp_set_connectable {
-	__le16 index;
-	__u8 connectable;
-} __packed;
 
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
@@ -118,19 +99,7 @@ struct mgmt_ev_index_removed {
 } __packed;
 
 #define MGMT_EV_POWERED			0x0006
-struct mgmt_ev_powered {
-	__le16 index;
-	__u8 powered;
-} __packed;
 
 #define MGMT_EV_DISCOVERABLE		0x0007
-struct mgmt_ev_discoverable {
-	__le16 index;
-	__u8 discoverable;
-} __packed;
 
 #define MGMT_EV_CONNECTABLE		0x0008
-struct mgmt_ev_connectable {
-	__le16 index;
-	__u8 connectable;
-} __packed;
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index d3ec5d8..36a3e1c 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -320,7 +320,7 @@ static void mgmt_pending_remove(u16 opcode, int index)
 
 static int set_powered(struct sock *sk, unsigned char *data, u16 len)
 {
-	struct mgmt_cp_set_powered *cp;
+	struct mgmt_mode *cp;
 	struct hci_dev *hdev;
 	u16 dev_id;
 	int ret, up;
@@ -337,7 +337,7 @@ static int set_powered(struct sock *sk, unsigned char *data, u16 len)
 	hci_dev_lock_bh(hdev);
 
 	up = test_bit(HCI_UP, &hdev->flags);
-	if ((cp->powered && up) || (!cp->powered && !up)) {
+	if ((cp->val && up) || (!cp->val && !up)) {
 		ret = cmd_status(sk, MGMT_OP_SET_POWERED, EALREADY);
 		goto failed;
 	}
@@ -351,7 +351,7 @@ static int set_powered(struct sock *sk, unsigned char *data, u16 len)
 	if (ret < 0)
 		goto failed;
 
-	if (cp->powered)
+	if (cp->val)
 		queue_work(hdev->workqueue, &hdev->power_on);
 	else
 		queue_work(hdev->workqueue, &hdev->power_off);
@@ -366,7 +366,7 @@ failed:
 
 static int set_discoverable(struct sock *sk, unsigned char *data, u16 len)
 {
-	struct mgmt_cp_set_discoverable *cp;
+	struct mgmt_mode *cp;
 	struct hci_dev *hdev;
 	u16 dev_id;
 	u8 scan;
@@ -394,7 +394,7 @@ static int set_discoverable(struct sock *sk, unsigned char *data, u16 len)
 		goto failed;
 	}
 
-	if (cp->discoverable == test_bit(HCI_ISCAN, &hdev->flags) &&
+	if (cp->val == test_bit(HCI_ISCAN, &hdev->flags) &&
 					test_bit(HCI_PSCAN, &hdev->flags)) {
 		err = cmd_status(sk, MGMT_OP_SET_DISCOVERABLE, EALREADY);
 		goto failed;
@@ -406,7 +406,7 @@ static int set_discoverable(struct sock *sk, unsigned char *data, u16 len)
 
 	scan = SCAN_PAGE;
 
-	if (cp->discoverable)
+	if (cp->val)
 		scan |= SCAN_INQUIRY;
 
 	err = hci_send_cmd(hdev, HCI_OP_WRITE_SCAN_ENABLE, 1, &scan);
@@ -422,7 +422,7 @@ failed:
 
 static int set_connectable(struct sock *sk, unsigned char *data, u16 len)
 {
-	struct mgmt_cp_set_connectable *cp;
+	struct mgmt_mode *cp;
 	struct hci_dev *hdev;
 	u16 dev_id;
 	u8 scan;
@@ -450,7 +450,7 @@ static int set_connectable(struct sock *sk, unsigned char *data, u16 len)
 		goto failed;
 	}
 
-	if (cp->connectable == test_bit(HCI_PSCAN, &hdev->flags)) {
+	if (cp->val == test_bit(HCI_PSCAN, &hdev->flags)) {
 		err = cmd_status(sk, MGMT_OP_SET_CONNECTABLE, EALREADY);
 		goto failed;
 	}
@@ -459,7 +459,7 @@ static int set_connectable(struct sock *sk, unsigned char *data, u16 len)
 	if (err < 0)
 		goto failed;
 
-	if (cp->connectable)
+	if (cp->val)
 		scan = SCAN_PAGE;
 	else
 		scan = 0;
@@ -582,20 +582,20 @@ int mgmt_index_removed(u16 index)
 }
 
 struct cmd_lookup {
-	u8 value;
+	u8 val;
 	struct sock *sk;
 };
 
-static void power_rsp(struct pending_cmd *cmd, void *data)
+static void mode_rsp(struct pending_cmd *cmd, void *data)
 {
 	struct mgmt_hdr *hdr;
 	struct mgmt_ev_cmd_complete *ev;
-	struct mgmt_rp_set_powered *rp;
-	struct mgmt_cp_set_powered *cp = cmd->cmd;
+	struct mgmt_mode *rp;
+	struct mgmt_mode *cp = cmd->cmd;
 	struct sk_buff *skb;
 	struct cmd_lookup *match = data;
 
-	if (cp->powered != match->value)
+	if (cp->val != match->val)
 		return;
 
 	skb = alloc_skb(sizeof(*hdr) + sizeof(*ev) + sizeof(*rp), GFP_ATOMIC);
@@ -611,7 +611,7 @@ static void power_rsp(struct pending_cmd *cmd, void *data)
 
 	rp = (void *) skb_put(skb, sizeof(*rp));
 	put_unaligned_le16(cmd->index, &rp->index);
-	rp->powered = cp->powered;
+	rp->val = cp->val;
 
 	if (sock_queue_rcv_skb(cmd->sk, skb) < 0)
 		kfree_skb(skb);
@@ -628,14 +628,14 @@ static void power_rsp(struct pending_cmd *cmd, void *data)
 
 int mgmt_powered(u16 index, u8 powered)
 {
-	struct mgmt_ev_powered ev;
+	struct mgmt_mode ev;
 	struct cmd_lookup match = { powered, NULL };
 	int ret;
 
-	put_unaligned_le16(index, &ev.index);
-	ev.powered = powered;
+	mgmt_pending_foreach(MGMT_OP_SET_POWERED, index, mode_rsp, &match);
 
-	mgmt_pending_foreach(MGMT_OP_SET_POWERED, index, power_rsp, &match);
+	put_unaligned_le16(index, &ev.index);
+	ev.val = powered;
 
 	ret = mgmt_event(MGMT_EV_POWERED, &ev, sizeof(ev), match.sk);
 
@@ -645,57 +645,17 @@ int mgmt_powered(u16 index, u8 powered)
 	return ret;
 }
 
-static void discoverable_rsp(struct pending_cmd *cmd, void *data)
-{
-	struct mgmt_cp_set_discoverable *cp = cmd->cmd;
-	struct cmd_lookup *match = data;
-	struct sk_buff *skb;
-	struct mgmt_hdr *hdr;
-	struct mgmt_ev_cmd_complete *ev;
-	struct mgmt_rp_set_discoverable *rp;
-
-	if (cp->discoverable != match->value)
-		return;
-
-	skb = alloc_skb(sizeof(*hdr) + sizeof(*ev) + sizeof(*rp), GFP_ATOMIC);
-	if (!skb)
-		return;
-
-	hdr = (void *) skb_put(skb, sizeof(*hdr));
-	hdr->opcode = cpu_to_le16(MGMT_EV_CMD_COMPLETE);
-	hdr->len = cpu_to_le16(sizeof(*ev) + sizeof(*rp));
-
-	ev = (void *) skb_put(skb, sizeof(*ev));
-	put_unaligned_le16(MGMT_OP_SET_DISCOVERABLE, &ev->opcode);
-
-	rp = (void *) skb_put(skb, sizeof(*rp));
-	put_unaligned_le16(cmd->index, &rp->index);
-	rp->discoverable = cp->discoverable;
-
-	if (sock_queue_rcv_skb(cmd->sk, skb) < 0)
-		kfree_skb(skb);
-
-	list_del(&cmd->list);
-
-	if (match->sk == NULL) {
-		match->sk = cmd->sk;
-		sock_hold(match->sk);
-	}
-
-	mgmt_pending_free(cmd);
-}
-
 int mgmt_discoverable(u16 index, u8 discoverable)
 {
-	struct mgmt_ev_discoverable ev;
+	struct mgmt_mode ev;
 	struct cmd_lookup match = { discoverable, NULL };
 	int ret;
 
-	put_unaligned_le16(index, &ev.index);
-	ev.discoverable = discoverable;
-
 	mgmt_pending_foreach(MGMT_OP_SET_DISCOVERABLE, index,
-						discoverable_rsp, &match);
+							mode_rsp, &match);
+
+	put_unaligned_le16(index, &ev.index);
+	ev.val = discoverable;
 
 	ret = mgmt_event(MGMT_EV_DISCOVERABLE, &ev, sizeof(ev), match.sk);
 
@@ -705,57 +665,16 @@ int mgmt_discoverable(u16 index, u8 discoverable)
 	return ret;
 }
 
-static void connectable_rsp(struct pending_cmd *cmd, void *data)
-{
-	struct mgmt_cp_set_connectable *cp = cmd->cmd;
-	struct cmd_lookup *match = data;
-	struct sk_buff *skb;
-	struct mgmt_hdr *hdr;
-	struct mgmt_ev_cmd_complete *ev;
-	struct mgmt_rp_set_connectable *rp;
-
-	if (cp->connectable != match->value)
-		return;
-
-	skb = alloc_skb(sizeof(*hdr) + sizeof(*ev) + sizeof(*rp), GFP_ATOMIC);
-	if (!skb)
-		return;
-
-	hdr = (void *) skb_put(skb, sizeof(*hdr));
-	hdr->opcode = cpu_to_le16(MGMT_EV_CMD_COMPLETE);
-	hdr->len = cpu_to_le16(sizeof(*ev) + sizeof(*rp));
-
-	ev = (void *) skb_put(skb, sizeof(*ev));
-	put_unaligned_le16(MGMT_OP_SET_CONNECTABLE, &ev->opcode);
-
-	rp = (void *) skb_put(skb, sizeof(*rp));
-	put_unaligned_le16(cmd->index, &rp->index);
-	rp->connectable = cp->connectable;
-
-	if (sock_queue_rcv_skb(cmd->sk, skb) < 0)
-		kfree_skb(skb);
-
-	list_del(&cmd->list);
-
-	if (match->sk == NULL) {
-		match->sk = cmd->sk;
-		sock_hold(match->sk);
-	}
-
-	mgmt_pending_free(cmd);
-}
-
 int mgmt_connectable(u16 index, u8 connectable)
 {
-	struct mgmt_ev_connectable ev;
+	struct mgmt_mode ev;
 	struct cmd_lookup match = { connectable, NULL };
 	int ret;
 
-	put_unaligned_le16(index, &ev.index);
-	ev.connectable = connectable;
+	mgmt_pending_foreach(MGMT_OP_SET_CONNECTABLE, index, mode_rsp, &match);
 
-	mgmt_pending_foreach(MGMT_OP_SET_CONNECTABLE, index,
-						connectable_rsp, &match);
+	put_unaligned_le16(index, &ev.index);
+	ev.val = connectable;
 
 	ret = mgmt_event(MGMT_EV_CONNECTABLE, &ev, sizeof(ev), match.sk);
 
-- 
1.7.2.3

