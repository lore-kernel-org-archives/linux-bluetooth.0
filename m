Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 8/8] Bluetooth: Move conn to struct l2cap_chan
Date: Fri, 15 Apr 2011 15:17:34 -0300
Message-Id: <1302891454-10165-9-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1302891454-10165-8-git-send-email-padovan@profusion.mobi>
References: <1302891454-10165-1-git-send-email-padovan@profusion.mobi>
 <1302891454-10165-2-git-send-email-padovan@profusion.mobi>
 <1302891454-10165-3-git-send-email-padovan@profusion.mobi>
 <1302891454-10165-4-git-send-email-padovan@profusion.mobi>
 <1302891454-10165-5-git-send-email-padovan@profusion.mobi>
 <1302891454-10165-6-git-send-email-padovan@profusion.mobi>
 <1302891454-10165-7-git-send-email-padovan@profusion.mobi>
 <1302891454-10165-8-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

There is no need to the socket deal directly with the channel, most of the
time it cares about the channel only.

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 include/net/bluetooth/l2cap.h |    7 ++-
 net/bluetooth/l2cap_core.c    |   92 ++++++++++++++++++-----------------------
 net/bluetooth/l2cap_sock.c    |   12 +++--
 net/bluetooth/rfcomm/core.c   |    8 ++-
 net/bluetooth/rfcomm/sock.c   |    5 +-
 5 files changed, 59 insertions(+), 65 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index fd199cd..3de90a9 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -284,6 +284,9 @@ struct srej_list {
 
 struct l2cap_chan {
 	struct sock *sk;
+
+	struct l2cap_conn	*conn;
+
 	__le16		psm;
 	__u16		dcid;
 	__u16		scid;
@@ -385,8 +388,6 @@ struct l2cap_conn {
 
 struct l2cap_pinfo {
 	struct bt_sock	bt;
-
-	struct l2cap_conn	*conn;
 	struct l2cap_chan	*chan;
 };
 
@@ -447,7 +448,7 @@ int l2cap_init_sockets(void);
 void l2cap_cleanup_sockets(void);
 
 void l2cap_send_cmd(struct l2cap_conn *conn, u8 ident, u8 code, u16 len, void *data);
-void __l2cap_connect_rsp_defer(struct sock *sk);
+void __l2cap_connect_rsp_defer(struct l2cap_chan *chan);
 int __l2cap_wait_ack(struct sock *sk);
 
 struct sk_buff *l2cap_create_connless_pdu(struct l2cap_chan *chan, struct msghdr *msg, size_t len);
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 3ff8840..8680161 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -169,7 +169,7 @@ static void __l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan)
 
 	conn->disc_reason = 0x13;
 
-	l2cap_pi(sk)->conn = conn;
+	chan->conn = conn;
 
 	if (sk->sk_type == SOCK_SEQPACKET || sk->sk_type == SOCK_STREAM) {
 		if (conn->hcon->type == LE_LINK) {
@@ -204,7 +204,7 @@ static void __l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan)
 void l2cap_chan_del(struct l2cap_chan *chan, int err)
 {
 	struct sock *sk = chan->sk;
-	struct l2cap_conn *conn = l2cap_pi(sk)->conn;
+	struct l2cap_conn *conn = chan->conn;
 	struct sock *parent = bt_sk(sk)->parent;
 
 	l2cap_sock_clear_timer(sk);
@@ -218,7 +218,7 @@ void l2cap_chan_del(struct l2cap_chan *chan, int err)
 		write_unlock_bh(&conn->chan_lock);
 		__sock_put(sk);
 
-		l2cap_pi(sk)->conn = NULL;
+		chan->conn = NULL;
 		hci_conn_put(conn->hcon);
 	}
 
@@ -296,7 +296,7 @@ static inline u8 l2cap_get_auth_type(struct l2cap_chan *chan)
 /* Service level security */
 static inline int l2cap_check_security(struct l2cap_chan *chan)
 {
-	struct l2cap_conn *conn = l2cap_pi(chan->sk)->conn;
+	struct l2cap_conn *conn = chan->conn;
 	__u8 auth_type;
 
 	auth_type = l2cap_get_auth_type(chan);
@@ -349,7 +349,7 @@ static inline void l2cap_send_sframe(struct l2cap_chan *chan, u16 control)
 	struct sk_buff *skb;
 	struct l2cap_hdr *lh;
 	struct l2cap_pinfo *pi = l2cap_pi(chan->sk);
-	struct l2cap_conn *conn = pi->conn;
+	struct l2cap_conn *conn = chan->conn;
 	struct sock *sk = (struct sock *)pi;
 	int count, hlen = L2CAP_HDR_SIZE + 2;
 	u8 flags;
@@ -394,7 +394,7 @@ static inline void l2cap_send_sframe(struct l2cap_chan *chan, u16 control)
 	else
 		flags = ACL_START;
 
-	hci_send_acl(pi->conn->hcon, skb, flags);
+	hci_send_acl(chan->conn->hcon, skb, flags);
 }
 
 static inline void l2cap_send_rr_or_rnr(struct l2cap_chan *chan, u16 control)
@@ -417,8 +417,7 @@ static inline int __l2cap_no_conn_pending(struct l2cap_chan *chan)
 
 static void l2cap_do_start(struct l2cap_chan *chan)
 {
-	struct sock *sk = chan->sk;
-	struct l2cap_conn *conn = l2cap_pi(sk)->conn;
+	struct l2cap_conn *conn = chan->conn;
 
 	if (conn->info_state & L2CAP_INFO_FEAT_MASK_REQ_SENT) {
 		if (!(conn->info_state & L2CAP_INFO_FEAT_MASK_REQ_DONE))
@@ -920,12 +919,13 @@ done:
 
 int __l2cap_wait_ack(struct sock *sk)
 {
+	struct l2cap_chan *chan = l2cap_pi(sk)->chan;
 	DECLARE_WAITQUEUE(wait, current);
 	int err = 0;
 	int timeo = HZ/5;
 
 	add_wait_queue(sk_sleep(sk), &wait);
-	while ((l2cap_pi(sk)->chan->unacked_frames > 0 && l2cap_pi(sk)->conn)) {
+	while ((chan->unacked_frames > 0 && chan->conn)) {
 		set_current_state(TASK_INTERRUPTIBLE);
 
 		if (!timeo)
@@ -958,7 +958,7 @@ static void l2cap_monitor_timeout(unsigned long arg)
 
 	bh_lock_sock(sk);
 	if (chan->retry_count >= chan->remote_max_tx) {
-		l2cap_send_disconn_req(l2cap_pi(sk)->conn, chan, ECONNABORTED);
+		l2cap_send_disconn_req(chan->conn, chan, ECONNABORTED);
 		bh_unlock_sock(sk);
 		return;
 	}
@@ -1008,8 +1008,7 @@ static void l2cap_drop_acked_frames(struct l2cap_chan *chan)
 
 void l2cap_do_send(struct l2cap_chan *chan, struct sk_buff *skb)
 {
-	struct sock *sk = chan->sk;
-	struct hci_conn *hcon = l2cap_pi(sk)->conn->hcon;
+	struct hci_conn *hcon = chan->conn->hcon;
 	u16 flags;
 
 	BT_DBG("chan %p, skb %p len %d", chan, skb, skb->len);
@@ -1045,8 +1044,6 @@ void l2cap_streaming_send(struct l2cap_chan *chan)
 
 static void l2cap_retransmit_one_frame(struct l2cap_chan *chan, u8 tx_seq)
 {
-	struct sock *sk = chan->sk;
-	struct l2cap_pinfo *pi = l2cap_pi(sk);
 	struct sk_buff *skb, *tx_skb;
 	u16 control, fcs;
 
@@ -1065,7 +1062,7 @@ static void l2cap_retransmit_one_frame(struct l2cap_chan *chan, u8 tx_seq)
 
 	if (chan->remote_max_tx &&
 			bt_cb(skb)->retries == chan->remote_max_tx) {
-		l2cap_send_disconn_req(pi->conn, chan, ECONNABORTED);
+		l2cap_send_disconn_req(chan->conn, chan, ECONNABORTED);
 		return;
 	}
 
@@ -1095,7 +1092,6 @@ int l2cap_ertm_send(struct l2cap_chan *chan)
 {
 	struct sk_buff *skb, *tx_skb;
 	struct sock *sk = chan->sk;
-	struct l2cap_pinfo *pi = l2cap_pi(sk);
 	u16 control, fcs;
 	int nsent = 0;
 
@@ -1106,7 +1102,7 @@ int l2cap_ertm_send(struct l2cap_chan *chan)
 
 		if (chan->remote_max_tx &&
 				bt_cb(skb)->retries == chan->remote_max_tx) {
-			l2cap_send_disconn_req(pi->conn, chan, ECONNABORTED);
+			l2cap_send_disconn_req(chan->conn, chan, ECONNABORTED);
 			break;
 		}
 
@@ -1202,7 +1198,7 @@ static void l2cap_send_srejtail(struct l2cap_chan *chan)
 
 static inline int l2cap_skbuff_fromiovec(struct sock *sk, struct msghdr *msg, int len, int count, struct sk_buff *skb)
 {
-	struct l2cap_conn *conn = l2cap_pi(sk)->conn;
+	struct l2cap_conn *conn = l2cap_pi(sk)->chan->conn;
 	struct sk_buff **frag;
 	int err, sent = 0;
 
@@ -1235,7 +1231,7 @@ static inline int l2cap_skbuff_fromiovec(struct sock *sk, struct msghdr *msg, in
 struct sk_buff *l2cap_create_connless_pdu(struct l2cap_chan *chan, struct msghdr *msg, size_t len)
 {
 	struct sock *sk = chan->sk;
-	struct l2cap_conn *conn = l2cap_pi(sk)->conn;
+	struct l2cap_conn *conn = chan->conn;
 	struct sk_buff *skb;
 	int err, count, hlen = L2CAP_HDR_SIZE + 2;
 	struct l2cap_hdr *lh;
@@ -1265,7 +1261,7 @@ struct sk_buff *l2cap_create_connless_pdu(struct l2cap_chan *chan, struct msghdr
 struct sk_buff *l2cap_create_basic_pdu(struct l2cap_chan *chan, struct msghdr *msg, size_t len)
 {
 	struct sock *sk = chan->sk;
-	struct l2cap_conn *conn = l2cap_pi(sk)->conn;
+	struct l2cap_conn *conn = chan->conn;
 	struct sk_buff *skb;
 	int err, count, hlen = L2CAP_HDR_SIZE;
 	struct l2cap_hdr *lh;
@@ -1294,7 +1290,7 @@ struct sk_buff *l2cap_create_basic_pdu(struct l2cap_chan *chan, struct msghdr *m
 struct sk_buff *l2cap_create_iframe_pdu(struct l2cap_chan *chan, struct msghdr *msg, size_t len, u16 control, u16 sdulen)
 {
 	struct sock *sk = chan->sk;
-	struct l2cap_conn *conn = l2cap_pi(sk)->conn;
+	struct l2cap_conn *conn = chan->conn;
 	struct sk_buff *skb;
 	int err, count, hlen = L2CAP_HDR_SIZE + 2;
 	struct l2cap_hdr *lh;
@@ -1610,7 +1606,6 @@ static inline __u8 l2cap_select_mode(__u8 mode, __u16 remote_feat_mask)
 
 static int l2cap_build_conf_req(struct l2cap_chan *chan, void *data)
 {
-	struct l2cap_pinfo *pi = l2cap_pi(chan->sk);
 	struct l2cap_conf_req *req = data;
 	struct l2cap_conf_rfc rfc = { .mode = chan->mode };
 	void *ptr = req->data;
@@ -1628,7 +1623,7 @@ static int l2cap_build_conf_req(struct l2cap_chan *chan, void *data)
 
 		/* fall through */
 	default:
-		chan->mode = l2cap_select_mode(rfc.mode, pi->conn->feat_mask);
+		chan->mode = l2cap_select_mode(rfc.mode, chan->conn->feat_mask);
 		break;
 	}
 
@@ -1638,8 +1633,8 @@ done:
 
 	switch (chan->mode) {
 	case L2CAP_MODE_BASIC:
-		if (!(pi->conn->feat_mask & L2CAP_FEAT_ERTM) &&
-				!(pi->conn->feat_mask & L2CAP_FEAT_STREAMING))
+		if (!(chan->conn->feat_mask & L2CAP_FEAT_ERTM) &&
+				!(chan->conn->feat_mask & L2CAP_FEAT_STREAMING))
 			break;
 
 		rfc.mode            = L2CAP_MODE_BASIC;
@@ -1660,13 +1655,13 @@ done:
 		rfc.retrans_timeout = 0;
 		rfc.monitor_timeout = 0;
 		rfc.max_pdu_size    = cpu_to_le16(L2CAP_DEFAULT_MAX_PDU_SIZE);
-		if (L2CAP_DEFAULT_MAX_PDU_SIZE > pi->conn->mtu - 10)
-			rfc.max_pdu_size = cpu_to_le16(pi->conn->mtu - 10);
+		if (L2CAP_DEFAULT_MAX_PDU_SIZE > chan->conn->mtu - 10)
+			rfc.max_pdu_size = cpu_to_le16(chan->conn->mtu - 10);
 
 		l2cap_add_conf_opt(&ptr, L2CAP_CONF_RFC, sizeof(rfc),
 							(unsigned long) &rfc);
 
-		if (!(pi->conn->feat_mask & L2CAP_FEAT_FCS))
+		if (!(chan->conn->feat_mask & L2CAP_FEAT_FCS))
 			break;
 
 		if (chan->fcs == L2CAP_FCS_NONE ||
@@ -1683,13 +1678,13 @@ done:
 		rfc.retrans_timeout = 0;
 		rfc.monitor_timeout = 0;
 		rfc.max_pdu_size    = cpu_to_le16(L2CAP_DEFAULT_MAX_PDU_SIZE);
-		if (L2CAP_DEFAULT_MAX_PDU_SIZE > pi->conn->mtu - 10)
-			rfc.max_pdu_size = cpu_to_le16(pi->conn->mtu - 10);
+		if (L2CAP_DEFAULT_MAX_PDU_SIZE > chan->conn->mtu - 10)
+			rfc.max_pdu_size = cpu_to_le16(chan->conn->mtu - 10);
 
 		l2cap_add_conf_opt(&ptr, L2CAP_CONF_RFC, sizeof(rfc),
 							(unsigned long) &rfc);
 
-		if (!(pi->conn->feat_mask & L2CAP_FEAT_FCS))
+		if (!(chan->conn->feat_mask & L2CAP_FEAT_FCS))
 			break;
 
 		if (chan->fcs == L2CAP_FCS_NONE ||
@@ -1708,7 +1703,6 @@ done:
 
 static int l2cap_parse_conf_req(struct l2cap_chan *chan, void *data)
 {
-	struct l2cap_pinfo *pi = l2cap_pi(chan->sk);
 	struct l2cap_conf_rsp *rsp = data;
 	void *ptr = rsp->data;
 	void *req = chan->conf_req;
@@ -1768,7 +1762,7 @@ static int l2cap_parse_conf_req(struct l2cap_chan *chan, void *data)
 	case L2CAP_MODE_ERTM:
 		if (!(chan->conf_state & L2CAP_CONF_STATE2_DEVICE)) {
 			chan->mode = l2cap_select_mode(rfc.mode,
-					pi->conn->feat_mask);
+					chan->conn->feat_mask);
 			break;
 		}
 
@@ -1813,8 +1807,8 @@ done:
 			chan->remote_tx_win = rfc.txwin_size;
 			chan->remote_max_tx = rfc.max_transmit;
 
-			if (le16_to_cpu(rfc.max_pdu_size) > pi->conn->mtu - 10)
-				rfc.max_pdu_size = cpu_to_le16(pi->conn->mtu - 10);
+			if (le16_to_cpu(rfc.max_pdu_size) > chan->conn->mtu - 10)
+				rfc.max_pdu_size = cpu_to_le16(chan->conn->mtu - 10);
 
 			chan->remote_mps = le16_to_cpu(rfc.max_pdu_size);
 
@@ -1831,8 +1825,8 @@ done:
 			break;
 
 		case L2CAP_MODE_STREAMING:
-			if (le16_to_cpu(rfc.max_pdu_size) > pi->conn->mtu - 10)
-				rfc.max_pdu_size = cpu_to_le16(pi->conn->mtu - 10);
+			if (le16_to_cpu(rfc.max_pdu_size) > chan->conn->mtu - 10)
+				rfc.max_pdu_size = cpu_to_le16(chan->conn->mtu - 10);
 
 			chan->remote_mps = le16_to_cpu(rfc.max_pdu_size);
 
@@ -1942,15 +1936,12 @@ static int l2cap_build_conf_rsp(struct l2cap_chan *chan, void *data, u16 result,
 	return ptr - data;
 }
 
-void __l2cap_connect_rsp_defer(struct sock *sk)
+void __l2cap_connect_rsp_defer(struct l2cap_chan *chan)
 {
 	struct l2cap_conn_rsp rsp;
-	struct l2cap_conn *conn = l2cap_pi(sk)->conn;
-	struct l2cap_chan *chan = l2cap_pi(sk)->chan;
+	struct l2cap_conn *conn = chan->conn;
 	u8 buf[128];
 
-	sk->sk_state = BT_CONFIG;
-
 	rsp.scid   = cpu_to_le16(chan->dcid);
 	rsp.dcid   = cpu_to_le16(chan->scid);
 	rsp.result = cpu_to_le16(L2CAP_CR_SUCCESS);
@@ -2855,7 +2846,6 @@ static int l2cap_add_to_srej_queue(struct l2cap_chan *chan, struct sk_buff *skb,
 
 static int l2cap_ertm_reassembly_sdu(struct l2cap_chan *chan, struct sk_buff *skb, u16 control)
 {
-	struct l2cap_pinfo *pi = l2cap_pi(chan->sk);
 	struct sk_buff *_skb;
 	int err;
 
@@ -2956,7 +2946,7 @@ drop:
 	chan->sdu = NULL;
 
 disconnect:
-	l2cap_send_disconn_req(pi->conn, chan, ECONNRESET);
+	l2cap_send_disconn_req(chan->conn, chan, ECONNRESET);
 	kfree_skb(skb);
 	return 0;
 }
@@ -3017,7 +3007,7 @@ static void l2cap_busy_work(struct work_struct *work)
 
 		if (n_tries++ > L2CAP_LOCAL_BUSY_TRIES) {
 			err = -EBUSY;
-			l2cap_send_disconn_req(l2cap_pi(sk)->conn, chan, EBUSY);
+			l2cap_send_disconn_req(chan->conn, chan, EBUSY);
 			break;
 		}
 
@@ -3235,7 +3225,6 @@ static void l2cap_send_srejframe(struct l2cap_chan *chan, u8 tx_seq)
 
 static inline int l2cap_data_channel_iframe(struct l2cap_chan *chan, u16 rx_control, struct sk_buff *skb)
 {
-	struct l2cap_pinfo *pi = l2cap_pi(chan->sk);
 	u8 tx_seq = __get_txseq(rx_control);
 	u8 req_seq = __get_reqseq(rx_control);
 	u8 sar = rx_control >> L2CAP_CTRL_SAR_SHIFT;
@@ -3266,7 +3255,7 @@ static inline int l2cap_data_channel_iframe(struct l2cap_chan *chan, u16 rx_cont
 
 	/* invalid tx_seq */
 	if (tx_seq_offset >= chan->tx_win) {
-		l2cap_send_disconn_req(pi->conn, chan, ECONNRESET);
+		l2cap_send_disconn_req(chan->conn, chan, ECONNRESET);
 		goto drop;
 	}
 
@@ -3533,7 +3522,6 @@ static inline int l2cap_data_channel_sframe(struct l2cap_chan *chan, u16 rx_cont
 static int l2cap_ertm_data_rcv(struct sock *sk, struct sk_buff *skb)
 {
 	struct l2cap_chan *chan = l2cap_pi(sk)->chan;
-	struct l2cap_pinfo *pi = l2cap_pi(sk);
 	u16 control;
 	u8 req_seq;
 	int len, next_tx_seq_offset, req_seq_offset;
@@ -3557,7 +3545,7 @@ static int l2cap_ertm_data_rcv(struct sock *sk, struct sk_buff *skb)
 		len -= 2;
 
 	if (len > chan->mps) {
-		l2cap_send_disconn_req(pi->conn, chan, ECONNRESET);
+		l2cap_send_disconn_req(chan->conn, chan, ECONNRESET);
 		goto drop;
 	}
 
@@ -3573,13 +3561,13 @@ static int l2cap_ertm_data_rcv(struct sock *sk, struct sk_buff *skb)
 
 	/* check for invalid req-seq */
 	if (req_seq_offset > next_tx_seq_offset) {
-		l2cap_send_disconn_req(pi->conn, chan, ECONNRESET);
+		l2cap_send_disconn_req(chan->conn, chan, ECONNRESET);
 		goto drop;
 	}
 
 	if (__is_iframe(control)) {
 		if (len < 0) {
-			l2cap_send_disconn_req(pi->conn, chan, ECONNRESET);
+			l2cap_send_disconn_req(chan->conn, chan, ECONNRESET);
 			goto drop;
 		}
 
@@ -3587,7 +3575,7 @@ static int l2cap_ertm_data_rcv(struct sock *sk, struct sk_buff *skb)
 	} else {
 		if (len != 0) {
 			BT_ERR("%d", len);
-			l2cap_send_disconn_req(pi->conn, chan, ECONNRESET);
+			l2cap_send_disconn_req(chan->conn, chan, ECONNRESET);
 			goto drop;
 		}
 
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index f5a2773..61d93f6 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -455,8 +455,8 @@ static int l2cap_sock_getsockopt_old(struct socket *sock, int optname, char __us
 			break;
 		}
 
-		cinfo.hci_handle = l2cap_pi(sk)->conn->hcon->handle;
-		memcpy(cinfo.dev_class, l2cap_pi(sk)->conn->hcon->dev_class, 3);
+		cinfo.hci_handle = chan->conn->hcon->handle;
+		memcpy(cinfo.dev_class, chan->conn->hcon->dev_class, 3);
 
 		len = min_t(unsigned int, len, sizeof(cinfo));
 		if (copy_to_user(optval, (char *) &cinfo, len))
@@ -690,7 +690,7 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname, ch
 		}
 
 		if (opt == BT_FLUSHABLE_OFF) {
-			struct l2cap_conn *conn = l2cap_pi(sk)->conn;
+			struct l2cap_conn *conn = chan->conn;
 			/* proceed futher only when we have l2cap_conn and
 			   No Flush support in the LM */
 			if (!conn || !lmp_no_flush_capable(conn->hcon->hdev)) {
@@ -823,7 +823,9 @@ static int l2cap_sock_recvmsg(struct kiocb *iocb, struct socket *sock, struct ms
 	lock_sock(sk);
 
 	if (sk->sk_state == BT_CONNECT2 && bt_sk(sk)->defer_setup) {
-		__l2cap_connect_rsp_defer(sk);
+		sk->sk_state = BT_CONFIG;
+
+		__l2cap_connect_rsp_defer(l2cap_pi(sk)->chan);
 		release_sock(sk);
 		return 0;
 	}
@@ -878,8 +880,8 @@ static void l2cap_sock_cleanup_listen(struct sock *parent)
 
 void __l2cap_sock_close(struct sock *sk, int reason)
 {
-	struct l2cap_conn *conn = l2cap_pi(sk)->conn;
 	struct l2cap_chan *chan = l2cap_pi(sk)->chan;
+	struct l2cap_conn *conn = chan->conn;
 
 	BT_DBG("sk %p state %d socket %p", sk, sk->sk_state, sk->sk_socket);
 
diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index fdd8f5a..121a5c1 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -232,6 +232,8 @@ static int rfcomm_l2sock_create(struct socket **sock)
 static inline int rfcomm_check_security(struct rfcomm_dlc *d)
 {
 	struct sock *sk = d->session->sock->sk;
+	struct l2cap_conn *conn = l2cap_pi(sk)->chan->conn;
+
 	__u8 auth_type;
 
 	switch (d->sec_level) {
@@ -246,8 +248,7 @@ static inline int rfcomm_check_security(struct rfcomm_dlc *d)
 		break;
 	}
 
-	return hci_conn_security(l2cap_pi(sk)->conn->hcon, d->sec_level,
-								auth_type);
+	return hci_conn_security(conn->hcon, d->sec_level, auth_type);
 }
 
 static void rfcomm_session_timeout(unsigned long arg)
@@ -1241,6 +1242,7 @@ static int rfcomm_recv_disc(struct rfcomm_session *s, u8 dlci)
 void rfcomm_dlc_accept(struct rfcomm_dlc *d)
 {
 	struct sock *sk = d->session->sock->sk;
+	struct l2cap_conn *conn = l2cap_pi(sk)->chan->conn;
 
 	BT_DBG("dlc %p", d);
 
@@ -1254,7 +1256,7 @@ void rfcomm_dlc_accept(struct rfcomm_dlc *d)
 	rfcomm_dlc_unlock(d);
 
 	if (d->role_switch)
-		hci_conn_switch_role(l2cap_pi(sk)->conn->hcon, 0x00);
+		hci_conn_switch_role(conn->hcon, 0x00);
 
 	rfcomm_send_msc(d->session, 1, d->dlci, d->v24_sig);
 }
diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
index 66cc1f0..386cfaf 100644
--- a/net/bluetooth/rfcomm/sock.c
+++ b/net/bluetooth/rfcomm/sock.c
@@ -743,6 +743,7 @@ static int rfcomm_sock_getsockopt_old(struct socket *sock, int optname, char __u
 	struct sock *sk = sock->sk;
 	struct sock *l2cap_sk;
 	struct rfcomm_conninfo cinfo;
+	struct l2cap_conn *conn = l2cap_pi(sk)->chan->conn;
 	int len, err = 0;
 	u32 opt;
 
@@ -787,8 +788,8 @@ static int rfcomm_sock_getsockopt_old(struct socket *sock, int optname, char __u
 
 		l2cap_sk = rfcomm_pi(sk)->dlc->session->sock->sk;
 
-		cinfo.hci_handle = l2cap_pi(l2cap_sk)->conn->hcon->handle;
-		memcpy(cinfo.dev_class, l2cap_pi(l2cap_sk)->conn->hcon->dev_class, 3);
+		cinfo.hci_handle = conn->hcon->handle;
+		memcpy(cinfo.dev_class, conn->hcon->dev_class, 3);
 
 		len = min_t(unsigned int, len, sizeof(cinfo));
 		if (copy_to_user(optval, (char *) &cinfo, len))
-- 
1.7.5.rc1

