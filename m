Return-Path: <cyrus@holtmann.org>
From: Mat Martineau <mathewm@codeaurora.org>
To: linux-bluetooth@vger.kernel.org, gustavo@padovan.org
Cc: sunnyk@codeaurora.org, marcel@holtmann.org,
	andrei.emeltchenko.news@gmail.com
Subject: [PATCHv3 04/18] Bluetooth: Lookup channel structure based on DCID
Date: Thu, 18 Oct 2012 10:58:36 -0700
Message-Id: <1350583130-3241-5-git-send-email-mathewm@codeaurora.org>
In-Reply-To: <1350583130-3241-1-git-send-email-mathewm@codeaurora.org>
References: <1350583130-3241-1-git-send-email-mathewm@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Processing a move channel request involves getting the channel
structure using the destination channel ID.  Previous code could only
look up using the source channel ID.

Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
Acked-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/l2cap_core.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index ec2b4d9..e826420 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -100,6 +100,22 @@ static struct l2cap_chan *l2cap_get_chan_by_scid(struct l2cap_conn *conn,
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
 static struct l2cap_chan *__l2cap_get_chan_by_ident(struct l2cap_conn *conn,
 						    u8 ident)
 {
-- 
1.7.12.3

--
Mat Martineau

Employee of Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
