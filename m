Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <gustavo@las.ic.unicamp.br>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, gustavo@padovan.org
Subject: [PATCH 6/7] Bluetooth: Fix ReqSeq value on sending I-frames
Date: Tue, 29 Sep 2009 01:42:28 -0300
Message-Id: <1254199349-19713-6-git-send-email-gustavo@las.ic.unicamp.br>
In-Reply-To: <1254199349-19713-5-git-send-email-gustavo@las.ic.unicamp.br>
References: <1254199349-19713-1-git-send-email-gustavo@las.ic.unicamp.br>
 <1254199349-19713-2-git-send-email-gustavo@las.ic.unicamp.br>
 <1254199349-19713-3-git-send-email-gustavo@las.ic.unicamp.br>
 <1254199349-19713-4-git-send-email-gustavo@las.ic.unicamp.br>
 <1254199349-19713-5-git-send-email-gustavo@las.ic.unicamp.br>
List-ID: <linux-bluetooth.vger.kernel.org>

ReqSeq shall be set to BufferSeq instead of ExpectedTxSeq. BufferSeq gives
real notion of txWindow at sending side (the side sending that I-frame).
It is incremented only when I-frames are pulled by reassembly function.

Signed-off-by: Gustavo F. Padovan <gustavo@las.ic.unicamp.br>
---
 net/bluetooth/l2cap.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index 10bf0c4..ddf70d6 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -1329,7 +1329,7 @@ static int l2cap_retransmit_frame(struct sock *sk, u8 tx_seq)
 		tx_skb = skb_clone(skb, GFP_ATOMIC);
 		bt_cb(skb)->retries++;
 		control = get_unaligned_le16(tx_skb->data + L2CAP_HDR_SIZE);
-		control |= (pi->expected_tx_seq << L2CAP_CTRL_REQSEQ_SHIFT)
+		control |= (pi->buffer_seq << L2CAP_CTRL_REQSEQ_SHIFT)
 				| (tx_seq << L2CAP_CTRL_TXSEQ_SHIFT);
 		put_unaligned_le16(control, tx_skb->data + L2CAP_HDR_SIZE);
 
@@ -1371,7 +1371,7 @@ static int l2cap_ertm_send(struct sock *sk)
 		bt_cb(skb)->retries++;
 
 		control = get_unaligned_le16(tx_skb->data + L2CAP_HDR_SIZE);
-		control |= (pi->expected_tx_seq << L2CAP_CTRL_REQSEQ_SHIFT)
+		control |= (pi->buffer_seq << L2CAP_CTRL_REQSEQ_SHIFT)
 				| (pi->next_tx_seq << L2CAP_CTRL_TXSEQ_SHIFT);
 		put_unaligned_le16(control, tx_skb->data + L2CAP_HDR_SIZE);
 
-- 
1.6.3.3
