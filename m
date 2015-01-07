Return-Path: <cyrus@holtmann.org>
From: Vikrampal Yadav <vikram.pal@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, vikram.pal@samsung.com, cpgs@samsung.com
Subject: [PATCH 6/6] monitor: Add AVRCP SetBrowsedPlayer support
Date: Wed, 07 Jan 2015 13:53:20 +0530
Message-id: <1420619000-24211-7-git-send-email-vikram.pal@samsung.com>
In-reply-to: <1420619000-24211-1-git-send-email-vikram.pal@samsung.com>
References: <1420619000-24211-1-git-send-email-vikram.pal@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Support for decoding AVRCP SetBrowsedPlayer added in Bluetooth monitor.

Channel: 65 len 12 ctrl 0x0102 [PSM 27 mode 3] {chan 1}
      I-frame: Unsegmented TxSeq 1 ReqSeq 1
      AVCTP Browsing: Command: type 0x00 label 0 PID 0x110e
        AVRCP: SetBrowsedPlayer: len 0x0002
          PlayerID: 0x0001 (1)
---
 monitor/avctp.c | 86 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 85 insertions(+), 1 deletion(-)

diff --git a/monitor/avctp.c b/monitor/avctp.c
index af91ecc..0a1e92d 100644
--- a/monitor/avctp.c
+++ b/monitor/avctp.c
@@ -1637,11 +1637,95 @@ static bool avrcp_control_packet(struct avctp_frame *avctp_frame)
 	}
 }
 
+static bool avrcp_set_browsed_player(struct avctp_frame *avctp_frame)
+{
+	struct l2cap_frame *frame = &avctp_frame->l2cap_frame;
+	uint32_t items;
+	uint16_t id, uids, charset;
+	uint8_t status, folders, indent = 2;
+
+	if (avctp_frame->hdr & 0x02)
+		goto response;
+
+	if (!l2cap_frame_get_be16(frame, &id))
+		return false;
+
+	print_field("%*cPlayerID: 0x%04x (%u)", indent, ' ', id, id);
+	return true;
+
+response:
+	if (!l2cap_frame_get_u8(frame, &status))
+		return false;
+
+	print_field("%*cStatus: 0x%02x (%s)", indent, ' ', status,
+							error2str(status));
+
+	if (!l2cap_frame_get_be16(frame, &uids))
+		return false;
+
+	print_field("%*cUIDCounter: 0x%04x (%u)", indent, ' ', uids, uids);
+
+	if (!l2cap_frame_get_be32(frame, &items))
+		return false;
+
+	print_field("%*cNumber of Items: 0x%08x (%u)", indent, ' ',
+								items, items);
+
+	if (!l2cap_frame_get_be16(frame, &charset))
+		return false;
+
+	print_field("%*cCharsetID: 0x%04x (%s)", indent, ' ', charset,
+							charset2str(charset));
+
+	if (!l2cap_frame_get_u8(frame, &folders))
+		return false;
+
+	print_field("%*cFolder Depth: 0x%02x (%u)", indent, ' ', folders,
+								folders);
+
+	for (; folders > 0; folders--) {
+		uint8_t len;
+
+		if (!l2cap_frame_get_u8(frame, &len))
+			return false;
+
+		printf("Folder: ");
+		for (; len > 0; len--) {
+			uint8_t c;
+
+			if (!l2cap_frame_get_u8(frame, &c))
+				return false;
+
+			printf("%1c", isprint(c) ? c : '.');
+		}
+		printf("\n");
+	}
+
+	return true;
+}
+
 static bool avrcp_browsing_packet(struct avctp_frame *avctp_frame)
 {
 	struct l2cap_frame *frame = &avctp_frame->l2cap_frame;
+	uint16_t len;
+	uint8_t pduid;
+
+	if (!l2cap_frame_get_u8(frame, &pduid))
+		return false;
+
+	if (!l2cap_frame_get_be16(frame, &len))
+		return false;
+
+	print_field("AVRCP: %s: len 0x%04x", pdu2str(pduid), len);
+
+	switch (pduid) {
+	case AVRCP_SET_BROWSED_PLAYER:
+		avrcp_set_browsed_player(avctp_frame);
+		break;
+	default:
+		packet_hexdump(frame->data, frame->size);
+	}
 
-	packet_hexdump(frame->data, frame->size);
 	return true;
 }
 
-- 
1.9.1

