Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv3 05/16] Bluetooth: EWS: rewrite handling SAR bits
Date: Tue, 11 Oct 2011 13:37:45 +0300
Message-Id: <1318329476-30153-6-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1318329476-30153-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1318329476-30153-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Segmentation and Reassembly (SAR) occupies different windows in standard and
extended control fields. Convert hardcoded masks to relative ones and use shift
to access SAR bits.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/l2cap.h |   37 ++++++++++++++++++++++++++++++++-----
 net/bluetooth/l2cap_core.c    |   30 +++++++++++++++---------------
 2 files changed, 47 insertions(+), 20 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index f24f5cf..0759ac6 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -146,10 +146,10 @@ struct l2cap_conninfo {
 #define L2CAP_SUPER_SREJ	0x03
 
 /* L2CAP Segmentation and Reassembly */
-#define L2CAP_SDU_UNSEGMENTED       0x0000
-#define L2CAP_SDU_START             0x4000
-#define L2CAP_SDU_END               0x8000
-#define L2CAP_SDU_CONTINUE          0xC000
+#define L2CAP_SAR_UNSEGMENTED	0x00
+#define L2CAP_SAR_START		0x01
+#define L2CAP_SAR_END		0x02
+#define L2CAP_SAR_CONTINUE	0x03
 
 /* L2CAP Command rej. reasons */
 #define L2CAP_REJ_NOT_UNDERSTOOD	0x0000
@@ -516,7 +516,34 @@ static inline int l2cap_tx_window_full(struct l2cap_chan *ch)
 #define __get_reqseq(ctrl)	(((ctrl) & L2CAP_CTRL_REQSEQ) >> 8)
 #define __is_iframe(ctrl)	(!((ctrl) & L2CAP_CTRL_FRAME_TYPE))
 #define __is_sframe(ctrl)	((ctrl) & L2CAP_CTRL_FRAME_TYPE)
-#define __is_sar_start(ctrl)	(((ctrl) & L2CAP_CTRL_SAR) == L2CAP_SDU_START)
+static inline __u8 __get_ctrl_sar(struct l2cap_chan *chan, __u32 ctrl)
+{
+	if (test_bit(FLAG_EXT_CTRL, &chan->flags))
+		return (ctrl & L2CAP_EXT_CTRL_SAR) >> L2CAP_EXT_CTRL_SAR_SHIFT;
+	else
+		return (ctrl & L2CAP_CTRL_SAR) >> L2CAP_CTRL_SAR_SHIFT;
+}
+
+static inline __u32 __set_ctrl_sar(struct l2cap_chan *chan, __u32 sar)
+{
+	if (test_bit(FLAG_EXT_CTRL, &chan->flags))
+		return (sar << L2CAP_EXT_CTRL_SAR_SHIFT) & L2CAP_EXT_CTRL_SAR;
+	else
+		return (sar << L2CAP_CTRL_SAR_SHIFT) & L2CAP_CTRL_SAR;
+}
+
+static inline bool __is_sar_start(struct l2cap_chan *chan, __u32 ctrl)
+{
+	return __get_ctrl_sar(chan, ctrl) == L2CAP_SAR_START;
+}
+
+static inline __u32 __get_sar_mask(struct l2cap_chan *chan)
+{
+	if (test_bit(FLAG_EXT_CTRL, &chan->flags))
+		return L2CAP_EXT_CTRL_SAR;
+	else
+		return L2CAP_CTRL_SAR;
+}
 
 static inline __u8 __get_ctrl_super(struct l2cap_chan *chan, __u32 ctrl)
 {
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 93b5da6..9ee42ba 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1311,7 +1311,7 @@ static void l2cap_retransmit_one_frame(struct l2cap_chan *chan, u8 tx_seq)
 	tx_skb = skb_clone(skb, GFP_ATOMIC);
 	bt_cb(skb)->retries++;
 	control = get_unaligned_le16(tx_skb->data + L2CAP_HDR_SIZE);
-	control &= L2CAP_CTRL_SAR;
+	control &= __get_sar_mask(chan);
 
 	if (test_and_clear_bit(CONN_SEND_FBIT, &chan->conn_state))
 		control |= L2CAP_CTRL_FINAL;
@@ -1351,7 +1351,7 @@ static int l2cap_ertm_send(struct l2cap_chan *chan)
 		bt_cb(skb)->retries++;
 
 		control = get_unaligned_le16(tx_skb->data + L2CAP_HDR_SIZE);
-		control &= L2CAP_CTRL_SAR;
+		control &= __get_sar_mask(chan);
 
 		if (test_and_clear_bit(CONN_SEND_FBIT, &chan->conn_state))
 			control |= L2CAP_CTRL_FINAL;
@@ -1582,7 +1582,7 @@ static int l2cap_sar_segment_sdu(struct l2cap_chan *chan, struct msghdr *msg, si
 	size_t size = 0;
 
 	skb_queue_head_init(&sar_queue);
-	control = L2CAP_SDU_START;
+	control = __set_ctrl_sar(chan, L2CAP_SAR_START);
 	skb = l2cap_create_iframe_pdu(chan, msg, chan->remote_mps, control, len);
 	if (IS_ERR(skb))
 		return PTR_ERR(skb);
@@ -1595,10 +1595,10 @@ static int l2cap_sar_segment_sdu(struct l2cap_chan *chan, struct msghdr *msg, si
 		size_t buflen;
 
 		if (len > chan->remote_mps) {
-			control = L2CAP_SDU_CONTINUE;
+			control = __set_ctrl_sar(chan, L2CAP_SAR_CONTINUE);
 			buflen = chan->remote_mps;
 		} else {
-			control = L2CAP_SDU_END;
+			control = __set_ctrl_sar(chan, L2CAP_SAR_END);
 			buflen = len;
 		}
 
@@ -1654,7 +1654,7 @@ int l2cap_chan_send(struct l2cap_chan *chan, struct msghdr *msg, size_t len)
 	case L2CAP_MODE_STREAMING:
 		/* Entire SDU fits into one PDU */
 		if (len <= chan->remote_mps) {
-			control = L2CAP_SDU_UNSEGMENTED;
+			control = __set_ctrl_sar(chan, L2CAP_SAR_UNSEGMENTED);
 			skb = l2cap_create_iframe_pdu(chan, msg, len, control,
 									0);
 			if (IS_ERR(skb))
@@ -3201,15 +3201,15 @@ static int l2cap_reassemble_sdu(struct l2cap_chan *chan, struct sk_buff *skb, u1
 {
 	int err = -EINVAL;
 
-	switch (control & L2CAP_CTRL_SAR) {
-	case L2CAP_SDU_UNSEGMENTED:
+	switch (__get_ctrl_sar(chan, control)) {
+	case L2CAP_SAR_UNSEGMENTED:
 		if (chan->sdu)
 			break;
 
 		err = chan->ops->recv(chan->data, skb);
 		break;
 
-	case L2CAP_SDU_START:
+	case L2CAP_SAR_START:
 		if (chan->sdu)
 			break;
 
@@ -3231,7 +3231,7 @@ static int l2cap_reassemble_sdu(struct l2cap_chan *chan, struct sk_buff *skb, u1
 		err = 0;
 		break;
 
-	case L2CAP_SDU_CONTINUE:
+	case L2CAP_SAR_CONTINUE:
 		if (!chan->sdu)
 			break;
 
@@ -3245,7 +3245,7 @@ static int l2cap_reassemble_sdu(struct l2cap_chan *chan, struct sk_buff *skb, u1
 		err = 0;
 		break;
 
-	case L2CAP_SDU_END:
+	case L2CAP_SAR_END:
 		if (!chan->sdu)
 			break;
 
@@ -3343,7 +3343,7 @@ static void l2cap_check_srej_gap(struct l2cap_chan *chan, u8 tx_seq)
 			break;
 
 		skb = skb_dequeue(&chan->srej_q);
-		control = bt_cb(skb)->sar << L2CAP_CTRL_SAR_SHIFT;
+		control = __set_ctrl_sar(chan, bt_cb(skb)->sar);
 		err = l2cap_reassemble_sdu(chan, skb, control);
 
 		if (err < 0) {
@@ -3398,7 +3398,7 @@ static inline int l2cap_data_channel_iframe(struct l2cap_chan *chan, u16 rx_cont
 {
 	u8 tx_seq = __get_txseq(rx_control);
 	u8 req_seq = __get_reqseq(rx_control);
-	u8 sar = rx_control >> L2CAP_CTRL_SAR_SHIFT;
+	u8 sar = __get_ctrl_sar(chan, rx_control);
 	int tx_seq_offset, expected_tx_seq_offset;
 	int num_to_ack = (chan->tx_win/6) + 1;
 	int err = 0;
@@ -3707,7 +3707,7 @@ static int l2cap_ertm_data_rcv(struct sock *sk, struct sk_buff *skb)
 	if (l2cap_check_fcs(chan, skb))
 		goto drop;
 
-	if (__is_sar_start(control) && __is_iframe(control))
+	if (__is_sar_start(chan, control) && __is_iframe(control))
 		len -= 2;
 
 	if (chan->fcs == L2CAP_FCS_CRC16)
@@ -3811,7 +3811,7 @@ static inline int l2cap_data_channel(struct l2cap_conn *conn, u16 cid, struct sk
 		if (l2cap_check_fcs(chan, skb))
 			goto drop;
 
-		if (__is_sar_start(control))
+		if (__is_sar_start(chan, control))
 			len -= 2;
 
 		if (chan->fcs == L2CAP_FCS_CRC16)
-- 
1.7.4.1

