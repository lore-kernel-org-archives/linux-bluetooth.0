Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH hcidump 04/13] Add parsing for AVRCP ListPlayerApplicationSettingValues pdu
Date: Mon,  1 Aug 2011 11:42:09 +0300
Message-Id: <1312188138-32265-5-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1312188138-32265-1-git-send-email-luiz.dentz@gmail.com>
References: <1312188138-32265-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 parser/avrcp.c |   94 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 94 insertions(+), 0 deletions(-)

diff --git a/parser/avrcp.c b/parser/avrcp.c
index 7daba13..e6f8755 100644
--- a/parser/avrcp.c
+++ b/parser/avrcp.c
@@ -467,6 +467,97 @@ static void avrcp_list_player_attributes_dump(int level, struct frame *frm,
 	}
 }
 
+static const char *value2str(uint8_t attr, uint8_t value)
+{
+	switch (attr) {
+	case AVRCP_ATTRIBUTE_ILEGAL:
+		return "Illegal";
+	case AVRCP_ATTRIBUTE_EQUALIZER:
+		switch (value) {
+		case 0x01:
+			return "OFF";
+		case 0x02:
+			return "ON";
+		default:
+			return "Reserved";
+		}
+	case AVRCP_ATTRIBUTE_REPEAT_MODE:
+		switch (value) {
+		case 0x01:
+			return "OFF";
+		case 0x02:
+			return "Single Track Repeat";
+		case 0x03:
+			return "All Track Repeat";
+		case 0x04:
+			return "Group Repeat";
+		default:
+			return "Reserved";
+		}
+	case AVRCP_ATTRIBUTE_SHUFFLE:
+		switch (value) {
+		case 0x01:
+			return "OFF";
+		case 0x02:
+			return "All Track Suffle";
+		case 0x03:
+			return "Group Suffle";
+		default:
+			return "Reserved";
+		}
+	case AVRCP_ATTRIBUTE_SCAN:
+		switch (value) {
+		case 0x01:
+			return "OFF";
+		case 0x02:
+			return "All Track Scan";
+		case 0x03:
+			return "Group Scan";
+		default:
+			return "Reserved";
+		}
+	default:
+		return "Unknown";
+	}
+}
+
+static void avrcp_list_player_values_dump(int level, struct frame *frm,
+						uint8_t ctype, uint16_t len)
+{
+	static uint8_t attr = 0; /* Remember attribute */
+	uint8_t num;
+
+	p_indent(level, frm);
+
+	if (len < 1) {
+		printf("PDU Malformed\n");
+		raw_dump(level, frm);
+		return;
+	}
+
+	if (ctype > AVC_CTYPE_GENERAL_INQUIRY)
+		goto response;
+
+	attr = get_u8(frm);
+	printf("AttributeID: 0x%02x (%s)\n", attr, attr2str(attr));
+
+	return;
+
+response:
+	num = get_u8(frm);
+	printf("ValueCount: 0x%02x\n", num);
+
+	for (; num > 0; num--) {
+		uint8_t value;
+
+		p_indent(level, frm);
+
+		value = get_u8(frm);
+		printf("ValueID: 0x%02x (%s)\n", value,
+						value2str(attr, value));
+	}
+}
+
 static void avrcp_pdu_dump(int level, struct frame *frm, uint8_t ctype)
 {
 	uint8_t pduid, pt;
@@ -502,6 +593,9 @@ static void avrcp_pdu_dump(int level, struct frame *frm, uint8_t ctype)
 	case AVRCP_LIST_PLAYER_ATTRIBUTES:
 		avrcp_list_player_attributes_dump(level + 1, frm, len);
 		break;
+	case AVRCP_LIST_PLAYER_VALUES:
+		avrcp_list_player_values_dump(level + 1, frm, ctype, len);
+		break;
 	default:
 		raw_dump(level, frm);
 	}
-- 
1.7.6

