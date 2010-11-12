Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Elvis=20Pf=C3=BCtzenreuter?= <epx@signove.com>
To: linux-bluetooth@vger.kernel.org
Cc: epx@signove.com
Subject: [PATCH] [RFC] Show multiple classes in Device UUIDs property
Date: Fri, 12 Nov 2010 12:52:08 -0200
Message-Id: <1289573528-14404-1-git-send-email-epx@signove.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds support for multiple service classes in a single SDP record,
This is a common case for HDP profile (a HDP device which is both source and
sink will have classes 0x1401 and 0x1402, but often just one SDP record).

Current implementation gets only the first UUID in record, which can be
any of the two, and prevents an application to filter e.g. sources by
UUIDs property alone.

The patch also prevents a device driver from being probed and/or removed
twice, if two different UUIDs are served by the same driver. Moreover, it
detects the case when one UUID is removed (e.g. 0x1401) but another one
showed up (0x1402) and both are served by the same driver, which means
the driver must not be removed.

NOTE: the main reason I am submitting this patch, is to reopen the
multiple-UUIDs-in-a-profile discussion. This has been tested mainly with
HDP but there may be issues that affect other drivers and invalidates this
solution completely. I am prepared for the lapidation :)
---
 src/device.c |  123 +++++++++++++++++++++++++++++++++++++++++----------------
 1 files changed, 88 insertions(+), 35 deletions(-)

diff --git a/src/device.c b/src/device.c
index 7c421e3..83ca441 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1186,6 +1186,14 @@ static GSList *device_match_driver(struct btd_device *device,
 	return uuids;
 }
 
+static int device_drivers_cmp(const void *a, const void *b)
+{
+	const struct btd_driver_data *driver_data = a;
+	const struct btd_device_driver *driver = b;
+
+	return (driver_data->driver == driver ? 0 : 1);
+}
+
 void device_probe_drivers(struct btd_device *device, GSList *profiles)
 {
 	GSList *list;
@@ -1208,20 +1216,25 @@ void device_probe_drivers(struct btd_device *device, GSList *profiles)
 		if (!probe_uuids)
 			continue;
 
-		driver_data = g_new0(struct btd_driver_data, 1);
-
 		err = driver->probe(device, probe_uuids);
 		if (err < 0) {
 			error("probe failed with driver %s for device %s",
 					driver->name, device->path);
 
-			g_free(driver_data);
 			g_slist_free(probe_uuids);
 			continue;
 		}
 
+		if (g_slist_find_custom(device->drivers, driver,
+				(GCompareFunc) device_drivers_cmp)) {
+			g_slist_free(probe_uuids);
+			continue;
+		}
+
+		driver_data = g_new0(struct btd_driver_data, 1);
 		driver_data->driver = driver;
 		device->drivers = g_slist_append(device->drivers, driver_data);
+
 		g_slist_free(probe_uuids);
 	}
 
@@ -1254,13 +1267,45 @@ static void device_remove_drivers(struct btd_device *device, GSList *uuids)
 
 	DBG("Remove drivers for %s", device->path);
 
+	for (list = uuids; list; list = list->next) {
+		sdp_record_t *rec;
+
+		device->uuids = g_slist_remove(device->uuids, list->data);
+
+		rec = find_record_in_list(records, list->data);
+		if (!rec)
+			continue;
+
+		delete_record(srcaddr, dstaddr, rec->handle);
+
+		records = sdp_list_remove(records, rec);
+		sdp_record_free(rec);
+
+	}
+
+	if (records)
+		sdp_list_free(records, (sdp_free_func_t) sdp_record_free);
+
 	for (list = device->drivers; list; list = next) {
 		struct btd_driver_data *driver_data = list->data;
 		struct btd_device_driver *driver = driver_data->driver;
 		const char **uuid;
+		gboolean in_use_by_another_uuid;
 
 		next = list->next;
 
+		in_use_by_another_uuid = FALSE;
+		for (uuid = driver->uuids; *uuid; uuid++) {
+			if (g_slist_find_custom(device->uuids, *uuid,
+						(GCompareFunc) strcasecmp)) {
+				in_use_by_another_uuid = TRUE;
+				break;
+			}
+		}
+
+		if (in_use_by_another_uuid)
+			continue;
+
 		for (uuid = driver->uuids; *uuid; uuid++) {
 			if (!g_slist_find_custom(uuids, *uuid,
 						(GCompareFunc) strcasecmp))
@@ -1277,25 +1322,6 @@ static void device_remove_drivers(struct btd_device *device, GSList *uuids)
 			break;
 		}
 	}
