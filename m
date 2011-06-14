Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH -v2 1/2] Bluetooth: use bit operation on conf_state
Date: Tue, 14 Jun 2011 17:39:28 -0300
Message-Id: <1308083969-16502-1-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Instead of making the bit operations manually, we now use set_bit,
test_bit, etc.

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 include/net/bluetooth/l2cap.h |   20 ++++++-----
 net/bluetooth/l2cap_core.c    |   77 ++++++++++++++++++----------------------
 net/bluetooth/l2cap_sock.c    |    4 +-
 3 files changed, 48 insertions(+), 53 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 01c993b..791e6d5 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -324,7 +324,7 @@ struct l2cap_chan {
 	__u16		monitor_timeout;
 	__u16		mps;
 
-	__u8		conf_state;
+	unsigned long	conf_state;
 	__u16		conn_state;
 
 	__u8		next_tx_seq;
@@ -421,14 +421,16 @@ struct l2cap_pinfo {
 	struct l2cap_chan	*chan;
 };
 
-#define L2CAP_CONF_REQ_SENT       0x01
-#define L2CAP_CONF_INPUT_DONE     0x02
-#define L2CAP_CONF_OUTPUT_DONE    0x04
-#define L2CAP_CONF_MTU_DONE       0x08
-#define L2CAP_CONF_MODE_DONE      0x10
-#define L2CAP_CONF_CONNECT_PEND   0x20
-#define L2CAP_CONF_NO_FCS_RECV    0x40
-#define L2CAP_CONF_STATE2_DEVICE  0x80
+enum {
+	CONF_REQ_SENT,
+	CONF_INPUT_DONE,
+	CONF_OUTPUT_DONE,
+	CONF_MTU_DONE,
+	CONF_MODE_DONE,
+	CONF_CONNECT_PEND,
+	CONF_NO_FCS_RECV,
+	CONF_STATE2_DEVICE,
+};
 
 #define L2CAP_CONF_MAX_CONF_REQ 2
 #define L2CAP_CONF_MAX_CONF_RSP 2
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 584a423..aa203b5 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -381,8 +381,8 @@ static void l2cap_chan_del(struct l2cap_chan *chan, int err)
 	} else
 		sk->sk_state_change(sk);
 
-	if (!(chan->conf_state & L2CAP_CONF_OUTPUT_DONE &&
-			chan->conf_state & L2CAP_CONF_INPUT_DONE))
+	if (!(test_bit(CONF_OUTPUT_DONE, &chan->conf_state) &&
+			test_bit(CONF_INPUT_DONE, &chan->conf_state)))
 		return;
 
 	skb_queue_purge(&chan->tx_q);
@@ -633,7 +633,7 @@ static inline void l2cap_send_rr_or_rnr(struct l2cap_chan *chan, u16 control)
 
 static inline int __l2cap_no_conn_pending(struct l2cap_chan *chan)
 {
-	return !(chan->conf_state & L2CAP_CONF_CONNECT_PEND);
+	return !test_bit(CONF_CONNECT_PEND, &chan->conf_state);
 }
 
 static void l2cap_do_start(struct l2cap_chan *chan)
@@ -651,7 +651,7 @@ static void l2cap_do_start(struct l2cap_chan *chan)
 			req.psm  = chan->psm;
 
 			chan->ident = l2cap_get_ident(conn);
-			chan->conf_state |= L2CAP_CONF_CONNECT_PEND;
+			set_bit(CONF_CONNECT_PEND, &chan->conf_state);
 
 			l2cap_send_cmd(conn, chan->ident, L2CAP_CONN_REQ,
 							sizeof(req), &req);
@@ -740,10 +740,9 @@ static void l2cap_conn_start(struct l2cap_conn *conn)
 				continue;
 			}
 
