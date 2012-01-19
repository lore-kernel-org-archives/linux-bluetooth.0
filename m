Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv3 27/34] Bluetooth: A2MP: Handling fixed channels
Date: Thu, 19 Jan 2012 11:20:16 +0200
Message-Id: <1326964823-26747-28-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1326964823-26747-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1326964823-26747-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

A2MP fixed channel do not have sk

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/l2cap.h |    1 +
 net/bluetooth/a2mp.c          |    4 ++--
 net/bluetooth/l2cap_core.c    |   25 ++++++++++++++++++++++---
 3 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index cc6f299..f896db1 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -551,6 +551,7 @@ struct l2cap_conn {
 #define L2CAP_CHAN_RAW			1
 #define L2CAP_CHAN_CONN_LESS		2
 #define L2CAP_CHAN_CONN_ORIENTED	3
+#define L2CAP_CHAN_CONN_FIX_A2MP	4
 
 /* ----- L2CAP socket info ----- */
 #define l2cap_pi(sk) ((struct l2cap_pinfo *) sk)
diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
index f366f5f..d4324f6 100644
--- a/net/bluetooth/a2mp.c
+++ b/net/bluetooth/a2mp.c
@@ -425,9 +425,9 @@ static struct l2cap_chan *open_a2mp_chan(struct l2cap_conn *conn)
 
 	BT_DBG("chan %p", chan);
 
+	chan->chan_type = L2CAP_CHAN_CONN_FIX_A2MP;
+
 	chan->sec_level = BT_SECURITY_LOW;
-	chan->omtu = L2CAP_A2MP_DEFAULT_MTU;
-	chan->imtu = L2CAP_A2MP_DEFAULT_MTU;
 	chan->flush_to = L2CAP_DEFAULT_FLUSH_TO;
 	chan->fcs = L2CAP_FCS_CRC16;
 
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index a99009e..2a0d50c 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -341,6 +341,13 @@ void l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan)
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
@@ -366,7 +373,7 @@ static void l2cap_chan_del(struct l2cap_chan *chan, int err)
 {
 	struct sock *sk = chan->sk;
 	struct l2cap_conn *conn = chan->conn;
-	struct sock *parent = bt_sk(sk)->parent;
+	struct sock *parent;
 
 	__clear_chan_timer(chan);
 
@@ -383,6 +390,11 @@ static void l2cap_chan_del(struct l2cap_chan *chan, int err)
 		hci_conn_put(conn->hcon);
 	}
 
+	if (chan->chan_type == L2CAP_CHAN_CONN_FIX_A2MP)
+		goto clean;
+
+	parent = bt_sk(sk)->parent;
+
 	l2cap_state_change(chan, BT_CLOSED);
 	sock_set_flag(sk, SOCK_ZAPPED);
 
@@ -399,6 +411,7 @@ static void l2cap_chan_del(struct l2cap_chan *chan, int err)
 			test_bit(CONF_INPUT_DONE, &chan->conf_state)))
 		return;
 
+clean:
 	skb_queue_purge(&chan->tx_q);
 
 	if (chan->mode == L2CAP_MODE_ERTM) {
@@ -1014,9 +1027,15 @@ static void l2cap_conn_del(struct hci_conn *hcon, int err)
 	/* Kill channels */
 	list_for_each_entry_safe(chan, l, &conn->chan_l, list) {
 		sk = chan->sk;
-		lock_sock(sk);
+
+		if (sk)
+			lock_sock(sk);
+
 		l2cap_chan_del(chan, err);
-		release_sock(sk);
+
+		if (sk)
+			release_sock(sk);
+
 		chan->ops->close(chan->data);
 	}
 
-- 
1.7.4.1

