Return-Path: <cyrus@holtmann.org>
From: Mat Martineau <mathewm@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: padovan@profusion.mobi, Mat Martineau <mathewm@codeaurora.org>
Subject: [PATCH 1/6] Bluetooth: Check earlier for L2CAP ERTM frames to drop
Date: Wed, 29 Jun 2011 14:35:19 -0700
Message-Id: <1309383324-12002-2-git-send-email-mathewm@codeaurora.org>
In-Reply-To: <1309383324-12002-1-git-send-email-mathewm@codeaurora.org>
References: <1309383324-12002-1-git-send-email-mathewm@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Even when the received tx_seq is expected, the frame still needs to be
dropped if the TX window is exceeded or the receiver is in the local
busy state.

Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
---
 net/bluetooth/l2cap_core.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 9ec9c8c..74de2b7 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -3522,9 +3522,6 @@ static inline int l2cap_data_channel_iframe(struct l2cap_chan *chan, u16 rx_cont
 	chan->expected_ack_seq = req_seq;
 	l2cap_drop_acked_frames(chan);
 
-	if (tx_seq == chan->expected_tx_seq)
-		goto expected;
-
 	tx_seq_offset = (tx_seq - chan->buffer_seq) % 64;
 	if (tx_seq_offset < 0)
 		tx_seq_offset += 64;
@@ -3538,6 +3535,9 @@ static inline int l2cap_data_channel_iframe(struct l2cap_chan *chan, u16 rx_cont
 	if (test_bit(CONN_LOCAL_BUSY, &chan->conn_state))
 		goto drop;
 
+	if (tx_seq == chan->expected_tx_seq)
+		goto expected;
+
 	if (test_bit(CONN_SREJ_SENT, &chan->conn_state)) {
 		struct srej_list *first;
 
-- 
1.7.5.4

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum

