Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv7 16/23] Bluetooth: A2MP: Handling fixed channels
Date: Fri, 20 Apr 2012 14:09:44 +0300
Message-Id: <1334920191-29308-17-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1334920191-29308-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1332519246-16656-27-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1334920191-29308-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

A2MP fixed channel do not have sk

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/l2cap.h |    1 +
 net/bluetooth/a2mp.c          |    3 +--
 net/bluetooth/l2cap_core.c    |   17 +++++++++++++++--
 3 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index a8c4457..e36f7c5 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -576,6 +576,7 @@ struct l2cap_conn {
 #define L2CAP_CHAN_RAW			1
 #define L2CAP_CHAN_CONN_LESS		2
 #define L2CAP_CHAN_CONN_ORIENTED	3
+#define L2CAP_CHAN_CONN_FIX_A2MP	4
 
 /* ----- L2CAP socket info ----- */
 #define l2cap_pi(sk) ((struct l2cap_pinfo *) sk)
diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
index 4675785..aa93e0b 100644
--- a/net/bluetooth/a2mp.c
+++ b/net/bluetooth/a2mp.c
@@ -462,8 +462,7 @@ static struct l2cap_chan *a2mp_chan_open(struct l2cap_conn *conn)
 
 	hci_conn_hold(conn->hcon);
 
-	chan->omtu = L2CAP_A2MP_DEFAULT_MTU;
-	chan->imtu = L2CAP_A2MP_DEFAULT_MTU;
+	chan->chan_type = L2CAP_CHAN_CONN_FIX_A2MP;
 	chan->flush_to = L2CAP_DEFAULT_FLUSH_TO;
 
 	chan->ops = &a2mp_chan_ops;
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index b6d0d0b..d0aeb56 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -453,6 +453,13 @@ static void __l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan)
 		chan->omtu = L2CAP_DEFAULT_MTU;
 		break;
 
+	case L2CAP_CHAN_CONN_FIX_A2MP:
+		chan->scid = L2CAP_CID_A2MP;
+		chan->dcid = L2CAP_CID_A2MP;
+		chan->omtu = L2CAP_A2MP_DEFAULT_MTU;
+		chan->imtu = L2CAP_A2MP_DEFAULT_MTU;
+		break;
+
 	default:
 		/* Raw socket can send/recv signalling messages only */
 		chan->scid = L2CAP_CID_SIGNALING;
@@ -483,7 +490,7 @@ static void l2cap_chan_del(struct l2cap_chan *chan, int err)
 {
 	struct sock *sk = chan->sk;
 	struct l2cap_conn *conn = chan->conn;
-	struct sock *parent = bt_sk(sk)->parent;
+	struct sock *parent;
 
 	__clear_chan_timer(chan);
 
@@ -499,6 +506,9 @@ static void l2cap_chan_del(struct l2cap_chan *chan, int err)
 		hci_conn_put(conn->hcon);
 	}
 
+	if (chan->chan_type == L2CAP_CHAN_CONN_FIX_A2MP)
+		goto clean;
+
 	lock_sock(sk);
 
 	__l2cap_state_change(chan, BT_CLOSED);
@@ -507,6 +517,7 @@ static void l2cap_chan_del(struct l2cap_chan *chan, int err)
 	if (err)
 		__l2cap_chan_set_err(chan, err);
 
+	parent = bt_sk(sk)->parent;
 	if (parent) {
 		bt_accept_unlink(sk);
 		parent->sk_data_ready(parent, 0);
@@ -519,6 +530,7 @@ static void l2cap_chan_del(struct l2cap_chan *chan, int err)
 			test_bit(CONF_INPUT_DONE, &chan->conf_state)))
 		return;
 
+clean:
 	skb_queue_purge(&chan->tx_q);
 
 	if (chan->mode == L2CAP_MODE_ERTM) {
@@ -1543,7 +1555,8 @@ static void l2cap_monitor_timeout(struct work_struct *work)
 	l2cap_chan_lock(chan);
 
 	if (chan->retry_count >= chan->remote_max_tx) {
-		l2cap_send_disconn_req(chan->conn, chan, ECONNABORTED);
+		if (chan->chan_type != L2CAP_CHAN_CONN_FIX_A2MP)
+			l2cap_send_disconn_req(chan->conn, chan, ECONNABORTED);
 		l2cap_chan_unlock(chan);
 		l2cap_chan_put(chan);
 		return;
-- 
1.7.9.5

