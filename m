Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
Subject: [PATCH v2 21/22] monitor/a2dp: Decode aptX capabilities
Date: Fri, 20 Nov 2015 15:13:39 +0100
Message-Id: <1448028820-25330-22-git-send-email-andrzej.kaczmarek@codecoup.pl>
In-Reply-To: <1448028820-25330-1-git-send-email-andrzej.kaczmarek@codecoup.pl>
References: <1448028820-25330-1-git-send-email-andrzej.kaczmarek@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

> ACL Data RX: Handle 5 flags 0x02 dlen 23
      Channel: 65 len 19 [PSM 25 mode 0] {chan 1}
      AVDTP: Get Capabilities (0x02) Response Accept (0x02) type 0x00 label 12 nosp 0
        Service Category: Media Transport (0x01)
        Service Category: Media Codec (0x07)
          Media Type: Audio (0x00)
          Media Codec: Non-A2DP (0xff)
            Vendor ID: APT Licensing Ltd. (0x0000004f)
            Vendor Specific Codec ID: aptX (0x0001)
              Frequency: 0x30
                44100
                48000
              Channel Mode: 0x02
                Stereo
        Service Category: Content Protection (0x04)
          Content Protection Type: SCMS-T (0x0002)

< ACL Data TX: Handle 5 flags 0x00 dlen 21
      Channel: 193 len 17 [PSM 25 mode 0] {chan 1}
      AVDTP: Set Configuration (0x03) Command (0x00) type 0x00 label 14 nosp 0
        ACP SEID: 3
        INT SEID: 1
        Service Category: Media Transport (0x01)
        Service Category: Media Codec (0x07)
          Media Type: Audio (0x00)
          Media Codec: Non-A2DP (0xff)
            Vendor ID: APT Licensing Ltd. (0x0000004f)
            Vendor Specific Codec ID: aptX (0x0001)
              Frequency: 48000 (0x10)
              Channel Mode: Stereo (0x02)
---
 monitor/a2dp.c | 127 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 127 insertions(+)

diff --git a/monitor/a2dp.c b/monitor/a2dp.c
index 51fffd4..d438db0 100644
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
 static void print_value_bits(uint8_t indent, uint32_t value,
 						const struct bit_desc *table)
 {
@@ -190,6 +208,14 @@ static const char *find_value_bit(uint32_t value,
 	return "Unknown";
 }
 
+static const char *vndcodec2str(uint32_t vendor_id, uint16_t codec_id)
+{
+	if (vendor_id == APTX_VENDOR_ID && codec_id == APTX_CODEC_ID)
+		return "aptX";
+
+	return "Unknown";
+}
+
 static bool codec_sbc_cap(uint8_t losc, struct l2cap_frame *frame)
 {
 	uint8_t cap = 0;
@@ -458,6 +484,103 @@ static bool codec_aac_cfg(uint8_t losc, struct l2cap_frame *frame)
 	return true;
 }
 
+static bool codec_vendor_aptx_cap(uint8_t losc, struct l2cap_frame *frame)
+{
+	uint8_t cap = 0;
+
+	if (losc != 1)
+		return false;
+
+	l2cap_frame_get_u8(frame, &cap);
+
+	print_field("%*cFrequency: 0x%02x", BASE_INDENT + 2, ' ', cap & 0xf0);
+	print_value_bits(BASE_INDENT + 2, cap & 0xf0, aptx_frequency_table);
+
+	print_field("%*cChannel Mode: 0x%02x", BASE_INDENT + 2, ' ',
+								cap & 0x0f);
+	print_value_bits(BASE_INDENT + 2, cap & 0x0f, aptx_channel_mode_table);
+
+	return true;
+}
+
+static bool codec_vendor_cap(uint8_t losc, struct l2cap_frame *frame)
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
+	print_field("%*cVendor ID: %s (0x%08x)", BASE_INDENT, ' ',
+					bt_compidtostr(vendor_id),  vendor_id);
+
+	print_field("%*cVendor Specific Codec ID: %s (0x%04x)", BASE_INDENT,
+			' ', vndcodec2str(vendor_id, codec_id), codec_id);
+
+	if (vendor_id == APTX_VENDOR_ID && codec_id == APTX_CODEC_ID) {
+		codec_vendor_aptx_cap(losc, frame);
+	} else {
+		packet_hexdump(frame->data, losc);
+		l2cap_frame_pull(frame, frame, losc);
+	}
+
+	return true;
+}
+
+static bool codec_vendor_aptx_cfg(uint8_t losc, struct l2cap_frame *frame)
+{
+	uint8_t cap = 0;
+
+	if (losc != 1)
+		return false;
+
+	l2cap_frame_get_u8(frame, &cap);
+
+	print_field("%*cFrequency: %s (0x%02x)", BASE_INDENT + 2, ' ',
+			find_value_bit(cap & 0xf0, aptx_frequency_table),
+			cap & 0xf0);
+
+	print_field("%*cChannel Mode: %s (0x%02x)", BASE_INDENT + 2, ' ',
+			find_value_bit(cap & 0x0f, aptx_channel_mode_table),
+			cap & 0x0f);
+
+	return true;
+}
+
+static bool codec_vendor_cfg(uint8_t losc, struct l2cap_frame *frame)
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
+	print_field("%*cVendor ID: %s (0x%08x)", BASE_INDENT, ' ',
+					bt_compidtostr(vendor_id),  vendor_id);
+
+	print_field("%*cVendor Specific Codec ID: %s (0x%04x)", BASE_INDENT,
+			' ', vndcodec2str(vendor_id, codec_id), codec_id);
+
+	if (vendor_id == APTX_VENDOR_ID && codec_id == APTX_CODEC_ID) {
+		codec_vendor_aptx_cfg(losc, frame);
+	} else {
+		packet_hexdump(frame->data, losc);
+		l2cap_frame_pull(frame, frame, losc);
+	}
+
+	return true;
+}
+
 bool a2dp_codec_cap(uint8_t codec, uint8_t losc, struct l2cap_frame *frame)
 {
 	switch (codec) {
@@ -467,6 +590,8 @@ bool a2dp_codec_cap(uint8_t codec, uint8_t losc, struct l2cap_frame *frame)
 		return codec_mpeg12_cap(losc, frame);
 	case A2DP_CODEC_MPEG24:
 		return codec_aac_cap(losc, frame);
+	case A2DP_CODEC_VENDOR:
+		return codec_vendor_cap(losc, frame);
 	default:
 		packet_hexdump(frame->data, losc);
 		l2cap_frame_pull(frame, frame, losc);
@@ -483,6 +608,8 @@ bool a2dp_codec_cfg(uint8_t codec, uint8_t losc, struct l2cap_frame *frame)
 		return codec_mpeg12_cfg(losc, frame);
 	case A2DP_CODEC_MPEG24:
 		return codec_aac_cfg(losc, frame);
+	case A2DP_CODEC_VENDOR:
+		return codec_vendor_cfg(losc, frame);
 	default:
 		packet_hexdump(frame->data, losc);
 		l2cap_frame_pull(frame, frame, losc);
-- 
2.6.2

