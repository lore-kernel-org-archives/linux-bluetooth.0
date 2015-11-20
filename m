Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
Subject: [PATCH v2 20/22] monitor/a2dp: Decode AAC capabilities
Date: Fri, 20 Nov 2015 15:13:38 +0100
Message-Id: <1448028820-25330-21-git-send-email-andrzej.kaczmarek@codecoup.pl>
In-Reply-To: <1448028820-25330-1-git-send-email-andrzej.kaczmarek@codecoup.pl>
References: <1448028820-25330-1-git-send-email-andrzej.kaczmarek@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

> ACL Data RX: Handle 12 flags 0x02 dlen 22                                                                                                                            4.565591
      Channel: 67 len 18 [PSM 25 mode 0] {chan 1}
      AVDTP: Get Capabilities (0x02) Response Accept (0x02) type 0x00 label 4 nosp 0
        Service Category: Media Transport (0x01)
        Service Category: Media Codec (0x07)
          Media Type: Audio (0x00)
          Media Codec: MPEG-2,4 AAC (0x02)
            Object Type: 0xc0
              MPEG-2 AAC LC
              MPEG-4 AAC LC
            Frequency: 0x180
              44100
              48000
            Channels: 0x0c
              1
              2
            Bitrate: 320000bps
            VBR: Yes
        Service Category: Content Protection (0x04)
          Content Protection Type: SCMS-T (0x0002)
---
 monitor/a2dp.c | 124 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 124 insertions(+)

diff --git a/monitor/a2dp.c b/monitor/a2dp.c
index effdfe7..51fffd4 100644
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
 static void print_value_bits(uint8_t indent, uint32_t value,
 						const struct bit_desc *table)
 {
@@ -338,6 +372,92 @@ static bool codec_mpeg12_cfg(uint8_t losc, struct l2cap_frame *frame)
 	return true;
 }
 
+static bool codec_aac_cap(uint8_t losc, struct l2cap_frame *frame)
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
+	print_value_bits(BASE_INDENT, type, aac_object_type_table);
+
+	print_field("%*cFrequency: 0x%02x", BASE_INDENT, ' ', freq);
+	print_value_bits(BASE_INDENT, freq, aac_frequency_table);
+
+	print_field("%*cChannels: 0x%02x", BASE_INDENT, ' ', chan);
+	print_value_bits(BASE_INDENT, chan, aac_channels_table);
+
+	print_field("%*cBitrate: %ubps", BASE_INDENT, ' ', bitrate);
+	print_field("%*cVBR: %s", BASE_INDENT, ' ', vbr ? "Yes" : "No");
+
+	return true;
+}
+
+static bool codec_aac_cfg(uint8_t losc, struct l2cap_frame *frame)
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
+	print_field("%*cObject Type: %s (0x%02x)", BASE_INDENT, ' ',
+			find_value_bit(type, aac_object_type_table), type);
+
+	print_field("%*cFrequency: %s (0x%02x)", BASE_INDENT, ' ',
+			find_value_bit(freq, aac_frequency_table), freq);
+
+	print_field("%*cChannels: %s (0x%02x)", BASE_INDENT, ' ',
+			find_value_bit(chan, aac_channels_table), chan);
+
+	print_field("%*cBitrate: %ubps", BASE_INDENT, ' ', bitrate);
+	print_field("%*cVBR: %s", BASE_INDENT, ' ', vbr ? "Yes" : "No");
+
+	return true;
+}
+
 bool a2dp_codec_cap(uint8_t codec, uint8_t losc, struct l2cap_frame *frame)
 {
 	switch (codec) {
@@ -345,6 +465,8 @@ bool a2dp_codec_cap(uint8_t codec, uint8_t losc, struct l2cap_frame *frame)
 		return codec_sbc_cap(losc, frame);
 	case A2DP_CODEC_MPEG12:
 		return codec_mpeg12_cap(losc, frame);
+	case A2DP_CODEC_MPEG24:
+		return codec_aac_cap(losc, frame);
 	default:
 		packet_hexdump(frame->data, losc);
 		l2cap_frame_pull(frame, frame, losc);
@@ -359,6 +481,8 @@ bool a2dp_codec_cfg(uint8_t codec, uint8_t losc, struct l2cap_frame *frame)
 		return codec_sbc_cfg(losc, frame);
 	case A2DP_CODEC_MPEG12:
 		return codec_mpeg12_cfg(losc, frame);
+	case A2DP_CODEC_MPEG24:
+		return codec_aac_cfg(losc, frame);
 	default:
 		packet_hexdump(frame->data, losc);
 		l2cap_frame_pull(frame, frame, losc);
-- 
2.6.2

