Return-Path: <cyrus@holtmann.org>
From: Vikrampal Yadav <vikram.pal@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, d.kasatkin@samsung.com,
	vikram.pal@samsung.com, cpgs@samsung.com
Subject: [PATCH] monitor: Fix the return value of l2cap_frame_get_le16()
Date: Wed, 19 Nov 2014 20:07:30 +0530
Message-id: <1416407850-13721-1-git-send-email-vikram.pal@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The return value of l2cap_frame_get_le16() rectified.
---
 monitor/l2cap.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/monitor/l2cap.h b/monitor/l2cap.h
index c14aeef..975f78a 100644
--- a/monitor/l2cap.h
+++ b/monitor/l2cap.h
@@ -92,7 +92,7 @@ static inline bool l2cap_frame_get_le16(struct l2cap_frame *frame,
 
 	l2cap_frame_pull(frame, frame, sizeof(*value));
 
-	return 0;
+	return true;
 }
 
 static inline bool l2cap_frame_get_be32(struct l2cap_frame *frame,
-- 
1.9.1

