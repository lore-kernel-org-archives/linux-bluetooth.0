Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH 08/18] Add a way to retrieve ATT primary services
Date: Tue, 21 Dec 2010 19:26:30 -0200
Message-Id: <1292966800-6264-9-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1292966800-6264-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1292966800-6264-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

As the primary services were discovered by the core bluetoothd, we need
a way to export that information.

The service discovery uses the same primary list as the device, there's no
need to free that list when the discovery finishes. That list will be removed
when the device is free'd.
---
 src/adapter.c     |    6 +++---
 src/device.c      |   15 +++++++++++++++
 src/device.h      |    3 +++
 src/glib-helper.c |    1 -
 4 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 3d5fafc..e48f1fd 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -1994,14 +1994,14 @@ static void create_stored_device_from_primary(char *key, char *value,
 	for (l = services, uuids = NULL; l; l = l->next) {
 		struct att_primary *prim = l->data;
 		uuids = g_slist_append(uuids, prim->uuid);
+
+		device_add_primary(device, prim);
 	}
 
 	device_probe_drivers(device, uuids);
 
-	g_slist_free(uuids);
-
-	g_slist_foreach(services, (GFunc) att_primary_free, NULL);
 	g_slist_free(services);
+	g_slist_free(uuids);
 }
 
 static void load_devices(struct btd_adapter *adapter)
diff --git a/src/device.c b/src/device.c
index d67f804..627db8f 100644
--- a/src/device.c
+++ b/src/device.c
@@ -115,6 +115,7 @@ struct btd_device {
 	struct btd_adapter	*adapter;
 	GSList		*uuids;
 	GSList		*services;		/* Primary services path */
+	GSList		*primaries;		/* List of primary services */
 	GSList		*drivers;		/* List of driver_data */
 	GSList		*watches;		/* List of disconnect_data */
 	gboolean	temporary;
@@ -209,6 +210,9 @@ static void device_free(gpointer user_data)
 	g_slist_foreach(device->uuids, (GFunc) g_free, NULL);
 	g_slist_free(device->uuids);
 
+	g_slist_foreach(device->primaries, (GFunc) att_primary_free, NULL);
+	g_slist_free(device->primaries);
+
 	if (device->tmp_records)
 		sdp_list_free(device->tmp_records,
 					(sdp_free_func_t) sdp_record_free);
@@ -1571,6 +1575,7 @@ static void primary_cb(GSList *services, int err, gpointer user_data)
 	for (l = services; l; l = l->next) {
 		struct att_primary *prim = l->data;
 		uuids = g_slist_append(uuids, prim->uuid);
+		device_add_primary(device, prim);
 	}
 
 	device_probe_drivers(device, uuids);
@@ -2383,6 +2388,16 @@ void device_add_service(struct btd_device *device, const char *path)
 	device->services = g_slist_append(device->services, g_strdup(path));
 }
 
+void device_add_primary(struct btd_device *device, struct att_primary *prim)
+{
+	device->primaries = g_slist_append(device->primaries, prim);
+}
+
+GSList *btd_device_get_primaries(struct btd_device *device)
+{
+	return device->primaries;
+}
+
 void btd_device_add_uuid(struct btd_device *device, const char *uuid)
 {
 	GSList *uuid_list;
diff --git a/src/device.h b/src/device.h
index 7820636..0bd6fff 100644
--- a/src/device.h
+++ b/src/device.h
@@ -25,6 +25,7 @@
 #define DEVICE_INTERFACE	"org.bluez.Device"
 
 struct btd_device;
+struct att_primary;
 
 typedef enum {
 	AUTH_TYPE_PINCODE,
@@ -53,7 +54,9 @@ int device_browse(struct btd_device *device, DBusConnection *conn,
 void device_probe_drivers(struct btd_device *device, GSList *profiles);
 const sdp_record_t *btd_device_get_record(struct btd_device *device,
 						const char *uuid);
+GSList *btd_device_get_primaries(struct btd_device *device);
 void device_add_service(struct btd_device *device, const char *path);
+void device_add_primary(struct btd_device *device, struct att_primary *prim);
 void btd_device_add_uuid(struct btd_device *device, const char *uuid);
 struct btd_adapter *device_get_adapter(struct btd_device *device);
 void device_get_address(struct btd_device *device, bdaddr_t *bdaddr);
diff --git a/src/glib-helper.c b/src/glib-helper.c
index 4bd6a50..648dd62 100644
--- a/src/glib-helper.c
+++ b/src/glib-helper.c
@@ -75,7 +75,6 @@ static void gattrib_context_free(struct gattrib_context *ctxt)
 	if (ctxt->destroy)
 		ctxt->destroy(ctxt->user_data);
 
-	g_slist_foreach(ctxt->primaries, (GFunc) att_primary_free, NULL);
 	g_slist_free(ctxt->primaries);
 	g_attrib_unref(ctxt->attrib);
 	if (ctxt->io) {
-- 
1.7.3.4

