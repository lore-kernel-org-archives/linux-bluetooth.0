Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH hcidump 09/13] Add parsing for AVRCP InformDisplayableCharacterSet pdu
Date: Mon,  1 Aug 2011 11:42:14 +0300
Message-Id: <1312188138-32265-10-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1312188138-32265-1-git-send-email-luiz.dentz@gmail.com>
References: <1312188138-32265-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 parser/avrcp.c |   33 +++++++++++++++++++++++++++++++++
 1 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/parser/avrcp.c b/parser/avrcp.c
index 5fb5cbe..ababe03 100644
--- a/parser/avrcp.c
+++ b/parser/avrcp.c
@@ -817,6 +817,36 @@ response:
 	}
 }
 
+static void avrcp_displayable_charset(int level, struct frame *frm,
+						uint8_t ctype, uint16_t len)
+{
+	uint8_t num;
+
+	if (ctype > AVC_CTYPE_GENERAL_INQUIRY)
+		return;
+
+	p_indent(level, frm);
+
+	if (len < 2) {
+		printf("PDU Malformed\n");
+		raw_dump(level, frm);
+		return;
+	}
+
+	num = get_u8(frm);
+	printf("CharsetCount: 0x%02x\n", num);
+
+	for (; num > 0; num--) {
+		uint16_t charset;
+
+		p_indent(level, frm);
+
+		charset = get_u16(frm);
+		printf("CharsetID: 0x%04x (%s)\n", charset,
+							charset2str(charset));
+	}
+}
+
 static void avrcp_pdu_dump(int level, struct frame *frm, uint8_t ctype)
 {
 	uint8_t pduid, pt;
@@ -869,6 +899,9 @@ static void avrcp_pdu_dump(int level, struct frame *frm, uint8_t ctype)
 	case AVRCP_GET_PLAYER_VALUE_TEXT:
 		avrcp_get_player_value_text_dump(level + 1, frm, ctype, len);
 		break;
+	case AVRCP_DISPLAYABLE_CHARSET:
+		avrcp_displayable_charset(level + 1, frm, ctype, len);
+		break;
 	default:
 		raw_dump(level, frm);
 	}
-- 
1.7.6

