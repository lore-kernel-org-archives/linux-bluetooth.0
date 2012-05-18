Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: [PATCH -v2] Bluetooth: Do not purge queue in Basic Mode
Date: Fri, 18 May 2012 20:22:38 -0300
Message-Id: <1337383358-19279-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

chan->tx_q is only initialized if we use ERTM or Streaming mode.

Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
---
 net/bluetooth/l2cap_core.c |   14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index b70dca4..ae69da8 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -549,9 +549,11 @@ static void l2cap_chan_del(struct l2cap_chan *chan, int err)
 	if (test_bit(CONF_NOT_COMPLETE, &chan->conf_state))
 		return;
 
-	skb_queue_purge(&chan->tx_q);
+	switch(chan->mode) {
+	case L2CAP_MODE_BASIC:
+		break;
 
-	if (chan->mode == L2CAP_MODE_ERTM) {
+	case L2CAP_MODE_ERTM:
 		__clear_retrans_timer(chan);
 		__clear_monitor_timer(chan);
 		__clear_ack_timer(chan);
@@ -560,7 +562,15 @@ static void l2cap_chan_del(struct l2cap_chan *chan, int err)
 
 		l2cap_seq_list_free(&chan->srej_list);
 		l2cap_seq_list_free(&chan->retrans_list);
+
+		/* fall through */
+
+	case L2CAP_MODE_STREAMING:
+		skb_queue_purge(&chan->tx_q);
+		break;
 	}
+
+	return;
 }
 
 static void l2cap_chan_cleanup_listen(struct sock *parent)
-- 
1.7.10.1

