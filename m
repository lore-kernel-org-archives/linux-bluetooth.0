Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv2 07/10] Bluetooth: Add socket error function
Date: Fri,  3 Feb 2012 16:36:26 +0200
Message-Id: <1328279789-10870-8-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1328279789-10870-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1328279789-10870-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Use locked and unlocked versions to help removing socket
locks from l2cap.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/l2cap_core.c |   23 +++++++++++++++++++----
 1 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index cdc9d0c..79d6996 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -243,6 +243,20 @@ static void l2cap_state_change(struct l2cap_chan *chan, int state)
 	release_sock(chan->sk);
 }
 
+static inline void __l2cap_set_sock_err(struct sock *sk, int err)
+{
+	sk->sk_err = err;
+}
+
+static inline void l2cap_set_sock_err(struct l2cap_chan *chan, int err)
+{
+	struct sock *sk = chan->sk;
+
+	lock_sock(sk);
+	__l2cap_set_sock_err(sk, err);
+	release_sock(sk);
+}
+
 static void l2cap_chan_timeout(struct work_struct *work)
 {
 	struct l2cap_chan *chan = container_of(work, struct l2cap_chan,
@@ -385,7 +399,7 @@ static void l2cap_chan_del(struct l2cap_chan *chan, int err)
 	sock_set_flag(sk, SOCK_ZAPPED);
 
 	if (err)
-		sk->sk_err = err;
+		__l2cap_set_sock_err(sk, err);
 
 	if (parent) {
 		bt_accept_unlink(sk);
@@ -738,8 +752,8 @@ static void l2cap_send_disconn_req(struct l2cap_conn *conn, struct l2cap_chan *c
 	l2cap_send_cmd(conn, l2cap_get_ident(conn),
 			L2CAP_DISCONN_REQ, sizeof(req), &req);
 
-	sk->sk_err = err;
 	__l2cap_state_change(chan, BT_DISCONN);
+	__l2cap_set_sock_err(sk, err);
 }
 
 /* ---- L2CAP connections ---- */
@@ -981,7 +995,7 @@ static void l2cap_conn_unreliable(struct l2cap_conn *conn, int err)
 		struct sock *sk = chan->sk;
 
 		if (test_bit(FLAG_FORCE_RELIABLE, &chan->flags))
-			sk->sk_err = err;
+			__l2cap_set_sock_err(sk, err);
 	}
 
 	mutex_unlock(&conn->chan_lock);
@@ -2995,7 +3009,8 @@ static inline int l2cap_config_rsp(struct l2cap_conn *conn, struct l2cap_cmd_hdr
 		}
 
 	default:
-		sk->sk_err = ECONNRESET;
+		l2cap_set_sock_err(chan, ECONNRESET);
+
 		__set_chan_timer(chan,
 				msecs_to_jiffies(L2CAP_DISC_REJ_TIMEOUT));
 		l2cap_send_disconn_req(conn, chan, ECONNRESET);
-- 
1.7.8.3

