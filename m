Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH hcidump 03/13] Add parsing for AVRCP ListPlayerApplicationSettingAttributes pdu
Date: Mon,  1 Aug 2011 11:42:08 +0300
Message-Id: <1312188138-32265-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1312188138-32265-1-git-send-email-luiz.dentz@gmail.com>
References: <1312188138-32265-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 parser/avrcp.c |   51 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 51 insertions(+), 0 deletions(-)

diff --git a/parser/avrcp.c b/parser/avrcp.c
index 025805e..7daba13 100644
--- a/parser/avrcp.c
+++ b/parser/avrcp.c
@@ -150,6 +150,13 @@
 #define AVRCP_STATUS_NO_AVAILABLE_PLAYERS		0x15
 #define AVRCP_STATUS_ADDRESSED_PLAYER_CHANGED		0x16
 
+/* player attributes */
+#define AVRCP_ATTRIBUTE_ILEGAL		0x00
+#define AVRCP_ATTRIBUTE_EQUALIZER	0x01
+#define AVRCP_ATTRIBUTE_REPEAT_MODE	0x02
+#define AVRCP_ATTRIBUTE_SHUFFLE		0x03
+#define AVRCP_ATTRIBUTE_SCAN		0x04
+
 static const char *ctype2str(uint8_t ctype)
 {
 	switch (ctype & 0x0f) {
@@ -419,6 +426,47 @@ static void avrcp_get_capabilities_dump(int level, struct frame *frm, uint16_t l
 	}
 }
 
+static const char *attr2str(uint8_t attr)
+{
+	switch (attr) {
+	case AVRCP_ATTRIBUTE_ILEGAL:
+		return "Illegal";
+	case AVRCP_ATTRIBUTE_EQUALIZER:
+		return "Equalizer ON/OFF Status";
+	case AVRCP_ATTRIBUTE_REPEAT_MODE:
+		return "Repeat Mode Status";
+	case AVRCP_ATTRIBUTE_SHUFFLE:
+		return "Shuffle ON/OFF Status";
+	case AVRCP_ATTRIBUTE_SCAN:
+		return "Scan ON/OFF Status";
+	default:
+		return "Unknown";
+	}
+}
+
+static void avrcp_list_player_attributes_dump(int level, struct frame *frm,
+								uint16_t len)
+{
+	uint8_t num;
+
+	if (len == 0)
+		return;
+
+	p_indent(level, frm);
+
+	num = get_u8(frm);
+	printf("AttributeCount: 0x%02x\n", num);
+
+	for (; num > 0; num--) {
+		uint8_t attr;
+
+		p_indent(level, frm);
+
+		attr = get_u8(frm);
+		printf("AttributeID: 0x%02x (%s)\n", attr, attr2str(attr));
+	}
+}
+
 static void avrcp_pdu_dump(int level, struct frame *frm, uint8_t ctype)
 {
 	uint8_t pduid, pt;
@@ -451,6 +499,9 @@ static void avrcp_pdu_dump(int level, struct frame *frm, uint8_t ctype)
 	case AVRCP_GET_CAPABILITIES:
 		avrcp_get_capabilities_dump(level + 1, frm, len);
 		break;
+	case AVRCP_LIST_PLAYER_ATTRIBUTES:
+		avrcp_list_player_attributes_dump(level + 1, frm, len);
+		break;
 	default:
 		raw_dump(level, frm);
 	}
-- 
1.7.6

