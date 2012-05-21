Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Silent sparse warnings
Date: Mon, 21 May 2012 15:47:46 +0300
Message-Id: <1337604466-3860-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Silence warnings below:

net/bluetooth/l2cap_core.c:1662:24: warning: Using plain integer
as NULL pointer
net/bluetooth/l2cap_core.c:1662:27: warning: Using plain integer
as NULL pointer
net/bluetooth/l2cap_core.c:1683:24: warning: Using plain integer
as NULL pointer
net/bluetooth/l2cap_core.c:1683:27: warning: Using plain integer
as NULL pointer
net/bluetooth/l2cap_core.c:2260:46: warning: Using plain integer
as NULL pointer
net/bluetooth/l2cap_core.c:2574:33: warning: Using plain integer
as NULL pointer
net/bluetooth/l2cap_core.c:2581:33: warning: Using plain integer
as NULL pointer
net/bluetooth/l2cap_core.c:4556:24: warning: Using plain integer
as NULL pointer
net/bluetooth/l2cap_core.c:4556:27: warning: Using plain integer
as NULL pointer

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/l2cap_core.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index cb817a0..83d9fce 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1659,7 +1659,7 @@ static void l2cap_monitor_timeout(struct work_struct *work)
 		return;
 	}
 
-	l2cap_tx(chan, 0, 0, L2CAP_EV_MONITOR_TO);
+	l2cap_tx(chan, NULL, NULL, L2CAP_EV_MONITOR_TO);
 
 	l2cap_chan_unlock(chan);
 	l2cap_chan_put(chan);
@@ -1680,7 +1680,7 @@ static void l2cap_retrans_timeout(struct work_struct *work)
 		return;
 	}
 
-	l2cap_tx(chan, 0, 0, L2CAP_EV_RETRANS_TO);
+	l2cap_tx(chan, NULL, NULL, L2CAP_EV_RETRANS_TO);
 	l2cap_chan_unlock(chan);
 	l2cap_chan_put(chan);
 }
@@ -2257,7 +2257,7 @@ int l2cap_chan_send(struct l2cap_chan *chan, struct msghdr *msg, size_t len,
 			break;
 
 		if (chan->mode == L2CAP_MODE_ERTM)
-			err = l2cap_tx(chan, 0, &seg_queue,
+			err = l2cap_tx(chan, NULL, &seg_queue,
 				       L2CAP_EV_DATA_REQUEST);
 		else
 			err = l2cap_streaming_send(chan, &seg_queue);
@@ -2571,14 +2571,14 @@ static void l2cap_pass_to_tx(struct l2cap_chan *chan,
 			     struct l2cap_ctrl *control)
 {
 	BT_DBG("chan %p, control %p", chan, control);
-	l2cap_tx(chan, control, 0, L2CAP_EV_RECV_REQSEQ_AND_FBIT);
+	l2cap_tx(chan, control, NULL, L2CAP_EV_RECV_REQSEQ_AND_FBIT);
 }
 
 static void l2cap_pass_to_tx_fbit(struct l2cap_chan *chan,
 				  struct l2cap_ctrl *control)
 {
 	BT_DBG("chan %p, control %p", chan, control);
-	l2cap_tx(chan, control, 0, L2CAP_EV_RECV_FBIT);
+	l2cap_tx(chan, control, NULL, L2CAP_EV_RECV_FBIT);
 }
 
 /* Copy frame to all raw sockets on that connection */
@@ -4553,7 +4553,7 @@ void l2cap_chan_busy(struct l2cap_chan *chan, int busy)
 		return;
 
 	event = busy ? L2CAP_EV_LOCAL_BUSY_DETECTED : L2CAP_EV_LOCAL_BUSY_CLEAR;
-	l2cap_tx(chan, 0, 0, event);
+	l2cap_tx(chan, NULL, NULL, event);
 }
 
 static int l2cap_rx_queued_iframes(struct l2cap_chan *chan)
-- 
1.7.9.5

