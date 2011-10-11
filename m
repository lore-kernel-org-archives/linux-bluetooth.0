Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv3 06/16] Bluetooth: EWS: rewrite reqseq calculation
Date: Tue, 11 Oct 2011 13:37:46 +0300
Message-Id: <1318329476-30153-7-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1318329476-30153-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1318329476-30153-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

reqseq calculation uses now information about control field type.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/l2cap.h |   20 +++++++++++++++++-
 net/bluetooth/l2cap_core.c    |   42 ++++++++++++++++++++--------------------
 2 files changed, 39 insertions(+), 23 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 0759ac6..57b64bb 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -365,11 +365,11 @@ struct l2cap_chan {
 	__u8		next_tx_seq;
 	__u8		expected_ack_seq;
 	__u8		expected_tx_seq;
-	__u8		buffer_seq;
 	__u8		buffer_seq_srej;
 	__u8		srej_save_reqseq;
 	__u8		frames_sent;
 	__u8		unacked_frames;
+	__u16		buffer_seq;
 	__u8		retry_count;
 	__u8		num_acked;
 	__u16		sdu_len;
@@ -512,8 +512,24 @@ static inline int l2cap_tx_window_full(struct l2cap_chan *ch)
 	return sub == ch->remote_tx_win;
 }
 
+static inline __u16 __get_reqseq(struct l2cap_chan *chan, __u32 ctrl)
+{
+	if (test_bit(FLAG_EXT_CTRL, &chan->flags))
+		return (ctrl & L2CAP_EXT_CTRL_REQSEQ) >>
+						L2CAP_EXT_CTRL_REQSEQ_SHIFT;
+	else
+		return (ctrl & L2CAP_CTRL_REQSEQ) >> L2CAP_CTRL_REQSEQ_SHIFT;
+}
+
+static inline __u32 __set_reqseq(struct l2cap_chan *chan, __u32 reqseq)
+{
+	if (test_bit(FLAG_EXT_CTRL, &chan->flags))
+		return (reqseq << L2CAP_EXT_CTRL_REQSEQ_SHIFT) &
+							L2CAP_EXT_CTRL_REQSEQ;
+	else
+		return (reqseq << L2CAP_CTRL_REQSEQ_SHIFT) & L2CAP_CTRL_REQSEQ;
+}
 #define __get_txseq(ctrl)	(((ctrl) & L2CAP_CTRL_TXSEQ) >> 1)
-#define __get_reqseq(ctrl)	(((ctrl) & L2CAP_CTRL_REQSEQ) >> 8)
 #define __is_iframe(ctrl)	(!((ctrl) & L2CAP_CTRL_FRAME_TYPE))
 #define __is_sframe(ctrl)	((ctrl) & L2CAP_CTRL_FRAME_TYPE)
 static inline __u8 __get_ctrl_sar(struct l2cap_chan *chan, __u32 ctrl)
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 9ee42ba..f35eb73 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -618,7 +618,7 @@ static inline void l2cap_send_rr_or_rnr(struct l2cap_chan *chan, u16 control)
 	} else
 		control |= __set_ctrl_super(chan, L2CAP_SUPER_RR);
 
-	control |= chan->buffer_seq << L2CAP_CTRL_REQSEQ_SHIFT;
+	control |= __set_reqseq(chan, chan->buffer_seq);
 
 	l2cap_send_sframe(chan, control);
 }
@@ -1316,8 +1316,8 @@ static void l2cap_retransmit_one_frame(struct l2cap_chan *chan, u8 tx_seq)
 	if (test_and_clear_bit(CONN_SEND_FBIT, &chan->conn_state))
 		control |= L2CAP_CTRL_FINAL;
 
-	control |= (chan->buffer_seq << L2CAP_CTRL_REQSEQ_SHIFT)
-			| (tx_seq << L2CAP_CTRL_TXSEQ_SHIFT);
+	control |= __set_reqseq(chan, chan->buffer_seq);
+	control |= tx_seq << L2CAP_CTRL_TXSEQ_SHIFT;
 
 	put_unaligned_le16(control, tx_skb->data + L2CAP_HDR_SIZE);
 
