Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH hcidump 06/13] Add parsing for AVRCP SetPlayerApplicationSettingValue pdu
Date: Mon,  1 Aug 2011 11:42:11 +0300
Message-Id: <1312188138-32265-7-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1312188138-32265-1-git-send-email-luiz.dentz@gmail.com>
References: <1312188138-32265-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 parser/avrcp.c |   38 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 38 insertions(+), 0 deletions(-)

diff --git a/parser/avrcp.c b/parser/avrcp.c
index bb0dd1d..e07e77b 100644
--- a/parser/avrcp.c
+++ b/parser/avrcp.c
@@ -613,6 +613,41 @@ response:
 	}
 }
 
+static void avrcp_set_player_value_dump(int level, struct frame *frm,
+						uint8_t ctype, uint16_t len)
+{
+	uint8_t num;
+
+	p_indent(level, frm);
+
+	if (ctype > AVC_CTYPE_GENERAL_INQUIRY)
+		return;
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
+	for (; num > 0; num--) {
+		uint8_t attr, value;
+
+		p_indent(level, frm);
+
+		attr = get_u8(frm);
+		printf("AttributeID: 0x%02x (%s)\n", attr, attr2str(attr));
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
@@ -655,6 +690,9 @@ static void avrcp_pdu_dump(int level, struct frame *frm, uint8_t ctype)
 		avrcp_get_current_player_value_dump(level + 1, frm, ctype,
 									len);
 		break;
+	case AVRCP_SET_PLAYER_VALUE:
+		avrcp_set_player_value_dump(level + 1, frm, ctype, len);
+		break;
 	default:
 		raw_dump(level, frm);
 	}
-- 
1.7.6

