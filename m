Return-Path: <cyrus@holtmann.org>
From: Mat Martineau <mathewm@codeaurora.org>
To: linux-bluetooth@vger.kernel.org, gustavo@padovan.org,
	Andrei.Emeltchenko.news@gmail.com
Cc: pkrystad@codeaurora.org
Subject: [RFCv0 11/21] Bluetooth: Add move confirm response handling
Date: Wed, 25 Jul 2012 16:51:03 -0700
Message-Id: <1343260274-11953-12-git-send-email-mathewm@codeaurora.org>
In-Reply-To: <1343260274-11953-1-git-send-email-mathewm@codeaurora.org>
References: <1343260274-11953-1-git-send-email-mathewm@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
---
 net/bluetooth/l2cap_core.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 79f9d8e..bc56f09 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -4579,6 +4579,7 @@ static inline int l2cap_move_channel_confirm_rsp(struct l2cap_conn *conn,
 						 u16 cmd_len, void *data)
 {
 	struct l2cap_move_chan_cfm_rsp *rsp = data;
+	struct l2cap_chan *chan;
 	u16 icid;
 
 	if (cmd_len != sizeof(*rsp))
@@ -4588,6 +4589,32 @@ static inline int l2cap_move_channel_confirm_rsp(struct l2cap_conn *conn,
 
 	BT_DBG("icid 0x%4.4x", icid);
 
+	chan = l2cap_get_chan_by_scid(conn, icid);
+
+	if (!chan)
+		return 0;
+
+	__clear_chan_timer(chan);
+
+	if (chan->move_state == L2CAP_MOVE_WAIT_CONFIRM_RSP) {
+		chan->move_state = L2CAP_MOVE_STABLE;
+		chan->chan_id = chan->move_id;
+
+		if (!chan->chan_id && chan->hs_hchan) {
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
1.7.11.2

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
