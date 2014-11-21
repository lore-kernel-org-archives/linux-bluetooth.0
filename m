Return-Path: <cyrus@holtmann.org>
From: Vikrampal Yadav <vikram.pal@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, d.kasatkin@samsung.com,
	vikram.pal@samsung.com, cpgs@samsung.com
Subject: [PATCH 5/7] monitor: Add support for parsing L2CAP extended control
 field
Date: Fri, 21 Nov 2014 19:17:43 +0530
Message-id: <1416577665-21876-6-git-send-email-vikram.pal@samsung.com>
In-reply-to: <1416577665-21876-1-git-send-email-vikram.pal@samsung.com>
References: <1416577665-21876-1-git-send-email-vikram.pal@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Support for parsing L2CAP extended control field added.
---
 monitor/l2cap.c | 111 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 111 insertions(+)

diff --git a/monitor/l2cap.c b/monitor/l2cap.c
index 427c4a2..f5ee0cd 100644
--- a/monitor/l2cap.c
+++ b/monitor/l2cap.c
@@ -44,6 +44,48 @@
 #include "avctp.h"
 #include "rfcomm.h"
 
+/* L2CAP Control Field bit masks */
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
+
+/* L2CAP Supervisory Function */
+#define L2CAP_SUPER_RR		0x00
+#define L2CAP_SUPER_REJ		0x01
+#define L2CAP_SUPER_RNR		0x02
+#define L2CAP_SUPER_SREJ	0x03
+
+/* L2CAP Segmentation and Reassembly */
+#define L2CAP_SAR_UNSEGMENTED 	0x00
+#define L2CAP_SAR_START		0x01
+#define L2CAP_SAR_END		0x02
+#define L2CAP_SAR_CONTINUE	0x03
+
 #define MAX_CHAN 64
 
 struct chan_data {
@@ -307,6 +349,73 @@ static uint8_t get_ext_ctrl(const struct l2cap_frame *frame)
 	return 0;
 }
 
+static char *sar2str(uint8_t sar)
+{
+	switch (sar) {
+	case L2CAP_SAR_UNSEGMENTED:
+		return "Unsegmented";
+	case L2CAP_SAR_START:
+		return "Start";
+	case L2CAP_SAR_END:
+		return "End";
+	case L2CAP_SAR_CONTINUE:
+		return "Continuation";
+	default:
+		return "Bad SAR";
+	}
+}
+
+static char *supervisory2str(uint8_t supervisory)
+{
+	switch (supervisory) {
+	case L2CAP_SUPER_RR:
+		return "Receiver Ready (RR)";
+	case L2CAP_SUPER_REJ:
+		return "Reject (REJ)";
+	case L2CAP_SUPER_RNR:
+		return "Receiver Not Ready (RNR)";
+	case L2CAP_SUPER_SREJ:
+		return "Select Reject (SREJ)";
+	default:
+		return "Bad Supervisory";
+	}
+}
+
+static void l2cap_ctrl_ext_parse(struct l2cap_frame *frame, uint32_t ctrl)
+{
+	printf("      %s:",
+		ctrl & L2CAP_EXT_CTRL_FRAME_TYPE ? "S-frame" : "I-frame");
+
+	if (ctrl & L2CAP_EXT_CTRL_FRAME_TYPE) {
+		printf(" %s",
+		supervisory2str((ctrl & L2CAP_EXT_CTRL_SUPERVISE_MASK) >>
+						L2CAP_EXT_CTRL_SUPER_SHIFT));
+
+		if (ctrl & L2CAP_EXT_CTRL_POLL)
+			printf(" P-bit");
+	} else {
+		uint8_t sar = (ctrl & L2CAP_EXT_CTRL_SAR_MASK) >>
+						L2CAP_EXT_CTRL_SAR_SHIFT;
+		printf(" %s", sar2str(sar));
+		if (sar == L2CAP_SAR_START) {
+			uint16_t len;
+
+			if (!l2cap_frame_get_le16(frame, &len))
+				return;
+
+			printf(" (len %d)", len);
+		}
+		printf(" TxSeq %d", (ctrl & L2CAP_EXT_CTRL_TXSEQ_MASK) >>
+						L2CAP_EXT_CTRL_TXSEQ_SHIFT);
+	}
+
+	printf(" ReqSeq %d", (ctrl & L2CAP_EXT_CTRL_REQSEQ_MASK) >>
+						L2CAP_EXT_CTRL_REQSEQ_SHIFT);
+
+	if (ctrl & L2CAP_EXT_CTRL_FINAL)
+		printf(" F-bit");
+}
+
 #define MAX_INDEX 16
 
 struct index_data {
@@ -2707,6 +2816,8 @@ static void l2cap_frame(uint16_t index, bool in, uint16_t handle,
 						" [PSM %d mode %d] {chan %d}",
 						cid, size, ctrl32, frame.psm,
 						frame.mode, frame.chan);
+
+				l2cap_ctrl_ext_parse(&frame, ctrl32);
 			} else {
 				if (!l2cap_frame_get_le16(&frame, &ctrl16))
 					return;
-- 
1.9.1

