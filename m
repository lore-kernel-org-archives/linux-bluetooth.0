Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 18/19] Bluetooth: A2MP: Handling fixed channels
Date: Wed, 23 May 2012 18:37:24 +0300
Message-Id: <1337787445-23235-19-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1337787445-23235-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1337351150-20526-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1337787445-23235-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
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
index b022329..2fd0afd 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -575,6 +575,7 @@ struct l2cap_conn {
 #define L2CAP_CHAN_RAW			1
 #define L2CAP_CHAN_CONN_LESS		2
 #define L2CAP_CHAN_CONN_ORIENTED	3
+#define L2CAP_CHAN_CONN_FIX_A2MP	4
 
 /* ----- L2CAP socket info ----- */
 #define l2cap_pi(sk) ((struct l2cap_pinfo *) sk)
diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
index a454f8b..894e53c 100644
--- a/net/bluetooth/a2mp.c
+++ b/net/bluetooth/a2mp.c
@@ -466,8 +466,7 @@ static struct l2cap_chan *a2mp_chan_open(struct l2cap_conn *conn)
 
 	hci_conn_hold(conn->hcon);
 
-	chan->omtu = L2CAP_A2MP_DEFAULT_MTU;
-	chan->imtu = L2CAP_A2MP_DEFAULT_MTU;
+	chan->chan_type = L2CAP_CHAN_CONN_FIX_A2MP;
 	chan->flush_to = L2CAP_DEFAULT_FLUSH_TO;
 
 	chan->ops = &a2mp_chan_ops;
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 988ee09..bd9197c 100644
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
@@ -1014,6 +1021,11 @@ static void l2cap_send_disconn_req(struct l2cap_conn *conn, struct l2cap_chan *c
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
@@ -1217,6 +1229,11 @@ static void l2cap_conn_ready(struct l2cap_conn *conn)
 
 		l2cap_chan_lock(chan);
 
+		if (chan->chan_type == L2CAP_CHAN_CONN_FIX_A2MP) {
+			l2cap_chan_unlock(chan);
+			continue;
+		}
+
 		if (conn->hcon->type == LE_LINK) {
 			if (smp_conn_security(conn, chan->sec_level))
 				if (chan->ops->ready)
-- 
1.7.9.5

