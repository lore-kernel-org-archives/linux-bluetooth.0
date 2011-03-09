Return-Path: <cyrus@holtmann.org>
From: Suraj Sumangala <suraj@atheros.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <Jothikumar.Mothilal@Atheros.com>,
	Suraj Sumangala <suraj@atheros.com>
Subject: [PATCH] Bluetooth: Increment unacked_frames count only the first transmit
Date: Wed, 9 Mar 2011 14:44:05 +0530
Message-ID: <1299662045-5214-1-git-send-email-suraj@atheros.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch lets 'l2cap_pinfo.unacked_frames' be incremented only
the first time a frame is transmitted.

Previously it was being incremented for retransmitted packets
too resulting the value to cross the transmit window size.

Signed-off-by: Suraj Sumangala <suraj@atheros.com>
---
 net/bluetooth/l2cap_core.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index c9f9cec..ca27f3a 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1116,7 +1116,9 @@ int l2cap_ertm_send(struct sock *sk)
 		bt_cb(skb)->tx_seq = pi->next_tx_seq;
 		pi->next_tx_seq = (pi->next_tx_seq + 1) % 64;
 
-		pi->unacked_frames++;
+		if (bt_cb(skb)->retries == 1)
+			pi->unacked_frames++;
+
 		pi->frames_sent++;
 
 		if (skb_queue_is_last(TX_QUEUE(sk), skb))
-- 
1.7.0.4

