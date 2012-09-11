Return-Path: <cyrus@holtmann.org>
From: Mat Martineau <mathewm@codeaurora.org>
To: linux-bluetooth@vger.kernel.org, gustavo@padovan.org
Cc: sunnyk@codeaurora.org
Subject: [RFCv1 05/20] Bluetooth: Lookup channel structure based on DCID
Date: Tue, 11 Sep 2012 11:21:16 -0700
Message-Id: <1347387691-5285-6-git-send-email-mathewm@codeaurora.org>
In-Reply-To: <1347387691-5285-1-git-send-email-mathewm@codeaurora.org>
References: <1347387691-5285-1-git-send-email-mathewm@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Processing a move channel request involves getting the channel
structure using the destination channel ID.  Previous code could only
look up using the source channel ID.

Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
---
 net/bluetooth/l2cap_core.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index a042bcf..cc62f70 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -97,6 +97,22 @@ static struct l2cap_chan *l2cap_get_chan_by_scid(struct l2cap_conn *conn, u16 ci
 	return c;
 }
 
+/* Find channel with given DCID.
+ * Returns locked channel. */
+static struct l2cap_chan *l2cap_get_chan_by_dcid(struct l2cap_conn *conn,
+						 u16 cid)
+{
+	struct l2cap_chan *c;
+
+	mutex_lock(&conn->chan_lock);
+	c = __l2cap_get_chan_by_dcid(conn, cid);
+	if (c)
+		l2cap_chan_lock(c);
+	mutex_unlock(&conn->chan_lock);
+
+	return c;
+}
+
 static struct l2cap_chan *__l2cap_get_chan_by_ident(struct l2cap_conn *conn, u8 ident)
 {
 	struct l2cap_chan *c;
@@ -4088,6 +4104,7 @@ static inline int l2cap_move_channel_req(struct l2cap_conn *conn,
 					 u16 cmd_len, void *data)
 {
 	struct l2cap_move_chan_req *req = data;
+	struct l2cap_chan *chan;
 	u16 icid = 0;
 	u16 result = L2CAP_MR_NOT_ALLOWED;
 
@@ -4101,9 +4118,14 @@ static inline int l2cap_move_channel_req(struct l2cap_conn *conn,
 	if (!enable_hs)
 		return -EINVAL;
 
+	chan = l2cap_get_chan_by_dcid(conn, icid);
+
 	/* Placeholder: Always refuse */
 	l2cap_send_move_chan_rsp(conn, cmd->ident, icid, result);
 
+	if (chan)
+		l2cap_chan_unlock(chan);
+
 	return 0;
 }
 
-- 
1.7.12

--
Mat Martineau

The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
