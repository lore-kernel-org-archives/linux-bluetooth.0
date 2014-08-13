Return-Path: <cyrus@holtmann.org>
From: Vikrampal Yadav <vikram.pal@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, d.kasatkin@samsung.com,
	vikram.pal@samsung.com, cpgs@samsung.com
Subject: [PATCH] monitor: Add AVRCP ListPlayerApplicationSettingAttributes
 support
Date: Wed, 13 Aug 2014 17:35:17 +0530
Message-id: <1407931517-16264-1-git-send-email-vikram.pal@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Support for decoding AVRCP ListPlayerApplicationSettingAttributes
added in Bluetooth monitor.
---
 monitor/avctp.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/monitor/avctp.c b/monitor/avctp.c
index 9eeac7f..a25945b 100644
--- a/monitor/avctp.c
+++ b/monitor/avctp.c
@@ -150,6 +150,13 @@
 #define AVRCP_PACKET_TYPE_CONTINUING	0x02
 #define AVRCP_PACKET_TYPE_END		0x03
 
+/* player attributes */
+#define AVRCP_ATTRIBUTE_ILEGAL		0x00
+#define AVRCP_ATTRIBUTE_EQUALIZER	0x01
+#define AVRCP_ATTRIBUTE_REPEAT_MODE	0x02
+#define AVRCP_ATTRIBUTE_SHUFFLE		0x03
+#define AVRCP_ATTRIBUTE_SCAN		0x04
+
 static const char *ctype2str(uint8_t ctype)
 {
 	switch (ctype & 0x0f) {
@@ -404,6 +411,24 @@ static const char *pt2str(uint8_t pt)
 	}
 }
 
+static const char *attr2str(uint8_t attr)
+{
+	switch (attr) {
+	case AVRCP_ATTRIBUTE_ILEGAL:
+		return "Illegal";
+	case AVRCP_ATTRIBUTE_EQUALIZER:
+		return "Equalizer ON/OFF Status";
+	case AVRCP_ATTRIBUTE_REPEAT_MODE:
+		return "Repeat Mode Status";
+	case AVRCP_ATTRIBUTE_SHUFFLE:
+		return "Shuffle ON/OFF Status";
+	case AVRCP_ATTRIBUTE_SCAN:
+		return "Scan ON/OFF Status";
+	default:
+		return "Unknown";
+	}
+}
+
 static void avrcp_passthrough_packet(const struct l2cap_frame *frame)
 {
 }
@@ -457,6 +482,22 @@ static void avrcp_list_player_attributes(const struct l2cap_frame *frame,
 						uint8_t ctype, uint8_t len,
 						uint8_t indent)
 {
+	uint8_t num;
+	int i;
+
+	if (len == 0)
+		return;
+
+	num = *((uint8_t *) frame->data);
+	print_field("%*cAttributeCount: 0x%02x", (indent - 8), ' ', num);
+
+	for (i = 0; num > 0; num--, i++) {
+		uint8_t attr;
+
+		attr = *((uint8_t *) (frame->data + 1 + i));
+		print_field("%*cAttributeID: 0x%02x (%s)", (indent - 8), ' ',
+							attr, attr2str(attr));
+	}
 }
 
 static void avrcp_list_player_values(const struct l2cap_frame *frame,
-- 
1.9.1

