Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
Subject: [PATCH v3 18/22] monitor/a2dp: Decode SBC capabilities
Date: Sun, 22 Nov 2015 21:20:30 +0100
Message-Id: <1448223634-23305-19-git-send-email-andrzej.kaczmarek@codecoup.pl>
In-Reply-To: <1448223634-23305-1-git-send-email-andrzej.kaczmarek@codecoup.pl>
References: <1448223634-23305-1-git-send-email-andrzej.kaczmarek@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

> ACL Data RX: Handle 256 flags 0x02 dlen 20                                                                                                                    [hci0] 9.242155
      Channel: 66 len 16 [PSM 25 mode 0] {chan 2}
      AVDTP: Get Capabilities (0x02) Response Accept (0x02) type 0x00 label 1 nosp 0
        Service Category: Media Transport (0x01)
        Service Category: Media Codec (0x07)
          Media Type: Audio (0x00)
          Media Codec: SBC (0x00)
            Frequency: 0x30
              44100
              48000
            Channel Mode: 0x0f
              Mono
              Dual Channel
              Stereo
              Joint Channel
            Block Length: 0xf0
              4
              8
              12
              16
            Subbands: 0x0c
              4
              8
            Allocation Method: 0x03
              SNR
              Loudness
            Minimum Bitpool: 2
            Maximum Bitpool: 53
        Service Category: Content Protection (0x04)
          Content Protection Type: SCMS-T (0x0002)

< ACL Data TX: Handle 256 flags 0x00 dlen 18                                                                                                                    [hci0] 9.272120
      Channel: 258 len 14 [PSM 25 mode 0] {chan 2}
      AVDTP: Set Configuration (0x03) Command (0x00) type 0x00 label 5 nosp 0
        ACP SEID: 1
        INT SEID: 3
        Service Category: Media Transport (0x01)
        Service Category: Media Codec (0x07)
          Media Type: Audio (0x00)
          Media Codec: SBC (0x00)
            Frequency: 44100 (0x20)
            Channel Mode: Joint Channel (0x01)
            Block Length: 16 (0x10)
            Subbands: 8 (0x04)
            Allocation Method: Loudness (0x01)
            Minimum Bitpool: 2
            Maximum Bitpool: 53
---
 Makefile.tools     |   1 +
 android/Android.mk |   1 +
 monitor/a2dp.c     | 217 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 monitor/a2dp.h     |  26 +++++++
 monitor/avdtp.c    |  18 +++--
 5 files changed, 257 insertions(+), 6 deletions(-)
 create mode 100644 monitor/a2dp.c
 create mode 100644 monitor/a2dp.h

diff --git a/Makefile.tools b/Makefile.tools
index 8555a6b..034790a 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -28,6 +28,7 @@ monitor_btmon_SOURCES = monitor/main.c monitor/bt.h \
 				monitor/sdp.h monitor/sdp.c \
 				monitor/avctp.h monitor/avctp.c \
 				monitor/avdtp.h monitor/avdtp.c \
+				monitor/a2dp.h monitor/a2dp.c \
 				monitor/rfcomm.h monitor/rfcomm.c \
 				monitor/bnep.h monitor/bnep.c \
 				monitor/uuid.h monitor/uuid.c \
diff --git a/android/Android.mk b/android/Android.mk
index fa1188b..38ef4aa 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -340,6 +340,7 @@ LOCAL_SRC_FILES := \
 	bluez/monitor/l2cap.c \
 	bluez/monitor/avctp.c \
 	bluez/monitor/avdtp.c \
+	bluez/monitor/a2dp.c \
 	bluez/monitor/rfcomm.c \
 	bluez/monitor/bnep.c \
 	bluez/monitor/uuid.c \
