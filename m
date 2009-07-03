Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <gustavo@las.ic.unicamp.br>
To: marcel@holtmann.org
Cc: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: add support to configure ERTM and Streaming mode
Date: Fri,  3 Jul 2009 02:11:48 -0300
Message-Id: <1246597908-7314-1-git-send-email-gustavo@las.ic.unicamp.br>
List-ID: <linux-bluetooth.vger.kernel.org>

Add code to config_req and config_rsp to configure ERTM and Streaming
mode. If the remote devices specifies ERTM or Streaming Mode, we propose
the same mode received. Otherwise we propose ERTM or Basic Mode.
And if we are a state 2 device the remote should propose the same mode
that we sent, if not, the channel is disconnected.

Signed-off-by: Gustavo F. Padovan <gustavo@las.ic.unicamp.br>
---
 include/net/bluetooth/l2cap.h |   28 +++-
 net/bluetooth/l2cap.c         |  289 +++++++++++++++++++++++++++++++++++------
 2 files changed, 271 insertions(+), 46 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 06b072f..6fc7698 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -27,8 +27,9 @@
 
 /* L2CAP defaults */
 #define L2CAP_DEFAULT_MTU		672
+#define L2CAP_DEFAULT_MIN_MTU		48
 #define L2CAP_DEFAULT_FLUSH_TO		0xffff
-#define L2CAP_DEFAULT_RX_WINDOW		1
+#define L2CAP_DEFAULT_TX_WINDOW		1
 #define L2CAP_DEFAULT_MAX_RECEIVE	1
 #define L2CAP_DEFAULT_RETRANS_TO	300    /* 300 milliseconds */
 #define L2CAP_DEFAULT_MONITOR_TO	1000   /* 1 second */
