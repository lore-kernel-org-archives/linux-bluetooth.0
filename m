Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH hcidump 11/13] Add parsing for AVRCP GetElementAttributes pdu
Date: Mon,  1 Aug 2011 11:42:16 +0300
Message-Id: <1312188138-32265-12-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1312188138-32265-1-git-send-email-luiz.dentz@gmail.com>
References: <1312188138-32265-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 parser/avrcp.c |  114 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 114 insertions(+), 0 deletions(-)

diff --git a/parser/avrcp.c b/parser/avrcp.c
index bb7bcbb..49a7145 100644
--- a/parser/avrcp.c
+++ b/parser/avrcp.c
@@ -158,6 +158,16 @@
 #define AVRCP_ATTRIBUTE_SHUFFLE		0x03
 #define AVRCP_ATTRIBUTE_SCAN		0x04
 
+/* media attributes */
+#define AVRCP_MEDIA_ATTRIBUTE_ILLEGAL	0x0
+#define AVRCP_MEDIA_ATTRIBUTE_TITLE	0x1
+#define AVRCP_MEDIA_ATTRIBUTE_ARTIST	0x2
+#define AVRCP_MEDIA_ATTRIBUTE_ALBUM	0x3
+#define AVRCP_MEDIA_ATTRIBUTE_TRACK	0x4
+#define AVRCP_MEDIA_ATTRIBUTE_TOTAL	0x5
+#define AVRCP_MEDIA_ATTRIBUTE_GENRE	0x6
+#define AVRCP_MEDIA_ATTRIBUTE_PROGRESS	0x7
+
 static const char *ctype2str(uint8_t ctype)
 {
 	switch (ctype & 0x0f) {
@@ -879,6 +889,107 @@ static void avrcp_ct_battery_status_dump(int level, struct frame *frm,
 	printf("BatteryStatus: 0x%02x (%s)\n", status, status2str(status));
 }
 
+static const char *mediattr2str(uint32_t attr)
+{
+	switch (attr) {
+	case AVRCP_MEDIA_ATTRIBUTE_ILLEGAL:
+		return "Illegal";
+	case AVRCP_MEDIA_ATTRIBUTE_TITLE:
+		return "Title";
+	case AVRCP_MEDIA_ATTRIBUTE_ARTIST:
+		return "Artist";
+	case AVRCP_MEDIA_ATTRIBUTE_ALBUM:
+		return "Album";
+	case AVRCP_MEDIA_ATTRIBUTE_TRACK:
+		return "Track";
+	case AVRCP_MEDIA_ATTRIBUTE_TOTAL:
+		return "Track Total";
+	case AVRCP_MEDIA_ATTRIBUTE_GENRE:
+		return "Genre";
+	case AVRCP_MEDIA_ATTRIBUTE_PROGRESS:
+		return "Progress";
+	default:
+		return "Reserved";
+	}
+}
+
+static void avrcp_get_element_attributes_dump(int level, struct frame *frm,
+						uint8_t ctype, uint16_t len)
+{
+	uint64_t id;
+	uint8_t num;
+
+	p_indent(level, frm);
+
+	if (ctype > AVC_CTYPE_GENERAL_INQUIRY)
+		goto response;
+
+	if (len < 9) {
+		printf("PDU Malformed\n");
+		raw_dump(level, frm);
+		return;
+	}
+
+	id = get_u64(frm);
+	printf("Identifier: 0x%jx (%s)\n", id, id ? "Reserved" : "PLAYING");
+
+	p_indent(level, frm);
+
+	num = get_u8(frm);
+	printf("AttributeCount: 0x%02x\n", num);
+
+	for (; num > 0; num--) {
+		uint32_t attr;
+
+		p_indent(level, frm);
+
+		attr = get_u32(frm);
+		printf("Attribute: 0x%08x (%s)\n", attr, mediattr2str(attr));
+	}
+
+	return;
+
+response:
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
+		uint32_t attr;
+		uint16_t charset, len;
+
+		p_indent(level, frm);
+
+		attr = get_u32(frm);
+		printf("Attribute: 0x%08x (%s)\n", attr, mediattr2str(attr));
+
+		p_indent(level, frm);
+
+		charset = get_u16(frm);
+		printf("CharsetID: 0x%04x (%s)\n", charset,
+							charset2str(charset));
+
+		p_indent(level, frm);
+
+		len = get_u16(frm);
+		printf("AttributeValueLength: 0x%04x\n", len);
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
 static void avrcp_pdu_dump(int level, struct frame *frm, uint8_t ctype)
 {
 	uint8_t pduid, pt;
@@ -937,6 +1048,9 @@ static void avrcp_pdu_dump(int level, struct frame *frm, uint8_t ctype)
 	case AVRCP_CT_BATTERY_STATUS:
 		avrcp_ct_battery_status_dump(level + 1, frm, ctype, len);
 		break;
+	case AVRCP_GET_ELEMENT_ATTRIBUTES:
+		avrcp_get_element_attributes_dump(level + 1, frm, ctype, len);
+		break;
 	default:
 		raw_dump(level, frm);
 	}
-- 
1.7.6

