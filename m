Return-Path: <cyrus@holtmann.org>
From: Mat Martineau <mathewm@codeaurora.org>
To: linux-bluetooth@vger.kernel.org,
	gustavo@padovan.org,
	marcel@holtmann.org
Cc: pkrystad@codeaurora.org,
	andrei.emeltchenko.news@gmail.com
Subject: [RFC 4/8] Bluetooth: Move recently-added ERTM header packing functions
Date: Wed, 25 Apr 2012 16:36:15 -0700
Message-Id: <1335396979-11692-5-git-send-email-mathewm@codeaurora.org>
In-Reply-To: <1335396979-11692-1-git-send-email-mathewm@codeaurora.org>
References: <1335396979-11692-1-git-send-email-mathewm@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Moving these functions simplifies future patches by eliminating
forward declarations, makes future patches easier to review, and
better preserves 'git blame' information.

Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
---
 net/bluetooth/l2cap_core.c |  102 ++++++++++++++++++++++----------------------
 1 file changed, 51 insertions(+), 51 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 9a33f21..3221f17 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -725,6 +725,57 @@ static void l2cap_do_send(struct l2cap_chan *chan, struct sk_buff *skb)
 	hci_send_acl(chan->conn->hchan, skb, flags);
 }
 
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
 static inline void l2cap_send_sframe(struct l2cap_chan *chan, u32 control)
 {
 	struct sk_buff *skb;
@@ -787,25 +838,6 @@ static inline void l2cap_send_rr_or_rnr(struct l2cap_chan *chan, u32 control)
 	l2cap_send_sframe(chan, control);
 }
 
-static u16 __pack_enhanced_control(struct l2cap_ctrl *control)
-{
-	u16 packed;
-
-	packed = control->reqseq << L2CAP_CTRL_REQSEQ_SHIFT;
-	packed |= control->final << L2CAP_CTRL_FINAL_SHIFT;
-
-	if (control->sframe) {
-		packed |= control->poll << L2CAP_CTRL_POLL_SHIFT;
-		packed |= control->super << L2CAP_CTRL_SUPER_SHIFT;
-		packed |= L2CAP_CTRL_FRAME_TYPE;
-	} else {
-		packed |= control->sar << L2CAP_CTRL_SAR_SHIFT;
-		packed |= control->txseq << L2CAP_CTRL_TXSEQ_SHIFT;
-	}
-
-	return packed;
-}
-
 static void __unpack_enhanced_control(u16 enh, struct l2cap_ctrl *control)
 {
 	control->reqseq = (enh & L2CAP_CTRL_REQSEQ) >> L2CAP_CTRL_REQSEQ_SHIFT;
@@ -830,25 +862,6 @@ static void __unpack_enhanced_control(u16 enh, struct l2cap_ctrl *control)
 	}
 }
 
-static u32 __pack_extended_control(struct l2cap_ctrl *control)
-{
-	u32 packed;
-
-	packed = control->reqseq << L2CAP_EXT_CTRL_REQSEQ_SHIFT;
-	packed |= control->final << L2CAP_EXT_CTRL_FINAL_SHIFT;
-
-	if (control->sframe) {
-		packed |= control->poll << L2CAP_EXT_CTRL_POLL_SHIFT;
-		packed |= control->super << L2CAP_EXT_CTRL_SUPER_SHIFT;
-		packed |= L2CAP_EXT_CTRL_FRAME_TYPE;
-	} else {
-		packed |= control->sar << L2CAP_EXT_CTRL_SAR_SHIFT;
-		packed |= control->txseq << L2CAP_EXT_CTRL_TXSEQ_SHIFT;
-	}
-
-	return packed;
-}
-
 static void __unpack_extended_control(u32 ext, struct l2cap_ctrl *control)
 {
 	control->reqseq = (ext & L2CAP_EXT_CTRL_REQSEQ) >> L2CAP_EXT_CTRL_REQSEQ_SHIFT;
@@ -885,19 +898,6 @@ static inline void __unpack_control(struct l2cap_chan *chan,
 	}
 }
 
-static inline void __pack_control(struct l2cap_chan *chan,
-				  struct l2cap_ctrl *control,
-				  struct sk_buff *skb)
-{
-	if (test_bit(FLAG_EXT_CTRL, &chan->flags)) {
-		put_unaligned_le32(__pack_extended_control(control),
-				   skb->data + L2CAP_HDR_SIZE);
-	} else {
-		put_unaligned_le16(__pack_enhanced_control(control),
-				   skb->data + L2CAP_HDR_SIZE);
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
