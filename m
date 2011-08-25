Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] definitions for decoding extended ctrl and window size
Date: Thu, 25 Aug 2011 13:34:00 +0300
Message-Id: <1314268440-3488-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Definitions are needed to decode extended window size option
and extended control field by user space tools like hcidump.
Those will be added also to kernel soon so l2cap header will
be in sync.
---
 lib/l2cap.h |   45 +++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 45 insertions(+), 0 deletions(-)

diff --git a/lib/l2cap.h b/lib/l2cap.h
index 55fe88b..47b3dc3 100644
--- a/lib/l2cap.h
+++ b/lib/l2cap.h
@@ -95,6 +95,50 @@ struct l2cap_conninfo {
 #define L2CAP_FEAT_EXT_WINDOW	0x00000100
 #define L2CAP_FEAT_UCD		0x00000200
 
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
+#define L2CAP_SAR_UNSEGMENTED	0x00
+#define L2CAP_SAR_START		0x01
+#define L2CAP_SAR_END		0x02
+#define L2CAP_SAR_CONTINUE	0x03
+
+#define L2CAP_SDULEN_SIZE	2
+
 /* L2CAP structures */
 typedef struct {
 	uint16_t	len;
@@ -175,6 +219,7 @@ typedef struct {
 #define L2CAP_CONF_RFC		0x04
 #define L2CAP_CONF_FCS		0x05
 #define L2CAP_CONF_EFS		0x06
+#define L2CAP_CONF_EWS		0x07
 
 #define L2CAP_CONF_MAX_SIZE	22
 
-- 
1.7.4.1

