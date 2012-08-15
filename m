Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC hcidump 5/8] AVRCP: Add parsing for GetItemAttributes PDU
Date: Wed, 15 Aug 2012 16:32:06 +0300
Message-Id: <1345037529-1828-5-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1345037529-1828-1-git-send-email-luiz.dentz@gmail.com>
References: <1345037529-1828-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 parser/avrcp.c | 129 ++++++++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 101 insertions(+), 28 deletions(-)

diff --git a/parser/avrcp.c b/parser/avrcp.c
index 7059cb8..046368c 100644
--- a/parser/avrcp.c
+++ b/parser/avrcp.c
@@ -1718,6 +1718,41 @@ static const char *elementtype2str(uint8_t type)
 	return "Reserved";
 }
 
+static void avrcp_attribute_entry_list_dump(int level, struct frame *frm,
+								uint8_t count)
+{
+	for (; count > 0; count--) {
+		uint32_t attr;
+		uint16_t charset;
+		uint8_t len;
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
+		len = get_u8(frm);
+		printf("AttributeLength: 0x%02x (%u)\n", len, len);
+
+		p_indent(level, frm);
+
+		printf("AttributeValue: ");
+		for (; len > 0; len--) {
+			uint8_t c = get_u8(frm);
+			printf("%1c", isprint(c) ? c : '.');
+		}
+		printf("\n");
+	}
+}
+
 static void avrcp_media_element_item_dump(int level, struct frame *frm,
 								uint16_t len)
 {
@@ -1763,34 +1798,7 @@ static void avrcp_media_element_item_dump(int level, struct frame *frm,
 	count = get_u8(frm);
 	printf("AttributeCount: 0x%02x (%u)\n", count, count);
 
-	for (; count > 0; count--) {
-		uint32_t attr;
-
-		p_indent(level, frm);
-
-		attr = get_u32(frm);
-		printf("AttributeID: 0x%08x (%s)\n", attr, mediattr2str(attr));
-
-		p_indent(level, frm);
-
-		charset = get_u16(frm);
-		printf("CharsetID: 0x%04x (%s)\n", charset,
-							charset2str(charset));
-
-		p_indent(level, frm);
-
-		namelen = get_u8(frm);
-		printf("AttributeLength: 0x%02x (%u)\n", namelen, namelen);
-
-		p_indent(level, frm);
-
-		printf("AttributeValue: ");
-		for (; namelen > 0; namelen--) {
-			uint8_t c = get_u8(frm);
-			printf("%1c", isprint(c) ? c : '.');
-		}
-		printf("\n");
-	}
+	avrcp_attribute_entry_list_dump(level, frm, count);
 }
 
 static void avrcp_get_folder_items_dump(int level, struct frame *frm,
@@ -1944,6 +1952,68 @@ response:
 	printf("Number of Items: 0x%04x (%u)", items, items);
 }
 
+static void avrcp_get_item_attributes_dump(int level, struct frame *frm,
+						uint8_t hdr, uint16_t len)
+{
+	uint64_t uid;
+	uint32_t uidcounter;
+	uint8_t scope, count, status;
+
+	p_indent(level, frm);
+
+	if (hdr & 0x02)
+		goto response;
+
+	if (len < 12) {
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
+	p_indent(level, frm);
+
+	count = get_u32(frm);
+	printf("AttributeCount: 0x%04x (%u)", count, count);
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
+	count = get_u32(frm);
+	printf("AttributeCount: 0x%04x (%u)", count, count);
+
+	avrcp_attribute_entry_list_dump(level, frm, count);
+}
+
 static void avrcp_browsing_dump(int level, struct frame *frm, uint8_t hdr)
 {
 	uint8_t pduid;
@@ -1971,6 +2041,9 @@ static void avrcp_browsing_dump(int level, struct frame *frm, uint8_t hdr)
 	case AVRCP_CHANGE_PATH:
 		avrcp_change_path_dump(level + 1, frm, hdr, len);
 		break;
+	case AVRCP_GET_ITEM_ATTRIBUTES:
+		avrcp_get_item_attributes_dump(level + 1, frm, hdr, len);
+		break;
 	default:
 		raw_dump(level, frm);
 	}
-- 
1.7.11.2

