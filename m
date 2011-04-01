Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 06/15] Bluetooth: clean up l2cap_sock_recvmsg()
Date: Fri,  1 Apr 2011 19:33:11 -0300
Message-Id: <1301697200-2446-7-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1301697200-2446-6-git-send-email-padovan@profusion.mobi>
References: <1301697200-2446-1-git-send-email-padovan@profusion.mobi>
 <1301697200-2446-2-git-send-email-padovan@profusion.mobi>
 <1301697200-2446-3-git-send-email-padovan@profusion.mobi>
 <1301697200-2446-4-git-send-email-padovan@profusion.mobi>
 <1301697200-2446-5-git-send-email-padovan@profusion.mobi>
 <1301697200-2446-6-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Move some channel specific stuff to l2cap_core.c, this will make things
more clear.

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 include/net/bluetooth/l2cap.h |    3 +--
 net/bluetooth/l2cap_core.c    |   28 +++++++++++++++++++++++++++-
 net/bluetooth/l2cap_sock.c    |   25 +------------------------
 3 files changed, 29 insertions(+), 27 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index bf91828..4692413 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -446,9 +446,8 @@ extern struct bt_sock_list l2cap_sk_list;
 int l2cap_init_sockets(void);
 void l2cap_cleanup_sockets(void);
 
-u8 l2cap_get_ident(struct l2cap_conn *conn);
 void l2cap_send_cmd(struct l2cap_conn *conn, u8 ident, u8 code, u16 len, void *data);
-int l2cap_build_conf_req(struct l2cap_chan *chan, void *data);
+void __l2cap_connect_rsp_defer(struct sock *sk);
 int __l2cap_wait_ack(struct sock *sk);
 
 struct sk_buff *l2cap_create_connless_pdu(struct sock *sk, struct msghdr *msg, size_t len);
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 95e488f..26c187e 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -70,6 +70,7 @@ static void l2cap_busy_work(struct work_struct *work);
 
 static struct sk_buff *l2cap_build_cmd(struct l2cap_conn *conn,
 				u8 code, u8 ident, u16 dlen, void *data);
+static int l2cap_build_conf_req(struct l2cap_chan *chan, void *data);
 
 static int l2cap_ertm_data_rcv(struct sock *sk, struct sk_buff *skb);
 
@@ -1599,7 +1600,7 @@ static inline __u8 l2cap_select_mode(__u8 mode, __u16 remote_feat_mask)
 	}
 }
 
-int l2cap_build_conf_req(struct l2cap_chan *chan, void *data)
+static int l2cap_build_conf_req(struct l2cap_chan *chan, void *data)
 {
 	struct sock *sk = chan->sk;
 	struct l2cap_pinfo *pi = l2cap_pi(sk);
@@ -1935,6 +1936,31 @@ static int l2cap_build_conf_rsp(struct sock *sk, void *data, u16 result, u16 fla
 	return ptr - data;
 }
 
+void __l2cap_connect_rsp_defer(struct sock *sk)
+{
+	struct l2cap_conn_rsp rsp;
+	struct l2cap_conn *conn = l2cap_pi(sk)->conn;
+	struct l2cap_chan *chan = l2cap_pi(sk)->chan;
+	u8 buf[128];
+
+	sk->sk_state = BT_CONFIG;
+
+	rsp.scid   = cpu_to_le16(l2cap_pi(sk)->dcid);
+	rsp.dcid   = cpu_to_le16(l2cap_pi(sk)->scid);
+	rsp.result = cpu_to_le16(L2CAP_CR_SUCCESS);
+	rsp.status = cpu_to_le16(L2CAP_CS_NO_INFO);
+	l2cap_send_cmd(conn, chan->ident,
+				L2CAP_CONN_RSP, sizeof(rsp), &rsp);
+
+	if (l2cap_pi(sk)->conf_state & L2CAP_CONF_REQ_SENT)
+		return;
+
+	l2cap_pi(sk)->conf_state |= L2CAP_CONF_REQ_SENT;
+	l2cap_send_cmd(conn, l2cap_get_ident(conn), L2CAP_CONF_REQ,
+			l2cap_build_conf_req(chan, buf), buf);
+	chan->num_conf_req++;
+}
+
 static void l2cap_conf_rfc_get(struct sock *sk, void *rsp, int len)
 {
 	struct l2cap_pinfo *pi = l2cap_pi(sk);
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 244475e..450f57b 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -808,30 +808,7 @@ static int l2cap_sock_recvmsg(struct kiocb *iocb, struct socket *sock, struct ms
 	lock_sock(sk);
 
 	if (sk->sk_state == BT_CONNECT2 && bt_sk(sk)->defer_setup) {
-		struct l2cap_conn_rsp rsp;
-		struct l2cap_conn *conn = l2cap_pi(sk)->conn;
-		struct l2cap_chan *chan = l2cap_pi(sk)->chan;
-		u8 buf[128];
-
-		sk->sk_state = BT_CONFIG;
-
-		rsp.scid   = cpu_to_le16(l2cap_pi(sk)->dcid);
-		rsp.dcid   = cpu_to_le16(l2cap_pi(sk)->scid);
-		rsp.result = cpu_to_le16(L2CAP_CR_SUCCESS);
-		rsp.status = cpu_to_le16(L2CAP_CS_NO_INFO);
-		l2cap_send_cmd(l2cap_pi(sk)->conn, chan->ident,
-					L2CAP_CONN_RSP, sizeof(rsp), &rsp);
-
-		if (l2cap_pi(sk)->conf_state & L2CAP_CONF_REQ_SENT) {
-			release_sock(sk);
-			return 0;
-		}
-
-		l2cap_pi(sk)->conf_state |= L2CAP_CONF_REQ_SENT;
-		l2cap_send_cmd(conn, l2cap_get_ident(conn), L2CAP_CONF_REQ,
-				l2cap_build_conf_req(chan, buf), buf);
-		chan->num_conf_req++;
-
+		__l2cap_connect_rsp_defer(sk);
 		release_sock(sk);
 		return 0;
 	}
-- 
1.7.4.1

