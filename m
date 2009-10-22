Return-Path: <cyrus@holtmann.org>
From: Jaikumar Ganesh <jaikumar@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jaikumar Ganesh <jaikumar@google.com>
Subject: [PATCH] Update SDP storage records when a record is deleted.
Date: Thu, 22 Oct 2009 16:19:22 -0700
Message-Id: <1256253562-22532-1-git-send-email-jaikumar@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When a SDP record is deleted at the remote end, we update
the storage only if we have a device driver registered for that UUID.
Update the cache in all cases.
---
 src/device.c |   48 +++++++++++++++++++++++++++---------------------
 1 files changed, 27 insertions(+), 21 deletions(-)

diff --git a/src/device.c b/src/device.c
index 63f35de..9386681 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1110,19 +1110,37 @@ void device_probe_drivers(struct btd_device *device, GSList *profiles)
 	}
 }
 
-static void device_remove_drivers(struct btd_device *device, GSList *uuids)
-{
+static void update_service_records(struct btd_device *device) {
 	struct btd_adapter *adapter = device_get_adapter(device);
-	GSList *list, *next;
-	char srcaddr[18], dstaddr[18];
 	bdaddr_t src;
-	sdp_list_t *records;
+	sdp_list_t *records, *seq;
+	sdp_record_t *rec;
+	char srcaddr[18], dstaddr[18];
+	GSList *l;
+	const char *uuid;
 
 	adapter_get_address(adapter, &src);
 	ba2str(&src, srcaddr);
 	ba2str(&device->bdaddr, dstaddr);
 
 	records = read_records(&src, &device->bdaddr);
+	for (l = device->uuids; l; l = l->next) {
+		uuid = l->data;
+		rec = find_record_in_list(records, uuid);
+		if (rec)
+			records = sdp_list_remove(records, rec);
+	}
+	for (seq = records; seq; seq = seq->next) {
+		rec = (sdp_record_t *) seq->data;
+		delete_record(srcaddr, dstaddr, rec->handle);
+	}
+	if (records)
+		sdp_list_free(records, (sdp_free_func_t) sdp_record_free);
+}
+
+static void device_remove_drivers(struct btd_device *device, GSList *uuids)
+{
+	GSList *list, *next;
 
 	debug("Remove drivers for %s", device->path);
 
@@ -1134,36 +1152,22 @@ static void device_remove_drivers(struct btd_device *device, GSList *uuids)
 		next = list->next;
 
 		for (uuid = driver->uuids; *uuid; uuid++) {
-			sdp_record_t *rec;
-
 			if (!g_slist_find_custom(uuids, *uuid,
 					(GCompareFunc) strcasecmp))
 				continue;
 
-			debug("UUID %s was removed from device %s",
-							*uuid, dstaddr);
+			debug("UUID %s was removed from device path %s",
+							*uuid, device->path);
 
 			driver->remove(device);
 			device->drivers = g_slist_remove(device->drivers,
 								driver_data);
 			g_free(driver_data);
 
-			rec = find_record_in_list(records, *uuid);
-			if (!rec)
-				break;
-
-			delete_record(srcaddr, dstaddr, rec->handle);
-
-			records = sdp_list_remove(records, rec);
-			sdp_record_free(rec);
-
 			break;
 		}
 	}
 
-	if (records)
-		sdp_list_free(records, (sdp_free_func_t) sdp_record_free);
-
 	for (list = uuids; list; list = list->next)
 		device->uuids = g_slist_remove(device->uuids, list->data);
 }
@@ -1333,6 +1337,8 @@ static void search_cb(sdp_list_t *recs, int err, gpointer user_data)
 	if (req->profiles_removed)
 		device_remove_drivers(device, req->profiles_removed);
 
+	update_service_records(device);
+
 	/* Propagate services changes */
 	services_changed(req->device);
 
-- 
1.6.2.3