@@ -272,6 +273,9 @@ struct l2cap_pinfo {
 	__u16		omtu;
 	__u16		flush_to;
 	__u8		mode;
+	__u8		num_conf_req;
+	__u8		num_conf_rsp;
+
 	__u8		fcs;
 	__u8		sec_level;
 	__u8		role_switch;
@@ -280,10 +284,15 @@ struct l2cap_pinfo {
 	__u8		conf_req[64];
 	__u8		conf_len;
 	__u8		conf_state;
-	__u8		conf_retry;
 
 	__u8		ident;
 
+	__u8		remote_tx_win;
+	__u8		remote_max_tx;
+	__u16		retrans_timeout;
+	__u16		monitor_timeout;
+	__u16		max_pdu_size;
+
 	__le16		sport;
 
 	struct l2cap_conn	*conn;
@@ -291,12 +300,17 @@ struct l2cap_pinfo {
 	struct sock		*prev_c;
 };
 
-#define L2CAP_CONF_REQ_SENT	0x01
-#define L2CAP_CONF_INPUT_DONE	0x02
-#define L2CAP_CONF_OUTPUT_DONE	0x04
-#define L2CAP_CONF_CONNECT_PEND	0x80
+#define L2CAP_CONF_REQ_SENT       0x01
+#define L2CAP_CONF_INPUT_DONE     0x02
+#define L2CAP_CONF_OUTPUT_DONE    0x04
+#define L2CAP_CONF_MTU_DONE       0x08
+#define L2CAP_CONF_MODE_DONE      0x10
+#define L2CAP_CONF_CONNECT_PEND   0x20
+#define L2CAP_CONF_STATE2_DEVICE  0x80
+
+#define L2CAP_CONF_MAX_CONF_REQ 2
+#define L2CAP_CONF_MAX_CONF_RSP 2
 
-#define L2CAP_CONF_MAX_RETRIES	2
 
 void l2cap_load(void);
 
diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index 7ce1a24..737a011 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -966,8 +966,10 @@ static int l2cap_sock_connect(struct socket *sock, struct sockaddr *addr, int al
 	case L2CAP_MODE_BASIC:
 		break;
 	case L2CAP_MODE_ERTM:
-		if (enable_ertm)
+	case L2CAP_MODE_STREAMING:
+		if (enable_ertm) {
 			break;
+		}
 		/* fall through */
 	default:
 		err = -ENOTSUPP;
@@ -1029,8 +1031,10 @@ static int l2cap_sock_listen(struct socket *sock, int backlog)
 	case L2CAP_MODE_BASIC:
 		break;
 	case L2CAP_MODE_ERTM:
-		if (enable_ertm)
+	case L2CAP_MODE_STREAMING:
+		if (enable_ertm) {
 			break;
+		}
 		/* fall through */
 	default:
 		err = -ENOTSUPP;
@@ -1739,15 +1743,64 @@ static void l2cap_add_conf_opt(void **ptr, u8 type, u8 len, unsigned long val)
 	*ptr += L2CAP_CONF_OPT_SIZE + len;
 }
 
-static int l2cap_build_conf_req(struct sock *sk, void *data)
+static int l2cap_mode_supported(__u8 mode, __u32 feat_mask)
+{
+	u32 local_feat_mask = l2cap_feat_mask;
+	if (enable_ertm)
+		local_feat_mask |= L2CAP_FEAT_ERTM;
+
+	switch (mode) {
+	case L2CAP_MODE_ERTM:
+		return L2CAP_FEAT_ERTM & feat_mask & local_feat_mask;
+	case L2CAP_MODE_STREAMING:
+		return L2CAP_FEAT_STREAMING & feat_mask & local_feat_mask;
+	default:
+		return 0x00;
+	}
+}
+
+static inline __u8 l2cap_select_mode(__u8 mode, __u16 remote_feat_mask)
+{
+	switch (mode) {
+	case L2CAP_MODE_STREAMING:
+	case L2CAP_MODE_ERTM:
+		if (l2cap_mode_supported(mode, remote_feat_mask))
+			return mode;
+		/* fall through */
+	default:
+		return L2CAP_MODE_BASIC;
+	}
+}
+
+static int l2cap_build_conf_req(struct sock *sk, struct l2cap_conn *conn, void *data)
 {
 	struct l2cap_pinfo *pi = l2cap_pi(sk);
 	struct l2cap_conf_req *req = data;
-	struct l2cap_conf_rfc rfc = { .mode = L2CAP_MODE_BASIC };
+	struct l2cap_conf_rfc rfc = { .mode = L2CAP_MODE_ERTM };
 	void *ptr = req->data;
 
 	BT_DBG("sk %p", sk);
 
+	if (pi->num_conf_req || pi->num_conf_rsp)
+		goto out;
+
+	switch (pi->mode) {
+	case L2CAP_MODE_STREAMING:
+	case L2CAP_MODE_ERTM:
+		pi->conf_state |= L2CAP_CONF_STATE2_DEVICE;
+		if (!l2cap_mode_supported(pi->mode, conn->feat_mask)) {
+			struct l2cap_disconn_req req;
+			req.dcid = cpu_to_le16(pi->dcid);
+			req.scid = cpu_to_le16(pi->scid);
+			l2cap_send_cmd(conn, l2cap_get_ident(conn),
+				L2CAP_DISCONN_REQ, sizeof(req), &req);
+		}
+		break;
+	default:
+		pi->mode = l2cap_select_mode(rfc.mode, conn->feat_mask);
+	}
+
+out:
 	switch (pi->mode) {
 	case L2CAP_MODE_BASIC:
 		if (pi->imtu != L2CAP_DEFAULT_MTU)
@@ -1756,14 +1809,26 @@ static int l2cap_build_conf_req(struct sock *sk, void *data)
 
 	case L2CAP_MODE_ERTM:
 		rfc.mode            = L2CAP_MODE_ERTM;
-		rfc.txwin_size      = L2CAP_DEFAULT_RX_WINDOW;
+		rfc.txwin_size      = L2CAP_DEFAULT_TX_WINDOW;
 		rfc.max_transmit    = L2CAP_DEFAULT_MAX_RECEIVE;
-		rfc.retrans_timeout = cpu_to_le16(L2CAP_DEFAULT_RETRANS_TO);
-		rfc.monitor_timeout = cpu_to_le16(L2CAP_DEFAULT_MONITOR_TO);
+		rfc.retrans_timeout = 0;
+		rfc.monitor_timeout = 0;
 		rfc.max_pdu_size    = cpu_to_le16(L2CAP_DEFAULT_MAX_RX_APDU);
 
-		l2cap_add_conf_opt(&ptr, L2CAP_CONF_RFC,
-					sizeof(rfc), (unsigned long) &rfc);
+		l2cap_add_conf_opt(&ptr, L2CAP_CONF_RFC, sizeof(rfc),
+				(unsigned long) &rfc);
+		break;
+
+	case L2CAP_MODE_STREAMING:
+		rfc.mode            = L2CAP_MODE_STREAMING;
+		rfc.txwin_size      = 0;
+		rfc.max_transmit    = 0;
+		rfc.retrans_timeout = 0;
+		rfc.monitor_timeout = 0;
+		rfc.max_pdu_size    = cpu_to_le16(L2CAP_DEFAULT_MAX_RX_APDU);
+
+		l2cap_add_conf_opt(&ptr, L2CAP_CONF_RFC, sizeof(rfc),
+				(unsigned long) &rfc);
 		break;
 	}
 
@@ -1777,7 +1842,7 @@ static int l2cap_build_conf_req(struct sock *sk, void *data)
 	return ptr - data;
 }
 
-static int l2cap_parse_conf_req(struct sock *sk, void *data)
+static int l2cap_parse_conf_req(struct sock *sk, struct l2cap_conn *conn, void *data, int *disconnect)
 {
 	struct l2cap_pinfo *pi = l2cap_pi(sk);
 	struct l2cap_conf_rsp *rsp = data;
@@ -1825,30 +1890,82 @@ static int l2cap_parse_conf_req(struct sock *sk, void *data)
 		}
 	}
 
+	if (pi->num_conf_rsp || pi->num_conf_req)
+		goto out;
+
+	switch (pi->mode) {
+	case L2CAP_MODE_STREAMING:
+	case L2CAP_MODE_ERTM:
+		pi->conf_state |= L2CAP_CONF_STATE2_DEVICE;
+		if (!l2cap_mode_supported(pi->mode, conn->feat_mask))
+			*disconnect = 1;
+		break;
+	default:
+		pi->mode = l2cap_select_mode(rfc.mode, conn->feat_mask);
+	}
+
+out:
+	if (pi->mode != rfc.mode) {
+		result = L2CAP_CONF_UNACCEPT;
+		rfc.mode = pi->mode;
+
+		if (pi->num_conf_rsp == 1)
+			*disconnect = 1;
+		else
+			l2cap_add_conf_opt(&ptr, L2CAP_CONF_RFC,
+				sizeof(rfc), (unsigned long) &rfc);
+	}
+
+
 	if (result == L2CAP_CONF_SUCCESS) {
 		/* Configure output options and let the other side know
 		 * which ones we don't like. */
 
-		if (rfc.mode == L2CAP_MODE_BASIC) {
-			if (mtu < pi->omtu)
-				result = L2CAP_CONF_UNACCEPT;
-			else {
-				pi->omtu = mtu;
-				pi->conf_state |= L2CAP_CONF_OUTPUT_DONE;
-			}
+		if (mtu < L2CAP_DEFAULT_MIN_MTU)
+			result = L2CAP_CONF_UNACCEPT;
+		else {
+			pi->omtu = mtu;
+			pi->conf_state |= L2CAP_CONF_MTU_DONE;
+		}
+		l2cap_add_conf_opt(&ptr, L2CAP_CONF_MTU, 2, pi->omtu);
 
-			l2cap_add_conf_opt(&ptr, L2CAP_CONF_MTU, 2, pi->omtu);
-		} else {
+		switch (rfc.mode) {
+		case L2CAP_MODE_BASIC:
+			pi->fcs = L2CAP_FCS_NONE;
+			pi->conf_state |= L2CAP_CONF_MODE_DONE;
+			break;
+
+		case L2CAP_MODE_ERTM:
+			pi->remote_tx_win = rfc.txwin_size;
+			pi->remote_max_tx = rfc.max_transmit;
+			pi->max_pdu_size = rfc.max_pdu_size;
+
+			rfc.retrans_timeout = L2CAP_DEFAULT_RETRANS_TO;
+			rfc.monitor_timeout = L2CAP_DEFAULT_MONITOR_TO;
+
+			pi->conf_state |= L2CAP_CONF_MODE_DONE;
+			break;
+
+		case L2CAP_MODE_STREAMING:
+			pi->remote_tx_win = rfc.txwin_size;
+			pi->max_pdu_size = rfc.max_pdu_size;
+
+			pi->conf_state |= L2CAP_CONF_MODE_DONE;
+			break;
+
+		default:
 			result = L2CAP_CONF_UNACCEPT;
 
 			memset(&rfc, 0, sizeof(rfc));
-			rfc.mode = L2CAP_MODE_BASIC;
-
-			l2cap_add_conf_opt(&ptr, L2CAP_CONF_RFC,
-					sizeof(rfc), (unsigned long) &rfc);
+			rfc.mode = pi->mode;
 		}
-	}
 
+		l2cap_add_conf_opt(&ptr, L2CAP_CONF_RFC,
+				sizeof(rfc), (unsigned long) &rfc);
+
+		if (result == L2CAP_CONF_SUCCESS)
+			pi->conf_state |= L2CAP_CONF_OUTPUT_DONE;
+	}
 	rsp->scid   = cpu_to_le16(pi->dcid);
 	rsp->result = cpu_to_le16(result);
 	rsp->flags  = cpu_to_le16(0x0000);
@@ -1856,6 +1973,73 @@ static int l2cap_parse_conf_req(struct sock *sk, void *data)
 	return ptr - data;
 }
 
