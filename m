Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
Subject: [PATCH 18/22] monitor/a2dp: Decode SBC capabilities
Date: Sat, 14 Nov 2015 14:44:35 +0100
Message-Id: <1447508679-21798-19-git-send-email-andrzej.kaczmarek@codecoup.pl>
In-Reply-To: <1447508679-21798-1-git-send-email-andrzej.kaczmarek@codecoup.pl>
References: <1447508679-21798-1-git-send-email-andrzej.kaczmarek@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 Makefile.tools     |   1 +
 android/Android.mk |   1 +
 monitor/a2dp.c     | 150 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 monitor/a2dp.h     |  24 +++++++++
 monitor/avdtp.c    |   8 +--
 5 files changed, 178 insertions(+), 6 deletions(-)
 create mode 100644 monitor/a2dp.c
 create mode 100644 monitor/a2dp.h

diff --git a/Makefile.tools b/Makefile.tools
index 387917e..46cdb53 100644
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
index 0000000..60ebe94
--- /dev/null
+++ b/monitor/a2dp.c
@@ -0,0 +1,150 @@
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
+	uint8_t bit;
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
+	{  0, "Joint Channel" },
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
+static void print_bit_table(uint8_t indent, uint32_t value,
+						const struct bit_desc *table)
+{
+	int i;
+
+	for (i = 0; table[i].str; i++) {
+		if (value & (1 << table[i].bit))
+			print_field("%*c%s", indent + 2, ' ', table[i].str);
+	}
+}
+
+static bool codec_sbc(uint8_t losc, struct l2cap_frame *frame)
+{
+	uint8_t cap = 0;
+
+	if (losc != 4)
+		return false;
+
+	l2cap_frame_get_u8(frame, &cap);
+
+	print_field("%*cFrequency: 0x%02x", BASE_INDENT, ' ', cap & 0xf0);
+	print_bit_table(BASE_INDENT, cap & 0xf0, sbc_frequency_table);
+
+	print_field("%*cChannel Mode: 0x%02x", BASE_INDENT, ' ', cap & 0x0f);
+	print_bit_table(BASE_INDENT, cap & 0x0f, sbc_channel_mode_table);
+
+	l2cap_frame_get_u8(frame, &cap);
+
+	print_field("%*cBlock Length: 0x%02x", BASE_INDENT, ' ', cap & 0xf0);
+	print_bit_table(BASE_INDENT, cap & 0xf0, sbc_blocklen_table);
+
+	print_field("%*cSubbands: 0x%02x", BASE_INDENT, ' ', cap & 0x0c);
+	print_bit_table(BASE_INDENT, cap & 0x0c, sbc_subbands_table);
+
+	print_field("%*cAllocation Method: 0x%02x", BASE_INDENT, ' ',
+								cap & 0x03);
+	print_bit_table(BASE_INDENT, cap & 0x03, sbc_allocation_table);
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
+bool a2dp_codec_caps(uint8_t codec, uint8_t losc, struct l2cap_frame *frame)
+{
+	switch (codec) {
+	case A2DP_CODEC_SBC:
+		return codec_sbc(losc, frame);
+	default:
+		packet_hexdump(frame->data, losc);
+		l2cap_frame_pull(frame, frame, losc);
+		return true;
+	}
+}
diff --git a/monitor/a2dp.h b/monitor/a2dp.h
new file mode 100644
index 0000000..4376ab2
--- /dev/null
+++ b/monitor/a2dp.h
@@ -0,0 +1,24 @@
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
+bool a2dp_codec_caps(uint8_t codec, uint8_t losc, struct l2cap_frame *frame);
diff --git a/monitor/avdtp.c b/monitor/avdtp.c
index e216a1b..061b3f6 100644
--- a/monitor/avdtp.c
+++ b/monitor/avdtp.c
@@ -37,6 +37,7 @@
 #include "display.h"
 #include "l2cap.h"
 #include "avdtp.h"
+#include "a2dp.h"
 
 /* Signal Identifiers */
 #define AVDTP_DISCOVER			0x01
@@ -284,12 +285,7 @@ static bool service_media_codec(struct avdtp_frame *avdtp_frame, uint8_t losc)
 	print_field("%*cMedia Codec: %s", 2, ' ',
 					mediacodec2str(codec));
 
-	/* TODO: decode codec specific information */
-
-	packet_hexdump(frame->data, losc);
-	l2cap_frame_pull(frame, frame, losc);
-
-	return true;
+	return a2dp_codec_caps(codec, losc, frame);
 }
 
 static bool decode_capabilities(struct avdtp_frame *avdtp_frame)
-- 
2.6.2

