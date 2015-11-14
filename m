Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
Subject: [PATCH 20/22] monitor/a2dp: Decode AAC capabilities
Date: Sat, 14 Nov 2015 14:44:37 +0100
Message-Id: <1447508679-21798-21-git-send-email-andrzej.kaczmarek@codecoup.pl>
In-Reply-To: <1447508679-21798-1-git-send-email-andrzej.kaczmarek@codecoup.pl>
References: <1447508679-21798-1-git-send-email-andrzej.kaczmarek@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 monitor/a2dp.c | 79 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/monitor/a2dp.c b/monitor/a2dp.c
index 10eca42..b6b01ee 100644
--- a/monitor/a2dp.c
+++ b/monitor/a2dp.c
@@ -132,6 +132,40 @@ static const struct bit_desc mpeg12_bitrate_table[] = {
 	{ }
 };
 
+static const struct bit_desc aac_object_type_table[] = {
+	{  7, "MPEG-2 AAC LC" },
+	{  6, "MPEG-4 AAC LC" },
+	{  5, "MPEG-4 AAC LTP" },
+	{  4, "MPEG-4 AAC scalable" },
+	{  3, "RFA (b3)" },
+	{  2, "RFA (b2)" },
+	{  1, "RFA (b1)" },
+	{  0, "RFA (b0)" },
+	{ }
+};
+
+static const struct bit_desc aac_frequency_table[] = {
+	{ 15, "8000" },
+	{ 14, "11025" },
+	{ 13, "12000" },
+	{ 12, "16000" },
+	{ 11, "22050" },
+	{ 10, "24000" },
+	{  9, "32000" },
+	{  8, "44100" },
+	{  7, "48000" },
+	{  6, "64000" },
+	{  5, "88200" },
+	{  4, "96000" },
+	{ }
+};
+
+static const struct bit_desc aac_channels_table[] = {
+	{  3, "1" },
+	{  2, "2" },
+	{ }
+};
+
 static void print_bit_table(uint8_t indent, uint32_t value,
 						const struct bit_desc *table)
 {
@@ -229,6 +263,49 @@ static bool codec_mpeg12(uint8_t losc, struct l2cap_frame *frame)
 	return true;
 }
 
+static bool codec_aac(uint8_t losc, struct l2cap_frame *frame)
+{
+	uint16_t cap = 0;
+	uint8_t type;
+	uint16_t freq;
+	uint8_t chan;
+	uint32_t bitrate;
+	bool vbr;
+
+	if (losc != 6)
+		return false;
+
+	l2cap_frame_get_be16(frame, &cap);
+
+	type = cap >> 8;
+	freq = cap << 8;
+
+	l2cap_frame_get_be16(frame, &cap);
+
+	freq |= (cap >> 8) & 0xf0;
+	chan = (cap >> 8) & 0x0c;
+	bitrate = (cap << 16) & 0x7f0000;
+	vbr = cap & 0x0080;
+
+	l2cap_frame_get_be16(frame, &cap);
+
+	bitrate |= cap;
+
+	print_field("%*cObject Type: 0x%02x", BASE_INDENT, ' ', type);
+	print_bit_table(BASE_INDENT, type, aac_object_type_table);
+
+	print_field("%*cFrequency: 0x%02x", BASE_INDENT, ' ', freq);
+	print_bit_table(BASE_INDENT, freq, aac_frequency_table);
+
+	print_field("%*cChannels: 0x%02x", BASE_INDENT, ' ', chan);
+	print_bit_table(BASE_INDENT, chan, aac_channels_table);
+
+	print_field("%*cBitrate: %ubps", BASE_INDENT, ' ', bitrate);
+	print_field("%*cVBR: %s", BASE_INDENT, ' ', vbr ? "Yes" : "No");
+
+	return true;
+}
+
 bool a2dp_codec_caps(uint8_t codec, uint8_t losc, struct l2cap_frame *frame)
 {
 	switch (codec) {
@@ -236,6 +313,8 @@ bool a2dp_codec_caps(uint8_t codec, uint8_t losc, struct l2cap_frame *frame)
 		return codec_sbc(losc, frame);
 	case A2DP_CODEC_MPEG12:
 		return codec_mpeg12(losc, frame);
+	case A2DP_CODEC_MPEG24:
+		return codec_aac(losc, frame);
 	default:
 		packet_hexdump(frame->data, losc);
 		l2cap_frame_pull(frame, frame, losc);
-- 
2.6.2

