Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] android/gatt: Fix possible NULL dereference
Date: Fri, 19 Dec 2014 14:30:28 +0200
Message-Id: <1418992228-4070-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Fixes warnings:
...
Pointer 'req' returned from call to function 'queue_peek_head'
may be NULL and will be dereferenced
...
---
 android/gatt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/android/gatt.c b/android/gatt.c
index 6828f2f..2534836 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -5561,6 +5561,9 @@ static void handle_server_send_response(const void *buf, uint16_t len)
 		 * gatt_db_attribute_write().
 		 */
 		req = queue_peek_head(conn->device->pending_requests);
+		if (!req)
+			goto done;
+
 		/* Cast status to uint8_t, due to (byte) cast in java layer. */
 		req->error = err_to_att((uint8_t) cmd->status);
 		req->state = REQUEST_DONE;
-- 
2.1.0

