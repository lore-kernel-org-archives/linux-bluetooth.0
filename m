Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC hcidump 7/8] AVRCP: Add parsing for Search PDU
Date: Wed, 15 Aug 2012 16:32:08 +0300
Message-Id: <1345037529-1828-7-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1345037529-1828-1-git-send-email-luiz.dentz@gmail.com>
References: <1345037529-1828-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 parser/avrcp.c | 57 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/parser/avrcp.c b/parser/avrcp.c
index 47dfc9b..1fb085c 100644
--- a/parser/avrcp.c
+++ b/parser/avrcp.c
@@ -2055,6 +2055,60 @@ response:
 	avrcp_attribute_entry_list_dump(level, frm, count);
 }
 
+static void avrcp_search_dump(int level, struct frame *frm, uint8_t hdr,
+								uint16_t len)
+{
+	uint32_t uidcounter, items;
+	uint16_t charset;
+	uint8_t namelen, status;
+
+	p_indent(level, frm);
+
+	if (hdr & 0x02)
+		goto response;
+
+	if (len < 3) {
+		printf("PDU Malformed\n");
+		raw_dump(level, frm);
+		return;
+	}
+
+	charset = get_u16(frm);
+	printf("CharsetID: 0x%04x (%s)\n", charset, charset2str(charset));
+
+	p_indent(level, frm);
+
+	namelen = get_u8(frm);
+	printf("Length: 0x%02x (%u)\n", namelen, namelen);
+
+	p_indent(level, frm);
+
+	printf("String: ");
+	for (; namelen > 0; namelen--) {
+		uint8_t c = get_u8(frm);
+		printf("%1c", isprint(c) ? c : '.');
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
+	uidcounter = get_u16(frm);
+	printf("UIDCounter: 0x%04x (%u)\n", uidcounter, uidcounter);
+
+	p_indent(level, frm);
+
+	items = get_u32(frm);
+	printf("Number of Items: 0x%04x (%u)", items, items);
+}
+
 static void avrcp_browsing_dump(int level, struct frame *frm, uint8_t hdr)
 {
 	uint8_t pduid;
@@ -2085,6 +2139,9 @@ static void avrcp_browsing_dump(int level, struct frame *frm, uint8_t hdr)
 	case AVRCP_GET_ITEM_ATTRIBUTES:
 		avrcp_get_item_attributes_dump(level + 1, frm, hdr, len);
 		break;
+	case AVRCP_SEARCH:
+		avrcp_search_dump(level + 1, frm, hdr, len);
+		break;
 	default:
 		raw_dump(level, frm);
 	}
-- 
1.7.11.2

