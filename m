Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv5 13/16] Bluetooth: Change locking logic for conn/chan ready
Date: Fri, 17 Feb 2012 15:44:09 +0200
Message-Id: <1329486252-25252-14-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1329486252-25252-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1329486252-25252-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

In l2cap_conn_ready and l2cap_chan_ready change locking logic and
use explicit socket when needed.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/l2cap_core.c |   16 ++++++++++++----
 1 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 31810d3..6f28cf5 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -920,7 +920,11 @@ clean:
 static void l2cap_chan_ready(struct l2cap_chan *chan)
 {
 	struct sock *sk = chan->sk;
-	struct sock *parent = bt_sk(sk)->parent;
+	struct sock *parent;
+
+	lock_sock(sk);
+
+	parent = bt_sk(sk)->parent;
 
 	BT_DBG("sk %p, parent %p", sk, parent);
 
@@ -932,6 +936,8 @@ static void l2cap_chan_ready(struct l2cap_chan *chan)
 
 	if (parent)
 		parent->sk_data_ready(parent, 0);
+
+	release_sock(sk);
 }
 
 static void l2cap_conn_ready(struct l2cap_conn *conn)
@@ -949,23 +955,25 @@ static void l2cap_conn_ready(struct l2cap_conn *conn)
 	mutex_lock(&conn->chan_lock);
 
 	list_for_each_entry(chan, &conn->chan_l, list) {
-		struct sock *sk = chan->sk;
 
-		bh_lock_sock(sk);
+		l2cap_chan_lock(chan);
 
 		if (conn->hcon->type == LE_LINK) {
 			if (smp_conn_security(conn, chan->sec_level))
 				l2cap_chan_ready(chan);
 
 		} else if (chan->chan_type != L2CAP_CHAN_CONN_ORIENTED) {
+			struct sock *sk = chan->sk;
 			__clear_chan_timer(chan);
+			lock_sock(sk);
 			__l2cap_state_change(chan, BT_CONNECTED);
 			sk->sk_state_change(sk);
+			release_sock(sk);
 
 		} else if (chan->state == BT_CONNECT)
 			l2cap_do_start(chan);
 
-		bh_unlock_sock(sk);
+		l2cap_chan_unlock(chan);
 	}
 
 	mutex_unlock(&conn->chan_lock);
-- 
1.7.9

