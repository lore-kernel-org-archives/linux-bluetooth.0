Return-Path: <cyrus@holtmann.org>
From: Vikrampal Yadav <vikram.pal@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, d.kasatkin@samsung.com,
	vikram.pal@samsung.com, cpgs@samsung.com
Subject: [PATCH] monitor: Fix indentation for AVRCP PASS THROUGH commands
Date: Wed, 15 Oct 2014 19:11:49 +0530
Message-id: <1413380509-596-1-git-send-email-vikram.pal@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Intendation for AVRCP PASS THROUGH commands' decoding fixed.

btmon snippets:

      Channel: 66 len 14 [PSM 23 mode 0] {chan 3}
      AVCTP Control: Command: type 0x00 label 0 PID 0x110e
        AV/C: Status: address 0x48 opcode 0x7c
          Subunit: Panel
          Opcode: Passthrough
	  Operation: 0x44 (PLAY Pressed)
	  Lenght: 0x00
---
 monitor/avctp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/monitor/avctp.c b/monitor/avctp.c
index a4e34c5..4abd18f 100644
--- a/monitor/avctp.c
+++ b/monitor/avctp.c
@@ -686,13 +686,13 @@ static bool avrcp_passthrough_packet(struct avctp_frame *avctp_frame,
 	if (!l2cap_frame_get_u8(frame, &op))
 		return false;
 
-	print_field("%*cOperation: 0x%02x (%s %s)", (indent - 2), ' ', op,
+	print_field("%*cOperation: 0x%02x (%s %s)", (indent - 8), ' ', op,
 				op2str(op), op & 0x80 ? "Released" : "Pressed");
 
 	if (!l2cap_frame_get_u8(frame, &len))
 		return false;
 
-	print_field("%*cLength: 0x%02x", (indent - 2), ' ', len);
+	print_field("%*cLength: 0x%02x", (indent - 8), ' ', len);
 
 	packet_hexdump(frame->data, frame->size);
 	return true;
-- 
1.9.1

