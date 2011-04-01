Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 05/15] Bluetooth: Move conf_{req,rsp} stuff to struct l2cap_chan
Date: Fri,  1 Apr 2011 19:33:10 -0300
Message-Id: <1301697200-2446-6-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1301697200-2446-5-git-send-email-padovan@profusion.mobi>
References: <1301697200-2446-1-git-send-email-padovan@profusion.mobi>
 <1301697200-2446-2-git-send-email-padovan@profusion.mobi>
 <1301697200-2446-3-git-send-email-padovan@profusion.mobi>
 <1301697200-2446-4-git-send-email-padovan@profusion.mobi>
 <1301697200-2446-5-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

They are also l2cap_chan specific.

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 include/net/bluetooth/l2cap.h |   11 ++++---
 net/bluetooth/l2cap_core.c    |   55 +++++++++++++++++++++--------------------
 net/bluetooth/l2cap_sock.c    |    8 +++---
 3 files changed, 38 insertions(+), 36 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 81829e5..bf91828 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -281,6 +281,11 @@ struct l2cap_chan {
 	struct sock *sk;
 	__u8		ident;
 
+	__u8		conf_req[64];
+	__u8		conf_len;
+	__u8		num_conf_req;
+	__u8		num_conf_rsp;
+
 	struct list_head list;
 };
 
@@ -337,8 +342,6 @@ struct l2cap_pinfo {
 	__u16		omtu;
 	__u16		flush_to;
 	__u8		mode;
-	__u8		num_conf_req;
-	__u8		num_conf_rsp;
 
 	__u8		fcs;
 	__u8		sec_level;
@@ -346,8 +349,6 @@ struct l2cap_pinfo {
 	__u8		force_reliable;
 	__u8		flushable;
 
-	__u8		conf_req[64];
-	__u8		conf_len;
 	__u8		conf_state;
 	__u16		conn_state;
 
@@ -447,7 +448,7 @@ void l2cap_cleanup_sockets(void);
 
 u8 l2cap_get_ident(struct l2cap_conn *conn);
 void l2cap_send_cmd(struct l2cap_conn *conn, u8 ident, u8 code, u16 len, void *data);
-int l2cap_build_conf_req(struct sock *sk, void *data);
+int l2cap_build_conf_req(struct l2cap_chan *chan, void *data);
 int __l2cap_wait_ack(struct sock *sk);
 
 struct sk_buff *l2cap_create_connless_pdu(struct sock *sk, struct msghdr *msg, size_t len);
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 778b30b..95e488f 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -569,8 +569,8 @@ static void l2cap_conn_start(struct l2cap_conn *conn)
 
 			l2cap_pi(sk)->conf_state |= L2CAP_CONF_REQ_SENT;
 			l2cap_send_cmd(conn, l2cap_get_ident(conn), L2CAP_CONF_REQ,
-						l2cap_build_conf_req(sk, buf), buf);
-			l2cap_pi(sk)->num_conf_req++;
+						l2cap_build_conf_req(chan, buf), buf);
+			chan->num_conf_req++;
 		}
 
 		bh_unlock_sock(sk);
@@ -1599,8 +1599,9 @@ static inline __u8 l2cap_select_mode(__u8 mode, __u16 remote_feat_mask)
 	}
 }
 
