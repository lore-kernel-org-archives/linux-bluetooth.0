Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v2 3/9] Remove btd_device_add_service function
Date: Mon, 11 Apr 2011 15:24:48 -0300
Message-Id: <1302546288-24082-1-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1302197414-833-3-git-send-email-claudio.takahasi@openbossa.org>
References: <1302197414-833-3-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

btd_device_add_service is no longer necessary if the object paths for
the primary services can be returned during the registration.
---
 attrib/client.c |   16 ++++++++--------
 attrib/client.h |    2 +-
 src/device.c    |   11 ++---------
 src/device.h    |    1 -
 4 files changed, 11 insertions(+), 19 deletions(-)

diff --git a/attrib/client.c b/attrib/client.c
index 28e5704..2dd70c9 100644
--- a/attrib/client.c
+++ b/attrib/client.c
@@ -1020,11 +1020,11 @@ static GDBusMethodTable prim_methods[] = {
 	{ }
 };
 
-static void register_primaries(struct gatt_service *gatt, GSList *primaries)
+static GSList *register_primaries(struct gatt_service *gatt, GSList *primaries)
 {
-	GSList *l;
+	GSList *l, *paths;
 
-	for (l = primaries; l; l = l->next) {
+	for (paths = NULL, l = primaries; l; l = l->next) {
 		struct att_primary *att = l->data;
 		struct primary *prim;
 
@@ -1040,12 +1040,14 @@ static void register_primaries(struct gatt_service *gatt, GSList *primaries)
 		DBG("Registered: %s", prim->path);
 
 		gatt->primary = g_slist_append(gatt->primary, prim);
-		btd_device_add_service(gatt->dev, prim->path);
+		paths = g_slist_append(paths, g_strdup(prim->path));
 		load_characteristics(prim, gatt);
 	}
+
+	return paths;
 }
 
-int attrib_client_register(DBusConnection *connection,
+GSList *attrib_client_register(DBusConnection *connection,
 					struct btd_device *device, int psm,
 					GAttrib *attrib, GSList *primaries)
 {
@@ -1069,11 +1071,9 @@ int attrib_client_register(DBusConnection *connection,
 	if (attrib)
 		gatt->attrib = g_attrib_ref(attrib);
 
-	register_primaries(gatt, primaries);
-
 	gatt_services = g_slist_append(gatt_services, gatt);
 
-	return 0;
+	return register_primaries(gatt, primaries);
 }
 
 void attrib_client_unregister(struct btd_device *device)
diff --git a/attrib/client.h b/attrib/client.h
index b4a4ecc..b29797c 100644
--- a/attrib/client.h
+++ b/attrib/client.h
@@ -22,7 +22,7 @@
  *
  */
 
-int attrib_client_register(DBusConnection *connection,
+GSList *attrib_client_register(DBusConnection *connection,
 					struct btd_device *device, int psm,
 					GAttrib *attrib, GSList *primaries);
 void attrib_client_unregister(struct btd_device *device);
diff --git a/src/device.c b/src/device.c
index f9b7a73..efe9938 100644
--- a/src/device.c
+++ b/src/device.c
@@ -2336,18 +2336,11 @@ void device_set_authorizing(struct btd_device *device, gboolean auth)
 	device->authorizing = auth;
 }
 
-void btd_device_add_service(struct btd_device *device, const char *path)
-{
-	if (g_slist_find_custom(device->services, path, (GCompareFunc) strcmp))
-		return;
-
-	device->services = g_slist_append(device->services, g_strdup(path));
-}
-
 void device_register_services(DBusConnection *conn, struct btd_device *device,
 						GSList *prim_list, int psm)
 {
-	attrib_client_register(conn, device, psm, NULL, prim_list);
+	device->services = attrib_client_register(conn, device, psm, NULL,
+								prim_list);
 	device->primaries = g_slist_concat(device->primaries, prim_list);
 }
 
diff --git a/src/device.h b/src/device.h
index 285364f..2432884 100644
--- a/src/device.h
+++ b/src/device.h
@@ -56,7 +56,6 @@ void device_probe_drivers(struct btd_device *device, GSList *profiles);
 const sdp_record_t *btd_device_get_record(struct btd_device *device,
 						const char *uuid);
 GSList *btd_device_get_primaries(struct btd_device *device);
-void btd_device_add_service(struct btd_device *device, const char *path);
 void device_register_services(DBusConnection *conn, struct btd_device *device,
 						GSList *prim_list, int psm);
 void btd_device_add_uuid(struct btd_device *device, const char *uuid);
-- 
1.7.4.1

