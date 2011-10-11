Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv3 07/16] Bluetooth: EWS: rewrite L2CAP ERTM txseq calculation
Date: Tue, 11 Oct 2011 13:37:47 +0300
Message-Id: <1318329476-30153-8-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1318329476-30153-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1318329476-30153-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

L2CAP ERTM txseq calculation uses now information about control field type.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/l2cap.h |   36 +++++++++++++++++++++++++++---------
 net/bluetooth/l2cap_core.c    |   22 +++++++++++-----------
 2 files changed, 38 insertions(+), 20 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 57b64bb..3ca24af 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -316,7 +316,7 @@ struct l2cap_conn_param_update_rsp {
 
 /* ----- L2CAP channels and connections ----- */
 struct srej_list {
-	__u8	tx_seq;
+	__u16	tx_seq;
 	struct list_head list;
 };
 
@@ -362,14 +362,14 @@ struct l2cap_chan {
 	unsigned long	conn_state;
 	unsigned long	flags;
 
-	__u8		next_tx_seq;
-	__u8		expected_ack_seq;
-	__u8		expected_tx_seq;
-	__u8		buffer_seq_srej;
-	__u8		srej_save_reqseq;
-	__u8		frames_sent;
-	__u8		unacked_frames;
+	__u16		next_tx_seq;
+	__u16		expected_ack_seq;
+	__u16		expected_tx_seq;
 	__u16		buffer_seq;
+	__u16		buffer_seq_srej;
+	__u16		srej_save_reqseq;
+	__u16		frames_sent;
+	__u16		unacked_frames;
 	__u8		retry_count;
 	__u8		num_acked;
 	__u16		sdu_len;
@@ -529,7 +529,25 @@ static inline __u32 __set_reqseq(struct l2cap_chan *chan, __u32 reqseq)
 	else
 		return (reqseq << L2CAP_CTRL_REQSEQ_SHIFT) & L2CAP_CTRL_REQSEQ;
 }
-#define __get_txseq(ctrl)	(((ctrl) & L2CAP_CTRL_TXSEQ) >> 1)
+
+static inline __u16 __get_txseq(struct l2cap_chan *chan, __u32 ctrl)
+{
+	if (test_bit(FLAG_EXT_CTRL, &chan->flags))
+		return (ctrl & L2CAP_EXT_CTRL_TXSEQ) >>
+						L2CAP_EXT_CTRL_TXSEQ_SHIFT;
+	else
+		return (ctrl & L2CAP_CTRL_TXSEQ) >> L2CAP_CTRL_TXSEQ_SHIFT;
+}
+
+static inline __u32 __set_txseq(struct l2cap_chan *chan, __u32 txseq)
+{
+	if (test_bit(FLAG_EXT_CTRL, &chan->flags))
+		return (txseq << L2CAP_EXT_CTRL_TXSEQ_SHIFT) &
+							L2CAP_EXT_CTRL_TXSEQ;
+	else
+		return (txseq << L2CAP_CTRL_TXSEQ_SHIFT) & L2CAP_CTRL_TXSEQ;
+}
+
 #define __is_iframe(ctrl)	(!((ctrl) & L2CAP_CTRL_FRAME_TYPE))
 #define __is_sframe(ctrl)	((ctrl) & L2CAP_CTRL_FRAME_TYPE)
 static inline __u8 __get_ctrl_sar(struct l2cap_chan *chan, __u32 ctrl)
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index f35eb73..1c367d6 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1270,7 +1270,7 @@ static void l2cap_streaming_send(struct l2cap_chan *chan)
 
 	while ((skb = skb_dequeue(&chan->tx_q))) {
 		control = get_unaligned_le16(skb->data + L2CAP_HDR_SIZE);
-		control |= chan->next_tx_seq << L2CAP_CTRL_TXSEQ_SHIFT;
+		control |= __set_txseq(chan, chan->next_tx_seq);
 		put_unaligned_le16(control, skb->data + L2CAP_HDR_SIZE);
 
 		if (chan->fcs == L2CAP_FCS_CRC16) {
@@ -1284,7 +1284,7 @@ static void l2cap_streaming_send(struct l2cap_chan *chan)
 	}
 }
 
-static void l2cap_retransmit_one_frame(struct l2cap_chan *chan, u8 tx_seq)
+static void l2cap_retransmit_one_frame(struct l2cap_chan *chan, u16 tx_seq)
 {
 	struct sk_buff *skb, *tx_skb;
 	u16 control, fcs;
@@ -1317,7 +1317,7 @@ static void l2cap_retransmit_one_frame(struct l2cap_chan *chan, u8 tx_seq)
 		control |= L2CAP_CTRL_FINAL;
 
 	control |= __set_reqseq(chan, chan->buffer_seq);
-	control |= tx_seq << L2CAP_CTRL_TXSEQ_SHIFT;
+	control |= __set_txseq(chan, tx_seq);
 
 	put_unaligned_le16(control, tx_skb->data + L2CAP_HDR_SIZE);
 
@@ -1357,7 +1357,7 @@ static int l2cap_ertm_send(struct l2cap_chan *chan)
 			control |= L2CAP_CTRL_FINAL;
 
 		control |= __set_reqseq(chan, chan->buffer_seq);
-		control |= chan->next_tx_seq << L2CAP_CTRL_TXSEQ_SHIFT;
+		control |= __set_txseq(chan, chan->next_tx_seq);
 		put_unaligned_le16(control, tx_skb->data + L2CAP_HDR_SIZE);
 
 
@@ -3136,7 +3136,7 @@ static inline void l2cap_send_i_or_rr_or_rnr(struct l2cap_chan *chan)
 	}
 }
 
