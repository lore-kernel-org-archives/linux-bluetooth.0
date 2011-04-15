Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 6/8] Bluetooth: Move more channel info to struct l2cap_chan
Date: Fri, 15 Apr 2011 15:17:32 -0300
Message-Id: <1302891454-10165-7-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1302891454-10165-6-git-send-email-padovan@profusion.mobi>
References: <1302891454-10165-1-git-send-email-padovan@profusion.mobi>
 <1302891454-10165-2-git-send-email-padovan@profusion.mobi>
 <1302891454-10165-3-git-send-email-padovan@profusion.mobi>
 <1302891454-10165-4-git-send-email-padovan@profusion.mobi>
 <1302891454-10165-5-git-send-email-padovan@profusion.mobi>
 <1302891454-10165-6-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In this commit, omtu, imtu, flush_to, mode and sport. It also remove the
pi var from l2cap_sock_sendmsg().

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 include/net/bluetooth/l2cap.h |   14 +++---
 net/bluetooth/l2cap_core.c    |   97 +++++++++++++++++++--------------------
 net/bluetooth/l2cap_sock.c    |  100 ++++++++++++++++++++++-------------------
 net/bluetooth/rfcomm/core.c   |   11 +++--
 4 files changed, 115 insertions(+), 107 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 02db902..7522835 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -285,6 +285,13 @@ struct srej_list {
 struct l2cap_chan {
 	struct sock *sk;
 
+	__u16		imtu;
+	__u16		omtu;
+	__u16		flush_to;
+	__u8		mode;
+
+	__le16		sport;
+
 	__u8		sec_level;
 	__u8		role_switch;
 	__u8		force_reliable;
@@ -379,13 +386,6 @@ struct l2cap_pinfo {
 	__u16		dcid;
 	__u16		scid;
 
-	__u16		imtu;
-	__u16		omtu;
-	__u16		flush_to;
-	__u8		mode;
-
-	__le16		sport;
-
 	struct l2cap_conn	*conn;
 	struct l2cap_chan	*chan;
 };
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 5ca6c15..c267244 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -176,24 +176,24 @@ static void __l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan)
 	if (sk->sk_type == SOCK_SEQPACKET || sk->sk_type == SOCK_STREAM) {
 		if (conn->hcon->type == LE_LINK) {
 			/* LE connection */
-			l2cap_pi(sk)->omtu = L2CAP_LE_DEFAULT_MTU;
+			chan->omtu = L2CAP_LE_DEFAULT_MTU;
 			l2cap_pi(sk)->scid = L2CAP_CID_LE_DATA;
 			l2cap_pi(sk)->dcid = L2CAP_CID_LE_DATA;
 		} else {
 			/* Alloc CID for connection-oriented socket */
 			l2cap_pi(sk)->scid = l2cap_alloc_cid(conn);
-			l2cap_pi(sk)->omtu = L2CAP_DEFAULT_MTU;
+			chan->omtu = L2CAP_DEFAULT_MTU;
 		}
 	} else if (sk->sk_type == SOCK_DGRAM) {
 		/* Connectionless socket */
 		l2cap_pi(sk)->scid = L2CAP_CID_CONN_LESS;
 		l2cap_pi(sk)->dcid = L2CAP_CID_CONN_LESS;
-		l2cap_pi(sk)->omtu = L2CAP_DEFAULT_MTU;
+		chan->omtu = L2CAP_DEFAULT_MTU;
 	} else {
 		/* Raw socket can send/recv signalling messages only */
 		l2cap_pi(sk)->scid = L2CAP_CID_SIGNALING;
 		l2cap_pi(sk)->dcid = L2CAP_CID_SIGNALING;
-		l2cap_pi(sk)->omtu = L2CAP_DEFAULT_MTU;
+		chan->omtu = L2CAP_DEFAULT_MTU;
 	}
 
 	sock_hold(sk);
@@ -242,7 +242,7 @@ void l2cap_chan_del(struct l2cap_chan *chan, int err)
 
 	skb_queue_purge(&chan->tx_q);
 
-	if (l2cap_pi(sk)->mode == L2CAP_MODE_ERTM) {
+	if (chan->mode == L2CAP_MODE_ERTM) {
 		struct srej_list *l, *tmp;
 
 		del_timer(&chan->retrans_timer);
@@ -479,7 +479,7 @@ void l2cap_send_disconn_req(struct l2cap_conn *conn, struct l2cap_chan *chan, in
 
 	sk = chan->sk;
 
-	if (l2cap_pi(sk)->mode == L2CAP_MODE_ERTM) {
+	if (chan->mode == L2CAP_MODE_ERTM) {
 		del_timer(&chan->retrans_timer);
 		del_timer(&chan->monitor_timer);
 		del_timer(&chan->ack_timer);
@@ -523,7 +523,7 @@ static void l2cap_conn_start(struct l2cap_conn *conn)
 				continue;
 			}
 
-			if (!l2cap_mode_supported(l2cap_pi(sk)->mode,
+			if (!l2cap_mode_supported(chan->mode,
 					conn->feat_mask)
 					&& chan->conf_state &
 					L2CAP_CONF_STATE2_DEVICE) {
@@ -1608,7 +1608,7 @@ static int l2cap_build_conf_req(struct l2cap_chan *chan, void *data)
 {
 	struct l2cap_pinfo *pi = l2cap_pi(chan->sk);
 	struct l2cap_conf_req *req = data;
-	struct l2cap_conf_rfc rfc = { .mode = pi->mode };
+	struct l2cap_conf_rfc rfc = { .mode = chan->mode };
 	void *ptr = req->data;
 
 	BT_DBG("chan %p", chan);
@@ -1616,7 +1616,7 @@ static int l2cap_build_conf_req(struct l2cap_chan *chan, void *data)
 	if (chan->num_conf_req || chan->num_conf_rsp)
 		goto done;
 
-	switch (pi->mode) {
+	switch (chan->mode) {
 	case L2CAP_MODE_STREAMING:
 	case L2CAP_MODE_ERTM:
 		if (chan->conf_state & L2CAP_CONF_STATE2_DEVICE)
@@ -1624,15 +1624,15 @@ static int l2cap_build_conf_req(struct l2cap_chan *chan, void *data)
 
 		/* fall through */
 	default:
-		pi->mode = l2cap_select_mode(rfc.mode, pi->conn->feat_mask);
+		chan->mode = l2cap_select_mode(rfc.mode, pi->conn->feat_mask);
 		break;
 	}
 
 done:
-	if (pi->imtu != L2CAP_DEFAULT_MTU)
-		l2cap_add_conf_opt(&ptr, L2CAP_CONF_MTU, 2, pi->imtu);
+	if (chan->imtu != L2CAP_DEFAULT_MTU)
+		l2cap_add_conf_opt(&ptr, L2CAP_CONF_MTU, 2, chan->imtu);
 
-	switch (pi->mode) {
+	switch (chan->mode) {
 	case L2CAP_MODE_BASIC:
 		if (!(pi->conn->feat_mask & L2CAP_FEAT_ERTM) &&
 				!(pi->conn->feat_mask & L2CAP_FEAT_STREAMING))
@@ -1729,7 +1729,7 @@ static int l2cap_parse_conf_req(struct l2cap_chan *chan, void *data)
 			break;
 
 		case L2CAP_CONF_FLUSH_TO:
-			pi->flush_to = val;
+			chan->flush_to = val;
 			break;
 
 		case L2CAP_CONF_QOS:
@@ -1759,25 +1759,25 @@ static int l2cap_parse_conf_req(struct l2cap_chan *chan, void *data)
 	if (chan->num_conf_rsp || chan->num_conf_req > 1)
 		goto done;
 
-	switch (pi->mode) {
+	switch (chan->mode) {
 	case L2CAP_MODE_STREAMING:
 	case L2CAP_MODE_ERTM:
 		if (!(chan->conf_state & L2CAP_CONF_STATE2_DEVICE)) {
-			pi->mode = l2cap_select_mode(rfc.mode,
+			chan->mode = l2cap_select_mode(rfc.mode,
 					pi->conn->feat_mask);
 			break;
 		}
 
-		if (pi->mode != rfc.mode)
+		if (chan->mode != rfc.mode)
 			return -ECONNREFUSED;
 
 		break;
 	}
 
 done:
-	if (pi->mode != rfc.mode) {
+	if (chan->mode != rfc.mode) {
 		result = L2CAP_CONF_UNACCEPT;
-		rfc.mode = pi->mode;
+		rfc.mode = chan->mode;
 
 		if (chan->num_conf_rsp == 1)
 			return -ECONNREFUSED;
@@ -1794,10 +1794,10 @@ done:
 		if (mtu < L2CAP_DEFAULT_MIN_MTU)
 			result = L2CAP_CONF_UNACCEPT;
 		else {
-			pi->omtu = mtu;
+			chan->omtu = mtu;
 			chan->conf_state |= L2CAP_CONF_MTU_DONE;
 		}
-		l2cap_add_conf_opt(&ptr, L2CAP_CONF_MTU, 2, pi->omtu);
+		l2cap_add_conf_opt(&ptr, L2CAP_CONF_MTU, 2, chan->omtu);
 
 		switch (rfc.mode) {
 		case L2CAP_MODE_BASIC:
@@ -1843,7 +1843,7 @@ done:
 			result = L2CAP_CONF_UNACCEPT;
 
 			memset(&rfc, 0, sizeof(rfc));
-			rfc.mode = pi->mode;
+			rfc.mode = chan->mode;
 		}
 
 		if (result == L2CAP_CONF_SUCCESS)
@@ -1875,16 +1875,16 @@ static int l2cap_parse_conf_rsp(struct l2cap_chan *chan, void *rsp, int len, voi
 		case L2CAP_CONF_MTU:
 			if (val < L2CAP_DEFAULT_MIN_MTU) {
 				*result = L2CAP_CONF_UNACCEPT;
-				pi->imtu = L2CAP_DEFAULT_MIN_MTU;
+				chan->imtu = L2CAP_DEFAULT_MIN_MTU;
 			} else
-				pi->imtu = val;
-			l2cap_add_conf_opt(&ptr, L2CAP_CONF_MTU, 2, pi->imtu);
+				chan->imtu = val;
+			l2cap_add_conf_opt(&ptr, L2CAP_CONF_MTU, 2, chan->imtu);
 			break;
 
 		case L2CAP_CONF_FLUSH_TO:
-			pi->flush_to = val;
+			chan->flush_to = val;
 			l2cap_add_conf_opt(&ptr, L2CAP_CONF_FLUSH_TO,
-							2, pi->flush_to);
+							2, chan->flush_to);
 			break;
 
 		case L2CAP_CONF_RFC:
@@ -1892,7 +1892,7 @@ static int l2cap_parse_conf_rsp(struct l2cap_chan *chan, void *rsp, int len, voi
 				memcpy(&rfc, (void *)val, olen);
 
 			if ((chan->conf_state & L2CAP_CONF_STATE2_DEVICE) &&
-							rfc.mode != pi->mode)
+							rfc.mode != chan->mode)
 				return -ECONNREFUSED;
 
 			chan->fcs = 0;
@@ -1903,10 +1903,10 @@ static int l2cap_parse_conf_rsp(struct l2cap_chan *chan, void *rsp, int len, voi
 		}
 	}
 
-	if (pi->mode == L2CAP_MODE_BASIC && pi->mode != rfc.mode)
+	if (chan->mode == L2CAP_MODE_BASIC && chan->mode != rfc.mode)
 		return -ECONNREFUSED;
 
-	pi->mode = rfc.mode;
+	chan->mode = rfc.mode;
 
 	if (*result == L2CAP_CONF_SUCCESS) {
 		switch (rfc.mode) {
@@ -1967,14 +1967,13 @@ void __l2cap_connect_rsp_defer(struct sock *sk)
 
 static void l2cap_conf_rfc_get(struct l2cap_chan *chan, void *rsp, int len)
 {
-	struct l2cap_pinfo *pi = l2cap_pi(chan->sk);
 	int type, olen;
 	unsigned long val;
 	struct l2cap_conf_rfc rfc;
 
 	BT_DBG("chan %p, rsp %p, len %d", chan, rsp, len);
 
-	if ((pi->mode != L2CAP_MODE_ERTM) && (pi->mode != L2CAP_MODE_STREAMING))
+	if ((chan->mode != L2CAP_MODE_ERTM) && (chan->mode != L2CAP_MODE_STREAMING))
 		return;
 
 	while (len >= L2CAP_CONF_OPT_SIZE) {
@@ -2231,7 +2230,7 @@ static inline void set_default_fcs(struct l2cap_chan *chan)
 	/* FCS is enabled only in ERTM or streaming mode, if one or both
 	 * sides request it.
 	 */
-	if (pi->mode != L2CAP_MODE_ERTM && pi->mode != L2CAP_MODE_STREAMING)
+	if (chan->mode != L2CAP_MODE_ERTM && chan->mode != L2CAP_MODE_STREAMING)
 		chan->fcs = L2CAP_FCS_NONE;
 	else if (!(pi->chan->conf_state & L2CAP_CONF_NO_FCS_RECV))
 		chan->fcs = L2CAP_FCS_CRC16;
@@ -2311,7 +2310,7 @@ static inline int l2cap_config_req(struct l2cap_conn *conn, struct l2cap_cmd_hdr
 		chan->next_tx_seq = 0;
 		chan->expected_tx_seq = 0;
 		skb_queue_head_init(&chan->tx_q);
-		if (l2cap_pi(sk)->mode == L2CAP_MODE_ERTM)
+		if (chan->mode == L2CAP_MODE_ERTM)
 			l2cap_ertm_init(chan);
 
 		l2cap_chan_ready(sk);
@@ -2402,7 +2401,7 @@ static inline int l2cap_config_rsp(struct l2cap_conn *conn, struct l2cap_cmd_hdr
 		chan->next_tx_seq = 0;
 		chan->expected_tx_seq = 0;
 		skb_queue_head_init(&chan->tx_q);
-		if (l2cap_pi(sk)->mode ==  L2CAP_MODE_ERTM)
+		if (chan->mode ==  L2CAP_MODE_ERTM)
 			l2cap_ertm_init(chan);
 
 		l2cap_chan_ready(sk);
@@ -2875,7 +2874,7 @@ static int l2cap_ertm_reassembly_sdu(struct l2cap_chan *chan, struct sk_buff *sk
 
 		chan->sdu_len = get_unaligned_le16(skb->data);
 
-		if (chan->sdu_len > pi->imtu)
+		if (chan->sdu_len > chan->imtu)
 			goto disconnect;
 
 		chan->sdu = bt_skb_alloc(chan->sdu_len, GFP_ATOMIC);
@@ -2918,7 +2917,7 @@ static int l2cap_ertm_reassembly_sdu(struct l2cap_chan *chan, struct sk_buff *sk
 		if (!(chan->conn_state & L2CAP_CONN_SAR_RETRY)) {
 			chan->partial_sdu_len += skb->len;
 
-			if (chan->partial_sdu_len > pi->imtu)
+			if (chan->partial_sdu_len > chan->imtu)
 				goto drop;
 
 			if (chan->partial_sdu_len != chan->sdu_len)
@@ -3086,7 +3085,6 @@ static int l2cap_push_rx_skb(struct l2cap_chan *chan, struct sk_buff *skb, u16 c
 
 static int l2cap_streaming_reassembly_sdu(struct l2cap_chan *chan, struct sk_buff *skb, u16 control)
 {
-	struct l2cap_pinfo *pi = l2cap_pi(chan->sk);
 	struct sk_buff *_skb;
 	int err = -EINVAL;
 
@@ -3117,7 +3115,7 @@ static int l2cap_streaming_reassembly_sdu(struct l2cap_chan *chan, struct sk_buf
 		chan->sdu_len = get_unaligned_le16(skb->data);
 		skb_pull(skb, 2);
 
-		if (chan->sdu_len > pi->imtu) {
+		if (chan->sdu_len > chan->imtu) {
 			err = -EMSGSIZE;
 			break;
 		}
@@ -3158,7 +3156,7 @@ static int l2cap_streaming_reassembly_sdu(struct l2cap_chan *chan, struct sk_buf
 		chan->conn_state &= ~L2CAP_CONN_SAR_SDU;
 		chan->partial_sdu_len += skb->len;
 
-		if (chan->partial_sdu_len > pi->imtu)
+		if (chan->partial_sdu_len > chan->imtu)
 			goto drop;
 
 		if (chan->partial_sdu_len == chan->sdu_len) {
@@ -3624,14 +3622,14 @@ static inline int l2cap_data_channel(struct l2cap_conn *conn, u16 cid, struct sk
 	if (sk->sk_state != BT_CONNECTED)
 		goto drop;
 
-	switch (pi->mode) {
+	switch (chan->mode) {
 	case L2CAP_MODE_BASIC:
 		/* If socket recv buffers overflows we drop data here
 		 * which is *bad* because L2CAP has to be reliable.
 		 * But we don't have any other choice. L2CAP doesn't
 		 * provide flow control mechanism. */
 
-		if (pi->imtu < skb->len)
+		if (chan->imtu < skb->len)
 			goto drop;
 
 		if (!sock_queue_rcv_skb(sk, skb))
@@ -3677,7 +3675,7 @@ static inline int l2cap_data_channel(struct l2cap_conn *conn, u16 cid, struct sk
 		goto done;
 
 	default:
-		BT_DBG("chan %p: bad mode 0x%2.2x", chan, pi->mode);
+		BT_DBG("chan %p: bad mode 0x%2.2x", chan, chan->mode);
 		break;
 	}
 
@@ -3706,7 +3704,7 @@ static inline int l2cap_conless_channel(struct l2cap_conn *conn, __le16 psm, str
 	if (sk->sk_state != BT_BOUND && sk->sk_state != BT_CONNECTED)
 		goto drop;
 
-	if (l2cap_pi(sk)->imtu < skb->len)
+	if (l2cap_pi(sk)->chan->imtu < skb->len)
 		goto drop;
 
 	if (!sock_queue_rcv_skb(sk, skb))
@@ -3736,7 +3734,7 @@ static inline int l2cap_att_channel(struct l2cap_conn *conn, __le16 cid, struct
 	if (sk->sk_state != BT_BOUND && sk->sk_state != BT_CONNECTED)
 		goto drop;
 
-	if (l2cap_pi(sk)->imtu < skb->len)
+	if (l2cap_pi(sk)->chan->imtu < skb->len)
 		goto drop;
 
 	if (!sock_queue_rcv_skb(sk, skb))
@@ -4019,10 +4017,10 @@ static int l2cap_recv_acldata(struct hci_conn *hcon, struct sk_buff *skb, u16 fl
 		if (chan && chan->sk) {
 			struct sock *sk = chan->sk;
 
-			if (l2cap_pi(sk)->imtu < len - L2CAP_HDR_SIZE) {
+			if (chan->imtu < len - L2CAP_HDR_SIZE) {
 				BT_ERR("Frame exceeding recv MTU (len %d, "
 							"MTU %d)", len,
-							l2cap_pi(sk)->imtu);
+							chan->imtu);
 				bh_unlock_sock(sk);
 				l2cap_conn_unreliable(conn, ECOMM);
 				goto drop;
@@ -4082,14 +4080,15 @@ static int l2cap_debugfs_show(struct seq_file *f, void *p)
 
 	sk_for_each(sk, node, &l2cap_sk_list.head) {
 		struct l2cap_pinfo *pi = l2cap_pi(sk);
+		struct l2cap_chan *chan = pi->chan;
 
 		seq_printf(f, "%s %s %d %d 0x%4.4x 0x%4.4x %d %d %d %d\n",
 					batostr(&bt_sk(sk)->src),
 					batostr(&bt_sk(sk)->dst),
 					sk->sk_state, __le16_to_cpu(pi->psm),
 					pi->scid, pi->dcid,
-					pi->imtu, pi->omtu, pi->chan->sec_level,
-					pi->mode);
+					chan->imtu, chan->omtu, chan->sec_level,
+					chan->mode);
 	}
 
 	read_unlock_bh(&l2cap_sk_list.lock);
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 4ba15b3..eef33b1 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -80,9 +80,13 @@ static struct sock *__l2cap_get_sock_by_addr(__le16 psm, bdaddr_t *src)
 {
 	struct sock *sk;
 	struct hlist_node *node;
-	sk_for_each(sk, node, &l2cap_sk_list.head)
-		if (l2cap_pi(sk)->sport == psm && !bacmp(&bt_sk(sk)->src, src))
+	sk_for_each(sk, node, &l2cap_sk_list.head) {
+		struct l2cap_chan *chan = l2cap_pi(sk)->chan;
+
+		if (chan->sport == psm && !bacmp(&bt_sk(sk)->src, src))
 			goto found;
+	}
+
 	sk = NULL;
 found:
 	return sk;
@@ -138,7 +142,7 @@ static int l2cap_sock_bind(struct socket *sock, struct sockaddr *addr, int alen)
 		/* Save source address */
 		bacpy(&bt_sk(sk)->src, &la.l2_bdaddr);
 		l2cap_pi(sk)->psm   = la.l2_psm;
-		l2cap_pi(sk)->sport = la.l2_psm;
+		chan->sport = la.l2_psm;
 		sk->sk_state = BT_BOUND;
 
 		if (__le16_to_cpu(la.l2_psm) == 0x0001 ||
@@ -159,6 +163,7 @@ done:
 static int l2cap_sock_connect(struct socket *sock, struct sockaddr *addr, int alen, int flags)
 {
 	struct sock *sk = sock->sk;
+	struct l2cap_chan *chan = l2cap_pi(sk)->chan;
 	struct sockaddr_l2 la;
 	int len, err = 0;
 
@@ -183,7 +188,7 @@ static int l2cap_sock_connect(struct socket *sock, struct sockaddr *addr, int al
 		goto done;
 	}
 
-	switch (l2cap_pi(sk)->mode) {
+	switch (chan->mode) {
 	case L2CAP_MODE_BASIC:
 		break;
 	case L2CAP_MODE_ERTM:
@@ -245,6 +250,7 @@ done:
 static int l2cap_sock_listen(struct socket *sock, int backlog)
 {
 	struct sock *sk = sock->sk;
+	struct l2cap_chan *chan = l2cap_pi(sk)->chan;
 	int err = 0;
 
 	BT_DBG("sk %p backlog %d", sk, backlog);
@@ -257,7 +263,7 @@ static int l2cap_sock_listen(struct socket *sock, int backlog)
 		goto done;
 	}
 
-	switch (l2cap_pi(sk)->mode) {
+	switch (chan->mode) {
 	case L2CAP_MODE_BASIC:
 		break;
 	case L2CAP_MODE_ERTM:
@@ -281,7 +287,7 @@ static int l2cap_sock_listen(struct socket *sock, int backlog)
 		for (psm = 0x1001; psm < 0x1100; psm += 2)
 			if (!__l2cap_get_sock_by_addr(cpu_to_le16(psm), src)) {
 				l2cap_pi(sk)->psm   = cpu_to_le16(psm);
-				l2cap_pi(sk)->sport = cpu_to_le16(psm);
+				chan->sport = cpu_to_le16(psm);
 				err = 0;
 				break;
 			}
@@ -361,6 +367,7 @@ static int l2cap_sock_getname(struct socket *sock, struct sockaddr *addr, int *l
 {
 	struct sockaddr_l2 *la = (struct sockaddr_l2 *) addr;
 	struct sock *sk = sock->sk;
+	struct l2cap_chan *chan = l2cap_pi(sk)->chan;
 
 	BT_DBG("sock %p, sk %p", sock, sk);
 
@@ -372,7 +379,7 @@ static int l2cap_sock_getname(struct socket *sock, struct sockaddr *addr, int *l
 		bacpy(&la->l2_bdaddr, &bt_sk(sk)->dst);
 		la->l2_cid = cpu_to_le16(l2cap_pi(sk)->dcid);
 	} else {
-		la->l2_psm = l2cap_pi(sk)->sport;
+		la->l2_psm = chan->sport;
 		bacpy(&la->l2_bdaddr, &bt_sk(sk)->src);
 		la->l2_cid = cpu_to_le16(l2cap_pi(sk)->scid);
 	}
@@ -399,10 +406,10 @@ static int l2cap_sock_getsockopt_old(struct socket *sock, int optname, char __us
 	switch (optname) {
 	case L2CAP_OPTIONS:
 		memset(&opts, 0, sizeof(opts));
-		opts.imtu     = l2cap_pi(sk)->imtu;
-		opts.omtu     = l2cap_pi(sk)->omtu;
-		opts.flush_to = l2cap_pi(sk)->flush_to;
-		opts.mode     = l2cap_pi(sk)->mode;
+		opts.imtu     = chan->imtu;
+		opts.omtu     = chan->omtu;
+		opts.flush_to = chan->flush_to;
+		opts.mode     = chan->mode;
 		opts.fcs      = chan->fcs;
 		opts.max_tx   = chan->max_tx;
 		opts.txwin_size = (__u16)chan->tx_win;
@@ -547,10 +554,10 @@ static int l2cap_sock_setsockopt_old(struct socket *sock, int optname, char __us
 			break;
 		}
 
-		opts.imtu     = l2cap_pi(sk)->imtu;
-		opts.omtu     = l2cap_pi(sk)->omtu;
-		opts.flush_to = l2cap_pi(sk)->flush_to;
-		opts.mode     = l2cap_pi(sk)->mode;
+		opts.imtu     = chan->imtu;
+		opts.omtu     = chan->omtu;
+		opts.flush_to = chan->flush_to;
+		opts.mode     = chan->mode;
 		opts.fcs      = chan->fcs;
 		opts.max_tx   = chan->max_tx;
 		opts.txwin_size = (__u16)chan->tx_win;
@@ -566,8 +573,8 @@ static int l2cap_sock_setsockopt_old(struct socket *sock, int optname, char __us
 			break;
 		}
 
-		l2cap_pi(sk)->mode = opts.mode;
-		switch (l2cap_pi(sk)->mode) {
+		chan->mode = opts.mode;
+		switch (chan->mode) {
 		case L2CAP_MODE_BASIC:
 			chan->conf_state &= ~L2CAP_CONF_STATE2_DEVICE;
 			break;
@@ -581,8 +588,8 @@ static int l2cap_sock_setsockopt_old(struct socket *sock, int optname, char __us
 			break;
 		}
 
-		l2cap_pi(sk)->imtu = opts.imtu;
-		l2cap_pi(sk)->omtu = opts.omtu;
+		chan->imtu = opts.imtu;
+		chan->omtu = opts.omtu;
 		chan->fcs  = opts.fcs;
 		chan->max_tx = opts.max_tx;
 		chan->tx_win = (__u8)opts.txwin_size;
@@ -707,7 +714,7 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname, ch
 static int l2cap_sock_sendmsg(struct kiocb *iocb, struct socket *sock, struct msghdr *msg, size_t len)
 {
 	struct sock *sk = sock->sk;
-	struct l2cap_pinfo *pi = l2cap_pi(sk);
+	struct l2cap_chan *chan = l2cap_pi(sk)->chan;
 	struct sk_buff *skb;
 	u16 control;
 	int err;
@@ -734,16 +741,16 @@ static int l2cap_sock_sendmsg(struct kiocb *iocb, struct socket *sock, struct ms
 		if (IS_ERR(skb)) {
 			err = PTR_ERR(skb);
 		} else {
-			l2cap_do_send(pi->chan, skb);
+			l2cap_do_send(chan, skb);
 			err = len;
 		}
 		goto done;
 	}
 
-	switch (pi->mode) {
+	switch (chan->mode) {
 	case L2CAP_MODE_BASIC:
 		/* Check outgoing MTU */
-		if (len > pi->omtu) {
+		if (len > chan->omtu) {
 			err = -EMSGSIZE;
 			goto done;
 		}
@@ -755,52 +762,52 @@ static int l2cap_sock_sendmsg(struct kiocb *iocb, struct socket *sock, struct ms
 			goto done;
 		}
 
-		l2cap_do_send(pi->chan, skb);
+		l2cap_do_send(chan, skb);
 		err = len;
 		break;
 
 	case L2CAP_MODE_ERTM:
 	case L2CAP_MODE_STREAMING:
 		/* Entire SDU fits into one PDU */
-		if (len <= pi->chan->remote_mps) {
+		if (len <= chan->remote_mps) {
 			control = L2CAP_SDU_UNSEGMENTED;
-			skb = l2cap_create_iframe_pdu(pi->chan, msg, len,
-								control, 0);
+			skb = l2cap_create_iframe_pdu(chan, msg, len, control,
+									0);
 			if (IS_ERR(skb)) {
 				err = PTR_ERR(skb);
 				goto done;
 			}
-			__skb_queue_tail(&pi->chan->tx_q, skb);
+			__skb_queue_tail(&chan->tx_q, skb);
 
-			if (pi->chan->tx_send_head == NULL)
-				pi->chan->tx_send_head = skb;
+			if (chan->tx_send_head == NULL)
+				chan->tx_send_head = skb;
 
 		} else {
 		/* Segment SDU into multiples PDUs */
-			err = l2cap_sar_segment_sdu(pi->chan, msg, len);
+			err = l2cap_sar_segment_sdu(chan, msg, len);
 			if (err < 0)
 				goto done;
 		}
 
-		if (pi->mode == L2CAP_MODE_STREAMING) {
-			l2cap_streaming_send(pi->chan);
+		if (chan->mode == L2CAP_MODE_STREAMING) {
+			l2cap_streaming_send(chan);
 			err = len;
 			break;
 		}
 
-		if ((pi->chan->conn_state & L2CAP_CONN_REMOTE_BUSY) &&
-				(pi->chan->conn_state & L2CAP_CONN_WAIT_F)) {
+		if ((chan->conn_state & L2CAP_CONN_REMOTE_BUSY) &&
+				(chan->conn_state & L2CAP_CONN_WAIT_F)) {
 			err = len;
 			break;
 		}
-		err = l2cap_ertm_send(pi->chan);
+		err = l2cap_ertm_send(chan);
 
 		if (err >= 0)
 			err = len;
 		break;
 
 	default:
-		BT_DBG("bad state %1.1x", pi->mode);
+		BT_DBG("bad state %1.1x", chan->mode);
 		err = -EBADFD;
 	}
 
@@ -929,6 +936,7 @@ void __l2cap_sock_close(struct sock *sk, int reason)
 static int l2cap_sock_shutdown(struct socket *sock, int how)
 {
 	struct sock *sk = sock->sk;
+	struct l2cap_chan *chan = l2cap_pi(sk)->chan;
 	int err = 0;
 
 	BT_DBG("sock %p, sk %p", sock, sk);
@@ -938,7 +946,7 @@ static int l2cap_sock_shutdown(struct socket *sock, int how)
 
 	lock_sock(sk);
 	if (!sk->sk_shutdown) {
-		if (l2cap_pi(sk)->mode == L2CAP_MODE_ERTM)
+		if (chan->mode == L2CAP_MODE_ERTM)
 			err = __l2cap_wait_ack(sk);
 
 		sk->sk_shutdown = SHUTDOWN_MASK;
@@ -995,10 +1003,10 @@ void l2cap_sock_init(struct sock *sk, struct sock *parent)
 		sk->sk_type = parent->sk_type;
 		bt_sk(sk)->defer_setup = bt_sk(parent)->defer_setup;
 
-		pi->imtu = l2cap_pi(parent)->imtu;
-		pi->omtu = l2cap_pi(parent)->omtu;
+		chan->imtu = pchan->imtu;
+		chan->omtu = pchan->omtu;
 		chan->conf_state = pchan->conf_state;
-		pi->mode = l2cap_pi(parent)->mode;
+		chan->mode = pchan->mode;
 		chan->fcs  = pchan->fcs;
 		chan->max_tx = pchan->max_tx;
 		chan->tx_win = pchan->tx_win;
@@ -1007,13 +1015,13 @@ void l2cap_sock_init(struct sock *sk, struct sock *parent)
 		chan->force_reliable = pchan->force_reliable;
 		chan->flushable = pchan->flushable;
 	} else {
-		pi->imtu = L2CAP_DEFAULT_MTU;
-		pi->omtu = 0;
+		chan->imtu = L2CAP_DEFAULT_MTU;
+		chan->omtu = 0;
 		if (!disable_ertm && sk->sk_type == SOCK_STREAM) {
-			pi->mode = L2CAP_MODE_ERTM;
+			chan->mode = L2CAP_MODE_ERTM;
 			chan->conf_state |= L2CAP_CONF_STATE2_DEVICE;
 		} else {
-			pi->mode = L2CAP_MODE_BASIC;
+			chan->mode = L2CAP_MODE_BASIC;
 		}
 		chan->max_tx = L2CAP_DEFAULT_MAX_TX;
 		chan->fcs  = L2CAP_FCS_CRC16;
@@ -1025,7 +1033,7 @@ void l2cap_sock_init(struct sock *sk, struct sock *parent)
 	}
 
 	/* Default config options */
-	pi->flush_to = L2CAP_DEFAULT_FLUSH_TO;
+	chan->flush_to = L2CAP_DEFAULT_FLUSH_TO;
 }
 
 static struct proto l2cap_proto = {
diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index 4f728a4..fdd8f5a 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -710,10 +710,10 @@ static struct rfcomm_session *rfcomm_session_create(bdaddr_t *src,
 	/* Set L2CAP options */
 	sk = sock->sk;
 	lock_sock(sk);
-	l2cap_pi(sk)->imtu = l2cap_mtu;
+	l2cap_pi(sk)->chan->imtu = l2cap_mtu;
 	l2cap_pi(sk)->chan->sec_level = sec_level;
 	if (l2cap_ertm)
-		l2cap_pi(sk)->mode = L2CAP_MODE_ERTM;
+		l2cap_pi(sk)->chan->mode = L2CAP_MODE_ERTM;
 	release_sock(sk);
 
 	s = rfcomm_session_add(sock, BT_BOUND);
@@ -1890,7 +1890,8 @@ static inline void rfcomm_accept_connection(struct rfcomm_session *s)
 
 		/* We should adjust MTU on incoming sessions.
 		 * L2CAP MTU minus UIH header and FCS. */
-		s->mtu = min(l2cap_pi(nsock->sk)->omtu, l2cap_pi(nsock->sk)->imtu) - 5;
+		s->mtu = min(l2cap_pi(nsock->sk)->chan->omtu,
+				l2cap_pi(nsock->sk)->chan->imtu) - 5;
 
 		rfcomm_schedule();
 	} else
@@ -1909,7 +1910,7 @@ static inline void rfcomm_check_connection(struct rfcomm_session *s)
 
 		/* We can adjust MTU on outgoing sessions.
 		 * L2CAP MTU minus UIH header and FCS. */
-		s->mtu = min(l2cap_pi(sk)->omtu, l2cap_pi(sk)->imtu) - 5;
+		s->mtu = min(l2cap_pi(sk)->chan->omtu, l2cap_pi(sk)->chan->imtu) - 5;
 
 		rfcomm_send_sabm(s, 0);
 		break;
@@ -1992,7 +1993,7 @@ static int rfcomm_add_listener(bdaddr_t *ba)
 	/* Set L2CAP options */
 	sk = sock->sk;
 	lock_sock(sk);
-	l2cap_pi(sk)->imtu = l2cap_mtu;
+	l2cap_pi(sk)->chan->imtu = l2cap_mtu;
 	release_sock(sk);
 
 	/* Start listening on the socket */
-- 
1.7.5.rc1

