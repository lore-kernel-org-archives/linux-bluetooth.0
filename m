Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 3/4] android/gatt: Fix pending request data leakage
Date: Thu,  6 Nov 2014 10:30:37 +0100
Message-Id: <1415266238-12423-3-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1415266238-12423-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1415266238-12423-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Fix potential memory leaks and one reported by Valgrind:
==28453== 201 (144 direct, 57 indirect) bytes in 3 blocks are definitely
lost in loss record 156 of 166
==28453==    at 0x4C2CC70: calloc (in
/usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==28453==    by 0x4362AD: att_handler (gatt.c:5655)
==28453==    by 0x44496D: received_data.part.2 (gattrib.c:432)
==28453==    by 0x4E7FCE4: g_main_context_dispatch (in
/lib/x86_64-linux-gnu/libglib-2.0.so.0.4002.0)
==28453==    by 0x4E80047: ??? (in
/lib/x86_64-linux-gnu/libglib-2.0.so.0.4002.0)
==28453==    by 0x4E80309: g_main_loop_run (in
/lib/x86_64-linux-gnu/libglib-2.0.so.0.4002.0)
==28453==    by 0x4045B6: main (main.c:772)
---
 android/gatt.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/android/gatt.c b/android/gatt.c
index 828f788..47dadc2 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -4350,6 +4350,7 @@ static void send_dev_complete_response(struct gatt_device *device,
 		if (val->error) {
 			queue_destroy(temp, NULL);
 			error = val->error;
+			destroy_pending_request(val);
 			goto done;
 		}
 
@@ -4363,6 +4364,9 @@ static void send_dev_complete_response(struct gatt_device *device,
 		adl = att_data_list_alloc(queue_length(temp), sizeof(uint16_t) +
 									length);
 
+		if (val)
+			destroy_pending_request(val);
+
 		val = queue_pop_head(temp);
 		while (val) {
 			uint8_t *value = adl->data[iterator++];
@@ -5637,7 +5641,8 @@ static uint8_t read_by_type(const uint8_t *cmd, uint16_t cmd_len,
 
 		data->state = REQUEST_INIT;
 		data->handle = handle;
-		queue_push_tail(device->pending_requests, data);
+		if (!queue_push_tail(device->pending_requests, data))
+			free(data);
 	}
 
 	queue_destroy(q, NULL);
-- 
1.9.1

