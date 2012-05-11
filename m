Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/4] Bluetooth: add a timer to L2CAP MSG_MORE code
Date: Fri, 11 May 2012 13:16:14 -0300
Message-Id: <1336752974-7747-4-git-send-email-gustavo@padovan.org>
In-Reply-To: <1336752974-7747-3-git-send-email-gustavo@padovan.org>
References: <1336752974-7747-1-git-send-email-gustavo@padovan.org>
 <1336752974-7747-2-git-send-email-gustavo@padovan.org>
 <1336752974-7747-3-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

There is now a 200 milliseconds limit for which L2CAP will wait for
which L2CAP will wait before send the already queued data to the
controller.

Signed-off-by: Gustavo Padovan <gustavo@padovan.org>
---
 include/net/bluetooth/l2cap.h |    5 ++++
 net/bluetooth/l2cap_core.c    |   65 ++++++++++++++++++++++++++++-------------
 2 files changed, 49 insertions(+), 21 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 5f2845d..e8bbb2e 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -40,6 +40,7 @@
 #define L2CAP_DEFAULT_MONITOR_TO	12000   /* 12 seconds */
 #define L2CAP_DEFAULT_MAX_PDU_SIZE	1009    /* Sized for 3-DH5 packet */
 #define L2CAP_DEFAULT_ACK_TO		200
+#define L2CAP_MSG_MORE_TO		200
 #define L2CAP_LE_DEFAULT_MTU		23
 #define L2CAP_DEFAULT_MAX_SDU_SIZE	0xFFFF
 #define L2CAP_DEFAULT_SDU_ITIME		0xFFFFFFFF
@@ -521,6 +522,7 @@ struct l2cap_chan {
 	struct list_head	global_l;
 
 	struct sk_buff		*skb_more;
+	struct delayed_work	more_timer;
 
 	void			*data;
 	struct l2cap_ops	*ops;
@@ -724,6 +726,9 @@ static inline bool l2cap_clear_timer(struct l2cap_chan *chan,
 #define __set_ack_timer(c) l2cap_set_timer(c, &chan->ack_timer, \
 		msecs_to_jiffies(L2CAP_DEFAULT_ACK_TO));
 #define __clear_ack_timer(c) l2cap_clear_timer(c, &c->ack_timer)
+#define __set_more_timer(c) l2cap_set_timer(c, &chan->more_timer, \
+		msecs_to_jiffies(L2CAP_MSG_MORE_TO));
+#define __clear_more_timer(c) l2cap_clear_timer(c, &c->more_timer)
 
 static inline int __seq_offset(struct l2cap_chan *chan, __u16 seq1, __u16 seq2)
 {
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 73bf8a8..4f3ccf8 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -337,6 +337,24 @@ static void l2cap_seq_list_append(struct l2cap_seq_list *seq_list, u16 seq)
 	}
 }
 
+static void l2cap_do_send(struct l2cap_chan *chan, struct sk_buff *skb)
+{
+	struct hci_conn *hcon = chan->conn->hcon;
+	u16 flags;
+
+	BT_DBG("chan %p, skb %p len %d priority %u", chan, skb, skb->len,
+							skb->priority);
+
+	if (!test_bit(FLAG_FLUSHABLE, &chan->flags) &&
+					lmp_no_flush_capable(hcon->hdev))
+		flags = ACL_START_NO_FLUSH;
+	else
+		flags = ACL_START;
+
+	bt_cb(skb)->force_active = test_bit(FLAG_FORCE_ACTIVE, &chan->flags);
+	hci_send_acl(chan->conn->hchan, skb, flags);
+}
+
 static void l2cap_chan_timeout(struct work_struct *work)
 {
 	struct l2cap_chan *chan = container_of(work, struct l2cap_chan,
@@ -367,6 +385,22 @@ static void l2cap_chan_timeout(struct work_struct *work)
 	l2cap_chan_put(chan);
 }
 
+static void l2cap_msg_more_timeout(struct work_struct *work)
+{
+	struct l2cap_chan *chan = container_of(work, struct l2cap_chan,
+					       more_timer.work);
+
+	BT_DBG("chan %p", chan);
+
+	l2cap_chan_lock(chan);
+
+	l2cap_do_send(chan, chan->skb_more);
+	chan->skb_more = NULL;
+
+	l2cap_chan_unlock(chan);
+	l2cap_chan_put(chan);
+}
+
 struct l2cap_chan *l2cap_chan_create(void)
 {
 	struct l2cap_chan *chan;
@@ -382,6 +416,7 @@ struct l2cap_chan *l2cap_chan_create(void)
 	write_unlock(&chan_list_lock);
 
 	INIT_DELAYED_WORK(&chan->chan_timer, l2cap_chan_timeout);
+	INIT_DELAYED_WORK(&chan->more_timer, l2cap_msg_more_timeout);
 
 	chan->state = BT_OPEN;
 
@@ -696,24 +731,6 @@ static void l2cap_send_cmd(struct l2cap_conn *conn, u8 ident, u8 code, u16 len,
 	hci_send_acl(conn->hchan, skb, flags);
 }
 
-static void l2cap_do_send(struct l2cap_chan *chan, struct sk_buff *skb)
-{
-	struct hci_conn *hcon = chan->conn->hcon;
-	u16 flags;
-
-	BT_DBG("chan %p, skb %p len %d priority %u", chan, skb, skb->len,
-							skb->priority);
-
-	if (!test_bit(FLAG_FLUSHABLE, &chan->flags) &&
-					lmp_no_flush_capable(hcon->hdev))
-		flags = ACL_START_NO_FLUSH;
-	else
-		flags = ACL_START;
-
-	bt_cb(skb)->force_active = test_bit(FLAG_FORCE_ACTIVE, &chan->flags);
-	hci_send_acl(chan->conn->hchan, skb, flags);
-}
-
 static void __unpack_enhanced_control(u16 enh, struct l2cap_ctrl *control)
 {
 	control->reqseq = (enh & L2CAP_CTRL_REQSEQ) >> L2CAP_CTRL_REQSEQ_SHIFT;
@@ -2142,6 +2159,9 @@ int l2cap_chan_send(struct l2cap_chan *chan, struct msghdr *msg, size_t len,
 
 	switch (chan->mode) {
 	case L2CAP_MODE_BASIC:
+
+		__clear_more_timer(chan);
+
 		/* Check outgoing MTU */
 		if (len > chan->omtu) {
 			kfree_skb(chan->skb_more);
@@ -2173,10 +2193,13 @@ int l2cap_chan_send(struct l2cap_chan *chan, struct msghdr *msg, size_t len,
 		if (!skb)
 			return err;
 
-		if (msg->msg_flags & MSG_MORE && skb->len < chan->omtu)
+		if (msg->msg_flags & MSG_MORE && skb->len < chan->omtu) {
 			chan->skb_more = skb;
-		else
-			l2cap_do_send(chan, skb);
+			__set_more_timer(chan);
+			return err;
+		}
+
+		l2cap_do_send(chan, skb);
 
 		break;
 
-- 
1.7.10.1

