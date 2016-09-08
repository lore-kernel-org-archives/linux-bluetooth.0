Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/5] scanparam: Make use of service user_data to store service context
Date: Thu,  8 Sep 2016 15:38:59 +0300
Message-Id: <1473338340-7587-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1473338340-7587-1-git-send-email-luiz.dentz@gmail.com>
References: <1473338340-7587-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Instead of storing service context data in a list this make use of
btd_service_set_user_data to store the context data which later can be
retrieved with btd_service_get_user_data.
---
 profiles/scanparam/scan.c | 35 ++++++++---------------------------
 1 file changed, 8 insertions(+), 27 deletions(-)

diff --git a/profiles/scanparam/scan.c b/profiles/scanparam/scan.c
index d12e09e..f8ad810 100644
--- a/profiles/scanparam/scan.c
+++ b/profiles/scanparam/scan.c
@@ -62,8 +62,6 @@ struct scan {
 	guint refresh_cb_id;
 };
 
-static GSList *devices;
-
 static void scan_free(struct scan *scan)
 {
 	bt_gatt_client_unregister_notify(scan->client, scan->refresh_cb_id);
@@ -73,14 +71,6 @@ static void scan_free(struct scan *scan)
 	g_free(scan);
 }
 
-static int cmp_device(gconstpointer a, gconstpointer b)
-{
-	const struct scan *scan = a;
-	const struct btd_device *device = b;
-
-	return scan->device == device ? 0 : -1;
-}
-
 static void write_scan_params(struct scan *scan)
 {
 	uint8_t value[4];
@@ -181,21 +171,17 @@ static int scan_param_accept(struct btd_service *service)
 	struct gatt_db *db = btd_device_get_gatt_db(device);
 	struct bt_gatt_client *client = btd_device_get_gatt_client(device);
 	bt_uuid_t scan_parameters_uuid;
-	struct scan *scan;
-	GSList *l;
+	struct scan *scan = btd_service_get_user_data(service);
 	char addr[18];
 
 	ba2str(device_get_address(device), addr);
 	DBG("Scan Parameters Client Driver profile accept (%s)", addr);
 
-	l = g_slist_find_custom(devices, device, cmp_device);
-	if (!l) {
+	if (!scan) {
 		error("Scan Parameters service not handled by profile");
 		return -1;
 	}
 
-	scan = l->data;
-
 	/* Clean-up any old client/db and acquire the new ones */
 	scan->attr = NULL;
 	gatt_db_unref(scan->db);
@@ -226,21 +212,17 @@ static void scan_param_remove(struct btd_service *service)
 {
 	struct btd_device *device = btd_service_get_device(service);
 	struct scan *scan;
-	GSList *l;
 	char addr[18];
 
 	ba2str(device_get_address(device), addr);
 	DBG("GAP profile remove (%s)", addr);
 
-	l = g_slist_find_custom(devices, device, cmp_device);
-	if (!l) {
+	scan = btd_service_get_user_data(service);
+	if (!scan) {
 		error("GAP service not handled by profile");
 		return;
 	}
 
-	scan = l->data;
-
-	devices = g_slist_remove(devices, scan);
 	scan_free(scan);
 }
 
@@ -248,16 +230,15 @@ static int scan_param_probe(struct btd_service *service)
 {
 	struct btd_device *device = btd_service_get_device(service);
 	struct scan *scan;
-	GSList *l;
 	char addr[18];
 
 	ba2str(device_get_address(device), addr);
 	DBG("Scan Parameters Client Driver profile probe (%s)", addr);
 
 	/* Ignore, if we were probed for this device already */
-	l = g_slist_find_custom(devices, device, cmp_device);
-	if (l) {
-		error("Profile probed twice for the same device!");
+	scan = btd_service_get_user_data(service);
+	if (scan) {
+		error("Profile probed twice for the same service!");
 		return -1;
 	}
 
@@ -266,7 +247,7 @@ static int scan_param_probe(struct btd_service *service)
 		return -1;
 
 	scan->device = btd_device_ref(device);
-	devices = g_slist_append(devices, scan);
+	btd_service_set_user_data(service, scan);
 	return 0;
 }
 
-- 
2.7.4