-
-	for (list = uuids; list; list = list->next) {
-		sdp_record_t *rec;
-
-		device->uuids = g_slist_remove(device->uuids, list->data);
-
-		rec = find_record_in_list(records, list->data);
-		if (!rec)
-			continue;
-
-		delete_record(srcaddr, dstaddr, rec->handle);
-
-		records = sdp_list_remove(records, rec);
-		sdp_record_free(rec);
-
-	}
-
-	if (records)
-		sdp_list_free(records, (sdp_free_func_t) sdp_record_free);
 }
 
 static void services_changed(struct btd_device *device)
@@ -1323,6 +1349,43 @@ static int rec_cmp(const void *a, const void *b)
 	return r1->handle - r2->handle;
 }
 
+static void append_uuids(GSList *existing, GSList **uuids, sdp_list_t *svcclass)
+{
+	gchar *uuid;
+	GSList *l;
+
+	do {
+		uuid = bt_uuid2string(svcclass->data);
+
+		l = g_slist_find_custom(existing, uuid, (GCompareFunc) strcmp);
+		if (l) {
+			g_free(uuid);
+			continue;
+		}
+
+		l = g_slist_find_custom(*uuids, uuid, (GCompareFunc) strcmp);
+		if (!l) 
+			*uuids = g_slist_append(*uuids, uuid);
+		else
+			g_free(uuid);
+	} while ((svcclass = svcclass->next));
+}
+
+static void remove_uuids(GSList **uuids, sdp_list_t *svcclass)
+{
+	gchar *uuid;
+	GSList *l;
+
+	do {
+		uuid = bt_uuid2string(svcclass->data);
+		l = g_slist_find_custom(*uuids, uuid, (GCompareFunc) strcmp);
+
+		if (l) 
+			*uuids = g_slist_remove(*uuids, l->data);
+		g_free(uuid);
+	} while ((svcclass = svcclass->next));
+}
+
 static void update_services(struct browse_req *req, sdp_list_t *recs)
 {
 	struct btd_device *device = req->device;
@@ -1339,7 +1402,6 @@ static void update_services(struct browse_req *req, sdp_list_t *recs)
 		sdp_record_t *rec = (sdp_record_t *) seq->data;
 		sdp_list_t *svcclass = NULL;
 		gchar *profile_uuid;
-		GSList *l;
 
 		if (!rec)
 			break;
@@ -1394,19 +1456,10 @@ static void update_services(struct browse_req *req, sdp_list_t *recs)
 		req->records = sdp_list_append(req->records,
 							sdp_copy_record(rec));
 
-		l = g_slist_find_custom(device->uuids, profile_uuid,
-							(GCompareFunc) strcmp);
-		if (!l)
-			req->profiles_added =
-					g_slist_append(req->profiles_added,
-							profile_uuid);
-		else {
-			req->profiles_removed =
-					g_slist_remove(req->profiles_removed,
-							l->data);
-			g_free(profile_uuid);
-		}
+		append_uuids(device->uuids, &req->profiles_added, svcclass);
+		remove_uuids(&req->profiles_removed, svcclass);
 
+		g_free(profile_uuid);
 		sdp_list_free(svcclass, free);
 	}
 }
-- 
1.7.0.4