+static int l2cap_parse_conf_rsp(struct sock *sk, void *rsp, int len, void *data, u16 *result, int *disconnect)
+{
+	struct l2cap_pinfo *pi = l2cap_pi(sk);
+	struct l2cap_conf_req *req = data;
+	void *ptr = req->data;
+	int type, olen;
+	unsigned long val;
+	struct l2cap_conf_rfc rfc;
+
+	BT_DBG("sk %p, rsp %p, len %d, req %p", sk, rsp, len, data);
+
+	while (len >= L2CAP_CONF_OPT_SIZE) {
+		len -= l2cap_get_conf_opt(&rsp, &type, &olen, &val);
+
+		switch (type) {
+		case L2CAP_CONF_MTU:
+			if (val < L2CAP_DEFAULT_MIN_MTU) {
+				*result = L2CAP_CONF_UNACCEPT;
+				pi->omtu = L2CAP_DEFAULT_MIN_MTU;
+			} else
+				pi->omtu = val;
+			l2cap_add_conf_opt(&ptr, L2CAP_CONF_MTU, 2, pi->omtu);
+			break;
+
+		case L2CAP_CONF_FLUSH_TO:
+			pi->flush_to = val;
+			l2cap_add_conf_opt(&ptr, L2CAP_CONF_FLUSH_TO, 2,
+						pi->flush_to);
+			break;
+
+		case L2CAP_CONF_RFC:
+			if (olen == sizeof(rfc))
+				memcpy(&rfc, (void *)val, olen);
+
+			if (rfc.mode != pi->mode &&
+				(pi->conf_state & L2CAP_CONF_STATE2_DEVICE))
+				*disconnect = 1;
+
+			pi->mode = rfc.mode;
+			pi->fcs = 0;
+
+			l2cap_add_conf_opt(&ptr, L2CAP_CONF_RFC,
+				sizeof(rfc), (unsigned long) &rfc);
+			break;
+		}
+	}
+
+	if (*result == L2CAP_CONF_SUCCESS) {
+		switch (rfc.mode) {
+		case L2CAP_MODE_ERTM:
+			pi->remote_tx_win   = rfc.txwin_size;
+			pi->retrans_timeout = rfc.retrans_timeout;
+			pi->monitor_timeout = rfc.monitor_timeout;
+			pi->max_pdu_size    = le16_to_cpu(rfc.max_pdu_size);
+			break;
+		case L2CAP_MODE_STREAMING:
+			pi->max_pdu_size    = le16_to_cpu(rfc.max_pdu_size);
+			break;
+		}
+	}
+
+	req->dcid   = cpu_to_le16(pi->dcid);
+	req->flags  = cpu_to_le16(0x0000);
+
+	return ptr - data;
+}
+
 static int l2cap_build_conf_rsp(struct sock *sk, void *data, u16 result, u16 flags)
 {
 	struct l2cap_conf_rsp *rsp = data;
@@ -2041,7 +2225,8 @@ static inline int l2cap_connect_rsp(struct l2cap_conn *conn, struct l2cap_cmd_hd
 		l2cap_pi(sk)->conf_state &= ~L2CAP_CONF_CONNECT_PEND;
 
 		l2cap_send_cmd(conn, l2cap_get_ident(conn), L2CAP_CONF_REQ,
-					l2cap_build_conf_req(sk, req), req);
+					l2cap_build_conf_req(sk, conn, req), req);
+		l2cap_pi(sk)->num_conf_req++;
 		break;
 
 	case L2CAP_CR_PEND:
@@ -2063,7 +2248,7 @@ static inline int l2cap_config_req(struct l2cap_conn *conn, struct l2cap_cmd_hdr
 	u16 dcid, flags;
 	u8 rsp[64];
 	struct sock *sk;
-	int len;
+	int len, disconn = 0;
 
 	dcid  = __le16_to_cpu(req->dcid);
 	flags = __le16_to_cpu(req->flags);
@@ -2099,11 +2284,21 @@ static inline int l2cap_config_req(struct l2cap_conn *conn, struct l2cap_cmd_hdr
 	}
 
 	/* Complete config. */
-	len = l2cap_parse_conf_req(sk, rsp);
+	len = l2cap_parse_conf_req(sk, conn, rsp, &disconn);
 	if (len < 0)
 		goto unlock;
 
-	l2cap_send_cmd(conn, cmd->ident, L2CAP_CONF_RSP, len, rsp);
+	if (disconn) {
+		struct l2cap_disconn_req req;
+		req.dcid = cpu_to_le16(l2cap_pi(sk)->dcid);
+		req.scid = cpu_to_le16(l2cap_pi(sk)->scid);
+		l2cap_send_cmd(conn, l2cap_get_ident(conn),
+				L2CAP_DISCONN_REQ, sizeof(req), &req);
+		goto unlock;
+	} else {
+		l2cap_send_cmd(conn, cmd->ident, L2CAP_CONF_RSP, len, rsp);
+		l2cap_pi(sk)->num_conf_rsp++;
+	}
 
 	/* Reset config buffer. */
 	l2cap_pi(sk)->conf_len = 0;
@@ -2120,7 +2315,9 @@ static inline int l2cap_config_req(struct l2cap_conn *conn, struct l2cap_cmd_hdr
 	if (!(l2cap_pi(sk)->conf_state & L2CAP_CONF_REQ_SENT)) {
 		u8 buf[64];
 		l2cap_send_cmd(conn, l2cap_get_ident(conn), L2CAP_CONF_REQ,
-					l2cap_build_conf_req(sk, buf), buf);
+					l2cap_build_conf_req(sk, conn, buf), buf);
+		l2cap_pi(sk)->num_conf_req++;
+
 	}
 
 unlock:
@@ -2133,6 +2330,7 @@ static inline int l2cap_config_rsp(struct l2cap_conn *conn, struct l2cap_cmd_hdr
 	struct l2cap_conf_rsp *rsp = (struct l2cap_conf_rsp *)data;
 	u16 scid, flags, result;
 	struct sock *sk;
+	int disconn = 0;
 
 	scid   = __le16_to_cpu(rsp->scid);
 	flags  = __le16_to_cpu(rsp->flags);
@@ -2150,16 +2348,29 @@ static inline int l2cap_config_rsp(struct l2cap_conn *conn, struct l2cap_cmd_hdr
 		break;
 
 	case L2CAP_CONF_UNACCEPT:
-		if (++l2cap_pi(sk)->conf_retry < L2CAP_CONF_MAX_RETRIES) {
-			char req[128];
-			/* It does not make sense to adjust L2CAP parameters
-			 * that are currently defined in the spec. We simply
-			 * resend config request that we sent earlier. It is
-			 * stupid, but it helps qualification testing which
-			 * expects at least some response from us. */
-			l2cap_send_cmd(conn, l2cap_get_ident(conn), L2CAP_CONF_REQ,
-						l2cap_build_conf_req(sk, req), req);
-			goto done;
+		if (l2cap_pi(sk)->num_conf_rsp <= L2CAP_CONF_MAX_CONF_RSP) {
+			int len = cmd->len - sizeof(*rsp);
+			char req[64];
+
+			/* throw out any old conf requests we stored */
+			result = L2CAP_CONF_SUCCESS;
+			len = l2cap_parse_conf_rsp(sk, rsp->data, len, req,
+					&result, &disconn);
+			if (disconn) {
+				struct l2cap_disconn_req req;
+				req.dcid = cpu_to_le16(l2cap_pi(sk)->dcid);
+				req.scid = cpu_to_le16(l2cap_pi(sk)->scid);
+				l2cap_send_cmd(conn, l2cap_get_ident(conn),
+					L2CAP_DISCONN_REQ, sizeof(req), &req);
+				goto done;
+			}
+
+			l2cap_send_cmd(conn, l2cap_get_ident(conn),
+						L2CAP_CONF_REQ, len, req);
+			l2cap_pi(sk)->num_conf_req++;
+			if (result != L2CAP_CONF_SUCCESS)
+				goto done;
+			break;
 		}
 
 	default:
-- 
1.6.0.6
