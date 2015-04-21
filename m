Return-Path: <cyrus@holtmann.org>
From: Bharat Panda <bharat.panda@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: cpgs@samsung.com, Bharat Panda <bharat.panda@samsung.com>
Subject: [PATCH  1/3] monitor: Add Support for AVRCP GetItemAttributes
Date: Tue, 21 Apr 2015 17:35:45 +0530
Message-id: <1429617947-5784-2-git-send-email-bharat.panda@samsung.com>
In-reply-to: <1429617947-5784-1-git-send-email-bharat.panda@samsung.com>
References: <1429617947-5784-1-git-send-email-bharat.panda@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Support for decoding AVRCP GetItemAttributes added to btmon.

      Channel: 65 len 26 ctrl 0x0102 [PSM 27 mode 3] {chan 1}
      I-frame: Unsegmented TxSeq 1 ReqSeq 1
      AVCTP Browsing: Command: type 0x00 label 0 PID 0x110e
        AVRCP: GetItemAttributes: len 0x0010
          Scope: 0x01 (Media Player Virtual Filesystem)
          UID: 0x0000000000000001 (1)
          UIDCounter: 0x0000 (0)
          AttributeCount: 0x01 (1)
          AttributeID: 0x00000001 (Title)
---
 monitor/avctp.c | 77 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/monitor/avctp.c b/monitor/avctp.c
index f4f3250..95475a0 100644
--- a/monitor/avctp.c
+++ b/monitor/avctp.c
@@ -1954,6 +1954,80 @@ static bool avrcp_media_element_item(struct avctp_frame *avctp_frame,
 	return true;
 }
 
+static bool avrcp_get_item_attributes(struct avctp_frame *avctp_frame)
+{
+	struct l2cap_frame *frame = &avctp_frame->l2cap_frame;
+	uint64_t uid;
+	uint16_t uidcounter;
+	uint8_t scope, count, status, indent = 2;
+
+	if (avctp_frame->hdr & 0x02)
+		goto response;
+
+	if (frame->size < 12) {
+		print_field("%*cPDU Malformed", indent, ' ');
+		packet_hexdump(frame->data, frame->size);
+		return false;
+	}
+
+	if (!l2cap_frame_get_u8(frame, &scope))
+		return false;
+
+	print_field("%*cScope: 0x%02x (%s)", indent, ' ',
+					scope, scope2str(scope));
+
+	if (!l2cap_frame_get_be64(frame, &uid))
+		return false;
+
+	print_field("%*cUID: 0x%016" PRIx64 " (%" PRIu64 ")", indent,
+					' ', uid, uid);
+
+	if (!l2cap_frame_get_be16(frame, &uidcounter))
+		return false;
+
+	print_field("%*cUIDCounter: 0x%04x (%u)", indent, ' ',
+					uidcounter, uidcounter);
+
+	if (!l2cap_frame_get_u8(frame, &count))
+		return false;
+
+	print_field("%*cAttributeCount: 0x%02x (%u)", indent, ' ',
+					count, count);
+
+	for (; count > 0; count--) {
+		uint32_t attr;
+
+		if (!l2cap_frame_get_be32(frame, &attr))
+			return false;
+
+		print_field("%*cAttributeID: 0x%08x (%s)", indent, ' ',
+					attr, mediattr2str(attr));
+	}
+
+	return true;
+
+response:
+	if (!l2cap_frame_get_u8(frame, &status))
+		return false;
+
+	print_field("%*cStatus: 0x%02x (%s)", indent, ' ',
+					status, error2str(status));
+
+	if (frame->size == 1)
+		return false;
+
+	if (!l2cap_frame_get_u8(frame, &count))
+	return false;
+
+	print_field("%*cAttributeCount: 0x%02x (%u)", indent, ' ',
+					count, count);
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
@@ -2136,6 +2210,9 @@ static bool avrcp_browsing_packet(struct avctp_frame *avctp_frame)
 	case AVRCP_GET_FOLDER_ITEMS:
 		avrcp_get_folder_items(avctp_frame);
 		break;
+	case AVRCP_GET_ITEM_ATTRIBUTES:
+		avrcp_get_item_attributes(avctp_frame);
+		break;
 	default:
 		packet_hexdump(frame->data, frame->size);
 	}
-- 
1.9.1

