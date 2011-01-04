Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 05/11] Bluetooth: Add set_connectable management command
Date: Tue,  4 Jan 2011 12:08:46 +0200
Message-Id: <1294135732-26765-5-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1294135732-26765-1-git-send-email-johan.hedberg@gmail.com>
References: <1294135732-26765-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@nokia.com>

This patch adds a set_connectable command as well as a corresponding
event to the management interface. It's mainly useful for setting an
adapter as connectable from a non-initialized state as well as setting
an already initialized adapter as non-connectable (mostly useful for
qualification purposes).

Signed-off-by: Johan Hedberg <johan.hedberg@nokia.com>
---
 include/net/bluetooth/hci_core.h |    1 +
 include/net/bluetooth/mgmt.h     |   17 +++++
 net/bluetooth/hci_event.c        |   16 ++++--
 net/bluetooth/mgmt.c             |  122 +++++++++++++++++++++++++++++++++++++-
 4 files changed, 149 insertions(+), 7 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 2b7c31f..8d800d9 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -674,6 +674,7 @@ int mgmt_index_added(u16 index);
 int mgmt_index_removed(u16 index);
 int mgmt_powered(u16 index, u8 powered);
 int mgmt_discoverable(u16 index, u8 discoverable);
+int mgmt_connectable(u16 index, u8 connectable);
 
 /* HCI info for socket */
 #define hci_pi(sk) ((struct hci_pinfo *) sk)
diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 434dbcf..008acf5 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -47,6 +47,7 @@ struct mgmt_rp_read_info {
 	__le16 index;
 	__u8 type;
 	__u8 powered;
+	__u8 connectable;
 	__u8 discoverable;
 	__u8 pairable;
 	__u8 sec_mode;
@@ -78,6 +79,16 @@ struct mgmt_rp_set_discoverable {
 	__u8 discoverable;
 } __packed;
 
+#define MGMT_OP_SET_CONNECTABLE		0x0007
+struct mgmt_cp_set_connectable {
+	__le16 index;
+	__u8 connectable;
+} __packed;
+struct mgmt_rp_set_connectable {
+	__le16 index;
+	__u8 connectable;
+} __packed;
+
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
 	__le16 opcode;
@@ -117,3 +128,9 @@ struct mgmt_ev_discoverable {
 	__le16 index;
 	__u8 discoverable;
 } __packed;
+
+#define MGMT_EV_CONNECTABLE		0x0008
+struct mgmt_ev_connectable {
+	__le16 index;
+	__u8 connectable;
+} __packed;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index f47ceb1..319f954 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -274,18 +274,24 @@ static void hci_cc_write_scan_enable(struct hci_dev *hdev, struct sk_buff *skb)
 
 	if (!status) {
 		__u8 param = *((__u8 *) sent);
+		int old_pscan, old_iscan;
 
-		clear_bit(HCI_PSCAN, &hdev->flags);
-		clear_bit(HCI_ISCAN, &hdev->flags);
+		old_pscan = test_and_clear_bit(HCI_PSCAN, &hdev->flags);
+		old_iscan = test_and_clear_bit(HCI_ISCAN, &hdev->flags);
 
 		if (param & SCAN_INQUIRY) {
 			set_bit(HCI_ISCAN, &hdev->flags);
-			mgmt_discoverable(hdev->id, 1);
-		} else
+			if (!old_iscan)
+				mgmt_discoverable(hdev->id, 1);
+		} else if (old_iscan)
 			mgmt_discoverable(hdev->id, 0);
 
-		if (param & SCAN_PAGE)
+		if (param & SCAN_PAGE) {
 			set_bit(HCI_PSCAN, &hdev->flags);
+			if (!old_pscan)
+				mgmt_connectable(hdev->id, 1);
+		} else if (old_pscan)
+			mgmt_connectable(hdev->id, 0);
 	}
 
 	hci_req_complete(hdev, HCI_OP_WRITE_SCAN_ENABLE, status);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index e7c2fa3..d3ec5d8 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -202,6 +202,7 @@ static int read_controller_info(struct sock *sk, unsigned char *data, u16 len)
 	rp->type = hdev->dev_type;
 
 	rp->powered = test_bit(HCI_UP, &hdev->flags);
+	rp->connectable = test_bit(HCI_PSCAN, &hdev->flags);
 	rp->discoverable = test_bit(HCI_ISCAN, &hdev->flags);
 	rp->pairable = test_bit(HCI_PSCAN, &hdev->flags);
 
