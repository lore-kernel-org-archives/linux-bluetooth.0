Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv3 06/16] Bluetooth: Add socket error function
Date: Thu,  9 Feb 2012 16:17:27 +0200
Message-Id: <1328797057-26331-7-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1328797057-26331-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1328797057-26331-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Use locked and unlocked versions to help removing socket
locks from l2cap.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/l2cap_core.c |   30 +++++++++++++++++++++---------
 1 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index a23c306..e6515b3 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -243,6 +243,22 @@ static void l2cap_state_change(struct l2cap_chan *chan, int state)
 	release_sock(sk);
 }
 
+static inline void __l2cap_set_sock_err(struct l2cap_chan *chan, int err)
+{
+	struct sock *sk = chan->sk;
+
+	sk->sk_err = err;
+}
+
+static inline void l2cap_set_sock_err(struct l2cap_chan *chan, int err)
+{
+	struct sock *sk = chan->sk;
+
+	lock_sock(sk);
+	__l2cap_set_sock_err(chan, err);
+	release_sock(sk);
+}
+
 static void l2cap_chan_timeout(struct work_struct *work)
 {
 	struct l2cap_chan *chan = container_of(work, struct l2cap_chan,
@@ -385,7 +401,7 @@ static void l2cap_chan_del(struct l2cap_chan *chan, int err)
 	sock_set_flag(sk, SOCK_ZAPPED);
 
 	if (err)
-		sk->sk_err = err;
+		__l2cap_set_sock_err(chan, err);
 
 	if (parent) {
 		bt_accept_unlink(sk);
@@ -717,14 +733,11 @@ static inline int l2cap_mode_supported(__u8 mode, __u32 feat_mask)
 
 static void l2cap_send_disconn_req(struct l2cap_conn *conn, struct l2cap_chan *chan, int err)
 {
-	struct sock *sk;
 	struct l2cap_disconn_req req;
 
 	if (!conn)
 		return;
 
-	sk = chan->sk;
-
 	if (chan->mode == L2CAP_MODE_ERTM) {
 		__clear_retrans_timer(chan);
 		__clear_monitor_timer(chan);
@@ -737,7 +750,7 @@ static void l2cap_send_disconn_req(struct l2cap_conn *conn, struct l2cap_chan *c
 			L2CAP_DISCONN_REQ, sizeof(req), &req);
 
 	__l2cap_state_change(chan, BT_DISCONN);
-	sk->sk_err = err;
+	__l2cap_set_sock_err(chan, err);
 }
 
 /* ---- L2CAP connections ---- */
@@ -976,10 +989,8 @@ static void l2cap_conn_unreliable(struct l2cap_conn *conn, int err)
 	mutex_lock(&conn->chan_lock);
 
 	list_for_each_entry(chan, &conn->chan_l, list) {
-		struct sock *sk = chan->sk;
-
 		if (test_bit(FLAG_FORCE_RELIABLE, &chan->flags))
-			sk->sk_err = err;
+			l2cap_set_sock_err(chan, err);
 	}
 
 	mutex_unlock(&conn->chan_lock);
@@ -2994,7 +3005,8 @@ static inline int l2cap_config_rsp(struct l2cap_conn *conn, struct l2cap_cmd_hdr
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

