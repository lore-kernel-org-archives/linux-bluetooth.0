Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH BlueZ v0 5/6] scanparam: Use btd_service userdata pointer
Date: Mon, 27 May 2013 14:04:08 +0200
Message-Id: <1369656249-27980-6-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1369656249-27980-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1369656249-27980-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Avoid maintaining an internal list of probed struct scan instances by
making use of btd_service's userdata pointer.
---
 profiles/scanparam/scan.c | 36 ++++++------------------------------
 1 file changed, 6 insertions(+), 30 deletions(-)

diff --git a/profiles/scanparam/scan.c b/profiles/scanparam/scan.c
index a9baec8..fc4779f 100644
--- a/profiles/scanparam/scan.c
+++ b/profiles/scanparam/scan.c
@@ -64,16 +64,6 @@ struct scan {
 	uint16_t refresh_cb_id;
 };
 
-static GSList *servers = NULL;
-
-static int scan_device_cmp(gconstpointer a, gconstpointer b)
-{
-	const struct scan *scan = a;
-	const struct btd_device *device = b;
-
-	return (device == scan->device ? 0 : -1);
-}
-
 static void write_scan_params(GAttrib *attrib, uint16_t handle)
 {
 	uint8_t value[4];
@@ -227,8 +217,9 @@ static void attio_disconnected_cb(gpointer user_data)
 	scan->attrib = NULL;
 }
 
-static int scan_register(struct btd_device *device, struct gatt_primary *prim)
+static int scan_register(struct btd_service *service, struct gatt_primary *prim)
 {
+	struct btd_device *device = btd_service_get_device(service);
 	struct scan *scan;
 
 	scan = g_new0(struct scan, 1);
@@ -239,22 +230,14 @@ static int scan_register(struct btd_device *device, struct gatt_primary *prim)
 							attio_disconnected_cb,
 							scan);
 
-	servers = g_slist_prepend(servers, scan);
+	btd_service_set_user_data(service, scan);
 
 	return 0;
 }
 
-static void scan_unregister(struct btd_device *device)
+static void scan_param_remove(struct btd_service *service)
 {
-	struct scan *scan;
-	GSList *l;
-
-	l = g_slist_find_custom(servers, device, scan_device_cmp);
-	if (l == NULL)
-		return;
-
-	scan = l->data;
-	servers = g_slist_remove(servers, scan);
+	struct scan *scan = btd_service_get_user_data(service);
 
 	if (scan->refresh_cb_id) {
 		g_attrib_unregister(scan->attrib, scan->refresh_cb_id);
@@ -278,14 +261,7 @@ static int scan_param_probe(struct btd_service *service)
 	if (!prim)
 		return -EINVAL;
 
-	return scan_register(device, prim);
-}
-
-static void scan_param_remove(struct btd_service *service)
-{
-	struct btd_device *device = btd_service_get_device(service);
-
-	scan_unregister(device);
+	return scan_register(service, prim);
 }
 
 static struct btd_profile scan_profile = {
-- 
1.8.1.4