-int l2cap_build_conf_req(struct sock *sk, void *data)
+int l2cap_build_conf_req(struct l2cap_chan *chan, void *data)
 {
+	struct sock *sk = chan->sk;
 	struct l2cap_pinfo *pi = l2cap_pi(sk);
 	struct l2cap_conf_req *req = data;
 	struct l2cap_conf_rfc rfc = { .mode = pi->mode };
@@ -1608,7 +1609,7 @@ int l2cap_build_conf_req(struct sock *sk, void *data)
 
 	BT_DBG("sk %p", sk);
 
-	if (pi->num_conf_req || pi->num_conf_rsp)
+	if (chan->num_conf_req || chan->num_conf_rsp)
 		goto done;
 
 	switch (pi->mode) {
@@ -1697,20 +1698,20 @@ done:
 	return ptr - data;
 }
 
-static int l2cap_parse_conf_req(struct sock *sk, void *data)
+static int l2cap_parse_conf_req(struct l2cap_chan *chan, void *data)
 {
-	struct l2cap_pinfo *pi = l2cap_pi(sk);
+	struct l2cap_pinfo *pi = l2cap_pi(chan->sk);
 	struct l2cap_conf_rsp *rsp = data;
 	void *ptr = rsp->data;
-	void *req = pi->conf_req;
-	int len = pi->conf_len;
+	void *req = chan->conf_req;
+	int len = chan->conf_len;
 	int type, hint, olen;
 	unsigned long val;
 	struct l2cap_conf_rfc rfc = { .mode = L2CAP_MODE_BASIC };
 	u16 mtu = L2CAP_DEFAULT_MTU;
 	u16 result = L2CAP_CONF_SUCCESS;
 
-	BT_DBG("sk %p", sk);
+	BT_DBG("chan %p", chan);
 
 	while (len >= L2CAP_CONF_OPT_SIZE) {
 		len -= l2cap_get_conf_opt(&req, &type, &olen, &val);
@@ -1751,7 +1752,7 @@ static int l2cap_parse_conf_req(struct sock *sk, void *data)
 		}
 	}
 
-	if (pi->num_conf_rsp || pi->num_conf_req > 1)
+	if (chan->num_conf_rsp || chan->num_conf_req > 1)
 		goto done;
 
 	switch (pi->mode) {
@@ -1774,7 +1775,7 @@ done:
 		result = L2CAP_CONF_UNACCEPT;
 		rfc.mode = pi->mode;
 
-		if (pi->num_conf_rsp == 1)
+		if (chan->num_conf_rsp == 1)
 			return -ECONNREFUSED;
 
 		l2cap_add_conf_opt(&ptr, L2CAP_CONF_RFC,
@@ -1993,7 +1994,7 @@ static inline int l2cap_connect_req(struct l2cap_conn *conn, struct l2cap_cmd_hd
 {
 	struct l2cap_conn_req *req = (struct l2cap_conn_req *) data;
 	struct l2cap_conn_rsp rsp;
-	struct l2cap_chan *chan;
+	struct l2cap_chan *chan = NULL;
 	struct sock *parent, *sk = NULL;
 	int result, status = L2CAP_CS_NO_INFO;
 
@@ -2116,13 +2117,13 @@ sendresp:
 					L2CAP_INFO_REQ, sizeof(info), &info);
 	}
 
-	if (sk && !(l2cap_pi(sk)->conf_state & L2CAP_CONF_REQ_SENT) &&
+	if (chan && !(l2cap_pi(sk)->conf_state & L2CAP_CONF_REQ_SENT) &&
 				result == L2CAP_CR_SUCCESS) {
 		u8 buf[128];
 		l2cap_pi(sk)->conf_state |= L2CAP_CONF_REQ_SENT;
 		l2cap_send_cmd(conn, l2cap_get_ident(conn), L2CAP_CONF_REQ,
-					l2cap_build_conf_req(sk, buf), buf);
-		l2cap_pi(sk)->num_conf_req++;
+					l2cap_build_conf_req(chan, buf), buf);
+		chan->num_conf_req++;
 	}
 
 	return 0;
@@ -2168,8 +2169,8 @@ static inline int l2cap_connect_rsp(struct l2cap_conn *conn, struct l2cap_cmd_hd
 		l2cap_pi(sk)->conf_state |= L2CAP_CONF_REQ_SENT;
 
 		l2cap_send_cmd(conn, l2cap_get_ident(conn), L2CAP_CONF_REQ,
-					l2cap_build_conf_req(sk, req), req);
-		l2cap_pi(sk)->num_conf_req++;
+					l2cap_build_conf_req(chan, req), req);
+		chan->num_conf_req++;
 		break;
 
 	case L2CAP_CR_PEND:
@@ -2235,7 +2236,7 @@ static inline int l2cap_config_req(struct l2cap_conn *conn, struct l2cap_cmd_hdr
 
 	/* Reject if config buffer is too small. */
 	len = cmd_len - sizeof(*req);
-	if (l2cap_pi(sk)->conf_len + len > sizeof(l2cap_pi(sk)->conf_req)) {
+	if (chan->conf_len + len > sizeof(chan->conf_req)) {
 		l2cap_send_cmd(conn, cmd->ident, L2CAP_CONF_RSP,
 				l2cap_build_conf_rsp(sk, rsp,
 					L2CAP_CONF_REJECT, flags), rsp);
@@ -2243,8 +2244,8 @@ static inline int l2cap_config_req(struct l2cap_conn *conn, struct l2cap_cmd_hdr
 	}
 
 	/* Store config. */
-	memcpy(l2cap_pi(sk)->conf_req + l2cap_pi(sk)->conf_len, req->data, len);
-	l2cap_pi(sk)->conf_len += len;
+	memcpy(chan->conf_req + chan->conf_len, req->data, len);
+	chan->conf_len += len;
 
 	if (flags & 0x0001) {
 		/* Incomplete config. Send empty response. */
@@ -2255,17 +2256,17 @@ static inline int l2cap_config_req(struct l2cap_conn *conn, struct l2cap_cmd_hdr
 	}
 
 	/* Complete config. */
-	len = l2cap_parse_conf_req(sk, rsp);
+	len = l2cap_parse_conf_req(chan, rsp);
 	if (len < 0) {
 		l2cap_send_disconn_req(conn, sk, ECONNRESET);
 		goto unlock;
 	}
 
 	l2cap_send_cmd(conn, cmd->ident, L2CAP_CONF_RSP, len, rsp);
-	l2cap_pi(sk)->num_conf_rsp++;
+	chan->num_conf_rsp++;
 
 	/* Reset config buffer. */
-	l2cap_pi(sk)->conf_len = 0;
+	chan->conf_len = 0;
 
 	if (!(l2cap_pi(sk)->conf_state & L2CAP_CONF_OUTPUT_DONE))
 		goto unlock;
@@ -2289,8 +2290,8 @@ static inline int l2cap_config_req(struct l2cap_conn *conn, struct l2cap_cmd_hdr
 		u8 buf[64];
 		l2cap_pi(sk)->conf_state |= L2CAP_CONF_REQ_SENT;
 		l2cap_send_cmd(conn, l2cap_get_ident(conn), L2CAP_CONF_REQ,
-					l2cap_build_conf_req(sk, buf), buf);
-		l2cap_pi(sk)->num_conf_req++;
+					l2cap_build_conf_req(chan, buf), buf);
+		chan->num_conf_req++;
 	}
 
 unlock:
@@ -2325,7 +2326,7 @@ static inline int l2cap_config_rsp(struct l2cap_conn *conn, struct l2cap_cmd_hdr
 		break;
 
 	case L2CAP_CONF_UNACCEPT:
-		if (l2cap_pi(sk)->num_conf_rsp <= L2CAP_CONF_MAX_CONF_RSP) {
+		if (chan->num_conf_rsp <= L2CAP_CONF_MAX_CONF_RSP) {
 			char req[64];
 
 			if (len > sizeof(req) - sizeof(struct l2cap_conf_req)) {
@@ -2344,7 +2345,7 @@ static inline int l2cap_config_rsp(struct l2cap_conn *conn, struct l2cap_cmd_hdr
 
 			l2cap_send_cmd(conn, l2cap_get_ident(conn),
 						L2CAP_CONF_REQ, len, req);
-			l2cap_pi(sk)->num_conf_req++;
+			chan->num_conf_req++;
 			if (result != L2CAP_CONF_SUCCESS)
 				goto done;
 			break;
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index cad4bc7..244475e 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -810,6 +810,7 @@ static int l2cap_sock_recvmsg(struct kiocb *iocb, struct socket *sock, struct ms
 	if (sk->sk_state == BT_CONNECT2 && bt_sk(sk)->defer_setup) {
 		struct l2cap_conn_rsp rsp;
 		struct l2cap_conn *conn = l2cap_pi(sk)->conn;
+		struct l2cap_chan *chan = l2cap_pi(sk)->chan;
 		u8 buf[128];
 
 		sk->sk_state = BT_CONFIG;
@@ -818,7 +819,7 @@ static int l2cap_sock_recvmsg(struct kiocb *iocb, struct socket *sock, struct ms
 		rsp.dcid   = cpu_to_le16(l2cap_pi(sk)->scid);
 		rsp.result = cpu_to_le16(L2CAP_CR_SUCCESS);
 		rsp.status = cpu_to_le16(L2CAP_CS_NO_INFO);
-		l2cap_send_cmd(l2cap_pi(sk)->conn, l2cap_pi(sk)->chan->ident,
+		l2cap_send_cmd(l2cap_pi(sk)->conn, chan->ident,
 					L2CAP_CONN_RSP, sizeof(rsp), &rsp);
 
 		if (l2cap_pi(sk)->conf_state & L2CAP_CONF_REQ_SENT) {
@@ -828,8 +829,8 @@ static int l2cap_sock_recvmsg(struct kiocb *iocb, struct socket *sock, struct ms
 
 		l2cap_pi(sk)->conf_state |= L2CAP_CONF_REQ_SENT;
 		l2cap_send_cmd(conn, l2cap_get_ident(conn), L2CAP_CONF_REQ,
-				l2cap_build_conf_req(sk, buf), buf);
-		l2cap_pi(sk)->num_conf_req++;
+				l2cap_build_conf_req(chan, buf), buf);
+		chan->num_conf_req++;
 
 		release_sock(sk);
 		return 0;
@@ -1035,7 +1036,6 @@ void l2cap_sock_init(struct sock *sk, struct sock *parent)
 	}
 
 	/* Default config options */
-	pi->conf_len = 0;
 	pi->flush_to = L2CAP_DEFAULT_FLUSH_TO;
 	skb_queue_head_init(TX_QUEUE(sk));
 	skb_queue_head_init(SREJ_QUEUE(sk));
-- 
1.7.4.1

