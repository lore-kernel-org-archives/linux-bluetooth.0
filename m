Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix not clearing ack timer when sending an i-frame
Date: Mon,  6 Feb 2012 16:38:53 +0200
Message-Id: <1328539133-26410-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

When sending an i-frame the first time unacked_frames is incremented
which means we are waiting an ack and there is no need to send an ack
since the i-frame itself already serve that purpose.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/l2cap_core.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 09cd860..e969677 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1448,8 +1448,10 @@ static int l2cap_ertm_send(struct l2cap_chan *chan)
 
 		chan->next_tx_seq = __next_seq(chan, chan->next_tx_seq);
 
-		if (bt_cb(skb)->retries == 1)
+		if (bt_cb(skb)->retries == 1) {
 			chan->unacked_frames++;
+			__clear_ack_timer(chan);
+		}
 
 		chan->frames_sent++;
 
-- 
1.7.7.6

