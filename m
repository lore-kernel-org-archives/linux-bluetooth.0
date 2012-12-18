Return-Path: <cyrus@holtmann.org>
From: Rami Rosen <ramirose@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	gustavo@padovan.org,
	johan.hedberg@gmail.com,
	Rami Rosen <ramirose@gmail.com>
Subject: [PATCH] Bluetooth: remove an unused variable in a header file.
Date: Tue, 18 Dec 2012 11:48:01 +0200
Message-Id: <1355824081-5381-1-git-send-email-ramirose@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

This patch removes srej_queue_next from include/net/bluetooth/l2cap.h as it 
is not used.

Signed-off-by: Rami Rosen <ramirose@gmail.com>
---
 include/net/bluetooth/l2cap.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 7588ef4..cdd3302 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -496,7 +496,6 @@ struct l2cap_chan {
 	__u16		frames_sent;
 	__u16		unacked_frames;
 	__u8		retry_count;
-	__u16		srej_queue_next;
 	__u16		sdu_len;
 	struct sk_buff	*sdu;
 	struct sk_buff	*sdu_last_frag;
-- 
1.7.11.7
