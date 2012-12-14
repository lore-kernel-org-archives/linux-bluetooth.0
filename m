Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH BlueZ 1/2] core: Fix leftover signal for UUIDs property
Date: Fri, 14 Dec 2012 12:13:29 -0200
Message-Id: <1355494410-24627-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/device.c | 28 ++++++++--------------------
 1 file changed, 8 insertions(+), 20 deletions(-)

diff --git a/src/device.c b/src/device.c
index 01c40a7..714fc72 100644
--- a/src/device.c
+++ b/src/device.c
@@ -2442,23 +2442,6 @@ static void device_remove_profiles(struct btd_device *device, GSList *uuids)
 	}
 }
 
-static void uuids_changed(struct btd_device *device)
-{
-	char **uuids;
-	GSList *l;
-	int i;
-
-	uuids = g_new0(char *, g_slist_length(device->uuids) + 1);
-	for (i = 0, l = device->uuids; l; l = l->next, i++)
-		uuids[i] = l->data;
-
-	emit_array_property_changed(device->path,
-					DEVICE_INTERFACE, "UUIDs",
-					DBUS_TYPE_STRING, &uuids, i);
-
-	g_free(uuids);
-}
-
 static void store_sdp_record(GKeyFile *key_file, sdp_record_t *rec)
 {
 	char handle_str[11];
@@ -2803,7 +2786,9 @@ static void search_cb(sdp_list_t *recs, int err, gpointer user_data)
 		device_remove_profiles(device, req->profiles_removed);
 
 	/* Propagate services changes */
-	uuids_changed(req->device);
+	g_dbus_emit_property_changed(btd_get_dbus_connection(),
+					req->device->path, DEVICE_INTERFACE,
+					"UUIDs");
 
 send_reply:
 	device_svc_resolved(device, err);
@@ -2966,7 +2951,8 @@ static void register_all_services(struct browse_req *req, GSList *services)
 	if (device->attios == NULL && device->attios_offline == NULL)
 		attio_cleanup(device);
 
-	uuids_changed(device);
+	g_dbus_emit_property_changed(btd_get_dbus_connection(), device->path,
+						DEVICE_INTERFACE, "UUIDs");
 
 	device_svc_resolved(device, 0);
 
@@ -4057,7 +4043,9 @@ void btd_device_add_uuid(struct btd_device *device, const char *uuid)
 	g_slist_free(uuid_list);
 
 	store_device_info(device);
-	uuids_changed(device);
+
+	g_dbus_emit_property_changed(btd_get_dbus_connection(), device->path,
+						DEVICE_INTERFACE, "UUIDs");
 }
 
 static sdp_list_t *read_device_records(struct btd_device *device)
-- 
1.8.0.2

