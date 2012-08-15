Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC hcidump 3/8] AVRCP: Add parsing for GetFolderItems PDU
Date: Wed, 15 Aug 2012 16:32:04 +0300
Message-Id: <1345037529-1828-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1345037529-1828-1-git-send-email-luiz.dentz@gmail.com>
References: <1345037529-1828-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 parser/avrcp.c | 389 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 389 insertions(+)

diff --git a/parser/avrcp.c b/parser/avrcp.c
index 5179501..9ceb507 100644
--- a/parser/avrcp.c
+++ b/parser/avrcp.c
@@ -31,6 +31,7 @@
 #include <stdlib.h>
 #include <string.h>
 #include <ctype.h>
+#include <inttypes.h>
 
 #include "parser/parser.h"
 
@@ -179,6 +180,12 @@
 #define AVRCP_PLAY_STATUS_REV_SEEK	0x04
 #define AVRCP_PLAY_STATUS_ERROR		0xFF
 
+/* media scope */
+#define AVRCP_MEDIA_PLAYER_LIST		0x00
+#define AVRCP_MEDIA_PLAYER_VFS		0x01
+#define AVRCP_MEDIA_SEARCH		0x02
+#define AVRCP_MEDIA_NOW_PLAYING		0x03
+
 static struct avrcp_continuing {
 	uint16_t num;
 	uint16_t size;
@@ -1207,6 +1214,7 @@ response:
 		uid = get_u16(frm);
 		printf("PlayerID: 0x%04x (%u)\n", uid, uid);
 
+
 		p_indent(level, frm);
 
 		uid = get_u16(frm);
@@ -1499,6 +1507,384 @@ static const char *subunit2str(uint8_t subunit)
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
+static const char *playertype2str(uint8_t type)
+{
+	switch (type & 0x0F) {
+	case 0x01:
+		return "Audio";
+	case 0x02:
+		return "Video";
+	case 0x03:
+		return "Audio, Video";
+	case 0x04:
+		return "Audio Broadcasting";
+	case 0x05:
+		return "Audio, Audio Broadcasting";
+	case 0x06:
+		return "Video, Audio Broadcasting";
+	case 0x07:
+		return "Audio, Video, Audio Broadcasting";
+	case 0x08:
+		return "Video Broadcasting";
+	case 0x09:
+		return "Audio, Video Broadcasting";
+	case 0x0A:
+		return "Video, Video Broadcasting";
+	case 0x0B:
+		return "Audio, Video, Video Broadcasting";
+	case 0x0C:
+		return "Audio Broadcasting, Video Broadcasting";
+	case 0x0D:
+		return "Audio, Audio Broadcasting, Video Broadcasting";
+	case 0x0E:
+		return "Video, Audio Broadcasting, Video Broadcasting";
+	case 0x0F:
+		return "Audio, Video, Audio Broadcasting, Video Broadcasting";
+	}
+
+	return "None";
+}
+
+static const char *playersubtype2str(uint32_t subtype)
+{
+	switch (subtype & 0x03) {
+	case 0x01:
+		return "Audio Book";
+	case 0x02:
+		return "Podcast";
+	case 0x03:
+		return "Audio Book, Podcast";
+	}
+
+	return "None";
+}
+
+static void avrcp_media_player_item_dump(int level, struct frame *frm,
+								uint16_t len)
+{
+	uint16_t id, charset;
+	uint8_t type, status, namelen;
+	uint32_t subtype;
+	uint64_t features[2];
+
+	p_indent(level, frm);
+
+	if (len < 28) {
+		printf("PDU Malformed\n");
+		raw_dump(level, frm);
+		return;
+	}
+
+	id = get_u16(frm);
+	printf("PlayerID: 0x%04x (%u)\n", id, id);
+
+	p_indent(level, frm);
+
+	type = get_u8(frm);
+	printf("PlayerType: 0x%04x (%s)\n", type, playertype2str(type));
+
+	p_indent(level, frm);
+
+	subtype = get_u32(frm);
+	printf("PlayerSubtype: 0x%08x (%s)\n", subtype,
+						playersubtype2str(subtype));
+
+	p_indent(level, frm);
+
+	status = get_u8(frm);
+	printf("PlayStatus: 0x%02x (%s)\n", status, playstatus2str(status));
+
+	p_indent(level, frm);
+
+	get_u128(frm, &features[0], &features[1]);
+	printf("Features: 0x%16" PRIx64 "%16" PRIx64 "\n", features[1],
+								features[0]);
+
+	p_indent(level, frm);
+
+	charset = get_u16(frm);
+	printf("CharsetID: 0x%04x (%s)\n", charset, charset2str(charset));
+
+	p_indent(level, frm);
+
+	namelen = get_u8(frm);
+	printf("NameLength: 0x%02x (%u)\n", namelen, namelen);
+
+	p_indent(level, frm);
+
+	printf("Name: ");
+	for (; namelen > 0; namelen--) {
+		uint8_t c = get_u8(frm);
+		printf("%1c", isprint(c) ? c : '.');
+	}
+	printf("\n");
+}
+
+static const char *foldertype2str(uint8_t type)
+{
+	switch (type) {
+	case 0x00:
+		return "Mixed";
+	case 0x01:
+		return "Titles";
+	case 0x02:
+		return "Albuns";
+	case 0x03:
+		return "Artists";
+	case 0x04:
+		return "Genres";
+	case 0x05:
+		return "Playlists";
+	case 0x06:
+		return "Years";
+	}
+
+	return "Reserved";
+}
+
+static void avrcp_folder_item_dump(int level, struct frame *frm, uint16_t len)
+{
+	uint8_t type, playable, namelen;
+	uint16_t charset;
+	uint64_t uid;
+
+	p_indent(level, frm);
+
+	if (len < 14) {
+		printf("PDU Malformed\n");
+		raw_dump(level, frm);
+		return;
+	}
+
+	uid = get_u64(frm);
+	printf("FolderUID: 0x%16" PRIx64 " (%" PRIu64 ")\n", uid, uid);
+
+	p_indent(level, frm);
+
+	type = get_u8(frm);
+	printf("FolderType: 0x%02x (%s)\n", type, foldertype2str(type));
+
+	p_indent(level, frm);
+
+	playable = get_u8(frm);
+	printf("IsPlayable: 0x%02x (%s)\n", playable,
+					playable & 0x01 ? "True" : "False");
+
+	p_indent(level, frm);
+
+	charset = get_u16(frm);
+	printf("CharsetID: 0x%04x (%s)\n", charset, charset2str(charset));
+
+	p_indent(level, frm);
+
+	namelen = get_u8(frm);
+	printf("NameLength: 0x%02x (%u)\n", namelen, namelen);
+
+	p_indent(level, frm);
+
+	printf("Name: ");
+	for (; namelen > 0; namelen--) {
+		uint8_t c = get_u8(frm);
+		printf("%1c", isprint(c) ? c : '.');
+	}
+	printf("\n");
+}
+
+static const char *elementtype2str(uint8_t type)
+{
+	switch (type) {
+	case 0x00:
+		return "Audio";
+	case 0x01:
+		return "Video";
+	}
+
+	return "Reserved";
+}
+
+static void avrcp_media_element_item_dump(int level, struct frame *frm,
+								uint16_t len)
+{
+	uint64_t uid;
+	uint16_t charset;
+	uint8_t type, namelen, count;
+
+	if (len < 14) {
+		printf("PDU Malformed\n");
+		raw_dump(level, frm);
+		return;
+	}
+
+	uid = get_u64(frm);
+	printf("ElementUID: 0x%16" PRIx64 " (%" PRIu64 ")\n", uid, uid);
+
+	p_indent(level, frm);
+
+	type = get_u8(frm);
+	printf("ElementType: 0x%02x (%s)\n", type, elementtype2str(type));
+
+	p_indent(level, frm);
+
+	charset = get_u16(frm);
+	printf("CharsetID: 0x%04x (%s)\n", charset, charset2str(charset));
+
+	p_indent(level, frm);
+
+	namelen = get_u8(frm);
+	printf("NameLength: 0x%02x (%u)\n", namelen, namelen);
+
+	p_indent(level, frm);
+
+	printf("Name: ");
+	for (; namelen > 0; namelen--) {
+		uint8_t c = get_u8(frm);
+		printf("%1c", isprint(c) ? c : '.');
+	}
+	printf("\n");
+
+	p_indent(level, frm);
+
+	count = get_u8(frm);
+	printf("AttributeCount: 0x%02x (%u)\n", count, count);
+
+	for (; count > 0; count--) {
+		uint32_t attr;
+
+		p_indent(level, frm);
+
+		attr = get_u32(frm);
+		printf("AttributeID: 0x%08x (%s)\n", attr, mediattr2str(attr));
+
+		p_indent(level, frm);
+
+		charset = get_u16(frm);
+		printf("CharsetID: 0x%04x (%s)\n", charset,
+							charset2str(charset));
+
+		p_indent(level, frm);
+
+		namelen = get_u8(frm);
+		printf("AttributeLength: 0x%02x (%u)\n", namelen, namelen);
+
+		p_indent(level, frm);
+
+		printf("AttributeValue: ");
+		for (; namelen > 0; namelen--) {
+			uint8_t c = get_u8(frm);
+			printf("%1c", isprint(c) ? c : '.');
+		}
+		printf("\n");
+	}
+}
+
+static void avrcp_get_folder_items_dump(int level, struct frame *frm,
+						uint8_t hdr, uint16_t len)
+{
+	uint8_t scope, count, status;
+	uint32_t start, end;
+	uint16_t uid, num;
+
+	p_indent(level, frm);
+
+	if (hdr & 0x02)
+		goto response;
+
+	if (len < 10) {
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
+	start = get_u32(frm);
+	printf("StartItem: 0x%08x (%u)\n", start, start);
+
+	p_indent(level, frm);
+
+	end = get_u32(frm);
+	printf("EndItem: 0x%08x (%u)\n", end, end);
+
+	p_indent(level, frm);
+
+	count = get_u8(frm);
+	printf("AttributeCount: 0x%02x (%u)\n", count, count);
+
+	for (; count > 0; count--) {
+		uint32_t attr;
+
+		p_indent(level, frm);
+
+		attr = get_u32(frm);
+		printf("AttributeID: 0x%08x (%s)\n", attr, mediattr2str(attr));
+	}
+
+	return;
+
+response:
+	status = get_u8(frm);
+	printf("Status: 0x%02x (%s)\n", status, error2str(status));
+
+	if (len == 1)
+		return;
+
+	p_indent(level, frm);
+
+	uid = get_u16(frm);
+	printf("UIDCounter: 0x%04x (%u)\n", uid, uid);
+
+	p_indent(level, frm);
+
+	num = get_u16(frm);
+	printf("Number of Items: 0x%04x (%u)\n", num, num);
+
+	for (; num > 0; num--) {
+		uint8_t type;
+		uint16_t len;
+
+		p_indent(level, frm);
+
+		type = get_u8(frm);
+		len = get_u16(frm);
+		switch (type) {
+		case 0x01:
+			printf("Item: 0x01 (Media Player)) ");
+			printf("Length: 0x%04x (%u)\n", len, len);
+			avrcp_media_player_item_dump(level, frm, len);
+			break;
+		case 0x02:
+			printf("Item: 0x02 (Folder) ");
+			printf("Length: 0x%04x (%u)\n", len, len);
+			avrcp_folder_item_dump(level, frm, len);
+			break;
+		case 0x03:
+			printf("Item: 0x03 (Media Element) ");
+			printf("Length: 0x%04x (%u)\n", len, len);
+			avrcp_media_element_item_dump(level, frm, len);
+			break;
+		}
+	}
+}
+
 static void avrcp_browsing_dump(int level, struct frame *frm, uint8_t hdr)
 {
 	uint8_t pduid;
@@ -1520,6 +1906,9 @@ static void avrcp_browsing_dump(int level, struct frame *frm, uint8_t hdr)
 	case AVRCP_SET_BROWSED_PLAYER:
 		avrcp_set_browsed_player_dump(level + 1, frm, hdr, len);
 		break;
+	case AVRCP_GET_FOLDER_ITEMS:
+		avrcp_get_folder_items_dump(level + 1, frm, hdr, len);
+		break;
 	default:
 		raw_dump(level, frm);
 	}
-- 
1.7.11.2

