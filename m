Return-Path: <cyrus@holtmann.org>
From: Mat Martineau <mathewm@codeaurora.org>
To: linux-bluetooth@vger.kernel.org, gustavo@padovan.org
Cc: pkrystad@codeaurora.org
Subject: [PATCHv2 1/2] Bluetooth: Restore locking semantics when looking up L2CAP channels
Date: Fri,  4 May 2012 14:20:30 -0700
Message-Id: <1336166431-4926-2-git-send-email-mathewm@codeaurora.org>
In-Reply-To: <1336166431-4926-1-git-send-email-mathewm@codeaurora.org>
References: <1336166431-4926-1-git-send-email-mathewm@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

As the comment for l2cap_get_chan_by_scid indicated, the function used
to return a locked socket.  The lock for the socket was acquired while
the channel list was also locked.

When locking was moved over to the l2cap_chan structure, the channel
lock was no longer acquired with the channel list still locked.  This
made it possible for the l2cap_chan to be deleted after
conn->chan_lock was released but before l2cap_chan_lock was called.
Making the call to l2cap_chan_lock before releasing conn->chan_lock
makes it impossible for the l2cap_chan to be deleted at the wrong
time.

Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
---
 net/bluetooth/l2cap_core.c |   10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 2f94067..11236ac 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -98,13 +98,15 @@ static struct l2cap_chan *__l2cap_get_chan_by_scid(struct l2cap_conn *conn, u16
 }
 
 /* Find channel with given SCID.
- * Returns locked socket */
+ * Returns locked channel. */
 static struct l2cap_chan *l2cap_get_chan_by_scid(struct l2cap_conn *conn, u16 cid)
 {
 	struct l2cap_chan *c;
 
 	mutex_lock(&conn->chan_lock);
 	c = __l2cap_get_chan_by_scid(conn, cid);
+	if (c)
+		l2cap_chan_lock(c);
 	mutex_unlock(&conn->chan_lock);
 
 	return c;
@@ -2860,8 +2862,6 @@ static inline int l2cap_config_req(struct l2cap_conn *conn, struct l2cap_cmd_hdr
 	if (!chan)
 		return -ENOENT;
 
-	l2cap_chan_lock(chan);
-
 	if (chan->state != BT_CONFIG && chan->state != BT_CONNECT2) {
 		struct l2cap_cmd_rej_cid rej;
 
@@ -2971,8 +2971,6 @@ static inline int l2cap_config_rsp(struct l2cap_conn *conn, struct l2cap_cmd_hdr
 	if (!chan)
 		return 0;
 
-	l2cap_chan_lock(chan);
-
 	switch (result) {
 	case L2CAP_CONF_SUCCESS:
 		l2cap_conf_rfc_get(chan, rsp->data, len);
@@ -4296,8 +4294,6 @@ static inline int l2cap_data_channel(struct l2cap_conn *conn, u16 cid, struct sk
 		return 0;
 	}
 
-	l2cap_chan_lock(chan);
-
 	BT_DBG("chan %p, len %d", chan, skb->len);
 
 	if (chan->state != BT_CONNECTED)
-- 
1.7.10

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
