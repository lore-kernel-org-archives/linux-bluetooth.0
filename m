Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
Subject: [PATCH v3 19/22] monitor/a2dp: Decode MPEG-1,2 capabilities
Date: Sun, 22 Nov 2015 21:20:31 +0100
Message-Id: <1448223634-23305-20-git-send-email-andrzej.kaczmarek@codecoup.pl>
In-Reply-To: <1448223634-23305-1-git-send-email-andrzej.kaczmarek@codecoup.pl>
References: <1448223634-23305-1-git-send-email-andrzej.kaczmarek@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 monitor/a2dp.c | 150 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 150 insertions(+)

diff --git a/monitor/a2dp.c b/monitor/a2dp.c
index c89a7c1..9028238 100644
--- a/monitor/a2dp.c
+++ b/monitor/a2dp.c
@@ -88,6 +88,50 @@ static const struct bit_desc sbc_allocation_table[] = {
 	{ }
 };
 
+static const struct bit_desc mpeg12_layer_table[] = {
+	{  7, "Layer I (mp1)" },
+	{  6, "Layer II (mp2)" },
+	{  5, "Layer III (mp3)" },
+	{ }
+};
+
+static const struct bit_desc mpeg12_channel_mode_table[] = {
+	{  3, "Mono" },
+	{  2, "Dual Channel" },
+	{  1, "Stereo" },
+	{  0, "Joint Stereo" },
+	{ }
+};
+
+static const struct bit_desc mpeg12_frequency_table[] = {
+	{  5, "16000" },
+	{  4, "22050" },
+	{  3, "24000" },
+	{  2, "32000" },
+	{  1, "44100" },
+	{  0, "48000" },
+	{ }
+};
+
+static const struct bit_desc mpeg12_bitrate_table[] = {
+	{ 14, "1110" },
+	{ 13, "1101" },
+	{ 12, "1100" },
+	{ 11, "1011" },
+	{ 10, "1010" },
+	{  9, "1001" },
+	{  8, "1000" },
+	{  7, "0111" },
+	{  6, "0110" },
+	{  5, "0101" },
+	{  4, "0100" },
+	{  3, "0011" },
+	{  2, "0010" },
+	{  1, "0001" },
+	{  0, "0000" },
+	{ }
+};
+
 static void print_value_bits(uint8_t indent, uint32_t value,
 						const struct bit_desc *table)
 {
@@ -192,11 +236,115 @@ static bool codec_sbc_cfg(uint8_t losc, struct l2cap_frame *frame)
 	return true;
 }
 
+static bool codec_mpeg12_cap(uint8_t losc, struct l2cap_frame *frame)
+{
+	uint16_t cap = 0;
+	uint8_t layer;
+	uint8_t chan;
+	uint8_t freq;
+	uint16_t bitrate;
+	bool crc, mpf, vbr;
+
+	if (losc != 4)
+		return false;
+
+	l2cap_frame_get_be16(frame, &cap);
+
+	layer = (cap >> 8) & 0xe0;
+	crc = cap & 0x1000;
+	chan = (cap >> 8) & 0x0f;
+	mpf = cap & 0x0040;
+	freq = cap & 0x003f;
+
+	l2cap_frame_get_be16(frame, &cap);
+
+	vbr = cap & 0x8000;
+	bitrate = cap & 0x7fff;
+
+	print_field("%*cLayer: 0x%02x", BASE_INDENT, ' ', layer);
+	print_value_bits(BASE_INDENT, layer, mpeg12_layer_table);
+
+	print_field("%*cCRC: %s", BASE_INDENT, ' ', crc ? "Yes" : "No");
+
+	print_field("%*cChannel Mode: 0x%02x", BASE_INDENT, ' ', chan);
+	print_value_bits(BASE_INDENT, chan, mpeg12_channel_mode_table);
+
+	print_field("%*cMedia Payload Format: %s", BASE_INDENT, ' ',
+					mpf ? "RFC-2250 RFC-3119" : "RFC-2250");
+
+	print_field("%*cFrequency: 0x%02x", BASE_INDENT, ' ', freq);
+	print_value_bits(BASE_INDENT, freq, mpeg12_frequency_table);
+
+	if (!vbr) {
+		print_field("%*cBitrate Index: 0x%04x", BASE_INDENT, ' ',
+								bitrate);
+		print_value_bits(BASE_INDENT, freq, mpeg12_bitrate_table);
+	}
+
+	print_field("%*cVBR: %s", BASE_INDENT, ' ', vbr ? "Yes" : "No");
+
+	return true;
+}
+
+static bool codec_mpeg12_cfg(uint8_t losc, struct l2cap_frame *frame)
+{
+	uint16_t cap = 0;
+	uint8_t layer;
+	uint8_t chan;
+	uint8_t freq;
+	uint16_t bitrate;
+	bool crc, mpf, vbr;
+
+	if (losc != 4)
+		return false;
+
+	l2cap_frame_get_be16(frame, &cap);
+
+	layer = (cap >> 8) & 0xe0;
+	crc = cap & 0x1000;
+	chan = (cap >> 8) & 0x0f;
+	mpf = cap & 0x0040;
+	freq = cap & 0x003f;
+
+	l2cap_frame_get_be16(frame, &cap);
+
+	vbr = cap & 0x8000;
+	bitrate = cap & 0x7fff;
+
+	print_field("%*cLayer: %s (0x%02x)", BASE_INDENT, ' ',
+				find_value_bit(layer, mpeg12_layer_table),
+				layer);
+
+	print_field("%*cCRC: %s", BASE_INDENT, ' ', crc ? "Yes" : "No");
+
+	print_field("%*cChannel Mode: %s (0x%02x)", BASE_INDENT, ' ',
+				find_value_bit(chan, mpeg12_channel_mode_table),
+				chan);
+
+	print_field("%*cMedia Payload Format: %s", BASE_INDENT, ' ',
+					mpf ? "RFC-2250 RFC-3119" : "RFC-2250");
+
+	print_field("%*cFrequency: %s (0x%02x)", BASE_INDENT, ' ',
+				find_value_bit(freq, mpeg12_frequency_table),
+				freq);
+
+	if (!vbr)
+		print_field("%*cBitrate Index: %s (0x%04x)", BASE_INDENT, ' ',
+				find_value_bit(freq, mpeg12_bitrate_table),
+				bitrate);
+
+	print_field("%*cVBR: %s", BASE_INDENT, ' ', vbr ? "Yes" : "No");
+
+	return true;
+}
+
 bool a2dp_codec_cap(uint8_t codec, uint8_t losc, struct l2cap_frame *frame)
 {
 	switch (codec) {
 	case A2DP_CODEC_SBC:
 		return codec_sbc_cap(losc, frame);
+	case A2DP_CODEC_MPEG12:
+		return codec_mpeg12_cap(losc, frame);
 	default:
 		packet_hexdump(frame->data, losc);
 		l2cap_frame_pull(frame, frame, losc);
@@ -209,6 +357,8 @@ bool a2dp_codec_cfg(uint8_t codec, uint8_t losc, struct l2cap_frame *frame)
 	switch (codec) {
 	case A2DP_CODEC_SBC:
 		return codec_sbc_cfg(losc, frame);
+	case A2DP_CODEC_MPEG12:
+		return codec_mpeg12_cfg(losc, frame);
 	default:
 		packet_hexdump(frame->data, losc);
 		l2cap_frame_pull(frame, frame, losc);
-- 
2.6.2

