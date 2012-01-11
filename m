Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <kanak.gupta@stericsson.com>, Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v2 4/5] Bluetooth: Don't send RNR immediately when entering local busy
Date: Wed, 11 Jan 2012 10:59:48 +0100
Message-ID: <1326275989-32226-5-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1326275989-32226-1-git-send-email-szymon.janc@tieto.com>
References: <1326275989-32226-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

There is no need to send RNR immediately when entring local busy.
Also upper layer might clear local busy condition before ack timer
expires saving few cycles for sending RNR.

This also prevents sending two RNRs in some cases where sending one
would be enough i.e received N I-frame can trigger local busy
(sending RNR acking up to N-1 I-frame) and later sending ack (RNR
acking up to N I-frame).

This was affecting TC_ERM_BV_07_C and TC_ERM_BV_22_C with some non
default channel parameters (tx window and receiving buffer sizes).

Signed-off-by: Szymon Janc <szymon.janc@tieto.com>
---
 net/bluetooth/l2cap_core.c |   15 +++++----------
 1 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index b9e232e..cd1eb6d 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -3719,19 +3719,11 @@ static int l2cap_reassemble_sdu(struct l2cap_chan *chan, struct sk_buff *skb, u3
 
 static void l2cap_ertm_enter_local_busy(struct l2cap_chan *chan)
 {
-	u32 control;
-
 	BT_DBG("chan %p, Enter local busy", chan);
 
 	set_bit(CONN_LOCAL_BUSY, &chan->conn_state);
 
-	control = __set_reqseq(chan, chan->buffer_seq);
-	control |= __set_ctrl_super(chan, L2CAP_SUPER_RNR);
-	l2cap_send_sframe(chan, control);
-
-	set_bit(CONN_RNR_SENT, &chan->conn_state);
-
-	__clear_ack_timer(chan);
+	__set_ack_timer(chan);
 }
 
 static void l2cap_ertm_exit_local_busy(struct l2cap_chan *chan)
@@ -3871,8 +3863,11 @@ static inline int l2cap_data_channel_iframe(struct l2cap_chan *chan, u32 rx_cont
 		goto drop;
 	}
 
-	if (test_bit(CONN_LOCAL_BUSY, &chan->conn_state))
+	if (test_bit(CONN_LOCAL_BUSY, &chan->conn_state)) {
+		if (!test_bit(CONN_RNR_SENT, &chan->conn_state))
+			l2cap_send_ack(chan);
 		goto drop;
+	}
 
 	if (tx_seq == chan->expected_tx_seq)
 		goto expected;
-- 
on behalf of ST-Ericsson

