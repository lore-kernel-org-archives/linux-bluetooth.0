Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC hcidump 6/8] AVRCP: Add parsing for PlayItem PDU
Date: Wed, 15 Aug 2012 16:32:07 +0300
Message-Id: <1345037529-1828-6-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1345037529-1828-1-git-send-email-luiz.dentz@gmail.com>
References: <1345037529-1828-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 parser/avrcp.c | 73 +++++++++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 57 insertions(+), 16 deletions(-)

diff --git a/parser/avrcp.c b/parser/avrcp.c
index 046368c..47dfc9b 100644
--- a/parser/avrcp.c
+++ b/parser/avrcp.c
@@ -1342,6 +1342,60 @@ response:
 	}
 }
 
+static const char *scope2str(uint8_t scope)
+{
+	switch (scope) {
+	case AVRCP_MEDIA_PLAYER_LIST:
+		return "Media Player List";
+	case AVRCP_MEDIA_PLAYER_VFS:
+		return "Media Player Virtual Filesystem";
+	case AVRCP_MEDIA_SEARCH:
+		return "Search";
+	case AVRCP_MEDIA_NOW_PLAYING:
+		return "Now Playing";
+	default:
+		return "Unknown";
+	}
+}
+
+static void avrcp_play_item_dump(int level, struct frame *frm,
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
+	if (len < 13) {
+		printf("PDU Malformed\n");
+		raw_dump(level, frm);
+		return;
+	}
+
+	scope = get_u8(frm);
+	printf("Scope: 0x%02x (%s)", scope, scope2str(scope));
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
@@ -1414,6 +1468,9 @@ static void avrcp_pdu_dump(int level, struct frame *frm, uint8_t ctype)
 	case AVRCP_SET_ADDRESSED_PLAYER:
 		avrcp_set_addressed_player(level + 1, frm, ctype, len);
 		break;
+	case AVRCP_PLAY_ITEM:
+		avrcp_play_item_dump(level + 1, frm, ctype, len);
+		break;
 	default:
 		raw_dump(level, frm);
 	}
@@ -1507,22 +1564,6 @@ static const char *subunit2str(uint8_t subunit)
 	}
 }
 
-static const char *scope2str(uint8_t scope)
-{
-	switch (scope) {
-	case AVRCP_MEDIA_PLAYER_LIST:
-		return "Media Player List";
-	case AVRCP_MEDIA_PLAYER_VFS:
-		return "Media Player Virtual Filesystem";
-	case AVRCP_MEDIA_SEARCH:
-		return "Search";
-	case AVRCP_MEDIA_NOW_PLAYING:
-		return "Now Playing";
-	default:
-		return "Unknown";
-	}
-}
-
 static const char *playertype2str(uint8_t type)
 {
 	switch (type & 0x0F) {
-- 
1.7.11.2

