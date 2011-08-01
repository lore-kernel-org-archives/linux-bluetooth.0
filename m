Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH hcidump 05/13] Add parsing for AVRCP GetCurrentPlayerApplicationSettingValue pdu
Date: Mon,  1 Aug 2011 11:42:10 +0300
Message-Id: <1312188138-32265-6-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1312188138-32265-1-git-send-email-luiz.dentz@gmail.com>
References: <1312188138-32265-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 parser/avrcp.c |   59 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 59 insertions(+), 0 deletions(-)

diff --git a/parser/avrcp.c b/parser/avrcp.c
index e6f8755..bb0dd1d 100644
--- a/parser/avrcp.c
+++ b/parser/avrcp.c
@@ -558,6 +558,61 @@ response:
 	}
 }
 
+static void avrcp_get_current_player_value_dump(int level, struct frame *frm,
+						uint8_t ctype, uint16_t len)
+{
+	uint8_t num;
+
+	p_indent(level, frm);
+
+	if (len < 2) {
+		printf("PDU Malformed\n");
+		raw_dump(level, frm);
+		return;
+	}
+
+	if (ctype > AVC_CTYPE_GENERAL_INQUIRY)
+		goto response;
+
+	num = get_u8(frm);
+	printf("AttributeCount: 0x%02x\n", num);
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
+	num = get_u8(frm);
+	printf("ValueCount: 0x%02x\n", num);
+
+	for (; num > 0; num--) {
+		uint8_t attr, player, value;
+
+		p_indent(level, frm);
+
+		attr = get_u8(frm);
+		printf("AttributeID: 0x%02x (%s)\n", attr, attr2str(attr));
+
+		p_indent(level, frm);
+
+		player = get_u8(frm);
+		printf("Player: 0x%02x\n", player);
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
@@ -596,6 +651,10 @@ static void avrcp_pdu_dump(int level, struct frame *frm, uint8_t ctype)
 	case AVRCP_LIST_PLAYER_VALUES:
 		avrcp_list_player_values_dump(level + 1, frm, ctype, len);
 		break;
+	case AVRCP_GET_CURRENT_PLAYER_VALUE:
+		avrcp_get_current_player_value_dump(level + 1, frm, ctype,
+									len);
+		break;
 	default:
 		raw_dump(level, frm);
 	}
-- 
1.7.6

