Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <kanak.gupta@stericsson.com>, Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v2 2/5] Bluetooth: Set P-bit for SREJ frame only if there are I-frames to ack
Date: Wed, 11 Jan 2012 10:59:46 +0100
Message-ID: <1326275989-32226-3-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1326275989-32226-1-git-send-email-szymon.janc@tieto.com>
References: <1326275989-32226-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

SREJ frame with P-bit set acknowledges I-frames numbered up to
(ReqSeq - 1). With this patch P-bit in SREJ is set only when there are
some I-frames to ack.

This fixes ambiguous situation when lost of I-frame with TxSeq=0 would
result in sending SREJ acking all previous I-frames.
Consider following scenario:
TxWindow=3

HostA: sent I-frame TxSeq=0
HostA: sent I-frame TxSeq=1
HostA: sent I-frame TxSeq=2
HostB: missed I-frame TxSeq=0
HostB: received I-frame TxSeq=1
HostB: sent SREJ ReqSeq=0 Pbit=1
HostA: received SREJ ReqSeq=0 Pbit=1   <- All I-frames acked or not?
...

Signed-off-by: Szymon Janc <szymon.janc@tieto.com>
---
 net/bluetooth/l2cap_core.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 97f8549..308d9d7 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -3927,15 +3927,15 @@ static inline int l2cap_data_channel_iframe(struct l2cap_chan *chan, u32 rx_cont
 		__skb_queue_head_init(&chan->srej_q);
 		l2cap_add_to_srej_queue(chan, skb, tx_seq, sar);
 
-		set_bit(CONN_SEND_PBIT, &chan->conn_state);
+		/* Set P-bit only if there are some I-frames to ack. */
+		if (__clear_ack_timer(chan))
+			set_bit(CONN_SEND_PBIT, &chan->conn_state);
 
 		err = l2cap_send_srejframe(chan, tx_seq);
 		if (err < 0) {
 			l2cap_send_disconn_req(chan->conn, chan, -err);
 			return err;
 		}
-
-		__clear_ack_timer(chan);
 	}
 	return 0;
 
-- 
on behalf of ST-Ericsson

