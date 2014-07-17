Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/8] android/gatt: Fix check for permissions error
Date: Thu, 17 Jul 2014 10:42:46 +0200
Message-Id: <1405586570-16851-4-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1405586570-16851-1-git-send-email-marcin.kraglak@tieto.com>
References: <1405586570-16851-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If error is returned from check_device_permissions, fill response
data and return. In case of read errors we didn't send error response.
Zero length data was send instead.
---
 android/gatt.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 4cd94b8..002592c 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -4508,8 +4508,11 @@ static void read_requested_attributes(void *data, void *user_data)
 	error = check_device_permissions(process_data->device,
 							process_data->opcode,
 							permissions);
-	if (error)
-		goto done;
+	if (error != 0) {
+		resp_data->error = error;
+		resp_data->state = REQUEST_DONE;
+		return;
+	}
 
 	resp_data->state = REQUEST_PENDING;
 
@@ -4517,12 +4520,9 @@ static void read_requested_attributes(void *data, void *user_data)
 						resp_data->offset,
 						process_data->opcode,
 						&process_data->device->bdaddr,
-						&value, &value_len)) {
+						&value, &value_len))
 		error = ATT_ECODE_UNLIKELY;
-		goto done;
-	}
 
-done:
 	/* We have value here already if no callback will be called */
 	if (value_len > 0)
 		fill_gatt_response(resp_data, resp_data->handle,
-- 
1.9.0

