Return-Path: <cyrus@holtmann.org>
From: Mat Martineau <mathewm@codeaurora.org>
To: linux-bluetooth@vger.kernel.org, gustavo@padovan.org
Cc: sunnyk@codeaurora.org, marcel@holtmann.org,
	andrei.emeltchenko.news@gmail.com
Subject: [PATCHv3 07/18] Bluetooth: Add move channel confirm handling
Date: Thu, 18 Oct 2012 10:58:39 -0700
Message-Id: <1350583130-3241-8-git-send-email-mathewm@codeaurora.org>
In-Reply-To: <1350583130-3241-1-git-send-email-mathewm@codeaurora.org>
References: <1350583130-3241-1-git-send-email-mathewm@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

After sending a move channel response, a move responder waits for a
move channel confirm command.  If the received command has a
"confirmed" result the move is proceeding, and "unconfirmed" means the
move has failed and the channel will not change controllers.

Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
---
 net/bluetooth/l2cap_core.c | 71 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 68 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index ff25bf4..2fa1bb5 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1036,6 +1036,42 @@ static void l2cap_move_setup(struct l2cap_chan *chan)
 	set_bit(CONN_REMOTE_BUSY, &chan->conn_state);
 }
 
+static void l2cap_move_success(struct l2cap_chan *chan)
+{
+	BT_DBG("chan %p", chan);
+
+	if (chan->mode != L2CAP_MODE_ERTM)
+		return;
+
+	switch (chan->move_role) {
+	case L2CAP_MOVE_ROLE_INITIATOR:
+		l2cap_tx(chan, NULL, NULL, L2CAP_EV_EXPLICIT_POLL);
+		chan->rx_state = L2CAP_RX_STATE_WAIT_F;
+		break;
+	case L2CAP_MOVE_ROLE_RESPONDER:
+		chan->rx_state = L2CAP_RX_STATE_WAIT_P;
+		break;
+	}
+}
+
+static void l2cap_move_revert(struct l2cap_chan *chan)
+{
+	BT_DBG("chan %p", chan);
+
+	if (chan->mode != L2CAP_MODE_ERTM)
+		return;
+
+	switch (chan->move_role) {
+	case L2CAP_MOVE_ROLE_INITIATOR:
+		l2cap_tx(chan, NULL, NULL, L2CAP_EV_EXPLICIT_POLL);
+		chan->rx_state = L2CAP_RX_STATE_WAIT_F;
+		break;
+	case L2CAP_MOVE_ROLE_RESPONDER:
+		chan->rx_state = L2CAP_RX_STATE_WAIT_P;
+		break;
+	}
+}
+
 static void l2cap_chan_ready(struct l2cap_chan *chan)
 {
 	/* This clears all conf flags, including CONF_NOT_COMPLETE */
@@ -4301,11 +4337,12 @@ static inline int l2cap_move_channel_rsp(struct l2cap_conn *conn,
 	return 0;
 }
 
-static inline int l2cap_move_channel_confirm(struct l2cap_conn *conn,
-					     struct l2cap_cmd_hdr *cmd,
-					     u16 cmd_len, void *data)
+static int l2cap_move_channel_confirm(struct l2cap_conn *conn,
+				      struct l2cap_cmd_hdr *cmd,
+				      u16 cmd_len, void *data)
 {
 	struct l2cap_move_chan_cfm *cfm = data;
+	struct l2cap_chan *chan;
 	u16 icid, result;
 
 	if (cmd_len != sizeof(*cfm))
@@ -4316,8 +4353,36 @@ static inline int l2cap_move_channel_confirm(struct l2cap_conn *conn,
 
 	BT_DBG("icid 0x%4.4x, result 0x%4.4x", icid, result);
 
+	chan = l2cap_get_chan_by_dcid(conn, icid);
+	if (!chan) {
+		/* Spec requires a response even if the icid was not found */
+		l2cap_send_move_chan_cfm_rsp(conn, cmd->ident, icid);
+		return 0;
+	}
+
+	if (chan->move_state == L2CAP_MOVE_WAIT_CONFIRM) {
+		chan->move_state = L2CAP_MOVE_STABLE;
+		if (result == L2CAP_MC_CONFIRMED) {
+			chan->local_amp_id = chan->move_id;
+			if (!chan->local_amp_id) {
+				/* Have moved off of AMP, free the channel */
+				chan->hs_hchan = NULL;
+				chan->hs_hcon = NULL;
+
+				/* Placeholder - free the logical link */
+			}
+			l2cap_move_success(chan);
+		} else {
+			chan->move_id = chan->local_amp_id;
+			l2cap_move_revert(chan);
+		}
+		chan->move_role = L2CAP_MOVE_ROLE_NONE;
+	}
+
 	l2cap_send_move_chan_cfm_rsp(conn, cmd->ident, icid);
 
+	l2cap_chan_unlock(chan);
+
 	return 0;
 }
 
-- 
1.7.12.3

--
Mat Martineau

Employee of Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
