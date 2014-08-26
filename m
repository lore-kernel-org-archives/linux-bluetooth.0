Return-Path: <cyrus@holtmann.org>
From: Vikrampal Yadav <vikram.pal@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, d.kasatkin@samsung.com,
	vikram.pal@samsung.com, cpgs@samsung.com
Subject: [PATCH v3 5/5] monitor: Add AVRCP InformDisplayableCharacterSet support
Date: Tue, 26 Aug 2014 19:50:52 +0530
Message-id: <1409062852-29295-5-git-send-email-vikram.pal@samsung.com>
In-reply-to: <1409062852-29295-1-git-send-email-vikram.pal@samsung.com>
References: <1409062852-29295-1-git-send-email-vikram.pal@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Support for decoding AVRCP InformDisplayableCharacterSet added in
Bluetooth monitor.
---
 monitor/avctp.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/monitor/avctp.c b/monitor/avctp.c
index 1bfd9cf..28e1f34 100644
--- a/monitor/avctp.c
+++ b/monitor/avctp.c
@@ -863,6 +863,32 @@ response:
 	return true;
 }
 
+static bool avrcp_displayable_charset(struct l2cap_frame *frame, uint8_t ctype,
+					uint8_t len, uint8_t indent)
+{
+	uint8_t num;
+
+	if (ctype > AVC_CTYPE_GENERAL_INQUIRY)
+		return true;
+
+	if (!l2cap_frame_get_u8(frame, &num))
+		return false;
+
+	print_field("%*cCharsetCount: 0x%02x", (indent - 8), ' ', num);
+
+	for (; num > 0; num--) {
+		uint16_t charset;
+
+		if (!l2cap_frame_get_be16(frame, &charset))
+			return false;
+
+		print_field("%*cCharsetID: 0x%04x (%s)", (indent - 8),
+					' ', charset, charset2str(charset));
+	}
+
+	return true;
+}
+
 struct avrcp_ctrl_pdu_data {
 	uint8_t pduid;
 	bool (*func) (struct l2cap_frame *frame, uint8_t ctype, uint8_t len,
@@ -877,6 +903,7 @@ static const struct avrcp_ctrl_pdu_data avrcp_ctrl_pdu_table[] = {
 	{ 0x14, avrcp_set_player_value			},
 	{ 0x15, avrcp_get_player_attribute_text		},
 	{ 0x16, avrcp_get_player_value_text		},
+	{ 0x17, avrcp_displayable_charset		},
 	{ }
 };
 
-- 
1.9.1

