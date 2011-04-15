Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 7/8] Bluetooth: Move more vars to struct l2cap_chan
Date: Fri, 15 Apr 2011 15:17:33 -0300
Message-Id: <1302891454-10165-8-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1302891454-10165-7-git-send-email-padovan@profusion.mobi>
References: <1302891454-10165-1-git-send-email-padovan@profusion.mobi>
 <1302891454-10165-2-git-send-email-padovan@profusion.mobi>
 <1302891454-10165-3-git-send-email-padovan@profusion.mobi>
 <1302891454-10165-4-git-send-email-padovan@profusion.mobi>
 <1302891454-10165-5-git-send-email-padovan@profusion.mobi>
 <1302891454-10165-6-git-send-email-padovan@profusion.mobi>
 <1302891454-10165-7-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In this commit, psm, scid and dcid.

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 include/net/bluetooth/l2cap.h |   10 ++--
 net/bluetooth/l2cap_core.c    |  116 +++++++++++++++++++++--------------------
 net/bluetooth/l2cap_sock.c    |   26 +++++-----
 3 files changed, 77 insertions(+), 75 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 7522835..fd199cd 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -284,6 +284,9 @@ struct srej_list {
 
 struct l2cap_chan {
 	struct sock *sk;
+	__le16		psm;
+	__u16		dcid;
+	__u16		scid;
 
 	__u16		imtu;
 	__u16		omtu;
@@ -382,9 +385,6 @@ struct l2cap_conn {
 
 struct l2cap_pinfo {
 	struct bt_sock	bt;
-	__le16		psm;
-	__u16		dcid;
-	__u16		scid;
 
 	struct l2cap_conn	*conn;
 	struct l2cap_chan	*chan;
@@ -450,8 +450,8 @@ void l2cap_send_cmd(struct l2cap_conn *conn, u8 ident, u8 code, u16 len, void *d
 void __l2cap_connect_rsp_defer(struct sock *sk);
 int __l2cap_wait_ack(struct sock *sk);
 
-struct sk_buff *l2cap_create_connless_pdu(struct sock *sk, struct msghdr *msg, size_t len);
-struct sk_buff *l2cap_create_basic_pdu(struct sock *sk, struct msghdr *msg, size_t len);
+struct sk_buff *l2cap_create_connless_pdu(struct l2cap_chan *chan, struct msghdr *msg, size_t len);
+struct sk_buff *l2cap_create_basic_pdu(struct l2cap_chan *chan, struct msghdr *msg, size_t len);
 struct sk_buff *l2cap_create_iframe_pdu(struct l2cap_chan *chan, struct msghdr *msg, size_t len, u16 control, u16 sdulen);
 int l2cap_sar_segment_sdu(struct l2cap_chan *chan, struct msghdr *msg, size_t len);
 void l2cap_do_send(struct l2cap_chan *chan, struct sk_buff *skb);
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index c267244..3ff8840 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -80,8 +80,7 @@ static struct l2cap_chan *__l2cap_get_chan_by_dcid(struct l2cap_conn *conn, u16
 	struct l2cap_chan *c;
 
 	list_for_each_entry(c, &conn->chan_l, list) {
-		struct sock *s = c->sk;
-		if (l2cap_pi(s)->dcid == cid)
+		if (c->dcid == cid)
 			return c;
 	}
 	return NULL;
@@ -93,8 +92,7 @@ static struct l2cap_chan *__l2cap_get_chan_by_scid(struct l2cap_conn *conn, u16
 	struct l2cap_chan *c;
 
 	list_for_each_entry(c, &conn->chan_l, list) {
-		struct sock *s = c->sk;
-		if (l2cap_pi(s)->scid == cid)
+		if (c->scid == cid)
 			return c;
 	}
 	return NULL;
@@ -167,7 +165,7 @@ static void __l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan)
 	struct sock *sk = chan->sk;
 
 	BT_DBG("conn %p, psm 0x%2.2x, dcid 0x%4.4x", conn,
-			l2cap_pi(sk)->psm, l2cap_pi(sk)->dcid);
+			chan->psm, chan->dcid);
 
 	conn->disc_reason = 0x13;
 
@@ -177,22 +175,22 @@ static void __l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan)
 		if (conn->hcon->type == LE_LINK) {
 			/* LE connection */
 			chan->omtu = L2CAP_LE_DEFAULT_MTU;
-			l2cap_pi(sk)->scid = L2CAP_CID_LE_DATA;
-			l2cap_pi(sk)->dcid = L2CAP_CID_LE_DATA;
+			chan->scid = L2CAP_CID_LE_DATA;
+			chan->dcid = L2CAP_CID_LE_DATA;
 		} else {
 			/* Alloc CID for connection-oriented socket */
-			l2cap_pi(sk)->scid = l2cap_alloc_cid(conn);
+			chan->scid = l2cap_alloc_cid(conn);
 			chan->omtu = L2CAP_DEFAULT_MTU;
 		}
 	} else if (sk->sk_type == SOCK_DGRAM) {
 		/* Connectionless socket */
-		l2cap_pi(sk)->scid = L2CAP_CID_CONN_LESS;
-		l2cap_pi(sk)->dcid = L2CAP_CID_CONN_LESS;
+		chan->scid = L2CAP_CID_CONN_LESS;
+		chan->dcid = L2CAP_CID_CONN_LESS;
 		chan->omtu = L2CAP_DEFAULT_MTU;
 	} else {
 		/* Raw socket can send/recv signalling messages only */
-		l2cap_pi(sk)->scid = L2CAP_CID_SIGNALING;
-		l2cap_pi(sk)->dcid = L2CAP_CID_SIGNALING;
+		chan->scid = L2CAP_CID_SIGNALING;
+		chan->dcid = L2CAP_CID_SIGNALING;
 		chan->omtu = L2CAP_DEFAULT_MTU;
 	}
 
@@ -275,7 +273,7 @@ static inline u8 l2cap_get_auth_type(struct l2cap_chan *chan)
 		default:
 			return HCI_AT_NO_BONDING;
 		}
-	} else if (l2cap_pi(sk)->psm == cpu_to_le16(0x0001)) {
+	} else if (chan->psm == cpu_to_le16(0x0001)) {
 		if (chan->sec_level == BT_SECURITY_LOW)
 			chan->sec_level = BT_SECURITY_SDP;
 
@@ -383,7 +381,7 @@ static inline void l2cap_send_sframe(struct l2cap_chan *chan, u16 control)
 
 	lh = (struct l2cap_hdr *) skb_put(skb, L2CAP_HDR_SIZE);
 	lh->len = cpu_to_le16(hlen - L2CAP_HDR_SIZE);
-	lh->cid = cpu_to_le16(pi->dcid);
+	lh->cid = cpu_to_le16(chan->dcid);
 	put_unaligned_le16(control, skb_put(skb, 2));
 
 	if (chan->fcs == L2CAP_FCS_CRC16) {
@@ -429,8 +427,8 @@ static void l2cap_do_start(struct l2cap_chan *chan)
 		if (l2cap_check_security(chan) &&
 				__l2cap_no_conn_pending(chan)) {
 			struct l2cap_conn_req req;
-			req.scid = cpu_to_le16(l2cap_pi(sk)->scid);
-			req.psm  = l2cap_pi(sk)->psm;
+			req.scid = cpu_to_le16(chan->scid);
+			req.psm  = chan->psm;
 
 			chan->ident = l2cap_get_ident(conn);
 			chan->conf_state |= L2CAP_CONF_CONNECT_PEND;
@@ -485,8 +483,8 @@ void l2cap_send_disconn_req(struct l2cap_conn *conn, struct l2cap_chan *chan, in
 		del_timer(&chan->ack_timer);
 	}
 
-	req.dcid = cpu_to_le16(l2cap_pi(sk)->dcid);
-	req.scid = cpu_to_le16(l2cap_pi(sk)->scid);
+	req.dcid = cpu_to_le16(chan->dcid);
+	req.scid = cpu_to_le16(chan->scid);
 	l2cap_send_cmd(conn, l2cap_get_ident(conn),
 			L2CAP_DISCONN_REQ, sizeof(req), &req);
 
@@ -536,8 +534,8 @@ static void l2cap_conn_start(struct l2cap_conn *conn)
 				continue;
 			}
 
-			req.scid = cpu_to_le16(l2cap_pi(sk)->scid);
-			req.psm  = l2cap_pi(sk)->psm;
+			req.scid = cpu_to_le16(chan->scid);
+			req.psm  = chan->psm;
 
 			chan->ident = l2cap_get_ident(conn);
 			chan->conf_state |= L2CAP_CONF_CONNECT_PEND;
@@ -548,8 +546,8 @@ static void l2cap_conn_start(struct l2cap_conn *conn)
 		} else if (sk->sk_state == BT_CONNECT2) {
 			struct l2cap_conn_rsp rsp;
 			char buf[128];
-			rsp.scid = cpu_to_le16(l2cap_pi(sk)->dcid);
-			rsp.dcid = cpu_to_le16(l2cap_pi(sk)->scid);
+			rsp.scid = cpu_to_le16(chan->dcid);
+			rsp.dcid = cpu_to_le16(chan->scid);
 
 			if (l2cap_check_security(chan)) {
 				if (bt_sk(sk)->defer_setup) {
@@ -600,10 +598,12 @@ static struct sock *l2cap_get_sock_by_scid(int state, __le16 cid, bdaddr_t *src)
 	read_lock(&l2cap_sk_list.lock);
 
 	sk_for_each(sk, node, &l2cap_sk_list.head) {
+		struct l2cap_chan *chan = l2cap_pi(sk)->chan;
+
 		if (state && sk->sk_state != state)
 			continue;
 
-		if (l2cap_pi(sk)->scid == cid) {
+		if (chan->scid == cid) {
 			/* Exact match. */
 			if (!bacmp(&bt_sk(sk)->src, src))
 				break;
@@ -830,10 +830,12 @@ static struct sock *l2cap_get_sock_by_psm(int state, __le16 psm, bdaddr_t *src)
 	read_lock(&l2cap_sk_list.lock);
 
 	sk_for_each(sk, node, &l2cap_sk_list.head) {
+		struct l2cap_chan *chan = l2cap_pi(sk)->chan;
+
 		if (state && sk->sk_state != state)
 			continue;
 
-		if (l2cap_pi(sk)->psm == psm) {
+		if (chan->psm == psm) {
 			/* Exact match. */
 			if (!bacmp(&bt_sk(sk)->src, src))
 				break;
@@ -861,7 +863,7 @@ int l2cap_chan_connect(struct l2cap_chan *chan)
 	int err;
 
 	BT_DBG("%s -> %s psm 0x%2.2x", batostr(src), batostr(dst),
-							l2cap_pi(sk)->psm);
+							chan->psm);
 
 	hdev = hci_get_route(dst, src);
 	if (!hdev)
@@ -871,7 +873,7 @@ int l2cap_chan_connect(struct l2cap_chan *chan)
 
 	auth_type = l2cap_get_auth_type(chan);
 
-	if (l2cap_pi(sk)->dcid == L2CAP_CID_LE_DATA)
+	if (chan->dcid == L2CAP_CID_LE_DATA)
 		hcon = hci_connect(hdev, LE_LINK, dst,
 					chan->sec_level, auth_type);
 	else
@@ -1230,8 +1232,9 @@ static inline int l2cap_skbuff_fromiovec(struct sock *sk, struct msghdr *msg, in
 	return sent;
 }
 
-struct sk_buff *l2cap_create_connless_pdu(struct sock *sk, struct msghdr *msg, size_t len)
+struct sk_buff *l2cap_create_connless_pdu(struct l2cap_chan *chan, struct msghdr *msg, size_t len)
 {
+	struct sock *sk = chan->sk;
 	struct l2cap_conn *conn = l2cap_pi(sk)->conn;
 	struct sk_buff *skb;
 	int err, count, hlen = L2CAP_HDR_SIZE + 2;
@@ -1247,9 +1250,9 @@ struct sk_buff *l2cap_create_connless_pdu(struct sock *sk, struct msghdr *msg, s
 
 	/* Create L2CAP header */
 	lh = (struct l2cap_hdr *) skb_put(skb, L2CAP_HDR_SIZE);
-	lh->cid = cpu_to_le16(l2cap_pi(sk)->dcid);
+	lh->cid = cpu_to_le16(chan->dcid);
 	lh->len = cpu_to_le16(len + (hlen - L2CAP_HDR_SIZE));
-	put_unaligned_le16(l2cap_pi(sk)->psm, skb_put(skb, 2));
+	put_unaligned_le16(chan->psm, skb_put(skb, 2));
 
 	err = l2cap_skbuff_fromiovec(sk, msg, len, count, skb);
 	if (unlikely(err < 0)) {
@@ -1259,8 +1262,9 @@ struct sk_buff *l2cap_create_connless_pdu(struct sock *sk, struct msghdr *msg, s
 	return skb;
 }
 
-struct sk_buff *l2cap_create_basic_pdu(struct sock *sk, struct msghdr *msg, size_t len)
+struct sk_buff *l2cap_create_basic_pdu(struct l2cap_chan *chan, struct msghdr *msg, size_t len)
 {
+	struct sock *sk = chan->sk;
 	struct l2cap_conn *conn = l2cap_pi(sk)->conn;
 	struct sk_buff *skb;
 	int err, count, hlen = L2CAP_HDR_SIZE;
@@ -1276,7 +1280,7 @@ struct sk_buff *l2cap_create_basic_pdu(struct sock *sk, struct msghdr *msg, size
 
 	/* Create L2CAP header */
 	lh = (struct l2cap_hdr *) skb_put(skb, L2CAP_HDR_SIZE);
-	lh->cid = cpu_to_le16(l2cap_pi(sk)->dcid);
+	lh->cid = cpu_to_le16(chan->dcid);
 	lh->len = cpu_to_le16(len + (hlen - L2CAP_HDR_SIZE));
 
 	err = l2cap_skbuff_fromiovec(sk, msg, len, count, skb);
@@ -1314,7 +1318,7 @@ struct sk_buff *l2cap_create_iframe_pdu(struct l2cap_chan *chan, struct msghdr *
 
 	/* Create L2CAP header */
 	lh = (struct l2cap_hdr *) skb_put(skb, L2CAP_HDR_SIZE);
-	lh->cid = cpu_to_le16(l2cap_pi(sk)->dcid);
+	lh->cid = cpu_to_le16(chan->dcid);
 	lh->len = cpu_to_le16(len + (hlen - L2CAP_HDR_SIZE));
 	put_unaligned_le16(control, skb_put(skb, 2));
 	if (sdulen)
@@ -1696,7 +1700,7 @@ done:
 		break;
 	}
 
-	req->dcid  = cpu_to_le16(pi->dcid);
+	req->dcid  = cpu_to_le16(chan->dcid);
 	req->flags = cpu_to_le16(0);
 
 	return ptr - data;
@@ -1849,7 +1853,7 @@ done:
 		if (result == L2CAP_CONF_SUCCESS)
 			chan->conf_state |= L2CAP_CONF_OUTPUT_DONE;
 	}
-	rsp->scid   = cpu_to_le16(pi->dcid);
+	rsp->scid   = cpu_to_le16(chan->dcid);
 	rsp->result = cpu_to_le16(result);
 	rsp->flags  = cpu_to_le16(0x0000);
 
@@ -1858,15 +1862,13 @@ done:
 
 static int l2cap_parse_conf_rsp(struct l2cap_chan *chan, void *rsp, int len, void *data, u16 *result)
 {
-	struct sock *sk = chan->sk;
-	struct l2cap_pinfo *pi = l2cap_pi(sk);
 	struct l2cap_conf_req *req = data;
 	void *ptr = req->data;
 	int type, olen;
 	unsigned long val;
 	struct l2cap_conf_rfc rfc;
 
-	BT_DBG("sk %p, rsp %p, len %d, req %p", sk, rsp, len, data);
+	BT_DBG("chan %p, rsp %p, len %d, req %p", chan, rsp, len, data);
 
 	while (len >= L2CAP_CONF_OPT_SIZE) {
 		len -= l2cap_get_conf_opt(&rsp, &type, &olen, &val);
@@ -1920,20 +1922,20 @@ static int l2cap_parse_conf_rsp(struct l2cap_chan *chan, void *rsp, int len, voi
 		}
 	}
 
-	req->dcid   = cpu_to_le16(pi->dcid);
+	req->dcid   = cpu_to_le16(chan->dcid);
 	req->flags  = cpu_to_le16(0x0000);
 
 	return ptr - data;
 }
 
-static int l2cap_build_conf_rsp(struct sock *sk, void *data, u16 result, u16 flags)
+static int l2cap_build_conf_rsp(struct l2cap_chan *chan, void *data, u16 result, u16 flags)
 {
 	struct l2cap_conf_rsp *rsp = data;
 	void *ptr = rsp->data;
 
-	BT_DBG("sk %p", sk);
+	BT_DBG("chan %p", chan);
 
-	rsp->scid   = cpu_to_le16(l2cap_pi(sk)->dcid);
+	rsp->scid   = cpu_to_le16(chan->dcid);
 	rsp->result = cpu_to_le16(result);
 	rsp->flags  = cpu_to_le16(flags);
 
@@ -1949,8 +1951,8 @@ void __l2cap_connect_rsp_defer(struct sock *sk)
 
 	sk->sk_state = BT_CONFIG;
 
-	rsp.scid   = cpu_to_le16(l2cap_pi(sk)->dcid);
-	rsp.dcid   = cpu_to_le16(l2cap_pi(sk)->scid);
+	rsp.scid   = cpu_to_le16(chan->dcid);
+	rsp.dcid   = cpu_to_le16(chan->scid);
 	rsp.result = cpu_to_le16(L2CAP_CR_SUCCESS);
 	rsp.status = cpu_to_le16(L2CAP_CS_NO_INFO);
 	l2cap_send_cmd(conn, chan->ident,
@@ -2084,14 +2086,14 @@ static inline int l2cap_connect_req(struct l2cap_conn *conn, struct l2cap_cmd_hd
 	l2cap_sock_init(sk, parent);
 	bacpy(&bt_sk(sk)->src, conn->src);
 	bacpy(&bt_sk(sk)->dst, conn->dst);
-	l2cap_pi(sk)->psm  = psm;
-	l2cap_pi(sk)->dcid = scid;
+	chan->psm  = psm;
+	chan->dcid = scid;
 
 	bt_accept_enqueue(parent, sk);
 
 	__l2cap_chan_add(conn, chan);
 
-	dcid = l2cap_pi(sk)->scid;
+	dcid = chan->scid;
 
 	l2cap_sock_set_timer(sk, sk->sk_sndtimeo);
 
@@ -2189,7 +2191,7 @@ static inline int l2cap_connect_rsp(struct l2cap_conn *conn, struct l2cap_cmd_hd
 	case L2CAP_CR_SUCCESS:
 		sk->sk_state = BT_CONFIG;
 		chan->ident = 0;
-		l2cap_pi(sk)->dcid = dcid;
+		chan->dcid = dcid;
 		chan->conf_state &= ~L2CAP_CONF_CONNECT_PEND;
 
 		if (chan->conf_state & L2CAP_CONF_REQ_SENT)
@@ -2269,7 +2271,7 @@ static inline int l2cap_config_req(struct l2cap_conn *conn, struct l2cap_cmd_hdr
 	len = cmd_len - sizeof(*req);
 	if (chan->conf_len + len > sizeof(chan->conf_req)) {
 		l2cap_send_cmd(conn, cmd->ident, L2CAP_CONF_RSP,
-				l2cap_build_conf_rsp(sk, rsp,
+				l2cap_build_conf_rsp(chan, rsp,
 					L2CAP_CONF_REJECT, flags), rsp);
 		goto unlock;
 	}
@@ -2281,7 +2283,7 @@ static inline int l2cap_config_req(struct l2cap_conn *conn, struct l2cap_cmd_hdr
 	if (flags & 0x0001) {
 		/* Incomplete config. Send empty response. */
 		l2cap_send_cmd(conn, cmd->ident, L2CAP_CONF_RSP,
-				l2cap_build_conf_rsp(sk, rsp,
+				l2cap_build_conf_rsp(chan, rsp,
 					L2CAP_CONF_SUCCESS, 0x0001), rsp);
 		goto unlock;
 	}
@@ -2431,8 +2433,8 @@ static inline int l2cap_disconnect_req(struct l2cap_conn *conn, struct l2cap_cmd
 
 	sk = chan->sk;
 
-	rsp.dcid = cpu_to_le16(l2cap_pi(sk)->scid);
-	rsp.scid = cpu_to_le16(l2cap_pi(sk)->dcid);
+	rsp.dcid = cpu_to_le16(chan->scid);
+	rsp.scid = cpu_to_le16(chan->dcid);
 	l2cap_send_cmd(conn, cmd->ident, L2CAP_DISCONN_RSP, sizeof(rsp), &rsp);
 
 	sk->sk_shutdown = SHUTDOWN_MASK;
@@ -3919,8 +3921,8 @@ static int l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
 		if (sk->sk_state == BT_CONNECT) {
 			if (!status) {
 				struct l2cap_conn_req req;
-				req.scid = cpu_to_le16(l2cap_pi(sk)->scid);
-				req.psm  = l2cap_pi(sk)->psm;
+				req.scid = cpu_to_le16(chan->scid);
+				req.psm  = chan->psm;
 
 				chan->ident = l2cap_get_ident(conn);
 				chan->conf_state |= L2CAP_CONF_CONNECT_PEND;
@@ -3944,8 +3946,8 @@ static int l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
 				result = L2CAP_CR_SEC_BLOCK;
 			}
 
-			rsp.scid   = cpu_to_le16(l2cap_pi(sk)->dcid);
-			rsp.dcid   = cpu_to_le16(l2cap_pi(sk)->scid);
+			rsp.scid   = cpu_to_le16(chan->dcid);
+			rsp.dcid   = cpu_to_le16(chan->scid);
 			rsp.result = cpu_to_le16(result);
 			rsp.status = cpu_to_le16(L2CAP_CS_NO_INFO);
 			l2cap_send_cmd(conn, chan->ident, L2CAP_CONN_RSP,
@@ -4085,8 +4087,8 @@ static int l2cap_debugfs_show(struct seq_file *f, void *p)
 		seq_printf(f, "%s %s %d %d 0x%4.4x 0x%4.4x %d %d %d %d\n",
 					batostr(&bt_sk(sk)->src),
 					batostr(&bt_sk(sk)->dst),
-					sk->sk_state, __le16_to_cpu(pi->psm),
-					pi->scid, pi->dcid,
+					sk->sk_state, __le16_to_cpu(chan->psm),
+					chan->scid, chan->dcid,
 					chan->imtu, chan->omtu, chan->sec_level,
 					chan->mode);
 	}
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index eef33b1..f5a2773 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -141,7 +141,7 @@ static int l2cap_sock_bind(struct socket *sock, struct sockaddr *addr, int alen)
 	} else {
 		/* Save source address */
 		bacpy(&bt_sk(sk)->src, &la.l2_bdaddr);
-		l2cap_pi(sk)->psm   = la.l2_psm;
+		chan->psm   = la.l2_psm;
 		chan->sport = la.l2_psm;
 		sk->sk_state = BT_BOUND;
 
@@ -151,7 +151,7 @@ static int l2cap_sock_bind(struct socket *sock, struct sockaddr *addr, int alen)
 	}
 
 	if (la.l2_cid)
-		l2cap_pi(sk)->scid = la.l2_cid;
+		chan->scid = la.l2_cid;
 
 	write_unlock_bh(&l2cap_sk_list.lock);
 
@@ -232,8 +232,8 @@ static int l2cap_sock_connect(struct socket *sock, struct sockaddr *addr, int al
 
 	/* Set destination address and psm */
 	bacpy(&bt_sk(sk)->dst, &la.l2_bdaddr);
-	l2cap_pi(sk)->psm = la.l2_psm;
-	l2cap_pi(sk)->dcid = la.l2_cid;
+	chan->psm = la.l2_psm;
+	chan->dcid = la.l2_cid;
 
 	err = l2cap_chan_connect(l2cap_pi(sk)->chan);
 	if (err)
@@ -276,7 +276,7 @@ static int l2cap_sock_listen(struct socket *sock, int backlog)
 		goto done;
 	}
 
-	if (!l2cap_pi(sk)->psm && !l2cap_pi(sk)->scid) {
+	if (!chan->psm && !chan->scid) {
 		bdaddr_t *src = &bt_sk(sk)->src;
 		u16 psm;
 
@@ -286,7 +286,7 @@ static int l2cap_sock_listen(struct socket *sock, int backlog)
 
 		for (psm = 0x1001; psm < 0x1100; psm += 2)
 			if (!__l2cap_get_sock_by_addr(cpu_to_le16(psm), src)) {
-				l2cap_pi(sk)->psm   = cpu_to_le16(psm);
+				chan->psm   = cpu_to_le16(psm);
 				chan->sport = cpu_to_le16(psm);
 				err = 0;
 				break;
@@ -375,13 +375,13 @@ static int l2cap_sock_getname(struct socket *sock, struct sockaddr *addr, int *l
 	*len = sizeof(struct sockaddr_l2);
 
 	if (peer) {
-		la->l2_psm = l2cap_pi(sk)->psm;
+		la->l2_psm = chan->psm;
 		bacpy(&la->l2_bdaddr, &bt_sk(sk)->dst);
-		la->l2_cid = cpu_to_le16(l2cap_pi(sk)->dcid);
+		la->l2_cid = cpu_to_le16(chan->dcid);
 	} else {
 		la->l2_psm = chan->sport;
 		bacpy(&la->l2_bdaddr, &bt_sk(sk)->src);
-		la->l2_cid = cpu_to_le16(l2cap_pi(sk)->scid);
+		la->l2_cid = cpu_to_le16(chan->scid);
 	}
 
 	return 0;
@@ -737,7 +737,7 @@ static int l2cap_sock_sendmsg(struct kiocb *iocb, struct socket *sock, struct ms
 
 	/* Connectionless channel */
 	if (sk->sk_type == SOCK_DGRAM) {
-		skb = l2cap_create_connless_pdu(sk, msg, len);
+		skb = l2cap_create_connless_pdu(chan, msg, len);
 		if (IS_ERR(skb)) {
 			err = PTR_ERR(skb);
 		} else {
@@ -756,7 +756,7 @@ static int l2cap_sock_sendmsg(struct kiocb *iocb, struct socket *sock, struct ms
 		}
 
 		/* Create a basic PDU */
-		skb = l2cap_create_basic_pdu(sk, msg, len);
+		skb = l2cap_create_basic_pdu(chan, msg, len);
 		if (IS_ERR(skb)) {
 			err = PTR_ERR(skb);
 			goto done;
@@ -911,8 +911,8 @@ void __l2cap_sock_close(struct sock *sk, int reason)
 			else
 				result = L2CAP_CR_BAD_PSM;
 
-			rsp.scid   = cpu_to_le16(l2cap_pi(sk)->dcid);
-			rsp.dcid   = cpu_to_le16(l2cap_pi(sk)->scid);
+			rsp.scid   = cpu_to_le16(chan->dcid);
+			rsp.dcid   = cpu_to_le16(chan->scid);
 			rsp.result = cpu_to_le16(result);
 			rsp.status = cpu_to_le16(L2CAP_CS_NO_INFO);
 			l2cap_send_cmd(conn, chan->ident, L2CAP_CONN_RSP,
-- 
1.7.5.rc1

