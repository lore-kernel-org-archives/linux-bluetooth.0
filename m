Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 03/11] Bluetooth: Add support for set_powered management command
Date: Tue,  4 Jan 2011 12:08:44 +0200
Message-Id: <1294135732-26765-3-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1294135732-26765-1-git-send-email-johan.hedberg@gmail.com>
References: <1294135732-26765-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@nokia.com>

This patch adds a set_powered command to the management interface
through which the powered state of local adapters can be controlled.

Signed-off-by: Johan Hedberg <johan.hedberg@nokia.com>
---
 include/net/bluetooth/hci_core.h |    3 +-
 include/net/bluetooth/mgmt.h     |   10 ++
 net/bluetooth/hci_core.c         |    4 +-
 net/bluetooth/hci_event.c        |    2 +-
 net/bluetooth/hci_sock.c         |    6 +-
 net/bluetooth/mgmt.c             |  200 +++++++++++++++++++++++++++++++++++++-
 6 files changed, 215 insertions(+), 10 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 6449ff8..b6078ba 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -665,7 +665,8 @@ void *hci_sent_cmd_data(struct hci_dev *hdev, __u16 opcode);
 void hci_si_event(struct hci_dev *hdev, int type, int dlen, void *data);
 
 /* ----- HCI Sockets ----- */
-void hci_send_to_sock(struct hci_dev *hdev, struct sk_buff *skb);
+void hci_send_to_sock(struct hci_dev *hdev, struct sk_buff *skb,
+							struct sock *skip_sk);
 
 /* Management interface */
 int mgmt_control(struct sock *sk, struct msghdr *msg, size_t len);
diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 0ac1520..81ef789 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -58,6 +58,16 @@ struct mgmt_rp_read_info {
 	__u16 hci_rev;
 } __packed;
 
+#define MGMT_OP_SET_POWERED		0x0005
+struct mgmt_cp_set_powered {
+	__le16 index;
+	__u8 powered;
+} __packed;
+struct mgmt_rp_set_powered {
+	__le16 index;
+	__u8 powered;
+} __packed;
+
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
 	__le16 opcode;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 36b08a4..de40a8a 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1373,7 +1373,7 @@ static int hci_send_frame(struct sk_buff *skb)
 		/* Time stamp */
 		__net_timestamp(skb);
 
-		hci_send_to_sock(hdev, skb);
+		hci_send_to_sock(hdev, skb, NULL);
 	}
 
 	/* Get rid of skb owner, prior to sending to the driver. */
