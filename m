Return-Path: <cyrus@holtmann.org>
From: Mat Martineau <mathewm@codeaurora.org>
To: linux-bluetooth@vger.kernel.org, gustavo@padovan.org,
	Andrei.Emeltchenko.news@gmail.com
Cc: pkrystad@codeaurora.org
Subject: [RFCv0 19/21] Bluetooth: Tie AMP link setup to connect/disconnect
Date: Wed, 25 Jul 2012 16:51:11 -0700
Message-Id: <1343260274-11953-20-git-send-email-mathewm@codeaurora.org>
In-Reply-To: <1343260274-11953-1-git-send-email-mathewm@codeaurora.org>
References: <1343260274-11953-1-git-send-email-mathewm@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
---
 net/bluetooth/l2cap_core.c | 83 ++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 77 insertions(+), 6 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index e4df53d..d69b4b3 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -56,7 +56,10 @@ static void l2cap_send_disconn_req(struct l2cap_conn *conn,
 				   struct l2cap_chan *chan, int err);
 
 static void l2cap_tx(struct l2cap_chan *chan, struct l2cap_ctrl *control,
-		    struct sk_buff_head *skbs, u8 event);
+		     struct sk_buff_head *skbs, u8 event);
+
+static void l2cap_logical_cfm(struct l2cap_chan *chan, struct hci_chan *hchan,
+			      u8 status);
 
 /* ---- L2CAP channels ---- */
 
@@ -552,6 +555,13 @@ void l2cap_chan_del(struct l2cap_chan *chan, int err)
 			hci_conn_put(conn->hcon);
 	}
 
+	if (chan->hs_hchan) {
+		chan->hs_hchan = NULL;
+		chan->hs_hcon = NULL;
+
+		/* Placeholder - free logical link */
+	}
+
 	if (chan->ops->teardown)
 		chan->ops->teardown(chan, err);
 
@@ -1092,8 +1102,19 @@ static void l2cap_do_start(struct l2cap_chan *chan)
 			return;
 
 		if (l2cap_chan_check_security(chan) &&
-				__l2cap_no_conn_pending(chan))
-			l2cap_send_conn_req(chan);
+		    __l2cap_no_conn_pending(chan)) {
+			if (enable_hs &&
+			    (conn->fixed_chan_mask & L2CAP_FC_A2MP) &&
+			    chan->chan_policy == BT_CHANNEL_POLICY_AMP_PREFERRED) {
+				set_bit(CONF_CONNECT_PEND, &chan->conf_state);
+
+				/* Placeholder
+				amp_create_phylink();
+				*/
+			} else {
+				l2cap_send_conn_req(chan);
+			}
+		}
 	} else {
 		struct l2cap_info_req req;
 		req.type = __constant_cpu_to_le16(L2CAP_IT_FEAT_MASK);
@@ -1188,8 +1209,17 @@ static void l2cap_conn_start(struct l2cap_conn *conn)
 				continue;
 			}
 
-			l2cap_send_conn_req(chan);
+			if (enable_hs &&
+			    (conn->fixed_chan_mask & L2CAP_FC_A2MP) &&
+			    chan->chan_policy == BT_CHANNEL_POLICY_AMP_PREFERRED) {
+				set_bit(CONF_CONNECT_PEND, &chan->conf_state);
 
+				/* Placeholder
+				amp_create_phylink();
+				*/
+			} else {
+				l2cap_send_conn_req(chan);
+			}
 		} else if (chan->state == BT_CONNECT2) {
 			struct l2cap_conn_rsp rsp;
 			char buf[128];
@@ -1217,8 +1247,18 @@ static void l2cap_conn_start(struct l2cap_conn *conn)
 				rsp.status = __constant_cpu_to_le16(L2CAP_CS_AUTHEN_PEND);
 			}
 
+			if (rsp.result == __constant_cpu_to_le16(L2CAP_CR_SUCCESS) &&
+			    chan->chan_id) {
+				/* Placeholder - uncomment when amp functions
+				 * are available
+				amp_accept_physical(chan, chan->chan_id);
+				 */
+				l2cap_chan_unlock(chan);
+				continue;
+			}
+
 			l2cap_send_cmd(conn, chan->ident, L2CAP_CONN_RSP,
-							sizeof(rsp), &rsp);
+				       sizeof(rsp), &rsp);
 
 			if (test_bit(CONF_REQ_SENT, &chan->conf_state) ||
 					rsp.result != L2CAP_CR_SUCCESS) {
@@ -3301,6 +3341,18 @@ done:
 			rfc.mode = chan->mode;
 		}
 
+		if (test_bit(CONF_LOC_CONF_PEND, &chan->conf_state) &&
+		    chan->chan_id) {
+			struct hci_chan *hchan = NULL;
+
+			/* Placeholder - get hci_chan for logical link */
+
+			if (hchan && hchan->state == BT_CONNECTED) {
+				l2cap_logical_cfm(chan, hchan,
+						  L2CAP_MR_SUCCESS);
+			}
+		}
+
 		if (result == L2CAP_CONF_SUCCESS)
 			set_bit(CONF_OUTPUT_DONE, &chan->conf_state);
 	}
@@ -6262,7 +6314,18 @@ int l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
 
 		if (chan->state == BT_CONNECT) {
 			if (!status) {
-				l2cap_send_conn_req(chan);
+				if (enable_hs &&
+				    (conn->fixed_chan_mask & L2CAP_FC_A2MP) &&
+				    chan->chan_policy == BT_CHANNEL_POLICY_AMP_PREFERRED) {
+					set_bit(CONF_CONNECT_PEND,
+						&chan->conf_state);
+
+					/* Placeholder
+					amp_create_phylink();
+					*/
+				} else {
+					l2cap_send_conn_req(chan);
+				}
 			} else {
 				__set_chan_timer(chan, L2CAP_DISC_TIMEOUT);
 			}
@@ -6282,6 +6345,14 @@ int l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
 					if (parent)
 						parent->sk_data_ready(parent, 0);
 				} else {
+					if (chan->chan_id) {
+						/* Placeholder - accept physical
+						 * link
+						amp_accept_physical(chan, chan->chan_id);
+						*/
+						continue;
+					}
+
 					__l2cap_state_change(chan, BT_CONFIG);
 					res = L2CAP_CR_SUCCESS;
 					stat = L2CAP_CS_NO_INFO;
-- 
1.7.11.2

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
