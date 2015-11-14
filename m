Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
Subject: [PATCH 19/22] monitor/a2dp: Decode MPEG-1,2 capabilities
Date: Sat, 14 Nov 2015 14:44:36 +0100
Message-Id: <1447508679-21798-20-git-send-email-andrzej.kaczmarek@codecoup.pl>
In-Reply-To: <1447508679-21798-1-git-send-email-andrzej.kaczmarek@codecoup.pl>
References: <1447508679-21798-1-git-send-email-andrzej.kaczmarek@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 monitor/a2dp.c | 94 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 94 insertions(+)

diff --git a/monitor/a2dp.c b/monitor/a2dp.c
index 60ebe94..10eca42 100644
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
+	{  0, "Joint Channel" },
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
 static void print_bit_table(uint8_t indent, uint32_t value,
 						const struct bit_desc *table)
 {
@@ -137,11 +181,61 @@ static bool codec_sbc(uint8_t losc, struct l2cap_frame *frame)
 	return true;
 }
 
+static bool codec_mpeg12(uint8_t losc, struct l2cap_frame *frame)
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
+	print_bit_table(BASE_INDENT, layer, mpeg12_layer_table);
+
+	print_field("%*cCRC: %s", BASE_INDENT, ' ', crc ? "Yes" : "No");
+
+	print_field("%*cChannel Mode: 0x%02x", BASE_INDENT, ' ', chan);
+	print_bit_table(BASE_INDENT, chan, mpeg12_channel_mode_table);
+
+	print_field("%*cMedia Payload Format: %s", BASE_INDENT, ' ',
+					mpf ? "RFC-2250 RFC-3119" : "RFC-2250");
+
+	print_field("%*cFrequency: 0x%02x", BASE_INDENT, ' ', freq);
+	print_bit_table(BASE_INDENT, freq, mpeg12_frequency_table);
+
+	print_field("%*cBitrate: 0x%04x", BASE_INDENT, ' ', bitrate);
+	if (!vbr)
+		print_bit_table(BASE_INDENT, freq, mpeg12_bitrate_table);
+
+	print_field("%*cVBR: %s", BASE_INDENT, ' ', vbr ? "Yes" : "No");
+
+	return true;
+}
+
 bool a2dp_codec_caps(uint8_t codec, uint8_t losc, struct l2cap_frame *frame)
 {
 	switch (codec) {
 	case A2DP_CODEC_SBC:
 		return codec_sbc(losc, frame);
+	case A2DP_CODEC_MPEG12:
+		return codec_mpeg12(losc, frame);
 	default:
 		packet_hexdump(frame->data, losc);
 		l2cap_frame_pull(frame, frame, losc);
-- 
2.6.2