@@ -1760,7 +1760,7 @@ static void hci_rx_task(unsigned long arg)
 	while ((skb = skb_dequeue(&hdev->rx_q))) {
 		if (atomic_read(&hdev->promisc)) {
 			/* Send copy to the sockets */
-			hci_send_to_sock(hdev, skb);
+			hci_send_to_sock(hdev, skb, NULL);
 		}
 
 		if (test_bit(HCI_RAW, &hdev->flags)) {
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 3810017..b19b061 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2082,6 +2082,6 @@ void hci_si_event(struct hci_dev *hdev, int type, int dlen, void *data)
 
 	bt_cb(skb)->pkt_type = HCI_EVENT_PKT;
 	skb->dev = (void *) hdev;
-	hci_send_to_sock(hdev, skb);
+	hci_send_to_sock(hdev, skb, NULL);
 	kfree_skb(skb);
 }
diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 29827c7..d50e961 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -85,7 +85,8 @@ static struct bt_sock_list hci_sk_list = {
 };
 
 /* Send frame to RAW socket */
-void hci_send_to_sock(struct hci_dev *hdev, struct sk_buff *skb)
+void hci_send_to_sock(struct hci_dev *hdev, struct sk_buff *skb,
+							struct sock *skip_sk)
 {
 	struct sock *sk;
 	struct hlist_node *node;
@@ -97,6 +98,9 @@ void hci_send_to_sock(struct hci_dev *hdev, struct sk_buff *skb)
 		struct hci_filter *flt;
 		struct sk_buff *nskb;
 
+		if (sk == skip_sk)
+			continue;
+
 		if (sk->sk_state != BT_BOUND || hci_pi(sk)->hdev != hdev)
 			continue;
 
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index b7aeb7c..046696b 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -32,6 +32,16 @@
 #define MGMT_VERSION	0
 #define MGMT_REVISION	1
 
+struct pending_cmd {
+	struct list_head list;
+	__u16 opcode;
+	int index;
+	void *cmd;
+	struct sock *sk;
+};
+
+LIST_HEAD(cmd_list);
+
 static int cmd_status(struct sock *sk, u16 cmd, u8 status)
 {
 	struct sk_buff *skb;
@@ -218,6 +228,129 @@ static int read_controller_info(struct sock *sk, unsigned char *data, u16 len)
 	return 0;
 }
 
+static void mgmt_pending_free(struct pending_cmd *cmd)
+{
+	sock_put(cmd->sk);
+	kfree(cmd->cmd);
+	kfree(cmd);
+}
+
+static int mgmt_pending_add(struct sock *sk, u16 opcode, int index,
+							void *data, u16 len)
+{
+	struct pending_cmd *cmd;
+
+	cmd = kmalloc(sizeof(*cmd), GFP_ATOMIC);
+	if (!cmd)
+		return -ENOMEM;
+
+	cmd->opcode = opcode;
+	cmd->index = index;
+
+	cmd->cmd = kmalloc(len, GFP_ATOMIC);
+	if (!cmd->cmd) {
+		kfree(cmd);
+		return -ENOMEM;
+	}
+
+	memcpy(cmd->cmd, data, len);
+
+	cmd->sk = sk;
+	sock_hold(sk);
+
+	list_add(&cmd->list, &cmd_list);
+
+	return 0;
+}
+
+static void mgmt_pending_foreach(u16 opcode, int index,
+				void (*cb)(struct pending_cmd *cmd, void *data),
+				void *data)
+{
+	struct list_head *p, *n;
+
+	list_for_each_safe(p, n, &cmd_list) {
+		struct pending_cmd *cmd;
+
+		cmd = list_entry(p, struct pending_cmd, list);
+
+		if (cmd->opcode != opcode)
+			continue;
+
+		if (index >= 0 && cmd->index != index)
+			continue;
+
+		cb(cmd, data);
+	}
+}
+
+static struct pending_cmd *mgmt_pending_find(u16 opcode, int index)
+{
+	struct list_head *p;
+
+	list_for_each(p, &cmd_list) {
+		struct pending_cmd *cmd;
+
+		cmd = list_entry(p, struct pending_cmd, list);
+
+		if (cmd->opcode != opcode)
+			continue;
+
+		if (index >= 0 && cmd->index != index)
+			continue;
+
+		return cmd;
+	}
+
+	return NULL;
+}
+
+static int set_powered(struct sock *sk, unsigned char *data, u16 len)
+{
+	struct mgmt_cp_set_powered *cp;
+	struct hci_dev *hdev;
+	u16 dev_id;
+	int ret, up;
+
+	cp = (void *) data;
+	dev_id = get_unaligned_le16(&cp->index);
+
+	BT_DBG("request for hci%u", dev_id);
+
+	hdev = hci_dev_get(dev_id);
+	if (!hdev)
+		return cmd_status(sk, MGMT_OP_SET_POWERED, ENODEV);
+
+	hci_dev_lock_bh(hdev);
+
+	up = test_bit(HCI_UP, &hdev->flags);
+	if ((cp->powered && up) || (!cp->powered && !up)) {
+		ret = cmd_status(sk, MGMT_OP_SET_POWERED, EALREADY);
+		goto failed;
+	}
+
+	if (mgmt_pending_find(MGMT_OP_SET_POWERED, dev_id)) {
+		ret = cmd_status(sk, MGMT_OP_SET_POWERED, EBUSY);
+		goto failed;
+	}
+
+	ret = mgmt_pending_add(sk, MGMT_OP_SET_POWERED, dev_id, data, len);
+	if (ret < 0)
+		goto failed;
+
+	if (cp->powered)
+		queue_work(hdev->workqueue, &hdev->power_on);
+	else
+		queue_work(hdev->workqueue, &hdev->power_off);
+
+	ret = 0;
+
+failed:
+	hci_dev_unlock_bh(hdev);
+	hci_dev_put(hdev);
+	return ret;
+}
+
 int mgmt_control(struct sock *sk, struct msghdr *msg, size_t msglen)
 {
 	unsigned char *buf;
@@ -258,6 +391,9 @@ int mgmt_control(struct sock *sk, struct msghdr *msg, size_t msglen)
 	case MGMT_OP_READ_INFO:
 		err = read_controller_info(sk, buf + sizeof(*hdr), len);
 		break;
+	case MGMT_OP_SET_POWERED:
+		err = set_powered(sk, buf + sizeof(*hdr), len);
+		break;
 	default:
 		BT_DBG("Unknown op %u", opcode);
 		err = cmd_status(sk, opcode, 0x01);
@@ -274,7 +410,7 @@ done:
 	return err;
 }
 
-static int mgmt_event(u16 event, void *data, u16 data_len)
+static int mgmt_event(u16 event, void *data, u16 data_len, struct sock *skip_sk)
 {
 	struct sk_buff *skb;
 	struct mgmt_hdr *hdr;
@@ -291,7 +427,7 @@ static int mgmt_event(u16 event, void *data, u16 data_len)
 
 	memcpy(skb_put(skb, data_len), data, data_len);
 
-	hci_send_to_sock(NULL, skb);
+	hci_send_to_sock(NULL, skb, skip_sk);
 	kfree_skb(skb);
 
 	return 0;
@@ -303,7 +439,7 @@ int mgmt_index_added(u16 index)
 
 	put_unaligned_le16(index, &ev.index);
 
-	return mgmt_event(MGMT_EV_INDEX_ADDED, &ev, sizeof(ev));
+	return mgmt_event(MGMT_EV_INDEX_ADDED, &ev, sizeof(ev), NULL);
 }
 
 int mgmt_index_removed(u16 index)
@@ -312,15 +448,69 @@ int mgmt_index_removed(u16 index)
 
 	put_unaligned_le16(index, &ev.index);
 
-	return mgmt_event(MGMT_EV_INDEX_REMOVED, &ev, sizeof(ev));
+	return mgmt_event(MGMT_EV_INDEX_REMOVED, &ev, sizeof(ev), NULL);
+}
+
+struct powered_lookup {
+	u8 powered;
+	struct sock *sk;
+};
+
+static void power_rsp(struct pending_cmd *cmd, void *data)
+{
+	struct mgmt_hdr *hdr;
+	struct mgmt_ev_cmd_complete *ev;
+	struct mgmt_rp_set_powered *rp;
+	struct mgmt_cp_set_powered *cp = cmd->cmd;
+	struct sk_buff *skb;
+	struct powered_lookup *match = data;
+
+	if (cp->powered != match->powered)
+		return;
+
+	skb = alloc_skb(sizeof(*hdr) + sizeof(*ev) + sizeof(*rp), GFP_ATOMIC);
+	if (!skb)
+		return;
+
+	hdr = (void *) skb_put(skb, sizeof(*hdr));
+	hdr->opcode = cpu_to_le16(MGMT_EV_CMD_COMPLETE);
+	hdr->len = cpu_to_le16(sizeof(*ev) + sizeof(*rp));
+
+	ev = (void *) skb_put(skb, sizeof(*ev));
+	put_unaligned_le16(cmd->opcode, &ev->opcode);
+
+	rp = (void *) skb_put(skb, sizeof(*rp));
+	put_unaligned_le16(cmd->index, &rp->index);
+	rp->powered = cp->powered;
+
+	if (sock_queue_rcv_skb(cmd->sk, skb) < 0)
+		kfree_skb(skb);
+
+	list_del(&cmd->list);
+
+	if (match->sk == NULL) {
+		match->sk = cmd->sk;
+		sock_hold(match->sk);
+	}
+
+	mgmt_pending_free(cmd);
 }
 
 int mgmt_powered(u16 index, u8 powered)
 {
 	struct mgmt_ev_powered ev;
+	struct powered_lookup match = { powered, NULL };
+	int ret;
 
 	put_unaligned_le16(index, &ev.index);
 	ev.powered = powered;
 
-	return mgmt_event(MGMT_EV_POWERED, &ev, sizeof(ev));
+	mgmt_pending_foreach(MGMT_OP_SET_POWERED, index, power_rsp, &match);
+
+	ret = mgmt_event(MGMT_EV_POWERED, &ev, sizeof(ev), match.sk);
+
+	if (match.sk)
+		sock_put(match.sk);
+
+	return ret;
 }
-- 
1.7.2.3

