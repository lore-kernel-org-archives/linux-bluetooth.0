Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH 2/9] Cleanup primary service registration from storage
Date: Thu,  7 Apr 2011 14:30:07 -0300
Message-Id: <1302197414-833-2-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1302197414-833-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1302197414-833-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/adapter.c |    9 +--------
 src/device.c  |   20 ++++++--------------
 src/device.h  |    4 ++--
 3 files changed, 9 insertions(+), 24 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index c400bfd..6caff9a 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -58,8 +58,6 @@
 #include "storage.h"
 #include "attrib-server.h"
 #include "att.h"
-#include "gattrib.h"
-#include "attrib/client.h"
 
 /* Interleaved discovery window: 5.12 sec */
 #define GAP_INTER_DISCOV_WIN		5120
@@ -2193,16 +2191,11 @@ static void create_stored_device_from_primary(char *key, char *value,
 	for (l = services, uuids = NULL; l; l = l->next) {
 		struct att_primary *prim = l->data;
 		uuids = g_slist_append(uuids, prim->uuid);
-
-		device_add_primary(device, prim);
 	}
 
-	/* FIXME: Need the correct psm */
-	attrib_client_register(connection, device, -1, NULL, services);
-
 	device_probe_drivers(device, uuids);
+	device_register_services(connection, device, services, -1);
 
-	g_slist_free(services);
 	g_slist_free(uuids);
 }
 
diff --git a/src/device.c b/src/device.c
index 32eb643..b6750b6 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1480,14 +1480,6 @@ static GSList *primary_from_record(struct btd_device *device, GSList *profiles)
 	return prim_list;
 }
 
-static void register_primary_services(DBusConnection *conn,
-				struct btd_device *device, GSList *prim_list)
-{
-	/* TODO: PSM is hardcoded */
-	attrib_client_register(conn, device, 31, NULL, prim_list);
-	device->primaries = g_slist_concat(device->primaries, prim_list);
-}
-
 static void search_cb(sdp_list_t *recs, int err, gpointer user_data)
 {
 	struct browse_req *req = user_data;
@@ -1524,7 +1516,7 @@ static void search_cb(sdp_list_t *recs, int err, gpointer user_data)
 
 		list = primary_from_record(device, req->profiles_added);
 		if (list)
-			register_primary_services(req->conn, device, list);
+			device_register_services(req->conn, device, list, 31);
 	}
 
 	/* Remove drivers for services removed */
@@ -1666,13 +1658,11 @@ static void primary_cb(GSList *services, guint8 status, gpointer user_data)
 	for (l = services; l; l = l->next) {
 		struct att_primary *prim = l->data;
 		uuids = g_slist_append(uuids, prim->uuid);
-		device_add_primary(device, prim);
 	}
 
 	device_probe_drivers(device, uuids);
 
-	/* FIXME: Need the correct psm */
-	attrib_client_register(req->conn, device, -1, req->attrib, services);
+	device_register_services(req->conn, device, services, -1);
 
 	g_slist_free(uuids);
 
@@ -2428,9 +2418,11 @@ void btd_device_add_service(struct btd_device *device, const char *path)
 	device->services = g_slist_append(device->services, g_strdup(path));
 }
 
-void device_add_primary(struct btd_device *device, struct att_primary *prim)
+void device_register_services(DBusConnection *conn, struct btd_device *device,
+						GSList *prim_list, int psm)
 {
-	device->primaries = g_slist_append(device->primaries, prim);
+	attrib_client_register(conn, device, psm, NULL, prim_list);
+	device->primaries = g_slist_concat(device->primaries, prim_list);
 }
 
 GSList *btd_device_get_primaries(struct btd_device *device)
diff --git a/src/device.h b/src/device.h
index 3ce212b..285364f 100644
--- a/src/device.h
+++ b/src/device.h
@@ -25,7 +25,6 @@
 #define DEVICE_INTERFACE	"org.bluez.Device"
 
 struct btd_device;
-struct att_primary;
 
 typedef enum {
 	AUTH_TYPE_PINCODE,
@@ -58,7 +57,8 @@ const sdp_record_t *btd_device_get_record(struct btd_device *device,
 						const char *uuid);
 GSList *btd_device_get_primaries(struct btd_device *device);
 void btd_device_add_service(struct btd_device *device, const char *path);
-void device_add_primary(struct btd_device *device, struct att_primary *prim);
+void device_register_services(DBusConnection *conn, struct btd_device *device,
+						GSList *prim_list, int psm);
 void btd_device_add_uuid(struct btd_device *device, const char *uuid);
 struct btd_adapter *device_get_adapter(struct btd_device *device);
 void device_get_address(struct btd_device *device, bdaddr_t *bdaddr);
-- 
1.7.4.1

