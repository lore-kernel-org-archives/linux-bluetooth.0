Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 1/2] BlueZ: l2test: Use defined L2CAP extended feature mask
Date: Wed,  6 Jul 2011 10:48:35 +0300
Message-Id: <1309938516-510-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Sync l2cap.h from kernel concerning L2CAP extended feature mask.
---
 lib/l2cap.h   |   12 ++++++++++++
 test/l2test.c |   20 ++++++++++----------
 2 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/lib/l2cap.h b/lib/l2cap.h
index e59cfdd..bc87f72 100644
--- a/lib/l2cap.h
+++ b/lib/l2cap.h
@@ -83,6 +83,18 @@ struct l2cap_conninfo {
 #define L2CAP_INFO_REQ		0x0a
 #define L2CAP_INFO_RSP		0x0b
 
+/* L2CAP extended feature mask */
+#define L2CAP_FEAT_FLOWCTL	0x00000001
+#define L2CAP_FEAT_RETRANS	0x00000002
+#define L2CAP_FEAT_BIDIR_QOS	0x00000004
+#define L2CAP_FEAT_ERTM		0x00000008
+#define L2CAP_FEAT_STREAMING	0x00000010
+#define L2CAP_FEAT_FCS		0x00000020
+#define L2CAP_FEAT_EXT_FLOW	0x00000040
+#define L2CAP_FEAT_FIXED_CHAN	0x00000080
+#define L2CAP_FEAT_EXT_WINDOW	0x00000100
+#define L2CAP_FEAT_UCD		0x00000200
+
 /* L2CAP structures */
 typedef struct {
 	uint16_t	len;
diff --git a/test/l2test.c b/test/l2test.c
index 3ac332f..3b606d2 100644
--- a/test/l2test.c
+++ b/test/l2test.c
@@ -948,25 +948,25 @@ static void info_request(char *svr)
 	case 0x0000:
 		memcpy(&mask, rsp->data, sizeof(mask));
 		printf("Extended feature mask is 0x%04x\n", btohl(mask));
-		if (mask & 0x01)
+		if (mask & L2CAP_FEAT_FLOWCTL)
 			printf("  Flow control mode\n");
-		if (mask & 0x02)
+		if (mask & L2CAP_FEAT_RETRANS)
 			printf("  Retransmission mode\n");
-		if (mask & 0x04)
+		if (mask & L2CAP_FEAT_BIDIR_QOS)
 			printf("  Bi-directional QoS\n");
-		if (mask & 0x08)
+		if (mask & L2CAP_FEAT_ERTM)
 			printf("  Enhanced Retransmission mode\n");
-		if (mask & 0x10)
+		if (mask & L2CAP_FEAT_STREAMING)
 			printf("  Streaming mode\n");
-		if (mask & 0x20)
+		if (mask & L2CAP_FEAT_FCS)
 			printf("  FCS Option\n");
-		if (mask & 0x40)
+		if (mask & L2CAP_FEAT_EXT_FLOW)
 			printf("  Extended Flow Specification\n");
-		if (mask & 0x80)
+		if (mask & L2CAP_FEAT_FIXED_CHAN)
 			printf("  Fixed Channels\n");
-		if (mask & 0x0100)
+		if (mask & L2CAP_FEAT_EXT_WINDOW)
 			printf("  Extended Window Size\n");
-		if (mask & 0x0200)
+		if (mask & L2CAP_FEAT_UCD)
 			printf("  Unicast Connectionless Data Reception\n");
 		break;
 	case 0x0001:
-- 
1.7.4.1

