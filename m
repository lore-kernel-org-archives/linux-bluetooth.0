Return-Path: <cyrus@holtmann.org>
From: Bharat Panda <bharat.panda@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: cpgs@samsung.com, Bharat Panda <bharat.panda@samsung.com>
Subject: [PATCH  4/4] monitor: Add MediaElementItem for GetFolderItems
Date: Thu, 16 Apr 2015 18:46:40 +0530
Message-id: <1429190200-13911-4-git-send-email-bharat.panda@samsung.com>
In-reply-to: <1429190200-13911-1-git-send-email-bharat.panda@samsung.com>
References: <1429190200-13911-1-git-send-email-bharat.panda@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add support for decoding GetFolderItems(MediaElementItem) for avrcp in
bluetooth monitor.

      Channel: 65 len 20 ctrl 0x0000 [PSM 27 mode 3] {chan 1}
      I-frame: Unsegmented TxSeq 0 ReqSeq 0
      AVCTP Browsing: Command: type 0x00 label 0 PID 0x110e
        AVRCP: GetFolderItems: len 0x000a
          Scope: 0x01 (Media Player Virtual Filesystem)
          StartItem: 0x00000000 (0)
          EndItem: 0x0000000a (10)
          AttributeCount: 0xff (255)
          AttributeID: 0x0000326e (Reserved)
---
 monitor/avctp.c | 111 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 111 insertions(+)

diff --git a/monitor/avctp.c b/monitor/avctp.c
index 7e55bef..4fcbfa1 100644
--- a/monitor/avctp.c
+++ b/monitor/avctp.c
@@ -770,6 +770,18 @@ static const char *foldertype2str(uint8_t type)
 	return "Reserved";
 }
 
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
 static bool avrcp_passthrough_packet(struct avctp_frame *avctp_frame,
 								uint8_t indent)
 {
@@ -1847,6 +1859,101 @@ static bool avrcp_folder_item(struct avctp_frame *avctp_frame,
 	return true;
 }
 
+static bool avrcp_attribute_entry_list(struct avctp_frame *avctp_frame,
+						uint8_t indent, uint8_t count)
+{
+	struct l2cap_frame *frame = &avctp_frame->l2cap_frame;
+
+	for (; count > 0; count--) {
+		uint32_t attr;
+		uint16_t charset;
+		uint8_t len;
+
+		if (!l2cap_frame_get_be32(frame, &attr))
+			return false;
+
+		print_field("%*cAttributeID: 0x%08x (%s)", indent, ' ',
+						attr, mediattr2str(attr));
+
+		if (!l2cap_frame_get_be16(frame, &charset))
+			return false;
+
+		print_field("%*cCharsetID: 0x%04x (%s)", indent, ' ',
+						charset, charset2str(charset));
+
+		if (!l2cap_frame_get_u8(frame, &len))
+			return false;
+
+		print_field("%*cAttributeLength: 0x%02x (%u)", indent, ' ',
+						len, len);
+
+		print_field("%*cAttributeValue: ", indent, ' ');
+		for (; len > 0; len--) {
+			uint8_t c;
+
+			if (!l2cap_frame_get_u8(frame, &c))
+				return false;
+
+			printf("%1c", isprint(c) ? c : '.');
+		}
+	}
+
+	return true;
+}
+
+static bool avrcp_media_element_item(struct avctp_frame *avctp_frame,
+							uint8_t indent)
+{
+	struct l2cap_frame *frame = &avctp_frame->l2cap_frame;
+	uint64_t uid;
+	uint16_t charset, namelen;
+	uint8_t type, count;
+
+	if (!l2cap_frame_get_be64(frame, &uid))
+		return false;
+
+	print_field("%*cElementUID: 0x%16" PRIx64 " (%" PRIu64 ")",
+					indent, ' ', uid, uid);
+
+	if (!l2cap_frame_get_u8(frame, &type))
+		return false;
+
+	print_field("%*cElementType: 0x%02x (%s)", indent, ' ',
+					type, elementtype2str(type));
+
+	if (!l2cap_frame_get_be16(frame, &charset))
+		return false;
+
+	print_field("%*cCharsetID: 0x%04x (%s)", indent, ' ',
+					charset, charset2str(charset));
+
+	if (!l2cap_frame_get_be16(frame, &namelen))
+		return false;
+
+	print_field("%*cNameLength: 0x%04x (%u)", indent, ' ',
+					namelen, namelen);
+
+	print_field("%*cName: ", indent, ' ');
+	for (; namelen > 0; namelen--) {
+		uint8_t c;
+		if (!l2cap_frame_get_u8(frame, &c))
+			return false;
+
+		printf("%1c", isprint(c) ? c : '.');
+	}
+
+	if (!l2cap_frame_get_u8(frame, &count))
+		return false;
+
+	print_field("%*cAttributeCount: 0x%02x (%u)", indent, ' ',
+						count, count);
+
+	if (!avrcp_attribute_entry_list(avctp_frame, indent, count))
+		return false;
+
+	return true;
+}
+
 static bool avrcp_get_folder_items(struct avctp_frame *avctp_frame)
 {
 	struct l2cap_frame *frame = &avctp_frame->l2cap_frame;
@@ -1930,6 +2037,10 @@ response:
 			avrcp_folder_item(avctp_frame, indent);
 			break;
 		case AVRCP_MEDIA_ELEMENT_ITEM_TYPE:
+			avrcp_media_element_item(avctp_frame, indent);
+			break;
+		default:
+			print_field("%*cUnknown Media Item type", indent, ' ');
 			packet_hexdump(frame->data, frame->size);
 			break;
 		}
-- 
1.9.1

