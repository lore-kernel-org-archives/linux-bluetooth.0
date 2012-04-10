Return-Path: <cyrus@holtmann.org>
From: Mat Martineau <mathewm@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: gustavo@padovan.org,
	pkrystad@codeaurora.org,
	marcel@holtmann.org,
	Mat Martineau <mathewm@codeaurora.org>
Subject: [PATCHv5 2/2] Bluetooth: Functions for handling ERTM control fields
Date: Mon,  9 Apr 2012 17:55:33 -0700
Message-Id: <1334019333-31035-3-git-send-email-mathewm@codeaurora.org>
In-Reply-To: <1334019333-31035-1-git-send-email-mathewm@codeaurora.org>
References: <1334019333-31035-1-git-send-email-mathewm@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

These functions encode or decode ERTM control fields (extended or
enhanced) to or from the new l2cap_ctrl structure.

Acked-by: Marcel Holtmann <marcel@holtmann.org>
Acked-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
---
 net/bluetooth/l2cap_core.c |  113 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 113 insertions(+)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index e576c2f..68b3fb6 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -787,6 +787,117 @@ static inline void l2cap_send_rr_or_rnr(struct l2cap_chan *chan, u32 control)
 	l2cap_send_sframe(chan, control);
 }
 
+static u16 __pack_enhanced_control(struct l2cap_ctrl *control)
+{
+	u16 packed;
+
+	packed = control->reqseq << L2CAP_CTRL_REQSEQ_SHIFT;
+	packed |= control->final << L2CAP_CTRL_FINAL_SHIFT;
+
+	if (control->sframe) {
+		packed |= control->poll << L2CAP_CTRL_POLL_SHIFT;
+		packed |= control->super << L2CAP_CTRL_SUPER_SHIFT;
+		packed |= L2CAP_CTRL_FRAME_TYPE;
+	} else {
+		packed |= control->sar << L2CAP_CTRL_SAR_SHIFT;
+		packed |= control->txseq << L2CAP_CTRL_TXSEQ_SHIFT;
+	}
+
+	return packed;
+}
+
+static void __unpack_enhanced_control(u16 enh, struct l2cap_ctrl *control)
+{
+	control->reqseq = (enh & L2CAP_CTRL_REQSEQ) >> L2CAP_CTRL_REQSEQ_SHIFT;
+	control->final = (enh & L2CAP_CTRL_FINAL) >> L2CAP_CTRL_FINAL_SHIFT;
+
+	if (enh & L2CAP_CTRL_FRAME_TYPE) {
+		/* S-Frame */
+		control->sframe = 1;
+		control->poll = (enh & L2CAP_CTRL_POLL) >> L2CAP_CTRL_POLL_SHIFT;
+		control->super = (enh & L2CAP_CTRL_SUPERVISE) >> L2CAP_CTRL_SUPER_SHIFT;
+
+		control->sar = 0;
+		control->txseq = 0;
+	} else {
+		/* I-Frame */
+		control->sframe = 0;
+		control->sar = (enh & L2CAP_CTRL_SAR) >> L2CAP_CTRL_SAR_SHIFT;
+		control->txseq = (enh & L2CAP_CTRL_TXSEQ) >> L2CAP_CTRL_TXSEQ_SHIFT;
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
+	packed = control->reqseq << L2CAP_EXT_CTRL_REQSEQ_SHIFT;
+	packed |= control->final << L2CAP_EXT_CTRL_FINAL_SHIFT;
+
+	if (control->sframe) {
+		packed |= control->poll << L2CAP_EXT_CTRL_POLL_SHIFT;
+		packed |= control->super << L2CAP_EXT_CTRL_SUPER_SHIFT;
+		packed |= L2CAP_EXT_CTRL_FRAME_TYPE;
+	} else {
+		packed |= control->sar << L2CAP_EXT_CTRL_SAR_SHIFT;
+		packed |= control->txseq << L2CAP_EXT_CTRL_TXSEQ_SHIFT;
+	}
+
+	return packed;
+}
+
+static void __unpack_extended_control(u32 ext, struct l2cap_ctrl *control)
+{
+	control->reqseq = (ext & L2CAP_EXT_CTRL_REQSEQ) >> L2CAP_EXT_CTRL_REQSEQ_SHIFT;
+	control->final = (ext & L2CAP_EXT_CTRL_FINAL) >> L2CAP_EXT_CTRL_FINAL_SHIFT;
+
+	if (ext & L2CAP_EXT_CTRL_FRAME_TYPE) {
+		/* S-Frame */
+		control->sframe = 1;
+		control->poll = (ext & L2CAP_EXT_CTRL_POLL) >> L2CAP_EXT_CTRL_POLL_SHIFT;
+		control->super = (ext & L2CAP_EXT_CTRL_SUPERVISE) >> L2CAP_EXT_CTRL_SUPER_SHIFT;
+
+		control->sar = 0;
+		control->txseq = 0;
+	} else {
+		/* I-Frame */
+		control->sframe = 0;
+		control->sar = (ext & L2CAP_EXT_CTRL_SAR) >> L2CAP_EXT_CTRL_SAR_SHIFT;
+		control->txseq = (ext & L2CAP_EXT_CTRL_TXSEQ) >> L2CAP_EXT_CTRL_TXSEQ_SHIFT;
+
+		control->poll = 0;
+		control->super = 0;
+	}
+}
+
+static inline void __unpack_control(struct l2cap_chan *chan,
+				    struct sk_buff *skb)
+{
+	if (test_bit(FLAG_EXT_CTRL, &chan->flags)) {
+		__unpack_extended_control(get_unaligned_le32(skb->data),
+				       &bt_cb(skb)->control);
+	} else {
+		__unpack_enhanced_control(get_unaligned_le16(skb->data),
+				       &bt_cb(skb)->control);
+	}
+}
+
+static inline void __pack_control(struct l2cap_chan *chan,
+				  struct l2cap_ctrl *control,
+				  struct sk_buff *skb)
+{
+	if (test_bit(FLAG_EXT_CTRL, &chan->flags)) {
+		put_unaligned_le32(__pack_extended_control(control),
+				   skb->data + L2CAP_HDR_SIZE);
+	} else {
+		put_unaligned_le16(__pack_enhanced_control(control),
+				   skb->data + L2CAP_HDR_SIZE);
+	}
+}
+
 static inline int __l2cap_no_conn_pending(struct l2cap_chan *chan)
 {
 	return !test_bit(CONF_CONNECT_PEND, &chan->conf_state);
@@ -4363,6 +4474,8 @@ static int l2cap_ertm_data_rcv(struct l2cap_chan *chan, struct sk_buff *skb)
 	u16 req_seq;
 	int len, next_tx_seq_offset, req_seq_offset;
 
+	__unpack_control(chan, skb);
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
