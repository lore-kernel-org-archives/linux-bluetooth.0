Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
Subject: [PATCH 21/22] monitor/a2dp: Decode aptX capabilities
Date: Sat, 14 Nov 2015 14:44:38 +0100
Message-Id: <1447508679-21798-22-git-send-email-andrzej.kaczmarek@codecoup.pl>
In-Reply-To: <1447508679-21798-1-git-send-email-andrzej.kaczmarek@codecoup.pl>
References: <1447508679-21798-1-git-send-email-andrzej.kaczmarek@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 monitor/a2dp.c | 77 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/monitor/a2dp.c b/monitor/a2dp.c
index b6b01ee..ab93097 100644
--- a/monitor/a2dp.c
+++ b/monitor/a2dp.c
@@ -47,6 +47,10 @@
 #define A2DP_CODEC_ATRAC	0x04
 #define A2DP_CODEC_VENDOR	0xff
 
+/* Vendor Specific A2DP Codecs */
+#define APTX_VENDOR_ID		0x0000004f
+#define APTX_CODEC_ID		0x0001
+
 struct bit_desc {
 	uint8_t bit;
 	const char *str;
@@ -166,6 +170,20 @@ static const struct bit_desc aac_channels_table[] = {
 	{ }
 };
 
+static const struct bit_desc aptx_frequency_table[] = {
+	{  7, "16000" },
+	{  6, "32000" },
+	{  5, "44100" },
+	{  4, "48000" },
+	{ }
+};
+
+static const struct bit_desc aptx_channel_mode_table[] = {
+	{  0, "Mono" },
+	{  1, "Stereo" },
+	{ }
+};
+
 static void print_bit_table(uint8_t indent, uint32_t value,
 						const struct bit_desc *table)
 {
@@ -177,6 +195,14 @@ static void print_bit_table(uint8_t indent, uint32_t value,
 	}
 }
 
+static const char *vndcodec2str(uint32_t vendor_id, uint16_t codec_id)
+{
+	if (vendor_id == APTX_VENDOR_ID && codec_id == APTX_CODEC_ID)
+		return "aptX";
+
+	return "Unknown";
+}
+
 static bool codec_sbc(uint8_t losc, struct l2cap_frame *frame)
 {
 	uint8_t cap = 0;
@@ -306,6 +332,55 @@ static bool codec_aac(uint8_t losc, struct l2cap_frame *frame)
 	return true;
 }
 
+static bool codec_vendor_aptx(uint8_t losc, struct l2cap_frame *frame)
+{
+	uint8_t cap = 0;
+
+	if (losc != 1)
+		return false;
+
+	l2cap_frame_get_u8(frame, &cap);
+
+	print_field("%*cFrequency: 0x%02x", BASE_INDENT + 2, ' ', cap & 0xf0);
+	print_bit_table(BASE_INDENT + 2, cap & 0xf0, aptx_frequency_table);
+
+	print_field("%*cChannel Mode: 0x%02x", BASE_INDENT + 2, ' ',
+								cap & 0x0f);
+	print_bit_table(BASE_INDENT + 2, cap & 0x0f, aptx_channel_mode_table);
+
+	return true;
+}
+
+static bool codec_vendor(uint8_t losc, struct l2cap_frame *frame)
+{
+	uint32_t vendor_id = 0;
+	uint16_t codec_id = 0;
+
+	if (losc < 6)
+		return false;
+
+	l2cap_frame_get_le32(frame, &vendor_id);
+	l2cap_frame_get_le16(frame, &codec_id);
+
+	losc -= 6;
+
+	print_field("%*cVendor ID: 0x%08x (%s)", BASE_INDENT, ' ', vendor_id,
+						bt_compidtostr(vendor_id));
+
+	print_field("%*cVendor Specific Codec ID: 0x%04x (%s)",
+					BASE_INDENT, ' ', codec_id,
+					vndcodec2str(vendor_id, codec_id));
+
+	if (vendor_id == APTX_VENDOR_ID && codec_id == APTX_CODEC_ID) {
+		codec_vendor_aptx(losc, frame);
+	} else {
+		packet_hexdump(frame->data, losc);
+		l2cap_frame_pull(frame, frame, losc);
+	}
+
+	return true;
+}
+
 bool a2dp_codec_caps(uint8_t codec, uint8_t losc, struct l2cap_frame *frame)
 {
 	switch (codec) {
@@ -315,6 +390,8 @@ bool a2dp_codec_caps(uint8_t codec, uint8_t losc, struct l2cap_frame *frame)
 		return codec_mpeg12(losc, frame);
 	case A2DP_CODEC_MPEG24:
 		return codec_aac(losc, frame);
+	case A2DP_CODEC_VENDOR:
+		return codec_vendor(losc, frame);
 	default:
 		packet_hexdump(frame->data, losc);
 		l2cap_frame_pull(frame, frame, losc);
-- 
2.6.2