@@ -388,8 +389,7 @@ static int set_discoverable(struct sock *sk, unsigned char *data, u16 len)
 	}
 
 	if (mgmt_pending_find(MGMT_OP_SET_DISCOVERABLE, dev_id) ||
-			mgmt_pending_find(MGMT_OP_SET_CONNECTABLE, dev_id) ||
-			hci_sent_cmd_data(hdev, HCI_OP_WRITE_SCAN_ENABLE)) {
+			mgmt_pending_find(MGMT_OP_SET_CONNECTABLE, dev_id)) {
 		err = cmd_status(sk, MGMT_OP_SET_DISCOVERABLE, EBUSY);
 		goto failed;
 	}
@@ -420,6 +420,61 @@ failed:
 	return err;
 }
 
+static int set_connectable(struct sock *sk, unsigned char *data, u16 len)
+{
+	struct mgmt_cp_set_connectable *cp;
+	struct hci_dev *hdev;
+	u16 dev_id;
+	u8 scan;
+	int err;
+
+	cp = (void *) data;
+	dev_id = get_unaligned_le16(&cp->index);
+
+	BT_DBG("request for hci%u", dev_id);
+
+	hdev = hci_dev_get(dev_id);
+	if (!hdev)
+		return cmd_status(sk, MGMT_OP_SET_CONNECTABLE, ENODEV);
+
+	hci_dev_lock_bh(hdev);
+
+	if (!test_bit(HCI_UP, &hdev->flags)) {
+		err = cmd_status(sk, MGMT_OP_SET_CONNECTABLE, ENETDOWN);
+		goto failed;
+	}
+
+	if (mgmt_pending_find(MGMT_OP_SET_DISCOVERABLE, dev_id) ||
+			mgmt_pending_find(MGMT_OP_SET_CONNECTABLE, dev_id)) {
+		err = cmd_status(sk, MGMT_OP_SET_CONNECTABLE, EBUSY);
+		goto failed;
+	}
+
+	if (cp->connectable == test_bit(HCI_PSCAN, &hdev->flags)) {
+		err = cmd_status(sk, MGMT_OP_SET_CONNECTABLE, EALREADY);
+		goto failed;
+	}
+
+	err = mgmt_pending_add(sk, MGMT_OP_SET_CONNECTABLE, dev_id, data, len);
+	if (err < 0)
+		goto failed;
+
+	if (cp->connectable)
+		scan = SCAN_PAGE;
+	else
+		scan = 0;
+
+	err = hci_send_cmd(hdev, HCI_OP_WRITE_SCAN_ENABLE, 1, &scan);
+	if (err < 0)
+		mgmt_pending_remove(MGMT_OP_SET_CONNECTABLE, dev_id);
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
@@ -466,6 +521,9 @@ int mgmt_control(struct sock *sk, struct msghdr *msg, size_t msglen)
 	case MGMT_OP_SET_DISCOVERABLE:
 		err = set_discoverable(sk, buf + sizeof(*hdr), len);
 		break;
+	case MGMT_OP_SET_CONNECTABLE:
+		err = set_connectable(sk, buf + sizeof(*hdr), len);
+		break;
 	default:
 		BT_DBG("Unknown op %u", opcode);
 		err = cmd_status(sk, opcode, 0x01);
@@ -646,3 +704,63 @@ int mgmt_discoverable(u16 index, u8 discoverable)
 
 	return ret;
 }
+
+static void connectable_rsp(struct pending_cmd *cmd, void *data)
+{
+	struct mgmt_cp_set_connectable *cp = cmd->cmd;
+	struct cmd_lookup *match = data;
+	struct sk_buff *skb;
+	struct mgmt_hdr *hdr;
+	struct mgmt_ev_cmd_complete *ev;
+	struct mgmt_rp_set_connectable *rp;
+
+	if (cp->connectable != match->value)
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
+	put_unaligned_le16(MGMT_OP_SET_CONNECTABLE, &ev->opcode);
+
+	rp = (void *) skb_put(skb, sizeof(*rp));
+	put_unaligned_le16(cmd->index, &rp->index);
+	rp->connectable = cp->connectable;
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
+}
+
+int mgmt_connectable(u16 index, u8 connectable)
+{
+	struct mgmt_ev_connectable ev;
+	struct cmd_lookup match = { connectable, NULL };
+	int ret;
+
+	put_unaligned_le16(index, &ev.index);
+	ev.connectable = connectable;
+
+	mgmt_pending_foreach(MGMT_OP_SET_CONNECTABLE, index,
+						connectable_rsp, &match);
+
+	ret = mgmt_event(MGMT_EV_CONNECTABLE, &ev, sizeof(ev), match.sk);
+
+	if (match.sk)
+		sock_put(match.sk);
+
+	return ret;
+}
-- 
1.7.2.3

