Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: "Gustavo F. Padovan" <padovan@profusion.mobi>
Subject: [PATCH 01/12] Bluetooth: convert SCO socket timeout function to workqueue
Date: Thu, 22 Dec 2011 16:56:02 -0200
Message-Id: <1324580173-24957-1-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: "Gustavo F. Padovan" <padovan@profusion.mobi>

As a consequence of the move of the Bluetooth core to the process context
we need all important timer to process context too. Thus we will not need
to deal with different context inside the Bluetooth core anymore.

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 include/net/bluetooth/sco.h |    1 +
 net/bluetooth/sco.c         |   35 +++++++++++++++++++++--------------
 2 files changed, 22 insertions(+), 14 deletions(-)

diff --git a/include/net/bluetooth/sco.h b/include/net/bluetooth/sco.h
index 1e35c43..fc1cf9d 100644
--- a/include/net/bluetooth/sco.h
+++ b/include/net/bluetooth/sco.h
@@ -74,6 +74,7 @@ struct sco_pinfo {
 	struct bt_sock	bt;
 	__u32		flags;
 	struct sco_conn	*conn;
+	struct delayed_work timer;
 };
 
 #endif /* __SCO_H */
diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index 0d59e61..8057a4b 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -68,9 +68,10 @@ static void sco_sock_close(struct sock *sk);
 static void sco_sock_kill(struct sock *sk);
 
 /* ---- SCO timers ---- */
-static void sco_sock_timeout(unsigned long arg)
+static void sco_sock_timeout(struct work_struct *work)
 {
-	struct sock *sk = (struct sock *) arg;
+	struct sock *sk = (void *)container_of(work, struct sco_pinfo,
+								timer.work);
 
 	BT_DBG("sock %p state %d", sk, sk->sk_state);
 
@@ -83,16 +84,21 @@ static void sco_sock_timeout(unsigned long arg)
 	sock_put(sk);
 }
 
-static void sco_sock_set_timer(struct sock *sk, long timeout)
+static inline void sco_set_timer(struct sock *sk, long timeout)
 {
 	BT_DBG("sock %p state %d timeout %ld", sk, sk->sk_state, timeout);
-	sk_reset_timer(sk, &sk->sk_timer, jiffies + timeout);
+
+	if (!__cancel_delayed_work(&sco_pi(sk)->timer))
+		sock_hold(sk);
+	schedule_delayed_work(&sco_pi(sk)->timer, timeout);
 }
 
-static void sco_sock_clear_timer(struct sock *sk)
+static inline void sco_clear_timer(struct sock *sk)
 {
 	BT_DBG("sock %p state %d", sk, sk->sk_state);
-	sk_stop_timer(sk, &sk->sk_timer);
+
+	if (__cancel_delayed_work(&sco_pi(sk)->timer))
+		sock_put(sk);
 }
 
 /* ---- SCO connections ---- */
@@ -149,7 +155,7 @@ static int sco_conn_del(struct hci_conn *hcon, int err)
 	sk = sco_chan_get(conn);
 	if (sk) {
 		bh_lock_sock(sk);
-		sco_sock_clear_timer(sk);
+		sco_clear_timer(sk);
 		sco_chan_del(sk, err);
 		bh_unlock_sock(sk);
 		sco_sock_kill(sk);
@@ -217,11 +223,11 @@ static int sco_connect(struct sock *sk)
 		goto done;
 
 	if (hcon->state == BT_CONNECTED) {
-		sco_sock_clear_timer(sk);
+		sco_clear_timer(sk);
 		sk->sk_state = BT_CONNECTED;
 	} else {
 		sk->sk_state = BT_CONNECT;
-		sco_sock_set_timer(sk, sk->sk_sndtimeo);
+		sco_set_timer(sk, sk->sk_sndtimeo);
 	}
 
 done:
@@ -372,7 +378,8 @@ static void __sco_sock_close(struct sock *sk)
 	case BT_CONFIG:
 		if (sco_pi(sk)->conn) {
 			sk->sk_state = BT_DISCONN;
-			sco_sock_set_timer(sk, SCO_DISCONN_TIMEOUT);
+			sco_set_timer(sk,
+					msecs_to_jiffies(SCO_DISCONN_TIMEOUT));
 			hci_conn_put(sco_pi(sk)->conn->hcon);
 			sco_pi(sk)->conn->hcon = NULL;
 		} else
@@ -393,7 +400,7 @@ static void __sco_sock_close(struct sock *sk)
 /* Must be called on unlocked socket. */
 static void sco_sock_close(struct sock *sk)
 {
-	sco_sock_clear_timer(sk);
+	sco_clear_timer(sk);
 	lock_sock(sk);
 	__sco_sock_close(sk);
 	release_sock(sk);
@@ -435,7 +442,7 @@ static struct sock *sco_sock_alloc(struct net *net, struct socket *sock, int pro
 	sk->sk_protocol = proto;
 	sk->sk_state    = BT_OPEN;
 
-	setup_timer(&sk->sk_timer, sco_sock_timeout, (unsigned long)sk);
+	INIT_DELAYED_WORK(&sco_pi(sk)->timer, sco_sock_timeout);
 
 	bt_sock_link(&sco_sk_list, sk);
 	return sk;
@@ -771,7 +778,7 @@ static int sco_sock_shutdown(struct socket *sock, int how)
 	lock_sock(sk);
 	if (!sk->sk_shutdown) {
 		sk->sk_shutdown = SHUTDOWN_MASK;
-		sco_sock_clear_timer(sk);
+		sco_clear_timer(sk);
 		__sco_sock_close(sk);
 
 		if (sock_flag(sk, SOCK_LINGER) && sk->sk_lingertime)
@@ -853,7 +860,7 @@ static void sco_conn_ready(struct sco_conn *conn)
 	sco_conn_lock(conn);
 
 	if (sk) {
-		sco_sock_clear_timer(sk);
+		sco_clear_timer(sk);
 		bh_lock_sock(sk);
 		sk->sk_state = BT_CONNECTED;
 		sk->sk_state_change(sk);
-- 
1.7.6.4

