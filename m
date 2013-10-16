Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/3] Bluetooth: Fix L2CAP "Command Reject: Invalid CID" response
Date: Wed, 16 Oct 2013 11:06:39 +0300
Message-Id: <1381910801-3130-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1381910801-3130-1-git-send-email-johan.hedberg@gmail.com>
References: <1381910801-3130-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

When the reason code in the L2CAP command reject is "invalid CID" there
should be four additional bytes of data in the PDU, namely the source
and destination CIDs (which should be zero if one or both are not
applicable). This patch fixes all occurrences of such errors to return
the right kind of PDU.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/l2cap_core.c | 38 +++++++++++++++++++++++---------------
 1 file changed, 23 insertions(+), 15 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 72ce21a..7d25ec5 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -3971,6 +3971,18 @@ static void l2cap_send_efs_conf_rsp(struct l2cap_chan *chan, void *data,
 					    L2CAP_CONF_SUCCESS, flags), data);
 }
 
+static void cmd_reject_invalid_cid(struct l2cap_conn *conn, u8 ident,
+				   u16 scid, u16 dcid)
+{
+	struct l2cap_cmd_rej_cid rej;
+
+	rej.reason = __constant_cpu_to_le16(L2CAP_REJ_INVALID_CID);
+	rej.scid = __cpu_to_le16(scid);
+	rej.dcid = __cpu_to_le16(dcid);
+
+	l2cap_send_cmd(conn, ident, L2CAP_COMMAND_REJ, sizeof(rej), &rej);
+}
+
 static inline int l2cap_config_req(struct l2cap_conn *conn,
 				   struct l2cap_cmd_hdr *cmd, u16 cmd_len,
 				   u8 *data)
@@ -3990,18 +4002,14 @@ static inline int l2cap_config_req(struct l2cap_conn *conn,
 	BT_DBG("dcid 0x%4.4x flags 0x%2.2x", dcid, flags);
 
 	chan = l2cap_get_chan_by_scid(conn, dcid);
-	if (!chan)
-		return -EBADSLT;
+	if (!chan) {
+		cmd_reject_invalid_cid(conn, cmd->ident, dcid, 0);
+		return 0;
+	}
 
 	if (chan->state != BT_CONFIG && chan->state != BT_CONNECT2) {
-		struct l2cap_cmd_rej_cid rej;
-
-		rej.reason = __constant_cpu_to_le16(L2CAP_REJ_INVALID_CID);
-		rej.scid = cpu_to_le16(chan->scid);
-		rej.dcid = cpu_to_le16(chan->dcid);
-
-		l2cap_send_cmd(conn, cmd->ident, L2CAP_COMMAND_REJ,
-			       sizeof(rej), &rej);
+		cmd_reject_invalid_cid(conn, cmd->ident, chan->scid,
+				       chan->dcid);
 		goto unlock;
 	}
 
@@ -4217,8 +4225,8 @@ static inline int l2cap_disconnect_req(struct l2cap_conn *conn,
 
 	chan = __l2cap_get_chan_by_scid(conn, dcid);
 	if (!chan) {
-		mutex_unlock(&conn->chan_lock);
-		return -EBADSLT;
+		cmd_reject_invalid_cid(conn, cmd->ident, dcid, scid);
+		return 0;
 	}
 
 	l2cap_chan_lock(chan);
@@ -4447,7 +4455,9 @@ static int l2cap_create_channel_req(struct l2cap_conn *conn,
 						  &conn->hcon->dst);
 		if (!hs_hcon) {
 			hci_dev_put(hdev);
-			return -EBADSLT;
+			cmd_reject_invalid_cid(conn, cmd->ident, chan->scid,
+					       chan->dcid);
+			return 0;
 		}
 
 		BT_DBG("mgr %p bredr_chan %p hs_hcon %p", mgr, chan, hs_hcon);
@@ -5306,8 +5316,6 @@ static inline int l2cap_le_sig_cmd(struct l2cap_conn *conn,
 static __le16 l2cap_err_to_reason(int err)
 {
 	switch (err) {
-	case -EBADSLT:
-		return __constant_cpu_to_le16(L2CAP_REJ_INVALID_CID);
 	case -EMSGSIZE:
 		return __constant_cpu_to_le16(L2CAP_REJ_MTU_EXCEEDED);
 	case -EINVAL:
-- 
1.8.3.1

