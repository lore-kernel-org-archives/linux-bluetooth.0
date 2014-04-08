Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <szymon.janc@tieto.com>,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v2 11/15] android/gatt: Cache include services
Date: Tue, 8 Apr 2014 15:14:35 +0200
Message-ID: <1396962875-14776-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds caching included services.
Note that included service in put on two queues.
1. On main services queue on the device, together with primary services.
2. On special queue inside the primary service.

We need 1) to have easy search of service when Android framework request
for characteristics etc.

We need 2) to handle iteration on included services done by Android
framework for a given primary service
---
 android/gatt.c | 39 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/android/gatt.c b/android/gatt.c
index 3500cd4..063e177 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -90,6 +90,7 @@ struct service {
 	bool primary;
 
 	struct queue *chars;
+	struct queue *included;	/* Valid only for primary services */
 };
 
 struct notification_data {
@@ -204,6 +205,16 @@ static void destroy_service(void *data)
 		return;
 
 	queue_destroy(srvc->chars, destroy_characteristic);
+
+	/* Included services we keep on two queues.
+	 * 1. On the same queue with primary services.
+	 * 2. On the queue inside primary service.
+	 * So we need to free service memory only once but we need to destroy
+	 * two queues
+	 */
+	if (srvc->primary)
+		queue_destroy(srvc->included, NULL);
+
 	free(srvc);
 }
 
@@ -552,6 +563,17 @@ static struct service *create_service(bool primary, char *uuid, void *data)
 	else
 		memcpy(&s->incl, data, sizeof(s->incl));
 
+	if (!s->primary)
+		return s;
+
+	/* For primary service allocate queue for included services */
+	s->included = queue_new();
+	if (!s->included) {
+		queue_destroy(s->chars, NULL);
+		free(s);
+		return NULL;
+	}
+
 	return s;
 }
 
@@ -1254,11 +1276,26 @@ static void get_included_cb(uint8_t status, GSList *included, void *user_data)
 
 	bt_string_to_uuid(&uuid, service->prim.uuid);
 
-	/* TODO store included services in device->services list */
 	for (; included; included = included->next) {
 		struct gatt_included *included_service = included->data;
 		bt_uuid_t included_uuid;
+		struct service *incl;
+
+		incl = create_service(false, included_service->uuid,
+							included_service);
+		if (!incl)
+			continue;
 
+		/* Lets keep included service on two queues.
+		 * 1. on services queue together with primary service
+		 * 2. on special queue inside primary service
+		 */
+		if (!queue_push_tail(service->included, incl) ||
+				!queue_push_tail(device->services, incl)) {
+			error("gatt: Cannot push incl service to the list");
+			destroy_service(incl);
+			continue;
+		}
 		ev.conn_id = device->conn_id;
 		ev.status = GATT_SUCCESS;
 
-- 
1.8.4

