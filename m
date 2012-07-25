Return-Path: <cyrus@holtmann.org>
From: Mat Martineau <mathewm@codeaurora.org>
To: linux-bluetooth@vger.kernel.org, gustavo@padovan.org,
	Andrei.Emeltchenko.news@gmail.com
Cc: pkrystad@codeaurora.org
Subject: [RFCv0 09/21] Bluetooth: Move channel response
Date: Wed, 25 Jul 2012 16:51:01 -0700
Message-Id: <1343260274-11953-10-git-send-email-mathewm@codeaurora.org>
In-Reply-To: <1343260274-11953-1-git-send-email-mathewm@codeaurora.org>
References: <1343260274-11953-1-git-send-email-mathewm@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
---
 include/net/bluetooth/l2cap.h |   2 +
 net/bluetooth/l2cap_core.c    | 138 +++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 138 insertions(+), 2 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index c585def..fcc971a 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -51,6 +51,8 @@
 #define L2CAP_ENC_TIMEOUT		msecs_to_jiffies(5000)
 #define L2CAP_CONN_TIMEOUT		msecs_to_jiffies(40000)
 #define L2CAP_INFO_TIMEOUT		msecs_to_jiffies(4000)
+#define L2CAP_MOVE_TIMEOUT		msecs_to_jiffies(4000)
+#define L2CAP_MOVE_ERTX_TIMEOUT		msecs_to_jiffies(60000)
 
 #define L2CAP_A2MP_DEFAULT_MTU		670
 
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index b91ad10..8d72f2e 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -4161,6 +4161,13 @@ static void l2cap_send_move_chan_cfm_rsp(struct l2cap_conn *conn, u8 ident,
 	l2cap_send_cmd(conn, ident, L2CAP_MOVE_CHAN_CFM_RSP, sizeof(rsp), &rsp);
 }
 
+static void l2cap_logical_cfm(struct l2cap_chan *chan, struct hci_chan *hchan,
+			      u8 status)
+{
+	/* Placeholder */
+	return;
+}
+
 static inline int l2cap_move_channel_req(struct l2cap_conn *conn,
 					 struct l2cap_cmd_hdr *cmd,
 					 u16 cmd_len, void *data)
