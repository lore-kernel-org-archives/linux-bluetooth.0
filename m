Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv5 1/4] Bluetooth: EWS: handling different Control fields
Date: Mon, 17 Oct 2011 12:19:56 +0300
Message-Id: <1318843199-18232-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1318843199-18232-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1318843199-18232-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

There are three different Control Field formats: the Standard Control
Field, the Enhanced Control Field, and the Extended Control Field.
Patch adds function to handle all those fields seamlessly.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/l2cap.h |   28 ++++++++++++
 net/bluetooth/l2cap_core.c    |   95 ++++++++++++++++++++++-------------------
 2 files changed, 79 insertions(+), 44 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 806b950..8324cac 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -27,6 +27,8 @@
 #ifndef __L2CAP_H
 #define __L2CAP_H
 
+#include <asm/unaligned.h>
+
 /* L2CAP defaults */
 #define L2CAP_DEFAULT_MTU		672
 #define L2CAP_DEFAULT_MIN_MTU		48
@@ -649,6 +651,32 @@ static inline bool __is_ctrl_poll(struct l2cap_chan *chan, __u32 ctrl)
 	else
 		return ctrl & L2CAP_CTRL_POLL;
 }
+
+static inline __u32 __get_control(struct l2cap_chan *chan, void *p)
+{
+	if (test_bit(FLAG_EXT_CTRL, &chan->flags))
+		return get_unaligned_le32(p);
+	else
+		return get_unaligned_le16(p);
+}
+
+static inline void __put_control(struct l2cap_chan *chan, __u32 control,
+								void *p)
+{
+	if (test_bit(FLAG_EXT_CTRL, &chan->flags))
+		return put_unaligned_le32(control, p);
+	else
+		return put_unaligned_le16(control, p);
+}
+
+static inline __u8 __ctrl_size(struct l2cap_chan *chan)
+{
+	if (test_bit(FLAG_EXT_CTRL, &chan->flags))
+		return L2CAP_EXT_HDR_SIZE - L2CAP_HDR_SIZE;
+	else
+		return L2CAP_ENH_HDR_SIZE - L2CAP_HDR_SIZE;
+}
+
 extern int disable_ertm;
 
 int l2cap_init_sockets(void);
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 439e715..520d30f 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -561,7 +561,7 @@ static void l2cap_send_cmd(struct l2cap_conn *conn, u8 ident, u8 code, u16 len,
 	hci_send_acl(conn->hcon, skb, flags);
 }
 