@@ -1356,8 +1356,8 @@ static int l2cap_ertm_send(struct l2cap_chan *chan)
 		if (test_and_clear_bit(CONN_SEND_FBIT, &chan->conn_state))
 			control |= L2CAP_CTRL_FINAL;
 
-		control |= (chan->buffer_seq << L2CAP_CTRL_REQSEQ_SHIFT)
-				| (chan->next_tx_seq << L2CAP_CTRL_TXSEQ_SHIFT);
+		control |= __set_reqseq(chan, chan->buffer_seq);
+		control |= chan->next_tx_seq << L2CAP_CTRL_TXSEQ_SHIFT;
 		put_unaligned_le16(control, tx_skb->data + L2CAP_HDR_SIZE);
 
 
@@ -1405,7 +1405,7 @@ static void l2cap_send_ack(struct l2cap_chan *chan)
 {
 	u16 control = 0;
 
-	control |= chan->buffer_seq << L2CAP_CTRL_REQSEQ_SHIFT;
+	control |= __set_reqseq(chan, chan->buffer_seq);
 
 	if (test_bit(CONN_LOCAL_BUSY, &chan->conn_state)) {
 		control |= __set_ctrl_super(chan, L2CAP_SUPER_RNR);
@@ -1430,7 +1430,7 @@ static void l2cap_send_srejtail(struct l2cap_chan *chan)
 	control |= L2CAP_CTRL_FINAL;
 
 	tail = list_entry((&chan->srej_l)->prev, struct srej_list, list);
-	control |= tail->tx_seq << L2CAP_CTRL_REQSEQ_SHIFT;
+	control |= __set_reqseq(chan, tail->tx_seq);
 
 	l2cap_send_sframe(chan, control);
 }
@@ -3116,7 +3116,7 @@ static inline void l2cap_send_i_or_rr_or_rnr(struct l2cap_chan *chan)
 
 	chan->frames_sent = 0;
 
-	control |= chan->buffer_seq << L2CAP_CTRL_REQSEQ_SHIFT;
+	control |= __set_reqseq(chan, chan->buffer_seq);
 
 	if (test_bit(CONN_LOCAL_BUSY, &chan->conn_state)) {
 		control |= __set_ctrl_super(chan, L2CAP_SUPER_RNR);
@@ -3286,7 +3286,7 @@ static void l2cap_ertm_enter_local_busy(struct l2cap_chan *chan)
 
 	set_bit(CONN_LOCAL_BUSY, &chan->conn_state);
 
-	control = chan->buffer_seq << L2CAP_CTRL_REQSEQ_SHIFT;
+	control = __set_reqseq(chan, chan->buffer_seq);
 	control |= __set_ctrl_super(chan, L2CAP_SUPER_RNR);
 	l2cap_send_sframe(chan, control);
 
@@ -3302,7 +3302,7 @@ static void l2cap_ertm_exit_local_busy(struct l2cap_chan *chan)
 	if (!test_bit(CONN_RNR_SENT, &chan->conn_state))
 		goto done;
 
-	control = chan->buffer_seq << L2CAP_CTRL_REQSEQ_SHIFT;
+	control = __set_reqseq(chan, chan->buffer_seq);
 	control |= L2CAP_CTRL_POLL;
 	control |= __set_ctrl_super(chan, L2CAP_SUPER_RR);
 	l2cap_send_sframe(chan, control);
@@ -3369,7 +3369,7 @@ static void l2cap_resend_srejframe(struct l2cap_chan *chan, u8 tx_seq)
 			return;
 		}
 		control = __set_ctrl_super(chan, L2CAP_SUPER_SREJ);
-		control |= l->tx_seq << L2CAP_CTRL_REQSEQ_SHIFT;
+		control |= __set_reqseq(chan, l->tx_seq);
 		l2cap_send_sframe(chan, control);
 		list_del(&l->list);
 		list_add_tail(&l->list, &chan->srej_l);
@@ -3383,7 +3383,7 @@ static void l2cap_send_srejframe(struct l2cap_chan *chan, u8 tx_seq)
 
 	while (tx_seq != chan->expected_tx_seq) {
 		control = __set_ctrl_super(chan, L2CAP_SUPER_SREJ);
-		control |= chan->expected_tx_seq << L2CAP_CTRL_REQSEQ_SHIFT;
+		control |= __set_reqseq(chan, chan->expected_tx_seq);
 		l2cap_send_sframe(chan, control);
 
 		new = kzalloc(sizeof(struct srej_list), GFP_ATOMIC);
@@ -3397,7 +3397,7 @@ static void l2cap_send_srejframe(struct l2cap_chan *chan, u8 tx_seq)
 static inline int l2cap_data_channel_iframe(struct l2cap_chan *chan, u16 rx_control, struct sk_buff *skb)
 {
 	u8 tx_seq = __get_txseq(rx_control);
-	u8 req_seq = __get_reqseq(rx_control);
+	u16 req_seq = __get_reqseq(chan, rx_control);
 	u8 sar = __get_ctrl_sar(chan, rx_control);
 	int tx_seq_offset, expected_tx_seq_offset;
 	int num_to_ack = (chan->tx_win/6) + 1;
@@ -3531,10 +3531,10 @@ drop:
 
 static inline void l2cap_data_channel_rrframe(struct l2cap_chan *chan, u16 rx_control)
 {
-	BT_DBG("chan %p, req_seq %d ctrl 0x%4.4x", chan, __get_reqseq(rx_control),
-						rx_control);
+	BT_DBG("chan %p, req_seq %d ctrl 0x%4.4x", chan,
+				__get_reqseq(chan, rx_control), rx_control);
 
-	chan->expected_ack_seq = __get_reqseq(rx_control);
+	chan->expected_ack_seq = __get_reqseq(chan, rx_control);
 	l2cap_drop_acked_frames(chan);
 
 	if (rx_control & L2CAP_CTRL_POLL) {
@@ -3571,7 +3571,7 @@ static inline void l2cap_data_channel_rrframe(struct l2cap_chan *chan, u16 rx_co
 
 static inline void l2cap_data_channel_rejframe(struct l2cap_chan *chan, u16 rx_control)
 {
-	u8 tx_seq = __get_reqseq(rx_control);
+	u16 tx_seq = __get_reqseq(chan, rx_control);
 
 	BT_DBG("chan %p, req_seq %d ctrl 0x%4.4x", chan, tx_seq, rx_control);
 
@@ -3592,7 +3592,7 @@ static inline void l2cap_data_channel_rejframe(struct l2cap_chan *chan, u16 rx_c
 }
 static inline void l2cap_data_channel_srejframe(struct l2cap_chan *chan, u16 rx_control)
 {
-	u8 tx_seq = __get_reqseq(rx_control);
+	u16 tx_seq = __get_reqseq(chan, rx_control);
 
 	BT_DBG("chan %p, req_seq %d ctrl 0x%4.4x", chan, tx_seq, rx_control);
 
@@ -3628,7 +3628,7 @@ static inline void l2cap_data_channel_srejframe(struct l2cap_chan *chan, u16 rx_
 
 static inline void l2cap_data_channel_rnrframe(struct l2cap_chan *chan, u16 rx_control)
 {
-	u8 tx_seq = __get_reqseq(rx_control);
+	u16 tx_seq = __get_reqseq(chan, rx_control);
 
 	BT_DBG("chan %p, req_seq %d ctrl 0x%4.4x", chan, tx_seq, rx_control);
 
@@ -3692,7 +3692,7 @@ static int l2cap_ertm_data_rcv(struct sock *sk, struct sk_buff *skb)
 {
 	struct l2cap_chan *chan = l2cap_pi(sk)->chan;
 	u16 control;
-	u8 req_seq;
+	u16 req_seq;
 	int len, next_tx_seq_offset, req_seq_offset;
 
 	control = get_unaligned_le16(skb->data);
@@ -3718,7 +3718,7 @@ static int l2cap_ertm_data_rcv(struct sock *sk, struct sk_buff *skb)
 		goto drop;
 	}
 
-	req_seq = __get_reqseq(control);
+	req_seq = __get_reqseq(chan, control);
 	req_seq_offset = (req_seq - chan->expected_ack_seq) % 64;
 	if (req_seq_offset < 0)
 		req_seq_offset += 64;
-- 
1.7.4.1

