Return-Path: <cyrus@holtmann.org>
From: Mat Martineau <mathewm@codeaurora.org>
To: linux-bluetooth@vger.kernel.org,
	gustavo@padovan.org
Cc: sunnyk@codeaurora.org,
	marcel@holtmann.org
Subject: [PATCH 11/19] Bluetooth: Add move confirm response handling
Date: Mon, 15 Oct 2012 08:34:00 -0700
Message-Id: <1350315248-7690-12-git-send-email-mathewm@codeaurora.org>
In-Reply-To: <1350315248-7690-1-git-send-email-mathewm@codeaurora.org>
References: <1350315248-7690-1-git-send-email-mathewm@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

The move confirm response concludes the channel move command sequence.
Receipt of this command indicates that data may begin to flow again.

Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
---
 net/bluetooth/l2cap_core.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 7e31e98..ac9d34a 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -4632,6 +4632,7 @@ static inline int l2cap_move_channel_confirm_rsp(struct l2cap_conn *conn,
 						 u16 cmd_len, void *data)
 {
 	struct l2cap_move_chan_cfm_rsp *rsp = data;
+	struct l2cap_chan *chan;
 	u16 icid;
 
 	if (cmd_len != sizeof(*rsp))
@@ -4641,6 +4642,31 @@ static inline int l2cap_move_channel_confirm_rsp(struct l2cap_conn *conn,
 
 	BT_DBG("icid 0x%4.4x", icid);
 
+	chan = l2cap_get_chan_by_scid(conn, icid);
+	if (!chan)
+		return 0;
+
+	__clear_chan_timer(chan);
+
+	if (chan->move_state == L2CAP_MOVE_WAIT_CONFIRM_RSP) {
+		chan->move_state = L2CAP_MOVE_STABLE;
+		chan->local_amp_id = chan->move_id;
+
+		if (!chan->local_amp_id && chan->hs_hchan) {
+			/* Have moved off of AMP, free the channel */
+			chan->hs_hchan = NULL;
+			chan->hs_hcon = NULL;
+
+			/* Placeholder - free the logical link */
+		}
+
+		l2cap_move_success(chan);
+
+		chan->move_role = L2CAP_MOVE_ROLE_NONE;
+	}
+
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
