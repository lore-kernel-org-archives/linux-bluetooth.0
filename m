Return-Path: <cyrus@holtmann.org>
From: Mat Martineau <mathewm@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: padovan@profusion.mobi,
	pkrystad@codeaurora.org,
	marcel@holtmann.org,
	Mat Martineau <mathewm@codeaurora.org>
Subject: [PATCH 4/4] Bluetooth: Functions parsing or generating ERTM control fields
Date: Fri, 23 Mar 2012 16:56:58 -0700
Message-Id: <1332547018-19468-5-git-send-email-mathewm@codeaurora.org>
In-Reply-To: <1332547018-19468-1-git-send-email-mathewm@codeaurora.org>
References: <1332547018-19468-1-git-send-email-mathewm@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

These functions encode or decode ERTM control fields (extended or
enhanced) to or from the new l2cap_control structure.

Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
---
 net/bluetooth/l2cap_core.c |  120 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 120 insertions(+)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index ad73696..890cfb9 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -787,6 +787,118 @@ static inline void l2cap_send_rr_or_rnr(struct l2cap_chan *chan, u32 control)
 	l2cap_send_sframe(chan, control);
 }
 
+static u16 __pack_enhanced_control(struct l2cap_ctrl *control)
+{
+	u16 packed;
+
+	packed = (control->reqseq << L2CAP_CTRL_REQSEQ_SHIFT) &
+		L2CAP_CTRL_REQSEQ;
+	packed |= (control->final << L2CAP_CTRL_FINAL_SHIFT) &
+		L2CAP_CTRL_FINAL;
+
+	if (control->sframe) {
+		packed |= (control->poll << L2CAP_CTRL_POLL_SHIFT) &
+			L2CAP_CTRL_POLL;
+		packed |= (control->super << L2CAP_CTRL_SUPER_SHIFT) &
+			L2CAP_CTRL_SUPERVISE;
+		packed |= L2CAP_CTRL_FRAME_TYPE;
+	} else {
+		packed |= (control->sar << L2CAP_CTRL_SAR_SHIFT) &
+			L2CAP_CTRL_SAR;
+		packed |= (control->txseq << L2CAP_CTRL_TXSEQ_SHIFT) &
+			L2CAP_CTRL_TXSEQ;
+	}
+
+	return packed;
+}
+
+static void __get_enhanced_control(u16 enhanced,
+					struct l2cap_ctrl *control)
+{
+	control->reqseq = (enhanced & L2CAP_CTRL_REQSEQ) >>
+		L2CAP_CTRL_REQSEQ_SHIFT;
+	control->final = (enhanced & L2CAP_CTRL_FINAL) >>
+		L2CAP_CTRL_FINAL_SHIFT;
+
+	if (enhanced & L2CAP_CTRL_FRAME_TYPE) {
+		/* S-Frame */
+		control->sframe = 1;
+		control->poll = (enhanced & L2CAP_CTRL_POLL) >>
+			L2CAP_CTRL_POLL_SHIFT;
+		control->super = (enhanced & L2CAP_CTRL_SUPERVISE) >>
+			L2CAP_CTRL_SUPER_SHIFT;
+
+		control->sar = 0;
+		control->txseq = 0;
+	} else {
+		/* I-Frame */
+		control->sframe = 0;
+		control->sar = (enhanced & L2CAP_CTRL_SAR) >>
+			L2CAP_CTRL_SAR_SHIFT;
+		control->txseq = (enhanced & L2CAP_CTRL_TXSEQ) >>
+			L2CAP_CTRL_TXSEQ_SHIFT;
+
+		control->poll = 0;
+		control->super = 0;
+	}
+}
+
+static u32 __pack_extended_control(struct l2cap_ctrl *control)
+{
+	u32 packed;
+
+	packed = (control->reqseq << L2CAP_EXT_CTRL_REQSEQ_SHIFT) &
+		L2CAP_EXT_CTRL_REQSEQ;
+	packed |= (control->final << L2CAP_EXT_CTRL_FINAL_SHIFT) &
+		L2CAP_EXT_CTRL_FINAL;
+
+	if (control->sframe) {
+		packed |= (control->poll << L2CAP_EXT_CTRL_POLL_SHIFT) &
+			L2CAP_EXT_CTRL_POLL;
+		packed |= (control->super << L2CAP_EXT_CTRL_SUPER_SHIFT) &
+			L2CAP_EXT_CTRL_SUPERVISE;
+		packed |= L2CAP_EXT_CTRL_FRAME_TYPE;
+	} else {
+		packed |= (control->sar << L2CAP_EXT_CTRL_SAR_SHIFT) &
+			L2CAP_EXT_CTRL_SAR;
+		packed |= (control->txseq << L2CAP_EXT_CTRL_TXSEQ_SHIFT) &
+			L2CAP_EXT_CTRL_TXSEQ;
+	}
+
+	return packed;
+}
+
+static void __get_extended_control(u32 extended,
+				struct l2cap_ctrl *control)
+{
+	control->reqseq = (extended & L2CAP_EXT_CTRL_REQSEQ) >>
+		L2CAP_EXT_CTRL_REQSEQ_SHIFT;
+	control->final = (extended & L2CAP_EXT_CTRL_FINAL) >>
+		L2CAP_EXT_CTRL_FINAL_SHIFT;
+
+	if (extended & L2CAP_EXT_CTRL_FRAME_TYPE) {
+		/* S-Frame */
+		control->sframe = 1;
+		control->poll = (extended & L2CAP_EXT_CTRL_POLL) >>
+			L2CAP_EXT_CTRL_POLL_SHIFT;
+		control->super = (extended & L2CAP_EXT_CTRL_SUPERVISE) >>
+			L2CAP_EXT_CTRL_SUPER_SHIFT;
+
+		control->sar = 0;
+		control->txseq = 0;
+	} else {
+		/* I-Frame */
+		control->sframe = 0;
+		control->sar = (extended & L2CAP_EXT_CTRL_SAR) >>
+			L2CAP_EXT_CTRL_SAR_SHIFT;
+		control->txseq = (extended & L2CAP_EXT_CTRL_TXSEQ) >>
+			L2CAP_EXT_CTRL_TXSEQ_SHIFT;
+
+		control->poll = 0;
+		control->super = 0;
+	}
+}
+
 static inline int __l2cap_no_conn_pending(struct l2cap_chan *chan)
 {
 	return !test_bit(CONF_CONNECT_PEND, &chan->conf_state);
@@ -4345,6 +4457,14 @@ static int l2cap_ertm_data_rcv(struct l2cap_chan *chan, struct sk_buff *skb)
 	u16 req_seq;
 	int len, next_tx_seq_offset, req_seq_offset;
 
+	if (test_bit(FLAG_EXT_CTRL, &chan->flags)) {
+		__get_extended_control(get_unaligned_le32(skb->data),
+				       &bt_cb(skb)->control);
+	} else {
+		__get_enhanced_control(get_unaligned_le16(skb->data),
+				       &bt_cb(skb)->control);
+	}
+
 	control = __get_control(chan, skb->data);
 	skb_pull(skb, __ctrl_size(chan));
 	len = skb->len;
-- 
1.7.9.4

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
