Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 04/11] Bluetooth: Add support for set_discoverable management command
Date: Tue,  4 Jan 2011 12:08:45 +0200
Message-Id: <1294135732-26765-4-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1294135732-26765-1-git-send-email-johan.hedberg@gmail.com>
References: <1294135732-26765-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@nokia.com>

This patch adds a set_discoverable command to the management interface
as well as the corresponding event. The command is used to control the
discoverable state of adapters.

Signed-off-by: Johan Hedberg <johan.hedberg@nokia.com>
---
 include/net/bluetooth/hci_core.h |    1 +
 include/net/bluetooth/mgmt.h     |   16 ++++
 net/bluetooth/hci_event.c        |    5 +-
 net/bluetooth/mgmt.c             |  142 ++++++++++++++++++++++++++++++++++++--
 4 files changed, 158 insertions(+), 6 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index b6078ba..2b7c31f 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -673,6 +673,7 @@ int mgmt_control(struct sock *sk, struct msghdr *msg, size_t len);
 int mgmt_index_added(u16 index);
 int mgmt_index_removed(u16 index);
 int mgmt_powered(u16 index, u8 powered);
+int mgmt_discoverable(u16 index, u8 discoverable);
 
 /* HCI info for socket */
 #define hci_pi(sk) ((struct hci_pinfo *) sk)
diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 81ef789..434dbcf 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -68,6 +68,16 @@ struct mgmt_rp_set_powered {
 	__u8 powered;
 } __packed;
 
+#define MGMT_OP_SET_DISCOVERABLE	0x0006
+struct mgmt_cp_set_discoverable {
+	__le16 index;
+	__u8 discoverable;
+} __packed;
+struct mgmt_rp_set_discoverable {
+	__le16 index;
+	__u8 discoverable;
+} __packed;
+
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
 	__le16 opcode;
@@ -101,3 +111,9 @@ struct mgmt_ev_powered {
 	__le16 index;
 	__u8 powered;
 } __packed;
+
+#define MGMT_EV_DISCOVERABLE		0x0007
+struct mgmt_ev_discoverable {
+	__le16 index;
+	__u8 discoverable;
+} __packed;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index b19b061..f47ceb1 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -278,8 +278,11 @@ static void hci_cc_write_scan_enable(struct hci_dev *hdev, struct sk_buff *skb)
 		clear_bit(HCI_PSCAN, &hdev->flags);
 		clear_bit(HCI_ISCAN, &hdev->flags);
 
-		if (param & SCAN_INQUIRY)
+		if (param & SCAN_INQUIRY) {
 			set_bit(HCI_ISCAN, &hdev->flags);
+			mgmt_discoverable(hdev->id, 1);
+		} else
+			mgmt_discoverable(hdev->id, 0);
 
 		if (param & SCAN_PAGE)
 			set_bit(HCI_PSCAN, &hdev->flags);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 046696b..e7c2fa3 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -305,6 +305,18 @@ static struct pending_cmd *mgmt_pending_find(u16 opcode, int index)
 	return NULL;
 }
 
+static void mgmt_pending_remove(u16 opcode, int index)
+{
+	struct pending_cmd *cmd;
+
+	cmd = mgmt_pending_find(opcode, index);
+	if (cmd == NULL)
+		return;
+
+	list_del(&cmd->list);
+	mgmt_pending_free(cmd);
+}
+
 static int set_powered(struct sock *sk, unsigned char *data, u16 len)
 {
 	struct mgmt_cp_set_powered *cp;
@@ -351,6 +363,63 @@ failed:
 	return ret;
 }
 
