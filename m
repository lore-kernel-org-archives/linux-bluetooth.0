Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 11/15] Bluetooth: Move remote info to struct l2cap_chan
Date: Fri,  1 Apr 2011 19:33:16 -0300
Message-Id: <1301697200-2446-12-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1301697200-2446-11-git-send-email-padovan@profusion.mobi>
References: <1301697200-2446-1-git-send-email-padovan@profusion.mobi>
 <1301697200-2446-2-git-send-email-padovan@profusion.mobi>
 <1301697200-2446-3-git-send-email-padovan@profusion.mobi>
 <1301697200-2446-4-git-send-email-padovan@profusion.mobi>
 <1301697200-2446-5-git-send-email-padovan@profusion.mobi>
 <1301697200-2446-6-git-send-email-padovan@profusion.mobi>
 <1301697200-2446-7-git-send-email-padovan@profusion.mobi>
 <1301697200-2446-8-git-send-email-padovan@profusion.mobi>
 <1301697200-2446-9-git-send-email-padovan@profusion.mobi>
 <1301697200-2446-10-git-send-email-padovan@profusion.mobi>
 <1301697200-2446-11-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

As part of the moving channel stuff to l2cap_chan.

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 include/net/bluetooth/l2cap.h |   10 +++++-----
 net/bluetooth/l2cap_core.c    |   32 ++++++++++++++++----------------
 net/bluetooth/l2cap_sock.c    |    4 ++--
 3 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 19d613b..11c53cb 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -302,6 +302,9 @@ struct l2cap_chan {
 	__u16		partial_sdu_len;
 	struct sk_buff	*sdu;
 
+	__u8		remote_tx_win;
+	__u8		remote_max_tx;
+	__u16		remote_mps;
 
 	struct list_head list;
 };
@@ -370,11 +373,8 @@ struct l2cap_pinfo {
 
 	__u8		tx_win;
 	__u8		max_tx;
-	__u8		remote_tx_win;
-	__u8		remote_max_tx;
 	__u16		retrans_timeout;
 	__u16		monitor_timeout;
-	__u16		remote_mps;
 	__u16		mps;
 
 	__le16		sport;
@@ -431,7 +431,7 @@ static inline int l2cap_tx_window_full(struct l2cap_chan *ch)
 	if (sub < 0)
 		sub += 64;
 
-	return sub == l2cap_pi(ch->sk)->remote_tx_win;
+	return sub == ch->remote_tx_win;
 }
 
 #define __get_txseq(ctrl)	(((ctrl) & L2CAP_CTRL_TXSEQ) >> 1)
@@ -454,7 +454,7 @@ int __l2cap_wait_ack(struct sock *sk);
 struct sk_buff *l2cap_create_connless_pdu(struct sock *sk, struct msghdr *msg, size_t len);
 struct sk_buff *l2cap_create_basic_pdu(struct sock *sk, struct msghdr *msg, size_t len);
 struct sk_buff *l2cap_create_iframe_pdu(struct sock *sk, struct msghdr *msg, size_t len, u16 control, u16 sdulen);
-int l2cap_sar_segment_sdu(struct sock *sk, struct msghdr *msg, size_t len);
+int l2cap_sar_segment_sdu(struct l2cap_chan *chan, struct msghdr *msg, size_t len);
 void l2cap_do_send(struct sock *sk, struct sk_buff *skb);
 void l2cap_streaming_send(struct l2cap_chan *chan);
 int l2cap_ertm_send(struct l2cap_chan *chan);
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 9f59147..512cf26 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -957,7 +957,7 @@ static void l2cap_monitor_timeout(unsigned long arg)
 	BT_DBG("chan %p", chan);
 
 	bh_lock_sock(sk);
