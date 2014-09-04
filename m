Return-Path: <cyrus@holtmann.org>
From: Vikrampal Yadav <vikram.pal@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, d.kasatkin@samsung.com,
	vikram.pal@samsung.com, cpgs@samsung.com
Subject: [PATCH] monitor: Remove superfluous call to l2cap_frame_pull
Date: Thu, 04 Sep 2014 15:52:38 +0530
Message-id: <1409826158-29266-1-git-send-email-vikram.pal@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Removed superfluous call to l2cap_frame_pull.
---
 monitor/avctp.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/monitor/avctp.c b/monitor/avctp.c
index 64d4b58..98ffa22 100644
--- a/monitor/avctp.c
+++ b/monitor/avctp.c
@@ -546,16 +546,13 @@ static bool avrcp_list_player_attributes(struct l2cap_frame *frame,
 						uint8_t ctype, uint8_t len,
 						uint8_t indent)
 {
-	struct l2cap_frame avrcp_frame;
 	uint8_t num;
 	int i;
 
 	if (len == 0)
 		return true;
 
-	l2cap_frame_pull(&avrcp_frame, frame, 0);
-
-	if (!l2cap_frame_get_u8(&avrcp_frame, &num))
+	if (!l2cap_frame_get_u8(frame, &num))
 		return false;
 
 	print_field("%*cAttributeCount: 0x%02x", (indent - 8), ' ', num);
@@ -563,7 +560,7 @@ static bool avrcp_list_player_attributes(struct l2cap_frame *frame,
 	for (i = 0; num > 0; num--, i++) {
 		uint8_t attr;
 
-		if (!l2cap_frame_get_u8(&avrcp_frame, &attr))
+		if (!l2cap_frame_get_u8(frame, &attr))
 			return false;
 
 		print_field("%*cAttributeID: 0x%02x (%s)", (indent - 8), ' ',
-- 
1.9.1

