Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH] android/gatt: Fix not checking for read errors in read by type
Date: Wed, 28 May 2014 09:48:13 +0200
Message-Id: <1401263293-30611-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/gatt.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/android/gatt.c b/android/gatt.c
index 0c9837d..736c7cc 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -3677,9 +3677,15 @@ static void send_dev_pending_response(struct gatt_device *device,
 			goto done;
 		}
 
+		if (val->error) {
+			queue_destroy(temp, NULL);
+			error = val->error;
+			goto done;
+		}
+
 		length = val->length;
 
-		while (val && val->length == length) {
+		while (val && val->length == length && val->error == 0) {
 			queue_push_tail(temp, val);
 			val = queue_pop_head(device->pending_requests);
 		}
-- 
1.9.3

