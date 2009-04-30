Return-Path: <cyrus@holtmann.org>
From: ngh@isomerica.net
To: linux-bluetooth@vger.kernel.org
Cc: Nathan Holstein <nathan@lampreynetworks.com>
Subject: [PATCH] Add support for receiving data over an enhanced L2CAP channel
Date: Wed, 29 Apr 2009 21:45:32 -0400
Message-Id: <1241055933-12343-5-git-send-email-ngh@isomerica.net>
In-Reply-To: <1241055933-12343-4-git-send-email-ngh@isomerica.net>
References: <1241055933-12343-1-git-send-email-ngh@isomerica.net>
 <1241055933-12343-2-git-send-email-ngh@isomerica.net>
 <1241055933-12343-3-git-send-email-ngh@isomerica.net>
 <1241055933-12343-4-git-send-email-ngh@isomerica.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Nathan Holstein <nathan@lampreynetworks.com>

Receiving data over L2CAP socket depends upon the mode of the connection.  In
Basic mode, no processing needs to be done.  In Enhanced Retransmission and
Streaming modes there are two types of packets: information and supervisory.

This patch splits the control path of l2cap_data_channel() accordingly.
---
 net/bluetooth/l2cap.c |  131 ++++++++++++++++++++++++++++++++++++++++++++++---
 1 files changed, 123 insertions(+), 8 deletions(-)

diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index 2c694eb..0a9dd65 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -54,6 +54,8 @@
 #define VERSION "2.13"
 
 static u32 l2cap_feat_mask =
+	L2CAP_FEATURE_E_RETRANS |
+	L2CAP_FEATURE_STREAM |
 	L2CAP_FEATURE_FIX_CHAN;
 static u8 l2cap_fixed_chan[8] = { 0x02, };
 
@@ -2564,7 +2566,96 @@ static inline void l2cap_sig_channel(struct l2cap_conn *conn, struct sk_buff *sk
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
 
@@ -2582,13 +2673,37 @@ static inline int l2cap_data_channel(struct l2cap_conn *conn, u16 cid, struct sk
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
+	case L2CAP_MODE_ENH_RETRANS:
+		if (!l2cap_data_channel_enhanced(sk, lh, skb));
+			goto done;
+		break;
+
+	case L2CAP_MODE_STREAMING:
+		if (!l2cap_data_channel_streaming(sk, lh, skb));
+			goto done;
+		break;
+
+	case L2CAP_MODE_RETRANS:
+	case L2CAP_MODE_FLOWCTL:
+	default:
+		/* not implemented, no intention to implement
+		 * these modes are superceded by Enhanced Retransmission
+		 * and Streaming modes. */
+		BT_DBG("sk %p: bad mode 0x%2.2x", sk, l2cap_pi(sk)->mode);
+		break;
+	}
 
 drop:
 	kfree_skb(skb);
@@ -2652,7 +2767,7 @@ static void l2cap_recv_frame(struct l2cap_conn *conn, struct sk_buff *skb)
 		break;
 
 	default:
-		l2cap_data_channel(conn, cid, skb);
+		l2cap_data_channel(conn, cid, lh, skb);
 		break;
 	}
 }
-- 
1.6.0.6

