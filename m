Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC hcidump 8/8] AVRCP: Add parsing for AddToNowPlaying PDU
Date: Wed, 15 Aug 2012 16:32:09 +0300
Message-Id: <1345037529-1828-8-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1345037529-1828-1-git-send-email-luiz.dentz@gmail.com>
References: <1345037529-1828-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 parser/avrcp.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/parser/avrcp.c b/parser/avrcp.c
index 1fb085c..6948689 100644
--- a/parser/avrcp.c
+++ b/parser/avrcp.c
@@ -1396,6 +1396,44 @@ response:
 	printf("Status: 0x%02x (%s)\n", status, error2str(status));
 }
 
+static void avrcp_add_to_now_playing_dump(int level, struct frame *frm,
+						uint8_t ctype, uint16_t len)
+{
+	uint64_t uid;
+	uint32_t uidcounter;
+	uint8_t scope, status;
+
+	p_indent(level, frm);
+
+	if (ctype > AVC_CTYPE_GENERAL_INQUIRY)
+		goto response;
+
+	if (len < 11) {
+		printf("PDU Malformed\n");
+		raw_dump(level, frm);
+		return;
+	}
+
+	scope = get_u8(frm);
+	printf("Scope: 0x%02x (%s)\n", scope, scope2str(scope));
+
+	p_indent(level, frm);
+
+	uid = get_u64(frm);
+	printf("UID: 0x%16" PRIx64 " (%" PRIu64 ")\n", uid, uid);
+
+	p_indent(level, frm);
+
+	uidcounter = get_u16(frm);
+	printf("UIDCounter: 0x%04x (%u)\n", uidcounter, uidcounter);
+
+	return;
+
+response:
+	status = get_u8(frm);
+	printf("Status: 0x%02x (%s)\n", status, error2str(status));
+}
+
 static void avrcp_pdu_dump(int level, struct frame *frm, uint8_t ctype)
 {
 	uint8_t pduid, pt;
@@ -1471,6 +1509,9 @@ static void avrcp_pdu_dump(int level, struct frame *frm, uint8_t ctype)
 	case AVRCP_PLAY_ITEM:
 		avrcp_play_item_dump(level + 1, frm, ctype, len);
 		break;
+	case AVRCP_ADD_TO_NOW_PLAYING:
+		avrcp_add_to_now_playing_dump(level + 1, frm, ctype, len);
+		break;
 	default:
 		raw_dump(level, frm);
 	}
-- 
1.7.11.2

