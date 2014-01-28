Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/4] Bluetooth: Free up l2cap_chan->sport when initiating a connection
Date: Tue, 28 Jan 2014 15:16:48 -0800
Message-Id: <1390951011-30576-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The sport variable is used to track the allocation of the local PSM
database to ensure no two sockets take the same local PSM. It is
acquired upon bind() but needs to be freed up if the socket ends up
becoming a client one. This patch adds the clearing of the value when
l2cap_chan_connect is called.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/l2cap_core.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index d2ef49b54aa2..f583988a4653 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -7126,6 +7126,13 @@ int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid,
 	l2cap_state_change(chan, BT_CONNECT);
 	__set_chan_timer(chan, chan->ops->get_sndtimeo(chan));
 
+	/* Release chan->sport so that it can be reused by other
+	 * sockets (as it's only used for listening sockets).
+	 */
+	write_lock(&chan_list_lock);
+	chan->sport = 0;
+	write_unlock(&chan_list_lock);
+
 	if (hcon->state == BT_CONNECTED) {
 		if (chan->chan_type != L2CAP_CHAN_CONN_ORIENTED) {
 			__clear_chan_timer(chan);
-- 
1.8.5.3

