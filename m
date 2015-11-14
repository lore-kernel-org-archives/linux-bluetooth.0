Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
Subject: [PATCH 22/22] monitor/a2dp: Decode LDAC capabilities
Date: Sat, 14 Nov 2015 14:44:39 +0100
Message-Id: <1447508679-21798-23-git-send-email-andrzej.kaczmarek@codecoup.pl>
In-Reply-To: <1447508679-21798-1-git-send-email-andrzej.kaczmarek@codecoup.pl>
References: <1447508679-21798-1-git-send-email-andrzej.kaczmarek@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 monitor/a2dp.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/monitor/a2dp.c b/monitor/a2dp.c
index ab93097..86ae39d 100644
--- a/monitor/a2dp.c
+++ b/monitor/a2dp.c
@@ -50,6 +50,8 @@
 /* Vendor Specific A2DP Codecs */
 #define APTX_VENDOR_ID		0x0000004f
 #define APTX_CODEC_ID		0x0001
+#define LDAC_VENDOR_ID		0x0000012d
+#define LDAC_CODEC_ID		0x00aa
 
 struct bit_desc {
 	uint8_t bit;
@@ -199,6 +201,8 @@ static const char *vndcodec2str(uint32_t vendor_id, uint16_t codec_id)
 {
 	if (vendor_id == APTX_VENDOR_ID && codec_id == APTX_CODEC_ID)
 		return "aptX";
+	else if (vendor_id == LDAC_VENDOR_ID && codec_id == LDAC_CODEC_ID)
+		return "LDAC";
 
 	return "Unknown";
 }
@@ -351,6 +355,20 @@ static bool codec_vendor_aptx(uint8_t losc, struct l2cap_frame *frame)
 	return true;
 }
 
+static bool codec_vendor_ldac(uint8_t losc, struct l2cap_frame *frame)
+{
+	uint16_t cap = 0;
+
+	if (losc != 2)
+		return false;
+
+	l2cap_frame_get_le16(frame, &cap);
+
+	print_field("%*cUnknown: 0x%04x", BASE_INDENT + 2, ' ', cap);
+
+	return true;
+}
+
 static bool codec_vendor(uint8_t losc, struct l2cap_frame *frame)
 {
 	uint32_t vendor_id = 0;
@@ -373,6 +391,8 @@ static bool codec_vendor(uint8_t losc, struct l2cap_frame *frame)
 
 	if (vendor_id == APTX_VENDOR_ID && codec_id == APTX_CODEC_ID) {
 		codec_vendor_aptx(losc, frame);
+	} else if (vendor_id == LDAC_VENDOR_ID && codec_id == LDAC_CODEC_ID) {
+		codec_vendor_ldac(losc, frame);
 	} else {
 		packet_hexdump(frame->data, losc);
 		l2cap_frame_pull(frame, frame, losc);
-- 
2.6.2

