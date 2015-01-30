Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 1/2] android/gatt: Fix Find By Type request
Date: Fri, 30 Jan 2015 06:46:07 +0100
Message-Id: <1422596768-17058-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

With this patch GATT will correctly response with attribute not found if
there is no attributes matching.

Issue found and fix tested on UPF50
---
 android/gatt.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/android/gatt.c b/android/gatt.c
index 466c1ea..3b0b81d 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -6258,6 +6258,7 @@ struct find_by_type_request_data {
 	uint8_t *search_value;
 	size_t search_vlen;
 	uint8_t error;
+	bool found;
 };
 
 static void find_by_type_request_cb(struct gatt_db_attribute *attrib,
@@ -6289,6 +6290,9 @@ static void find_by_type_request_cb(struct gatt_db_attribute *attrib,
 							find_data->search_vlen);
 
 	queue_push_tail(find_data->device->pending_requests, request_data);
+
+	if (!find_data->found)
+		find_data->found = true;
 }
 
 static uint8_t find_by_type_request(const uint8_t *cmd, uint16_t cmd_len,
@@ -6315,11 +6319,12 @@ static uint8_t find_by_type_request(const uint8_t *cmd, uint16_t cmd_len,
 	data.search_vlen = search_vlen;
 	data.search_value = search_value;
 	data.device = device;
+	data.found = false;
 
 	gatt_db_find_by_type(gatt_db, start, end, &uuid,
 						find_by_type_request_cb, &data);
 
-	if (data.error == ATT_ECODE_ATTR_NOT_FOUND) {
+	if (!data.found) {
 		size_t mtu;
 		uint8_t *rsp = g_attrib_get_buffer(device->attrib, &mtu);
 
-- 
1.8.4

