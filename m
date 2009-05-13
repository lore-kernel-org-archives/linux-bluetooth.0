Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <gustavo@las.ic.unicamp.br>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org
Subject: [PATCH] Bluetooth: add support to configure ERTM and Streaming mode, take 1
Date: Wed, 13 May 2009 01:20:02 -0300
Message-Id: <1242188402-17989-1-git-send-email-gustavo@las.ic.unicamp.br>
List-ID: <linux-bluetooth.vger.kernel.org>

Add code to config_req and config_rsp to configure ERTM and Streaming mode.
The code treat state1 and state2 devices as said in specification, also
uses the precendence list for state 1 device: Streaming mode, ERTM, Basic
Mode(highest).

Signed-off-by: Gustavo F. Padovan <gustavo@las.ic.unicamp.br>
---
 include/net/bluetooth/l2cap.h |   27 ++++-
 net/bluetooth/l2cap.c         |  271 ++++++++++++++++++++++++++++++++++++-----
 2 files changed, 267 insertions(+), 31 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 06b072f..1c85694 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -27,6 +27,7 @@
 
 /* L2CAP defaults */
 #define L2CAP_DEFAULT_MTU		672
+#define L2CAP_DEFAULT_MIN_MTU		48
 #define L2CAP_DEFAULT_FLUSH_TO		0xffff
 #define L2CAP_DEFAULT_RX_WINDOW		1
 #define L2CAP_DEFAULT_MAX_RECEIVE	1
