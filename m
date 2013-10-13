Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/3] Bluetooth: Store RFCOMM address information in its own socket structure
Date: Sun, 13 Oct 2013 10:34:02 -0700
Message-Id: <1381685643-57066-2-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The address information of RFCOMM sockets should be stored in its
own socket structure. Trying to generalize them is not helpful since
different transports have different address types.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/rfcomm.h |  2 ++
 net/bluetooth/rfcomm/sock.c    | 28 +++++++++++++++-------------
 2 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/include/net/bluetooth/rfcomm.h b/include/net/bluetooth/rfcomm.h
index 7afd419..3588f48 100644
--- a/include/net/bluetooth/rfcomm.h
+++ b/include/net/bluetooth/rfcomm.h
@@ -300,6 +300,8 @@ struct rfcomm_conninfo {
 
 struct rfcomm_pinfo {
 	struct bt_sock bt;
+	bdaddr_t src;
+	bdaddr_t dst;
 	struct rfcomm_dlc   *dlc;
 	u8     channel;
 	u8     sec_level;
diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
index 072938d..df17276 100644
--- a/net/bluetooth/rfcomm/sock.c
+++ b/net/bluetooth/rfcomm/sock.c
@@ -87,7 +87,8 @@ static void rfcomm_sk_state_change(struct rfcomm_dlc *d, int err)
 		parent->sk_data_ready(parent, 0);
 	} else {
 		if (d->state == BT_CONNECTED)
-			rfcomm_session_getaddr(d->session, &bt_sk(sk)->src, NULL);
+			rfcomm_session_getaddr(d->session,
+					       &rfcomm_pi(sk)->src, NULL);
 		sk->sk_state_change(sk);
 	}
 
@@ -110,7 +111,7 @@ static struct sock *__rfcomm_get_sock_by_addr(u8 channel, bdaddr_t *src)
 
 	sk_for_each(sk, &rfcomm_sk_list.head) {
 		if (rfcomm_pi(sk)->channel == channel &&
-				!bacmp(&bt_sk(sk)->src, src))
+				!bacmp(&rfcomm_pi(sk)->src, src))
 			break;
 	}
 
@@ -132,11 +133,11 @@ static struct sock *rfcomm_get_sock_by_channel(int state, u8 channel, bdaddr_t *
 
 		if (rfcomm_pi(sk)->channel == channel) {
 			/* Exact match. */
-			if (!bacmp(&bt_sk(sk)->src, src))
+			if (!bacmp(&rfcomm_pi(sk)->src, src))
 				break;
 
 			/* Closest match */
-			if (!bacmp(&bt_sk(sk)->src, BDADDR_ANY))
+			if (!bacmp(&rfcomm_pi(sk)->src, BDADDR_ANY))
 				sk1 = sk;
 		}
 	}
@@ -355,7 +356,7 @@ static int rfcomm_sock_bind(struct socket *sock, struct sockaddr *addr, int addr
 		err = -EADDRINUSE;
 	} else {
 		/* Save source address */
-		bacpy(&bt_sk(sk)->src, &sa->rc_bdaddr);
+		bacpy(&rfcomm_pi(sk)->src, &sa->rc_bdaddr);
 		rfcomm_pi(sk)->channel = sa->rc_channel;
 		sk->sk_state = BT_BOUND;
 	}
@@ -393,13 +394,14 @@ static int rfcomm_sock_connect(struct socket *sock, struct sockaddr *addr, int a
 	}
 
 	sk->sk_state = BT_CONNECT;
-	bacpy(&bt_sk(sk)->dst, &sa->rc_bdaddr);
+	bacpy(&rfcomm_pi(sk)->dst, &sa->rc_bdaddr);
 	rfcomm_pi(sk)->channel = sa->rc_channel;
 
 	d->sec_level = rfcomm_pi(sk)->sec_level;
 	d->role_switch = rfcomm_pi(sk)->role_switch;
 
-	err = rfcomm_dlc_open(d, &bt_sk(sk)->src, &sa->rc_bdaddr, sa->rc_channel);
+	err = rfcomm_dlc_open(d, &rfcomm_pi(sk)->src, &sa->rc_bdaddr,
+			      sa->rc_channel);
 	if (!err)
 		err = bt_sock_wait_state(sk, BT_CONNECTED,
 				sock_sndtimeo(sk, flags & O_NONBLOCK));
@@ -429,7 +431,7 @@ static int rfcomm_sock_listen(struct socket *sock, int backlog)
 	}
 
 	if (!rfcomm_pi(sk)->channel) {
-		bdaddr_t *src = &bt_sk(sk)->src;
+		bdaddr_t *src = &rfcomm_pi(sk)->src;
 		u8 channel;
 
 		err = -EINVAL;
@@ -530,9 +532,9 @@ static int rfcomm_sock_getname(struct socket *sock, struct sockaddr *addr, int *
 	sa->rc_family  = AF_BLUETOOTH;
 	sa->rc_channel = rfcomm_pi(sk)->channel;
 	if (peer)
-		bacpy(&sa->rc_bdaddr, &bt_sk(sk)->dst);
+		bacpy(&sa->rc_bdaddr, &rfcomm_pi(sk)->dst);
 	else
-		bacpy(&sa->rc_bdaddr, &bt_sk(sk)->src);
+		bacpy(&sa->rc_bdaddr, &rfcomm_pi(sk)->src);
 
 	*len = sizeof(struct sockaddr_rc);
 	return 0;
@@ -951,8 +953,8 @@ int rfcomm_connect_ind(struct rfcomm_session *s, u8 channel, struct rfcomm_dlc *
 	bt_sock_reclassify_lock(sk, BTPROTO_RFCOMM);
 
 	rfcomm_sock_init(sk, parent);
-	bacpy(&bt_sk(sk)->src, &src);
-	bacpy(&bt_sk(sk)->dst, &dst);
+	bacpy(&rfcomm_pi(sk)->src, &src);
+	bacpy(&rfcomm_pi(sk)->dst, &dst);
 	rfcomm_pi(sk)->channel = channel;
 
 	sk->sk_state = BT_CONFIG;
@@ -979,7 +981,7 @@ static int rfcomm_sock_debugfs_show(struct seq_file *f, void *p)
 
 	sk_for_each(sk, &rfcomm_sk_list.head) {
 		seq_printf(f, "%pMR %pMR %d %d\n",
-			   &bt_sk(sk)->src, &bt_sk(sk)->dst,
+			   &rfcomm_pi(sk)->src, &rfcomm_pi(sk)->dst,
 			   sk->sk_state, rfcomm_pi(sk)->channel);
 	}
 
-- 
1.8.3.1

