Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <ulrik.lauren@stericsson.com>, <kanak.gupta@stericsson.com>,
	Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 1/5] Bluetooth: Fix possible NULL pointer derefence in l2cap code
Date: Wed, 16 Nov 2011 09:32:18 +0100
Message-ID: <1321432342-8606-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Due to ERTM reliability L2CAP channel needs to be disconnected if
adding to srej list failed.

Signed-off-by: Szymon Janc <szymon.janc@tieto.com>
---
 net/bluetooth/l2cap_core.c |   20 +++++++++++++++++---
 1 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 1790ce3..276817a 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -3788,7 +3788,7 @@ static void l2cap_resend_srejframe(struct l2cap_chan *chan, u16 tx_seq)
 	}
 }
 
-static void l2cap_send_srejframe(struct l2cap_chan *chan, u16 tx_seq)
+static int l2cap_send_srejframe(struct l2cap_chan *chan, u16 tx_seq)
 {
 	struct srej_list *new;
 	u32 control;
@@ -3799,6 +3799,9 @@ static void l2cap_send_srejframe(struct l2cap_chan *chan, u16 tx_seq)
 		l2cap_send_sframe(chan, control);
 
 		new = kzalloc(sizeof(struct srej_list), GFP_ATOMIC);
+		if (!new)
+			return -ENOMEM;
+
 		new->tx_seq = chan->expected_tx_seq;
 
 		chan->expected_tx_seq = __next_seq(chan, chan->expected_tx_seq);
@@ -3807,6 +3810,8 @@ static void l2cap_send_srejframe(struct l2cap_chan *chan, u16 tx_seq)
 	}
 
 	chan->expected_tx_seq = __next_seq(chan, chan->expected_tx_seq);
+
+	return 0;
 }
 
 static inline int l2cap_data_channel_iframe(struct l2cap_chan *chan, u32 rx_control, struct sk_buff *skb)
@@ -3877,7 +3882,12 @@ static inline int l2cap_data_channel_iframe(struct l2cap_chan *chan, u32 rx_cont
 					return 0;
 				}
 			}
-			l2cap_send_srejframe(chan, tx_seq);
+
+			err = l2cap_send_srejframe(chan, tx_seq);
+			if (err < 0) {
+				l2cap_send_disconn_req(chan->conn, chan, -err);
+				return err;
+			}
 		}
 	} else {
 		expected_tx_seq_offset = __seq_offset(chan,
@@ -3899,7 +3909,11 @@ static inline int l2cap_data_channel_iframe(struct l2cap_chan *chan, u32 rx_cont
 
 		set_bit(CONN_SEND_PBIT, &chan->conn_state);
 
-		l2cap_send_srejframe(chan, tx_seq);
+		err = l2cap_send_srejframe(chan, tx_seq);
+		if (err < 0) {
+			l2cap_send_disconn_req(chan->conn, chan, -err);
+			return err;
+		}
 
 		__clear_ack_timer(chan);
 	}
-- 
on behalf of ST-Ericsson

