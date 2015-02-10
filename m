Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 2/6] android/gatt: Remove REQUEST_INIT state
Date: Tue, 10 Feb 2015 13:48:10 +0100
Message-Id: <1423572494-32037-2-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1423572494-32037-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1423572494-32037-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This state is redundant as it is just yet another pending state for which
we are not even testing anywhere.
---
 android/gatt.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 425d3e8..210a877 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -692,7 +692,6 @@ static void destroy_gatt_app(void *data)
 }
 
 enum pend_req_state {
-	REQUEST_INIT,
 	REQUEST_PENDING,
 	REQUEST_DONE,
 };
@@ -4881,8 +4880,6 @@ static void read_requested_attributes(void *data, void *user_data)
 		return;
 	}
 
-	resp_data->state = REQUEST_PENDING;
-
 	gatt_db_attribute_read(attrib, resp_data->offset, process_data->opcode,
 						&process_data->device->bdaddr,
 						attribute_read_cb, resp_data);
@@ -6097,7 +6094,6 @@ static uint8_t read_by_type(const uint8_t *cmd, uint16_t cmd_len,
 			return ATT_ECODE_INSUFF_RESOURCES;
 		}
 
-		data->state = REQUEST_INIT;
 		data->attrib = attrib;
 		if (!queue_push_tail(device->pending_requests, data)) {
 			free(data);
@@ -6150,7 +6146,6 @@ static uint8_t read_request(const uint8_t *cmd, uint16_t cmd_len,
 
 	data->offset = offset;
 	data->attrib = attrib;
-	data->state = REQUEST_INIT;
 	if (!queue_push_tail(dev->pending_requests, data)) {
 		free(data);
 		return ATT_ECODE_INSUFF_RESOURCES;
@@ -6325,7 +6320,6 @@ static void find_by_type_request_cb(struct gatt_db_attribute *attrib,
 		return;
 	}
 
-	request_data->state = REQUEST_INIT;
 	request_data->attrib = attrib;
 	request_data->filter_vlen = find_data->search_vlen;
 	memcpy(request_data->filter_value, find_data->search_value,
@@ -6538,7 +6532,6 @@ static uint8_t write_req_request(const uint8_t *cmd, uint16_t cmd_len,
 		return ATT_ECODE_INSUFF_RESOURCES;
 
 	data->attrib = attrib;
-	data->state = REQUEST_PENDING;
 
 	if (!queue_push_tail(dev->pending_requests, data)) {
 		free(data);
@@ -6595,7 +6588,6 @@ static uint8_t write_prep_request(const uint8_t *cmd, uint16_t cmd_len,
 
 	data->attrib = attrib;
 	data->offset = offset;
-	data->state = REQUEST_PENDING;
 
 	if (!queue_push_tail(dev->pending_requests, data)) {
 		free(data);
@@ -6668,7 +6660,6 @@ static uint8_t write_execute_request(const uint8_t *cmd, uint16_t cmd_len,
 	if (!data)
 		return ATT_ECODE_INSUFF_RESOURCES;
 
-	data->state = REQUEST_PENDING;
 	if (!queue_push_tail(dev->pending_requests, data)) {
 		free(data);
 		return ATT_ECODE_INSUFF_RESOURCES;
-- 
1.9.1

