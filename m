Return-Path: <cyrus@holtmann.org>
From: Bharat Panda <bharat.panda@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: cpgs@samsung.com, Bharat Panda <bharat.panda@samsung.com>
Subject: [PATCH  3/4] monitor: Add FolderItem support for GetFolderItems
Date: Thu, 16 Apr 2015 18:46:39 +0530
Message-id: <1429190200-13911-3-git-send-email-bharat.panda@samsung.com>
In-reply-to: <1429190200-13911-1-git-send-email-bharat.panda@samsung.com>
References: <1429190200-13911-1-git-send-email-bharat.panda@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add support for decoding GetFolderItems(FolderItem) for avrcp in
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
 monitor/avctp.c | 79 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/monitor/avctp.c b/monitor/avctp.c
index a109d5c..7e55bef 100644
--- a/monitor/avctp.c
+++ b/monitor/avctp.c
@@ -748,6 +748,28 @@ static const char *playersubtype2str(uint32_t subtype)
 	return "None";
 }
 
+static const char *foldertype2str(uint8_t type)
+{
+	switch (type) {
+	case 0x00:
+		return "Mixed";
+	case 0x01:
+		return "Titles";
+	case 0x02:
+		return "Albuns";
+	case 0x03:
+		return "Artists";
+	case 0x04:
+		return "Genres";
+	case 0x05:
+		return "Playlists";
+	case 0x06:
+		return "Years";
+	}
+
+	return "Reserved";
+}
+
 static bool avrcp_passthrough_packet(struct avctp_frame *avctp_frame,
 								uint8_t indent)
 {
@@ -1770,6 +1792,61 @@ static bool avrcp_media_player_item(struct avctp_frame *avctp_frame,
 	return true;
 }
 
+static bool avrcp_folder_item(struct avctp_frame *avctp_frame,
+							uint8_t indent)
+{
+	struct l2cap_frame *frame = &avctp_frame->l2cap_frame;
+	uint8_t type, playable;
+	uint16_t charset, namelen;
+	uint64_t uid;
+
+	if (frame->size < 14) {
+		printf("PDU Malformed\n");
+		return false;
+	}
+
+	if (!l2cap_frame_get_be64(frame, &uid))
+		return false;
+
+	print_field("%*cFolderUID: 0x%16" PRIx64 " (%" PRIu64 ")", indent, ' ',
+						uid, uid);
+
+	if (!l2cap_frame_get_u8(frame, &type))
+		return false;
+
+	print_field("%*cFolderType: 0x%02x (%s)", indent, ' ',
+						type, foldertype2str(type));
+
+	if (!l2cap_frame_get_u8(frame, &playable))
+		return false;
+
+	print_field("%*cIsPlayable: 0x%02x (%s)", indent, ' ', playable,
+					playable & 0x01 ? "True" : "False");
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
+	return true;
+}
+
 static bool avrcp_get_folder_items(struct avctp_frame *avctp_frame)
 {
 	struct l2cap_frame *frame = &avctp_frame->l2cap_frame;
@@ -1850,6 +1927,8 @@ response:
 			avrcp_media_player_item(avctp_frame, indent);
 			break;
 		case AVRCP_FOLDER_ITEM_TYPE:
+			avrcp_folder_item(avctp_frame, indent);
+			break;
 		case AVRCP_MEDIA_ELEMENT_ITEM_TYPE:
 			packet_hexdump(frame->data, frame->size);
 			break;
-- 
1.9.1

