Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <gustavo@las.ic.unicamp.br>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org
Subject: [PATCH] [RFC] Bluetooth: Add initial support for ERTM packets tranfers
Date: Fri, 17 Jul 2009 06:28:52 -0300
Message-Id: <1247822932-23162-1-git-send-email-gustavo@las.ic.unicamp.br>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

This patch adds support for ERTM, without retransmission and txWindow up to
63. I think the patch is too big, but all this code only make sense
together.

There is still one issue on sending I-frames, I still don't know what
value put into ReqSeq field, but this affects nothing for now and the
patch can reviewed. I'm still working on this issue.

Based on a patch from Nathan Holstein <nathan@lampreynetworks.com>

Signed-off-by: Gustavo F. Padovan <gustavo@las.ic.unicamp.br>
---
 include/net/bluetooth/bluetooth.h |    3 +-
 include/net/bluetooth/l2cap.h     |  137 ++++++++++++++-
 net/bluetooth/l2cap.c             |  352 +++++++++++++++++++++++++++++++------
 3 files changed, 439 insertions(+), 53 deletions(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index 968166a..65a5cf8 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -138,8 +138,9 @@ struct sock *bt_accept_dequeue(struct sock *parent, struct socket *newsock);
 struct bt_skb_cb {
 	__u8 pkt_type;
 	__u8 incoming;
+	__u8 tx_seq;
 };
-#define bt_cb(skb) ((struct bt_skb_cb *)(skb->cb)) 
+#define bt_cb(skb) ((struct bt_skb_cb *)((skb)->cb))
 
 static inline struct sk_buff *bt_skb_alloc(unsigned int len, gfp_t how)
 {
diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 6fc7698..167f9d9 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -29,7 +29,7 @@
 #define L2CAP_DEFAULT_MTU		672
 #define L2CAP_DEFAULT_MIN_MTU		48
 #define L2CAP_DEFAULT_FLUSH_TO		0xffff
-#define L2CAP_DEFAULT_TX_WINDOW		1
+#define L2CAP_DEFAULT_TX_WINDOW		63
 #define L2CAP_DEFAULT_MAX_RECEIVE	1
 #define L2CAP_DEFAULT_RETRANS_TO	300    /* 300 milliseconds */
 #define L2CAP_DEFAULT_MONITOR_TO	1000   /* 1 second */
@@ -94,6 +94,26 @@ struct l2cap_conninfo {
 #define L2CAP_FCS_NONE		0x00
 #define L2CAP_FCS_CRC16		0x01
 
+/* L2CAP Control Field bit masks */
+#define L2CAP_CONTROL_SAR               0xC000
+#define L2CAP_CONTROL_REQSEQ            0x3F00
+#define L2CAP_CONTROL_TXSEQ             0x007E
+#define L2CAP_CONTROL_RETRANS           0x0080
+#define L2CAP_CONTROL_FINAL             0x0080
+#define L2CAP_CONTROL_POLL              0x0010
+#define L2CAP_CONTROL_SUPERVISE         0x000C
+#define L2CAP_CONTROL_FRAME_TYPE        0x0001 /* I- or S-Frame */
+
+#define L2CAP_SEQ_NUM_INC(seq) ((seq) = (seq + 1) % 64)
+#define L2CAP_CONTROL_TXSEQ_SHIFT      1
+#define L2CAP_CONTROL_REQSEQ_SHIFT     8
+
+/* L2CAP Supervisory Function */
+#define L2CAP_SUPER_RCV_READY           0x0000
+#define L2CAP_SUPER_REJECT              0x0004
+#define L2CAP_SUPER_RCV_NOT_READY       0x0008
+#define L2CAP_SUPER_SELECT_REJECT       0x000C
+
 /* L2CAP structures */
 struct l2cap_hdr {
 	__le16     len;
@@ -101,6 +121,13 @@ struct l2cap_hdr {
 } __attribute__ ((packed));
 #define L2CAP_HDR_SIZE		4
 
+struct l2cap_ertm_hdr {
+	__le16     len;
+	__le16     cid;
+	__le16     control;
+} __attribute__ ((packed));
+#define L2CAP_ERTM_HDR_SIZE	6
+
 struct l2cap_cmd_hdr {
 	__u8       code;
 	__u8       ident;
@@ -284,6 +311,12 @@ struct l2cap_pinfo {
 	__u8		conf_req[64];
 	__u8		conf_len;
 	__u8		conf_state;
+	__u8		conn_state;
+
+	__u8		next_tx_seq;
+	__u8		expected_ack_seq;
+	__u8		req_seq;
+	__u8		expected_tx_seq;
 
 	__u8		ident;
 
@@ -295,6 +328,7 @@ struct l2cap_pinfo {
 
 	__le16		sport;
 
+	struct sk_buff_head	tx_queue;
 	struct l2cap_conn	*conn;
 	struct sock		*next_c;
 	struct sock		*prev_c;
@@ -311,6 +345,107 @@ struct l2cap_pinfo {
 #define L2CAP_CONF_MAX_CONF_REQ 2
 #define L2CAP_CONF_MAX_CONF_RSP 2
 
+#define L2CAP_CONN_TRANSMITTER     0x01
+
+static inline void l2cap_init_send_head(struct sock *sk)
+{
+	sk->sk_send_head = NULL;
+}
+
+static inline struct sk_buff *l2cap_send_head(struct sock *sk)
+{
+	return sk->sk_send_head;
+}
+
+static inline void __l2cap_add_tx_queue_tail(struct sock *sk, struct sk_buff *skb)
+{
+	__skb_queue_tail(&l2cap_pi(sk)->tx_queue, skb);
+}
+
+static inline void l2cap_tx_queue_head_init(struct sock *sk) {
+	__skb_queue_head_init(&l2cap_pi(sk)->tx_queue);
+}
+
+static inline void l2cap_add_tx_queue_tail(struct sock *sk, struct sk_buff *skb)
+{
+	__l2cap_add_tx_queue_tail(sk, skb);
+
+	/* Queue it, remembering where we must start sending. */
+	if (sk->sk_send_head == NULL) {
+		sk->sk_send_head = skb;
+	}
+}
+
+static inline struct sk_buff *l2cap_write_queue_next(struct sock *sk, struct sk_buff *skb)
+{
+	return skb_queue_next(&l2cap_pi(sk)->tx_queue, skb);
+}
+
+static inline bool l2cap_skb_is_last(const struct sock *sk,
+				   const struct sk_buff *skb)
+{
+	return skb_queue_is_last(&l2cap_pi(sk)->tx_queue, skb);
+}
+
+static inline struct sk_buff *l2cap_skb_peek(struct sock *sk)
+{
+	return skb_peek(&l2cap_pi(sk)->tx_queue);
+}
+
+static inline struct sk_buff *l2cap_skb_dequeue(struct sock *sk)
+{
+	return skb_dequeue(&l2cap_pi(sk)->tx_queue);
+}
+
+static inline void l2cap_advance_send_head(struct sock *sk, struct sk_buff *skb)
+{
+	if (l2cap_skb_is_last(sk, skb))
+		sk->sk_send_head = NULL;
+	else
+		sk->sk_send_head = l2cap_write_queue_next(sk, skb);
+}
+
+static inline int l2cap_tx_window_full(struct sock *sk)
+{
+	struct l2cap_pinfo *pi = l2cap_pi(sk);
+	int sub;
+
+	sub = (pi->next_tx_seq - pi->expected_ack_seq) % 64;
+
+	if (sub < 0)
+		sub +=  64;
+
+	 return (sub == pi->remote_tx_win);
+
+}
+
+static inline u8 l2cap_control_txseq(u16 control)
+{
+	return (control & L2CAP_CONTROL_TXSEQ) >>
+		L2CAP_CONTROL_TXSEQ_SHIFT;
+}
+
+static inline u8 l2cap_control_reqseq(u16 control)
+{
+	return (control & L2CAP_CONTROL_REQSEQ) >>
+		L2CAP_CONTROL_REQSEQ_SHIFT;
+}
+
+static inline u16 l2cap_txseq_to_reqseq(u16 control)
+{
+	return (control & L2CAP_CONTROL_TXSEQ) <<
+		(L2CAP_CONTROL_REQSEQ_SHIFT - L2CAP_CONTROL_TXSEQ_SHIFT);
+}
+
+static inline int l2cap_is_I_frame(u16 control)
+{
+	return !(control & L2CAP_CONTROL_FRAME_TYPE);
+}
+
+static inline int l2cap_is_S_frame(u16 control)
+{
+	return (control & L2CAP_CONTROL_FRAME_TYPE);
+}
 
 void l2cap_load(void);
 
diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index af0fbf9..ffe92de 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -69,6 +69,7 @@ static void l2cap_sock_kill(struct sock *sk);
 
 static struct sk_buff *l2cap_build_cmd(struct l2cap_conn *conn,
 				u8 code, u8 ident, u16 dlen, void *data);
+static struct sk_buff *l2cap_build_S_frame(struct l2cap_pinfo *pi, u16 control);
 
 /* ---- L2CAP timers ---- */
 static void l2cap_sock_timeout(unsigned long arg)
@@ -333,6 +334,18 @@ static inline int l2cap_send_cmd(struct l2cap_conn *conn, u8 ident, u8 code, u16
 	return hci_send_acl(conn->hcon, skb, 0);
 }
 
+static inline int l2cap_send_S_frame(struct l2cap_pinfo *pi, u16 control)
+{
+	struct sk_buff *skb = l2cap_build_S_frame(pi, control);
+
+	BT_DBG("control 0x%2.2x", control);
+
+	if (!skb)
+		return -ENOMEM;
+
+	return hci_send_acl(pi->conn->hcon, skb, 0);
+}
+
 static void l2cap_do_start(struct sock *sk)
 {
 	struct l2cap_conn *conn = l2cap_pi(sk)->conn;
@@ -1149,39 +1162,78 @@ static int l2cap_sock_getname(struct socket *sock, struct sockaddr *addr, int *l
 	return 0;
 }
 
-static inline int l2cap_do_send(struct sock *sk, struct msghdr *msg, int len)
+static void l2cap_drop_acked_frames(struct sock *sk)
 {
-	struct l2cap_conn *conn = l2cap_pi(sk)->conn;
-	struct sk_buff *skb, **frag;
-	int err, hlen, count, sent = 0;
-	struct l2cap_hdr *lh;
+	struct sk_buff *skb;
 
-	BT_DBG("sk %p len %d", sk, len);
+	while ((skb = l2cap_skb_peek(sk))) {
 
-	/* First fragment (with L2CAP header) */
-	if (sk->sk_type == SOCK_DGRAM)
-		hlen = L2CAP_HDR_SIZE + 2;
-	else
-		hlen = L2CAP_HDR_SIZE;
+		if (bt_cb(skb)->tx_seq == l2cap_pi(sk)->expected_ack_seq)
+			break;
 
-	count = min_t(unsigned int, (conn->mtu - hlen), len);
+		skb = l2cap_skb_dequeue(sk);
+		kfree_skb(skb);
+	}
 
-	skb = bt_skb_send_alloc(sk, hlen + count,
-			msg->msg_flags & MSG_DONTWAIT, &err);
-	if (!skb)
-		return err;
+	return;
+}
 
-	/* Create L2CAP header */
-	lh = (struct l2cap_hdr *) skb_put(skb, L2CAP_HDR_SIZE);
-	lh->cid = cpu_to_le16(l2cap_pi(sk)->dcid);
-	lh->len = cpu_to_le16(len + (hlen - L2CAP_HDR_SIZE));
+static inline int l2cap_do_send(struct sock *sk, struct sk_buff *skb)
+{
+	struct l2cap_pinfo *pi = l2cap_pi(sk);
+	int err;
 
-	if (sk->sk_type == SOCK_DGRAM)
-		put_unaligned(l2cap_pi(sk)->psm, (__le16 *) skb_put(skb, 2));
+	BT_DBG("sk %p, skb %p len %d", sk, skb, skb->len);
+
+	err = hci_send_acl(pi->conn->hcon, skb, 0);
+
+	if (unlikely(err) < 0)
+		kfree_skb(skb);
+
+	return err;
+}
+
+static int l2cap_ertm_send(struct sock *sk)
+{
+	struct sk_buff *skb, *tx_skb;
+	struct l2cap_pinfo *pi = l2cap_pi(sk);
+	struct l2cap_ertm_hdr *lh;
+	u8 tx_seq;
+	u16 control;
+	int err;
+
+	while ((skb = l2cap_send_head(sk)) && (!l2cap_tx_window_full(sk))) {
+
+		tx_seq = pi->next_tx_seq;
+		tx_skb = skb_clone(skb, GFP_ATOMIC);
+
+		lh = (struct l2cap_ertm_hdr *) skb_push(tx_skb, 0);
+		control  = (pi->req_seq << L2CAP_CONTROL_REQSEQ_SHIFT)
+			| (tx_seq << L2CAP_CONTROL_TXSEQ_SHIFT);
+		lh->control = cpu_to_le16(control);
+
+		err = l2cap_do_send(sk, tx_skb);
+		if (err < 0)
+			return err;
+
+		L2CAP_SEQ_NUM_INC(pi->next_tx_seq);
+		bt_cb(skb)->tx_seq = tx_seq;
+
+		l2cap_advance_send_head(sk, skb);
+	}
+
+	return 0;
+}
+
+
+static inline int l2cap_skbuff_fromiovec(struct sock *sk, struct msghdr *msg, int len, int count, struct sk_buff *skb)
+{
+	struct l2cap_conn *conn = l2cap_pi(sk)->conn;
+	struct sk_buff **frag;
+	int err, sent = 0;
 
 	if (memcpy_fromiovec(skb_put(skb, count), msg->msg_iov, count)) {
-		err = -EFAULT;
-		goto fail;
+		return -EFAULT;
 	}
 
 	sent += count;
@@ -1194,33 +1246,67 @@ static inline int l2cap_do_send(struct sock *sk, struct msghdr *msg, int len)
 
 		*frag = bt_skb_send_alloc(sk, count, msg->msg_flags & MSG_DONTWAIT, &err);
 		if (!*frag)
-			goto fail;
-
-		if (memcpy_fromiovec(skb_put(*frag, count), msg->msg_iov, count)) {
-			err = -EFAULT;
-			goto fail;
-		}
+			return -EFAULT;
+		if (memcpy_fromiovec(skb_put(*frag, count), msg->msg_iov, count))
+			return -EFAULT;
 
 		sent += count;
 		len  -= count;
 
 		frag = &(*frag)->next;
 	}
-	err = hci_send_acl(conn->hcon, skb, 0);
-	if (err < 0)
-		goto fail;
 
 	return sent;
+}
+
+static int l2cap_create_sdu(struct sock *sk, struct msghdr *msg, int len, u8 ertm, struct sk_buff **out_skb)
+{
+	struct l2cap_conn *conn = l2cap_pi(sk)->conn;
+	struct sk_buff *skb;
+	int err, count, hlen;
+	struct l2cap_hdr *lh;
+
+	hlen = (ertm) ? L2CAP_ERTM_HDR_SIZE : L2CAP_HDR_SIZE;
+
+	BT_DBG("sk %p len %d", sk, len);
+
+	/* First fragment (with L2CAP header) */
+	if (sk->sk_type == SOCK_DGRAM)
+		hlen += 2;
+
+	count = min_t(unsigned int, (conn->mtu - hlen), len);
+	skb = bt_skb_send_alloc(sk, count + hlen,
+			msg->msg_flags & MSG_DONTWAIT, &err);
+	if (!skb)
+		return -ENOMEM;
+
+	/* Create L2CAP header */
+	lh = (struct l2cap_hdr *) skb_put(skb, L2CAP_HDR_SIZE);
+	lh->cid = cpu_to_le16(l2cap_pi(sk)->dcid);
+	lh->len = cpu_to_le16(len + (hlen - L2CAP_HDR_SIZE));
+
+	/* Reserve Control bits */
+	if (ertm)
+		skb_put(skb, 2);
+
+	if (sk->sk_type == SOCK_DGRAM)
+		put_unaligned(l2cap_pi(sk)->psm, (__le16 *) skb_put(skb, 2));
+
+	err = l2cap_skbuff_fromiovec(sk, msg, len, count, skb);
+	if (unlikely(err < 0))
+		kfree_skb(skb);
+	else
+		*out_skb = skb;
 
-fail:
-	kfree_skb(skb);
 	return err;
 }
 
 static int l2cap_sock_sendmsg(struct kiocb *iocb, struct socket *sock, struct msghdr *msg, size_t len)
 {
 	struct sock *sk = sock->sk;
-	int err = 0;
+	struct l2cap_pinfo *pi = l2cap_pi(sk);
+	struct sk_buff *skb;
+	int err;
 
 	BT_DBG("sock %p, sk %p", sock, sk);
 
@@ -1232,16 +1318,54 @@ static int l2cap_sock_sendmsg(struct kiocb *iocb, struct socket *sock, struct ms
 		return -EOPNOTSUPP;
 
 	/* Check outgoing MTU */
-	if (sk->sk_type != SOCK_RAW && len > l2cap_pi(sk)->omtu)
+	if ((sk->sk_type != SOCK_RAW || pi->mode == L2CAP_MODE_BASIC)
+		&& len > pi->omtu)
 		return -EINVAL;
 
 	lock_sock(sk);
 
-	if (sk->sk_state == BT_CONNECTED)
-		err = l2cap_do_send(sk, msg, len);
-	else
+	if (sk->sk_state != BT_CONNECTED) {
 		err = -ENOTCONN;
+		goto done;
+	}
+
+	switch (pi->mode) {
+	case L2CAP_MODE_BASIC:
+		err = l2cap_create_sdu(sk, msg, len, 0, &skb);
+		if (err < 0)
+			goto done;
+		err = l2cap_do_send(sk, skb);
+		if (!err)
+			err = len;
+		break;
+
+	case L2CAP_MODE_ERTM:
 
+		/* Entire SDU fits into one PDU */
+		if (len <= pi->omtu)
+			err = l2cap_create_sdu(sk, msg, len, 1, &skb);
+		else {
+			/* Segmentation will be added later */
+			err = -EINVAL;
+			goto done;
+		}
+		if (err < 0)
+			goto done;
+
+		l2cap_add_tx_queue_tail(sk, skb);
+
+		err = l2cap_ertm_send(sk);
+		if (!err)
+			err = len;
+		break;
+
+	default:
+		BT_DBG("bad state %1.1x", pi->mode);
+		err = -EINVAL;
+	}
+
+
+done:
 	release_sock(sk);
 	return err;
 }
@@ -1678,6 +1802,30 @@ fail:
 	return NULL;
 }
 
+static struct sk_buff *l2cap_build_S_frame(struct l2cap_pinfo *pi, u16 control)
+{
+	struct sk_buff *skb;
+	struct l2cap_ertm_hdr *lh;
+	struct l2cap_conn *conn = pi->conn;
+	int count;
+
+	BT_DBG("pi %p, control 0x%2.2x", pi, control);
+
+	count = min_t(unsigned int, conn->mtu, L2CAP_ERTM_HDR_SIZE);
+	control |= L2CAP_CONTROL_FRAME_TYPE;
+
+	skb = bt_skb_alloc(count, GFP_ATOMIC);
+	if (!skb)
+		return NULL;
+
+	lh = (struct l2cap_ertm_hdr *) skb_put(skb, L2CAP_ERTM_HDR_SIZE);
+	lh->len = cpu_to_le16(2);
+	lh->cid = cpu_to_le16(pi->dcid);
+	lh->control = cpu_to_le16(control);
+
+	return skb;
+}
+
 static inline int l2cap_get_conf_opt(void **ptr, int *type, int *olen, unsigned long *val)
 {
 	struct l2cap_conf_opt *opt = *ptr;
@@ -2305,6 +2453,10 @@ static inline int l2cap_config_req(struct l2cap_conn *conn, struct l2cap_cmd_hdr
 
 	if (l2cap_pi(sk)->conf_state & L2CAP_CONF_INPUT_DONE) {
 		sk->sk_state = BT_CONNECTED;
+		l2cap_pi(sk)->next_tx_seq = 0;
+		l2cap_pi(sk)->expected_ack_seq = 0;
+		l2cap_pi(sk)->conn_state |= L2CAP_CONN_TRANSMITTER;
+		l2cap_tx_queue_head_init(sk);
 		l2cap_chan_ready(sk);
 		goto unlock;
 	}
@@ -2389,6 +2541,7 @@ static inline int l2cap_config_rsp(struct l2cap_conn *conn, struct l2cap_cmd_hdr
 
 	if (l2cap_pi(sk)->conf_state & L2CAP_CONF_OUTPUT_DONE) {
 		sk->sk_state = BT_CONNECTED;
+		l2cap_pi(sk)->expected_tx_seq = 0;
 		l2cap_chan_ready(sk);
 	}
 
@@ -2419,6 +2572,8 @@ static inline int l2cap_disconnect_req(struct l2cap_conn *conn, struct l2cap_cmd
 
 	sk->sk_shutdown = SHUTDOWN_MASK;
 
+	if (l2cap_pi(sk)->conn_state & L2CAP_CONN_TRANSMITTER)
+		skb_queue_purge(&l2cap_pi(sk)->tx_queue);
 	l2cap_chan_del(sk, ECONNRESET);
 	bh_unlock_sock(sk);
 
@@ -2441,6 +2596,8 @@ static inline int l2cap_disconnect_rsp(struct l2cap_conn *conn, struct l2cap_cmd
 	if (!sk)
 		return 0;
 
+	if (l2cap_pi(sk)->conn_state & L2CAP_CONN_TRANSMITTER)
+		skb_queue_purge(&l2cap_pi(sk)->tx_queue);
 	l2cap_chan_del(sk, 0);
 	bh_unlock_sock(sk);
 
@@ -2616,7 +2773,88 @@ static inline void l2cap_sig_channel(struct l2cap_conn *conn, struct sk_buff *sk
 	kfree_skb(skb);
 }
 
-static inline int l2cap_data_channel(struct l2cap_conn *conn, u16 cid, struct sk_buff *skb)
+static inline int l2cap_data_channel_I_frame(struct sock *sk, u16 rx_control, struct sk_buff *skb)
+{
+	struct l2cap_pinfo *pi = l2cap_pi(sk);
+	u8 tx_seq = l2cap_control_txseq(rx_control);
+	u16 tx_control = 0;
+	int err = 0;
+
+	BT_DBG("sk %p rx_control 0x%4.4x len %d", sk, rx_control, skb->len);
+
+	tx_control |= L2CAP_CONTROL_FRAME_TYPE;
+
+	if (tx_seq != pi->expected_tx_seq)
+		return -EINVAL;
+
+	L2CAP_SEQ_NUM_INC(pi->expected_tx_seq);
+	tx_control |= L2CAP_SUPER_RCV_READY;
+	tx_control |= pi->expected_tx_seq << L2CAP_CONTROL_REQSEQ_SHIFT;
+
+
+	err = sock_queue_rcv_skb(sk, skb);
+	if (err)
+		return err;
+
+	if (l2cap_send_S_frame(pi, tx_control))
+		return -EINVAL;
+
+	return err;
+}
+
+static inline int l2cap_data_channel_S_frame(struct sock *sk, u16 rx_control, struct sk_buff *skb)
+{
+	struct l2cap_pinfo *pi = l2cap_pi(sk);
+	u16 tx_control;
+
+	BT_DBG("sk %p rx_control 0x%4.4x len %d", sk, rx_control, skb->len);
+
+	if (rx_control & L2CAP_CONTROL_POLL) {
+		tx_control = L2CAP_SUPER_RCV_READY | L2CAP_CONTROL_FINAL;
+		return l2cap_send_S_frame(pi, tx_control);
+	}
+
+	switch (rx_control & L2CAP_CONTROL_SUPERVISE) {
+	case L2CAP_SUPER_RCV_READY:
+		pi->expected_ack_seq = l2cap_control_reqseq(rx_control);
+		l2cap_drop_acked_frames(sk);
+		l2cap_ertm_send(sk);
+		break;
+
+	case L2CAP_SUPER_RCV_NOT_READY:
+	case L2CAP_SUPER_REJECT:
+	case L2CAP_SUPER_SELECT_REJECT:
+		break;
+	}
+
+	return 0;
+}
+
+static inline int l2cap_ertm_data_channel(struct sock *sk, struct l2cap_hdr *lh, struct sk_buff *skb)
+{
+	u16 control, len = skb->len;
+
+	BT_DBG("sk %p skb %p", sk, skb);
+
+	control = get_unaligned((__le16 *) skb->data);
+	skb_pull(skb, 2);
+	len -=2;
+	BT_DBG("control 0x%4.4x", control);
+
+	if (l2cap_pi(sk)->imtu < skb->len)
+		goto drop;
+
+	if (l2cap_is_I_frame(control))
+		return l2cap_data_channel_I_frame(sk, control, skb);
+	else
+		return l2cap_data_channel_S_frame(sk, control, skb);
+
+drop:
+	kfree_skb(skb);
+	return 0;
+}
+
+static inline int l2cap_data_channel(struct l2cap_conn *conn, u16 cid, struct l2cap_hdr *lh, struct sk_buff *skb)
 {
 	struct sock *sk;
 
@@ -2631,16 +2869,29 @@ static inline int l2cap_data_channel(struct l2cap_conn *conn, u16 cid, struct sk
 	if (sk->sk_state != BT_CONNECTED)
 		goto drop;
 
-	if (l2cap_pi(sk)->imtu < skb->len)
-		goto drop;
+	switch (l2cap_pi(sk)->mode) {
+	case L2CAP_MODE_BASIC:
+		/* If socket recv buffers overflows we drop data here
+		 * which is *bad* because L2CAP has to be reliable.
+		 * But we don't have any other choice. L2CAP doesn't
+		 * provide flow control mechanism. */
 
-	/* If socket recv buffers overflows we drop data here
-	 * which is *bad* because L2CAP has to be reliable.
-	 * But we don't have any other choice. L2CAP doesn't
-	 * provide flow control mechanism. */
+		if (l2cap_pi(sk)->imtu < skb->len)
+			goto drop;
 
-	if (!sock_queue_rcv_skb(sk, skb))
-		goto done;
+		if (!sock_queue_rcv_skb(sk, skb))
+			goto done;
+		break;
+
+	case L2CAP_MODE_ERTM:
+		if (!l2cap_ertm_data_channel(sk, lh, skb));
+			goto done;
+		break;
+
+	default:
+		BT_DBG("sk %p: bad mode 0x%2.2x", sk, l2cap_pi(sk)->mode);
+		break;
+	}
 
 drop:
 	kfree_skb(skb);
@@ -2704,7 +2955,7 @@ static void l2cap_recv_frame(struct l2cap_conn *conn, struct sk_buff *skb)
 		break;
 
 	default:
-		l2cap_data_channel(conn, cid, skb);
+		l2cap_data_channel(conn, cid, lh, skb);
 		break;
 	}
 }
@@ -2885,7 +3136,6 @@ static int l2cap_recv_acldata(struct hci_conn *hcon, struct sk_buff *skb, u16 fl
 		goto drop;
 
 	BT_DBG("conn %p len %d flags 0x%x", conn, skb->len, flags);
-
 	if (flags & ACL_START) {
 		struct l2cap_hdr *hdr;
 		int len;
-- 
1.6.3.3
