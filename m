Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv4 16/17] Bluetooth: A2MP: Handling fixed channels
Date: Tue, 29 May 2012 13:59:16 +0300
Message-Id: <1338289158-25655-17-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1338289158-25655-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1337351150-20526-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1338289158-25655-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

A2MP fixed channel do not have sk

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/l2cap.h |    1 +
 net/bluetooth/a2mp.c          |    3 +--
 net/bluetooth/l2cap_core.c    |   17 +++++++++++++++++
 3 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index aaba222..a00b43e 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -581,6 +581,7 @@ struct l2cap_conn {
 #define L2CAP_CHAN_RAW			1
 #define L2CAP_CHAN_CONN_LESS		2
 #define L2CAP_CHAN_CONN_ORIENTED	3
+#define L2CAP_CHAN_CONN_FIX_A2MP	4
 
 /* ----- L2CAP socket info ----- */
 #define l2cap_pi(sk) ((struct l2cap_pinfo *) sk)
diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
index 1076ce3..2019fe3 100644
--- a/net/bluetooth/a2mp.c
+++ b/net/bluetooth/a2mp.c
@@ -485,8 +485,7 @@ static struct l2cap_chan *a2mp_chan_open(struct l2cap_conn *conn)
 
 	hci_conn_hold(conn->hcon);
 
-	chan->omtu = L2CAP_A2MP_DEFAULT_MTU;
-	chan->imtu = L2CAP_A2MP_DEFAULT_MTU;
+	chan->chan_type = L2CAP_CHAN_CONN_FIX_A2MP;
 	chan->flush_to = L2CAP_DEFAULT_FLUSH_TO;
 
 	chan->ops = &a2mp_chan_ops;
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index eb0ccef..621da9d 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -465,6 +465,13 @@ static void __l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan)
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
@@ -1000,6 +1007,11 @@ static void l2cap_send_disconn_req(struct l2cap_conn *conn, struct l2cap_chan *c
 		__clear_ack_timer(chan);
 	}
 
+	if (chan->chan_type == L2CAP_CHAN_CONN_FIX_A2MP) {
+		__l2cap_state_change(chan, BT_DISCONN);
+		return;
+	}
+
 	req.dcid = cpu_to_le16(chan->dcid);
 	req.scid = cpu_to_le16(chan->scid);
 	l2cap_send_cmd(conn, l2cap_get_ident(conn),
@@ -1194,6 +1206,11 @@ static void l2cap_conn_ready(struct l2cap_conn *conn)
 
 		l2cap_chan_lock(chan);
 
+		if (chan->chan_type == L2CAP_CHAN_CONN_FIX_A2MP) {
+			l2cap_chan_unlock(chan);
+			continue;
+		}
+
 		if (conn->hcon->type == LE_LINK) {
 			if (smp_conn_security(conn, chan->sec_level))
 				l2cap_chan_ready(chan);
-- 
1.7.9.5

