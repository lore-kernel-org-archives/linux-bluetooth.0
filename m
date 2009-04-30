Return-Path: <cyrus@holtmann.org>
From: ngh@isomerica.net
To: linux-bluetooth@vger.kernel.org
Cc: Nathan Holstein <nathan@lampreynetworks.com>
Subject: [PATCH 06/10] Add support for receiving data over an enhanced L2CAP channel
Date: Thu, 30 Apr 2009 17:16:43 -0400
Message-Id: <1241126207-19996-7-git-send-email-ngh@isomerica.net>
In-Reply-To: <1241126207-19996-1-git-send-email-ngh@isomerica.net>
References: <1241126207-19996-1-git-send-email-ngh@isomerica.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Nathan Holstein <nathan@lampreynetworks.com>

Receiving data over L2CAP socket depends upon the mode of the connection.  In
Basic mode, no processing needs to be done.  In Enhanced Retransmission and
Streaming modes there are two types of packets: information and supervisory.

This patch splits the control path of l2cap_data_channel() accordingly.

Signed-off-by: Nathan Holstein <nathan@lampreynetworks.com>
---
 include/net/bluetooth/l2cap.h |   30 ++++++++++-
 net/bluetooth/l2cap.c         |  124 ++++++++++++++++++++++++++++++++++++++---
 2 files changed, 145 insertions(+), 9 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 9221c4a..85fc21b 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -327,7 +327,7 @@ struct l2cap_pinfo {
 #define L2CAP_CONF_REQ_SENT	0x01
 #define L2CAP_CONF_INPUT_DONE	0x02
 #define L2CAP_CONF_MTU_DONE	0x04
-#define L2CAP_CONF_MODE_DONE	0x04
+#define L2CAP_CONF_MODE_DONE	0x08
 #define L2CAP_CONF_CONNECT_PEND	0x80
 #define L2CAP_CONF_OUTPUT_DONE(state) (\
 		((state) & L2CAP_CONF_MTU_DONE) && \
@@ -335,6 +335,34 @@ struct l2cap_pinfo {
 
 #define L2CAP_CONF_MAX_RETRIES	2
 
+static inline u8 l2cap_control_txseq(u16 control)
+{
+	return (control & L2CAP_CONTROL_TXSEQ_MASK) >>
+			L2CAP_CONTROL_TXSEQ_SHIFT;
+}
+
+static inline u8 l2cap_control_reqseq(u16 control)
+{
+	return (control & L2CAP_CONTROL_REQSEQ_MASK) >>
+			L2CAP_CONTROL_REQSEQ_SHIFT;
+}
+
+static inline u16 l2cap_txseq_to_reqseq(u16 control)
+{
+	return (control & L2CAP_CONTROL_TXSEQ_MASK) <<
+			(L2CAP_CONTROL_REQSEQ_SHIFT - L2CAP_CONTROL_TXSEQ_SHIFT);
+}
+
+static inline int l2cap_is_I_frame(u16 control)
+{
+	return !(control & L2CAP_CONTROL_TYPE_MASK);
+}
+
+static inline int l2cap_is_S_frame(u16 control)
+{
+	return (control & L2CAP_CONTROL_TYPE_MASK);
+}
+
 void l2cap_load(void);
 
 #endif /* __L2CAP_H */
diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index 423999e..b2c8dd7 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -2563,7 +2563,96 @@ static inline void l2cap_sig_channel(struct l2cap_conn *conn, struct sk_buff *sk
 	kfree_skb(skb);
 }
 
-static inline int l2cap_data_channel(struct l2cap_conn *conn, u16 cid, struct sk_buff *skb)
+static inline int l2cap_data_channel_i_frame(struct sock *sk, u16 rx_control, struct sk_buff *skb)
+{
+	struct l2cap_pinfo *pi = l2cap_pi(sk);
+	u8 tx_seq = l2cap_control_txseq(rx_control);
+	u16 tx_control;
+	int err = 0;
+
+	BT_DBG("sk %p rx_control 0x%4.4x len %d", sk, rx_control, skb->len);
+
+	if (tx_seq != pi->req_seq) {
+		tx_control = pi->req_seq << L2CAP_CONTROL_REQSEQ_SHIFT;
+		tx_control |= L2CAP_SUPER_SELECT_REJECT;
+		err = -1;
+		goto respond;
+	}
+
+	L2CAP_SEQ_NUM_INC(pi->req_seq);
+	tx_control = pi->req_seq << L2CAP_CONTROL_REQSEQ_SHIFT;
+
+	if ((err = sock_queue_rcv_skb(sk, skb))) {
+		tx_control |= L2CAP_SUPER_RCV_NOT_READY;
+		goto respond;
+	}
+
+	tx_control |= L2CAP_SUPER_RCV_READY;
+
+respond:
+	if (!l2cap_send_sframe(pi, tx_control)) {
+		/* TODO:
+		 * set an error state, disconnect */
+		return -1;
+	}
+
+	return err;
+}
+
+static inline int l2cap_data_channel_s_frame(struct sock *sk, u16 rx_control, struct sk_buff *skb)
+{
+	u16 tx_control;
+	BT_DBG("sk %p rx_control 0x%4.4x len %d", sk, rx_control, skb->len);
+
+	if (rx_control & L2CAP_CONTROL_POLL_MASK) {
+		tx_control = rx_control & L2CAP_CONTROL_REQSEQ_MASK;
+		tx_control |= L2CAP_CONTROL_FINAL_MASK;
+		return l2cap_send_sframe(l2cap_pi(sk), tx_control);
+	}
+
+	return -1;
+}
+
+static inline int l2cap_data_channel_enhanced(struct sock *sk, struct l2cap_hdr *lh, struct sk_buff *skb)
+{
+	struct l2cap_pinfo *pi = l2cap_pi(sk);
+	u16 control;
+
+	BT_DBG("sk %p skb %p", sk, skb);
+
+	control = get_unaligned((__le16 *) skb->data);
+	skb_pull(skb, 2);
+
+	if (l2cap_control_txseq(control) != pi->req_seq)
+	{
+		BT_DBG("wrong tx seq");
+		/* TODO:
+		 * once we increase our tx window, we can queue this.  For now,
+		 * just silently drop it. */
+		//return -1;
+	}
+
+	if (l2cap_is_I_frame(control))
+		return l2cap_data_channel_i_frame(sk, control, skb);
+	else
+		return l2cap_data_channel_s_frame(sk, control, skb);
+}
+
+static int l2cap_data_channel_streaming(struct sock *sk, struct l2cap_hdr *lh, struct sk_buff *skb)
+{
+	struct l2cap_pinfo *pi = l2cap_pi(sk);
+	u16 control;
+
+	control = get_unaligned((__le16 *) skb->data);
+	skb_pull(skb, 2);
+
+	if (!sock_queue_rcv_skb(sk, skb))
+		return -1;
+
+	return 0;
+}
+
+static inline int l2cap_data_channel(struct l2cap_conn *conn, u16 cid, struct l2cap_hdr *lh, struct sk_buff *skb)
 {
 	struct sock *sk;
 
@@ -2581,13 +2670,32 @@ static inline int l2cap_data_channel(struct l2cap_conn *conn, u16 cid, struct sk
 	if (l2cap_pi(sk)->imtu < skb->len)
 		goto drop;
 
-	/* If socket recv buffers overflows we drop data here
-	 * which is *bad* because L2CAP has to be reliable.
-	 * But we don't have any other choice. L2CAP doesn't
-	 * provide flow control mechanism. */
+	switch (l2cap_pi(sk)->mode)
+	{
+	case L2CAP_MODE_BASIC:
+		/* If socket recv buffers overflows we drop data here
+		 * which is *bad* because L2CAP has to be reliable.
+		 * But we don't have any other choice. L2CAP doesn't
+		 * provide flow control mechanism. */
 
-	if (!sock_queue_rcv_skb(sk, skb))
-		goto done;
+		if (!sock_queue_rcv_skb(sk, skb))
+			goto done;
+		break;
+
+	case L2CAP_MODE_ERTM:
+		if (!l2cap_data_channel_enhanced(sk, lh, skb));
+			goto done;
+		break;
+
+	case L2CAP_MODE_STREAM:
+		if (!l2cap_data_channel_streaming(sk, lh, skb));
+			goto done;
+		break;
+
+	default:
+		BT_DBG("sk %p: bad mode 0x%2.2x", sk, l2cap_pi(sk)->mode);
+		break;
+	}
 
 drop:
 	kfree_skb(skb);
@@ -2651,7 +2759,7 @@ static void l2cap_recv_frame(struct l2cap_conn *conn, struct sk_buff *skb)
 		break;
 
 	default:
-		l2cap_data_channel(conn, cid, skb);
+		l2cap_data_channel(conn, cid, lh, skb);
 		break;
 	}
 }
-- 
1.6.0.6

