Return-Path: <cyrus@holtmann.org>
From: Bharat Panda <bharat.panda@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: cpgs@samsung.com, Bharat Panda <bharat.panda@samsung.com>
Subject: [PATCH ] monitor: Add AVRCP ChangePath support
Date: Mon, 20 Apr 2015 20:19:10 +0530
Message-id: <1429541350-30882-1-git-send-email-bharat.panda@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add support for decoding AVRCP ChangePath in bluetooth monitor.

      Channel: 65 len 21 ctrl 0x0000 [PSM 27 mode 3] {chan 1}
      I-frame: Unsegmented TxSeq 0 ReqSeq 0
      AVCTP Browsing: Command: type 0x00 label 0 PID 0x110e
        AVRCP: ChangePath: len 0x000b
          UIDCounter: 0x0000 (0)
          Direction: 0x01 (Folder Down)
          FolderUID: 0x               1 (1)
---
 monitor/avctp.c | 71 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/monitor/avctp.c b/monitor/avctp.c
index f4f3250..e071393 100644
--- a/monitor/avctp.c
+++ b/monitor/avctp.c
@@ -1742,6 +1742,74 @@ static bool avrcp_control_packet(struct avctp_frame *avctp_frame)
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
+static bool avrcp_change_path(struct avctp_frame *avctp_frame)
+{
+	struct l2cap_frame *frame = &avctp_frame->l2cap_frame;
+	uint64_t uid;
+	uint32_t items;
+	uint16_t uidcounter;
+	uint8_t dir, status, indent = 2;
+
+	if (avctp_frame->hdr & 0x02)
+		goto response;
+
+	if (frame->size < 11) {
+		print_field("%*cPDU Malformed", indent, ' ');
+		packet_hexdump(frame->data, frame->size);
+		return false;
+	}
+
+	if (!l2cap_frame_get_be16(frame, &uidcounter))
+		return false;
+
+	print_field("%*cUIDCounter: 0x%04x (%u)", indent, ' ',
+					uidcounter, uidcounter);
+
+	if (!l2cap_frame_get_u8(frame, &dir))
+		return false;
+
+	print_field("%*cDirection: 0x%02x (%s)", indent, ' ',
+					dir, dir2str(dir));
+
+	if (!l2cap_frame_get_be64(frame, &uid))
+		return false;
+
+	print_field("%*cFolderUID: 0x%16" PRIx64 " (%" PRIu64 ")", indent, ' ',
+					uid, uid);
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
+	if (!l2cap_frame_get_be32(frame, &items))
+		return false;
+
+	print_field("%*cNumber of Items: 0x%04x (%u)", indent, ' ',
+					items, items);
+
+	return true;
+}
+
 static bool avrcp_media_player_item(struct avctp_frame *avctp_frame,
 							uint8_t indent)
 {
@@ -2136,6 +2204,9 @@ static bool avrcp_browsing_packet(struct avctp_frame *avctp_frame)
 	case AVRCP_GET_FOLDER_ITEMS:
 		avrcp_get_folder_items(avctp_frame);
 		break;
+	case AVRCP_CHANGE_PATH:
+		avrcp_change_path(avctp_frame);
+		break;
 	default:
 		packet_hexdump(frame->data, frame->size);
 	}
-- 
1.9.1

