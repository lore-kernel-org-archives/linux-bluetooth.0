Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: [PATCH 3/5] Bluetooth: Do not check if teardown exists
Date: Mon, 28 May 2012 18:16:21 -0300
Message-Id: <1338239783-26599-3-git-send-email-gustavo@padovan.org>
In-Reply-To: <1338239783-26599-1-git-send-email-gustavo@padovan.org>
References: <1338239783-26599-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

If a user don't want to use teardown op a l2cap_chan_no_teardown should be
created

Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
---
 net/bluetooth/l2cap_core.c |    9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 4a4367f..102cd1e 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -509,8 +509,7 @@ static void l2cap_chan_del(struct l2cap_chan *chan, int err)
 		hci_conn_put(conn->hcon);
 	}
 
-	if (chan->ops->teardown)
-		chan->ops->teardown(chan, err);
+	chan->ops->teardown(chan, err);
 
 	if (test_bit(CONF_NOT_COMPLETE, &chan->conf_state))
 		return;
@@ -549,8 +548,7 @@ void l2cap_chan_close(struct l2cap_chan *chan, int reason)
 
 	switch (chan->state) {
 	case BT_LISTEN:
-		if (chan->ops->teardown)
-			chan->ops->teardown(chan, 0);
+		chan->ops->teardown(chan, 0);
 		break;
 
 	case BT_CONNECTED:
@@ -592,8 +590,7 @@ void l2cap_chan_close(struct l2cap_chan *chan, int reason)
 		break;
 
 	default:
-		if (chan->ops->teardown)
-			chan->ops->teardown(chan, 0);
+		chan->ops->teardown(chan, 0);
 		break;
 	}
 }
-- 
1.7.10.2

