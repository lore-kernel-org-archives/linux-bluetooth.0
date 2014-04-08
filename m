Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <szymon.janc@tieto.com>,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 15/15] android/gatt: Fix instance id for primary and included service
Date: Tue, 8 Apr 2014 11:22:32 +0200
Message-ID: <1396948952-2035-16-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1396948952-2035-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1396948952-2035-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Since there might be multiple services with same uuid, we should
make sure that each primary and included service has unique instance
id.

This patch adds this.
---
 android/gatt.c | 30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index d1deae4..7f15459 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -543,7 +543,8 @@ done:
 
 }
 
-static struct service *create_service(bool primary, char *uuid, void *data)
+static struct service *create_service(uint8_t id, bool primary, char *uuid,
+								void *data)
 {
 	struct service *s;
 
@@ -567,6 +568,8 @@ static struct service *create_service(bool primary, char *uuid, void *data)
 		return NULL;
 	}
 
+	s->id.instance = id;
+
 	/* Put primary service to our local list */
 	s->primary = primary;
 	if (s->primary)
@@ -593,6 +596,7 @@ static void primary_cb(uint8_t status, GSList *services, void *user_data)
 	struct gatt_device *dev = user_data;
 	GSList *l;
 	int32_t gatt_status;
+	uint8_t instance_id;
 
 	DBG("Status %d", status);
 
@@ -609,11 +613,16 @@ static void primary_cb(uint8_t status, GSList *services, void *user_data)
 		goto done;
 	}
 
+	/* There might be multiply services with same uuid. Therefore make sure
+	 * each primary service one has unique instance_id
+	 */
+	instance_id = 0;
+
 	for (l = services; l; l = l->next) {
 		struct gatt_primary *prim = l->data;
 		struct service *p;
 
-		p = create_service(true, prim->uuid, prim);
+		p = create_service(instance_id++, true, prim->uuid, prim);
 		if (!p)
 			continue;
 
@@ -1267,12 +1276,20 @@ struct get_included_data {
 	struct gatt_device *device;
 };
 
+static uint8_t get_inst_id_of_prim_services(const struct gatt_device *dev)
+{
+	struct service *s = queue_peek_tail(dev->services);
+
+	return s->id.instance;
+}
+
 static void get_included_cb(uint8_t status, GSList *included, void *user_data)
 {
 	struct get_included_data *data = user_data;
 	struct gatt_device *device = data->device;
 	struct service *service = data->prim;
 	struct service *incl;
+	uint8_t instance_id;
 
 	DBG("");
 
@@ -1286,11 +1303,18 @@ static void get_included_cb(uint8_t status, GSList *included, void *user_data)
 	/* Remember that we already search included services.*/
 	service->incl_search_done = true;
 
+	/* There might be multiply services with same uuid. Therefore make sure
+	 * each service has unique instance id. Let's take the latest instance
+	 * id of primary service and start iterate included services from this
+	 * point.
+	 */
+	instance_id = get_inst_id_of_prim_services(device);
 
 	for (; included; included = included->next) {
 		struct gatt_included *included_service = included->data;
 
-		incl = create_service(false, included_service->uuid,
+		incl = create_service(++instance_id, false,
+							included_service->uuid,
 							included_service);
 		if (!incl)
 			continue;
-- 
1.8.4

