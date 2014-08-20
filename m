Return-Path: <cyrus@holtmann.org>
From: Vikrampal Yadav <vikram.pal@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, d.kasatkin@samsung.com,
	vikram.pal@samsung.com, cpgs@samsung.com
Subject: [PATCH 2/7] monitor: Add AVRCP GetCurrentPlayerApplicationSettingValue
 support
Date: Wed, 20 Aug 2014 14:54:02 +0530
Message-id: <1408526647-23894-2-git-send-email-vikram.pal@samsung.com>
In-reply-to: <1408526647-23894-1-git-send-email-vikram.pal@samsung.com>
References: <1408526647-23894-1-git-send-email-vikram.pal@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Support for decoding AVRCP GetCurrentPlayerApplicationSettingValue
added in Bluetooth monitor.
---
 monitor/avctp.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/monitor/avctp.c b/monitor/avctp.c
index ff1de1e..1aff224 100644
--- a/monitor/avctp.c
+++ b/monitor/avctp.c
@@ -589,6 +589,42 @@ static void avrcp_get_current_player_value(const struct l2cap_frame *frame,
 						uint8_t ctype, uint8_t len,
 						uint8_t indent)
 {
+	uint8_t num, i;
+
+	if (len < 1) {
+		print_text(COLOR_ERROR, "PDU malformed");
+		packet_hexdump(frame->data, frame->size);
+		return;
+	}
+
+	num = *((uint8_t *) frame->data);
+
+	if (ctype > AVC_CTYPE_GENERAL_INQUIRY) {
+		print_field("%*cValueCount: 0x%02x", (indent - 8), ' ', num);
+
+		for (i = 0; num > 0; num--, i++) {
+			uint8_t attr, value;
+
+			attr = *((uint8_t *) (frame->data + 1 + (i * 2)));
+			print_field("%*cAttributeID: 0x%02x (%s)",
+				(indent - 8), ' ', attr, attr2str(attr));
+
+			value = *((uint8_t *) (frame->data + 2 + (i * 2)));
+			print_field("%*cValueID: 0x%02x (%s)", (indent - 8),
+					' ', value, value2str(attr, value));
+		}
+	} else {
+		print_field("%*cAttributeCount: 0x%02x",
+				(indent - 8), ' ', num);
+
+		for (i = 0; num > 0; num--, i++) {
+			uint8_t attr;
+
+			attr = *((uint8_t *) (frame->data + 1 + i));
+			print_field("%*cAttributeID: 0x%02x (%s)",
+				(indent - 8), ' ', attr, attr2str(attr));
+		}
+	}
 }
 
 static void avrcp_set_player_value(const struct l2cap_frame *frame,
-- 
1.9.1

