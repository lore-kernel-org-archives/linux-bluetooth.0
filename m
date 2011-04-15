Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 5/8] Bluetooth: Move more vars to struct l2cap_chan
Date: Fri, 15 Apr 2011 15:17:31 -0300
Message-Id: <1302891454-10165-6-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1302891454-10165-5-git-send-email-padovan@profusion.mobi>
References: <1302891454-10165-1-git-send-email-padovan@profusion.mobi>
 <1302891454-10165-2-git-send-email-padovan@profusion.mobi>
 <1302891454-10165-3-git-send-email-padovan@profusion.mobi>
 <1302891454-10165-4-git-send-email-padovan@profusion.mobi>
 <1302891454-10165-5-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In this commit all ERTM and Streaming Mode specific vars.

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 include/net/bluetooth/l2cap.h |   18 ++++----
 net/bluetooth/l2cap_core.c    |  100 ++++++++++++++++++++--------------------
 net/bluetooth/l2cap_sock.c    |   33 +++++++-------
 net/bluetooth/rfcomm/core.c   |    2 +-
 4 files changed, 77 insertions(+), 76 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 684deee..02db902 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -297,6 +297,14 @@ struct l2cap_chan {
 	__u8		num_conf_req;
 	__u8		num_conf_rsp;
 
+	__u8		fcs;
+
+	__u8		tx_win;
+	__u8		max_tx;
+	__u16		retrans_timeout;
+	__u16		monitor_timeout;
+	__u16		mps;
+
 	__u8		conf_state;
 	__u16		conn_state;
 
@@ -376,14 +384,6 @@ struct l2cap_pinfo {
 	__u16		flush_to;
 	__u8		mode;
 
-	__u8		fcs;
-
-	__u8		tx_win;
-	__u8		max_tx;
-	__u16		retrans_timeout;
-	__u16		monitor_timeout;
-	__u16		mps;
-
 	__le16		sport;
 
 	struct l2cap_conn	*conn;
@@ -452,7 +452,7 @@ int __l2cap_wait_ack(struct sock *sk);
 
 struct sk_buff *l2cap_create_connless_pdu(struct sock *sk, struct msghdr *msg, size_t len);
 struct sk_buff *l2cap_create_basic_pdu(struct sock *sk, struct msghdr *msg, size_t len);
-struct sk_buff *l2cap_create_iframe_pdu(struct sock *sk, struct msghdr *msg, size_t len, u16 control, u16 sdulen);
+struct sk_buff *l2cap_create_iframe_pdu(struct l2cap_chan *chan, struct msghdr *msg, size_t len, u16 control, u16 sdulen);
 int l2cap_sar_segment_sdu(struct l2cap_chan *chan, struct msghdr *msg, size_t len);
 void l2cap_do_send(struct l2cap_chan *chan, struct sk_buff *skb);
 void l2cap_streaming_send(struct l2cap_chan *chan);
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index eca9c9a..5ca6c15 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -359,7 +359,7 @@ static inline void l2cap_send_sframe(struct l2cap_chan *chan, u16 control)
 	if (sk->sk_state != BT_CONNECTED)
 		return;
 
-	if (pi->fcs == L2CAP_FCS_CRC16)
+	if (chan->fcs == L2CAP_FCS_CRC16)
 		hlen += 2;
 
 	BT_DBG("chan %p, control 0x%2.2x", chan, control);
@@ -386,7 +386,7 @@ static inline void l2cap_send_sframe(struct l2cap_chan *chan, u16 control)
 	lh->cid = cpu_to_le16(pi->dcid);
 	put_unaligned_le16(control, skb_put(skb, 2));
 
-	if (pi->fcs == L2CAP_FCS_CRC16) {
+	if (chan->fcs == L2CAP_FCS_CRC16) {
 		u16 fcs = crc16(0, (u8 *)lh, count - 2);
 		put_unaligned_le16(fcs, skb_put(skb, 2));
 	}
@@ -1022,9 +1022,7 @@ void l2cap_do_send(struct l2cap_chan *chan, struct sk_buff *skb)
 
 void l2cap_streaming_send(struct l2cap_chan *chan)
 {
-	struct sock *sk = chan->sk;
 	struct sk_buff *skb;
-	struct l2cap_pinfo *pi = l2cap_pi(sk);
 	u16 control, fcs;
 
 	while ((skb = skb_dequeue(&chan->tx_q))) {
@@ -1032,7 +1030,7 @@ void l2cap_streaming_send(struct l2cap_chan *chan)
 		control |= chan->next_tx_seq << L2CAP_CTRL_TXSEQ_SHIFT;
 		put_unaligned_le16(control, skb->data + L2CAP_HDR_SIZE);
 
-		if (pi->fcs == L2CAP_FCS_CRC16) {
+		if (chan->fcs == L2CAP_FCS_CRC16) {
 			fcs = crc16(0, (u8 *)skb->data, skb->len - 2);
 			put_unaligned_le16(fcs, skb->data + skb->len - 2);
 		}
@@ -1083,7 +1081,7 @@ static void l2cap_retransmit_one_frame(struct l2cap_chan *chan, u8 tx_seq)
 
 	put_unaligned_le16(control, tx_skb->data + L2CAP_HDR_SIZE);
 
-	if (pi->fcs == L2CAP_FCS_CRC16) {
+	if (chan->fcs == L2CAP_FCS_CRC16) {
 		fcs = crc16(0, (u8 *)tx_skb->data, tx_skb->len - 2);
 		put_unaligned_le16(fcs, tx_skb->data + tx_skb->len - 2);
 	}
@@ -1126,7 +1124,7 @@ int l2cap_ertm_send(struct l2cap_chan *chan)
 		put_unaligned_le16(control, tx_skb->data + L2CAP_HDR_SIZE);
 
 
-		if (pi->fcs == L2CAP_FCS_CRC16) {
+		if (chan->fcs == L2CAP_FCS_CRC16) {
 			fcs = crc16(0, (u8 *)skb->data, tx_skb->len - 2);
 			put_unaligned_le16(fcs, skb->data + tx_skb->len - 2);
 		}
@@ -1289,8 +1287,9 @@ struct sk_buff *l2cap_create_basic_pdu(struct sock *sk, struct msghdr *msg, size
 	return skb;
 }
 
-struct sk_buff *l2cap_create_iframe_pdu(struct sock *sk, struct msghdr *msg, size_t len, u16 control, u16 sdulen)
+struct sk_buff *l2cap_create_iframe_pdu(struct l2cap_chan *chan, struct msghdr *msg, size_t len, u16 control, u16 sdulen)
 {
+	struct sock *sk = chan->sk;
 	struct l2cap_conn *conn = l2cap_pi(sk)->conn;
 	struct sk_buff *skb;
 	int err, count, hlen = L2CAP_HDR_SIZE + 2;
@@ -1304,7 +1303,7 @@ struct sk_buff *l2cap_create_iframe_pdu(struct sock *sk, struct msghdr *msg, siz
 	if (sdulen)
 		hlen += 2;
 
-	if (l2cap_pi(sk)->fcs == L2CAP_FCS_CRC16)
+	if (chan->fcs == L2CAP_FCS_CRC16)
 		hlen += 2;
 
 	count = min_t(unsigned int, (conn->mtu - hlen), len);
@@ -1327,7 +1326,7 @@ struct sk_buff *l2cap_create_iframe_pdu(struct sock *sk, struct msghdr *msg, siz
 		return ERR_PTR(err);
 	}
 
-	if (l2cap_pi(sk)->fcs == L2CAP_FCS_CRC16)
+	if (chan->fcs == L2CAP_FCS_CRC16)
 		put_unaligned_le16(0, skb_put(skb, 2));
 
 	bt_cb(skb)->retries = 0;
@@ -1336,7 +1335,6 @@ struct sk_buff *l2cap_create_iframe_pdu(struct sock *sk, struct msghdr *msg, siz
 
 int l2cap_sar_segment_sdu(struct l2cap_chan *chan, struct msghdr *msg, size_t len)
 {
-	struct sock *sk = chan->sk;
 	struct sk_buff *skb;
 	struct sk_buff_head sar_queue;
 	u16 control;
@@ -1344,7 +1342,7 @@ int l2cap_sar_segment_sdu(struct l2cap_chan *chan, struct msghdr *msg, size_t le
 
 	skb_queue_head_init(&sar_queue);
 	control = L2CAP_SDU_START;
-	skb = l2cap_create_iframe_pdu(sk, msg, chan->remote_mps, control, len);
+	skb = l2cap_create_iframe_pdu(chan, msg, chan->remote_mps, control, len);
 	if (IS_ERR(skb))
 		return PTR_ERR(skb);
 
@@ -1363,7 +1361,7 @@ int l2cap_sar_segment_sdu(struct l2cap_chan *chan, struct msghdr *msg, size_t le
 			buflen = len;
 		}
 
-		skb = l2cap_create_iframe_pdu(sk, msg, buflen, control, 0);
+		skb = l2cap_create_iframe_pdu(chan, msg, buflen, control, 0);
 		if (IS_ERR(skb)) {
 			skb_queue_purge(&sar_queue);
 			return PTR_ERR(skb);
@@ -1653,8 +1651,8 @@ done:
 
 	case L2CAP_MODE_ERTM:
 		rfc.mode            = L2CAP_MODE_ERTM;
-		rfc.txwin_size      = pi->tx_win;
-		rfc.max_transmit    = pi->max_tx;
+		rfc.txwin_size      = chan->tx_win;
+		rfc.max_transmit    = chan->max_tx;
 		rfc.retrans_timeout = 0;
 		rfc.monitor_timeout = 0;
 		rfc.max_pdu_size    = cpu_to_le16(L2CAP_DEFAULT_MAX_PDU_SIZE);
@@ -1667,10 +1665,10 @@ done:
 		if (!(pi->conn->feat_mask & L2CAP_FEAT_FCS))
 			break;
 
-		if (pi->fcs == L2CAP_FCS_NONE ||
+		if (chan->fcs == L2CAP_FCS_NONE ||
 				chan->conf_state & L2CAP_CONF_NO_FCS_RECV) {
-			pi->fcs = L2CAP_FCS_NONE;
-			l2cap_add_conf_opt(&ptr, L2CAP_CONF_FCS, 1, pi->fcs);
+			chan->fcs = L2CAP_FCS_NONE;
+			l2cap_add_conf_opt(&ptr, L2CAP_CONF_FCS, 1, chan->fcs);
 		}
 		break;
 
@@ -1690,10 +1688,10 @@ done:
 		if (!(pi->conn->feat_mask & L2CAP_FEAT_FCS))
 			break;
 
-		if (pi->fcs == L2CAP_FCS_NONE ||
+		if (chan->fcs == L2CAP_FCS_NONE ||
 				chan->conf_state & L2CAP_CONF_NO_FCS_RECV) {
-			pi->fcs = L2CAP_FCS_NONE;
-			l2cap_add_conf_opt(&ptr, L2CAP_CONF_FCS, 1, pi->fcs);
+			chan->fcs = L2CAP_FCS_NONE;
+			l2cap_add_conf_opt(&ptr, L2CAP_CONF_FCS, 1, chan->fcs);
 		}
 		break;
 	}
@@ -1803,7 +1801,7 @@ done:
 
 		switch (rfc.mode) {
 		case L2CAP_MODE_BASIC:
-			pi->fcs = L2CAP_FCS_NONE;
+			chan->fcs = L2CAP_FCS_NONE;
 			chan->conf_state |= L2CAP_CONF_MODE_DONE;
 			break;
 
@@ -1897,7 +1895,7 @@ static int l2cap_parse_conf_rsp(struct l2cap_chan *chan, void *rsp, int len, voi
 							rfc.mode != pi->mode)
 				return -ECONNREFUSED;
 
-			pi->fcs = 0;
+			chan->fcs = 0;
 
 			l2cap_add_conf_opt(&ptr, L2CAP_CONF_RFC,
 					sizeof(rfc), (unsigned long) &rfc);
@@ -1913,12 +1911,12 @@ static int l2cap_parse_conf_rsp(struct l2cap_chan *chan, void *rsp, int len, voi
 	if (*result == L2CAP_CONF_SUCCESS) {
 		switch (rfc.mode) {
 		case L2CAP_MODE_ERTM:
-			pi->retrans_timeout = le16_to_cpu(rfc.retrans_timeout);
-			pi->monitor_timeout = le16_to_cpu(rfc.monitor_timeout);
-			pi->mps    = le16_to_cpu(rfc.max_pdu_size);
+			chan->retrans_timeout = le16_to_cpu(rfc.retrans_timeout);
+			chan->monitor_timeout = le16_to_cpu(rfc.monitor_timeout);
+			chan->mps    = le16_to_cpu(rfc.max_pdu_size);
 			break;
 		case L2CAP_MODE_STREAMING:
-			pi->mps    = le16_to_cpu(rfc.max_pdu_size);
+			chan->mps    = le16_to_cpu(rfc.max_pdu_size);
 		}
 	}
 
@@ -1967,14 +1965,14 @@ void __l2cap_connect_rsp_defer(struct sock *sk)
 	chan->num_conf_req++;
 }
 
-static void l2cap_conf_rfc_get(struct sock *sk, void *rsp, int len)
+static void l2cap_conf_rfc_get(struct l2cap_chan *chan, void *rsp, int len)
 {
-	struct l2cap_pinfo *pi = l2cap_pi(sk);
+	struct l2cap_pinfo *pi = l2cap_pi(chan->sk);
 	int type, olen;
 	unsigned long val;
 	struct l2cap_conf_rfc rfc;
 
-	BT_DBG("sk %p, rsp %p, len %d", sk, rsp, len);
+	BT_DBG("chan %p, rsp %p, len %d", chan, rsp, len);
 
 	if ((pi->mode != L2CAP_MODE_ERTM) && (pi->mode != L2CAP_MODE_STREAMING))
 		return;
@@ -1993,12 +1991,12 @@ static void l2cap_conf_rfc_get(struct sock *sk, void *rsp, int len)
 done:
 	switch (rfc.mode) {
 	case L2CAP_MODE_ERTM:
-		pi->retrans_timeout = le16_to_cpu(rfc.retrans_timeout);
-		pi->monitor_timeout = le16_to_cpu(rfc.monitor_timeout);
-		pi->mps    = le16_to_cpu(rfc.max_pdu_size);
+		chan->retrans_timeout = le16_to_cpu(rfc.retrans_timeout);
+		chan->monitor_timeout = le16_to_cpu(rfc.monitor_timeout);
+		chan->mps    = le16_to_cpu(rfc.max_pdu_size);
 		break;
 	case L2CAP_MODE_STREAMING:
-		pi->mps    = le16_to_cpu(rfc.max_pdu_size);
+		chan->mps    = le16_to_cpu(rfc.max_pdu_size);
 	}
 }
 
@@ -2226,15 +2224,17 @@ static inline int l2cap_connect_rsp(struct l2cap_conn *conn, struct l2cap_cmd_hd
 	return 0;
 }
 
-static inline void set_default_fcs(struct l2cap_pinfo *pi)
+static inline void set_default_fcs(struct l2cap_chan *chan)
 {
+	struct l2cap_pinfo *pi = l2cap_pi(chan->sk);
+
 	/* FCS is enabled only in ERTM or streaming mode, if one or both
 	 * sides request it.
 	 */
 	if (pi->mode != L2CAP_MODE_ERTM && pi->mode != L2CAP_MODE_STREAMING)
-		pi->fcs = L2CAP_FCS_NONE;
+		chan->fcs = L2CAP_FCS_NONE;
 	else if (!(pi->chan->conf_state & L2CAP_CONF_NO_FCS_RECV))
-		pi->fcs = L2CAP_FCS_CRC16;
+		chan->fcs = L2CAP_FCS_CRC16;
 }
 
 static inline int l2cap_config_req(struct l2cap_conn *conn, struct l2cap_cmd_hdr *cmd, u16 cmd_len, u8 *data)
@@ -2304,7 +2304,7 @@ static inline int l2cap_config_req(struct l2cap_conn *conn, struct l2cap_cmd_hdr
 		goto unlock;
 
 	if (chan->conf_state & L2CAP_CONF_INPUT_DONE) {
-		set_default_fcs(l2cap_pi(sk));
+		set_default_fcs(chan);
 
 		sk->sk_state = BT_CONNECTED;
 
@@ -2354,7 +2354,7 @@ static inline int l2cap_config_rsp(struct l2cap_conn *conn, struct l2cap_cmd_hdr
 
 	switch (result) {
 	case L2CAP_CONF_SUCCESS:
-		l2cap_conf_rfc_get(sk, rsp->data, len);
+		l2cap_conf_rfc_get(chan, rsp->data, len);
 		break;
 
 	case L2CAP_CONF_UNACCEPT:
@@ -2396,7 +2396,7 @@ static inline int l2cap_config_rsp(struct l2cap_conn *conn, struct l2cap_cmd_hdr
 	chan->conf_state |= L2CAP_CONF_INPUT_DONE;
 
 	if (chan->conf_state & L2CAP_CONF_OUTPUT_DONE) {
-		set_default_fcs(l2cap_pi(sk));
+		set_default_fcs(chan);
 
 		sk->sk_state = BT_CONNECTED;
 		chan->next_tx_seq = 0;
@@ -2768,12 +2768,12 @@ static inline void l2cap_sig_channel(struct l2cap_conn *conn,
 	kfree_skb(skb);
 }
 
-static int l2cap_check_fcs(struct l2cap_pinfo *pi,  struct sk_buff *skb)
+static int l2cap_check_fcs(struct l2cap_chan *chan,  struct sk_buff *skb)
 {
 	u16 our_fcs, rcv_fcs;
 	int hdr_size = L2CAP_HDR_SIZE + 2;
 
-	if (pi->fcs == L2CAP_FCS_CRC16) {
+	if (chan->fcs == L2CAP_FCS_CRC16) {
 		skb_trim(skb, skb->len - 2);
 		rcv_fcs = get_unaligned_le16(skb->data + skb->len);
 		our_fcs = crc16(0, skb->data - hdr_size, skb->len + hdr_size);
@@ -3240,7 +3240,7 @@ static inline int l2cap_data_channel_iframe(struct l2cap_chan *chan, u16 rx_cont
 	u8 req_seq = __get_reqseq(rx_control);
 	u8 sar = rx_control >> L2CAP_CTRL_SAR_SHIFT;
 	int tx_seq_offset, expected_tx_seq_offset;
-	int num_to_ack = (pi->tx_win/6) + 1;
+	int num_to_ack = (chan->tx_win/6) + 1;
 	int err = 0;
 
 	BT_DBG("chan %p len %d tx_seq %d rx_control 0x%4.4x", chan, skb->len,
@@ -3265,7 +3265,7 @@ static inline int l2cap_data_channel_iframe(struct l2cap_chan *chan, u16 rx_cont
 		tx_seq_offset += 64;
 
 	/* invalid tx_seq */
-	if (tx_seq_offset >= pi->tx_win) {
+	if (tx_seq_offset >= chan->tx_win) {
 		l2cap_send_disconn_req(pi->conn, chan, ECONNRESET);
 		goto drop;
 	}
@@ -3547,16 +3547,16 @@ static int l2cap_ertm_data_rcv(struct sock *sk, struct sk_buff *skb)
 	 * Receiver will miss it and start proper recovery
 	 * procedures and ask retransmission.
 	 */
-	if (l2cap_check_fcs(pi, skb))
+	if (l2cap_check_fcs(chan, skb))
 		goto drop;
 
 	if (__is_sar_start(control) && __is_iframe(control))
 		len -= 2;
 
-	if (pi->fcs == L2CAP_FCS_CRC16)
+	if (chan->fcs == L2CAP_FCS_CRC16)
 		len -= 2;
 
-	if (len > pi->mps) {
+	if (len > chan->mps) {
 		l2cap_send_disconn_req(pi->conn, chan, ECONNRESET);
 		goto drop;
 	}
@@ -3653,16 +3653,16 @@ static inline int l2cap_data_channel(struct l2cap_conn *conn, u16 cid, struct sk
 		skb_pull(skb, 2);
 		len = skb->len;
 
-		if (l2cap_check_fcs(pi, skb))
+		if (l2cap_check_fcs(chan, skb))
 			goto drop;
 
 		if (__is_sar_start(control))
 			len -= 2;
 
-		if (pi->fcs == L2CAP_FCS_CRC16)
+		if (chan->fcs == L2CAP_FCS_CRC16)
 			len -= 2;
 
-		if (len > pi->mps || len < 0 || __is_sframe(control))
+		if (len > chan->mps || len < 0 || __is_sframe(control))
 			goto drop;
 
 		tx_seq = __get_txseq(control);
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 6129556..4ba15b3 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -403,9 +403,9 @@ static int l2cap_sock_getsockopt_old(struct socket *sock, int optname, char __us
 		opts.omtu     = l2cap_pi(sk)->omtu;
 		opts.flush_to = l2cap_pi(sk)->flush_to;
 		opts.mode     = l2cap_pi(sk)->mode;
-		opts.fcs      = l2cap_pi(sk)->fcs;
-		opts.max_tx   = l2cap_pi(sk)->max_tx;
-		opts.txwin_size = (__u16)l2cap_pi(sk)->tx_win;
+		opts.fcs      = chan->fcs;
+		opts.max_tx   = chan->max_tx;
+		opts.txwin_size = (__u16)chan->tx_win;
 
 		len = min_t(unsigned int, len, sizeof(opts));
 		if (copy_to_user(optval, (char *) &opts, len))
@@ -551,9 +551,9 @@ static int l2cap_sock_setsockopt_old(struct socket *sock, int optname, char __us
 		opts.omtu     = l2cap_pi(sk)->omtu;
 		opts.flush_to = l2cap_pi(sk)->flush_to;
 		opts.mode     = l2cap_pi(sk)->mode;
-		opts.fcs      = l2cap_pi(sk)->fcs;
-		opts.max_tx   = l2cap_pi(sk)->max_tx;
-		opts.txwin_size = (__u16)l2cap_pi(sk)->tx_win;
+		opts.fcs      = chan->fcs;
+		opts.max_tx   = chan->max_tx;
+		opts.txwin_size = (__u16)chan->tx_win;
 
 		len = min_t(unsigned int, sizeof(opts), optlen);
 		if (copy_from_user((char *) &opts, optval, len)) {
@@ -583,9 +583,9 @@ static int l2cap_sock_setsockopt_old(struct socket *sock, int optname, char __us
 
 		l2cap_pi(sk)->imtu = opts.imtu;
 		l2cap_pi(sk)->omtu = opts.omtu;
-		l2cap_pi(sk)->fcs  = opts.fcs;
-		l2cap_pi(sk)->max_tx = opts.max_tx;
-		l2cap_pi(sk)->tx_win = (__u8)opts.txwin_size;
+		chan->fcs  = opts.fcs;
+		chan->max_tx = opts.max_tx;
+		chan->tx_win = (__u8)opts.txwin_size;
 		break;
 
 	case L2CAP_LM:
@@ -764,7 +764,8 @@ static int l2cap_sock_sendmsg(struct kiocb *iocb, struct socket *sock, struct ms
 		/* Entire SDU fits into one PDU */
 		if (len <= pi->chan->remote_mps) {
 			control = L2CAP_SDU_UNSEGMENTED;
-			skb = l2cap_create_iframe_pdu(sk, msg, len, control, 0);
+			skb = l2cap_create_iframe_pdu(pi->chan, msg, len,
+								control, 0);
 			if (IS_ERR(skb)) {
 				err = PTR_ERR(skb);
 				goto done;
@@ -998,9 +999,9 @@ void l2cap_sock_init(struct sock *sk, struct sock *parent)
 		pi->omtu = l2cap_pi(parent)->omtu;
 		chan->conf_state = pchan->conf_state;
 		pi->mode = l2cap_pi(parent)->mode;
-		pi->fcs  = l2cap_pi(parent)->fcs;
-		pi->max_tx = l2cap_pi(parent)->max_tx;
-		pi->tx_win = l2cap_pi(parent)->tx_win;
+		chan->fcs  = pchan->fcs;
+		chan->max_tx = pchan->max_tx;
+		chan->tx_win = pchan->tx_win;
 		chan->sec_level = pchan->sec_level;
 		chan->role_switch = pchan->role_switch;
 		chan->force_reliable = pchan->force_reliable;
@@ -1014,9 +1015,9 @@ void l2cap_sock_init(struct sock *sk, struct sock *parent)
 		} else {
 			pi->mode = L2CAP_MODE_BASIC;
 		}
-		pi->max_tx = L2CAP_DEFAULT_MAX_TX;
-		pi->fcs  = L2CAP_FCS_CRC16;
-		pi->tx_win = L2CAP_DEFAULT_TX_WINDOW;
+		chan->max_tx = L2CAP_DEFAULT_MAX_TX;
+		chan->fcs  = L2CAP_FCS_CRC16;
+		chan->tx_win = L2CAP_DEFAULT_TX_WINDOW;
 		chan->sec_level = BT_SECURITY_LOW;
 		chan->role_switch = 0;
 		chan->force_reliable = 0;
diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index c997393..4f728a4 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -711,7 +711,7 @@ static struct rfcomm_session *rfcomm_session_create(bdaddr_t *src,
 	sk = sock->sk;
 	lock_sock(sk);
 	l2cap_pi(sk)->imtu = l2cap_mtu;
-	l2cap_pi(sk)->sec_level = sec_level;
+	l2cap_pi(sk)->chan->sec_level = sec_level;
 	if (l2cap_ertm)
 		l2cap_pi(sk)->mode = L2CAP_MODE_ERTM;
 	release_sock(sk);
-- 
1.7.5.rc1

