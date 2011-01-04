Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 08/11] Bluetooth: Implement set_pairable managment command
Date: Tue,  4 Jan 2011 12:08:49 +0200
Message-Id: <1294135732-26765-8-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1294135732-26765-1-git-send-email-johan.hedberg@gmail.com>
References: <1294135732-26765-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@nokia.com>

This patch implements a new set_pairable management command to control
the pairable state of local adapters. The state is represented using a
new HCI_PAIRABLE flag in the hci_dev struct.

For backwards compatibility with older user space versions the
HCI_PAIRABLE flag gets automatically set when the existence of an
adapter is reported to user space through legacy methods and the
HCI_MGMT flag is not set.

Signed-off-by: Johan Hedberg <johan.hedberg@nokia.com>
---
 include/net/bluetooth/hci.h  |    1 +
 include/net/bluetooth/mgmt.h |    4 +
 net/bluetooth/hci_core.c     |   10 +++
 net/bluetooth/mgmt.c         |  138 ++++++++++++++++++++++++++++-------------
 4 files changed, 109 insertions(+), 44 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index a34f638..2b370ba 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -80,6 +80,7 @@ enum {
 	HCI_SETUP,
 	HCI_AUTO_OFF,
 	HCI_MGMT,
+	HCI_PAIRABLE,
 };
 
 /* HCI ioctl defines */
diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index f61fd67..a554802 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -70,6 +70,8 @@ struct mgmt_mode {
 
 #define MGMT_OP_SET_CONNECTABLE		0x0007
 
+#define MGMT_OP_SET_PAIRABLE		0x0008
+
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
 	__le16 opcode;
@@ -103,3 +105,5 @@ struct mgmt_ev_index_removed {
 #define MGMT_EV_DISCOVERABLE		0x0007
 
 #define MGMT_EV_CONNECTABLE		0x0008
+
+#define MGMT_EV_PAIRABLE		0x0009
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index de40a8a..c03e6c9 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -799,10 +799,17 @@ int hci_get_dev_list(void __user *arg)
 	read_lock_bh(&hci_dev_list_lock);
 	list_for_each(p, &hci_dev_list) {
 		struct hci_dev *hdev;
+
 		hdev = list_entry(p, struct hci_dev, list);
+
 		hci_del_off_timer(hdev);
+
+		if (!test_bit(HCI_MGMT, &hdev->flags))
+			set_bit(HCI_PAIRABLE, &hdev->flags);
+
 		(dr + n)->dev_id  = hdev->id;
 		(dr + n)->dev_opt = hdev->flags;
+
 		if (++n >= dev_num)
 			break;
 	}
@@ -832,6 +839,9 @@ int hci_get_dev_info(void __user *arg)
 
 	hci_del_off_timer(hdev);
 
+	if (!test_bit(HCI_MGMT, &hdev->flags))
+		set_bit(HCI_PAIRABLE, &hdev->flags);
+
 	strcpy(di.name, hdev->name);
 	di.bdaddr   = hdev->bdaddr;
 	di.type     = (hdev->bus & 0x0f) | (hdev->dev_type << 4);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 9d82da9..04d8ad2 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -479,6 +479,96 @@ failed:
 	return err;
 }
 
+static int mgmt_event(u16 event, void *data, u16 data_len, struct sock *skip_sk)
+{
+	struct sk_buff *skb;
+	struct mgmt_hdr *hdr;
+
+	skb = alloc_skb(sizeof(*hdr) + data_len, GFP_ATOMIC);
+	if (!skb)
+		return -ENOMEM;
+
+	bt_cb(skb)->channel = HCI_CHANNEL_CONTROL;
+
+	hdr = (void *) skb_put(skb, sizeof(*hdr));
+	hdr->opcode = cpu_to_le16(event);
+	hdr->len = cpu_to_le16(data_len);
+
+	memcpy(skb_put(skb, data_len), data, data_len);
+
+	hci_send_to_sock(NULL, skb, skip_sk);
+	kfree_skb(skb);
+
+	return 0;
+}
+
+static int send_mode_rsp(struct sock *sk, u16 opcode, u16 index, u8 val)
+{
+	struct mgmt_hdr *hdr;
+	struct mgmt_ev_cmd_complete *ev;
+	struct mgmt_mode *rp;
+	struct sk_buff *skb;
+
+	skb = alloc_skb(sizeof(*hdr) + sizeof(*ev) + sizeof(*rp), GFP_ATOMIC);
+	if (!skb)
+		return -ENOMEM;
+
+	hdr = (void *) skb_put(skb, sizeof(*hdr));
+	hdr->opcode = cpu_to_le16(MGMT_EV_CMD_COMPLETE);
+	hdr->len = cpu_to_le16(sizeof(*ev) + sizeof(*rp));
+
+	ev = (void *) skb_put(skb, sizeof(*ev));
+	put_unaligned_le16(opcode, &ev->opcode);
+
+	rp = (void *) skb_put(skb, sizeof(*rp));
+	put_unaligned_le16(index, &rp->index);
+	rp->val = val;
+
+	if (sock_queue_rcv_skb(sk, skb) < 0)
+		kfree_skb(skb);
+
+	return 0;
+}
+
+static int set_pairable(struct sock *sk, unsigned char *data, u16 len)
+{
+	struct mgmt_mode *cp, ev;
+	struct hci_dev *hdev;
+	u16 dev_id;
+	int err;
+
+	cp = (void *) data;
+	dev_id = get_unaligned_le16(&cp->index);
+
+	BT_DBG("request for hci%u", dev_id);
+
+	hdev = hci_dev_get(dev_id);
+	if (!hdev)
+		return cmd_status(sk, MGMT_OP_SET_PAIRABLE, ENODEV);
+
+	hci_dev_lock_bh(hdev);
+
+	if (cp->val)
+		set_bit(HCI_PAIRABLE, &hdev->flags);
+	else
+		clear_bit(HCI_PAIRABLE, &hdev->flags);
+
+	err = send_mode_rsp(sk, MGMT_OP_SET_PAIRABLE, dev_id, cp->val);
+	if (err < 0)
+		goto failed;
+
+	put_unaligned_le16(dev_id, &ev.index);
+	ev.val = cp->val;
+
+	err = mgmt_event(MGMT_EV_PAIRABLE, &ev, sizeof(ev), sk);
+
+failed:
+	hci_dev_unlock_bh(hdev);
+	hci_dev_put(hdev);
+
+	return err;
+}
+
 int mgmt_control(struct sock *sk, struct msghdr *msg, size_t msglen)
 {
 	unsigned char *buf;
@@ -528,6 +618,9 @@ int mgmt_control(struct sock *sk, struct msghdr *msg, size_t msglen)
 	case MGMT_OP_SET_CONNECTABLE:
 		err = set_connectable(sk, buf + sizeof(*hdr), len);
 		break;
+	case MGMT_OP_SET_PAIRABLE:
+		err = set_pairable(sk, buf + sizeof(*hdr), len);
+		break;
 	default:
 		BT_DBG("Unknown op %u", opcode);
 		err = cmd_status(sk, opcode, 0x01);
@@ -544,29 +637,6 @@ done:
 	return err;
 }
 
-static int mgmt_event(u16 event, void *data, u16 data_len, struct sock *skip_sk)
-{
-	struct sk_buff *skb;
-	struct mgmt_hdr *hdr;
-
-	skb = alloc_skb(sizeof(*hdr) + data_len, GFP_ATOMIC);
-	if (!skb)
-		return -ENOMEM;
-
-	bt_cb(skb)->channel = HCI_CHANNEL_CONTROL;
-
-	hdr = (void *) skb_put(skb, sizeof(*hdr));
-	hdr->opcode = cpu_to_le16(event);
-	hdr->len = cpu_to_le16(data_len);
-
-	memcpy(skb_put(skb, data_len), data, data_len);
-
-	hci_send_to_sock(NULL, skb, skip_sk);
-	kfree_skb(skb);
-
-	return 0;
-}
-
 int mgmt_index_added(u16 index)
 {
 	struct mgmt_ev_index_added ev;
@@ -592,33 +662,13 @@ struct cmd_lookup {
 
 static void mode_rsp(struct pending_cmd *cmd, void *data)
 {
-	struct mgmt_hdr *hdr;
-	struct mgmt_ev_cmd_complete *ev;
-	struct mgmt_mode *rp;
 	struct mgmt_mode *cp = cmd->cmd;
-	struct sk_buff *skb;
 	struct cmd_lookup *match = data;
 
 	if (cp->val != match->val)
 		return;
 
-	skb = alloc_skb(sizeof(*hdr) + sizeof(*ev) + sizeof(*rp), GFP_ATOMIC);
-	if (!skb)
-		return;
-
-	hdr = (void *) skb_put(skb, sizeof(*hdr));
-	hdr->opcode = cpu_to_le16(MGMT_EV_CMD_COMPLETE);
-	hdr->len = cpu_to_le16(sizeof(*ev) + sizeof(*rp));
-
-	ev = (void *) skb_put(skb, sizeof(*ev));
-	put_unaligned_le16(cmd->opcode, &ev->opcode);
-
-	rp = (void *) skb_put(skb, sizeof(*rp));
-	put_unaligned_le16(cmd->index, &rp->index);
-	rp->val = cp->val;
-
-	if (sock_queue_rcv_skb(cmd->sk, skb) < 0)
-		kfree_skb(skb);
+	send_mode_rsp(cmd->sk, cmd->opcode, cmd->index, cp->val);
 
 	list_del(&cmd->list);
 
-- 
1.7.2.3

