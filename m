Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv3 10/16] Bluetooth: EWS: rewrite handling POLL (P) bit
Date: Tue, 11 Oct 2011 13:37:50 +0300
Message-Id: <1318329476-30153-11-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1318329476-30153-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1318329476-30153-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Handle POLL (P) bit in L2CAP ERTM using information about control field type.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/l2cap.h |   16 ++++++++++++++++
 net/bluetooth/l2cap_core.c    |   14 +++++++-------
 2 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 3110c43..67a2fdb 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -627,6 +627,22 @@ static inline bool __is_ctrl_final(struct l2cap_chan *chan, __u32 ctrl)
 	else
 		return ctrl & L2CAP_CTRL_FINAL;
 }
+
+static inline __u32 __set_ctrl_poll(struct l2cap_chan *chan)
+{
+	if (test_bit(FLAG_EXT_CTRL, &chan->flags))
+		return L2CAP_EXT_CTRL_POLL;
+	else
+		return L2CAP_CTRL_POLL;
+}
+
+static inline bool __is_ctrl_poll(struct l2cap_chan *chan, __u32 ctrl)
+{
+	if (test_bit(FLAG_EXT_CTRL, &chan->flags))
+		return ctrl & L2CAP_EXT_CTRL_POLL;
+	else
+		return ctrl & L2CAP_CTRL_POLL;
+}
 extern int disable_ertm;
 
 int l2cap_init_sockets(void);
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index c500d1c..97aa545 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -585,7 +585,7 @@ static inline void l2cap_send_sframe(struct l2cap_chan *chan, u16 control)
 		control |= __set_ctrl_final(chan);
 
 	if (test_and_clear_bit(CONN_SEND_PBIT, &chan->conn_state))
-		control |= L2CAP_CTRL_POLL;
+		control |= __set_ctrl_poll(chan);
 
 	skb = bt_skb_alloc(count, GFP_ATOMIC);
 	if (!skb)
@@ -3304,7 +3304,7 @@ static void l2cap_ertm_exit_local_busy(struct l2cap_chan *chan)
 		goto done;
 
 	control = __set_reqseq(chan, chan->buffer_seq);
-	control |= L2CAP_CTRL_POLL;
+	control |= __set_ctrl_poll(chan);
 	control |= __set_ctrl_super(chan, L2CAP_SUPER_RR);
 	l2cap_send_sframe(chan, control);
 	chan->retry_count = 1;
@@ -3538,7 +3538,7 @@ static inline void l2cap_data_channel_rrframe(struct l2cap_chan *chan, u16 rx_co
 	chan->expected_ack_seq = __get_reqseq(chan, rx_control);
 	l2cap_drop_acked_frames(chan);
 
-	if (rx_control & L2CAP_CTRL_POLL) {
+	if (__is_ctrl_poll(chan, rx_control)) {
 		set_bit(CONN_SEND_FBIT, &chan->conn_state);
 		if (test_bit(CONN_SREJ_SENT, &chan->conn_state)) {
 			if (test_bit(CONN_REMOTE_BUSY, &chan->conn_state) &&
@@ -3599,7 +3599,7 @@ static inline void l2cap_data_channel_srejframe(struct l2cap_chan *chan, u16 rx_
 
 	clear_bit(CONN_REMOTE_BUSY, &chan->conn_state);
 
-	if (rx_control & L2CAP_CTRL_POLL) {
+	if (__is_ctrl_poll(chan, rx_control)) {
 		chan->expected_ack_seq = tx_seq;
 		l2cap_drop_acked_frames(chan);
 
@@ -3637,17 +3637,17 @@ static inline void l2cap_data_channel_rnrframe(struct l2cap_chan *chan, u16 rx_c
 	chan->expected_ack_seq = tx_seq;
 	l2cap_drop_acked_frames(chan);
 
-	if (rx_control & L2CAP_CTRL_POLL)
+	if (__is_ctrl_poll(chan, rx_control))
 		set_bit(CONN_SEND_FBIT, &chan->conn_state);
 
 	if (!test_bit(CONN_SREJ_SENT, &chan->conn_state)) {
 		__clear_retrans_timer(chan);
-		if (rx_control & L2CAP_CTRL_POLL)
+		if (__is_ctrl_poll(chan, rx_control))
 			l2cap_send_rr_or_rnr(chan, L2CAP_CTRL_FINAL);
 		return;
 	}
 
-	if (rx_control & L2CAP_CTRL_POLL) {
+	if (__is_ctrl_poll(chan, rx_control)) {
 		l2cap_send_srejtail(chan);
 	} else {
 		rx_control = __set_ctrl_super(chan, L2CAP_SUPER_RR);
-- 
1.7.4.1