-			if (!l2cap_mode_supported(chan->mode,
-					conn->feat_mask)
-					&& chan->conf_state &
-					L2CAP_CONF_STATE2_DEVICE) {
+			if (!l2cap_mode_supported(chan->mode, conn->feat_mask)
+					&& test_bit(CONF_STATE2_DEVICE,
+					&chan->conf_state)) {
 				/* l2cap_chan_close() calls list_del(chan)
 				 * so release the lock */
 				read_unlock_bh(&conn->chan_lock);
@@ -757,7 +756,7 @@ static void l2cap_conn_start(struct l2cap_conn *conn)
 			req.psm  = chan->psm;
 
 			chan->ident = l2cap_get_ident(conn);
-			chan->conf_state |= L2CAP_CONF_CONNECT_PEND;
+			set_bit(CONF_CONNECT_PEND, &chan->conf_state);
 
 			l2cap_send_cmd(conn, chan->ident, L2CAP_CONN_REQ,
 							sizeof(req), &req);
@@ -788,13 +787,13 @@ static void l2cap_conn_start(struct l2cap_conn *conn)
 			l2cap_send_cmd(conn, chan->ident, L2CAP_CONN_RSP,
 							sizeof(rsp), &rsp);
 
-			if (chan->conf_state & L2CAP_CONF_REQ_SENT ||
+			if (test_bit(CONF_REQ_SENT, &chan->conf_state) ||
 					rsp.result != L2CAP_CR_SUCCESS) {
 				bh_unlock_sock(sk);
 				continue;
 			}
 
-			chan->conf_state |= L2CAP_CONF_REQ_SENT;
+			set_bit(CONF_REQ_SENT, &chan->conf_state);
 			l2cap_send_cmd(conn, l2cap_get_ident(conn), L2CAP_CONF_REQ,
 						l2cap_build_conf_req(chan, buf), buf);
 			chan->num_conf_req++;
@@ -1904,7 +1903,7 @@ static int l2cap_build_conf_req(struct l2cap_chan *chan, void *data)
 	switch (chan->mode) {
 	case L2CAP_MODE_STREAMING:
 	case L2CAP_MODE_ERTM:
-		if (chan->conf_state & L2CAP_CONF_STATE2_DEVICE)
+		if (test_bit(CONF_STATE2_DEVICE, &chan->conf_state))
 			break;
 
 		/* fall through */
@@ -1951,7 +1950,7 @@ done:
 			break;
 
 		if (chan->fcs == L2CAP_FCS_NONE ||
-				chan->conf_state & L2CAP_CONF_NO_FCS_RECV) {
+				test_bit(CONF_NO_FCS_RECV, &chan->conf_state)) {
 			chan->fcs = L2CAP_FCS_NONE;
 			l2cap_add_conf_opt(&ptr, L2CAP_CONF_FCS, 1, chan->fcs);
 		}
@@ -1974,7 +1973,7 @@ done:
 			break;
 
 		if (chan->fcs == L2CAP_FCS_NONE ||
-				chan->conf_state & L2CAP_CONF_NO_FCS_RECV) {
+				test_bit(CONF_NO_FCS_RECV, &chan->conf_state)) {
 			chan->fcs = L2CAP_FCS_NONE;
 			l2cap_add_conf_opt(&ptr, L2CAP_CONF_FCS, 1, chan->fcs);
 		}
@@ -2026,7 +2025,7 @@ static int l2cap_parse_conf_req(struct l2cap_chan *chan, void *data)
 
 		case L2CAP_CONF_FCS:
 			if (val == L2CAP_FCS_NONE)
-				chan->conf_state |= L2CAP_CONF_NO_FCS_RECV;
+				set_bit(CONF_NO_FCS_RECV, &chan->conf_state);
 
 			break;
 
@@ -2046,7 +2045,7 @@ static int l2cap_parse_conf_req(struct l2cap_chan *chan, void *data)
 	switch (chan->mode) {
 	case L2CAP_MODE_STREAMING:
 	case L2CAP_MODE_ERTM:
-		if (!(chan->conf_state & L2CAP_CONF_STATE2_DEVICE)) {
+		if (!test_bit(CONF_STATE2_DEVICE, &chan->conf_state)) {
 			chan->mode = l2cap_select_mode(rfc.mode,
 					chan->conn->feat_mask);
 			break;
@@ -2079,14 +2078,14 @@ done:
 			result = L2CAP_CONF_UNACCEPT;
 		else {
 			chan->omtu = mtu;
-			chan->conf_state |= L2CAP_CONF_MTU_DONE;
+			set_bit(CONF_MTU_DONE, &chan->conf_state);
 		}
 		l2cap_add_conf_opt(&ptr, L2CAP_CONF_MTU, 2, chan->omtu);
 
 		switch (rfc.mode) {
 		case L2CAP_MODE_BASIC:
 			chan->fcs = L2CAP_FCS_NONE;
-			chan->conf_state |= L2CAP_CONF_MODE_DONE;
+			set_bit(CONF_MODE_DONE, &chan->conf_state);
 			break;
 
 		case L2CAP_MODE_ERTM:
@@ -2103,7 +2102,7 @@ done:
 			rfc.monitor_timeout =
 				le16_to_cpu(L2CAP_DEFAULT_MONITOR_TO);
 
-			chan->conf_state |= L2CAP_CONF_MODE_DONE;
+			set_bit(CONF_MODE_DONE, &chan->conf_state);
 
 			l2cap_add_conf_opt(&ptr, L2CAP_CONF_RFC,
 					sizeof(rfc), (unsigned long) &rfc);
@@ -2116,7 +2115,7 @@ done:
 
 			chan->remote_mps = le16_to_cpu(rfc.max_pdu_size);
 
-			chan->conf_state |= L2CAP_CONF_MODE_DONE;
+			set_bit(CONF_MODE_DONE, &chan->conf_state);
 
 			l2cap_add_conf_opt(&ptr, L2CAP_CONF_RFC,
 					sizeof(rfc), (unsigned long) &rfc);
@@ -2131,7 +2130,7 @@ done:
 		}
 
 		if (result == L2CAP_CONF_SUCCESS)
-			chan->conf_state |= L2CAP_CONF_OUTPUT_DONE;
+			set_bit(CONF_OUTPUT_DONE, &chan->conf_state);
 	}
 	rsp->scid   = cpu_to_le16(chan->dcid);
 	rsp->result = cpu_to_le16(result);
@@ -2173,7 +2172,7 @@ static int l2cap_parse_conf_rsp(struct l2cap_chan *chan, void *rsp, int len, voi
 			if (olen == sizeof(rfc))
 				memcpy(&rfc, (void *)val, olen);
 
-			if ((chan->conf_state & L2CAP_CONF_STATE2_DEVICE) &&
+			if (test_bit(CONF_STATE2_DEVICE, &chan->conf_state) &&
 							rfc.mode != chan->mode)
 				return -ECONNREFUSED;
 
@@ -2235,10 +2234,9 @@ void __l2cap_connect_rsp_defer(struct l2cap_chan *chan)
 	l2cap_send_cmd(conn, chan->ident,
 				L2CAP_CONN_RSP, sizeof(rsp), &rsp);
 
-	if (chan->conf_state & L2CAP_CONF_REQ_SENT)
+	if (test_and_set_bit(CONF_REQ_SENT, &chan->conf_state))
 		return;
 
-	chan->conf_state |= L2CAP_CONF_REQ_SENT;
 	l2cap_send_cmd(conn, l2cap_get_ident(conn), L2CAP_CONF_REQ,
 			l2cap_build_conf_req(chan, buf), buf);
 	chan->num_conf_req++;
@@ -2420,10 +2418,10 @@ sendresp:
 					L2CAP_INFO_REQ, sizeof(info), &info);
 	}
 
-	if (chan && !(chan->conf_state & L2CAP_CONF_REQ_SENT) &&
+	if (chan && !test_bit(CONF_REQ_SENT, &chan->conf_state) &&
 				result == L2CAP_CR_SUCCESS) {
 		u8 buf[128];
-		chan->conf_state |= L2CAP_CONF_REQ_SENT;
+		set_bit(CONF_REQ_SENT, &chan->conf_state);
 		l2cap_send_cmd(conn, l2cap_get_ident(conn), L2CAP_CONF_REQ,
 					l2cap_build_conf_req(chan, buf), buf);
 		chan->num_conf_req++;
@@ -2464,20 +2462,18 @@ static inline int l2cap_connect_rsp(struct l2cap_conn *conn, struct l2cap_cmd_hd
 		l2cap_state_change(chan, BT_CONFIG);
 		chan->ident = 0;
 		chan->dcid = dcid;
-		chan->conf_state &= ~L2CAP_CONF_CONNECT_PEND;
+		clear_bit(CONF_CONNECT_PEND, &chan->conf_state);
 
-		if (chan->conf_state & L2CAP_CONF_REQ_SENT)
+		if (test_and_set_bit(CONF_REQ_SENT, &chan->conf_state))
 			break;
 
-		chan->conf_state |= L2CAP_CONF_REQ_SENT;
-
 		l2cap_send_cmd(conn, l2cap_get_ident(conn), L2CAP_CONF_REQ,
 					l2cap_build_conf_req(chan, req), req);
 		chan->num_conf_req++;
 		break;
 
 	case L2CAP_CR_PEND:
-		chan->conf_state |= L2CAP_CONF_CONNECT_PEND;
+		set_bit(CONF_CONNECT_PEND, &chan->conf_state);
 		break;
 
 	default:
@@ -2499,14 +2495,12 @@ static inline int l2cap_connect_rsp(struct l2cap_conn *conn, struct l2cap_cmd_hd
 
 static inline void set_default_fcs(struct l2cap_chan *chan)
 {
-	struct l2cap_pinfo *pi = l2cap_pi(chan->sk);
-
 	/* FCS is enabled only in ERTM or streaming mode, if one or both
 	 * sides request it.
 	 */
 	if (chan->mode != L2CAP_MODE_ERTM && chan->mode != L2CAP_MODE_STREAMING)
 		chan->fcs = L2CAP_FCS_NONE;
-	else if (!(pi->chan->conf_state & L2CAP_CONF_NO_FCS_RECV))
+	else if (!test_bit(CONF_NO_FCS_RECV, &chan->conf_state))
 		chan->fcs = L2CAP_FCS_CRC16;
 }
 
@@ -2573,10 +2567,10 @@ static inline int l2cap_config_req(struct l2cap_conn *conn, struct l2cap_cmd_hdr
 	/* Reset config buffer. */
 	chan->conf_len = 0;
 
-	if (!(chan->conf_state & L2CAP_CONF_OUTPUT_DONE))
+	if (!test_bit(CONF_OUTPUT_DONE, &chan->conf_state))
 		goto unlock;
 
-	if (chan->conf_state & L2CAP_CONF_INPUT_DONE) {
+	if (test_bit(CONF_INPUT_DONE, &chan->conf_state)) {
 		set_default_fcs(chan);
 
 		l2cap_state_change(chan, BT_CONNECTED);
@@ -2591,9 +2585,8 @@ static inline int l2cap_config_req(struct l2cap_conn *conn, struct l2cap_cmd_hdr
 		goto unlock;
 	}
 
-	if (!(chan->conf_state & L2CAP_CONF_REQ_SENT)) {
+	if (!test_and_set_bit(CONF_REQ_SENT, &chan->conf_state)) {
 		u8 buf[64];
-		chan->conf_state |= L2CAP_CONF_REQ_SENT;
 		l2cap_send_cmd(conn, l2cap_get_ident(conn), L2CAP_CONF_REQ,
 					l2cap_build_conf_req(chan, buf), buf);
 		chan->num_conf_req++;
@@ -2666,9 +2659,9 @@ static inline int l2cap_config_rsp(struct l2cap_conn *conn, struct l2cap_cmd_hdr
 	if (flags & 0x01)
 		goto done;
 
-	chan->conf_state |= L2CAP_CONF_INPUT_DONE;
+	set_bit(CONF_INPUT_DONE, &chan->conf_state);
 
-	if (chan->conf_state & L2CAP_CONF_OUTPUT_DONE) {
+	if (test_bit(CONF_OUTPUT_DONE, &chan->conf_state)) {
 		set_default_fcs(chan);
 
 		l2cap_state_change(chan, BT_CONNECTED);
@@ -4189,7 +4182,7 @@ static int l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
 			continue;
 		}
 
-		if (chan->conf_state & L2CAP_CONF_CONNECT_PEND) {
+		if (test_bit(CONF_CONNECT_PEND, &chan->conf_state)) {
 			bh_unlock_sock(sk);
 			continue;
 		}
@@ -4208,7 +4201,7 @@ static int l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
 				req.psm  = chan->psm;
 
 				chan->ident = l2cap_get_ident(conn);
-				chan->conf_state |= L2CAP_CONF_CONNECT_PEND;
+				set_bit(CONF_CONNECT_PEND, &chan->conf_state);
 
 				l2cap_send_cmd(conn, chan->ident,
 					L2CAP_CONN_REQ, sizeof(req), &req);
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 5c819e0..39082d4 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -512,7 +512,7 @@ static int l2cap_sock_setsockopt_old(struct socket *sock, int optname, char __us
 		chan->mode = opts.mode;
 		switch (chan->mode) {
 		case L2CAP_MODE_BASIC:
-			chan->conf_state &= ~L2CAP_CONF_STATE2_DEVICE;
+			clear_bit(CONF_STATE2_DEVICE, &chan->conf_state);
 			break;
 		case L2CAP_MODE_ERTM:
 		case L2CAP_MODE_STREAMING:
@@ -891,7 +891,7 @@ static void l2cap_sock_init(struct sock *sk, struct sock *parent)
 		chan->omtu = 0;
 		if (!disable_ertm && sk->sk_type == SOCK_STREAM) {
 			chan->mode = L2CAP_MODE_ERTM;
-			chan->conf_state |= L2CAP_CONF_STATE2_DEVICE;
+			set_bit(CONF_STATE2_DEVICE, &chan->conf_state);
 		} else {
 			chan->mode = L2CAP_MODE_BASIC;
 		}
-- 
1.7.5.1

