Return-Path: <cyrus@holtmann.org>
From: Vikrampal Yadav <vikram.pal@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, vikram.pal@samsung.com, cpgs@samsung.com
Subject: [PATCH 5/6] monitor: Add support for parsing L2CAP control field
Date: Wed, 07 Jan 2015 13:53:19 +0530
Message-id: <1420619000-24211-6-git-send-email-vikram.pal@samsung.com>
In-reply-to: <1420619000-24211-1-git-send-email-vikram.pal@samsung.com>
References: <1420619000-24211-1-git-send-email-vikram.pal@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Support for parsing L2CAP control field added.
---
 monitor/l2cap.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/monitor/l2cap.c b/monitor/l2cap.c
index 17104e2..19cb0a2 100644
--- a/monitor/l2cap.c
+++ b/monitor/l2cap.c
@@ -416,6 +416,38 @@ static void l2cap_ctrl_ext_parse(struct l2cap_frame *frame, uint32_t ctrl)
 		printf(" F-bit");
 }
 
+static void l2cap_ctrl_parse(struct l2cap_frame *frame, uint32_t ctrl)
+{
+	printf("      %s:",
+			ctrl & L2CAP_CTRL_FRAME_TYPE ? "S-frame" : "I-frame");
+
+	if (ctrl & 0x01) {
+		printf(" %s",
+			supervisory2str((ctrl & L2CAP_CTRL_SUPERVISE_MASK) >>
+						L2CAP_CTRL_SUPER_SHIFT));
+
+		if (ctrl & L2CAP_CTRL_POLL)
+			printf(" P-bit");
+	} else {
+		uint8_t sar = (ctrl & L2CAP_CTRL_SAR_MASK) >> L2CAP_CTRL_SAR_SHIFT;
+		printf(" %s", sar2str(sar));
+		if (sar == L2CAP_SAR_START) {
+			uint16_t len;
+
+			if (!l2cap_frame_get_le16(frame, &len))
+				return;
+
+			printf(" (len %d)", len);
+		}
+		printf(" TxSeq %d", (ctrl & L2CAP_CTRL_TXSEQ_MASK) >> L2CAP_CTRL_TXSEQ_SHIFT);
+	}
+
+	printf(" ReqSeq %d", (ctrl & L2CAP_CTRL_REQSEQ_MASK) >> L2CAP_CTRL_REQSEQ_SHIFT);
+
+	if (ctrl & L2CAP_CTRL_FINAL)
+		printf(" F-bit");
+}
+
 #define MAX_INDEX 16
 
 struct index_data {
@@ -2907,6 +2939,8 @@ static void l2cap_frame(uint16_t index, bool in, uint16_t handle,
 						" [PSM %d mode %d] {chan %d}",
 						cid, size, ctrl16, frame.psm,
 						frame.mode, frame.chan);
+
+				l2cap_ctrl_parse(&frame, ctrl16);
 			}
 
 			printf("\n");
-- 
1.9.1

