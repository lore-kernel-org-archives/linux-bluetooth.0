Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
Subject: [PATCH v3 22/22] monitor/a2dp: Decode LDAC capabilities
Date: Sun, 22 Nov 2015 21:20:34 +0100
Message-Id: <1448223634-23305-23-git-send-email-andrzej.kaczmarek@codecoup.pl>
In-Reply-To: <1448223634-23305-1-git-send-email-andrzej.kaczmarek@codecoup.pl>
References: <1448223634-23305-1-git-send-email-andrzej.kaczmarek@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

> ACL Data RX: Handle 12 flags 0x02 dlen 24
      Channel: 67 len 20 [PSM 25 mode 0] {chan 1}
      AVDTP: Get Capabilities (0x02) Response Accept (0x02) type 0x00 label 2 nosp 0
        Service Category: Media Transport (0x01)
        Service Category: Media Codec (0x07)
          Media Type: Audio (0x00)
          Media Codec: Non-A2DP (0xff)
            Vendor ID: Sony Corporation (0x0000012d)
            Vendor Specific Codec ID: LDAC (0x00aa)
              Unknown: 0x073c
        Service Category: Content Protection (0x04)
          Content Protection Type: SCMS-T (0x0002)

< ACL Data TX: Handle 12 flags 0x02 dlen 26
      Channel: 2753 len 22 [PSM 25 mode 0] {chan 1}
      AVDTP: Set Configuration (0x03) Command (0x00) type 0x00 label 5 nosp 0
        ACP SEID: 5
        INT SEID: 3
        Service Category: Media Transport (0x01)
        Service Category: Media Codec (0x07)
          Media Type: Audio (0x00)
          Media Codec: Non-A2DP (0xff)
            Vendor ID: Sony Corporation (0x0000012d)
            Vendor Specific Codec ID: LDAC (0x00aa0
              Unknown: 0x0104
        Service Category: Content Protection (0x04)
          Content Protection Type: SCMS-T (0x0002)
---
 monitor/a2dp.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/monitor/a2dp.c b/monitor/a2dp.c
index 5c9553e..94f9758 100644
--- a/monitor/a2dp.c
+++ b/monitor/a2dp.c
@@ -50,6 +50,8 @@
 /* Vendor Specific A2DP Codecs */
 #define APTX_VENDOR_ID		0x0000004f
 #define APTX_CODEC_ID		0x0001
+#define LDAC_VENDOR_ID		0x0000012d
+#define LDAC_CODEC_ID		0x00aa
 
 struct bit_desc {
 	uint8_t bit_num;
@@ -212,6 +214,8 @@ static const char *vndcodec2str(uint32_t vendor_id, uint16_t codec_id)
 {
 	if (vendor_id == APTX_VENDOR_ID && codec_id == APTX_CODEC_ID)
 		return "aptX";
+	else if (vendor_id == LDAC_VENDOR_ID && codec_id == LDAC_CODEC_ID)
+		return "LDAC";
 
 	return "Unknown";
 }
@@ -503,6 +507,20 @@ static bool codec_vendor_aptx_cap(uint8_t losc, struct l2cap_frame *frame)
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
 static bool codec_vendor_cap(uint8_t losc, struct l2cap_frame *frame)
 {
 	uint32_t vendor_id = 0;
@@ -524,8 +542,9 @@ static bool codec_vendor_cap(uint8_t losc, struct l2cap_frame *frame)
 
 	if (vendor_id == APTX_VENDOR_ID && codec_id == APTX_CODEC_ID)
 		return codec_vendor_aptx_cap(losc, frame);
+	else if (vendor_id == LDAC_VENDOR_ID && codec_id == LDAC_CODEC_ID)
+		return codec_vendor_ldac(losc, frame);
 
-	/* TODO: decode other codecs */
 	packet_hexdump(frame->data, losc);
 	l2cap_frame_pull(frame, frame, losc);
 
@@ -573,8 +592,9 @@ static bool codec_vendor_cfg(uint8_t losc, struct l2cap_frame *frame)
 
 	if (vendor_id == APTX_VENDOR_ID && codec_id == APTX_CODEC_ID)
 		return codec_vendor_aptx_cfg(losc, frame);
+	else if (vendor_id == LDAC_VENDOR_ID && codec_id == LDAC_CODEC_ID)
+		return codec_vendor_ldac(losc, frame);
 
-	/* TODO: decode other codecs */
 	packet_hexdump(frame->data, losc);
 	l2cap_frame_pull(frame, frame, losc);
 
-- 
2.6.2

