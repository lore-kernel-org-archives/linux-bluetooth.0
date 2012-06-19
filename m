Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH hcidump 1/2 v2] AVRCP: Add parsing for SetAddressedPlayer PDU
Date: Tue, 19 Jun 2012 14:40:29 +0300
Message-Id: <1340106030-30782-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
v2: Also prints PlayerID in decimal

 parser/avrcp.c |   35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/parser/avrcp.c b/parser/avrcp.c
index 850741b..5587da7 100644
--- a/parser/avrcp.c
+++ b/parser/avrcp.c
@@ -1222,6 +1222,38 @@ static void avrcp_set_absolute_volume_dump(int level, struct frame *frm,
 	printf("Volume: %.2f%% (%d/127)\n", value/1.27, value);
 }
 
+static void avrcp_set_addressed_player(int level, struct frame *frm,
+						uint8_t ctype, uint16_t len)
+{
+	uint16_t id;
+	uint8_t status;
+
+	p_indent(level, frm);
+
+	if (ctype > AVC_CTYPE_GENERAL_INQUIRY)
+		goto response;
+
+	if (len < 2) {
+		printf("PDU Malformed\n");
+		raw_dump(level, frm);
+		return;
+	}
+
+	id = get_u16(frm);
+	printf("PlayerID: 0x%04x (%u)", id, id);
+	return;
+
+response:
+	if (len < 1) {
+		printf("PDU Malformed\n");
+		raw_dump(level, frm);
+		return;
+	}
+
+	status = get_u8(frm);
+	printf("Status: 0x%02x (%s)\n", status, error2str(status));
+}
+
 static void avrcp_pdu_dump(int level, struct frame *frm, uint8_t ctype)
 {
 	uint8_t pduid, pt;
@@ -1291,6 +1323,9 @@ static void avrcp_pdu_dump(int level, struct frame *frm, uint8_t ctype)
 	case AVRCP_SET_ABSOLUTE_VOLUME:
 		avrcp_set_absolute_volume_dump(level + 1, frm, ctype, len);
 		break;
+	case AVRCP_SET_ADDRESSED_PLAYER:
+		avrcp_set_addressed_player(level + 1, frm, ctype, len);
+		break;
 	default:
 		raw_dump(level, frm);
 	}
-- 
1.7.10.2

