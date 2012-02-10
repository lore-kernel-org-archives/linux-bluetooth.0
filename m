Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv4 10/16] Bluetooth: Use chan lock in chan delete functions
Date: Fri, 10 Feb 2012 15:55:07 +0200
Message-Id: <1328882113-19810-11-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1328882113-19810-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1328882113-19810-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Change sk lock to chan lock in functions deleting L2CAP
channels.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/l2cap_core.c |   21 +++++++++++++++------
 net/bluetooth/l2cap_sock.c |    2 ++
 2 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 94938f0..9ea7758 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -403,6 +403,8 @@ static void l2cap_chan_del(struct l2cap_chan *chan, int err)
 		hci_conn_put(conn->hcon);
 	}
 
+	lock_sock(sk);
+
 	__l2cap_state_change(chan, BT_CLOSED);
 	sock_set_flag(sk, SOCK_ZAPPED);
 
@@ -415,6 +417,8 @@ static void l2cap_chan_del(struct l2cap_chan *chan, int err)
 	} else
 		sk->sk_state_change(sk);
 
+	release_sock(sk);
+
 	if (!(test_bit(CONF_OUTPUT_DONE, &chan->conf_state) &&
 			test_bit(CONF_INPUT_DONE, &chan->conf_state)))
 		return;
@@ -447,10 +451,10 @@ static void l2cap_chan_cleanup_listen(struct sock *parent)
 	while ((sk = bt_accept_dequeue(parent, NULL))) {
 		struct l2cap_chan *chan = l2cap_pi(sk)->chan;
 
+		l2cap_chan_lock(chan);
 		__clear_chan_timer(chan);
-		lock_sock(sk);
 		l2cap_chan_close(chan, ECONNRESET);
-		release_sock(sk);
+		l2cap_chan_unlock(chan);
 
 		chan->ops->close(chan->data);
 	}
@@ -465,10 +469,12 @@ void l2cap_chan_close(struct l2cap_chan *chan, int reason)
 
 	switch (chan->state) {
 	case BT_LISTEN:
+		lock_sock(sk);
 		l2cap_chan_cleanup_listen(sk);
 
 		__l2cap_state_change(chan, BT_CLOSED);
 		sock_set_flag(sk, SOCK_ZAPPED);
+		release_sock(sk);
 		break;
 
 	case BT_CONNECTED:
@@ -511,7 +517,9 @@ void l2cap_chan_close(struct l2cap_chan *chan, int reason)
 		break;
 
 	default:
+		lock_sock(sk);
 		sock_set_flag(sk, SOCK_ZAPPED);
+		release_sock(sk);
 		break;
 	}
 }
@@ -1020,7 +1028,6 @@ static void l2cap_conn_del(struct hci_conn *hcon, int err)
 {
 	struct l2cap_conn *conn = hcon->l2cap_data;
 	struct l2cap_chan *chan, *l;
-	struct sock *sk;
 
 	if (!conn)
 		return;
@@ -1033,10 +1040,12 @@ static void l2cap_conn_del(struct hci_conn *hcon, int err)
 
 	/* Kill channels */
 	list_for_each_entry_safe(chan, l, &conn->chan_l, list) {
-		sk = chan->sk;
-		lock_sock(sk);
+		l2cap_chan_lock(chan);
+
 		l2cap_chan_del(chan, err);
-		release_sock(sk);
+
+		l2cap_chan_unlock(chan);
+
 		chan->ops->close(chan->data);
 	}
 
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 1636029..85e4fd7 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -809,7 +809,9 @@ static int l2cap_sock_shutdown(struct socket *sock, int how)
 			err = __l2cap_wait_ack(sk);
 
 		sk->sk_shutdown = SHUTDOWN_MASK;
+		release_sock(sk);
 		l2cap_chan_close(chan, 0);
+		lock_sock(sk);
 
 		if (sock_flag(sk, SOCK_LINGER) && sk->sk_lingertime)
 			err = bt_sock_wait_state(sk, BT_CLOSED,
-- 
1.7.8.3