@@ -272,6 +273,11 @@ struct l2cap_pinfo {
 	__u16		omtu;
 	__u16		flush_to;
 	__u8		mode;
+	__u8		state;
+	__u8		dev_type;
+	__u8		nr_conf_req;
+	__u8		nr_conf_rsp;
+
 	__u8		fcs;
 	__u8		sec_level;
 	__u8		role_switch;
@@ -280,10 +286,15 @@ struct l2cap_pinfo {
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
@@ -294,9 +305,21 @@ struct l2cap_pinfo {
 #define L2CAP_CONF_REQ_SENT	0x01
 #define L2CAP_CONF_INPUT_DONE	0x02
 #define L2CAP_CONF_OUTPUT_DONE	0x04
+#define L2CAP_CONF_MTU_DONE    0x04
+#define L2CAP_CONF_MODE_DONE   0x04
 #define L2CAP_CONF_CONNECT_PEND	0x80
 
-#define L2CAP_CONF_MAX_RETRIES	2
+#define L2CAP_CONF_MAX_CONF_REQ 2
+#define L2CAP_CONF_MAX_CONF_RSP 2
+
+#define L2CAP_CONF_STATE1_DEVICE 0x01
+#define L2CAP_CONF_STATE2_DEVICE 0x02
+#define L2CAP_CONF_STATE1_LOWER  0x03
+#define L2CAP_CONF_STATE1_HIGHER 0x04
+
+#define L2CAP_CONF_DEV_LOCAL 0x01
+#define L2CAP_CONF_DEV_REMOTE 0x02
+
 
 void l2cap_load(void);
 
diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index 82feeb7..44836bb 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -718,6 +718,7 @@ static void l2cap_sock_init(struct sock *sk, struct sock *parent)
 		pi->imtu = l2cap_pi(parent)->imtu;
 		pi->omtu = l2cap_pi(parent)->omtu;
 		pi->mode = l2cap_pi(parent)->mode;
+		pi->state = l2cap_pi(parent)->state;
 		pi->fcs  = l2cap_pi(parent)->fcs;
 		pi->sec_level = l2cap_pi(parent)->sec_level;
 		pi->role_switch = l2cap_pi(parent)->role_switch;
@@ -965,6 +966,7 @@ static int l2cap_sock_connect(struct socket *sock, struct sockaddr *addr, int al
 	case L2CAP_MODE_BASIC:
 		break;
 	case L2CAP_MODE_ERTM:
+	case L2CAP_MODE_STREAMING:
 		if (enable_ertm)
 			break;
 		/* fall through */
@@ -1028,6 +1030,7 @@ static int l2cap_sock_listen(struct socket *sock, int backlog)
 	case L2CAP_MODE_BASIC:
 		break;
 	case L2CAP_MODE_ERTM:
+	case L2CAP_MODE_STREAMING:
 		if (enable_ertm)
 			break;
 		/* fall through */
@@ -1297,6 +1300,11 @@ static int l2cap_sock_setsockopt_old(struct socket *sock, int optname, char __us
 		l2cap_pi(sk)->imtu = opts.imtu;
 		l2cap_pi(sk)->omtu = opts.omtu;
 		l2cap_pi(sk)->mode = opts.mode;
+		if (l2cap_pi(sk)->mode == L2CAP_MODE_ERTM ||
+				l2cap_pi(sk)->mode == L2CAP_MODE_STREAMING)
+			l2cap_pi(sk)->state = L2CAP_CONF_STATE2_DEVICE;
+		else
+			l2cap_pi(sk)->state = L2CAP_CONF_STATE1_DEVICE;
 		break;
 
 	case L2CAP_LM:
@@ -1738,7 +1746,50 @@ static void l2cap_add_conf_opt(void **ptr, u8 type, u8 len, unsigned long val)
 	*ptr += L2CAP_CONF_OPT_SIZE + len;
 }
 
-static int l2cap_build_conf_req(struct sock *sk, void *data)
+
+static __u32 l2cap_mode_to_feat_mask(__u8 mode)
+{
+	switch(mode) {
+	case L2CAP_MODE_ERTM:
+			return L2CAP_FEAT_ERTM;
+	case L2CAP_MODE_STREAMING:
+			return  L2CAP_FEAT_STREAMING;
+	default:
+			return  0x00;
+	}
+}
+
+static int l2cap_mode_supported(__u8 mode, __u32 feat_mask)
+{
+	return (l2cap_mode_to_feat_mask(mode) & feat_mask);
+}
+
+static __u8 l2cap_next_state1_mode_supported(__u16 local_feat_mask, __u16 remote_feat_mask)
+{
+	if (local_feat_mask & remote_feat_mask & L2CAP_FEAT_STREAMING)
+		return L2CAP_MODE_STREAMING;
+	else if (local_feat_mask & remote_feat_mask & L2CAP_FEAT_ERTM)
+		return L2CAP_MODE_ERTM;
+	else
+		return L2CAP_MODE_BASIC;
+}
+
+static int l2cap_get_state1_type(__u8 local_mode, __u8 remote_mode)
+{
+	if (remote_mode == L2CAP_MODE_STREAMING)
+		return L2CAP_CONF_STATE1_LOWER;
+	else if (remote_mode == L2CAP_MODE_ERTM) {
+		if (local_mode == L2CAP_MODE_STREAMING)
+			return L2CAP_CONF_STATE1_HIGHER;
+		else
+			return L2CAP_CONF_STATE1_LOWER;
+	}
+	else
+		return L2CAP_CONF_STATE1_HIGHER;
+}
+
+
+static int l2cap_build_conf_req(struct sock *sk, struct l2cap_conn *conn, void *data)
 {
 	struct l2cap_pinfo *pi = l2cap_pi(sk);
 	struct l2cap_conf_req *req = data;
@@ -1747,6 +1798,22 @@ static int l2cap_build_conf_req(struct sock *sk, void *data)
 
 	BT_DBG("sk %p", sk);
 
+	if (pi->nr_conf_req == 0 && pi->nr_conf_req == 0) {
+		if (pi->state == L2CAP_CONF_STATE2_DEVICE) {
+			if (!l2cap_mode_supported(pi->mode, conn->feat_mask) ||
+					!l2cap_mode_supported(pi->mode, l2cap_feat_mask)) {
+				struct l2cap_disconn_req req;
+				req.dcid = cpu_to_le16(pi->dcid);
+				req.scid = cpu_to_le16(pi->scid);
+				l2cap_send_cmd(conn, l2cap_get_ident(conn),
+						L2CAP_DISCONN_REQ, sizeof(req), &req);
+			}
+		}
+		else {
+			pi->mode = l2cap_next_state1_mode_supported(l2cap_feat_mask, conn->feat_mask);
+		}
+	}
+
 	switch (pi->mode) {
 	case L2CAP_MODE_BASIC:
 		if (pi->imtu != L2CAP_DEFAULT_MTU)
@@ -1760,11 +1827,20 @@ static int l2cap_build_conf_req(struct sock *sk, void *data)
 		rfc.retrans_timeout = cpu_to_le16(L2CAP_DEFAULT_RETRANS_TO);
 		rfc.monitor_timeout = cpu_to_le16(L2CAP_DEFAULT_MONITOR_TO);
 		rfc.max_pdu_size    = cpu_to_le16(L2CAP_DEFAULT_MAX_RX_APDU);
+		break;
 
-		l2cap_add_conf_opt(&ptr, L2CAP_CONF_RFC,
-					sizeof(rfc), (unsigned long) &rfc);
+	case L2CAP_MODE_STREAMING:
+		rfc.mode = L2CAP_MODE_STREAMING;
+		rfc.txwin_size = 0;
+		rfc.max_transmit = 0;
+		rfc.retrans_timeout = 0;
+		rfc.monitor_timeout = 0;
+		rfc.max_pdu_size = cpu_to_le16(L2CAP_DEFAULT_MAX_RX_APDU);
 		break;
 	}
+	if (rfc.mode)
+		l2cap_add_conf_opt(&ptr, L2CAP_CONF_RFC, sizeof(rfc),
+				(unsigned long) &rfc);
 
 	/* FIXME: Need actual value of the flush timeout */
 	//if (flush_to != L2CAP_DEFAULT_FLUSH_TO)
@@ -1776,7 +1852,7 @@ static int l2cap_build_conf_req(struct sock *sk, void *data)
 	return ptr - data;
 }
 
-static int l2cap_parse_conf_req(struct sock *sk, void *data)
+static int l2cap_parse_conf_req(struct sock *sk, struct l2cap_conn *conn, void *data, int *disconnect)
 {
 	struct l2cap_pinfo *pi = l2cap_pi(sk);
 	struct l2cap_conf_rsp *rsp = data;
@@ -1824,24 +1900,70 @@ static int l2cap_parse_conf_req(struct sock *sk, void *data)
 		}
 	}
 
+	if (pi->nr_conf_rsp == 0 && pi->nr_conf_req == 0) {
+		if (pi->state == L2CAP_CONF_STATE2_DEVICE) {
+			if (!l2cap_mode_supported(pi->mode, conn->feat_mask) ||
+					!l2cap_mode_supported(pi->mode, l2cap_feat_mask)) {
+				*disconnect = 1;
+			}
+		}
+		else {
+			pi->mode = l2cap_next_state1_mode_supported(l2cap_feat_mask, conn->feat_mask);
+		}
+	}
+
+	if (pi->mode != rfc.mode) {
+		result = L2CAP_CONF_UNACCEPT;
+		rfc.mode = pi->mode;
+		pi->state = l2cap_get_state1_type(pi->mode, rfc.mode);
+
+		if (pi->nr_conf_rsp == 0) {
+			if (pi->dev_type == L2CAP_CONF_DEV_REMOTE &&
+					pi->state == L2CAP_CONF_STATE1_LOWER)
+				*disconnect = 1;
+		}
+		else
+			*disconnect = 1;
+
+		/*FIXME: when disconnecting we don't need this */
+		l2cap_add_conf_opt(&ptr, L2CAP_CONF_RFC,
+				sizeof(rfc), (unsigned long) &rfc);
+	}
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
+	   if (mtu < L2CAP_DEFAULT_MIN_MTU)
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
+			pi->fcs = 0;
+			pi->conf_state |= L2CAP_CONF_MODE_DONE;
+			break;
+
+		case L2CAP_MODE_ERTM:
+		case L2CAP_MODE_STREAMING:
+			pi->remote_tx_win = rfc.txwin_size;
+			pi->remote_max_tx = rfc.max_transmit;
+			pi->retrans_timeout = rfc.retrans_timeout;
+			pi->monitor_timeout = rfc.monitor_timeout;
+			pi->max_pdu_size = rfc.max_pdu_size;
+
+			pi->conf_state |= L2CAP_CONF_MODE_DONE;
+			break;
+
+		default:
 			result = L2CAP_CONF_UNACCEPT;
 
 			memset(&rfc, 0, sizeof(rfc));
-			rfc.mode = L2CAP_MODE_BASIC;
+			rfc.mode = pi->mode;
 
 			l2cap_add_conf_opt(&ptr, L2CAP_CONF_RFC,
 					sizeof(rfc), (unsigned long) &rfc);
@@ -1855,6 +1977,66 @@ static int l2cap_parse_conf_req(struct sock *sk, void *data)
 	return ptr - data;
 }
 
+static int l2cap_parse_conf_rsp(struct sock *sk, void *rsp, int len, void *_req, u16 *result, int *disconnect)
+{
+	struct l2cap_pinfo *pi = l2cap_pi(sk);
+	struct l2cap_conf_req *req = _req;
+	void *ptr = req->data;
+	int type, olen;
+	unsigned long val;
+	struct l2cap_conf_rfc rfc;
+
+	BT_DBG("sk %p, rsp %p, len %d, req %p", sk, rsp, len, _req);
+
+	while (len >= L2CAP_CONF_OPT_SIZE) {
+		len -= l2cap_get_conf_opt(&rsp, &type, &olen, &val);
+
+		switch (type) {
+		case L2CAP_CONF_MTU:
+			if (val < L2CAP_DEFAULT_MIN_MTU)
+			{
+				*result = L2CAP_CONF_UNACCEPT;
+				pi->omtu = L2CAP_DEFAULT_MIN_MTU;
+			}
+			else
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
+			if (olen == sizeof(rfc)) {
+				memcpy(&rfc, (void *) val, olen);
+			}
+			*result = L2CAP_CONF_UNACCEPT;
+			if ((rfc.mode != pi->mode) &&
+					(pi->state == L2CAP_CONF_STATE2_DEVICE)) {
+				*disconnect = 1;
+			}
+			if (pi->mode == L2CAP_MODE_BASIC)
+				pi->fcs = 0;
+			pi->mode = rfc.mode;
+			l2cap_add_conf_opt(&ptr, L2CAP_CONF_RFC,
+						sizeof(rfc), (unsigned long) &rfc);
+			break;
+		}
+	}
+
+	req->dcid   = cpu_to_le16(pi->dcid);
+	req->flags  = cpu_to_le16(0x0000);
+
+	return ptr - _req;
+}
+
+
+
+
+
 static int l2cap_build_conf_rsp(struct sock *sk, void *data, u16 result, u16 flags)
 {
 	struct l2cap_conf_rsp *rsp = data;
@@ -2040,7 +2222,9 @@ static inline int l2cap_connect_rsp(struct l2cap_conn *conn, struct l2cap_cmd_hd
 		l2cap_pi(sk)->conf_state &= ~L2CAP_CONF_CONNECT_PEND;
 
 		l2cap_send_cmd(conn, l2cap_get_ident(conn), L2CAP_CONF_REQ,
-					l2cap_build_conf_req(sk, req), req);
+					l2cap_build_conf_req(sk, conn, req), req);
+		l2cap_pi(sk)->nr_conf_req++;
+		l2cap_pi(sk)->dev_type = L2CAP_CONF_DEV_LOCAL;
 		break;
 
 	case L2CAP_CR_PEND:
@@ -2062,7 +2246,7 @@ static inline int l2cap_config_req(struct l2cap_conn *conn, struct l2cap_cmd_hdr
 	u16 dcid, flags;
 	u8 rsp[64];
 	struct sock *sk;
-	int len;
+	int len, disconn = 0;
 
 	dcid  = __le16_to_cpu(req->dcid);
 	flags = __le16_to_cpu(req->flags);
@@ -2098,11 +2282,22 @@ static inline int l2cap_config_req(struct l2cap_conn *conn, struct l2cap_cmd_hdr
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
+	}
+	else {
+		l2cap_send_cmd(conn, cmd->ident, L2CAP_CONF_RSP, len, rsp);
+		l2cap_pi(sk)->nr_conf_rsp++;
+	}
 
 	/* Reset config buffer. */
 	l2cap_pi(sk)->conf_len = 0;
@@ -2119,7 +2314,10 @@ static inline int l2cap_config_req(struct l2cap_conn *conn, struct l2cap_cmd_hdr
 	if (!(l2cap_pi(sk)->conf_state & L2CAP_CONF_REQ_SENT)) {
 		u8 buf[64];
 		l2cap_send_cmd(conn, l2cap_get_ident(conn), L2CAP_CONF_REQ,
-					l2cap_build_conf_req(sk, buf), buf);
+					l2cap_build_conf_req(sk, conn, buf), buf);
+		l2cap_pi(sk)->nr_conf_req++;
+		l2cap_pi(sk)->dev_type = L2CAP_CONF_DEV_REMOTE;
+
 	}
 
 unlock:
@@ -2132,6 +2330,7 @@ static inline int l2cap_config_rsp(struct l2cap_conn *conn, struct l2cap_cmd_hdr
 	struct l2cap_conf_rsp *rsp = (struct l2cap_conf_rsp *)data;
 	u16 scid, flags, result;
 	struct sock *sk;
+	int disconn;
 
 	scid   = __le16_to_cpu(rsp->scid);
 	flags  = __le16_to_cpu(rsp->flags);
@@ -2149,16 +2348,30 @@ static inline int l2cap_config_rsp(struct l2cap_conn *conn, struct l2cap_cmd_hdr
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
+		if (l2cap_pi(sk)->nr_conf_rsp <= L2CAP_CONF_MAX_CONF_RSP) {
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
+						L2CAP_DISCONN_REQ, sizeof(req), &req);
+				goto done;
+			}
+
+			l2cap_send_cmd(conn, l2cap_get_ident(conn),
+						L2CAP_CONF_REQ, len, req);
+			l2cap_pi(sk)->nr_conf_req++;
+			if (result == L2CAP_CONF_SUCCESS)
+				break;
+			else
+				goto done;
 		}
 
 	default:
-- 
1.6.0.6
