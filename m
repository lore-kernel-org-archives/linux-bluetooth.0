Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH BlueZ v0 4/6] deviceinfo: Use btd_service userdata pointer
Date: Mon, 27 May 2013 14:04:07 +0200
Message-Id: <1369656249-27980-5-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1369656249-27980-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1369656249-27980-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Avoid maintaining an internal list of probed deviceinfo instances by
making use of btd_service's userdata pointer.
---
 profiles/deviceinfo/deviceinfo.c | 46 ++++++----------------------------------
 1 file changed, 6 insertions(+), 40 deletions(-)

diff --git a/profiles/deviceinfo/deviceinfo.c b/profiles/deviceinfo/deviceinfo.c
index e8cb5f7..8343bb5 100644
--- a/profiles/deviceinfo/deviceinfo.c
+++ b/profiles/deviceinfo/deviceinfo.c
@@ -51,16 +51,14 @@ struct deviceinfo {
 	GSList			*chars;		/* Characteristics */
 };
 
-static GSList *servers = NULL;
-
 struct characteristic {
 	struct gatt_char	attr;	/* Characteristic */
 	struct deviceinfo	*d;	/* deviceinfo where the char belongs */
 };
 
-static void deviceinfo_free(gpointer user_data)
+static void deviceinfo_driver_remove(struct btd_service *service)
 {
-	struct deviceinfo *d = user_data;
+	struct deviceinfo *d = btd_service_get_user_data(service);
 
 	if (d->attioid > 0)
 		btd_device_remove_attio_callback(d->dev, d->attioid);
@@ -75,17 +73,6 @@ static void deviceinfo_free(gpointer user_data)
 	g_free(d);
 }
 
-static int cmp_device(gconstpointer a, gconstpointer b)
-{
-	const struct deviceinfo *d = a;
-	const struct btd_device *dev = b;
-
-	if (dev == d->dev)
-		return 0;
-
-	return -1;
-}
-
 static void read_pnpid_cb(guint8 status, const guint8 *pdu, guint16 len,
 							gpointer user_data)
 {
@@ -166,9 +153,10 @@ static void attio_disconnected_cb(gpointer user_data)
 	d->attrib = NULL;
 }
 
-static int deviceinfo_register(struct btd_device *device,
+static int deviceinfo_register(struct btd_service *service,
 						struct gatt_primary *prim)
 {
+	struct btd_device *device = btd_service_get_device(service);
 	struct deviceinfo *d;
 
 	d = g_new0(struct deviceinfo, 1);
@@ -177,28 +165,13 @@ static int deviceinfo_register(struct btd_device *device,
 	d->svc_range->start = prim->range.start;
 	d->svc_range->end = prim->range.end;
 
-	servers = g_slist_prepend(servers, d);
+	btd_service_set_user_data(service, d);
 
 	d->attioid = btd_device_add_attio_callback(device, attio_connected_cb,
 						attio_disconnected_cb, d);
 	return 0;
 }
 
-static void deviceinfo_unregister(struct btd_device *device)
-{
-	struct deviceinfo *d;
-	GSList *l;
-
-	l = g_slist_find_custom(servers, device, cmp_device);
-	if (l == NULL)
-		return;
-
-	d = l->data;
-	servers = g_slist_remove(servers, d);
-
-	deviceinfo_free(d);
-}
-
 static int deviceinfo_driver_probe(struct btd_service *service)
 {
 	struct btd_device *device = btd_service_get_device(service);
@@ -208,14 +181,7 @@ static int deviceinfo_driver_probe(struct btd_service *service)
 	if (prim == NULL)
 		return -EINVAL;
 
-	return deviceinfo_register(device, prim);
-}
-
-static void deviceinfo_driver_remove(struct btd_service *service)
-{
-	struct btd_device *device = btd_service_get_device(service);
-
-	deviceinfo_unregister(device);
+	return deviceinfo_register(service, prim);
 }
 
 static struct btd_profile deviceinfo_profile = {
-- 
1.8.1.4

