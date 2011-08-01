Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH hcidump 08/13] Add parsing for AVRCP GetPlayerApplicationSettingValueText pdu
Date: Mon,  1 Aug 2011 11:42:13 +0300
Message-Id: <1312188138-32265-9-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1312188138-32265-1-git-send-email-luiz.dentz@gmail.com>
References: <1312188138-32265-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 parser/avrcp.c |   76 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 76 insertions(+), 0 deletions(-)

diff --git a/parser/avrcp.c b/parser/avrcp.c
index 5915cc4..5fb5cbe 100644
--- a/parser/avrcp.c
+++ b/parser/avrcp.c
@@ -744,6 +744,79 @@ response:
 	}
 }
 
+static void avrcp_get_player_value_text_dump(int level, struct frame *frm,
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
+	p_indent(level, frm);
+
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
+
+	return;
+
+response:
+	num = get_u8(frm);
+	printf("ValueCount: 0x%02x\n", num);
+
+	for (; num > 0; num--) {
+		uint8_t value, len;
+		uint16_t charset;
+
+		p_indent(level, frm);
+
+		value = get_u8(frm);
+		printf("ValueID: 0x%02x (%s)\n", value,
+						value2str(attr, value));
+
+		p_indent(level, frm);
+
+		charset = get_u16(frm);
+		printf("CharsetID: 0x%04x (%s)\n", charset,
+							charset2str(charset));
+
+		p_indent(level, frm);
+
+		len = get_u8(frm);
+		printf("StringLength: 0x%02x\n", len);
+
+		p_indent(level, frm);
+
+		printf("String: ");
+		for (; len > 0; len--) {
+			uint8_t c = get_u8(frm);
+			printf("%1c", isprint(c) ? c : '.');
+		}
+		printf("\n");
+	}
+}
+
 static void avrcp_pdu_dump(int level, struct frame *frm, uint8_t ctype)
 {
 	uint8_t pduid, pt;
@@ -793,6 +866,9 @@ static void avrcp_pdu_dump(int level, struct frame *frm, uint8_t ctype)
 		avrcp_get_player_attribute_text_dump(level + 1, frm, ctype,
 									len);
 		break;
+	case AVRCP_GET_PLAYER_VALUE_TEXT:
+		avrcp_get_player_value_text_dump(level + 1, frm, ctype, len);
+		break;
 	default:
 		raw_dump(level, frm);
 	}
-- 
1.7.6