-static inline void l2cap_send_sframe(struct l2cap_chan *chan, u16 control)
+static inline void l2cap_send_sframe(struct l2cap_chan *chan, u32 control)
 {
 	struct sk_buff *skb;
 	struct l2cap_hdr *lh;
@@ -580,7 +580,7 @@ static inline void l2cap_send_sframe(struct l2cap_chan *chan, u16 control)
 	if (chan->fcs == L2CAP_FCS_CRC16)
 		hlen += 2;
 
-	BT_DBG("chan %p, control 0x%2.2x", chan, control);
+	BT_DBG("chan %p, control 0x%8.8x", chan, control);
 
 	count = min_t(unsigned int, conn->mtu, hlen);
 
@@ -599,7 +599,8 @@ static inline void l2cap_send_sframe(struct l2cap_chan *chan, u16 control)
 	lh = (struct l2cap_hdr *) skb_put(skb, L2CAP_HDR_SIZE);
 	lh->len = cpu_to_le16(hlen - L2CAP_HDR_SIZE);
 	lh->cid = cpu_to_le16(chan->dcid);
-	put_unaligned_le16(control, skb_put(skb, 2));
+
+	__put_control(chan, control, skb_put(skb, __ctrl_size(chan)));
 
 	if (chan->fcs == L2CAP_FCS_CRC16) {
 		u16 fcs = crc16(0, (u8 *)lh, count - 2);
@@ -616,7 +617,7 @@ static inline void l2cap_send_sframe(struct l2cap_chan *chan, u16 control)
 	hci_send_acl(chan->conn->hcon, skb, flags);
 }
 
-static inline void l2cap_send_rr_or_rnr(struct l2cap_chan *chan, u16 control)
+static inline void l2cap_send_rr_or_rnr(struct l2cap_chan *chan, u32 control)
 {
 	if (test_bit(CONN_LOCAL_BUSY, &chan->conn_state)) {
 		control |= __set_ctrl_super(chan, L2CAP_SUPER_RNR);
@@ -1272,12 +1273,13 @@ static void l2cap_do_send(struct l2cap_chan *chan, struct sk_buff *skb)
 static void l2cap_streaming_send(struct l2cap_chan *chan)
 {
 	struct sk_buff *skb;
-	u16 control, fcs;
+	u32 control;
+	u16 fcs;
 
 	while ((skb = skb_dequeue(&chan->tx_q))) {
-		control = get_unaligned_le16(skb->data + L2CAP_HDR_SIZE);
+		control = __get_control(chan, skb->data + L2CAP_HDR_SIZE);
 		control |= __set_txseq(chan, chan->next_tx_seq);
-		put_unaligned_le16(control, skb->data + L2CAP_HDR_SIZE);
+		__put_control(chan, control, skb->data + L2CAP_HDR_SIZE);
 
 		if (chan->fcs == L2CAP_FCS_CRC16) {
 			fcs = crc16(0, (u8 *)skb->data, skb->len - 2);
@@ -1293,7 +1295,8 @@ static void l2cap_streaming_send(struct l2cap_chan *chan)
 static void l2cap_retransmit_one_frame(struct l2cap_chan *chan, u16 tx_seq)
 {
 	struct sk_buff *skb, *tx_skb;
-	u16 control, fcs;
+	u16 fcs;
+	u32 control;
 
 	skb = skb_peek(&chan->tx_q);
 	if (!skb)
@@ -1316,7 +1319,8 @@ static void l2cap_retransmit_one_frame(struct l2cap_chan *chan, u16 tx_seq)
 
 	tx_skb = skb_clone(skb, GFP_ATOMIC);
 	bt_cb(skb)->retries++;
-	control = get_unaligned_le16(tx_skb->data + L2CAP_HDR_SIZE);
+
+	control = __get_control(chan, tx_skb->data + L2CAP_HDR_SIZE);
 	control &= __get_sar_mask(chan);
 
 	if (test_and_clear_bit(CONN_SEND_FBIT, &chan->conn_state))
@@ -1325,7 +1329,7 @@ static void l2cap_retransmit_one_frame(struct l2cap_chan *chan, u16 tx_seq)
 	control |= __set_reqseq(chan, chan->buffer_seq);
 	control |= __set_txseq(chan, tx_seq);
 
-	put_unaligned_le16(control, tx_skb->data + L2CAP_HDR_SIZE);
+	__put_control(chan, control, tx_skb->data + L2CAP_HDR_SIZE);
 
 	if (chan->fcs == L2CAP_FCS_CRC16) {
 		fcs = crc16(0, (u8 *)tx_skb->data, tx_skb->len - 2);
@@ -1338,7 +1342,8 @@ static void l2cap_retransmit_one_frame(struct l2cap_chan *chan, u16 tx_seq)
 static int l2cap_ertm_send(struct l2cap_chan *chan)
 {
 	struct sk_buff *skb, *tx_skb;
-	u16 control, fcs;
+	u16 fcs;
+	u32 control;
 	int nsent = 0;
 
 	if (chan->state != BT_CONNECTED)
@@ -1356,7 +1361,7 @@ static int l2cap_ertm_send(struct l2cap_chan *chan)
 
 		bt_cb(skb)->retries++;
 
-		control = get_unaligned_le16(tx_skb->data + L2CAP_HDR_SIZE);
+		control = __get_control(chan, tx_skb->data + L2CAP_HDR_SIZE);
 		control &= __get_sar_mask(chan);
 
 		if (test_and_clear_bit(CONN_SEND_FBIT, &chan->conn_state))
@@ -1364,8 +1369,8 @@ static int l2cap_ertm_send(struct l2cap_chan *chan)
 
 		control |= __set_reqseq(chan, chan->buffer_seq);
 		control |= __set_txseq(chan, chan->next_tx_seq);
-		put_unaligned_le16(control, tx_skb->data + L2CAP_HDR_SIZE);
 
+		__put_control(chan, control, tx_skb->data + L2CAP_HDR_SIZE);
 
 		if (chan->fcs == L2CAP_FCS_CRC16) {
 			fcs = crc16(0, (u8 *)skb->data, tx_skb->len - 2);
@@ -1409,7 +1414,7 @@ static int l2cap_retransmit_frames(struct l2cap_chan *chan)
 
 static void l2cap_send_ack(struct l2cap_chan *chan)
 {
-	u16 control = 0;
+	u32 control = 0;
 
 	control |= __set_reqseq(chan, chan->buffer_seq);
 
@@ -1430,7 +1435,7 @@ static void l2cap_send_ack(struct l2cap_chan *chan)
 static void l2cap_send_srejtail(struct l2cap_chan *chan)
 {
 	struct srej_list *tail;
-	u16 control;
+	u32 control;
 
 	control = __set_ctrl_super(chan, L2CAP_SUPER_SREJ);
 	control |= __set_ctrl_final(chan);
@@ -1534,7 +1539,7 @@ static struct sk_buff *l2cap_create_basic_pdu(struct l2cap_chan *chan, struct ms
 
 static struct sk_buff *l2cap_create_iframe_pdu(struct l2cap_chan *chan,
 						struct msghdr *msg, size_t len,
-						u16 control, u16 sdulen)
+						u32 control, u16 sdulen)
 {
 	struct sock *sk = chan->sk;
 	struct l2cap_conn *conn = chan->conn;
@@ -1568,7 +1573,9 @@ static struct sk_buff *l2cap_create_iframe_pdu(struct l2cap_chan *chan,
 	lh = (struct l2cap_hdr *) skb_put(skb, L2CAP_HDR_SIZE);
 	lh->cid = cpu_to_le16(chan->dcid);
 	lh->len = cpu_to_le16(len + (hlen - L2CAP_HDR_SIZE));
-	put_unaligned_le16(control, skb_put(skb, 2));
+
+	__put_control(chan, control, skb_put(skb, __ctrl_size(chan)));
+
 	if (sdulen)
 		put_unaligned_le16(sdulen, skb_put(skb, 2));
 
@@ -1589,7 +1596,7 @@ static int l2cap_sar_segment_sdu(struct l2cap_chan *chan, struct msghdr *msg, si
 {
 	struct sk_buff *skb;
 	struct sk_buff_head sar_queue;
-	u16 control;
+	u32 control;
 	size_t size = 0;
 
 	skb_queue_head_init(&sar_queue);
@@ -1633,7 +1640,7 @@ static int l2cap_sar_segment_sdu(struct l2cap_chan *chan, struct msghdr *msg, si
 int l2cap_chan_send(struct l2cap_chan *chan, struct msghdr *msg, size_t len)
 {
 	struct sk_buff *skb;
-	u16 control;
+	u32 control;
 	int err;
 
 	/* Connectionless channel */
@@ -3128,7 +3135,7 @@ static int l2cap_check_fcs(struct l2cap_chan *chan,  struct sk_buff *skb)
 
 static inline void l2cap_send_i_or_rr_or_rnr(struct l2cap_chan *chan)
 {
-	u16 control = 0;
+	u32 control = 0;
 
 	chan->frames_sent = 0;
 
@@ -3213,7 +3220,7 @@ static void append_skb_frag(struct sk_buff *skb,
 	skb->truesize += new_frag->truesize;
 }
 
-static int l2cap_reassemble_sdu(struct l2cap_chan *chan, struct sk_buff *skb, u16 control)
+static int l2cap_reassemble_sdu(struct l2cap_chan *chan, struct sk_buff *skb, u32 control)
 {
 	int err = -EINVAL;
 
@@ -3296,7 +3303,7 @@ static int l2cap_reassemble_sdu(struct l2cap_chan *chan, struct sk_buff *skb, u1
 
 static void l2cap_ertm_enter_local_busy(struct l2cap_chan *chan)
 {
-	u16 control;
+	u32 control;
 
 	BT_DBG("chan %p, Enter local busy", chan);
 
@@ -3313,7 +3320,7 @@ static void l2cap_ertm_enter_local_busy(struct l2cap_chan *chan)
 
 static void l2cap_ertm_exit_local_busy(struct l2cap_chan *chan)
 {
-	u16 control;
+	u32 control;
 
 	if (!test_bit(CONN_RNR_SENT, &chan->conn_state))
 		goto done;
@@ -3349,7 +3356,7 @@ void l2cap_chan_busy(struct l2cap_chan *chan, int busy)
 static void l2cap_check_srej_gap(struct l2cap_chan *chan, u16 tx_seq)
 {
 	struct sk_buff *skb;
-	u16 control;
+	u32 control;
 
 	while ((skb = skb_peek(&chan->srej_q)) &&
 			!test_bit(CONN_LOCAL_BUSY, &chan->conn_state)) {
@@ -3376,7 +3383,7 @@ static void l2cap_check_srej_gap(struct l2cap_chan *chan, u16 tx_seq)
 static void l2cap_resend_srejframe(struct l2cap_chan *chan, u16 tx_seq)
 {
 	struct srej_list *l, *tmp;
-	u16 control;
+	u32 control;
 
 	list_for_each_entry_safe(l, tmp, &chan->srej_l, list) {
 		if (l->tx_seq == tx_seq) {
@@ -3395,7 +3402,7 @@ static void l2cap_resend_srejframe(struct l2cap_chan *chan, u16 tx_seq)
 static void l2cap_send_srejframe(struct l2cap_chan *chan, u16 tx_seq)
 {
 	struct srej_list *new;
-	u16 control;
+	u32 control;
 
 	while (tx_seq != chan->expected_tx_seq) {
 		control = __set_ctrl_super(chan, L2CAP_SUPER_SREJ);
@@ -3410,7 +3417,7 @@ static void l2cap_send_srejframe(struct l2cap_chan *chan, u16 tx_seq)
 	chan->expected_tx_seq = (chan->expected_tx_seq + 1) % 64;
 }
 
-static inline int l2cap_data_channel_iframe(struct l2cap_chan *chan, u16 rx_control, struct sk_buff *skb)
+static inline int l2cap_data_channel_iframe(struct l2cap_chan *chan, u32 rx_control, struct sk_buff *skb)
 {
 	u16 tx_seq = __get_txseq(chan, rx_control);
 	u16 req_seq = __get_reqseq(chan, rx_control);
@@ -3419,7 +3426,7 @@ static inline int l2cap_data_channel_iframe(struct l2cap_chan *chan, u16 rx_cont
 	int num_to_ack = (chan->tx_win/6) + 1;
 	int err = 0;
 
-	BT_DBG("chan %p len %d tx_seq %d rx_control 0x%4.4x", chan, skb->len,
+	BT_DBG("chan %p len %d tx_seq %d rx_control 0x%8.8x", chan, skb->len,
 							tx_seq, rx_control);
 
 	if (__is_ctrl_final(chan, rx_control) &&
@@ -3545,9 +3552,9 @@ drop:
 	return 0;
 }
 
-static inline void l2cap_data_channel_rrframe(struct l2cap_chan *chan, u16 rx_control)
+static inline void l2cap_data_channel_rrframe(struct l2cap_chan *chan, u32 rx_control)
 {
-	BT_DBG("chan %p, req_seq %d ctrl 0x%4.4x", chan,
+	BT_DBG("chan %p, req_seq %d ctrl 0x%8.8x", chan,
 				__get_reqseq(chan, rx_control), rx_control);
 
 	chan->expected_ack_seq = __get_reqseq(chan, rx_control);
@@ -3585,11 +3592,11 @@ static inline void l2cap_data_channel_rrframe(struct l2cap_chan *chan, u16 rx_co
 	}
 }
 
-static inline void l2cap_data_channel_rejframe(struct l2cap_chan *chan, u16 rx_control)
+static inline void l2cap_data_channel_rejframe(struct l2cap_chan *chan, u32 rx_control)
 {
 	u16 tx_seq = __get_reqseq(chan, rx_control);
 
-	BT_DBG("chan %p, req_seq %d ctrl 0x%4.4x", chan, tx_seq, rx_control);
+	BT_DBG("chan %p, req_seq %d ctrl 0x%8.8x", chan, tx_seq, rx_control);
 
 	clear_bit(CONN_REMOTE_BUSY, &chan->conn_state);
 
@@ -3606,11 +3613,11 @@ static inline void l2cap_data_channel_rejframe(struct l2cap_chan *chan, u16 rx_c
 			set_bit(CONN_REJ_ACT, &chan->conn_state);
 	}
 }
-static inline void l2cap_data_channel_srejframe(struct l2cap_chan *chan, u16 rx_control)
+static inline void l2cap_data_channel_srejframe(struct l2cap_chan *chan, u32 rx_control)
 {
 	u16 tx_seq = __get_reqseq(chan, rx_control);
 
-	BT_DBG("chan %p, req_seq %d ctrl 0x%4.4x", chan, tx_seq, rx_control);
+	BT_DBG("chan %p, req_seq %d ctrl 0x%8.8x", chan, tx_seq, rx_control);
 
 	clear_bit(CONN_REMOTE_BUSY, &chan->conn_state);
 
@@ -3642,11 +3649,11 @@ static inline void l2cap_data_channel_srejframe(struct l2cap_chan *chan, u16 rx_
 	}
 }
 
-static inline void l2cap_data_channel_rnrframe(struct l2cap_chan *chan, u16 rx_control)
+static inline void l2cap_data_channel_rnrframe(struct l2cap_chan *chan, u32 rx_control)
 {
 	u16 tx_seq = __get_reqseq(chan, rx_control);
 
-	BT_DBG("chan %p, req_seq %d ctrl 0x%4.4x", chan, tx_seq, rx_control);
+	BT_DBG("chan %p, req_seq %d ctrl 0x%8.8x", chan, tx_seq, rx_control);
 
 	set_bit(CONN_REMOTE_BUSY, &chan->conn_state);
 	chan->expected_ack_seq = tx_seq;
@@ -3670,9 +3677,9 @@ static inline void l2cap_data_channel_rnrframe(struct l2cap_chan *chan, u16 rx_c
 	}
 }
 
-static inline int l2cap_data_channel_sframe(struct l2cap_chan *chan, u16 rx_control, struct sk_buff *skb)
+static inline int l2cap_data_channel_sframe(struct l2cap_chan *chan, u32 rx_control, struct sk_buff *skb)
 {
-	BT_DBG("chan %p rx_control 0x%4.4x len %d", chan, rx_control, skb->len);
+	BT_DBG("chan %p rx_control 0x%8.8x len %d", chan, rx_control, skb->len);
 
 	if (__is_ctrl_final(chan, rx_control) &&
 			test_bit(CONN_WAIT_F, &chan->conn_state)) {
@@ -3707,12 +3714,12 @@ static inline int l2cap_data_channel_sframe(struct l2cap_chan *chan, u16 rx_cont
 static int l2cap_ertm_data_rcv(struct sock *sk, struct sk_buff *skb)
 {
 	struct l2cap_chan *chan = l2cap_pi(sk)->chan;
-	u16 control;
+	u32 control;
 	u16 req_seq;
 	int len, next_tx_seq_offset, req_seq_offset;
 
-	control = get_unaligned_le16(skb->data);
-	skb_pull(skb, 2);
+	control = __get_control(chan, skb->data);
+	skb_pull(skb, __ctrl_size(chan));
 	len = skb->len;
 
 	/*
@@ -3778,7 +3785,7 @@ static inline int l2cap_data_channel(struct l2cap_conn *conn, u16 cid, struct sk
 {
 	struct l2cap_chan *chan;
 	struct sock *sk = NULL;
-	u16 control;
+	u32 control;
 	u16 tx_seq;
 	int len;
 
@@ -3820,8 +3827,8 @@ static inline int l2cap_data_channel(struct l2cap_conn *conn, u16 cid, struct sk
 		goto done;
 
 	case L2CAP_MODE_STREAMING:
-		control = get_unaligned_le16(skb->data);
-		skb_pull(skb, 2);
+		control = __get_control(chan, skb->data);
+		skb_pull(skb, __ctrl_size(chan));
 		len = skb->len;
 
 		if (l2cap_check_fcs(chan, skb))
-- 
1.7.4.1

