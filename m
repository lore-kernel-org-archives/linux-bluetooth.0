Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/8] Bluetooth: Move conf_state to struct l2cap_chan
Date: Fri, 15 Apr 2011 15:17:28 -0300
Message-Id: <1302891454-10165-3-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1302891454-10165-2-git-send-email-padovan@profusion.mobi>
References: <1302891454-10165-1-git-send-email-padovan@profusion.mobi>
 <1302891454-10165-2-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

First move of elements depending on user data.

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 include/net/bluetooth/l2cap.h |    3 +-
 net/bluetooth/l2cap_core.c    |   88 +++++++++++++++++++++--------------------
 net/bluetooth/l2cap_sock.c    |   10 +++-
 3 files changed, 53 insertions(+), 48 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 537e3c1..b3bb3d4 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -291,6 +291,7 @@ struct l2cap_chan {
 	__u8		num_conf_req;
 	__u8		num_conf_rsp;
 
+	__u8		conf_state;
 	__u16		conn_state;
 
 	__u8		next_tx_seq;
@@ -375,8 +376,6 @@ struct l2cap_pinfo {
 	__u8		force_reliable;
 	__u8		flushable;
 
-	__u8		conf_state;
-
 	__u8		tx_win;
 	__u8		max_tx;
 	__u16		retrans_timeout;
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 9a60ec0..a3aa26b 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -236,8 +236,8 @@ void l2cap_chan_del(struct l2cap_chan *chan, int err)
 	} else
 		sk->sk_state_change(sk);
 
-	if (!(l2cap_pi(sk)->conf_state & L2CAP_CONF_OUTPUT_DONE &&
-			l2cap_pi(sk)->conf_state & L2CAP_CONF_INPUT_DONE))
+	if (!(chan->conf_state & L2CAP_CONF_OUTPUT_DONE &&
+			chan->conf_state & L2CAP_CONF_INPUT_DONE))
 		goto free;
 
 	skb_queue_purge(&chan->tx_q);
@@ -411,9 +411,9 @@ static inline void l2cap_send_rr_or_rnr(struct l2cap_chan *chan, u16 control)
 	l2cap_send_sframe(chan, control);
 }
 
-static inline int __l2cap_no_conn_pending(struct sock *sk)
+static inline int __l2cap_no_conn_pending(struct l2cap_chan *chan)
 {
-	return !(l2cap_pi(sk)->conf_state & L2CAP_CONF_CONNECT_PEND);
+	return !(chan->conf_state & L2CAP_CONF_CONNECT_PEND);
 }
 
 static void l2cap_do_start(struct l2cap_chan *chan)
@@ -425,13 +425,13 @@ static void l2cap_do_start(struct l2cap_chan *chan)
 		if (!(conn->info_state & L2CAP_INFO_FEAT_MASK_REQ_DONE))
 			return;
 
