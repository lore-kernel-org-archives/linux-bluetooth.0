Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Remove unnecessary check for chan->psm
Date: Tue, 28 Jan 2014 15:28:04 -0800
Message-Id: <1390951684-3225-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Now that ATT sockets have been converted to use the new L2CAP_CHAN_FIXED
type there is no need to have an extra check for chan->psm in the
l2cap_chan_close function.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/l2cap_core.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index f583988a4653..66fbac91eaed 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -666,10 +666,7 @@ void l2cap_chan_close(struct l2cap_chan *chan, int reason)
 
 	case BT_CONNECTED:
 	case BT_CONFIG:
-		/* ATT uses L2CAP_CHAN_CONN_ORIENTED so we must also
-		 * check for chan->psm.
-		 */
-		if (chan->chan_type == L2CAP_CHAN_CONN_ORIENTED && chan->psm) {
+		if (chan->chan_type == L2CAP_CHAN_CONN_ORIENTED) {
 			__set_chan_timer(chan, chan->ops->get_sndtimeo(chan));
 			l2cap_send_disconn_req(chan, reason);
 		} else
-- 
1.8.5.3

