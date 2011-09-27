Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH hcidump 2/2] hcidump: parse extended control field in l2cap
Date: Tue, 27 Sep 2011 14:30:56 +0300
Message-Id: <1317123056-14235-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1317123056-14235-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1317123056-14235-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Adds support for parsing extended control field. Extended control
field may be used for ERTM and streaming mode (if EWS specified).
added fixes for P-bit
---
 parser/l2cap.c |  120 +++++++++++++++++++++++++++++++++++++++++++-------------
 1 files changed, 92 insertions(+), 28 deletions(-)

diff --git a/parser/l2cap.c b/parser/l2cap.c
index d3d3b1c..650276e 100644
--- a/parser/l2cap.c
+++ b/parser/l2cap.c
@@ -54,6 +54,9 @@ typedef struct {
 } cid_info;
 #define CID_TABLE_SIZE 20
 
+/* Specify whether to use extended ctrl field */
+static int ext_ctrl = 0;
+
 static cid_info cid_table[2][CID_TABLE_SIZE];
 
 #define SCID cid_table[0]
@@ -560,6 +563,7 @@ static void conf_opt(int level, void *ptr, int len, int in, uint16_t handle,
 			printf("EWS");
 			if (h->len > 0)
 				printf(" %d", get_val(h->val, h->len));
+			ext_ctrl = 1;
 			break;
 
 		default:
@@ -761,6 +765,71 @@ static inline void info_rsp(int level, l2cap_cmd_hdr *cmd, struct frame *frm)
 	}
 }
 
+static void l2cap_ctrl_ext_parse(int level, struct frame *frm, uint32_t ctrl)
+{
+	p_indent(level, frm);
+
+	printf("%s:", ctrl & L2CAP_EXT_CTRL_FRAME_TYPE ? "S-frame" : "I-frame");
+
+	if (ctrl & L2CAP_EXT_CTRL_FRAME_TYPE) {
+		printf(" %s", supervisory2str((ctrl & L2CAP_EXT_CTRL_SUPERVISE_MASK) >>
+					L2CAP_EXT_CTRL_SUPER_SHIFT));
+
+		if (ctrl & L2CAP_EXT_CTRL_POLL)
+			printf(" P-bit");
+	} else {
+		uint8_t sar = (ctrl & L2CAP_EXT_CTRL_SAR_MASK) >>
+			L2CAP_EXT_CTRL_SAR_SHIFT;
+		printf(" %s", sar2str(sar));
+		if (sar == L2CAP_SAR_START) {
+			uint16_t len;
+			len = btohs(bt_get_unaligned((uint16_t *) frm->ptr));
+			frm->ptr += L2CAP_SDULEN_SIZE;
+			frm->len -= L2CAP_SDULEN_SIZE;
+			printf(" (len %d)", len);
+		}
+		printf(" TxSeq %d", (ctrl & L2CAP_EXT_CTRL_TXSEQ_MASK) >>
+				L2CAP_EXT_CTRL_TXSEQ_SHIFT);
+	}
+
+	printf(" ReqSeq %d", (ctrl & L2CAP_EXT_CTRL_REQSEQ_MASK) >>
+			L2CAP_EXT_CTRL_REQSEQ_SHIFT);
+
+	if (ctrl & L2CAP_EXT_CTRL_FINAL)
+		printf(" F-bit");
+}
+
+static void l2cap_ctrl_parse(int level, struct frame *frm, uint32_t ctrl)
+{
+	p_indent(level, frm);
+
+	printf("%s:", ctrl & L2CAP_CTRL_FRAME_TYPE ? "S-frame" : "I-frame");
+
+	if (ctrl & 0x01) {
+		printf(" %s", supervisory2str((ctrl & L2CAP_CTRL_SUPERVISE_MASK) >>
+					L2CAP_CTRL_SUPER_SHIFT));
+
+		if (ctrl & L2CAP_CTRL_POLL)
+			printf(" P-bit");
+	} else {
+		uint8_t sar = (ctrl & L2CAP_CTRL_SAR_MASK) >> L2CAP_CTRL_SAR_SHIFT;
+		printf(" %s", sar2str(sar));
+		if (sar == L2CAP_SAR_START) {
+			uint16_t len;
+			len = btohs(bt_get_unaligned((uint16_t *) frm->ptr));
+			frm->ptr += L2CAP_SDULEN_SIZE;
+			frm->len -= L2CAP_SDULEN_SIZE;
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
 static void l2cap_parse(int level, struct frame *frm)
 {
 	l2cap_hdr *hdr = (void *)frm->ptr;
@@ -872,48 +941,43 @@ static void l2cap_parse(int level, struct frame *frm)
 
 		uint8_t mode = get_mode(!frm->in, frm->handle, cid);
 		uint16_t psm = get_psm(!frm->in, frm->handle, cid);
-		uint16_t ctrl = 0, fcs = 0;
-		uint32_t proto;
+		uint16_t fcs = 0;
+		uint32_t proto, ctrl = 0;
 
 		frm->cid = cid;
 		frm->num = get_num(!frm->in, frm->handle, cid);
 
 		if (mode > 0) {
-			ctrl = btohs(bt_get_unaligned((uint16_t *) frm->ptr));
-			frm->ptr += 2;
-			frm->len -= 4;
+			if (ext_ctrl) {
+				ctrl = get_val(frm->ptr, 4);
+				frm->ptr += 4;
+				frm->len -= 6;
+			} else {
+				ctrl = get_val(frm->ptr, 2);
+				frm->ptr += 2;
+				frm->len -= 4;
+			}
 			fcs = btohs(bt_get_unaligned((uint16_t *) (frm->ptr + frm->len)));
 		}
 
 		if (!p_filter(FILT_L2CAP)) {
 			p_indent(level, frm);
 			printf("L2CAP(d): cid 0x%4.4x len %d", cid, dlen);
-			if (mode > 0)
-				printf(" ctrl 0x%4.4x fcs 0x%4.4x", ctrl, fcs);
+			if (mode > 0) {
+				if (ext_ctrl)
+					printf(" ext_ctrl 0x%8.8x fcs 0x%4.4x", ctrl, fcs);
+				else
+					printf(" ctrl 0x%4.4x fcs 0x%4.4x", ctrl, fcs);
+			}
+
 			printf(" [psm %d]\n", psm);
 			level++;
 			if (mode > 0) {
-				p_indent(level, frm);
-				printf("%s:", ctrl & 0x01 ? "S-frame" : "I-frame");
-				if (ctrl & 0x01) {
-					printf(" %s", supervisory2str((ctrl & 0x0c) >> 2));
-				} else {
-					uint8_t sar = (ctrl & 0xc000) >> 14;
-					printf(" %s", sar2str(sar));
-					if (sar == 1) {
-						uint16_t len;
-						len = btohs(bt_get_unaligned((uint16_t *) frm->ptr));
-						frm->ptr += 2;
-						frm->len -= 2;
-						printf(" (len %d)", len);
-					}
-					printf(" TxSeq %d", (ctrl & 0x7e) >> 1);
-				}
-				printf(" ReqSeq %d", (ctrl & 0x3f00) >> 8);
-				if (ctrl & 0x80)
-					printf(" F-bit");
-				if (ctrl & 0x10)
-					printf(" P-bit");
+				if (ext_ctrl)
+					l2cap_ctrl_ext_parse(level, frm, ctrl);
+				else
+					l2cap_ctrl_parse(level, frm, ctrl);
+
 				printf("\n");
 			}
 		}
-- 
1.7.4.1

