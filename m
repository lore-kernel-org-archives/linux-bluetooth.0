Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC hcidump 4/8] AVRCP: Add parsing for ChangePath PDU
Date: Wed, 15 Aug 2012 16:32:05 +0300
Message-Id: <1345037529-1828-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1345037529-1828-1-git-send-email-luiz.dentz@gmail.com>
References: <1345037529-1828-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 parser/avrcp.c | 62 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/parser/avrcp.c b/parser/avrcp.c
index 9ceb507..7059cb8 100644
--- a/parser/avrcp.c
+++ b/parser/avrcp.c
@@ -1885,6 +1885,65 @@ response:
 	}
 }
 
+static const char *dir2str(uint8_t dir)
+{
+	switch (dir) {
+	case 0x00:
+		return "Folder Up";
+	case 0x01:
+		return "Folder Down";
+	}
+
+	return "Reserved";
+}
+
+static void avrcp_change_path_dump(int level, struct frame *frm, uint8_t hdr,
+								uint16_t len)
+{
+	uint64_t uid;
+	uint32_t items;
+	uint16_t uidcounter;
+	uint8_t dir, status;
+
+	p_indent(level, frm);
+
+	if (hdr & 0x02)
+		goto response;
+
+	if (len < 11) {
+		printf("PDU Malformed\n");
+		raw_dump(level, frm);
+		return;
+	}
+
+	uidcounter = get_u16(frm);
+	printf("UIDCounter: 0x%04x (%u)\n", uidcounter, uidcounter);
+
+	p_indent(level, frm);
+
+	dir = get_u8(frm);
+	printf("Direction: 0x%02x (%s)\n", dir, dir2str(dir));
+
+	p_indent(level, frm);
+
+	uid = get_u64(frm);
+	printf("FolderUID: 0x%16" PRIx64 " (%" PRIu64 ")\n", uid, uid);
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
+	items = get_u32(frm);
+	printf("Number of Items: 0x%04x (%u)", items, items);
+}
+
 static void avrcp_browsing_dump(int level, struct frame *frm, uint8_t hdr)
 {
 	uint8_t pduid;
@@ -1909,6 +1968,9 @@ static void avrcp_browsing_dump(int level, struct frame *frm, uint8_t hdr)
 	case AVRCP_GET_FOLDER_ITEMS:
 		avrcp_get_folder_items_dump(level + 1, frm, hdr, len);
 		break;
+	case AVRCP_CHANGE_PATH:
+		avrcp_change_path_dump(level + 1, frm, hdr, len);
+		break;
 	default:
 		raw_dump(level, frm);
 	}
-- 
1.7.11.2

