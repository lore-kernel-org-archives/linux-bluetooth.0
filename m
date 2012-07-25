Return-Path: <cyrus@holtmann.org>
From: Mat Martineau <mathewm@codeaurora.org>
To: linux-bluetooth@vger.kernel.org, gustavo@padovan.org,
	Andrei.Emeltchenko.news@gmail.com
Cc: pkrystad@codeaurora.org
Subject: [RFCv0 05/21] Bluetooth: Lookup channel id for channel move
Date: Wed, 25 Jul 2012 16:50:57 -0700
Message-Id: <1343260274-11953-6-git-send-email-mathewm@codeaurora.org>
In-Reply-To: <1343260274-11953-1-git-send-email-mathewm@codeaurora.org>
References: <1343260274-11953-1-git-send-email-mathewm@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
---
 net/bluetooth/l2cap_core.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index d7a501e..176a81d 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -97,6 +97,21 @@ static struct l2cap_chan *l2cap_get_chan_by_scid(struct l2cap_conn *conn, u16 ci
 	return c;
 }
 
+/* Find channel with given DCID.
+ * Returns locked channel. */
+static struct l2cap_chan *l2cap_get_chan_by_dcid(struct l2cap_conn *conn, u16 cid)
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
@@ -4086,6 +4101,7 @@ static inline int l2cap_move_channel_req(struct l2cap_conn *conn,
 					 u16 cmd_len, void *data)
 {
 	struct l2cap_move_chan_req *req = data;
+	struct l2cap_chan *chan;
 	u16 icid = 0;
 	u16 result = L2CAP_MR_NOT_ALLOWED;
 
@@ -4099,9 +4115,14 @@ static inline int l2cap_move_channel_req(struct l2cap_conn *conn,
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
1.7.11.2

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
