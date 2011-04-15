Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/8] Bluetooth: Refactor L2CAP channel allocation
Date: Fri, 15 Apr 2011 15:17:27 -0300
Message-Id: <1302891454-10165-2-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1302891454-10165-1-git-send-email-padovan@profusion.mobi>
References: <1302891454-10165-1-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If the allocation happens at l2cap_sock_create() will be able to use the
struct l2cap_chan to store channel info that comes from the user via
setsockopt.

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 include/net/bluetooth/l2cap.h |    3 ++-
 net/bluetooth/l2cap_core.c    |   23 +++++++----------------
 net/bluetooth/l2cap_sock.c    |   11 ++++++++++-
 3 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 7a215a7..537e3c1 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -465,7 +465,8 @@ void l2cap_sock_init(struct sock *sk, struct sock *parent);
 struct sock *l2cap_sock_alloc(struct net *net, struct socket *sock,
 							int proto, gfp_t prio);
 void l2cap_send_disconn_req(struct l2cap_conn *conn, struct l2cap_chan *chan, int err);
+struct l2cap_chan *l2cap_chan_alloc(struct sock *sk);
 void l2cap_chan_del(struct l2cap_chan *chan, int err);
-int l2cap_do_connect(struct sock *sk);
+int l2cap_do_connect(struct l2cap_chan *chan);
 
 #endif /* __L2CAP_H */
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index d47de2b..9a60ec0 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -149,7 +149,7 @@ static u16 l2cap_alloc_cid(struct l2cap_conn *conn)
 	return 0;
 }
 
-static struct l2cap_chan *l2cap_chan_alloc(struct sock *sk)
+struct l2cap_chan *l2cap_chan_alloc(struct sock *sk)
 {
 	struct l2cap_chan *chan;
 
@@ -648,6 +648,8 @@ static void l2cap_le_conn_ready(struct l2cap_conn *conn)
 		goto clean;
 	}
 
+	l2cap_pi(sk)->chan = chan;
+
 	write_lock_bh(&conn->chan_lock);
 
 	hci_conn_hold(conn->hcon);
@@ -661,8 +663,6 @@ static void l2cap_le_conn_ready(struct l2cap_conn *conn)
 
 	__l2cap_chan_add(conn, chan);
 
-	l2cap_pi(sk)->chan = chan;
-
 	l2cap_sock_set_timer(sk, sk->sk_sndtimeo);
 
 	sk->sk_state = BT_CONNECTED;
@@ -847,12 +847,12 @@ static struct sock *l2cap_get_sock_by_psm(int state, __le16 psm, bdaddr_t *src)
 	return node ? sk : sk1;
 }
 
-int l2cap_do_connect(struct sock *sk)
+int l2cap_do_connect(struct l2cap_chan *chan)
 {
+	struct sock *sk = chan->sk;
 	bdaddr_t *src = &bt_sk(sk)->src;
 	bdaddr_t *dst = &bt_sk(sk)->dst;
 	struct l2cap_conn *conn;
-	struct l2cap_chan *chan;
 	struct hci_conn *hcon;
 	struct hci_dev *hdev;
 	__u8 auth_type;
@@ -888,20 +888,11 @@ int l2cap_do_connect(struct sock *sk)
 		goto done;
 	}
 
-	chan = l2cap_chan_alloc(sk);
-	if (!chan) {
-		hci_conn_put(hcon);
-		err = -ENOMEM;
-		goto done;
-	}
-
 	/* Update source addr of the socket */
 	bacpy(src, conn->src);
 
 	l2cap_chan_add(conn, chan);
 
-	l2cap_pi(sk)->chan = chan;
-
 	sk->sk_state = BT_CONNECT;
 	l2cap_sock_set_timer(sk, sk->sk_sndtimeo);
 
@@ -2075,6 +2066,8 @@ static inline int l2cap_connect_req(struct l2cap_conn *conn, struct l2cap_cmd_hd
 		goto response;
 	}
 
+	l2cap_pi(sk)->chan = chan;
+
 	write_lock_bh(&conn->chan_lock);
 
 	/* Check if we already have channel with that dcid */
@@ -2097,8 +2090,6 @@ static inline int l2cap_connect_req(struct l2cap_conn *conn, struct l2cap_cmd_hd
 
 	__l2cap_chan_add(conn, chan);
 
-	l2cap_pi(sk)->chan = chan;
-
 	dcid = l2cap_pi(sk)->scid;
 
 	l2cap_sock_set_timer(sk, sk->sk_sndtimeo);
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 473e597..e372457 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -229,7 +229,7 @@ static int l2cap_sock_connect(struct socket *sock, struct sockaddr *addr, int al
 	l2cap_pi(sk)->psm = la.l2_psm;
 	l2cap_pi(sk)->dcid = la.l2_cid;
 
-	err = l2cap_do_connect(sk);
+	err = l2cap_do_connect(l2cap_pi(sk)->chan);
 	if (err)
 		goto done;
 
@@ -1054,6 +1054,7 @@ static int l2cap_sock_create(struct net *net, struct socket *sock, int protocol,
 			     int kern)
 {
 	struct sock *sk;
+	struct l2cap_chan *chan;
 
 	BT_DBG("sock %p", sock);
 
@@ -1072,6 +1073,14 @@ static int l2cap_sock_create(struct net *net, struct socket *sock, int protocol,
 	if (!sk)
 		return -ENOMEM;
 
+	chan = l2cap_chan_alloc(sk);
+	if (!chan) {
+		l2cap_sock_kill(sk);
+		return -ENOMEM;
+	}
+
+	l2cap_pi(sk)->chan = chan;
+
 	l2cap_sock_init(sk, NULL);
 	return 0;
 }
-- 
1.7.5.rc1

