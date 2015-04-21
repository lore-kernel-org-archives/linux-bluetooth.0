Return-Path: <cyrus@holtmann.org>
From: Bharat Panda <bharat.panda@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: cpgs@samsung.com, Bharat Panda <bharat.panda@samsung.com>
Subject: [PATCH  3/3] monitor: Add support for AVRCP GeneralReject
Date: Tue, 21 Apr 2015 17:35:47 +0530
Message-id: <1429617947-5784-4-git-send-email-bharat.panda@samsung.com>
In-reply-to: <1429617947-5784-1-git-send-email-bharat.panda@samsung.com>
References: <1429617947-5784-1-git-send-email-bharat.panda@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Support for AVRCP GeneralReject added to btmon.
---
 monitor/avctp.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/monitor/avctp.c b/monitor/avctp.c
index ccafc80..e03e527 100644
--- a/monitor/avctp.c
+++ b/monitor/avctp.c
@@ -1954,6 +1954,30 @@ static bool avrcp_media_element_item(struct avctp_frame *avctp_frame,
 	return true;
 }
 
+static bool avrcp_general_reject(struct avctp_frame *avctp_frame)
+{
+	struct l2cap_frame *frame = &avctp_frame->l2cap_frame;
+	uint8_t status, indent = 2;
+
+	if (avctp_frame->hdr & 0x02)
+		goto response;
+
+	print_field("%*cPDU Malformed", indent, ' ');
+	packet_hexdump(frame->data, frame->size);
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
+	return true;
+}
+
+
 static bool avrcp_search_item(struct avctp_frame *avctp_frame)
 {
 	struct l2cap_frame *frame = &avctp_frame->l2cap_frame;
@@ -2282,6 +2306,9 @@ static bool avrcp_browsing_packet(struct avctp_frame *avctp_frame)
 	case AVRCP_SEARCH:
 		avrcp_search_item(avctp_frame);
 		break;
+	case AVRCP_GENERAL_REJECT:
+		avrcp_general_reject(avctp_frame);
+		break;
 	default:
 		packet_hexdump(frame->data, frame->size);
 	}
-- 
1.9.1