-static int l2cap_add_to_srej_queue(struct l2cap_chan *chan, struct sk_buff *skb, u8 tx_seq, u8 sar)
+static int l2cap_add_to_srej_queue(struct l2cap_chan *chan, struct sk_buff *skb, u16 tx_seq, u8 sar)
 {
 	struct sk_buff *next_skb;
 	int tx_seq_offset, next_tx_seq_offset;
@@ -3330,7 +3330,7 @@ void l2cap_chan_busy(struct l2cap_chan *chan, int busy)
 	}
 }
 
-static void l2cap_check_srej_gap(struct l2cap_chan *chan, u8 tx_seq)
+static void l2cap_check_srej_gap(struct l2cap_chan *chan, u16 tx_seq)
 {
 	struct sk_buff *skb;
 	u16 control;
@@ -3357,7 +3357,7 @@ static void l2cap_check_srej_gap(struct l2cap_chan *chan, u8 tx_seq)
 	}
 }
 
-static void l2cap_resend_srejframe(struct l2cap_chan *chan, u8 tx_seq)
+static void l2cap_resend_srejframe(struct l2cap_chan *chan, u16 tx_seq)
 {
 	struct srej_list *l, *tmp;
 	u16 control;
@@ -3376,7 +3376,7 @@ static void l2cap_resend_srejframe(struct l2cap_chan *chan, u8 tx_seq)
 	}
 }
 
-static void l2cap_send_srejframe(struct l2cap_chan *chan, u8 tx_seq)
+static void l2cap_send_srejframe(struct l2cap_chan *chan, u16 tx_seq)
 {
 	struct srej_list *new;
 	u16 control;
@@ -3396,7 +3396,7 @@ static void l2cap_send_srejframe(struct l2cap_chan *chan, u8 tx_seq)
 
 static inline int l2cap_data_channel_iframe(struct l2cap_chan *chan, u16 rx_control, struct sk_buff *skb)
 {
-	u8 tx_seq = __get_txseq(rx_control);
+	u16 tx_seq = __get_txseq(chan, rx_control);
 	u16 req_seq = __get_reqseq(chan, rx_control);
 	u8 sar = __get_ctrl_sar(chan, rx_control);
 	int tx_seq_offset, expected_tx_seq_offset;
@@ -3763,7 +3763,7 @@ static inline int l2cap_data_channel(struct l2cap_conn *conn, u16 cid, struct sk
 	struct l2cap_chan *chan;
 	struct sock *sk = NULL;
 	u16 control;
-	u8 tx_seq;
+	u16 tx_seq;
 	int len;
 
 	chan = l2cap_get_chan_by_scid(conn, cid);
@@ -3820,7 +3820,7 @@ static inline int l2cap_data_channel(struct l2cap_conn *conn, u16 cid, struct sk
 		if (len > chan->mps || len < 0 || __is_sframe(control))
 			goto drop;
 
-		tx_seq = __get_txseq(control);
+		tx_seq = __get_txseq(chan, control);
 
 		if (chan->expected_tx_seq != tx_seq) {
 			/* Frame(s) missing - must discard partial SDU */
-- 
1.7.4.1

