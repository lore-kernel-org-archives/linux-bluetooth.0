Return-Path: <cyrus@holtmann.org>
From: Mat Martineau <mathewm@codeaurora.org>
To: linux-bluetooth@vger.kernel.org,
	gustavo@padovan.org
Cc: sunnyk@codeaurora.org,
	marcel@holtmann.org
Subject: [PATCHv2 10/19] Bluetooth: Add logical link confirm
Date: Tue, 16 Oct 2012 16:36:24 -0700
Message-Id: <1350430593-23565-11-git-send-email-mathewm@codeaurora.org>
In-Reply-To: <1350430593-23565-1-git-send-email-mathewm@codeaurora.org>
References: <1350430593-23565-1-git-send-email-mathewm@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

The logical link confirm callback is executed when the AMP controller
completes its logical link setup.  During a channel move, a newly
formed logical link allows a move responder to send a move channel
response.  A move initiator will send a move channel confirm.  A
failed logical link will end the channel move and send an appropriate
response or confirm command indicating a failure.

If the channel is being created on an AMP controller, L2CAP
configuration is started after the logical link is set up.

Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
---
 net/bluetooth/l2cap_core.c | 114 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 112 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 5e4796c..ddd8c72 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -3799,6 +3799,7 @@ static inline int l2cap_config_req(struct l2cap_conn *conn,
 		goto unlock;
 	}
 
+	chan->ident = cmd->ident;
 	l2cap_send_cmd(conn, cmd->ident, L2CAP_CONF_RSP, len, rsp);
 	chan->num_conf_rsp++;
 
@@ -4241,11 +4242,120 @@ static void l2cap_send_move_chan_cfm_rsp(struct l2cap_conn *conn, u8 ident,
 	l2cap_send_cmd(conn, ident, L2CAP_MOVE_CHAN_CFM_RSP, sizeof(rsp), &rsp);
 }
 
+/* Call with chan locked */
 static void l2cap_logical_cfm(struct l2cap_chan *chan, struct hci_chan *hchan,
 			      u8 status)
 {
-	/* Placeholder */
-	return;
+	BT_DBG("chan %p, hchan %p, status %d", chan, hchan, status);
+
+	if (status) {
+		/* Logical link setup failed */
+		if (chan->state != BT_CONNECTED) {
+			/* Create channel failure, disconnect */
+			l2cap_send_disconn_req(chan->conn, chan, ECONNRESET);
+		} else if (chan->move_role == L2CAP_MOVE_ROLE_RESPONDER) {
+			l2cap_move_revert(chan);
+			chan->move_role = L2CAP_MOVE_ROLE_NONE;
+			chan->move_state = L2CAP_MOVE_STABLE;
+			l2cap_send_move_chan_rsp(chan->conn, chan->ident,
+						 chan->dcid, L2CAP_MR_NOT_SUPP);
+		} else if (chan->move_role == L2CAP_MOVE_ROLE_INITIATOR) {
+			if (chan->move_state == L2CAP_MOVE_WAIT_LOGICAL_COMP ||
+			    chan->move_state == L2CAP_MOVE_WAIT_LOGICAL_CFM) {
+				/* Remote has only sent pending or
+				 * success responses, clean up
+				 */
+				l2cap_move_revert(chan);
+				chan->move_role = L2CAP_MOVE_ROLE_NONE;
+				chan->move_state = L2CAP_MOVE_STABLE;
+			}
+
+			/* Other amp move states imply that the move
+			 * has already aborted
+			 */
+			l2cap_send_move_chan_cfm(chan->conn, chan, chan->scid,
+						 L2CAP_MC_UNCONFIRMED);
+			__set_chan_timer(chan, L2CAP_MOVE_TIMEOUT);
+		}
+
+		chan->hs_hchan = NULL;
+		chan->hs_hcon = NULL;
+
+		/* Placeholder - free logical link */
+
+	} else if (chan->state != BT_CONNECTED) {
+		struct l2cap_conf_rsp rsp;
+		u8 code;
+
+		/* Create channel complete */
+
+		/* Ignore logical link if channel is on BR/EDR */
+		if (!chan->local_amp_id)
+			return;
+
+		chan->hs_hcon = hchan->conn;
+		chan->hs_hcon->l2cap_data = chan->conn;
+
+		code = l2cap_build_conf_rsp(chan, &rsp,
+					    L2CAP_CONF_SUCCESS, 0);
+		l2cap_send_cmd(chan->conn, chan->ident, L2CAP_CONF_RSP, code,
+			       &rsp);
+		set_bit(CONF_OUTPUT_DONE, &chan->conf_state);
+
+		if (test_bit(CONF_INPUT_DONE, &chan->conf_state)) {
+			int err = 0;
+
+			set_default_fcs(chan);
+
+			err = l2cap_ertm_init(chan);
+			if (err < 0)
+				l2cap_send_disconn_req(chan->conn, chan, -err);
+			else
+				l2cap_chan_ready(chan);
+		}
+	} else {
+		/* Channel move */
+		chan->hs_hcon = hchan->conn;
+		chan->hs_hcon->l2cap_data = chan->conn;
+
+		BT_DBG("move_state %d", chan->move_state);
+
+		switch (chan->move_state) {
+		case L2CAP_MOVE_WAIT_LOGICAL_COMP:
+			/* Move confirm will be sent after a success
+			 * response is received
+			 */
+			chan->move_state = L2CAP_MOVE_WAIT_RSP_SUCCESS;
+			break;
+		case L2CAP_MOVE_WAIT_LOGICAL_CFM:
+			if (test_bit(CONN_LOCAL_BUSY, &chan->conn_state)) {
+				chan->move_state = L2CAP_MOVE_WAIT_LOCAL_BUSY;
+			} else if (chan->move_role ==
+				   L2CAP_MOVE_ROLE_INITIATOR) {
+				chan->move_state = L2CAP_MOVE_WAIT_CONFIRM_RSP;
+				l2cap_send_move_chan_cfm(chan->conn, chan,
+							 chan->scid,
+							 L2CAP_MR_SUCCESS);
+				__set_chan_timer(chan, L2CAP_MOVE_TIMEOUT);
+			} else if (chan->move_role ==
+				   L2CAP_MOVE_ROLE_RESPONDER) {
+				chan->move_state = L2CAP_MOVE_WAIT_CONFIRM;
+				l2cap_send_move_chan_rsp(chan->conn,
+							 chan->ident,
+							 chan->dcid,
+							 L2CAP_MR_SUCCESS);
+			}
+			break;
+		default:
+			/* Move was not in expected state, free the channel */
+			chan->hs_hchan = NULL;
+			chan->hs_hcon = NULL;
+
+			/* Placeholder - free the logical link */
+
+			chan->move_state = L2CAP_MOVE_STABLE;
+		}
+	}
 }
 
 static inline int l2cap_move_channel_req(struct l2cap_conn *conn,
-- 
1.7.12.3

--
Mat Martineau

Employee of Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
