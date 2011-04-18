Return-Path: <cyrus@holtmann.org>
From: Ruiyi Zhang <Ruiyi.zhang@atheros.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Ruiyi Zhang <Ruiyi.zhang@atheros.com>
Subject: [PATCH] Bluetooth: Only keeping SAR bits when retransmitting one frame.
Date: Mon, 18 Apr 2011 11:04:30 +0800
Message-ID: <1303095870-8744-1-git-send-email-Ruiyi.zhang@atheros.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When retrasmitting one frame, only SAR bits in control field should
be kept.

Signed-off-by: Ruiyi Zhang <Ruiyi.zhang@atheros.com>
---
 net/bluetooth/l2cap_core.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index ca27f3a..2c8dd44 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1051,6 +1051,7 @@ static void l2cap_retransmit_one_frame(struct sock *sk, u8 tx_seq)
 	tx_skb = skb_clone(skb, GFP_ATOMIC);
 	bt_cb(skb)->retries++;
 	control = get_unaligned_le16(tx_skb->data + L2CAP_HDR_SIZE);
+	control &= L2CAP_CTRL_SAR;
 
 	if (pi->conn_state & L2CAP_CONN_SEND_FBIT) {
 		control |= L2CAP_CTRL_FINAL;
-- 
1.7.1

