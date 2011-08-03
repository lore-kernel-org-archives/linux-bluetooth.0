Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 2/3] Bluetooth: set skbuffer priority based on L2CAP socket priority
Date: Wed,  3 Aug 2011 16:11:33 +0300
Message-Id: <1312377094-11285-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1312377094-11285-1-git-send-email-luiz.dentz@gmail.com>
References: <1312377094-11285-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This uses SO_PRIORITY to set the skbuffer priority field

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/l2cap.h |    3 +-
 net/bluetooth/l2cap_core.c    |   47 +++++++++++++++++++++++++++++-----------
 net/bluetooth/l2cap_sock.c    |    2 +-
 3 files changed, 37 insertions(+), 15 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 4f34ad2..f018e5d 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -511,7 +511,8 @@ struct l2cap_chan *l2cap_chan_create(struct sock *sk);
 void l2cap_chan_close(struct l2cap_chan *chan, int reason);
 void l2cap_chan_destroy(struct l2cap_chan *chan);
 int l2cap_chan_connect(struct l2cap_chan *chan);
-int l2cap_chan_send(struct l2cap_chan *chan, struct msghdr *msg, size_t len);
+int l2cap_chan_send(struct l2cap_chan *chan, struct msghdr *msg, size_t len,
+								u32 priority);
 void l2cap_chan_busy(struct l2cap_chan *chan, int busy);
 
 #endif /* __L2CAP_H */
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 3204ba8..2be08ba 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -550,6 +550,8 @@ static void l2cap_send_cmd(struct l2cap_conn *conn, u8 ident, u8 code, u16 len,
 	if (!skb)
 		return;
 
+	skb->priority = HCI_PRIO_MAX;
+
 	if (lmp_no_flush_capable(conn->hcon->hdev))
 		flags = ACL_START_NO_FLUSH;
 	else
@@ -1245,7 +1247,8 @@ void l2cap_do_send(struct l2cap_chan *chan, struct sk_buff *skb)
 	struct hci_conn *hcon = chan->conn->hcon;
 	u16 flags;
 
-	BT_DBG("chan %p, skb %p len %d", chan, skb, skb->len);
+	BT_DBG("chan %p, skb %p len %d priority %u", chan, skb, skb->len,
+							skb->priority);
 
 	if (!chan->flushable && lmp_no_flush_capable(hcon->hdev))
 		flags = ACL_START_NO_FLUSH;
@@ -1451,6 +1454,8 @@ static inline int l2cap_skbuff_fromiovec(struct sock *sk, struct msghdr *msg, in
 		if (memcpy_fromiovec(skb_put(*frag, count), msg->msg_iov, count))
 			return -EFAULT;
 
+		(*frag)->priority = skb->priority;
+
 		sent += count;
 		len  -= count;
 
@@ -1460,7 +1465,9 @@ static inline int l2cap_skbuff_fromiovec(struct sock *sk, struct msghdr *msg, in
 	return sent;
 }
 
-struct sk_buff *l2cap_create_connless_pdu(struct l2cap_chan *chan, struct msghdr *msg, size_t len)
+static struct sk_buff *l2cap_create_connless_pdu(struct l2cap_chan *chan,
+						struct msghdr *msg, size_t len,
+						u32 priority)
 {
 	struct sock *sk = chan->sk;
 	struct l2cap_conn *conn = chan->conn;
@@ -1468,7 +1475,7 @@ struct sk_buff *l2cap_create_connless_pdu(struct l2cap_chan *chan, struct msghdr
 	int err, count, hlen = L2CAP_HDR_SIZE + 2;
 	struct l2cap_hdr *lh;
 
-	BT_DBG("sk %p len %d", sk, (int)len);
+	BT_DBG("sk %p len %d priority %u", sk, (int)len, priority);
 
 	count = min_t(unsigned int, (conn->mtu - hlen), len);
 	skb = bt_skb_send_alloc(sk, count + hlen,
@@ -1476,6 +1483,8 @@ struct sk_buff *l2cap_create_connless_pdu(struct l2cap_chan *chan, struct msghdr
 	if (!skb)
 		return ERR_PTR(err);
 
+	skb->priority = priority;
+
 	/* Create L2CAP header */
 	lh = (struct l2cap_hdr *) skb_put(skb, L2CAP_HDR_SIZE);
 	lh->cid = cpu_to_le16(chan->dcid);
@@ -1490,7 +1499,9 @@ struct sk_buff *l2cap_create_connless_pdu(struct l2cap_chan *chan, struct msghdr
 	return skb;
 }
 
-struct sk_buff *l2cap_create_basic_pdu(struct l2cap_chan *chan, struct msghdr *msg, size_t len)
+static struct sk_buff *l2cap_create_basic_pdu(struct l2cap_chan *chan,
+						struct msghdr *msg, size_t len,
+						u32 priority)
 {
 	struct sock *sk = chan->sk;
 	struct l2cap_conn *conn = chan->conn;
@@ -1506,6 +1517,8 @@ struct sk_buff *l2cap_create_basic_pdu(struct l2cap_chan *chan, struct msghdr *m
 	if (!skb)
 		return ERR_PTR(err);
 
+	skb->priority = priority;
+
 	/* Create L2CAP header */
 	lh = (struct l2cap_hdr *) skb_put(skb, L2CAP_HDR_SIZE);
 	lh->cid = cpu_to_le16(chan->dcid);
@@ -1519,7 +1532,10 @@ struct sk_buff *l2cap_create_basic_pdu(struct l2cap_chan *chan, struct msghdr *m
 	return skb;
 }
 
-struct sk_buff *l2cap_create_iframe_pdu(struct l2cap_chan *chan, struct msghdr *msg, size_t len, u16 control, u16 sdulen)
+static struct sk_buff *l2cap_create_iframe_pdu(struct l2cap_chan *chan,
+						struct msghdr *msg, size_t len,
+						u32 priority, u16 control,
+						u16 sdulen)
 {
 	struct sock *sk = chan->sk;
 	struct l2cap_conn *conn = chan->conn;
@@ -1527,7 +1543,7 @@ struct sk_buff *l2cap_create_iframe_pdu(struct l2cap_chan *chan, struct msghdr *
 	int err, count, hlen = L2CAP_HDR_SIZE + 2;
 	struct l2cap_hdr *lh;
 
-	BT_DBG("sk %p len %d", sk, (int)len);
+	BT_DBG("sk %p len %d priority %u", sk, (int)len, priority);
 
 	if (!conn)
 		return ERR_PTR(-ENOTCONN);
@@ -1544,6 +1560,8 @@ struct sk_buff *l2cap_create_iframe_pdu(struct l2cap_chan *chan, struct msghdr *
 	if (!skb)
 		return ERR_PTR(err);
 
+	skb->priority = priority;
+
 	/* Create L2CAP header */
 	lh = (struct l2cap_hdr *) skb_put(skb, L2CAP_HDR_SIZE);
 	lh->cid = cpu_to_le16(chan->dcid);
@@ -1574,7 +1592,8 @@ int l2cap_sar_segment_sdu(struct l2cap_chan *chan, struct msghdr *msg, size_t le
 
 	skb_queue_head_init(&sar_queue);
 	control = L2CAP_SDU_START;
-	skb = l2cap_create_iframe_pdu(chan, msg, chan->remote_mps, control, len);
+	skb = l2cap_create_iframe_pdu(chan, msg, chan->remote_mps,
+						HCI_PRIO_MAX, control, len);
 	if (IS_ERR(skb))
 		return PTR_ERR(skb);
 
@@ -1593,7 +1612,8 @@ int l2cap_sar_segment_sdu(struct l2cap_chan *chan, struct msghdr *msg, size_t le
 			buflen = len;
 		}
 
-		skb = l2cap_create_iframe_pdu(chan, msg, buflen, control, 0);
+		skb = l2cap_create_iframe_pdu(chan, msg, buflen, HCI_PRIO_MAX,
+								control, 0);
 		if (IS_ERR(skb)) {
 			skb_queue_purge(&sar_queue);
 			return PTR_ERR(skb);
@@ -1610,7 +1630,8 @@ int l2cap_sar_segment_sdu(struct l2cap_chan *chan, struct msghdr *msg, size_t le
 	return size;
 }
 
-int l2cap_chan_send(struct l2cap_chan *chan, struct msghdr *msg, size_t len)
+int l2cap_chan_send(struct l2cap_chan *chan, struct msghdr *msg, size_t len,
+								u32 priority)
 {
 	struct sk_buff *skb;
 	u16 control;
@@ -1618,7 +1639,7 @@ int l2cap_chan_send(struct l2cap_chan *chan, struct msghdr *msg, size_t len)
 
 	/* Connectionless channel */
 	if (chan->chan_type == L2CAP_CHAN_CONN_LESS) {
-		skb = l2cap_create_connless_pdu(chan, msg, len);
+		skb = l2cap_create_connless_pdu(chan, msg, len, priority);
 		if (IS_ERR(skb))
 			return PTR_ERR(skb);
 
@@ -1633,7 +1654,7 @@ int l2cap_chan_send(struct l2cap_chan *chan, struct msghdr *msg, size_t len)
 			return -EMSGSIZE;
 
 		/* Create a basic PDU */
-		skb = l2cap_create_basic_pdu(chan, msg, len);
+		skb = l2cap_create_basic_pdu(chan, msg, len, priority);
 		if (IS_ERR(skb))
 			return PTR_ERR(skb);
 
@@ -1646,8 +1667,8 @@ int l2cap_chan_send(struct l2cap_chan *chan, struct msghdr *msg, size_t len)
 		/* Entire SDU fits into one PDU */
 		if (len <= chan->remote_mps) {
 			control = L2CAP_SDU_UNSEGMENTED;
-			skb = l2cap_create_iframe_pdu(chan, msg, len, control,
-									0);
+			skb = l2cap_create_iframe_pdu(chan, msg, len, priority,
+								control, 0);
 			if (IS_ERR(skb))
 				return PTR_ERR(skb);
 
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 5c36b3e..abe302b 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -706,7 +706,7 @@ static int l2cap_sock_sendmsg(struct kiocb *iocb, struct socket *sock, struct ms
 		return -ENOTCONN;
 	}
 
-	err = l2cap_chan_send(chan, msg, len);
+	err = l2cap_chan_send(chan, msg, len, sk->sk_priority);
 
 	release_sock(sk);
 	return err;
-- 
1.7.6

