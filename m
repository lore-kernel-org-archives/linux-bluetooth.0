Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/3] Bluetooth: bt_skb_cb: Merge force_active and incoming into flags
Date: Thu,  5 Nov 2015 09:31:41 +0200
Message-Id: <1446708701-1387-4-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1446708701-1387-1-git-send-email-johan.hedberg@gmail.com>
References: <1446708701-1387-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

These are both boolean values in practice so we can save some space in
the bt_skb_cb struct by merging them both into a single flags field.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/bluetooth.h |  6 ++++--
 include/net/bluetooth/hci_core.h  |  2 +-
 net/bluetooth/hci_conn.c          |  4 ++--
 net/bluetooth/hci_core.c          | 15 +++++++++------
 net/bluetooth/hci_sock.c          | 10 +++++-----
 net/bluetooth/l2cap_core.c        |  7 +++++--
 6 files changed, 26 insertions(+), 18 deletions(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index 8d38f411009c..d8b3d5ef2f82 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -309,11 +309,13 @@ struct hci_ctrl {
 	};
 };
 
+#define BT_INCOMING		BIT(0)
+#define BT_FORCE_ACTIVE		BIT(1)
+
 struct bt_skb_cb {
 	__u8 pkt_type;
-	__u8 force_active;
+	__u8 flags;
 	__u16 expect;
-	__u8 incoming:1;
 	union {
 		struct l2cap_ctrl l2cap;
 		struct hci_ctrl hci;
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 1878d0a96333..9c461d43260f 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -889,7 +889,7 @@ int hci_conn_security(struct hci_conn *conn, __u8 sec_level, __u8 auth_type,
 		      bool initiator);
 int hci_conn_switch_role(struct hci_conn *conn, __u8 role);
 
-void hci_conn_enter_active_mode(struct hci_conn *conn, __u8 force_active);
+void hci_conn_enter_active_mode(struct hci_conn *conn, bool force_active);
 
 void hci_le_conn_failed(struct hci_conn *conn, u8 status);
 
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 85b82f7adbd2..f24d876b64d5 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1126,7 +1126,7 @@ struct hci_conn *hci_connect_sco(struct hci_dev *hdev, int type, bdaddr_t *dst,
 	if (acl->state == BT_CONNECTED &&
 	    (sco->state == BT_OPEN || sco->state == BT_CLOSED)) {
 		set_bit(HCI_CONN_POWER_SAVE, &acl->flags);
-		hci_conn_enter_active_mode(acl, BT_POWER_FORCE_ACTIVE_ON);
+		hci_conn_enter_active_mode(acl, true);
 
 		if (test_bit(HCI_CONN_MODE_CHANGE_PEND, &acl->flags)) {
 			/* defer SCO setup until mode change completed */
@@ -1323,7 +1323,7 @@ int hci_conn_switch_role(struct hci_conn *conn, __u8 role)
 EXPORT_SYMBOL(hci_conn_switch_role);
 
 /* Enter active mode */
-void hci_conn_enter_active_mode(struct hci_conn *conn, __u8 force_active)
+void hci_conn_enter_active_mode(struct hci_conn *conn, bool force_active)
 {
 	struct hci_dev *hdev = conn->hdev;
 
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index c270feaac8a1..b20dbefb4a0e 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3586,7 +3586,7 @@ int hci_recv_frame(struct hci_dev *hdev, struct sk_buff *skb)
 	}
 
 	/* Incoming skb */
-	bt_cb(skb)->incoming = 1;
+	bt_cb(skb)->flags |= BT_INCOMING;
 
 	/* Time stamp */
 	__net_timestamp(skb);
@@ -4088,6 +4088,8 @@ static void hci_sched_acl_pkt(struct hci_dev *hdev)
 	       (chan = hci_chan_sent(hdev, ACL_LINK, &quote))) {
 		u32 priority = (skb_peek(&chan->data_q))->priority;
 		while (quote-- && (skb = skb_peek(&chan->data_q))) {
+			bool force_active;
+
 			BT_DBG("chan %p skb %p len %d priority %u", chan, skb,
 			       skb->len, skb->priority);
 
@@ -4097,8 +4099,8 @@ static void hci_sched_acl_pkt(struct hci_dev *hdev)
 
 			skb = skb_dequeue(&chan->data_q);
 
-			hci_conn_enter_active_mode(chan->conn,
-						   bt_cb(skb)->force_active);
+			force_active = (bt_cb(skb)->flags & BT_FORCE_ACTIVE);
+			hci_conn_enter_active_mode(chan->conn, force_active);
 
 			hci_send_frame(hdev, skb);
 			hdev->acl_last_tx = jiffies;
@@ -4134,6 +4136,7 @@ static void hci_sched_acl_blk(struct hci_dev *hdev)
 	       (chan = hci_chan_sent(hdev, type, &quote))) {
 		u32 priority = (skb_peek(&chan->data_q))->priority;
 		while (quote > 0 && (skb = skb_peek(&chan->data_q))) {
+			bool force_active;
 			int blocks;
 
 			BT_DBG("chan %p skb %p len %d priority %u", chan, skb,
@@ -4149,8 +4152,8 @@ static void hci_sched_acl_blk(struct hci_dev *hdev)
 			if (blocks > hdev->block_cnt)
 				return;
 
-			hci_conn_enter_active_mode(chan->conn,
-						   bt_cb(skb)->force_active);
+			force_active = (bt_cb(skb)->flags & BT_FORCE_ACTIVE);
+			hci_conn_enter_active_mode(chan->conn, force_active);
 
 			hci_send_frame(hdev, skb);
 			hdev->acl_last_tx = jiffies;
@@ -4335,7 +4338,7 @@ static void hci_acldata_packet(struct hci_dev *hdev, struct sk_buff *skb)
 	hci_dev_unlock(hdev);
 
 	if (conn) {
-		hci_conn_enter_active_mode(conn, BT_POWER_FORCE_ACTIVE_OFF);
+		hci_conn_enter_active_mode(conn, false);
 
 		/* Send to upper protocol */
 		l2cap_recv_acldata(conn, skb, flags);
diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 19b23013c4f6..41555a04919e 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -178,7 +178,7 @@ void hci_send_to_sock(struct hci_dev *hdev, struct sk_buff *skb)
 			if (is_filtered_packet(sk, skb))
 				continue;
 		} else if (hci_pi(sk)->channel == HCI_CHANNEL_USER) {
-			if (!bt_cb(skb)->incoming)
+			if (!(bt_cb(skb)->flags & BT_INCOMING))
 				continue;
 			if (hci_skb_pkt_type(skb) != HCI_EVENT_PKT &&
 			    hci_skb_pkt_type(skb) != HCI_ACLDATA_PKT &&
@@ -270,13 +270,13 @@ void hci_send_to_monitor(struct hci_dev *hdev, struct sk_buff *skb)
 		opcode = cpu_to_le16(HCI_MON_EVENT_PKT);
 		break;
 	case HCI_ACLDATA_PKT:
-		if (bt_cb(skb)->incoming)
+		if (bt_cb(skb)->flags & BT_INCOMING)
 			opcode = cpu_to_le16(HCI_MON_ACL_RX_PKT);
 		else
 			opcode = cpu_to_le16(HCI_MON_ACL_TX_PKT);
 		break;
 	case HCI_SCODATA_PKT:
-		if (bt_cb(skb)->incoming)
+		if (bt_cb(skb)->flags & BT_INCOMING)
 			opcode = cpu_to_le16(HCI_MON_SCO_RX_PKT);
 		else
 			opcode = cpu_to_le16(HCI_MON_SCO_TX_PKT);
@@ -444,7 +444,7 @@ static void hci_si_event(struct hci_dev *hdev, int type, int dlen, void *data)
 	ev->type = type;
 	memcpy(ev->data, data, dlen);
 
-	bt_cb(skb)->incoming = 1;
+	bt_cb(skb)->flags |= BT_INCOMING;
 	__net_timestamp(skb);
 
 	hci_skb_pkt_type(skb) = HCI_EVENT_PKT;
@@ -960,7 +960,7 @@ static void hci_sock_cmsg(struct sock *sk, struct msghdr *msg,
 	__u32 mask = hci_pi(sk)->cmsg_mask;
 
 	if (mask & HCI_CMSG_DIR) {
-		int incoming = bt_cb(skb)->incoming;
+		int incoming = !!(bt_cb(skb)->flags & BT_INCOMING);
 		put_cmsg(msg, SOL_HCI, HCI_CMSG_DIR, sizeof(incoming),
 			 &incoming);
 	}
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 7c65ee200c29..c8be10b3ef5a 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -857,7 +857,7 @@ static void l2cap_send_cmd(struct l2cap_conn *conn, u8 ident, u8 code, u16 len,
 	else
 		flags = ACL_START;
 
-	bt_cb(skb)->force_active = BT_POWER_FORCE_ACTIVE_ON;
+	bt_cb(skb)->flags |= BT_FORCE_ACTIVE;
 	skb->priority = HCI_PRIO_MAX;
 
 	hci_send_acl(conn->hchan, skb, flags);
@@ -897,7 +897,10 @@ static void l2cap_do_send(struct l2cap_chan *chan, struct sk_buff *skb)
 	else
 		flags = ACL_START;
 
-	bt_cb(skb)->force_active = test_bit(FLAG_FORCE_ACTIVE, &chan->flags);
+	if (test_bit(FLAG_FORCE_ACTIVE, &chan->flags))
+		bt_cb(skb)->flags |= BT_FORCE_ACTIVE;
+	else
+		bt_cb(skb)->flags &= ~BT_FORCE_ACTIVE;
 	hci_send_acl(chan->conn->hchan, skb, flags);
 }
 
-- 
2.5.0

