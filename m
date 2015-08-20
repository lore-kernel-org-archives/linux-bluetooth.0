Return-Path: <cyrus@holtmann.org>
From: Bharat Panda <bharat.panda@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: cpgs@samsung.com, Bharat Panda <bharat.panda@samsung.com>
Subject: [PATCH ] monitor/avctp: Fix GetFolderItems field values
Date: Thu, 20 Aug 2015 14:32:05 +0530
Message-id: <1440061325-32588-1-git-send-email-bharat.panda@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Replaced field names for GetFolderItems response with
correct names, values and fix allignments.

      AVCTP Browsing: Response: type 0x00 label 0 PID 0x110e
        AVRCP: GetFolderItems: len 0x0030
          Status: 0x04 (Success)
          UIDCounter: 0x0000 (0)
          NumOfItems: 0x0001 (1)
          Item: 0x01 (Media Player)
          Length: 0x0028 (40)
          PlayerID: 0x0000 (0)
          PlayerType: 0x0001 (Audio)
          PlayerSubType: 0x00000001 (Audio Book)
          PlayStatus: 0x01 (PLAYING)
          Features: 0x0000000000b701ef0200000000000000
          CharsetID: 0x006a (UTF-8)
          NameLength: 0x000c (12)
          Name: SimplePlayer
---
 monitor/avctp.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/monitor/avctp.c b/monitor/avctp.c
index a54b051..d06640e 100644
--- a/monitor/avctp.c
+++ b/monitor/avctp.c
@@ -1818,9 +1818,9 @@ static bool avrcp_media_player_item(struct avctp_frame *avctp_frame,
 {
 	struct l2cap_frame *frame = &avctp_frame->l2cap_frame;
 	uint16_t id, charset, namelen;
-	uint8_t type, status;
+	uint8_t type, status, i;
 	uint32_t subtype;
-	uint64_t features[2];
+	uint8_t features[16];
 
 	if (!l2cap_frame_get_be16(frame, &id))
 		return false;
@@ -1830,26 +1830,31 @@ static bool avrcp_media_player_item(struct avctp_frame *avctp_frame,
 	if (!l2cap_frame_get_u8(frame, &type))
 		return false;
 
-	print_field("%*cPlayerID: 0x%04x (%s)", indent, ' ',
+	print_field("%*cPlayerType: 0x%04x (%s)", indent, ' ',
 						type, playertype2str(type));
 
 	if (!l2cap_frame_get_be32(frame, &subtype))
 		return false;
 
-	print_field("%*cPlayerID: 0x%08x (%s)", indent, ' ',
+	print_field("%*cPlayerSubType: 0x%08x (%s)", indent, ' ',
 					subtype, playersubtype2str(subtype));
 
 	if (!l2cap_frame_get_u8(frame, &status))
 		return false;
 
-	print_field("%*cPlayerID: 0x%02x (%s)", indent, ' ',
+	print_field("%*cPlayStatus: 0x%02x (%s)", indent, ' ',
 						status, playstatus2str(status));
 
-	if (!l2cap_frame_get_be128(frame, &features[0], &features[1]))
-		return false;
+	printf("%*cFeatures: 0x", indent+8, ' ');
+
+	for (i = 0; i < 16; i++) {
+		if (!l2cap_frame_get_u8(frame, &features[i]))
+			return false;
 
-	print_field("%*cFeatures: 0x%16" PRIx64 "%16" PRIx64, indent, ' ',
-						features[1], features[0]);
+		printf("%02x", features[i]);
+	}
+
+	printf("\n");
 
 	if (!l2cap_frame_get_be16(frame, &charset))
 		return false;
@@ -1863,7 +1868,7 @@ static bool avrcp_media_player_item(struct avctp_frame *avctp_frame,
 	print_field("%*cNameLength: 0x%04x (%u)", indent, ' ',
 						namelen, namelen);
 
-	printf("%*cName: ", indent, ' ');
+	printf("%*cName: ", indent+8, ' ');
 	for (; namelen > 0; namelen--) {
 		uint8_t c;
 
@@ -1871,6 +1876,7 @@ static bool avrcp_media_player_item(struct avctp_frame *avctp_frame,
 			return false;
 		printf("%1c", isprint(c) ? c : '.');
 	}
+	printf("\n");
 
 	return true;
 }
@@ -2296,7 +2302,7 @@ response:
 	if (!l2cap_frame_get_be16(frame, &num))
 		return false;
 
-	print_field("%*cUIDCounter: 0x%04x (%u)", indent, ' ', num, num);
+	print_field("%*cNumOfItems: 0x%04x (%u)", indent, ' ', num, num);
 
 	for (; num > 0; num--) {
 		uint8_t type;
-- 
1.9.1

