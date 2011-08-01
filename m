Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH hcidump 07/13] Add parsing for AVRCP GetPlayerApplicationSettingAttributeText pdu
Date: Mon,  1 Aug 2011 11:42:12 +0300
Message-Id: <1312188138-32265-8-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1312188138-32265-1-git-send-email-luiz.dentz@gmail.com>
References: <1312188138-32265-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 parser/avrcp.c |  100 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 100 insertions(+), 0 deletions(-)

diff --git a/parser/avrcp.c b/parser/avrcp.c
index e07e77b..5915cc4 100644
--- a/parser/avrcp.c
+++ b/parser/avrcp.c
@@ -30,6 +30,7 @@
 #include <unistd.h>
 #include <stdlib.h>
 #include <string.h>
+#include <ctype.h>
 
 #include <sys/types.h>
 #include <netinet/in.h>
@@ -648,6 +649,101 @@ static void avrcp_set_player_value_dump(int level, struct frame *frm,
 	}
 }
 
+static const char *charset2str(uint16_t charset)
+{
+	switch (charset) {
+	case 1:
+	case 2:
+		return "Reserved";
+	case 3:
+		return "ASCII";
+	case 4:
+		return "ISO_8859-1";
+	case 5:
+		return "ISO_8859-2";
+	case 6:
+		return "ISO_8859-3";
+	case 7:
+		return "ISO_8859-4";
+	case 8:
+		return "ISO_8859-5";
+	case 9:
+		return "ISO_8859-6";
+	case 10:
+		return "ISO_8859-7";
+	case 11:
+		return "ISO_8859-8";
+	case 12:
+		return "ISO_8859-9";
+	case 106:
+		return "UTF-8";
+	default:
+		return "Unknown";
+	}
+}
+
+static void avrcp_get_player_attribute_text_dump(int level, struct frame *frm,
+						uint8_t ctype, uint16_t len)
+{
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
+	num = get_u8(frm);
+	printf("AttributeCount: 0x%02x\n", num);
+
+	if (ctype > AVC_CTYPE_GENERAL_INQUIRY)
+		goto response;
+
+	for (; num > 0; num--) {
+		uint8_t attr;
+
+		p_indent(level, frm);
+
+		attr = get_u8(frm);
+		printf("AttributeID: 0x%02x (%s)\n", attr, attr2str(attr));
+	}
+
+	return;
+
+response:
+	for (; num > 0; num--) {
+		uint8_t attr, len;
+		uint16_t charset;
+
+		p_indent(level, frm);
+
+		attr = get_u8(frm);
+		printf("AttributeID: 0x%02x (%s)\n", attr, attr2str(attr));
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
@@ -693,6 +789,10 @@ static void avrcp_pdu_dump(int level, struct frame *frm, uint8_t ctype)
 	case AVRCP_SET_PLAYER_VALUE:
 		avrcp_set_player_value_dump(level + 1, frm, ctype, len);
 		break;
+	case AVRCP_GET_PLAYER_ATTRIBUTE_TEXT:
+		avrcp_get_player_attribute_text_dump(level + 1, frm, ctype,
+									len);
+		break;
 	default:
 		raw_dump(level, frm);
 	}
-- 
1.7.6

