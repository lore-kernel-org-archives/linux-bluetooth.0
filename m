Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 2/2] Bluetooth: timer check sk is not owned before freeing
Date: Fri, 21 May 2010 13:04:53 +0300
Message-Id: <1274436293-15063-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1274436293-15063-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1274436293-15063-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>

In timer context we might delete l2cap channel used by krfcommd.
The check makes sure that sk is not owned.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>
---
 net/bluetooth/l2cap.c |   32 ++++++++++++++++++++------------
 1 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index 11060d6..1a6c5bb 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -84,6 +84,18 @@ static struct sk_buff *l2cap_build_cmd(struct l2cap_conn *conn,
 				u8 code, u8 ident, u16 dlen, void *data);
 
 /* ---- L2CAP timers ---- */
+static void l2cap_sock_set_timer(struct sock *sk, long timeout)
+{
+	BT_DBG("sk %p state %d timeout %ld", sk, sk->sk_state, timeout);
+	sk_reset_timer(sk, &sk->sk_timer, jiffies + timeout);
+}
+
+static void l2cap_sock_clear_timer(struct sock *sk)
+{
+	BT_DBG("sock %p state %d", sk, sk->sk_state);
+	sk_stop_timer(sk, &sk->sk_timer);
+}
+
 static void l2cap_sock_timeout(unsigned long arg)
 {
 	struct sock *sk = (struct sock *) arg;
@@ -93,6 +105,14 @@ static void l2cap_sock_timeout(unsigned long arg)
 
 	bh_lock_sock(sk);
 
+	if (sock_owned_by_user(sk)) {
+		/* sk is owned by user. Try again later */
+		l2cap_sock_set_timer(sk, HZ * 2);
+		bh_unlock_sock(sk);
+		sock_put(sk);
+		return;
+	}
+
 	if (sk->sk_state == BT_CONNECTED || sk->sk_state == BT_CONFIG)
 		reason = ECONNREFUSED;
 	else if (sk->sk_state == BT_CONNECT &&
@@ -109,18 +129,6 @@ static void l2cap_sock_timeout(unsigned long arg)
 	sock_put(sk);
 }
 
-static void l2cap_sock_set_timer(struct sock *sk, long timeout)
-{
-	BT_DBG("sk %p state %d timeout %ld", sk, sk->sk_state, timeout);
-	sk_reset_timer(sk, &sk->sk_timer, jiffies + timeout);
-}
-
-static void l2cap_sock_clear_timer(struct sock *sk)
-{
-	BT_DBG("sock %p state %d", sk, sk->sk_state);
-	sk_stop_timer(sk, &sk->sk_timer);
-}
-
 /* ---- L2CAP channels ---- */
 static struct sock *__l2cap_get_chan_by_dcid(struct l2cap_chan_list *l, u16 cid)
 {
-- 
1.7.0.4

