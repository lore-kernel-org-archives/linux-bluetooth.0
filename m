Return-Path: <cyrus@holtmann.org>
From: Vikrampal Yadav <vikram.pal@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, d.kasatkin@samsung.com,
	vikram.pal@samsung.com, cpgs@samsung.com
Subject: [PATCH 1/3] monitor: Adjust for ERTM control bytes
Date: Wed, 12 Nov 2014 14:23:14 +0530
Message-id: <1415782396-28799-1-git-send-email-vikram.pal@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Adjustment for ERTM control bytes fixed.
---
 monitor/l2cap.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/monitor/l2cap.c b/monitor/l2cap.c
index ebdd20f..b37f20f 100644
--- a/monitor/l2cap.c
+++ b/monitor/l2cap.c
@@ -2621,6 +2621,9 @@ static void l2cap_frame(uint16_t index, bool in, uint16_t handle,
 		connless_packet(index, in, handle, cid, data, size);
 		break;
 	case 0x0003:
+		/* Adjust for ERTM control bytes */
+		data += 2;
+		size -= 2;
 		amp_packet(index, in, handle, cid, data, size);
 		break;
 	case 0x0004:
@@ -2635,6 +2638,9 @@ static void l2cap_frame(uint16_t index, bool in, uint16_t handle,
 	default:
 		l2cap_frame_init(&frame, index, in, handle, cid, data, size);
 
+		if (frame.mode > 0)
+			l2cap_frame_pull(&frame, &frame, 2);
+
 		print_indent(6, COLOR_CYAN, "Channel:", "", COLOR_OFF,
 				" %d len %d [PSM %d mode %d] {chan %d}",
 						cid, size, frame.psm,
-- 
1.9.1

