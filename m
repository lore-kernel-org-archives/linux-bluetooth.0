Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 2/2] android/gatt: Add return check for queue push
Date: Fri, 30 Jan 2015 06:46:08 +0100
Message-Id: <1422596768-17058-2-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1422596768-17058-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1422596768-17058-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/gatt.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/android/gatt.c b/android/gatt.c
index 3b0b81d..0f4136e 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -6289,7 +6289,12 @@ static void find_by_type_request_cb(struct gatt_db_attribute *attrib,
 	memcpy(request_data->filter_value, find_data->search_value,
 							find_data->search_vlen);
 
-	queue_push_tail(find_data->device->pending_requests, request_data);
+	if (!queue_push_tail(find_data->device->pending_requests,
+							request_data)) {
+		destroy_pending_request(request_data);
+		find_data->error = ATT_ECODE_INSUFF_RESOURCES;
+		return;
+	}
 
 	if (!find_data->found)
 		find_data->found = true;
-- 
1.8.4

