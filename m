Return-Path: <cyrus@holtmann.org>
From: Bharat Panda <bharat.panda@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: cpgs@samsung.com, Bharat Panda <bharat.panda@samsung.com>
Subject: [PATCH  2/4] monitor: Add MediaPlayerItem for GetFolderItems
Date: Thu, 16 Apr 2015 18:46:38 +0530
Message-id: <1429190200-13911-2-git-send-email-bharat.panda@samsung.com>
In-reply-to: <1429190200-13911-1-git-send-email-bharat.panda@samsung.com>
References: <1429190200-13911-1-git-send-email-bharat.panda@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add support for decoding GetFolderItems(MediaPlayerItem) for avrcp
in bluetooth monitor.

      Channel: 65 len 20 ctrl 0x0306 [PSM 27 mode 3] {chan 1}
      I-frame: Unsegmented TxSeq 3 ReqSeq 3
      AVCTP Browsing: Command: type 0x00 label 0 PID 0x110e
        AVRCP: GetFolderItems: len 0x000a
          Scope: 0x00 (Media Player List)
          StartItem: 0x00000000 (0)
          EndItem: 0x00000064 (100)
          AttributeCount: 0x00 (0)
---
 monitor/avctp.c | 119 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 monitor/l2cap.h |  16 ++++++++
 2 files changed, 133 insertions(+), 2 deletions(-)

diff --git a/monitor/avctp.c b/monitor/avctp.c
index a55cb41..a109d5c 100644
--- a/monitor/avctp.c
+++ b/monitor/avctp.c
@@ -696,6 +696,58 @@ static const char *type2str(uint8_t type)
 	}
 }
 
+static const char *playertype2str(uint8_t type)
+{
+	switch (type & 0x0F) {
+	case 0x01:
+		return "Audio";
+	case 0x02:
+		return "Video";
+	case 0x03:
+		return "Audio, Video";
+	case 0x04:
+		return "Audio Broadcasting";
+	case 0x05:
+		return "Audio, Audio Broadcasting";
+	case 0x06:
+		return "Video, Audio Broadcasting";
+	case 0x07:
+		return "Audio, Video, Audio Broadcasting";
+	case 0x08:
+		return "Video Broadcasting";
+	case 0x09:
+		return "Audio, Video Broadcasting";
+	case 0x0A:
+		return "Video, Video Broadcasting";
+	case 0x0B:
+		return "Audio, Video, Video Broadcasting";
+	case 0x0C:
+		return "Audio Broadcasting, Video Broadcasting";
+	case 0x0D:
+		return "Audio, Audio Broadcasting, Video Broadcasting";
+	case 0x0E:
+		return "Video, Audio Broadcasting, Video Broadcasting";
+	case 0x0F:
+		return "Audio, Video, Audio Broadcasting, Video Broadcasting";
+	}
+
+	return "None";
+}
+
+static const char *playersubtype2str(uint32_t subtype)
+{
+	switch (subtype & 0x03) {
+	case 0x01:
+		return "Audio Book";
+	case 0x02:
+		return "Podcast";
+	case 0x03:
+		return "Audio Book, Podcast";
+	}
+
+	return "None";
+}
+
 static bool avrcp_passthrough_packet(struct avctp_frame *avctp_frame,
 								uint8_t indent)
 {
@@ -1656,6 +1708,68 @@ static bool avrcp_control_packet(struct avctp_frame *avctp_frame)
 	}
 }
 
+static bool avrcp_media_player_item(struct avctp_frame *avctp_frame,
+							uint8_t indent)
+{
+	struct l2cap_frame *frame = &avctp_frame->l2cap_frame;
+	uint16_t id, charset, namelen;
+	uint8_t type, status;
+	uint32_t subtype;
+	uint64_t features[2];
+
+	if (!l2cap_frame_get_be16(frame, &id))
+		return false;
+
+	print_field("%*cPlayerID: 0x%04x (%u)", indent, ' ', id, id);
+
+	if (!l2cap_frame_get_u8(frame, &type))
+		return false;
+
+	print_field("%*cPlayerID: 0x%04x (%s)", indent, ' ',
+						type, playertype2str(type));
+
+	if (!l2cap_frame_get_be32(frame, &subtype))
+		return false;
+
+	print_field("%*cPlayerID: 0x%08x (%s)", indent, ' ',
+					subtype, playersubtype2str(subtype));
+
+	if (!l2cap_frame_get_u8(frame, &status))
+		return false;
+
+	print_field("%*cPlayerID: 0x%02x (%s)", indent, ' ',
+						status, playstatus2str(status));
+
+	if (l2cap_frame_get_be128(frame, &features[0], &features[1]))
+		return false;
+
+	print_field("%*cFeatures: 0x%16" PRIx64 "%16" PRIx64, indent, ' ',
+						features[1], features[0]);
+
+	if (!l2cap_frame_get_be16(frame, &charset))
+		return false;
+
+	print_field("%*cCharsetID: 0x%04x (%s)", indent, ' ',
+						charset, charset2str(charset));
+
+	if (!l2cap_frame_get_be16(frame, &namelen))
+		return false;
+
+	print_field("%*cNameLength: 0x%04x (%u)", indent, ' ',
+						namelen, namelen);
+
+	printf("%*cName: ", indent, ' ');
+	for (; namelen > 0; namelen--) {
+		uint8_t c;
+
+		if (!l2cap_frame_get_u8(frame, &c))
+			return false;
+		printf("%1c", isprint(c) ? c : '.');
+	}
+
+	return true;
+}
+
 static bool avrcp_get_folder_items(struct avctp_frame *avctp_frame)
 {
 	struct l2cap_frame *frame = &avctp_frame->l2cap_frame;
@@ -1691,9 +1805,8 @@ static bool avrcp_get_folder_items(struct avctp_frame *avctp_frame)
 	for (; count > 0; count--) {
 		uint16_t attr;
 
-		if (!l2cap_frame_get_be16(frame, &attr)) {
+		if (!l2cap_frame_get_be16(frame, &attr))
 			return false;
-		}
 
 		print_field("%*cAttributeID: 0x%08x (%s)", indent, ' ',
 					attr, mediattr2str(attr));
@@ -1734,6 +1847,8 @@ response:
 
 		switch (type) {
 		case AVRCP_MEDIA_PLAYER_ITEM_TYPE:
+			avrcp_media_player_item(avctp_frame, indent);
+			break;
 		case AVRCP_FOLDER_ITEM_TYPE:
 		case AVRCP_MEDIA_ELEMENT_ITEM_TYPE:
 			packet_hexdump(frame->data, frame->size);
diff --git a/monitor/l2cap.h b/monitor/l2cap.h
index 711bcb1..0364454 100644
--- a/monitor/l2cap.h
+++ b/monitor/l2cap.h
@@ -153,6 +153,22 @@ static inline bool l2cap_frame_get_le64(struct l2cap_frame *frame,
 	return true;
 }
 
+static inline bool l2cap_frame_get_be128(struct l2cap_frame *frame,
+					uint64_t *lvalue, uint64_t *rvalue)
+{
+	if (frame->size < (sizeof(*lvalue) + sizeof(*rvalue)))
+		return false;
+
+	if (lvalue && rvalue) {
+		*lvalue = get_be64(frame->data);
+		*rvalue = get_be64(frame->data);
+	}
+
+	l2cap_frame_pull(frame, frame, (sizeof(*lvalue) + sizeof(*rvalue)));
+
+	return true;
+}
+
 void l2cap_packet(uint16_t index, bool in, uint16_t handle, uint8_t flags,
 					const void *data, uint16_t size);
 
-- 
1.9.1

