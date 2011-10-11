Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv3 03/16] Bluetooth: EWS: adds ext control field bit mask
Date: Tue, 11 Oct 2011 13:37:43 +0300
Message-Id: <1318329476-30153-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1318329476-30153-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1318329476-30153-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Adds extended control field bit masks and rearrange defines to logical
groups: masks, flags and shift groups.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/l2cap.h |   41 +++++++++++++++++++++++++++++------------
 1 files changed, 29 insertions(+), 12 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 51998ff..fa7edab 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -109,18 +109,35 @@ struct l2cap_conninfo {
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
+#define L2CAP_CTRL_SAR			0xC000
+#define L2CAP_CTRL_REQSEQ		0x3F00
+#define L2CAP_CTRL_TXSEQ		0x007E
+#define L2CAP_CTRL_SUPERVISE		0x000C
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
+#define L2CAP_EXT_CTRL_TXSEQ		0xFFFC0000
+#define L2CAP_EXT_CTRL_SAR		0x00030000
+#define L2CAP_EXT_CTRL_SUPERVISE	0x00030000
+#define L2CAP_EXT_CTRL_REQSEQ		0x0000FFFC
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
 #define L2CAP_SUPER_RCV_READY           0x0000
-- 
1.7.4.1

