Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH] Bluetooth: Improve data packing in SAR mode
Date: Wed, 13 Aug 2014 16:01:41 +0200
Message-Id: <1407938501-25659-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

There is no need to decrease pdu size with L2CAP SDU lenght in Start
L2CAP SDU frame. Start packtet is just 2 bytes longer as specified and
we can keep payload as long as possible.

Signed-off-by: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
---
When testing SAR L2CAP against PTS, L2CAP channel is usually
configured in that way, that SDU = MPS * 3. PTS expets then 3
I-Frames from IUT: Start, Continuation and End frame.

Without this fix, we sent 4 I-Frames. We could pass a test
by using -b option in l2test and send just two bytes less than
SDU length but it was hakish :) With this patch no need to use -b
option.

 net/bluetooth/l2cap_core.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 7b0d744..8fe9f4b 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -2276,7 +2276,6 @@ static int l2cap_segment_sdu(struct l2cap_chan *chan,
 	} else {
 		sar = L2CAP_SAR_START;
 		sdu_len = len;
-		pdu_len -= L2CAP_SDULEN_SIZE;
 	}
 
 	while (len > 0) {
@@ -2291,10 +2290,8 @@ static int l2cap_segment_sdu(struct l2cap_chan *chan,
 		__skb_queue_tail(seg_queue, skb);
 
 		len -= pdu_len;
-		if (sdu_len) {
+		if (sdu_len)
 			sdu_len = 0;
-			pdu_len += L2CAP_SDULEN_SIZE;
-		}
 
 		if (len <= pdu_len) {
 			sar = L2CAP_SAR_END;
-- 
1.8.4

