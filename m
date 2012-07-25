Return-Path: <cyrus@holtmann.org>
From: Mat Martineau <mathewm@codeaurora.org>
To: linux-bluetooth@vger.kernel.org, gustavo@padovan.org,
	Andrei.Emeltchenko.news@gmail.com
Cc: pkrystad@codeaurora.org
Subject: [RFCv0 08/21] Bluetooth: Add move channel confirm handling
Date: Wed, 25 Jul 2012 16:51:00 -0700
Message-Id: <1343260274-11953-9-git-send-email-mathewm@codeaurora.org>
In-Reply-To: <1343260274-11953-1-git-send-email-mathewm@codeaurora.org>
References: <1343260274-11953-1-git-send-email-mathewm@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
---
 net/bluetooth/l2cap_core.c | 71 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 68 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index a327f02..b91ad10 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -981,6 +981,9 @@ static void l2cap_move_setup(struct l2cap_chan *chan)
 
 	BT_DBG("chan %p", chan);
 
+	if (chan->mode != L2CAP_MODE_ERTM)
+		return;
+
 	__clear_retrans_timer(chan);
 	__clear_monitor_timer(chan);
 	__clear_ack_timer(chan);
@@ -1007,6 +1010,36 @@ static void l2cap_move_setup(struct l2cap_chan *chan)
 	set_bit(CONN_REMOTE_BUSY, &chan->conn_state);
 }
 
+static void l2cap_move_success(struct l2cap_chan *chan)
+{
+	BT_DBG("chan %p", chan);
+
+	if (chan->mode != L2CAP_MODE_ERTM)
+		return;
+
+	if (chan->move_role == L2CAP_MOVE_ROLE_INITIATOR) {
+		l2cap_tx(chan, NULL, NULL, L2CAP_EV_EXPLICIT_POLL);
+		chan->rx_state = L2CAP_RX_STATE_WAIT_F;
+	} else if (chan->move_role == L2CAP_MOVE_ROLE_RESPONDER) {
+		chan->rx_state = L2CAP_RX_STATE_WAIT_P;
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
+	if (chan->move_role == L2CAP_MOVE_ROLE_INITIATOR) {
+		l2cap_tx(chan, NULL, NULL, L2CAP_EV_EXPLICIT_POLL);
+		chan->rx_state = L2CAP_RX_STATE_WAIT_F;
+	} else if (chan->move_role == L2CAP_MOVE_ROLE_RESPONDER) {
+		chan->rx_state = L2CAP_RX_STATE_WAIT_P;
+	}
+}
+
 static void l2cap_chan_ready(struct l2cap_chan *chan)
 {
 	/* This clears all conf flags, including CONF_NOT_COMPLETE */
@@ -4239,11 +4272,12 @@ static inline int l2cap_move_channel_rsp(struct l2cap_conn *conn,
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
@@ -4254,8 +4288,39 @@ static inline int l2cap_move_channel_confirm(struct l2cap_conn *conn,
 
 	BT_DBG("icid 0x%4.4x, result 0x%4.4x", icid, result);
 
+	chan = l2cap_get_chan_by_dcid(conn, icid);
+
+	if (!chan)
+		goto send_move_confirm_response;
+
+	if (chan->move_state == L2CAP_MOVE_WAIT_CONFIRM) {
+		chan->move_state = L2CAP_MOVE_STABLE;
+		if (result == L2CAP_MC_CONFIRMED) {
+			chan->chan_id = chan->move_id;
+			if (!chan->chan_id) {
+				/* Have moved off of AMP, free the channel */
+				chan->hs_hchan = NULL;
+				chan->hs_hcon = NULL;
+
+				/* Placeholder - free the logical link */
+			}
+			l2cap_move_success(chan);
+		} else {
+			chan->move_id = chan->chan_id;
+			l2cap_move_revert(chan);
+		}
+		chan->move_role = L2CAP_MOVE_ROLE_NONE;
+	} else if (chan->move_state == L2CAP_MOVE_WAIT_LOGICAL_CFM) {
+		BT_DBG("Bad MOVE_STATE (%d)", chan->move_state);
+	}
+
+
+send_move_confirm_response:
 	l2cap_send_move_chan_cfm_rsp(conn, cmd->ident, icid);
 
+	if (chan)
+		l2cap_chan_unlock(chan);
+
 	return 0;
 }
 
-- 
1.7.11.2

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
