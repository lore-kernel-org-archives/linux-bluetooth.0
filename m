Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 12/31] Bluetooth: Fix L2CAP channel closing for LE connections
Date: Wed,  4 Dec 2013 16:11:08 +0200
Message-Id: <1386166287-13693-13-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1386166287-13693-1-git-send-email-johan.hedberg@gmail.com>
References: <1386166287-13693-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Sending of the L2CAP Disconnect request should also be performed for LE
based channels. The proper thing to do is therefore to look at whether
there's a PSM specified for the channel instead of looking at the link
type.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/l2cap_core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 891995f845f6..333031fde67e 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -674,8 +674,10 @@ void l2cap_chan_close(struct l2cap_chan *chan, int reason)
 
 	case BT_CONNECTED:
 	case BT_CONFIG:
-		if (chan->chan_type == L2CAP_CHAN_CONN_ORIENTED &&
-		    conn->hcon->type == ACL_LINK) {
+		/* ATT uses L2CAP_CHAN_CONN_ORIENTED so we must also
+		 * check for chan->psm.
+		 */
+		if (chan->chan_type == L2CAP_CHAN_CONN_ORIENTED && chan->psm) {
 			__set_chan_timer(chan, chan->ops->get_sndtimeo(chan));
 			l2cap_send_disconn_req(chan, reason);
 		} else
-- 
1.8.4.2

