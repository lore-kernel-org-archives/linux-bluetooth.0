Return-Path: <cyrus@holtmann.org>
From: Mat Martineau <mathewm@codeaurora.org>
To: linux-bluetooth@vger.kernel.org,
	gustavo@padovan.org,
	marcel@holtmann.org
Cc: pkrystad@codeaurora.org,
	andrei.emeltchenko.news@gmail.com
Subject: [RFC 5/8] Bluetooth: Move recently-added ERTM header unpacking functions
Date: Wed, 25 Apr 2012 16:36:16 -0700
Message-Id: <1335396979-11692-6-git-send-email-mathewm@codeaurora.org>
In-Reply-To: <1335396979-11692-1-git-send-email-mathewm@codeaurora.org>
References: <1335396979-11692-1-git-send-email-mathewm@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Moving these functions simplifies future patches by eliminating
forward declarations, makes future patches easier to review, and
better preserves 'git blame' information.

Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
---
 net/bluetooth/l2cap_core.c |  120 ++++++++++++++++++++++----------------------
 1 file changed, 60 insertions(+), 60 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 3221f17..6aefeaa 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -725,6 +725,66 @@ static void l2cap_do_send(struct l2cap_chan *chan, struct sk_buff *skb)
 	hci_send_acl(chan->conn->hchan, skb, flags);
 }
 
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
+					  &bt_cb(skb)->control);
+	} else {
+		__unpack_enhanced_control(get_unaligned_le16(skb->data),
+					  &bt_cb(skb)->control);
+	}
+}
+
 static u32 __pack_extended_control(struct l2cap_ctrl *control)
 {
 	u32 packed;
@@ -838,66 +898,6 @@ static inline void l2cap_send_rr_or_rnr(struct l2cap_chan *chan, u32 control)
 	l2cap_send_sframe(chan, control);
 }
 
-static void __unpack_enhanced_control(u16 enh, struct l2cap_ctrl *control)
-{
-	control->reqseq = (enh & L2CAP_CTRL_REQSEQ) >> L2CAP_CTRL_REQSEQ_SHIFT;
-	control->final = (enh & L2CAP_CTRL_FINAL) >> L2CAP_CTRL_FINAL_SHIFT;
-
-	if (enh & L2CAP_CTRL_FRAME_TYPE) {
-		/* S-Frame */
-		control->sframe = 1;
-		control->poll = (enh & L2CAP_CTRL_POLL) >> L2CAP_CTRL_POLL_SHIFT;
-		control->super = (enh & L2CAP_CTRL_SUPERVISE) >> L2CAP_CTRL_SUPER_SHIFT;
-
-		control->sar = 0;
-		control->txseq = 0;
-	} else {
-		/* I-Frame */
-		control->sframe = 0;
-		control->sar = (enh & L2CAP_CTRL_SAR) >> L2CAP_CTRL_SAR_SHIFT;
-		control->txseq = (enh & L2CAP_CTRL_TXSEQ) >> L2CAP_CTRL_TXSEQ_SHIFT;
-
-		control->poll = 0;
-		control->super = 0;
-	}
-}
-
-static void __unpack_extended_control(u32 ext, struct l2cap_ctrl *control)
-{
-	control->reqseq = (ext & L2CAP_EXT_CTRL_REQSEQ) >> L2CAP_EXT_CTRL_REQSEQ_SHIFT;
-	control->final = (ext & L2CAP_EXT_CTRL_FINAL) >> L2CAP_EXT_CTRL_FINAL_SHIFT;
-
-	if (ext & L2CAP_EXT_CTRL_FRAME_TYPE) {
-		/* S-Frame */
-		control->sframe = 1;
-		control->poll = (ext & L2CAP_EXT_CTRL_POLL) >> L2CAP_EXT_CTRL_POLL_SHIFT;
-		control->super = (ext & L2CAP_EXT_CTRL_SUPERVISE) >> L2CAP_EXT_CTRL_SUPER_SHIFT;
-
-		control->sar = 0;
-		control->txseq = 0;
-	} else {
-		/* I-Frame */
-		control->sframe = 0;
-		control->sar = (ext & L2CAP_EXT_CTRL_SAR) >> L2CAP_EXT_CTRL_SAR_SHIFT;
-		control->txseq = (ext & L2CAP_EXT_CTRL_TXSEQ) >> L2CAP_EXT_CTRL_TXSEQ_SHIFT;
-
-		control->poll = 0;
-		control->super = 0;
-	}
-}
-
-static inline void __unpack_control(struct l2cap_chan *chan,
-				    struct sk_buff *skb)
-{
-	if (test_bit(FLAG_EXT_CTRL, &chan->flags)) {
-		__unpack_extended_control(get_unaligned_le32(skb->data),
-					  &bt_cb(skb)->control);
-	} else {
-		__unpack_enhanced_control(get_unaligned_le16(skb->data),
-					  &bt_cb(skb)->control);
-	}
-}
-
 static inline int __l2cap_no_conn_pending(struct l2cap_chan *chan)
 {
 	return !test_bit(CONF_CONNECT_PEND, &chan->conf_state);
-- 
1.7.10

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