@@ -4256,6 +4263,7 @@ static inline int l2cap_move_channel_rsp(struct l2cap_conn *conn,
 					 u16 cmd_len, void *data)
 {
 	struct l2cap_move_chan_rsp *rsp = data;
+	struct l2cap_chan *chan = NULL;
 	u16 icid, result;
 
 	if (cmd_len != sizeof(*rsp))
@@ -4266,8 +4274,134 @@ static inline int l2cap_move_channel_rsp(struct l2cap_conn *conn,
 
 	BT_DBG("icid 0x%4.4x, result 0x%4.4x", icid, result);
 
-	/* Placeholder: Always unconfirmed */
-	l2cap_send_move_chan_cfm(conn, NULL, icid, L2CAP_MC_UNCONFIRMED);
+	switch (result) {
+	case L2CAP_MR_SUCCESS:
+	case L2CAP_MR_PEND:
+		chan = l2cap_get_chan_by_scid(conn, icid);
+
+		if (!chan) {
+			l2cap_send_move_chan_cfm(conn, NULL, icid,
+						 L2CAP_MC_UNCONFIRMED);
+			break;
+		}
+
+		__clear_chan_timer(chan);
+		if (result == L2CAP_MR_PEND)
+			__set_chan_timer(chan, L2CAP_MOVE_ERTX_TIMEOUT);
+
+		if (chan->move_state == L2CAP_MOVE_WAIT_LOGICAL_COMP) {
+			/* Move confirm will be sent when logical link
+			 * is complete.
+			 */
+			chan->move_state = L2CAP_MOVE_WAIT_LOGICAL_CFM;
+		} else if (chan->move_state == L2CAP_MOVE_WAIT_RSP_SUCCESS) {
+			if (result == L2CAP_MR_PEND) {
+				break;
+			} else if (test_bit(CONN_LOCAL_BUSY,
+					    &chan->conn_state)) {
+				chan->move_state = L2CAP_MOVE_WAIT_LOCAL_BUSY;
+			} else {
+				/* Logical link is up or moving to BR/EDR,
+				 * proceed with move */
+				chan->move_state = L2CAP_MOVE_WAIT_CONFIRM_RSP;
+				l2cap_send_move_chan_cfm(conn, chan, chan->scid,
+							 L2CAP_MC_CONFIRMED);
+				__set_chan_timer(chan, L2CAP_MOVE_TIMEOUT);
+			}
+		} else if (chan->move_state == L2CAP_MOVE_WAIT_RSP) {
+			struct hci_chan *hchan = NULL;
+			/* Moving to AMP */
+			if (result == L2CAP_MR_SUCCESS) {
+				/* Remote is ready, send confirm immediately
+				 * after logical link is ready
+				 */
+				chan->move_state = L2CAP_MOVE_WAIT_LOGICAL_CFM;
+			} else {
+				/* Both logical link and move success
+				 * are required to confirm
+				 */
+				chan->move_state = L2CAP_MOVE_WAIT_LOGICAL_COMP;
+			}
+
+			/* Placeholder - get hci_chan for logical link */
+			if (!hchan) {
+				/* Logical link not available */
+				l2cap_send_move_chan_cfm(conn, chan, chan->scid,
+							 L2CAP_MC_UNCONFIRMED);
+				break;
+			}
+
+			/* If the logical link is not yet connected, do not
+			 * send confirmation.
+			 */
+			if (hchan->state != BT_CONNECTED)
+				break;
+
+			/* Logical link is already ready to go */
+
+			chan->hs_hcon = hchan->conn;
+			chan->hs_hcon->l2cap_data = chan->conn;
+
+			if (result == L2CAP_MR_SUCCESS) {
+				/* Can confirm now */
+				l2cap_send_move_chan_cfm(conn, chan, chan->scid,
+							 L2CAP_MC_CONFIRMED);
+			} else {
+				/* Now only need move success
+				 * to confirm
+				 */
+				chan->move_state = L2CAP_MOVE_WAIT_RSP_SUCCESS;
+			}
+
+			l2cap_logical_cfm(chan, hchan, L2CAP_MR_SUCCESS);
+		} else {
+			/* Any other amp move state means the move failed. */
+			chan->move_id = chan->chan_id;
+			chan->move_state = L2CAP_MOVE_STABLE;
+			l2cap_move_revert(chan);
+			chan->move_role = L2CAP_MOVE_ROLE_NONE;
+			l2cap_send_move_chan_cfm(conn, chan, chan->scid,
+						L2CAP_MC_UNCONFIRMED);
+			__set_chan_timer(chan, L2CAP_MOVE_TIMEOUT);
+		}
+		break;
+	default:
+		/* Failed (including collision case) */
+		mutex_lock(&conn->chan_lock);
+		chan = __l2cap_get_chan_by_ident(conn, cmd->ident);
+		if (chan)
+			l2cap_chan_lock(chan);
+		mutex_unlock(&conn->chan_lock);
+
+		if (!chan) {
+			/* Could not locate channel, icid is best guess */
+			l2cap_send_move_chan_cfm(conn, NULL, icid,
+						 L2CAP_MC_UNCONFIRMED);
+			break;
+		}
+
+		__clear_chan_timer(chan);
+
+		if (chan->move_role == L2CAP_MOVE_ROLE_INITIATOR) {
+			if (result == L2CAP_MR_COLLISION) {
+				chan->move_role = L2CAP_MOVE_ROLE_RESPONDER;
+			} else {
+				/* Cleanup - cancel move */
+				chan->move_id = chan->chan_id;
+				chan->move_state = L2CAP_MOVE_STABLE;
+				l2cap_move_revert(chan);
+				chan->move_role = L2CAP_MOVE_ROLE_NONE;
+			}
+		}
+
+		l2cap_send_move_chan_cfm(conn, chan, chan->scid,
+					 L2CAP_MC_UNCONFIRMED);
+		__set_chan_timer(chan, L2CAP_MOVE_TIMEOUT);
+		break;
+	}
+
+	if (chan)
+		l2cap_chan_unlock(chan);
 
 	return 0;
 }
-- 
1.7.11.2

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
