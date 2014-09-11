Return-Path: <cyrus@holtmann.org>
From: Vikrampal Yadav <vikram.pal@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, d.kasatkin@samsung.com,
	vikram.pal@samsung.com, cpgs@samsung.com
Subject: [PATCH 2/2] monitor: Add AVRCP GetElementAttributes support
Date: Thu, 11 Sep 2014 18:05:12 +0530
Message-id: <1410438912-14213-2-git-send-email-vikram.pal@samsung.com>
In-reply-to: <1410438912-14213-1-git-send-email-vikram.pal@samsung.com>
References: <1410438912-14213-1-git-send-email-vikram.pal@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Support for decoding AVRCP GetElementAttributes added in Bluetooth
monitor.
---
 monitor/avctp.c | 157 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 157 insertions(+)

diff --git a/monitor/avctp.c b/monitor/avctp.c
index 41b6380..505cc5d 100644
--- a/monitor/avctp.c
+++ b/monitor/avctp.c
@@ -158,12 +158,27 @@
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
 struct avctp_frame {
 	uint8_t hdr;
 	uint8_t pt;
 	struct l2cap_frame *l2cap_frame;
 };
 
+static struct avrcp_continuing {
+	uint16_t num;
+	uint16_t size;
+} avrcp_continuing;
+
 static const char *ctype2str(uint8_t ctype)
 {
 	switch (ctype & 0x0f) {
@@ -523,6 +538,30 @@ static const char *charset2str(uint16_t charset)
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
 static bool avrcp_passthrough_packet(struct avctp_frame *avctp_frame)
 {
 	struct l2cap_frame *frame = avctp_frame->l2cap_frame;
@@ -904,6 +943,123 @@ static bool avrcp_displayable_charset(struct avctp_frame *avctp_frame,
 	return true;
 }
 
+static bool avrcp_get_element_attributes(struct avctp_frame *avctp_frame,
+						uint8_t ctype, uint8_t len,
+						uint8_t indent)
+{
+	struct l2cap_frame *frame = avctp_frame->l2cap_frame;
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
+	if (avctp_frame->pt == AVRCP_PACKET_TYPE_SINGLE
+				|| avctp_frame->pt == AVRCP_PACKET_TYPE_START) {
+		if (!l2cap_frame_get_u8(frame, &num))
+			return false;
+
+		avrcp_continuing.num = num;
+		print_field("%*cAttributeCount: 0x%02x", (indent - 8),
+								' ', num);
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
 	bool (*func) (struct avctp_frame *avctp_frame, uint8_t ctype,
@@ -919,6 +1075,7 @@ static const struct avrcp_ctrl_pdu_data avrcp_ctrl_pdu_table[] = {
 	{ 0x15, avrcp_get_player_attribute_text		},
 	{ 0x16, avrcp_get_player_value_text		},
 	{ 0x17, avrcp_displayable_charset		},
+	{ 0x20, avrcp_get_element_attributes		},
 	{ }
 };
 
-- 
1.9.1

