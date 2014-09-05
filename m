Return-Path: <cyrus@holtmann.org>
From: Vikrampal Yadav <vikram.pal@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, d.kasatkin@samsung.com,
	vikram.pal@samsung.com, cpgs@samsung.com
Subject: [PATCH] monitor: Add AVRCP GetElementAttributes
Date: Fri, 05 Sep 2014 19:42:15 +0530
Message-id: <1409926335-20920-1-git-send-email-vikram.pal@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Support for decoding AVRCP GetElementAttributes added in Bluetooth
monitor.
---
 monitor/avctp.c | 157 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 monitor/l2cap.h |  16 +++---
 2 files changed, 166 insertions(+), 7 deletions(-)

diff --git a/monitor/avctp.c b/monitor/avctp.c
index c7e242b..ac1756c 100644
--- a/monitor/avctp.c
+++ b/monitor/avctp.c
@@ -158,6 +158,21 @@
 #define AVRCP_ATTRIBUTE_SHUFFLE		0x03
 #define AVRCP_ATTRIBUTE_SCAN		0x04
 
+/* media attributes */
+#define AVRCP_MEDIA_ATTRIBUTE_ILLEGAL	0x00
+#define AVRCP_MEDIA_ATTRIBUTE_TITLE	0x01
+#define AVRCP_MEDIA_ATTRIBUTE_ARTIST	0x02
+#define AVRCP_MEDIA_ATTRIBUTE_ALBUM	0x03
+#define AVRCP_MEDIA_ATTRIBUTE_TRACK	0x04
+#define AVRCP_MEDIA_ATTRIBUTE_TOTAL	0x05
+#define AVRCP_MEDIA_ATTRIBUTE_GENRE	0x06
+#define AVRCP_MEDIA_ATTRIBUTE_DURATION	0x07
+
+static struct avrcp_continuing {
+	uint16_t num;
+	uint16_t size;
+} avrcp_continuing;
+
 static const char *ctype2str(uint8_t ctype)
 {
 	switch (ctype & 0x0f) {
@@ -517,6 +532,30 @@ static const char *charset2str(uint16_t charset)
 	}
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
+	case AVRCP_MEDIA_ATTRIBUTE_DURATION:
+		return "Track duration";
+	default:
+		return "Reserved";
+	}
+}
+
 static bool avrcp_passthrough_packet(struct l2cap_frame *frame)
 {
 	packet_hexdump(frame->data, frame->size);
@@ -884,6 +923,121 @@ static bool avrcp_displayable_charset(struct l2cap_frame *frame, uint8_t ctype,
 	return true;
 }
 
+static bool avrcp_get_element_attributes(struct l2cap_frame *frame,
+						uint8_t ctype, uint8_t len,
+						uint8_t indent)
+{
+	uint64_t id;
+	uint8_t num;
+
+	if (ctype > AVC_CTYPE_GENERAL_INQUIRY)
+		goto response;
+
+	if (!l2cap_frame_get_be64(frame, &id))
+		return false;
+
+	print_field("%*cIdentifier: 0x%jx (%s)", (indent - 8), ' ',
+					id, id ? "Reserved" : "PLAYING");
+
+	if (!l2cap_frame_get_u8(frame, &num))
+		return false;
+
+	print_field("%*cAttributeCount: 0x%02x", (indent - 8), ' ', num);
+
+	for (; num > 0; num--) {
+		uint32_t attr;
+
+		if (!l2cap_frame_get_be32(frame, &attr))
+			return false;
+
+		print_field("%*cAttribute: 0x%08x (%s)", (indent - 8),
+					' ', attr, mediattr2str(attr));
+	}
+
+	return true;
+
+response:
+	if (frame->pkt_type == AVRCP_PACKET_TYPE_SINGLE
+				|| frame->pkt_type == AVRCP_PACKET_TYPE_START) {
+		if (!l2cap_frame_get_u8(frame, &num))
+			return false;
+
+		avrcp_continuing.num = num;
+		print_field("%*cAttributeCount: 0x%02x", (indent - 8), ' ', num);
+		len--;
+	} else {
+		num = avrcp_continuing.num;
+
+		if (avrcp_continuing.size > 0) {
+			uint16_t size;
+
+			if (avrcp_continuing.size > len) {
+				size = len;
+				avrcp_continuing.size -= len;
+			} else {
+				size = avrcp_continuing.size;
+				avrcp_continuing.size = 0;
+			}
+
+			printf("ContinuingAttributeValue: ");
+			for (; size > 0; size--) {
+				uint8_t c;
+
+				if (!l2cap_frame_get_u8(frame, &c))
+					return false;
+
+				printf("%1c", isprint(c) ? c : '.');
+			}
+			printf("\n");
+
+			len -= size;
+		}
+	}
+
+	while (num > 0 && len > 0) {
+		uint32_t attr;
+		uint16_t charset, attrlen;
+
+		if (!l2cap_frame_get_be32(frame, &attr))
+			return false;
+
+		print_field("%*cAttribute: 0x%08x (%s)", (indent - 8),
+						' ', attr, mediattr2str(attr));
+
+		if (!l2cap_frame_get_be16(frame, &charset))
+			return false;
+
+		print_field("%*cCharsetID: 0x%04x (%s)", (indent - 8),
+				' ', charset, charset2str(charset));
+
+		if (!l2cap_frame_get_be16(frame, &attrlen))
+			return false;
+
+		print_field("%*cAttributeValueLength: 0x%04x",
+						(indent - 8), ' ', attrlen);
+
+		len -= sizeof(attr) + sizeof(charset) + sizeof(attrlen);
+		num--;
+
+		print_field("%*cAttributeValue: ", (indent - 8), ' ');
+		for (; attrlen > 0 && len > 0; attrlen--, len--) {
+			uint8_t c;
+
+			if (!l2cap_frame_get_u8(frame, &c))
+				return false;
+
+			printf("%1c", isprint(c) ? c : '.');
+		}
+
+		if (attrlen > 0)
+			avrcp_continuing.size = attrlen;
+	}
+
+	avrcp_continuing.num = num;
+
+	return true;
+}
+
 struct avrcp_ctrl_pdu_data {
 	uint8_t pduid;
 	bool (*func) (struct l2cap_frame *frame, uint8_t ctype, uint8_t len,
@@ -899,6 +1053,7 @@ static const struct avrcp_ctrl_pdu_data avrcp_ctrl_pdu_table[] = {
 	{ 0x15, avrcp_get_player_attribute_text		},
 	{ 0x16, avrcp_get_player_value_text		},
 	{ 0x17, avrcp_displayable_charset		},
+	{ 0x20, avrcp_get_element_attributes		},
 	{ }
 };
 
@@ -932,6 +1087,8 @@ static bool avrcp_pdu_packet(struct l2cap_frame *frame, uint8_t ctype,
 	if (!l2cap_frame_get_be16(frame, &len))
 		return false;
 
+	frame->pkt_type = pt;
+
 	print_indent(indent, COLOR_OFF, "AVRCP: ", pdu2str(pduid), COLOR_OFF,
 					" pt %s len 0x%04x", pt2str(pt), len);
 
diff --git a/monitor/l2cap.h b/monitor/l2cap.h
index 5faaea6..9ade06f 100644
--- a/monitor/l2cap.h
+++ b/monitor/l2cap.h
@@ -33,6 +33,7 @@ struct l2cap_frame {
 	uint16_t psm;
 	uint16_t chan;
 	uint8_t mode;
+	uint8_t pkt_type;
 	const void *data;
 	uint16_t size;
 };
@@ -41,13 +42,14 @@ static inline void l2cap_frame_pull(struct l2cap_frame *frame,
 				const struct l2cap_frame *source, uint16_t len)
 {
 	if (frame != source) {
-		frame->index   = source->index;
-		frame->in      = source->in;
-		frame->handle  = source->handle;
-		frame->cid     = source->cid;
-		frame->psm     = source->psm;
-		frame->chan    = source->chan;
-		frame->mode    = source->mode;
+		frame->index    = source->index;
+		frame->in       = source->in;
+		frame->handle   = source->handle;
+		frame->cid      = source->cid;
+		frame->psm      = source->psm;
+		frame->chan     = source->chan;
+		frame->mode     = source->mode;
+		frame->pkt_type = source->pkt_type;
 	}
 
 	frame->data = source->data + len;
-- 
1.9.1