-		if (l2cap_check_security(sk) && __l2cap_no_conn_pending(sk)) {
+		if (l2cap_check_security(sk) && __l2cap_no_conn_pending(chan)) {
 			struct l2cap_conn_req req;
 			req.scid = cpu_to_le16(l2cap_pi(sk)->scid);
 			req.psm  = l2cap_pi(sk)->psm;
 
 			chan->ident = l2cap_get_ident(conn);
-			l2cap_pi(sk)->conf_state |= L2CAP_CONF_CONNECT_PEND;
+			chan->conf_state |= L2CAP_CONF_CONNECT_PEND;
 
 			l2cap_send_cmd(conn, chan->ident, L2CAP_CONN_REQ,
 							sizeof(req), &req);
@@ -516,14 +516,14 @@ static void l2cap_conn_start(struct l2cap_conn *conn)
 			struct l2cap_conn_req req;
 
 			if (!l2cap_check_security(sk) ||
-					!__l2cap_no_conn_pending(sk)) {
+					!__l2cap_no_conn_pending(chan)) {
 				bh_unlock_sock(sk);
 				continue;
 			}
 
 			if (!l2cap_mode_supported(l2cap_pi(sk)->mode,
 					conn->feat_mask)
-					&& l2cap_pi(sk)->conf_state &
+					&& chan->conf_state &
 					L2CAP_CONF_STATE2_DEVICE) {
 				/* __l2cap_sock_close() calls list_del(chan)
 				 * so release the lock */
@@ -538,7 +538,7 @@ static void l2cap_conn_start(struct l2cap_conn *conn)
 			req.psm  = l2cap_pi(sk)->psm;
 
 			chan->ident = l2cap_get_ident(conn);
-			l2cap_pi(sk)->conf_state |= L2CAP_CONF_CONNECT_PEND;
+			chan->conf_state |= L2CAP_CONF_CONNECT_PEND;
 
 			l2cap_send_cmd(conn, chan->ident, L2CAP_CONN_REQ,
 							sizeof(req), &req);
@@ -569,13 +569,13 @@ static void l2cap_conn_start(struct l2cap_conn *conn)
 			l2cap_send_cmd(conn, chan->ident, L2CAP_CONN_RSP,
 							sizeof(rsp), &rsp);
 
-			if (l2cap_pi(sk)->conf_state & L2CAP_CONF_REQ_SENT ||
+			if (chan->conf_state & L2CAP_CONF_REQ_SENT ||
 					rsp.result != L2CAP_CR_SUCCESS) {
 				bh_unlock_sock(sk);
 				continue;
 			}
 
-			l2cap_pi(sk)->conf_state |= L2CAP_CONF_REQ_SENT;
+			chan->conf_state |= L2CAP_CONF_REQ_SENT;
 			l2cap_send_cmd(conn, l2cap_get_ident(conn), L2CAP_CONF_REQ,
 						l2cap_build_conf_req(chan, buf), buf);
 			chan->num_conf_req++;
@@ -1381,10 +1381,11 @@ int l2cap_sar_segment_sdu(struct l2cap_chan *chan, struct msghdr *msg, size_t le
 static void l2cap_chan_ready(struct sock *sk)
 {
 	struct sock *parent = bt_sk(sk)->parent;
+	struct l2cap_chan *chan = l2cap_pi(sk)->chan;
 
 	BT_DBG("sk %p, parent %p", sk, parent);
 
-	l2cap_pi(sk)->conf_state = 0;
+	chan->conf_state = 0;
 	l2cap_sock_clear_timer(sk);
 
 	if (!parent) {
@@ -1618,7 +1619,7 @@ static int l2cap_build_conf_req(struct l2cap_chan *chan, void *data)
 	switch (pi->mode) {
 	case L2CAP_MODE_STREAMING:
 	case L2CAP_MODE_ERTM:
-		if (pi->conf_state & L2CAP_CONF_STATE2_DEVICE)
+		if (chan->conf_state & L2CAP_CONF_STATE2_DEVICE)
 			break;
 
 		/* fall through */
@@ -1665,7 +1666,7 @@ done:
 			break;
 
 		if (pi->fcs == L2CAP_FCS_NONE ||
-				pi->conf_state & L2CAP_CONF_NO_FCS_RECV) {
+				chan->conf_state & L2CAP_CONF_NO_FCS_RECV) {
 			pi->fcs = L2CAP_FCS_NONE;
 			l2cap_add_conf_opt(&ptr, L2CAP_CONF_FCS, 1, pi->fcs);
 		}
@@ -1688,7 +1689,7 @@ done:
 			break;
 
 		if (pi->fcs == L2CAP_FCS_NONE ||
-				pi->conf_state & L2CAP_CONF_NO_FCS_RECV) {
+				chan->conf_state & L2CAP_CONF_NO_FCS_RECV) {
 			pi->fcs = L2CAP_FCS_NONE;
 			l2cap_add_conf_opt(&ptr, L2CAP_CONF_FCS, 1, pi->fcs);
 		}
@@ -1741,7 +1742,7 @@ static int l2cap_parse_conf_req(struct l2cap_chan *chan, void *data)
 
 		case L2CAP_CONF_FCS:
 			if (val == L2CAP_FCS_NONE)
-				pi->conf_state |= L2CAP_CONF_NO_FCS_RECV;
+				chan->conf_state |= L2CAP_CONF_NO_FCS_RECV;
 
 			break;
 
@@ -1761,7 +1762,7 @@ static int l2cap_parse_conf_req(struct l2cap_chan *chan, void *data)
 	switch (pi->mode) {
 	case L2CAP_MODE_STREAMING:
 	case L2CAP_MODE_ERTM:
-		if (!(pi->conf_state & L2CAP_CONF_STATE2_DEVICE)) {
+		if (!(chan->conf_state & L2CAP_CONF_STATE2_DEVICE)) {
 			pi->mode = l2cap_select_mode(rfc.mode,
 					pi->conn->feat_mask);
 			break;
@@ -1794,14 +1795,14 @@ done:
 			result = L2CAP_CONF_UNACCEPT;
 		else {
 			pi->omtu = mtu;
-			pi->conf_state |= L2CAP_CONF_MTU_DONE;
+			chan->conf_state |= L2CAP_CONF_MTU_DONE;
 		}
 		l2cap_add_conf_opt(&ptr, L2CAP_CONF_MTU, 2, pi->omtu);
 
 		switch (rfc.mode) {
 		case L2CAP_MODE_BASIC:
 			pi->fcs = L2CAP_FCS_NONE;
-			pi->conf_state |= L2CAP_CONF_MODE_DONE;
+			chan->conf_state |= L2CAP_CONF_MODE_DONE;
 			break;
 
 		case L2CAP_MODE_ERTM:
@@ -1818,7 +1819,7 @@ done:
 			rfc.monitor_timeout =
 				le16_to_cpu(L2CAP_DEFAULT_MONITOR_TO);
 
-			pi->conf_state |= L2CAP_CONF_MODE_DONE;
+			chan->conf_state |= L2CAP_CONF_MODE_DONE;
 
 			l2cap_add_conf_opt(&ptr, L2CAP_CONF_RFC,
 					sizeof(rfc), (unsigned long) &rfc);
@@ -1831,7 +1832,7 @@ done:
 
 			chan->remote_mps = le16_to_cpu(rfc.max_pdu_size);
 
-			pi->conf_state |= L2CAP_CONF_MODE_DONE;
+			chan->conf_state |= L2CAP_CONF_MODE_DONE;
 
 			l2cap_add_conf_opt(&ptr, L2CAP_CONF_RFC,
 					sizeof(rfc), (unsigned long) &rfc);
@@ -1846,7 +1847,7 @@ done:
 		}
 
 		if (result == L2CAP_CONF_SUCCESS)
-			pi->conf_state |= L2CAP_CONF_OUTPUT_DONE;
+			chan->conf_state |= L2CAP_CONF_OUTPUT_DONE;
 	}
 	rsp->scid   = cpu_to_le16(pi->dcid);
 	rsp->result = cpu_to_le16(result);
@@ -1855,8 +1856,9 @@ done:
 	return ptr - data;
 }
 
-static int l2cap_parse_conf_rsp(struct sock *sk, void *rsp, int len, void *data, u16 *result)
+static int l2cap_parse_conf_rsp(struct l2cap_chan *chan, void *rsp, int len, void *data, u16 *result)
 {
+	struct sock *sk = chan->sk;
 	struct l2cap_pinfo *pi = l2cap_pi(sk);
 	struct l2cap_conf_req *req = data;
 	void *ptr = req->data;
@@ -1889,7 +1891,7 @@ static int l2cap_parse_conf_rsp(struct sock *sk, void *rsp, int len, void *data,
 			if (olen == sizeof(rfc))
 				memcpy(&rfc, (void *)val, olen);
 
-			if ((pi->conf_state & L2CAP_CONF_STATE2_DEVICE) &&
+			if ((chan->conf_state & L2CAP_CONF_STATE2_DEVICE) &&
 							rfc.mode != pi->mode)
 				return -ECONNREFUSED;
 
@@ -1954,10 +1956,10 @@ void __l2cap_connect_rsp_defer(struct sock *sk)
 	l2cap_send_cmd(conn, chan->ident,
 				L2CAP_CONN_RSP, sizeof(rsp), &rsp);
 
-	if (l2cap_pi(sk)->conf_state & L2CAP_CONF_REQ_SENT)
+	if (chan->conf_state & L2CAP_CONF_REQ_SENT)
 		return;
 
-	l2cap_pi(sk)->conf_state |= L2CAP_CONF_REQ_SENT;
+	chan->conf_state |= L2CAP_CONF_REQ_SENT;
 	l2cap_send_cmd(conn, l2cap_get_ident(conn), L2CAP_CONF_REQ,
 			l2cap_build_conf_req(chan, buf), buf);
 	chan->num_conf_req++;
@@ -2145,10 +2147,10 @@ sendresp:
 					L2CAP_INFO_REQ, sizeof(info), &info);
 	}
 
-	if (chan && !(l2cap_pi(sk)->conf_state & L2CAP_CONF_REQ_SENT) &&
+	if (chan && !(chan->conf_state & L2CAP_CONF_REQ_SENT) &&
 				result == L2CAP_CR_SUCCESS) {
 		u8 buf[128];
-		l2cap_pi(sk)->conf_state |= L2CAP_CONF_REQ_SENT;
+		chan->conf_state |= L2CAP_CONF_REQ_SENT;
 		l2cap_send_cmd(conn, l2cap_get_ident(conn), L2CAP_CONF_REQ,
 					l2cap_build_conf_req(chan, buf), buf);
 		chan->num_conf_req++;
@@ -2189,12 +2191,12 @@ static inline int l2cap_connect_rsp(struct l2cap_conn *conn, struct l2cap_cmd_hd
 		sk->sk_state = BT_CONFIG;
 		chan->ident = 0;
 		l2cap_pi(sk)->dcid = dcid;
-		l2cap_pi(sk)->conf_state &= ~L2CAP_CONF_CONNECT_PEND;
+		chan->conf_state &= ~L2CAP_CONF_CONNECT_PEND;
 
-		if (l2cap_pi(sk)->conf_state & L2CAP_CONF_REQ_SENT)
+		if (chan->conf_state & L2CAP_CONF_REQ_SENT)
 			break;
 
-		l2cap_pi(sk)->conf_state |= L2CAP_CONF_REQ_SENT;
+		chan->conf_state |= L2CAP_CONF_REQ_SENT;
 
 		l2cap_send_cmd(conn, l2cap_get_ident(conn), L2CAP_CONF_REQ,
 					l2cap_build_conf_req(chan, req), req);
@@ -2202,7 +2204,7 @@ static inline int l2cap_connect_rsp(struct l2cap_conn *conn, struct l2cap_cmd_hd
 		break;
 
 	case L2CAP_CR_PEND:
-		l2cap_pi(sk)->conf_state |= L2CAP_CONF_CONNECT_PEND;
+		chan->conf_state |= L2CAP_CONF_CONNECT_PEND;
 		break;
 
 	default:
@@ -2229,7 +2231,7 @@ static inline void set_default_fcs(struct l2cap_pinfo *pi)
 	 */
 	if (pi->mode != L2CAP_MODE_ERTM && pi->mode != L2CAP_MODE_STREAMING)
 		pi->fcs = L2CAP_FCS_NONE;
-	else if (!(pi->conf_state & L2CAP_CONF_NO_FCS_RECV))
+	else if (!(pi->chan->conf_state & L2CAP_CONF_NO_FCS_RECV))
 		pi->fcs = L2CAP_FCS_CRC16;
 }
 
@@ -2296,10 +2298,10 @@ static inline int l2cap_config_req(struct l2cap_conn *conn, struct l2cap_cmd_hdr
 	/* Reset config buffer. */
 	chan->conf_len = 0;
 
-	if (!(l2cap_pi(sk)->conf_state & L2CAP_CONF_OUTPUT_DONE))
+	if (!(chan->conf_state & L2CAP_CONF_OUTPUT_DONE))
 		goto unlock;
 
-	if (l2cap_pi(sk)->conf_state & L2CAP_CONF_INPUT_DONE) {
+	if (chan->conf_state & L2CAP_CONF_INPUT_DONE) {
 		set_default_fcs(l2cap_pi(sk));
 
 		sk->sk_state = BT_CONNECTED;
@@ -2314,9 +2316,9 @@ static inline int l2cap_config_req(struct l2cap_conn *conn, struct l2cap_cmd_hdr
 		goto unlock;
 	}
 
-	if (!(l2cap_pi(sk)->conf_state & L2CAP_CONF_REQ_SENT)) {
+	if (!(chan->conf_state & L2CAP_CONF_REQ_SENT)) {
 		u8 buf[64];
-		l2cap_pi(sk)->conf_state |= L2CAP_CONF_REQ_SENT;
+		chan->conf_state |= L2CAP_CONF_REQ_SENT;
 		l2cap_send_cmd(conn, l2cap_get_ident(conn), L2CAP_CONF_REQ,
 					l2cap_build_conf_req(chan, buf), buf);
 		chan->num_conf_req++;
@@ -2364,8 +2366,8 @@ static inline int l2cap_config_rsp(struct l2cap_conn *conn, struct l2cap_cmd_hdr
 
 			/* throw out any old stored conf requests */
 			result = L2CAP_CONF_SUCCESS;
-			len = l2cap_parse_conf_rsp(sk, rsp->data,
-							len, req, &result);
+			len = l2cap_parse_conf_rsp(chan, rsp->data, len,
+								req, &result);
 			if (len < 0) {
 				l2cap_send_disconn_req(conn, chan, ECONNRESET);
 				goto done;
@@ -2389,9 +2391,9 @@ static inline int l2cap_config_rsp(struct l2cap_conn *conn, struct l2cap_cmd_hdr
 	if (flags & 0x01)
 		goto done;
 
-	l2cap_pi(sk)->conf_state |= L2CAP_CONF_INPUT_DONE;
+	chan->conf_state |= L2CAP_CONF_INPUT_DONE;
 
-	if (l2cap_pi(sk)->conf_state & L2CAP_CONF_OUTPUT_DONE) {
+	if (chan->conf_state & L2CAP_CONF_OUTPUT_DONE) {
 		set_default_fcs(l2cap_pi(sk));
 
 		sk->sk_state = BT_CONNECTED;
@@ -3898,7 +3900,7 @@ static int l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
 
 		bh_lock_sock(sk);
 
-		if (l2cap_pi(sk)->conf_state & L2CAP_CONF_CONNECT_PEND) {
+		if (chan->conf_state & L2CAP_CONF_CONNECT_PEND) {
 			bh_unlock_sock(sk);
 			continue;
 		}
@@ -3917,7 +3919,7 @@ static int l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
 				req.psm  = l2cap_pi(sk)->psm;
 
 				chan->ident = l2cap_get_ident(conn);
-				l2cap_pi(sk)->conf_state |= L2CAP_CONF_CONNECT_PEND;
+				chan->conf_state |= L2CAP_CONF_CONNECT_PEND;
 
 				l2cap_send_cmd(conn, chan->ident,
 					L2CAP_CONN_REQ, sizeof(req), &req);
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index e372457..a29782a 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -528,6 +528,7 @@ static int l2cap_sock_getsockopt(struct socket *sock, int level, int optname, ch
 static int l2cap_sock_setsockopt_old(struct socket *sock, int optname, char __user *optval, unsigned int optlen)
 {
 	struct sock *sk = sock->sk;
+	struct l2cap_chan *chan = l2cap_pi(sk)->chan;
 	struct l2cap_options opts;
 	int len, err = 0;
 	u32 opt;
@@ -565,7 +566,7 @@ static int l2cap_sock_setsockopt_old(struct socket *sock, int optname, char __us
 		l2cap_pi(sk)->mode = opts.mode;
 		switch (l2cap_pi(sk)->mode) {
 		case L2CAP_MODE_BASIC:
-			l2cap_pi(sk)->conf_state &= ~L2CAP_CONF_STATE2_DEVICE;
+			chan->conf_state &= ~L2CAP_CONF_STATE2_DEVICE;
 			break;
 		case L2CAP_MODE_ERTM:
 		case L2CAP_MODE_STREAMING:
@@ -979,16 +980,19 @@ static void l2cap_sock_destruct(struct sock *sk)
 void l2cap_sock_init(struct sock *sk, struct sock *parent)
 {
 	struct l2cap_pinfo *pi = l2cap_pi(sk);
+	struct l2cap_chan *chan = pi->chan;
 
 	BT_DBG("sk %p", sk);
 
 	if (parent) {
+		struct l2cap_chan *pchan = l2cap_pi(parent)->chan;
+
 		sk->sk_type = parent->sk_type;
 		bt_sk(sk)->defer_setup = bt_sk(parent)->defer_setup;
 
 		pi->imtu = l2cap_pi(parent)->imtu;
 		pi->omtu = l2cap_pi(parent)->omtu;
-		pi->conf_state = l2cap_pi(parent)->conf_state;
+		chan->conf_state = pchan->conf_state;
 		pi->mode = l2cap_pi(parent)->mode;
 		pi->fcs  = l2cap_pi(parent)->fcs;
 		pi->max_tx = l2cap_pi(parent)->max_tx;
@@ -1002,7 +1006,7 @@ void l2cap_sock_init(struct sock *sk, struct sock *parent)
 		pi->omtu = 0;
 		if (!disable_ertm && sk->sk_type == SOCK_STREAM) {
 			pi->mode = L2CAP_MODE_ERTM;
-			pi->conf_state |= L2CAP_CONF_STATE2_DEVICE;
+			chan->conf_state |= L2CAP_CONF_STATE2_DEVICE;
 		} else {
 			pi->mode = L2CAP_MODE_BASIC;
 		}
-- 
1.7.5.rc1