diff --git a/monitor/a2dp.c b/monitor/a2dp.c
new file mode 100644
index 0000000..c89a7c1
--- /dev/null
+++ b/monitor/a2dp.c
@@ -0,0 +1,217 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2015  Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
+ *
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+
+#include "lib/bluetooth.h"
+
+#include "src/shared/util.h"
+#include "bt.h"
+#include "packet.h"
+#include "display.h"
+#include "l2cap.h"
+#include "a2dp.h"
+
+#define BASE_INDENT	4
+
+/* Codec Types */
+#define A2DP_CODEC_SBC		0x00
+#define A2DP_CODEC_MPEG12	0x01
+#define A2DP_CODEC_MPEG24	0x02
+#define A2DP_CODEC_ATRAC	0x04
+#define A2DP_CODEC_VENDOR	0xff
+
+struct bit_desc {
+	uint8_t bit_num;
+	const char *str;
+};
+
+static const struct bit_desc sbc_frequency_table[] = {
+	{  7, "16000" },
+	{  6, "32000" },
+	{  5, "44100" },
+	{  4, "48000" },
+	{ }
+};
+
+static const struct bit_desc sbc_channel_mode_table[] = {
+	{  3, "Mono" },
+	{  2, "Dual Channel" },
+	{  1, "Stereo" },
+	{  0, "Joint Stereo" },
+	{ }
+};
+
+static const struct bit_desc sbc_blocklen_table[] = {
+	{  7, "4" },
+	{  6, "8" },
+	{  5, "12" },
+	{  4, "16" },
+	{ }
+};
+
+static const struct bit_desc sbc_subbands_table[] = {
+	{  3, "4" },
+	{  2, "8" },
+	{ }
+};
+
+static const struct bit_desc sbc_allocation_table[] = {
+	{  1, "SNR" },
+	{  0, "Loudness" },
+	{ }
+};
+
+static void print_value_bits(uint8_t indent, uint32_t value,
+						const struct bit_desc *table)
+{
+	int i;
+
+	for (i = 0; table[i].str; i++) {
+		if (value & (1 << table[i].bit_num))
+			print_field("%*c%s", indent + 2, ' ', table[i].str);
+	}
+}
+
+static const char *find_value_bit(uint32_t value,
+						const struct bit_desc *table)
+{
+	int i;
+
+	for (i = 0; table[i].str; i++) {
+		if (value & (1 << table[i].bit_num))
+			return table[i].str;
+	}
+
+	return "Unknown";
+}
+
+static bool codec_sbc_cap(uint8_t losc, struct l2cap_frame *frame)
+{
+	uint8_t cap = 0;
+
+	if (losc != 4)
+		return false;
+
+	l2cap_frame_get_u8(frame, &cap);
+
+	print_field("%*cFrequency: 0x%02x", BASE_INDENT, ' ', cap & 0xf0);
+	print_value_bits(BASE_INDENT, cap & 0xf0, sbc_frequency_table);
+
+	print_field("%*cChannel Mode: 0x%02x", BASE_INDENT, ' ', cap & 0x0f);
+	print_value_bits(BASE_INDENT, cap & 0x0f, sbc_channel_mode_table);
+
+	l2cap_frame_get_u8(frame, &cap);
+
+	print_field("%*cBlock Length: 0x%02x", BASE_INDENT, ' ', cap & 0xf0);
+	print_value_bits(BASE_INDENT, cap & 0xf0, sbc_blocklen_table);
+
+	print_field("%*cSubbands: 0x%02x", BASE_INDENT, ' ', cap & 0x0c);
+	print_value_bits(BASE_INDENT, cap & 0x0c, sbc_subbands_table);
+
+	print_field("%*cAllocation Method: 0x%02x", BASE_INDENT, ' ',
+								cap & 0x03);
+	print_value_bits(BASE_INDENT, cap & 0x03, sbc_allocation_table);
+
+	l2cap_frame_get_u8(frame, &cap);
+
+	print_field("%*cMinimum Bitpool: %d", BASE_INDENT, ' ', cap);
+
+	l2cap_frame_get_u8(frame, &cap);
+
+	print_field("%*cMaximum Bitpool: %d", BASE_INDENT, ' ', cap);
+
+	return true;
+}
+
+static bool codec_sbc_cfg(uint8_t losc, struct l2cap_frame *frame)
+{
+	uint8_t cap = 0;
+
+	if (losc != 4)
+		return false;
+
+	l2cap_frame_get_u8(frame, &cap);
+
+	print_field("%*cFrequency: %s (0x%02x)", BASE_INDENT, ' ',
+			find_value_bit(cap & 0xf0, sbc_frequency_table),
+			cap & 0xf0);
+
+	print_field("%*cChannel Mode: %s (0x%02x)", BASE_INDENT, ' ',
+			find_value_bit(cap & 0x0f, sbc_channel_mode_table),
+			cap & 0x0f);
+
+	l2cap_frame_get_u8(frame, &cap);
+
+	print_field("%*cBlock Length: %s (0x%02x)", BASE_INDENT, ' ',
+			find_value_bit(cap & 0xf0, sbc_blocklen_table),
+			cap & 0xf0);
+
+	print_field("%*cSubbands: %s (0x%02x)", BASE_INDENT, ' ',
+			find_value_bit(cap & 0x0c, sbc_subbands_table),
+			cap & 0x0c);
+
+	print_field("%*cAllocation Method: %s (0x%02x)", BASE_INDENT, ' ',
+			find_value_bit(cap & 0x03, sbc_allocation_table),
+			cap & 0x03);
+
+	l2cap_frame_get_u8(frame, &cap);
+
+	print_field("%*cMinimum Bitpool: %d", BASE_INDENT, ' ', cap);
+
+	l2cap_frame_get_u8(frame, &cap);
+
+	print_field("%*cMaximum Bitpool: %d", BASE_INDENT, ' ', cap);
+
+	return true;
+}
+
+bool a2dp_codec_cap(uint8_t codec, uint8_t losc, struct l2cap_frame *frame)
+{
+	switch (codec) {
+	case A2DP_CODEC_SBC:
+		return codec_sbc_cap(losc, frame);
+	default:
+		packet_hexdump(frame->data, losc);
+		l2cap_frame_pull(frame, frame, losc);
+		return true;
+	}
+}
+
+bool a2dp_codec_cfg(uint8_t codec, uint8_t losc, struct l2cap_frame *frame)
+{
+	switch (codec) {
+	case A2DP_CODEC_SBC:
+		return codec_sbc_cfg(losc, frame);
+	default:
+		packet_hexdump(frame->data, losc);
+		l2cap_frame_pull(frame, frame, losc);
+		return true;
+	}
+}
diff --git a/monitor/a2dp.h b/monitor/a2dp.h
new file mode 100644
index 0000000..72a8f1f
--- /dev/null
+++ b/monitor/a2dp.h
@@ -0,0 +1,26 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2015  Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
+ *
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+bool a2dp_codec_cap(uint8_t codec, uint8_t losc, struct l2cap_frame *frame);
+
+bool a2dp_codec_cfg(uint8_t codec, uint8_t losc, struct l2cap_frame *frame);
diff --git a/monitor/avdtp.c b/monitor/avdtp.c
index f810f0e..3524faa 100644
--- a/monitor/avdtp.c
+++ b/monitor/avdtp.c
@@ -37,6 +37,7 @@
 #include "display.h"
 #include "l2cap.h"
 #include "avdtp.h"
