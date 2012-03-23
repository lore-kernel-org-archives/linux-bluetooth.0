Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv5 19/26] Bluetooth: A2MP: Handling fixed channels
Date: Fri, 23 Mar 2012 18:13:59 +0200
Message-Id: <1332519246-16656-20-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1332519246-16656-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1332519246-16656-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

A2MP fixed channel do not have sk

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/l2cap.h |    1 +
 net/bluetooth/a2mp.c          |    4 ++--
 net/bluetooth/l2cap_core.c    |   15 +++++++++++++--
 3 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 0f0ef6c..44ba4c4 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -555,6 +555,7 @@ struct l2cap_conn {
 #define L2CAP_CHAN_RAW			1
 #define L2CAP_CHAN_CONN_LESS		2
 #define L2CAP_CHAN_CONN_ORIENTED	3
+#define L2CAP_CHAN_CONN_FIX_A2MP	4
 
 /* ----- L2CAP socket info ----- */
 #define l2cap_pi(sk) ((struct l2cap_pinfo *) sk)
diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
index 178832e..2f7c461 100644
--- a/net/bluetooth/a2mp.c
+++ b/net/bluetooth/a2mp.c
@@ -430,9 +430,9 @@ static struct l2cap_chan *open_a2mp_chan(struct l2cap_conn *conn)
 
 	BT_DBG("chan %p", chan);
 
+	chan->chan_type = L2CAP_CHAN_CONN_FIX_A2MP;
+
 	chan->sec_level = BT_SECURITY_LOW;
-	chan->omtu = L2CAP_A2MP_DEFAULT_MTU;
-	chan->imtu = L2CAP_A2MP_DEFAULT_MTU;
 	chan->flush_to = L2CAP_DEFAULT_FLUSH_TO;
 	chan->fcs = L2CAP_FCS_CRC16;
 
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index c3b448b..7583eef 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -333,6 +333,13 @@ static void __l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan)
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
@@ -363,7 +370,7 @@ static void l2cap_chan_del(struct l2cap_chan *chan, int err)
 {
 	struct sock *sk = chan->sk;
 	struct l2cap_conn *conn = chan->conn;
-	struct sock *parent = bt_sk(sk)->parent;
+	struct sock *parent;
 
 	__clear_chan_timer(chan);
 
@@ -379,12 +386,15 @@ static void l2cap_chan_del(struct l2cap_chan *chan, int err)
 		hci_conn_put(conn->hcon);
 	}
 
+	if (chan->chan_type == L2CAP_CHAN_CONN_FIX_A2MP)
+		goto clean;
+
 	lock_sock(sk);
 
 	__l2cap_state_change(chan, BT_CLOSED, err);
-
 	sock_set_flag(sk, SOCK_ZAPPED);
 
+	parent = bt_sk(sk)->parent;
 	if (parent) {
 		bt_accept_unlink(sk);
 		parent->sk_data_ready(parent, 0);
@@ -397,6 +407,7 @@ static void l2cap_chan_del(struct l2cap_chan *chan, int err)
 			test_bit(CONF_INPUT_DONE, &chan->conf_state)))
 		return;
 
+clean:
 	skb_queue_purge(&chan->tx_q);
 
 	if (chan->mode == L2CAP_MODE_ERTM) {
-- 
1.7.9.1

