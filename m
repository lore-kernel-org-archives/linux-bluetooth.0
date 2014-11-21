Return-Path: <cyrus@holtmann.org>
From: Vikrampal Yadav <vikram.pal@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, d.kasatkin@samsung.com,
	vikram.pal@samsung.com, cpgs@samsung.com
Subject: [PATCH 1/7] monitor: Adjust for ERTM control bytes
Date: Fri, 21 Nov 2014 19:17:39 +0530
Message-id: <1416577665-21876-2-git-send-email-vikram.pal@samsung.com>
In-reply-to: <1416577665-21876-1-git-send-email-vikram.pal@samsung.com>
References: <1416577665-21876-1-git-send-email-vikram.pal@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Adjustment for ERTM control bytes fixed.
---
 monitor/l2cap.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/monitor/l2cap.c b/monitor/l2cap.c
index ebdd20f..635b967 100644
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
-- 
1.9.1

