Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv0 2/5] Bluetooth: l2cap extended control field support
Date: Tue, 30 Aug 2011 10:18:38 +0300
Message-Id: <1314688721-16742-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1314688721-16742-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1314688721-16742-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Adds support for parsing extended control field. Extended control
field may be used for ERTM and streaming mode (if EWS specified).
u32 control is used for standard, enhanced and extended control
fields. Flag in l2cap chan specifies which format is in use.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/l2cap.h |  276 ++++++++++++++++++++++++++++++++------
 net/bluetooth/l2cap_core.c    |  299 +++++++++++++++++++++++------------------
 2 files changed, 405 insertions(+), 170 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index b586a55..e2906c8 100644
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
@@ -113,36 +115,52 @@ struct l2cap_conninfo {
 #define L2CAP_FCS_CRC16		0x01
 
 /* L2CAP Control Field bit masks */
-#define L2CAP_CTRL_SAR               0xC000
-#define L2CAP_CTRL_REQSEQ            0x3F00
-#define L2CAP_CTRL_TXSEQ             0x007E
-#define L2CAP_CTRL_RETRANS           0x0080
-#define L2CAP_CTRL_FINAL             0x0080
-#define L2CAP_CTRL_POLL              0x0010
-#define L2CAP_CTRL_SUPERVISE         0x000C
-#define L2CAP_CTRL_FRAME_TYPE        0x0001 /* I- or S-Frame */
-
-#define L2CAP_CTRL_TXSEQ_SHIFT      1
-#define L2CAP_CTRL_REQSEQ_SHIFT     8
-#define L2CAP_CTRL_SAR_SHIFT       14
+#define L2CAP_CTRL_SAR_MASK		0xC000
+#define L2CAP_CTRL_REQSEQ_MASK		0x3F00
+#define L2CAP_CTRL_TXSEQ_MASK		0x007E
+#define L2CAP_CTRL_SUPERVISE_MASK	0x000C
+
+#define L2CAP_CTRL_RETRANS		0x0080
+#define L2CAP_CTRL_FINAL		0x0080
+#define L2CAP_CTRL_POLL			0x0010
+#define L2CAP_CTRL_FRAME_TYPE		0x0001 /* I- or S-Frame */
+
+#define L2CAP_CTRL_TXSEQ_SHIFT		1
+#define L2CAP_CTRL_SUPER_SHIFT		2
+#define L2CAP_CTRL_REQSEQ_SHIFT		8
+#define L2CAP_CTRL_SAR_SHIFT		14
+
+/* L2CAP Extended Control Field bit mask */
+#define L2CAP_EXT_CTRL_TXSEQ_MASK	0xFFFC0000
+#define L2CAP_EXT_CTRL_SAR_MASK		0x00030000
+#define L2CAP_EXT_CTRL_SUPERVISE_MASK	0x00030000
+#define L2CAP_EXT_CTRL_REQSEQ_MASK	0x0000FFFC
+
+#define L2CAP_EXT_CTRL_POLL		0x00040000
+#define L2CAP_EXT_CTRL_FINAL		0x00000002
+#define L2CAP_EXT_CTRL_FRAME_TYPE	0x00000001 /* I- or S-Frame */
+
+#define L2CAP_EXT_CTRL_REQSEQ_SHIFT	2
+#define L2CAP_EXT_CTRL_SAR_SHIFT	16
+#define L2CAP_EXT_CTRL_SUPER_SHIFT	16
+#define L2CAP_EXT_CTRL_TXSEQ_SHIFT	18
 
 /* L2CAP Supervisory Function */
-#define L2CAP_SUPER_RCV_READY           0x0000
-#define L2CAP_SUPER_REJECT              0x0004
-#define L2CAP_SUPER_RCV_NOT_READY       0x0008
-#define L2CAP_SUPER_SELECT_REJECT       0x000C
+#define L2CAP_SUPER_RR		0x00
+#define L2CAP_SUPER_REJ		0x01
+#define L2CAP_SUPER_RNR		0x02
+#define L2CAP_SUPER_SREJ	0x03
 
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
-#define L2CAP_REJ_NOT_UNDERSTOOD      0x0000
-#define L2CAP_REJ_MTU_EXCEEDED        0x0001
-#define L2CAP_REJ_INVALID_CID         0x0002
-
+#define L2CAP_REJ_NOT_UNDERSTOOD	0x0000
+#define L2CAP_REJ_MTU_EXCEEDED		0x0001
+#define L2CAP_REJ_INVALID_CID		0x0002
 
 /* L2CAP structures */
 struct l2cap_hdr {
@@ -150,6 +168,11 @@ struct l2cap_hdr {
 	__le16     cid;
 } __packed;
 #define L2CAP_HDR_SIZE		4
+#define L2CAP_ENHANCED_HDR_SIZE	6
+#define L2CAP_EXTENDED_HDR_SIZE	8
+
+#define L2CAP_FCS_SIZE		2
+#define L2CAP_SDULEN_SIZE	2
 
 struct l2cap_cmd_hdr {
 	__u8       code;
@@ -320,7 +343,7 @@ struct l2cap_conn_param_update_rsp {
 
 /* ----- L2CAP channels and connections ----- */
 struct srej_list {
-	__u8	tx_seq;
+	__u16	tx_seq;
 	struct list_head list;
 };
 
@@ -369,16 +392,16 @@ struct l2cap_chan {
 	unsigned long	conf_state;
 	unsigned long	conn_state;
 
-	__u8		next_tx_seq;
-	__u8		expected_ack_seq;
-	__u8		expected_tx_seq;
-	__u8		buffer_seq;
-	__u8		buffer_seq_srej;
-	__u8		srej_save_reqseq;
-	__u8		frames_sent;
-	__u8		unacked_frames;
+	__u16		next_tx_seq;
+	__u16		expected_ack_seq;
+	__u16		expected_tx_seq;
+	__u16		buffer_seq;
+	__u16		buffer_seq_srej;
+	__u16		srej_save_reqseq;
+	__u16		frames_sent;
+	__u16		unacked_frames;
 	__u8		retry_count;
-	__u8		num_acked;
+	__u16		num_acked;
 	__u16		sdu_len;
 	struct sk_buff	*sdu;
 	struct sk_buff	*sdu_last_frag;
@@ -537,11 +560,186 @@ static inline int l2cap_tx_window_full(struct l2cap_chan *ch)
 	return sub == ch->remote_tx_win;
 }
 
-#define __get_txseq(ctrl)	(((ctrl) & L2CAP_CTRL_TXSEQ) >> 1)
-#define __get_reqseq(ctrl)	(((ctrl) & L2CAP_CTRL_REQSEQ) >> 8)
-#define __is_iframe(ctrl)	(!((ctrl) & L2CAP_CTRL_FRAME_TYPE))
-#define __is_sframe(ctrl)	((ctrl) & L2CAP_CTRL_FRAME_TYPE)
-#define __is_sar_start(ctrl)	(((ctrl) & L2CAP_CTRL_SAR) == L2CAP_SDU_START)
+static inline __u16 __get_reqseq(__u8 ext_ctrl, __u32 ctrl)
+{
+	if (ext_ctrl)
+		return (ctrl & L2CAP_EXT_CTRL_REQSEQ_MASK) >>
+			L2CAP_EXT_CTRL_REQSEQ_SHIFT;
+	else
+		return (ctrl & L2CAP_CTRL_REQSEQ_MASK) >>
+			L2CAP_CTRL_REQSEQ_SHIFT;
+}
+
+static inline __u32 __set_reqseq(__u8 ext_ctrl, __u32 reqseq)
+{
+	if (ext_ctrl)
+		return (reqseq << L2CAP_EXT_CTRL_REQSEQ_SHIFT) &
+			L2CAP_EXT_CTRL_REQSEQ_MASK;
+	else
+		return (reqseq << L2CAP_CTRL_REQSEQ_SHIFT) &
+			L2CAP_CTRL_REQSEQ_MASK;
+}
+
+static inline __u16 __get_txseq(__u8 ext_ctrl, __u32 ctrl)
+{
+	if (ext_ctrl)
+		return (ctrl & L2CAP_EXT_CTRL_TXSEQ_MASK) >>
+			L2CAP_EXT_CTRL_TXSEQ_SHIFT;
+	else
+		return (ctrl & L2CAP_CTRL_TXSEQ_MASK) >>
+			L2CAP_CTRL_TXSEQ_SHIFT;
+}
+
+static inline __u32 __set_txseq(__u8 ext_ctrl, __u32 txseq)
+{
+	if (ext_ctrl)
+		return (txseq << L2CAP_EXT_CTRL_TXSEQ_SHIFT) &
+			L2CAP_EXT_CTRL_TXSEQ_MASK;
+	else
+		return (txseq << L2CAP_CTRL_TXSEQ_SHIFT) &
+			L2CAP_CTRL_TXSEQ_MASK;
+}
+
+static inline bool __is_sframe(__u8 ext_ctrl, __u32 ctrl)
+{
+	if (ext_ctrl)
+		return ctrl & L2CAP_EXT_CTRL_FRAME_TYPE;
+	else
+		return ctrl & L2CAP_CTRL_FRAME_TYPE;
+}
+
+static inline __u32 __set_sframe(__u8 ext_ctrl)
+{
+	if (ext_ctrl)
+		return L2CAP_EXT_CTRL_FRAME_TYPE;
+	else
+		return L2CAP_CTRL_FRAME_TYPE;
+}
+
+static inline __u8 __get_ctrl_sar(__u8 ext_ctrl, __u32 ctrl)
+{
+	if (ext_ctrl)
+		return (ctrl & L2CAP_EXT_CTRL_SAR_MASK) >>
+			L2CAP_EXT_CTRL_SAR_SHIFT;
+	else
+		return (ctrl & L2CAP_CTRL_SAR_MASK) >>
+			L2CAP_CTRL_SAR_SHIFT;
+}
+
+static inline __u32 __set_ctrl_sar(__u8 ext_ctrl, __u32 sar)
+{
+	if (ext_ctrl)
+		return (sar << L2CAP_EXT_CTRL_SAR_SHIFT) &
+			L2CAP_EXT_CTRL_SAR_MASK;
+	else
+		return (sar << L2CAP_CTRL_SAR_SHIFT) &
+			L2CAP_CTRL_SAR_MASK;
+}
+
+static inline bool __is_sar_start(__u8 ext_ctrl, __u32 ctrl)
+{
+	return __get_ctrl_sar(ext_ctrl, ctrl) == L2CAP_SAR_START;
+}
+
+static inline __u32 __get_sar_mask(__u8 ext_ctrl)
+{
+	if (ext_ctrl)
+		return L2CAP_EXT_CTRL_SAR_MASK;
+	else
+		return L2CAP_CTRL_SAR_MASK;
+}
+
+static inline __u8 __get_ctrl_super(__u8 ext_ctrl, __u32 ctrl)
+{
+	if (ext_ctrl)
+		return (ctrl & L2CAP_EXT_CTRL_SUPERVISE_MASK) >>
+			L2CAP_EXT_CTRL_SUPER_SHIFT;
+	else
+		return (ctrl & L2CAP_CTRL_SUPERVISE_MASK) >>
+			L2CAP_CTRL_SUPER_SHIFT;
+}
+
+static inline __u32 __set_ctrl_super(__u8 ext_ctrl, __u32 super)
+{
+	if (ext_ctrl)
+		return (super << L2CAP_EXT_CTRL_SUPER_SHIFT) &
+			L2CAP_EXT_CTRL_SUPERVISE_MASK;
+	else
+		return (super << L2CAP_CTRL_SUPER_SHIFT) &
+			L2CAP_CTRL_SUPERVISE_MASK;
+}
+
+static inline __u32 __set_ctrl_final(__u8 ext_ctrl)
+{
+	if (ext_ctrl)
+		return L2CAP_EXT_CTRL_FINAL;
+	else
+		return L2CAP_CTRL_FINAL;
+}
+
+static inline bool __is_ctrl_final(__u8 ext_ctrl, __u32 ctrl)
+{
+	if (ext_ctrl)
+		return ctrl & L2CAP_EXT_CTRL_FINAL;
+	else
+		return ctrl & L2CAP_CTRL_FINAL;
+}
+
+static inline __u32 __set_ctrl_poll(__u8 ext_ctrl)
+{
+	if (ext_ctrl)
+		return L2CAP_EXT_CTRL_POLL;
+	else
+		return L2CAP_CTRL_POLL;
+}
+
+static inline bool __is_ctrl_poll(__u8 ext_ctrl, __u32 ctrl)
+{
+	if (ext_ctrl)
+		return ctrl & L2CAP_EXT_CTRL_POLL;
+	else
+		return ctrl & L2CAP_CTRL_POLL;
+}
+
+static inline __u32 __get_control(__u8 ext_ctrl, void *p)
+{
+	if (ext_ctrl)
+		return get_unaligned_le32(p);
+	else
+		return get_unaligned_le16(p);
+}
+
+static inline __u32 __get_control_pull(__u8 ext_ctrl,
+		struct sk_buff *skb, void *p)
+{
+	__u32 ctrl;
+
+	if (ext_ctrl) {
+		ctrl = get_unaligned_le32(p);
+		skb_pull(skb, 4);
+	} else {
+		ctrl = get_unaligned_le16(p);
+		skb_pull(skb, 2);
+	}
+
+	return ctrl;
+}
+
+static inline void __put_control(__u8 ext_ctrl, __u32 control, void *p)
+{
+	if (ext_ctrl)
+		return put_unaligned_le32(control, p);
+	else
+		return put_unaligned_le16(control, p);
+}
+
+static inline void __put_control_put(__u8 ext_ctrl, __u32 control, void *p)
+{
+	if (ext_ctrl)
+		return put_unaligned_le32(control, skb_put(p, 4));
+	else
+		return put_unaligned_le16(control, skb_put(p, 2));
+}
 
 extern int disable_ertm;
 
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 0d62b05..820a2b0 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -582,30 +582,36 @@ static void l2cap_send_cmd(struct l2cap_conn *conn, u8 ident, u8 code, u16 len,
 	hci_send_acl(conn->hcon, skb, flags);
 }
 
-static inline void l2cap_send_sframe(struct l2cap_chan *chan, u16 control)
+static inline void l2cap_send_sframe(struct l2cap_chan *chan, u32 control)
 {
 	struct sk_buff *skb;
 	struct l2cap_hdr *lh;
 	struct l2cap_conn *conn = chan->conn;
-	int count, hlen = L2CAP_HDR_SIZE + 2;
+	int count, hlen;
 	u8 flags;
 
 	if (chan->state != BT_CONNECTED)
 		return;
 
+	if (chan->ext_ctrl)
+		hlen = L2CAP_EXTENDED_HDR_SIZE;
+	else
+		hlen = L2CAP_ENHANCED_HDR_SIZE;
+
 	if (chan->fcs == L2CAP_FCS_CRC16)
 		hlen += 2;
 
-	BT_DBG("chan %p, control 0x%2.2x", chan, control);
+	BT_DBG("chan %p, control 0x%8.8x", chan, control);
 
 	count = min_t(unsigned int, conn->mtu, hlen);
-	control |= L2CAP_CTRL_FRAME_TYPE;
+
+	control |= __set_sframe(chan->ext_ctrl);
 
 	if (test_and_clear_bit(CONN_SEND_FBIT, &chan->conn_state))
-		control |= L2CAP_CTRL_FINAL;
+		control |= __set_ctrl_final(chan->ext_ctrl);
 
 	if (test_and_clear_bit(CONN_SEND_PBIT, &chan->conn_state))
-		control |= L2CAP_CTRL_POLL;
+		control |= __set_ctrl_poll(chan->ext_ctrl);
 
 	skb = bt_skb_alloc(count, GFP_ATOMIC);
 	if (!skb)
@@ -614,7 +620,8 @@ static inline void l2cap_send_sframe(struct l2cap_chan *chan, u16 control)
 	lh = (struct l2cap_hdr *) skb_put(skb, L2CAP_HDR_SIZE);
 	lh->len = cpu_to_le16(hlen - L2CAP_HDR_SIZE);
 	lh->cid = cpu_to_le16(chan->dcid);
-	put_unaligned_le16(control, skb_put(skb, 2));
+
+	__put_control_put(chan->ext_ctrl, control, skb);
 
 	if (chan->fcs == L2CAP_FCS_CRC16) {
 		u16 fcs = crc16(0, (u8 *)lh, count - 2);
@@ -631,15 +638,15 @@ static inline void l2cap_send_sframe(struct l2cap_chan *chan, u16 control)
 	hci_send_acl(chan->conn->hcon, skb, flags);
 }
 
-static inline void l2cap_send_rr_or_rnr(struct l2cap_chan *chan, u16 control)
+static inline void l2cap_send_rr_or_rnr(struct l2cap_chan *chan, u32 control)
 {
 	if (test_bit(CONN_LOCAL_BUSY, &chan->conn_state)) {
-		control |= L2CAP_SUPER_RCV_NOT_READY;
+		control |= __set_ctrl_super(chan->ext_ctrl, L2CAP_SUPER_RNR);
 		set_bit(CONN_RNR_SENT, &chan->conn_state);
 	} else
-		control |= L2CAP_SUPER_RCV_READY;
+		control |= __set_ctrl_super(chan->ext_ctrl, L2CAP_SUPER_RR);
 
-	control |= chan->buffer_seq << L2CAP_CTRL_REQSEQ_SHIFT;
+	control |= __set_reqseq(chan->ext_ctrl, chan->buffer_seq);
 
 	l2cap_send_sframe(chan, control);
 }
@@ -1281,12 +1288,15 @@ static void l2cap_do_send(struct l2cap_chan *chan, struct sk_buff *skb)
 static void l2cap_streaming_send(struct l2cap_chan *chan)
 {
 	struct sk_buff *skb;
-	u16 control, fcs;
+	u32 control;
+	u16 fcs;
 
 	while ((skb = skb_dequeue(&chan->tx_q))) {
-		control = get_unaligned_le16(skb->data + L2CAP_HDR_SIZE);
-		control |= chan->next_tx_seq << L2CAP_CTRL_TXSEQ_SHIFT;
-		put_unaligned_le16(control, skb->data + L2CAP_HDR_SIZE);
+		control = __get_control(chan->ext_ctrl,
+				skb->data + L2CAP_HDR_SIZE);
+		control |= __set_txseq(chan->ext_ctrl, chan->next_tx_seq);
+		__put_control(chan->ext_ctrl, control,
+				skb->data + L2CAP_HDR_SIZE);
 
 		if (chan->fcs == L2CAP_FCS_CRC16) {
 			fcs = crc16(0, (u8 *)skb->data, skb->len - 2);
@@ -1299,10 +1309,11 @@ static void l2cap_streaming_send(struct l2cap_chan *chan)
 	}
 }
 
-static void l2cap_retransmit_one_frame(struct l2cap_chan *chan, u8 tx_seq)
+static void l2cap_retransmit_one_frame(struct l2cap_chan *chan, u16 tx_seq)
 {
 	struct sk_buff *skb, *tx_skb;
-	u16 control, fcs;
+	u16 fcs;
+	u32 control;
 
 	skb = skb_peek(&chan->tx_q);
 	if (!skb)
@@ -1325,16 +1336,17 @@ static void l2cap_retransmit_one_frame(struct l2cap_chan *chan, u8 tx_seq)
 
 	tx_skb = skb_clone(skb, GFP_ATOMIC);
 	bt_cb(skb)->retries++;
-	control = get_unaligned_le16(tx_skb->data + L2CAP_HDR_SIZE);
-	control &= L2CAP_CTRL_SAR;
+
+	control = __get_control(chan->ext_ctrl, tx_skb->data + L2CAP_HDR_SIZE);
+	control &= __get_sar_mask(chan->ext_ctrl);
 
 	if (test_and_clear_bit(CONN_SEND_FBIT, &chan->conn_state))
-		control |= L2CAP_CTRL_FINAL;
+		control |= __set_ctrl_final(chan->ext_ctrl);
 
-	control |= (chan->buffer_seq << L2CAP_CTRL_REQSEQ_SHIFT)
-			| (tx_seq << L2CAP_CTRL_TXSEQ_SHIFT);
+	control |= __set_reqseq(chan->ext_ctrl, chan->buffer_seq);
+	control |= __set_txseq(chan->ext_ctrl, tx_seq);
 
-	put_unaligned_le16(control, tx_skb->data + L2CAP_HDR_SIZE);
+	__put_control(chan->ext_ctrl, control, tx_skb->data + L2CAP_HDR_SIZE);
 
 	if (chan->fcs == L2CAP_FCS_CRC16) {
 		fcs = crc16(0, (u8 *)tx_skb->data, tx_skb->len - 2);
@@ -1347,7 +1359,8 @@ static void l2cap_retransmit_one_frame(struct l2cap_chan *chan, u8 tx_seq)
 static int l2cap_ertm_send(struct l2cap_chan *chan)
 {
 	struct sk_buff *skb, *tx_skb;
-	u16 control, fcs;
+	u16 fcs;
+	u32 control;
 	int nsent = 0;
 
 	if (chan->state != BT_CONNECTED)
@@ -1365,16 +1378,18 @@ static int l2cap_ertm_send(struct l2cap_chan *chan)
 
 		bt_cb(skb)->retries++;
 
-		control = get_unaligned_le16(tx_skb->data + L2CAP_HDR_SIZE);
-		control &= L2CAP_CTRL_SAR;
+		control = __get_control(chan->ext_ctrl,
+				tx_skb->data + L2CAP_HDR_SIZE);
+		control &= __get_sar_mask(chan->ext_ctrl);
 
 		if (test_and_clear_bit(CONN_SEND_FBIT, &chan->conn_state))
-			control |= L2CAP_CTRL_FINAL;
+			control |= __set_ctrl_final(chan->ext_ctrl);
 
-		control |= (chan->buffer_seq << L2CAP_CTRL_REQSEQ_SHIFT)
-				| (chan->next_tx_seq << L2CAP_CTRL_TXSEQ_SHIFT);
-		put_unaligned_le16(control, tx_skb->data + L2CAP_HDR_SIZE);
+		control |= __set_reqseq(chan->ext_ctrl, chan->buffer_seq);
+		control |= __set_txseq(chan->ext_ctrl, chan->next_tx_seq);
 
+		__put_control(chan->ext_ctrl, control,
+				tx_skb->data + L2CAP_HDR_SIZE);
 
 		if (chan->fcs == L2CAP_FCS_CRC16) {
 			fcs = crc16(0, (u8 *)skb->data, tx_skb->len - 2);
@@ -1418,12 +1433,12 @@ static int l2cap_retransmit_frames(struct l2cap_chan *chan)
 
 static void l2cap_send_ack(struct l2cap_chan *chan)
 {
-	u16 control = 0;
+	u32 control = 0;
 
-	control |= chan->buffer_seq << L2CAP_CTRL_REQSEQ_SHIFT;
+	control |= __set_reqseq(chan->ext_ctrl, chan->buffer_seq);
 
 	if (test_bit(CONN_LOCAL_BUSY, &chan->conn_state)) {
-		control |= L2CAP_SUPER_RCV_NOT_READY;
+		control |= __set_ctrl_super(chan->ext_ctrl, L2CAP_SUPER_RNR);
 		set_bit(CONN_RNR_SENT, &chan->conn_state);
 		l2cap_send_sframe(chan, control);
 		return;
@@ -1432,20 +1447,20 @@ static void l2cap_send_ack(struct l2cap_chan *chan)
 	if (l2cap_ertm_send(chan) > 0)
 		return;
 
-	control |= L2CAP_SUPER_RCV_READY;
+	control |= __set_ctrl_super(chan->ext_ctrl, L2CAP_SUPER_RR);
 	l2cap_send_sframe(chan, control);
 }
 
 static void l2cap_send_srejtail(struct l2cap_chan *chan)
 {
 	struct srej_list *tail;
-	u16 control;
+	u32 control;
 
-	control = L2CAP_SUPER_SELECT_REJECT;
-	control |= L2CAP_CTRL_FINAL;
+	control = __set_ctrl_super(chan->ext_ctrl, L2CAP_SUPER_SREJ);
+	control |= __set_ctrl_final(chan->ext_ctrl);
 
 	tail = list_entry((&chan->srej_l)->prev, struct srej_list, list);
-	control |= tail->tx_seq << L2CAP_CTRL_REQSEQ_SHIFT;
+	control |= __set_reqseq(chan->ext_ctrl, tail->tx_seq);
 
 	l2cap_send_sframe(chan, control);
 }
@@ -1541,12 +1556,12 @@ static struct sk_buff *l2cap_create_basic_pdu(struct l2cap_chan *chan, struct ms
 	return skb;
 }
 
-static struct sk_buff *l2cap_create_iframe_pdu(struct l2cap_chan *chan, struct msghdr *msg, size_t len, u16 control, u16 sdulen)
+static struct sk_buff *l2cap_create_iframe_pdu(struct l2cap_chan *chan, struct msghdr *msg, size_t len, u32 control, u16 sdulen)
 {
 	struct sock *sk = chan->sk;
 	struct l2cap_conn *conn = chan->conn;
 	struct sk_buff *skb;
-	int err, count, hlen = L2CAP_HDR_SIZE + 2;
+	int err, count, hlen;
 	struct l2cap_hdr *lh;
 
 	BT_DBG("sk %p len %d", sk, (int)len);
@@ -1554,6 +1569,11 @@ static struct sk_buff *l2cap_create_iframe_pdu(struct l2cap_chan *chan, struct m
 	if (!conn)
 		return ERR_PTR(-ENOTCONN);
 
+	if (chan->ext_ctrl)
+		hlen = L2CAP_EXTENDED_HDR_SIZE;
+	else
+		hlen = L2CAP_ENHANCED_HDR_SIZE;
+
 	if (sdulen)
 		hlen += 2;
 
@@ -1570,7 +1590,9 @@ static struct sk_buff *l2cap_create_iframe_pdu(struct l2cap_chan *chan, struct m
 	lh = (struct l2cap_hdr *) skb_put(skb, L2CAP_HDR_SIZE);
 	lh->cid = cpu_to_le16(chan->dcid);
 	lh->len = cpu_to_le16(len + (hlen - L2CAP_HDR_SIZE));
-	put_unaligned_le16(control, skb_put(skb, 2));
+
+	__put_control_put(chan->ext_ctrl, control, skb);
+
 	if (sdulen)
 		put_unaligned_le16(sdulen, skb_put(skb, 2));
 
@@ -1591,11 +1613,11 @@ static int l2cap_sar_segment_sdu(struct l2cap_chan *chan, struct msghdr *msg, si
 {
 	struct sk_buff *skb;
 	struct sk_buff_head sar_queue;
-	u16 control;
+	u32 control;
 	size_t size = 0;
 
 	skb_queue_head_init(&sar_queue);
-	control = L2CAP_SDU_START;
+	control = __set_ctrl_sar(chan->ext_ctrl, L2CAP_SAR_START);
 	skb = l2cap_create_iframe_pdu(chan, msg, chan->remote_mps, control, len);
 	if (IS_ERR(skb))
 		return PTR_ERR(skb);
@@ -1608,10 +1630,12 @@ static int l2cap_sar_segment_sdu(struct l2cap_chan *chan, struct msghdr *msg, si
 		size_t buflen;
 
 		if (len > chan->remote_mps) {
-			control = L2CAP_SDU_CONTINUE;
+			control = __set_ctrl_sar(chan->ext_ctrl,
+					L2CAP_SAR_CONTINUE);
 			buflen = chan->remote_mps;
 		} else {
-			control = L2CAP_SDU_END;
+			control = __set_ctrl_sar(chan->ext_ctrl,
+					L2CAP_SAR_END);
 			buflen = len;
 		}
 
@@ -1635,7 +1659,7 @@ static int l2cap_sar_segment_sdu(struct l2cap_chan *chan, struct msghdr *msg, si
 int l2cap_chan_send(struct l2cap_chan *chan, struct msghdr *msg, size_t len)
 {
 	struct sk_buff *skb;
-	u16 control;
+	u32 control;
 	int err;
 
 	/* Connectionless channel */
@@ -1667,7 +1691,8 @@ int l2cap_chan_send(struct l2cap_chan *chan, struct msghdr *msg, size_t len)
 	case L2CAP_MODE_STREAMING:
 		/* Entire SDU fits into one PDU */
 		if (len <= chan->remote_mps) {
-			control = L2CAP_SDU_UNSEGMENTED;
+			control = __set_ctrl_sar(chan->ext_ctrl,
+					L2CAP_SAR_UNSEGMENTED);
 			skb = l2cap_create_iframe_pdu(chan, msg, len, control,
 									0);
 			if (IS_ERR(skb))
@@ -2007,8 +2032,11 @@ done:
 			rfc.max_pdu_size = cpu_to_le16(chan->conn->mtu - 10);
 
 		l2cap_txwin_setup(chan);
-		rfc.txwin_size = chan->tx_win > L2CAP_DEFAULT_MAX_TX_WINDOW?
-			L2CAP_DEFAULT_MAX_TX_WINDOW : chan->tx_win;
+
+		if (chan->ext_ctrl)
+			rfc.txwin_size = L2CAP_DEFAULT_MAX_TX_WINDOW;
+		else
+			rfc.txwin_size = chan->tx_win;
 
 		l2cap_add_conf_opt(&ptr, L2CAP_CONF_RFC, sizeof(rfc),
 							(unsigned long) &rfc);
@@ -3298,7 +3326,12 @@ static inline void l2cap_sig_channel(struct l2cap_conn *conn,
 static int l2cap_check_fcs(struct l2cap_chan *chan,  struct sk_buff *skb)
 {
 	u16 our_fcs, rcv_fcs;
-	int hdr_size = L2CAP_HDR_SIZE + 2;
+	int hdr_size;
+
+	if (chan->ext_ctrl)
+		hdr_size = L2CAP_EXTENDED_HDR_SIZE;
+	else
+		hdr_size = L2CAP_ENHANCED_HDR_SIZE;
 
 	if (chan->fcs == L2CAP_FCS_CRC16) {
 		skb_trim(skb, skb->len - 2);
@@ -3313,14 +3346,14 @@ static int l2cap_check_fcs(struct l2cap_chan *chan,  struct sk_buff *skb)
 
 static inline void l2cap_send_i_or_rr_or_rnr(struct l2cap_chan *chan)
 {
-	u16 control = 0;
+	u32 control = 0;
 
 	chan->frames_sent = 0;
 
-	control |= chan->buffer_seq << L2CAP_CTRL_REQSEQ_SHIFT;
+	control |= __set_reqseq(chan->ext_ctrl, chan->buffer_seq);
 
 	if (test_bit(CONN_LOCAL_BUSY, &chan->conn_state)) {
-		control |= L2CAP_SUPER_RCV_NOT_READY;
+		control |= __set_ctrl_super(chan->ext_ctrl, L2CAP_SUPER_RNR);
 		l2cap_send_sframe(chan, control);
 		set_bit(CONN_RNR_SENT, &chan->conn_state);
 	}
@@ -3332,12 +3365,12 @@ static inline void l2cap_send_i_or_rr_or_rnr(struct l2cap_chan *chan)
 
 	if (!test_bit(CONN_LOCAL_BUSY, &chan->conn_state) &&
 			chan->frames_sent == 0) {
-		control |= L2CAP_SUPER_RCV_READY;
+		control |= __set_ctrl_super(chan->ext_ctrl, L2CAP_SUPER_RR);
 		l2cap_send_sframe(chan, control);
 	}
 }
 
-static int l2cap_add_to_srej_queue(struct l2cap_chan *chan, struct sk_buff *skb, u8 tx_seq, u8 sar)
+static int l2cap_add_to_srej_queue(struct l2cap_chan *chan, struct sk_buff *skb, u16 tx_seq, u8 sar)
 {
 	struct sk_buff *next_skb;
 	int tx_seq_offset, next_tx_seq_offset;
@@ -3398,19 +3431,19 @@ static void append_skb_frag(struct sk_buff *skb,
 	skb->truesize += new_frag->truesize;
 }
 
-static int l2cap_reassemble_sdu(struct l2cap_chan *chan, struct sk_buff *skb, u16 control)
+static int l2cap_reassemble_sdu(struct l2cap_chan *chan, struct sk_buff *skb, u32 control)
 {
 	int err = -EINVAL;
 
-	switch (control & L2CAP_CTRL_SAR) {
-	case L2CAP_SDU_UNSEGMENTED:
+	switch (__get_ctrl_sar(chan->ext_ctrl, control)) {
+	case L2CAP_SAR_UNSEGMENTED:
 		if (chan->sdu)
 			break;
 
 		err = chan->ops->recv(chan->data, skb);
 		break;
 
-	case L2CAP_SDU_START:
+	case L2CAP_SAR_START:
 		if (chan->sdu)
 			break;
 
@@ -3432,7 +3465,7 @@ static int l2cap_reassemble_sdu(struct l2cap_chan *chan, struct sk_buff *skb, u1
 		err = 0;
 		break;
 
-	case L2CAP_SDU_CONTINUE:
+	case L2CAP_SAR_CONTINUE:
 		if (!chan->sdu)
 			break;
 
@@ -3446,7 +3479,7 @@ static int l2cap_reassemble_sdu(struct l2cap_chan *chan, struct sk_buff *skb, u1
 		err = 0;
 		break;
 
-	case L2CAP_SDU_END:
+	case L2CAP_SAR_END:
 		if (!chan->sdu)
 			break;
 
@@ -3481,14 +3514,14 @@ static int l2cap_reassemble_sdu(struct l2cap_chan *chan, struct sk_buff *skb, u1
 
 static void l2cap_ertm_enter_local_busy(struct l2cap_chan *chan)
 {
-	u16 control;
+	u32 control;
 
 	BT_DBG("chan %p, Enter local busy", chan);
 
 	set_bit(CONN_LOCAL_BUSY, &chan->conn_state);
 
-	control = chan->buffer_seq << L2CAP_CTRL_REQSEQ_SHIFT;
-	control |= L2CAP_SUPER_RCV_NOT_READY;
+	control = __set_reqseq(chan->ext_ctrl, chan->buffer_seq);
+	control |= __set_ctrl_super(chan->ext_ctrl, L2CAP_SUPER_RNR);
 	l2cap_send_sframe(chan, control);
 
 	set_bit(CONN_RNR_SENT, &chan->conn_state);
@@ -3498,13 +3531,14 @@ static void l2cap_ertm_enter_local_busy(struct l2cap_chan *chan)
 
 static void l2cap_ertm_exit_local_busy(struct l2cap_chan *chan)
 {
-	u16 control;
+	u32 control;
 
 	if (!test_bit(CONN_RNR_SENT, &chan->conn_state))
 		goto done;
 
-	control = chan->buffer_seq << L2CAP_CTRL_REQSEQ_SHIFT;
-	control |= L2CAP_SUPER_RCV_READY | L2CAP_CTRL_POLL;
+	control = __set_reqseq(chan->ext_ctrl, chan->buffer_seq);
+	control |= __set_ctrl_super(chan->ext_ctrl, L2CAP_SUPER_RR);
+	control |= __set_ctrl_poll(chan->ext_ctrl);
 	l2cap_send_sframe(chan, control);
 	chan->retry_count = 1;
 
@@ -3530,10 +3564,10 @@ void l2cap_chan_busy(struct l2cap_chan *chan, int busy)
 	}
 }
 
-static void l2cap_check_srej_gap(struct l2cap_chan *chan, u8 tx_seq)
+static void l2cap_check_srej_gap(struct l2cap_chan *chan, u16 tx_seq)
 {
 	struct sk_buff *skb;
-	u16 control;
+	u32 control;
 
 	while ((skb = skb_peek(&chan->srej_q)) &&
 			!test_bit(CONN_LOCAL_BUSY, &chan->conn_state)) {
@@ -3543,7 +3577,7 @@ static void l2cap_check_srej_gap(struct l2cap_chan *chan, u8 tx_seq)
 			break;
 
 		skb = skb_dequeue(&chan->srej_q);
-		control = bt_cb(skb)->sar << L2CAP_CTRL_SAR_SHIFT;
+		control = __set_ctrl_sar(chan->ext_ctrl, bt_cb(skb)->sar);
 		err = l2cap_reassemble_sdu(chan, skb, control);
 
 		if (err < 0) {
@@ -3557,10 +3591,10 @@ static void l2cap_check_srej_gap(struct l2cap_chan *chan, u8 tx_seq)
 	}
 }
 
-static void l2cap_resend_srejframe(struct l2cap_chan *chan, u8 tx_seq)
+static void l2cap_resend_srejframe(struct l2cap_chan *chan, u16 tx_seq)
 {
 	struct srej_list *l, *tmp;
-	u16 control;
+	u32 control;
 
 	list_for_each_entry_safe(l, tmp, &chan->srej_l, list) {
 		if (l->tx_seq == tx_seq) {
@@ -3568,22 +3602,22 @@ static void l2cap_resend_srejframe(struct l2cap_chan *chan, u8 tx_seq)
 			kfree(l);
 			return;
 		}
-		control = L2CAP_SUPER_SELECT_REJECT;
-		control |= l->tx_seq << L2CAP_CTRL_REQSEQ_SHIFT;
+		control = __set_ctrl_super(chan->ext_ctrl, L2CAP_SUPER_SREJ);
+		control |= __set_reqseq(chan->ext_ctrl, l->tx_seq);
 		l2cap_send_sframe(chan, control);
 		list_del(&l->list);
 		list_add_tail(&l->list, &chan->srej_l);
 	}
 }
 
-static void l2cap_send_srejframe(struct l2cap_chan *chan, u8 tx_seq)
+static void l2cap_send_srejframe(struct l2cap_chan *chan, u16 tx_seq)
 {
 	struct srej_list *new;
-	u16 control;
+	u32 control;
 
 	while (tx_seq != chan->expected_tx_seq) {
-		control = L2CAP_SUPER_SELECT_REJECT;
-		control |= chan->expected_tx_seq << L2CAP_CTRL_REQSEQ_SHIFT;
+		control = __set_ctrl_super(chan->ext_ctrl, L2CAP_SUPER_SREJ);
+		control |= __set_reqseq(chan->ext_ctrl, chan->expected_tx_seq);
 		l2cap_send_sframe(chan, control);
 
 		new = kzalloc(sizeof(struct srej_list), GFP_ATOMIC);
@@ -3594,19 +3628,19 @@ static void l2cap_send_srejframe(struct l2cap_chan *chan, u8 tx_seq)
 	chan->expected_tx_seq = (chan->expected_tx_seq + 1) % 64;
 }
 
-static inline int l2cap_data_channel_iframe(struct l2cap_chan *chan, u16 rx_control, struct sk_buff *skb)
+static inline int l2cap_data_channel_iframe(struct l2cap_chan *chan, u32 rx_control, struct sk_buff *skb)
 {
-	u8 tx_seq = __get_txseq(rx_control);
-	u8 req_seq = __get_reqseq(rx_control);
-	u8 sar = rx_control >> L2CAP_CTRL_SAR_SHIFT;
+	u16 tx_seq = __get_txseq(chan->ext_ctrl, rx_control);
+	u16 req_seq = __get_reqseq(chan->ext_ctrl, rx_control);
+	u8 sar = __get_ctrl_sar(chan->ext_ctrl, rx_control);
 	int tx_seq_offset, expected_tx_seq_offset;
 	int num_to_ack = (chan->tx_win/6) + 1;
 	int err = 0;
 
-	BT_DBG("chan %p len %d tx_seq %d rx_control 0x%4.4x", chan, skb->len,
+	BT_DBG("chan %p len %d tx_seq %d rx_control 0x%8.8x", chan, skb->len,
 							tx_seq, rx_control);
 
-	if (L2CAP_CTRL_FINAL & rx_control &&
+	if (__is_ctrl_final(chan->ext_ctrl, rx_control) &&
 			test_bit(CONN_WAIT_F, &chan->conn_state)) {
 		__clear_monitor_timer(chan);
 		if (chan->unacked_frames > 0)
@@ -3711,7 +3745,7 @@ expected:
 		return err;
 	}
 
-	if (rx_control & L2CAP_CTRL_FINAL) {
+	if (__is_ctrl_final(chan->ext_ctrl, rx_control)) {
 		if (!test_and_clear_bit(CONN_REJ_ACT, &chan->conn_state))
 			l2cap_retransmit_frames(chan);
 	}
@@ -3729,15 +3763,16 @@ drop:
 	return 0;
 }
 
-static inline void l2cap_data_channel_rrframe(struct l2cap_chan *chan, u16 rx_control)
+static inline void l2cap_data_channel_rrframe(struct l2cap_chan *chan, u32 rx_control)
 {
-	BT_DBG("chan %p, req_seq %d ctrl 0x%4.4x", chan, __get_reqseq(rx_control),
-						rx_control);
+	BT_DBG("chan %p, req_seq %d ctrl 0x%8.8x",
+			chan, __get_reqseq(chan->ext_ctrl, rx_control),
+			rx_control);
 
-	chan->expected_ack_seq = __get_reqseq(rx_control);
+	chan->expected_ack_seq = __get_reqseq(chan->ext_ctrl, rx_control);
 	l2cap_drop_acked_frames(chan);
 
-	if (rx_control & L2CAP_CTRL_POLL) {
+	if (__is_ctrl_poll(chan->ext_ctrl, rx_control)) {
 		set_bit(CONN_SEND_FBIT, &chan->conn_state);
 		if (test_bit(CONN_SREJ_SENT, &chan->conn_state)) {
 			if (test_bit(CONN_REMOTE_BUSY, &chan->conn_state) &&
@@ -3750,7 +3785,7 @@ static inline void l2cap_data_channel_rrframe(struct l2cap_chan *chan, u16 rx_co
 			l2cap_send_i_or_rr_or_rnr(chan);
 		}
 
-	} else if (rx_control & L2CAP_CTRL_FINAL) {
+	} else if (__is_ctrl_final(chan->ext_ctrl, rx_control)) {
 		clear_bit(CONN_REMOTE_BUSY, &chan->conn_state);
 
 		if (!test_and_clear_bit(CONN_REJ_ACT, &chan->conn_state))
@@ -3769,9 +3804,9 @@ static inline void l2cap_data_channel_rrframe(struct l2cap_chan *chan, u16 rx_co
 	}
 }
 
-static inline void l2cap_data_channel_rejframe(struct l2cap_chan *chan, u16 rx_control)
+static inline void l2cap_data_channel_rejframe(struct l2cap_chan *chan, u32 rx_control)
 {
-	u8 tx_seq = __get_reqseq(rx_control);
+	u16 tx_seq = __get_reqseq(chan->ext_ctrl, rx_control);
 
 	BT_DBG("chan %p, req_seq %d ctrl 0x%4.4x", chan, tx_seq, rx_control);
 
@@ -3780,7 +3815,7 @@ static inline void l2cap_data_channel_rejframe(struct l2cap_chan *chan, u16 rx_c
 	chan->expected_ack_seq = tx_seq;
 	l2cap_drop_acked_frames(chan);
 
-	if (rx_control & L2CAP_CTRL_FINAL) {
+	if (__is_ctrl_final(chan->ext_ctrl, rx_control)) {
 		if (!test_and_clear_bit(CONN_REJ_ACT, &chan->conn_state))
 			l2cap_retransmit_frames(chan);
 	} else {
@@ -3790,15 +3825,15 @@ static inline void l2cap_data_channel_rejframe(struct l2cap_chan *chan, u16 rx_c
 			set_bit(CONN_REJ_ACT, &chan->conn_state);
 	}
 }
-static inline void l2cap_data_channel_srejframe(struct l2cap_chan *chan, u16 rx_control)
+static inline void l2cap_data_channel_srejframe(struct l2cap_chan *chan, u32 rx_control)
 {
-	u8 tx_seq = __get_reqseq(rx_control);
+	u16 tx_seq = __get_reqseq(chan->ext_ctrl, rx_control);
 
-	BT_DBG("chan %p, req_seq %d ctrl 0x%4.4x", chan, tx_seq, rx_control);
+	BT_DBG("chan %p, req_seq %d ctrl 0x%8.8x", chan, tx_seq, rx_control);
 
 	clear_bit(CONN_REMOTE_BUSY, &chan->conn_state);
 
-	if (rx_control & L2CAP_CTRL_POLL) {
+	if (__is_ctrl_poll(chan->ext_ctrl, rx_control)) {
 		chan->expected_ack_seq = tx_seq;
 		l2cap_drop_acked_frames(chan);
 
@@ -3811,7 +3846,7 @@ static inline void l2cap_data_channel_srejframe(struct l2cap_chan *chan, u16 rx_
 			chan->srej_save_reqseq = tx_seq;
 			set_bit(CONN_SREJ_ACT, &chan->conn_state);
 		}
-	} else if (rx_control & L2CAP_CTRL_FINAL) {
+	} else if (__is_ctrl_final(chan->ext_ctrl, rx_control)) {
 		if (test_bit(CONN_SREJ_ACT, &chan->conn_state) &&
 				chan->srej_save_reqseq == tx_seq)
 			clear_bit(CONN_SREJ_ACT, &chan->conn_state);
@@ -3826,37 +3861,39 @@ static inline void l2cap_data_channel_srejframe(struct l2cap_chan *chan, u16 rx_
 	}
 }
 
-static inline void l2cap_data_channel_rnrframe(struct l2cap_chan *chan, u16 rx_control)
+static inline void l2cap_data_channel_rnrframe(struct l2cap_chan *chan, u32 rx_control)
 {
-	u8 tx_seq = __get_reqseq(rx_control);
+	u16 tx_seq = __get_reqseq(chan->ext_ctrl, rx_control);
 
-	BT_DBG("chan %p, req_seq %d ctrl 0x%4.4x", chan, tx_seq, rx_control);
+	BT_DBG("chan %p, req_seq %d ctrl 0x%8.8x", chan, tx_seq, rx_control);
 
 	set_bit(CONN_REMOTE_BUSY, &chan->conn_state);
 	chan->expected_ack_seq = tx_seq;
 	l2cap_drop_acked_frames(chan);
 
-	if (rx_control & L2CAP_CTRL_POLL)
+	if (__is_ctrl_poll(chan->ext_ctrl, rx_control))
 		set_bit(CONN_SEND_FBIT, &chan->conn_state);
 
 	if (!test_bit(CONN_SREJ_SENT, &chan->conn_state)) {
 		__clear_retrans_timer(chan);
-		if (rx_control & L2CAP_CTRL_POLL)
+		if (__is_ctrl_poll(chan->ext_ctrl, rx_control))
 			l2cap_send_rr_or_rnr(chan, L2CAP_CTRL_FINAL);
 		return;
 	}
 
-	if (rx_control & L2CAP_CTRL_POLL)
+	if (__is_ctrl_poll(chan->ext_ctrl, rx_control))
 		l2cap_send_srejtail(chan);
-	else
-		l2cap_send_sframe(chan, L2CAP_SUPER_RCV_READY);
+	else {
+		rx_control = __set_ctrl_super(chan->ext_ctrl, L2CAP_SUPER_RR);
+		l2cap_send_sframe(chan, rx_control);
+	}
 }
 
-static inline int l2cap_data_channel_sframe(struct l2cap_chan *chan, u16 rx_control, struct sk_buff *skb)
+static inline int l2cap_data_channel_sframe(struct l2cap_chan *chan, u32 rx_control, struct sk_buff *skb)
 {
-	BT_DBG("chan %p rx_control 0x%4.4x len %d", chan, rx_control, skb->len);
+	BT_DBG("chan %p rx_control 0x%8.8x len %d", chan, rx_control, skb->len);
 
-	if (L2CAP_CTRL_FINAL & rx_control &&
+	if (__is_ctrl_final(chan->ext_ctrl, rx_control) &&
 			test_bit(CONN_WAIT_F, &chan->conn_state)) {
 		__clear_monitor_timer(chan);
 		if (chan->unacked_frames > 0)
@@ -3864,20 +3901,20 @@ static inline int l2cap_data_channel_sframe(struct l2cap_chan *chan, u16 rx_cont
 		clear_bit(CONN_WAIT_F, &chan->conn_state);
 	}
 
-	switch (rx_control & L2CAP_CTRL_SUPERVISE) {
-	case L2CAP_SUPER_RCV_READY:
+	switch (__get_ctrl_super(chan->ext_ctrl, rx_control)) {
+	case L2CAP_SUPER_RR:
 		l2cap_data_channel_rrframe(chan, rx_control);
 		break;
 
-	case L2CAP_SUPER_REJECT:
+	case L2CAP_SUPER_REJ:
 		l2cap_data_channel_rejframe(chan, rx_control);
 		break;
 
-	case L2CAP_SUPER_SELECT_REJECT:
+	case L2CAP_SUPER_SREJ:
 		l2cap_data_channel_srejframe(chan, rx_control);
 		break;
 
-	case L2CAP_SUPER_RCV_NOT_READY:
+	case L2CAP_SUPER_RNR:
 		l2cap_data_channel_rnrframe(chan, rx_control);
 		break;
 	}
@@ -3889,12 +3926,11 @@ static inline int l2cap_data_channel_sframe(struct l2cap_chan *chan, u16 rx_cont
 static int l2cap_ertm_data_rcv(struct sock *sk, struct sk_buff *skb)
 {
 	struct l2cap_chan *chan = l2cap_pi(sk)->chan;
-	u16 control;
-	u8 req_seq;
+	u32 control;
+	u16 req_seq;
 	int len, next_tx_seq_offset, req_seq_offset;
 
-	control = get_unaligned_le16(skb->data);
-	skb_pull(skb, 2);
+	control = __get_control_pull(chan->ext_ctrl, skb, skb->data);
 	len = skb->len;
 
 	/*
@@ -3905,8 +3941,9 @@ static int l2cap_ertm_data_rcv(struct sock *sk, struct sk_buff *skb)
 	if (l2cap_check_fcs(chan, skb))
 		goto drop;
 
-	if (__is_sar_start(control) && __is_iframe(control))
-		len -= 2;
+	if (__is_sar_start(chan->ext_ctrl, control) &&
+			!__is_sframe(chan->ext_ctrl, control))
+		len -= L2CAP_SDULEN_SIZE;
 
 	if (chan->fcs == L2CAP_FCS_CRC16)
 		len -= 2;
@@ -3916,7 +3953,7 @@ static int l2cap_ertm_data_rcv(struct sock *sk, struct sk_buff *skb)
 		goto drop;
 	}
 
-	req_seq = __get_reqseq(control);
+	req_seq = __get_reqseq(chan->ext_ctrl, control);
 	req_seq_offset = (req_seq - chan->expected_ack_seq) % 64;
 	if (req_seq_offset < 0)
 		req_seq_offset += 64;
@@ -3932,7 +3969,7 @@ static int l2cap_ertm_data_rcv(struct sock *sk, struct sk_buff *skb)
 		goto drop;
 	}
 
-	if (__is_iframe(control)) {
+	if (!__is_sframe(chan->ext_ctrl, control)) {
 		if (len < 0) {
 			l2cap_send_disconn_req(chan->conn, chan, ECONNRESET);
 			goto drop;
@@ -3960,8 +3997,8 @@ static inline int l2cap_data_channel(struct l2cap_conn *conn, u16 cid, struct sk
 {
 	struct l2cap_chan *chan;
 	struct sock *sk = NULL;
-	u16 control;
-	u8 tx_seq;
+	u32 control;
+	u16 tx_seq;
 	int len;
 
 	chan = l2cap_get_chan_by_scid(conn, cid);
@@ -4002,23 +4039,23 @@ static inline int l2cap_data_channel(struct l2cap_conn *conn, u16 cid, struct sk
 		goto done;
 
 	case L2CAP_MODE_STREAMING:
-		control = get_unaligned_le16(skb->data);
-		skb_pull(skb, 2);
+		control = __get_control_pull(chan->ext_ctrl, skb, skb->data);
 		len = skb->len;
 
 		if (l2cap_check_fcs(chan, skb))
 			goto drop;
 
-		if (__is_sar_start(control))
-			len -= 2;
+		if (__is_sar_start(chan->ext_ctrl, control))
+			len -= L2CAP_SDULEN_SIZE;
 
 		if (chan->fcs == L2CAP_FCS_CRC16)
 			len -= 2;
 
-		if (len > chan->mps || len < 0 || __is_sframe(control))
+		if (len > chan->mps || len < 0 || __is_sframe(chan->ext_ctrl,
+					control))
 			goto drop;
 
-		tx_seq = __get_txseq(control);
+		tx_seq = __get_txseq(chan->ext_ctrl, control);
 
 		if (chan->expected_tx_seq != tx_seq) {
 			/* Frame(s) missing - must discard partial SDU */
-- 
1.7.4.1

