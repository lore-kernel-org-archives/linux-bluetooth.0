Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: Rename L2CAP_CHAN_CONN_FIX_A2MP to L2CAP_CHAN_FIXED_CID
Date: Thu, 23 Jan 2014 15:22:47 +0200
Message-Id: <1390483368-21321-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

There's no reason why A2DP should need or deserve its on channel type.
Instead we should be able to group all fixed CID users under a single
channel type and reuse as much code as possible for them. Where CID
specific exceptions are needed the chan-scid value can be used.

This patch renames the current A2DP channel type to a generic one and
thereby paves the way to allow converting ATT and SMP (and any future
fixed channel protocols) to use the new channel type.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/l2cap.h |  2 +-
 net/bluetooth/a2mp.c          |  8 ++++++--
 net/bluetooth/l2cap_core.c    | 15 ++++++---------
 3 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 85cf40acc47e..eeb02f414255 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -651,7 +651,7 @@ struct l2cap_user {
 #define L2CAP_CHAN_RAW			1
 #define L2CAP_CHAN_CONN_LESS		2
 #define L2CAP_CHAN_CONN_ORIENTED	3
-#define L2CAP_CHAN_CONN_FIX_A2MP	4
+#define L2CAP_CHAN_FIXED_CID		4
 
 /* ----- L2CAP socket info ----- */
 #define l2cap_pi(sk) ((struct l2cap_pinfo *) sk)
diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
index efcd108822c4..677b970cede6 100644
--- a/net/bluetooth/a2mp.c
+++ b/net/bluetooth/a2mp.c
@@ -235,7 +235,7 @@ static int a2mp_discover_rsp(struct amp_mgr *mgr, struct sk_buff *skb,
 			BT_DBG("chan %p state %s", chan,
 			       state_to_string(chan->state));
 
-			if (chan->chan_type == L2CAP_CHAN_CONN_FIX_A2MP)
+			if (chan->scid == L2CAP_CID_A2MP)
 				continue;
 
 			l2cap_chan_lock(chan);
@@ -726,7 +726,11 @@ static struct l2cap_chan *a2mp_chan_open(struct l2cap_conn *conn, bool locked)
 
 	BT_DBG("chan %p", chan);
 
-	chan->chan_type = L2CAP_CHAN_CONN_FIX_A2MP;
+	chan->chan_type = L2CAP_CHAN_FIXED_CID;
+	chan->scid = L2CAP_CID_A2MP;
+	chan->dcid = L2CAP_CID_A2MP;
+	chan->omtu = L2CAP_A2MP_DEFAULT_MTU;
+	chan->imtu = L2CAP_A2MP_DEFAULT_MTU;
 	chan->flush_to = L2CAP_DEFAULT_FLUSH_TO;
 
 	chan->ops = &a2mp_chan_ops;
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 138394ad3e51..84714541b48c 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -519,11 +519,8 @@ void __l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan)
 		chan->omtu = L2CAP_DEFAULT_MTU;
 		break;
 
-	case L2CAP_CHAN_CONN_FIX_A2MP:
-		chan->scid = L2CAP_CID_A2MP;
-		chan->dcid = L2CAP_CID_A2MP;
-		chan->omtu = L2CAP_A2MP_DEFAULT_MTU;
-		chan->imtu = L2CAP_A2MP_DEFAULT_MTU;
+	case L2CAP_CHAN_FIXED_CID:
+		/* Caller will set CID and CID specific MTU values */
 		break;
 
 	default:
@@ -571,7 +568,7 @@ void l2cap_chan_del(struct l2cap_chan *chan, int err)
 
 		chan->conn = NULL;
 
-		if (chan->chan_type != L2CAP_CHAN_CONN_FIX_A2MP)
+		if (chan->scid != L2CAP_CID_A2MP)
 			hci_conn_drop(conn->hcon);
 
 		if (mgr && mgr->bredr_chan == chan)
@@ -1310,7 +1307,7 @@ static void l2cap_send_disconn_req(struct l2cap_chan *chan, int err)
 		__clear_ack_timer(chan);
 	}
 
-	if (chan->chan_type == L2CAP_CHAN_CONN_FIX_A2MP) {
+	if (chan->scid == L2CAP_CID_A2MP) {
 		l2cap_state_change(chan, BT_DISCONN);
 		return;
 	}
@@ -1508,7 +1505,7 @@ static void l2cap_conn_ready(struct l2cap_conn *conn)
 
 		l2cap_chan_lock(chan);
 
-		if (chan->chan_type == L2CAP_CHAN_CONN_FIX_A2MP) {
+		if (chan->scid == L2CAP_CID_A2MP) {
 			l2cap_chan_unlock(chan);
 			continue;
 		}
@@ -7245,7 +7242,7 @@ int l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
 		BT_DBG("chan %p scid 0x%4.4x state %s", chan, chan->scid,
 		       state_to_string(chan->state));
 
-		if (chan->chan_type == L2CAP_CHAN_CONN_FIX_A2MP) {
+		if (chan->scid == L2CAP_CID_A2MP) {
 			l2cap_chan_unlock(chan);
 			continue;
 		}
-- 
1.8.5.3

