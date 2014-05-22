Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: szymon.janc@tieto.com, Marcin Kraglak <marcin.kraglak@tieto.com>
Subject: [PATCH 1/4] android/gatt: Use common framework for processing read_by_group_type request
Date: Thu, 22 May 2014 13:17:42 +0200
Message-Id: <1400757465-11522-2-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1400757465-11522-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1400757465-11522-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Marcin Kraglak <marcin.kraglak@tieto.com>

Use function process_dev_pending_request to read values of attributes.
---
 android/gatt.c | 19 ++-----------------
 1 file changed, 2 insertions(+), 17 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 89da60d..46df0e1 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -4350,8 +4350,6 @@ static uint8_t read_by_group_type(const uint8_t *cmd, uint16_t cmd_len,
 
 	while (queue_peek_head(q)) {
 		uint16_t handle = PTR_TO_UINT(queue_pop_head(q));
-		uint8_t *value;
-		int value_len;
 		struct pending_request *entry;
 
 		entry = new0(struct pending_request, 1);
@@ -4361,19 +4359,7 @@ static uint8_t read_by_group_type(const uint8_t *cmd, uint16_t cmd_len,
 		}
 
 		entry->handle = handle;
-
-		if (!gatt_db_read(gatt_db, handle, 0, ATT_OP_READ_BY_GROUP_REQ,
-					&device->bdaddr, &value, &value_len))
-			break;
-
-		entry->value = malloc0(value_len);
-		if (!entry->value) {
-			queue_destroy(q, destroy_pending_request);
-			return ATT_ECODE_UNLIKELY;
-		}
-
-		memcpy(entry->value, value, value_len);
-		entry->length = value_len;
+		entry->length = READ_INIT;
 
 		if (!queue_push_tail(device->pending_requests, entry)) {
 			queue_remove_all(device->pending_requests, NULL, NULL,
@@ -4384,8 +4370,7 @@ static uint8_t read_by_group_type(const uint8_t *cmd, uint16_t cmd_len,
 	}
 
 	queue_destroy(q, NULL);
-
-	send_dev_pending_response(device, cmd[0]);
+	process_dev_pending_requests(device, cmd[0]);
 
 	return 0;
 }
-- 
1.8.4

