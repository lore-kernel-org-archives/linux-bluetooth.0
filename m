Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH hcidump] AVRCP: Add parsing for SetBrowsedPlayer PDU
Date: Wed, 18 Jul 2012 14:11:03 +0300
Message-Id: <1342609863-17028-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 parser/avrcp.c |   73 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/parser/avrcp.c b/parser/avrcp.c
index dfa9ee7..4925c40 100644
--- a/parser/avrcp.c
+++ b/parser/avrcp.c
@@ -1264,6 +1264,76 @@ response:
 	printf("Status: 0x%02x (%s)\n", status, error2str(status));
 }
 
+static void avrcp_set_browsed_player(int level, struct frame *frm,
+						uint8_t ctype, uint16_t len)
+{
+	uint32_t items;
+	uint16_t id, uids, charset;
+	uint8_t status, folders;
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
+	if (len != 1 && len < 10) {
+		printf("PDU Malformed\n");
+		raw_dump(level, frm);
+		return;
+	}
+
+	status = get_u8(frm);
+	printf("Status: 0x%02x (%s)\n", status, error2str(status));
+
+	if (len == 1)
+		return;
+
+	p_indent(level, frm);
+
+	uids = get_u16(frm);
+	printf("UIDCounter: 0x%04x (%u)", uids, uids);
+
+	p_indent(level, frm);
+
+	items = get_u32(frm);
+	printf("Number of Items: 0x%04x (%u)", items, items);
+
+	p_indent(level, frm);
+
+	charset = get_u16(frm);
+	printf("CharsetID: 0x%04x (%s)\n", charset, charset2str(charset));
+
+	p_indent(level, frm);
+
+	folders = get_u8(frm);
+	printf("Folder Depth: 0x%02x (%u)", folders, folders);
+
+	for (; folders > 0; folders--) {
+		uint16_t len;
+
+		p_indent(level, frm);
+
+		len = get_u8(frm);
+		printf("Folder: ");
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
@@ -1336,6 +1406,9 @@ static void avrcp_pdu_dump(int level, struct frame *frm, uint8_t ctype)
 	case AVRCP_SET_ADDRESSED_PLAYER:
 		avrcp_set_addressed_player(level + 1, frm, ctype, len);
 		break;
+	case AVRCP_SET_BROWSED_PLAYER:
+		avrcp_set_browsed_player(level + 1, frm, ctype, len);
+		break;
 	default:
 		raw_dump(level, frm);
 	}
-- 
1.7.10.4

