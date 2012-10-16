Return-Path: <cyrus@holtmann.org>
From: Mat Martineau <mathewm@codeaurora.org>
To: linux-bluetooth@vger.kernel.org,
	gustavo@padovan.org
Cc: sunnyk@codeaurora.org,
	marcel@holtmann.org
Subject: [PATCHv2 11/19] Bluetooth: Add move confirm response handling
Date: Tue, 16 Oct 2012 16:36:25 -0700
Message-Id: <1350430593-23565-12-git-send-email-mathewm@codeaurora.org>
In-Reply-To: <1350430593-23565-1-git-send-email-mathewm@codeaurora.org>
References: <1350430593-23565-1-git-send-email-mathewm@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

The move confirm response concludes the channel move command sequence.
Receipt of this command indicates that data may begin to flow again.

Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
Acked-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/l2cap_core.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index ddd8c72..2aaa9da 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -4652,6 +4652,7 @@ static inline int l2cap_move_channel_confirm_rsp(struct l2cap_conn *conn,
 						 u16 cmd_len, void *data)
 {
 	struct l2cap_move_chan_cfm_rsp *rsp = data;
+	struct l2cap_chan *chan;
 	u16 icid;
 
 	if (cmd_len != sizeof(*rsp))
@@ -4661,6 +4662,31 @@ static inline int l2cap_move_channel_confirm_rsp(struct l2cap_conn *conn,
 
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
