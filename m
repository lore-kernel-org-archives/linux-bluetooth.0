Return-Path: <cyrus@holtmann.org>
From: Mat Martineau <mathewm@codeaurora.org>
To: linux-bluetooth@vger.kernel.org, gustavo@padovan.org,
	Andrei.Emeltchenko.news@gmail.com
Cc: pkrystad@codeaurora.org
Subject: [RFCv0 10/21] Bluetooth: Add logical link confirm
Date: Wed, 25 Jul 2012 16:51:02 -0700
Message-Id: <1343260274-11953-11-git-send-email-mathewm@codeaurora.org>
In-Reply-To: <1343260274-11953-1-git-send-email-mathewm@codeaurora.org>
References: <1343260274-11953-1-git-send-email-mathewm@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
---
 include/net/bluetooth/l2cap.h |   1 +
 net/bluetooth/l2cap_core.c    | 120 +++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 119 insertions(+), 2 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index fcc971a..7c50606 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -461,6 +461,7 @@ struct l2cap_chan {
 
 	__u8		conf_req[64];
 	__u8		conf_len;
+	__u8		conf_ident;
 	__u8		num_conf_req;
 	__u8		num_conf_rsp;
 
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 8d72f2e..79f9d8e 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -3717,6 +3717,7 @@ static inline int l2cap_config_req(struct l2cap_conn *conn, struct l2cap_cmd_hdr
 		goto unlock;
 	}
 
+	chan->conf_ident = cmd->ident;
 	l2cap_send_cmd(conn, cmd->ident, L2CAP_CONF_RSP, len, rsp);
 	chan->num_conf_rsp++;
 
@@ -4161,11 +4162,126 @@ static void l2cap_send_move_chan_cfm_rsp(struct l2cap_conn *conn, u8 ident,
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
+	if (chan->state != BT_CONNECTED && !chan->chan_id)
+		return;
+
+	if (chan && !status && chan->state != BT_CONNECTED) {
+		struct l2cap_conf_rsp rsp;
+		u8 code;
+
+		/* Create channel complete */
+		chan->hs_hcon = hchan->conn;
+		chan->hs_hcon->l2cap_data = chan->conn;
+
+		code = l2cap_build_conf_rsp(chan, &rsp,
+					    L2CAP_CONF_SUCCESS, 0);
+		l2cap_send_cmd(chan->conn, chan->conf_ident,
+			       L2CAP_CONF_RSP, code, &rsp);
+		set_bit(CONF_OUTPUT_DONE, &chan->conf_state);
+
+		if (test_bit(CONF_INPUT_DONE, &chan->conf_state)) {
+			int err = 0;
+
+			set_default_fcs(chan);
+
+			if (chan->mode == L2CAP_MODE_ERTM ||
+			    chan->mode == L2CAP_MODE_STREAMING)
+				err = l2cap_ertm_init(chan);
+
+			if (err < 0)
+				l2cap_send_disconn_req(chan->conn, chan, -err);
+			else
+				l2cap_chan_ready(chan);
+		}
+	} else if (chan && !status) {
+		/* Channel move */
+		chan->hs_hcon = hchan->conn;
+		chan->hs_hcon->l2cap_data = chan->conn;
+
+		BT_DBG("move_state %d", chan->move_state);
+
+		if (chan->state != BT_CONNECTED) {
+			return;
+		}
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
+							 chan->move_cmd_ident,
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
+	} else {
+		/* Logical link setup failed. */
+
+		if (chan->state != BT_CONNECTED)
+			l2cap_send_disconn_req(chan->conn, chan, ECONNRESET);
+		else if (chan->move_role == L2CAP_MOVE_ROLE_RESPONDER) {
+			l2cap_move_revert(chan);
+			chan->move_role = L2CAP_MOVE_ROLE_NONE;
+			chan->move_state = L2CAP_MOVE_STABLE;
+			l2cap_send_move_chan_rsp(chan->conn,
+						 chan->move_cmd_ident,
+						 chan->dcid,
+						 L2CAP_MR_NOT_SUPP);
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
+	}
 }
 
 static inline int l2cap_move_channel_req(struct l2cap_conn *conn,
-- 
1.7.11.2

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