-	if (chan->retry_count >= l2cap_pi(sk)->remote_max_tx) {
+	if (chan->retry_count >= chan->remote_max_tx) {
 		l2cap_send_disconn_req(l2cap_pi(sk)->conn, sk, ECONNABORTED);
 		bh_unlock_sock(sk);
 		return;
@@ -1066,8 +1066,8 @@ static void l2cap_retransmit_one_frame(struct l2cap_chan *chan, u8 tx_seq)
 
 	} while ((skb = skb_queue_next(TX_QUEUE(sk), skb)));
 
-	if (pi->remote_max_tx &&
-			bt_cb(skb)->retries == pi->remote_max_tx) {
+	if (chan->remote_max_tx &&
+			bt_cb(skb)->retries == chan->remote_max_tx) {
 		l2cap_send_disconn_req(pi->conn, sk, ECONNABORTED);
 		return;
 	}
@@ -1107,8 +1107,8 @@ int l2cap_ertm_send(struct l2cap_chan *chan)
 
 	while ((skb = sk->sk_send_head) && (!l2cap_tx_window_full(chan))) {
 
-		if (pi->remote_max_tx &&
-				bt_cb(skb)->retries == pi->remote_max_tx) {
+		if (chan->remote_max_tx &&
+				bt_cb(skb)->retries == chan->remote_max_tx) {
 			l2cap_send_disconn_req(pi->conn, sk, ECONNABORTED);
 			break;
 		}
@@ -1338,9 +1338,9 @@ struct sk_buff *l2cap_create_iframe_pdu(struct sock *sk, struct msghdr *msg, siz
 	return skb;
 }
 
-int l2cap_sar_segment_sdu(struct sock *sk, struct msghdr *msg, size_t len)
+int l2cap_sar_segment_sdu(struct l2cap_chan *chan, struct msghdr *msg, size_t len)
 {
-	struct l2cap_pinfo *pi = l2cap_pi(sk);
+	struct sock *sk = chan->sk;
 	struct sk_buff *skb;
 	struct sk_buff_head sar_queue;
 	u16 control;
@@ -1348,20 +1348,20 @@ int l2cap_sar_segment_sdu(struct sock *sk, struct msghdr *msg, size_t len)
 
 	skb_queue_head_init(&sar_queue);
 	control = L2CAP_SDU_START;
-	skb = l2cap_create_iframe_pdu(sk, msg, pi->remote_mps, control, len);
+	skb = l2cap_create_iframe_pdu(sk, msg, chan->remote_mps, control, len);
 	if (IS_ERR(skb))
 		return PTR_ERR(skb);
 
 	__skb_queue_tail(&sar_queue, skb);
-	len -= pi->remote_mps;
-	size += pi->remote_mps;
+	len -= chan->remote_mps;
+	size += chan->remote_mps;
 
 	while (len > 0) {
 		size_t buflen;
 
-		if (len > pi->remote_mps) {
+		if (len > chan->remote_mps) {
 			control = L2CAP_SDU_CONTINUE;
-			buflen = pi->remote_mps;
+			buflen = chan->remote_mps;
 		} else {
 			control = L2CAP_SDU_END;
 			buflen = len;
@@ -1811,13 +1811,13 @@ done:
 			break;
 
 		case L2CAP_MODE_ERTM:
-			pi->remote_tx_win = rfc.txwin_size;
-			pi->remote_max_tx = rfc.max_transmit;
+			chan->remote_tx_win = rfc.txwin_size;
+			chan->remote_max_tx = rfc.max_transmit;
 
 			if (le16_to_cpu(rfc.max_pdu_size) > pi->conn->mtu - 10)
 				rfc.max_pdu_size = cpu_to_le16(pi->conn->mtu - 10);
 
-			pi->remote_mps = le16_to_cpu(rfc.max_pdu_size);
+			chan->remote_mps = le16_to_cpu(rfc.max_pdu_size);
 
 			rfc.retrans_timeout =
 				le16_to_cpu(L2CAP_DEFAULT_RETRANS_TO);
@@ -1835,7 +1835,7 @@ done:
 			if (le16_to_cpu(rfc.max_pdu_size) > pi->conn->mtu - 10)
 				rfc.max_pdu_size = cpu_to_le16(pi->conn->mtu - 10);
 
-			pi->remote_mps = le16_to_cpu(rfc.max_pdu_size);
+			chan->remote_mps = le16_to_cpu(rfc.max_pdu_size);
 
 			pi->conf_state |= L2CAP_CONF_MODE_DONE;
 
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 19574e4..f90ca25 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -757,7 +757,7 @@ static int l2cap_sock_sendmsg(struct kiocb *iocb, struct socket *sock, struct ms
 	case L2CAP_MODE_ERTM:
 	case L2CAP_MODE_STREAMING:
 		/* Entire SDU fits into one PDU */
-		if (len <= pi->remote_mps) {
+		if (len <= pi->chan->remote_mps) {
 			control = L2CAP_SDU_UNSEGMENTED;
 			skb = l2cap_create_iframe_pdu(sk, msg, len, control, 0);
 			if (IS_ERR(skb)) {
@@ -771,7 +771,7 @@ static int l2cap_sock_sendmsg(struct kiocb *iocb, struct socket *sock, struct ms
 
 		} else {
 		/* Segment SDU into multiples PDUs */
-			err = l2cap_sar_segment_sdu(sk, msg, len);
+			err = l2cap_sar_segment_sdu(pi->chan, msg, len);
 			if (err < 0)
 				goto done;
 		}
-- 
1.7.4.1

