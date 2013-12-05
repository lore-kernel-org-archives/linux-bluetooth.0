Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 10/32] Bluetooth: Refactor L2CAP connect rejection to its own function
Date: Thu,  5 Dec 2013 15:11:08 +0200
Message-Id: <1386249090-10236-11-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1386249090-10236-1-git-send-email-johan.hedberg@gmail.com>
References: <1386249090-10236-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

We'll need to have a separate code path for LE based connection
rejection so it's cleaner to move out the response construction code
into its own function (and later a second one for LE).

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/l2cap_core.c | 42 ++++++++++++++++++++++++------------------
 1 file changed, 24 insertions(+), 18 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 256662578f89..5f9287fd86df 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -617,6 +617,27 @@ void l2cap_chan_del(struct l2cap_chan *chan, int err)
 	return;
 }
 
+static void l2cap_chan_connect_reject(struct l2cap_chan *chan)
+{
+	struct l2cap_conn *conn = chan->conn;
+	struct l2cap_conn_rsp rsp;
+	u16 result;
+
+	if (test_bit(FLAG_DEFER_SETUP, &chan->flags))
+		result = L2CAP_CR_SEC_BLOCK;
+	else
+		result = L2CAP_CR_BAD_PSM;
+
+	l2cap_state_change(chan, BT_DISCONN);
+
+	rsp.scid   = cpu_to_le16(chan->dcid);
+	rsp.dcid   = cpu_to_le16(chan->scid);
+	rsp.result = cpu_to_le16(result);
+	rsp.status = __constant_cpu_to_le16(L2CAP_CS_NO_INFO);
+
+	l2cap_send_cmd(conn, chan->ident, L2CAP_CONN_RSP, sizeof(rsp), &rsp);
+}
+
 void l2cap_chan_close(struct l2cap_chan *chan, int reason)
 {
 	struct l2cap_conn *conn = chan->conn;
@@ -639,24 +660,9 @@ void l2cap_chan_close(struct l2cap_chan *chan, int reason)
 		break;
 
 	case BT_CONNECT2:
-		if (chan->chan_type == L2CAP_CHAN_CONN_ORIENTED &&
-		    conn->hcon->type == ACL_LINK) {
-			struct l2cap_conn_rsp rsp;
-			__u16 result;
-
-			if (test_bit(FLAG_DEFER_SETUP, &chan->flags))
-				result = L2CAP_CR_SEC_BLOCK;
-			else
-				result = L2CAP_CR_BAD_PSM;
-
-			l2cap_state_change(chan, BT_DISCONN);
-
-			rsp.scid   = cpu_to_le16(chan->dcid);
-			rsp.dcid   = cpu_to_le16(chan->scid);
-			rsp.result = cpu_to_le16(result);
-			rsp.status = __constant_cpu_to_le16(L2CAP_CS_NO_INFO);
-			l2cap_send_cmd(conn, chan->ident, L2CAP_CONN_RSP,
-				       sizeof(rsp), &rsp);
+		if (chan->chan_type == L2CAP_CHAN_CONN_ORIENTED) {
+			if (conn->hcon->type == ACL_LINK)
+				l2cap_chan_connect_reject(chan);
 		}
 
 		l2cap_chan_del(chan, reason);
-- 
1.8.4.2

