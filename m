Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: [PATCH -v2 8/8] Bluetooth: Call ops->teardown() without checking for NULL
Date: Thu, 11 Oct 2012 14:51:51 +0800
Message-Id: <1349938311-25101-8-git-send-email-gustavo@padovan.org>
In-Reply-To: <1349938311-25101-1-git-send-email-gustavo@padovan.org>
References: <1349938311-25101-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

Users that don't implement teardown() should use l2cap_chan_no_teardown()

Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
---
 net/bluetooth/l2cap_core.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 4c83157..c3a2c1c 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -542,8 +542,7 @@ void l2cap_chan_del(struct l2cap_chan *chan, int err)
 			hci_conn_put(conn->hcon);
 	}
 
-	if (chan->ops->teardown)
-		chan->ops->teardown(chan, err);
+	chan->ops->teardown(chan, err);
 
 	if (test_bit(CONF_NOT_COMPLETE, &chan->conf_state))
 		return;
@@ -582,8 +581,7 @@ void l2cap_chan_close(struct l2cap_chan *chan, int reason)
 
 	switch (chan->state) {
 	case BT_LISTEN:
-		if (chan->ops->teardown)
-			chan->ops->teardown(chan, 0);
+		chan->ops->teardown(chan, 0);
 		break;
 
 	case BT_CONNECTED:
@@ -625,8 +623,7 @@ void l2cap_chan_close(struct l2cap_chan *chan, int reason)
 		break;
 
 	default:
-		if (chan->ops->teardown)
-			chan->ops->teardown(chan, 0);
+		chan->ops->teardown(chan, 0);
 		break;
 	}
 }
-- 
1.7.11.4