+#include "a2dp.h"
 
 /* Message Types */
 #define AVDTP_MSG_TYPE_COMMAND		0x00
@@ -75,6 +76,13 @@ struct avdtp_frame {
 	struct l2cap_frame l2cap_frame;
 };
 
+static inline bool is_configuration_sig_id(uint8_t sig_id)
+{
+	return (sig_id == AVDTP_SET_CONFIGURATION) ||
+			(sig_id == AVDTP_GET_CONFIGURATION) ||
+			(sig_id == AVDTP_RECONFIGURE);
+}
+
 static const char *msgtype2str(uint8_t msgtype)
 {
 	switch (msgtype) {
@@ -293,12 +301,10 @@ static bool service_media_codec(struct avdtp_frame *avdtp_frame, uint8_t losc)
 	print_field("%*cMedia Codec: %s (0x%02x)", 2, ' ',
 					mediacodec2str(codec), codec);
 
-	/* TODO: decode codec specific information */
-
-	packet_hexdump(frame->data, losc);
-	l2cap_frame_pull(frame, frame, losc);
-
-	return true;
+	if (is_configuration_sig_id(avdtp_frame->sig_id))
+		return a2dp_codec_cfg(codec, losc, frame);
+	else
+		return a2dp_codec_cap(codec, losc, frame);
 }
 
 static bool decode_capabilities(struct avdtp_frame *avdtp_frame)
-- 
2.6.2

