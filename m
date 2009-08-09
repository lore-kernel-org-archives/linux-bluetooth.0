Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <gustavo@las.ic.unicamp.br>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, gustavo@padovan.org
Subject: [PATCH 4/4] Dump the FCS Option while configuring devices.
Date: Sun,  9 Aug 2009 05:41:09 -0300
Message-Id: <1249807269-21494-5-git-send-email-gustavo@las.ic.unicamp.br>
In-Reply-To: <1249807269-21494-4-git-send-email-gustavo@las.ic.unicamp.br>
References: <1249807269-21494-1-git-send-email-gustavo@las.ic.unicamp.br>
 <1249807269-21494-2-git-send-email-gustavo@las.ic.unicamp.br>
 <1249807269-21494-3-git-send-email-gustavo@las.ic.unicamp.br>
 <1249807269-21494-4-git-send-email-gustavo@las.ic.unicamp.br>
List-ID: <linux-bluetooth.vger.kernel.org>

Add support to show the FCS Option value in a configuration request into
the L2CAP layer.
---
 parser/l2cap.c |   29 +++++++++++++++++++++++++++++
 1 files changed, 29 insertions(+), 0 deletions(-)

diff --git a/parser/l2cap.c b/parser/l2cap.c
index 3bcb531..436f039 100644
--- a/parser/l2cap.c
+++ b/parser/l2cap.c
@@ -315,6 +315,18 @@ static char *mode2str(uint8_t mode)
 	}
 }
 
+static char *fcs2str(uint8_t fcs)
+{
+	switch (fcs) {
+	case 0x00:
+		return "No FCS";
+	case 0x01:
+		return "CRC16 Check";
+	default:
+		return "Reserved";
+	}
+}
+
 static char *sar2str(uint8_t sar)
 {
 	switch (sar) {
@@ -446,6 +458,16 @@ static void conf_rfc(void *ptr, int len, int in, uint16_t cid)
 	printf(")");
 }
 
+static void conf_fcs(void *ptr, int len)
+{
+	uint8_t fcs;
+
+	fcs = *((uint8_t *) ptr);
+	printf("FCS Option");
+	if (len > 0)
+		printf(" 0x%2.2x (%s)", fcs, fcs2str(fcs));
+}
+
 static void conf_opt(int level, void *ptr, int len, int in, uint16_t cid)
 {
 	p_indent(level, 0);
@@ -482,6 +504,10 @@ static void conf_opt(int level, void *ptr, int len, int in, uint16_t cid)
 			conf_rfc(h->val, h->len, in, cid);
 			break;
 
+		case L2CAP_CONF_FCS:
+			conf_fcs(h->val, h->len);
+			break;
+
 		default:
 			printf("Unknown (type %2.2x, len %d)", h->type & 0x7f, h->len);
 			break;
@@ -514,6 +540,9 @@ static void conf_list(int level, uint8_t *list, int len)
 		case L2CAP_CONF_RFC:
 			printf("RFC ");
 			break;
+		case L2CAP_CONF_FCS:
+			printf("FCS ");
+			break;
 		default:
 			printf("%2.2x ", list[i] & 0x7f);
 			break;
-- 
1.6.3.3