+static int set_discoverable(struct sock *sk, unsigned char *data, u16 len)
+{
+	struct mgmt_cp_set_discoverable *cp;
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
+		return cmd_status(sk, MGMT_OP_SET_DISCOVERABLE, ENODEV);
+
+	hci_dev_lock_bh(hdev);
+
+	if (!test_bit(HCI_UP, &hdev->flags)) {
+		err = cmd_status(sk, MGMT_OP_SET_DISCOVERABLE, ENETDOWN);
+		goto failed;
+	}
+
+	if (mgmt_pending_find(MGMT_OP_SET_DISCOVERABLE, dev_id) ||
+			mgmt_pending_find(MGMT_OP_SET_CONNECTABLE, dev_id) ||
+			hci_sent_cmd_data(hdev, HCI_OP_WRITE_SCAN_ENABLE)) {
+		err = cmd_status(sk, MGMT_OP_SET_DISCOVERABLE, EBUSY);
+		goto failed;
+	}
+
+	if (cp->discoverable == test_bit(HCI_ISCAN, &hdev->flags) &&
+					test_bit(HCI_PSCAN, &hdev->flags)) {
+		err = cmd_status(sk, MGMT_OP_SET_DISCOVERABLE, EALREADY);
+		goto failed;
+	}
+
+	err = mgmt_pending_add(sk, MGMT_OP_SET_DISCOVERABLE, dev_id, data, len);
+	if (err < 0)
+		goto failed;
+
+	scan = SCAN_PAGE;
+
+	if (cp->discoverable)
+		scan |= SCAN_INQUIRY;
+
+	err = hci_send_cmd(hdev, HCI_OP_WRITE_SCAN_ENABLE, 1, &scan);
+	if (err < 0)
+		mgmt_pending_remove(MGMT_OP_SET_DISCOVERABLE, dev_id);
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
@@ -394,6 +463,9 @@ int mgmt_control(struct sock *sk, struct msghdr *msg, size_t msglen)
 	case MGMT_OP_SET_POWERED:
 		err = set_powered(sk, buf + sizeof(*hdr), len);
 		break;
+	case MGMT_OP_SET_DISCOVERABLE:
+		err = set_discoverable(sk, buf + sizeof(*hdr), len);
+		break;
 	default:
 		BT_DBG("Unknown op %u", opcode);
 		err = cmd_status(sk, opcode, 0x01);
@@ -451,8 +523,8 @@ int mgmt_index_removed(u16 index)
 	return mgmt_event(MGMT_EV_INDEX_REMOVED, &ev, sizeof(ev), NULL);
 }
 
-struct powered_lookup {
-	u8 powered;
+struct cmd_lookup {
+	u8 value;
 	struct sock *sk;
 };
 
@@ -463,9 +535,9 @@ static void power_rsp(struct pending_cmd *cmd, void *data)
 	struct mgmt_rp_set_powered *rp;
 	struct mgmt_cp_set_powered *cp = cmd->cmd;
 	struct sk_buff *skb;
-	struct powered_lookup *match = data;
+	struct cmd_lookup *match = data;
 
-	if (cp->powered != match->powered)
+	if (cp->powered != match->value)
 		return;
 
 	skb = alloc_skb(sizeof(*hdr) + sizeof(*ev) + sizeof(*rp), GFP_ATOMIC);
@@ -499,7 +571,7 @@ static void power_rsp(struct pending_cmd *cmd, void *data)
 int mgmt_powered(u16 index, u8 powered)
 {
 	struct mgmt_ev_powered ev;
-	struct powered_lookup match = { powered, NULL };
+	struct cmd_lookup match = { powered, NULL };
 	int ret;
 
 	put_unaligned_le16(index, &ev.index);
@@ -514,3 +586,63 @@ int mgmt_powered(u16 index, u8 powered)
 
 	return ret;
 }
+
+static void discoverable_rsp(struct pending_cmd *cmd, void *data)
+{
+	struct mgmt_cp_set_discoverable *cp = cmd->cmd;
+	struct cmd_lookup *match = data;
+	struct sk_buff *skb;
+	struct mgmt_hdr *hdr;
+	struct mgmt_ev_cmd_complete *ev;
+	struct mgmt_rp_set_discoverable *rp;
+
+	if (cp->discoverable != match->value)
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
+	put_unaligned_le16(MGMT_OP_SET_DISCOVERABLE, &ev->opcode);
+
+	rp = (void *) skb_put(skb, sizeof(*rp));
+	put_unaligned_le16(cmd->index, &rp->index);
+	rp->discoverable = cp->discoverable;
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
+int mgmt_discoverable(u16 index, u8 discoverable)
+{
+	struct mgmt_ev_discoverable ev;
+	struct cmd_lookup match = { discoverable, NULL };
+	int ret;
+
+	put_unaligned_le16(index, &ev.index);
+	ev.discoverable = discoverable;
+
+	mgmt_pending_foreach(MGMT_OP_SET_DISCOVERABLE, index,
+						discoverable_rsp, &match);
+
+	ret = mgmt_event(MGMT_EV_DISCOVERABLE, &ev, sizeof(ev), match.sk);
+
+	if (match.sk)
+		sock_put(match.sk);
+
+	return ret;
+}
-- 
1.7.2.3

