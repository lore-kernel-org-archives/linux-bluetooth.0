Return-Path: <cyrus@holtmann.org>
From: Bharat Panda <bharat.panda@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: cpgs@samsung.com, Bharat Panda <bharat.panda@samsung.com>
Subject: [PATCH  2/3] monitor: Add support for AVRCP Search
Date: Tue, 21 Apr 2015 17:35:46 +0530
Message-id: <1429617947-5784-3-git-send-email-bharat.panda@samsung.com>
In-reply-to: <1429617947-5784-1-git-send-email-bharat.panda@samsung.com>
References: <1429617947-5784-1-git-send-email-bharat.panda@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Support for AVRCP Search item added to btmon.

      Channel: 65 len 17 ctrl 0x0000 [PSM 27 mode 3] {chan 1}
      I-frame: Unsegmented TxSeq 0 ReqSeq 0
      AVCTP Browsing: Command: type 0x00 label 0 PID 0x110e
        AVRCP: Search: len 0x0007
          CharsetID: 0x006a (UTF-8)
          Length: 0x0003 (3)
          String: New
---
 monitor/avctp.c | 69 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/monitor/avctp.c b/monitor/avctp.c
index 95475a0..ccafc80 100644
--- a/monitor/avctp.c
+++ b/monitor/avctp.c
@@ -1954,6 +1954,72 @@ static bool avrcp_media_element_item(struct avctp_frame *avctp_frame,
 	return true;
 }
 
+static bool avrcp_search_item(struct avctp_frame *avctp_frame)
+{
+	struct l2cap_frame *frame = &avctp_frame->l2cap_frame;
+	uint32_t items;
+	uint16_t charset, namelen, uidcounter;
+	uint8_t status, indent = 2;
+
+	if (avctp_frame->hdr & 0x02)
+		goto response;
+
+	if (frame->size < 4) {
+		printf("PDU Malformed\n");
+		packet_hexdump(frame->data, frame->size);
+		return false;
+	}
+
+	if (!l2cap_frame_get_be16(frame, &charset))
+		return false;
+
+	print_field("%*cCharsetID: 0x%04x (%s)", indent, ' ',
+				charset, charset2str(charset));
+
+	if (!l2cap_frame_get_be16(frame, &namelen))
+		return false;
+
+	print_field("%*cLength: 0x%04x (%u)", indent, ' ', namelen, namelen);
+
+	printf("%*cString: ", indent+8, ' ');
+	for (; namelen > 0; namelen--) {
+		uint8_t c;
+
+		if (!l2cap_frame_get_u8(frame, &c))
+			return false;
+
+		printf("%1c", isprint(c) ? c : '.');
+	}
+
+	printf("\n");
+
+	return true;
+
+response:
+	if (!l2cap_frame_get_u8(frame, &status))
+		return false;
+
+	print_field("%*cStatus: 0x%02x (%s)", indent, ' ',
+				status, error2str(status));
+
+	if (frame->size == 1)
+		return false;
+
+	if (!l2cap_frame_get_be16(frame, &uidcounter))
+		return false;
+
+	print_field("%*cUIDCounter: 0x%04x (%u)", indent, ' ',
+				uidcounter, uidcounter);
+
+	if (!l2cap_frame_get_be32(frame, &items))
+		return false;
+
+	print_field("%*cNumber of Items: 0x%04x (%u)", indent, ' ',
+				items, items);
+
+	return true;
+}
+
 static bool avrcp_get_item_attributes(struct avctp_frame *avctp_frame)
 {
 	struct l2cap_frame *frame = &avctp_frame->l2cap_frame;
@@ -2213,6 +2279,9 @@ static bool avrcp_browsing_packet(struct avctp_frame *avctp_frame)
 	case AVRCP_GET_ITEM_ATTRIBUTES:
 		avrcp_get_item_attributes(avctp_frame);
 		break;
+	case AVRCP_SEARCH:
+		avrcp_search_item(avctp_frame);
+		break;
 	default:
 		packet_hexdump(frame->data, frame->size);
 	}
-- 
1.9.1

