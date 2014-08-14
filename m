Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v2] Bluetooth: Fix ERTM L2CAP resend packet
Date: Thu, 14 Aug 2014 09:35:34 +0200
Message-Id: <1408001734-23910-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I-Frame which is going to be resend already has FCS field added and set
(if it was required). Adding additional FCS field calculated from data +
old FCS in resend function is incorrect.

This patch fix that.

Issue has been found during PTS testing.

Signed-off-by: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
---
 net/bluetooth/l2cap_core.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index ebe7454..43e2d74 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1968,10 +1968,12 @@ static void l2cap_ertm_resend(struct l2cap_chan *chan)
 					   tx_skb->data + L2CAP_HDR_SIZE);
 		}
 
+		/* Update FCS */
 		if (chan->fcs == L2CAP_FCS_CRC16) {
-			u16 fcs = crc16(0, (u8 *) tx_skb->data, tx_skb->len);
-			put_unaligned_le16(fcs, skb_put(tx_skb,
-							L2CAP_FCS_SIZE));
+			u16 fcs = crc16(0, (u8 *)tx_skb->data, tx_skb->len -
+					L2CAP_FCS_SIZE);
+			put_unaligned_le16(fcs, skb_tail_pointer(tx_skb) -
+					   L2CAP_FCS_SIZE);
 		}
 
 		l2cap_do_send(chan, tx_skb);
-- 
1.8.4

