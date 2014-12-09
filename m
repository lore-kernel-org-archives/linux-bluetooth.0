Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ 11/15] core: Introduce gatt-callbacks
Date: Mon,  8 Dec 2014 16:40:51 -0800
Message-Id: <1418085655-7304-12-git-send-email-armansito@chromium.org>
In-Reply-To: <1418085655-7304-1-git-send-email-armansito@chromium.org>
References: <1418085655-7304-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch introduces src/gatt-callbacks.h. This defines API functions
to get notified of bt_gatt_client related events, such as ready,
service removed, and disconnects. These callbacks are parallel to the
existing attio.h functions and will provide a temporary alternative
during the transition from attrib/ to shared/gatt.
---
 Makefile.am          |   1 +
 src/device.c         | 162 +++++++++++++++++++++++++++++++++++++++++++++++----
 src/gatt-callbacks.h |  36 ++++++++++++
 3 files changed, 188 insertions(+), 11 deletions(-)
 create mode 100644 src/gatt-callbacks.h

diff --git a/Makefile.am b/Makefile.am
index c506122..ad2c336 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -182,6 +182,7 @@ src_bluetoothd_SOURCES = $(builtin_sources) \
 			src/gatt-dbus.h src/gatt-dbus.c \
 			src/gatt.h src/gatt.c \
 			src/device.h src/device.c src/attio.h \
+			src/gatt-callbacks.h \
 			src/dbus-common.c src/dbus-common.h \
 			src/eir.h src/eir.c
 src_bluetoothd_LDADD = lib/libbluetooth-internal.la \
diff --git a/src/device.c b/src/device.c
index 0bfac1e..4b42580 100644
--- a/src/device.c
+++ b/src/device.c
@@ -59,6 +59,7 @@
 #include "attrib/gattrib.h"
 #include "attio.h"
 #include "device.h"
+#include "gatt-callbacks.h"
 #include "profile.h"
 #include "service.h"
 #include "dbus-common.h"
@@ -145,6 +146,14 @@ struct attio_data {
 	gpointer user_data;
 };
 
+struct gatt_cb_data {
+	unsigned int id;
+	btd_gatt_client_ready_t ready_func;
+	btd_gatt_service_removed_t svc_removed_func;
+	btd_gatt_disconnect_t disconn_func;
+	void *user_data;
+};
+
 struct svc_callback {
 	unsigned int id;
 	guint idle_id;
@@ -222,6 +231,8 @@ struct btd_device {
 	 */
 	struct gatt_db *client_db;		/* GATT client cache */
 	struct bt_gatt_client *gatt_client;	/* GATT client implementation */
+	GSList		*gatt_callbacks;
+	unsigned int	next_gatt_cb_id;
 
 	struct bearer_state bredr_state;
 	struct bearer_state le_state;
@@ -559,6 +570,7 @@ static void device_free(gpointer user_data)
 	g_slist_free_full(device->attios, g_free);
 	g_slist_free_full(device->attios_offline, g_free);
 	g_slist_free_full(device->svc_callbacks, svc_dev_remove);
+	g_slist_free_full(device->gatt_callbacks, g_free);
 
 	attio_cleanup(device);
 
@@ -2439,6 +2451,21 @@ static gint prim_attr_cmp(gconstpointer a, gconstpointer b)
 	return !(prim->range.start == start && prim->range.end == end);
 }
 
+struct svc_removed_data {
+	struct gatt_db_attribute *attr;
+	struct bt_gatt_client *client;
+};
+
+static void notify_gatt_service_removed(gpointer data, gpointer user_data)
+{
+	struct gatt_cb_data *cb = data;
+	struct svc_removed_data *rm_data = user_data;
+
+	if (cb->svc_removed_func)
+		cb->svc_removed_func(rm_data->client, rm_data->attr,
+								cb->user_data);
+}
+
 static void gatt_service_removed(struct gatt_db_attribute *attr,
 								void *user_data)
 {
@@ -2446,6 +2473,7 @@ static void gatt_service_removed(struct gatt_db_attribute *attr,
 	GSList *l;
 	struct gatt_primary *prim;
 	uint16_t start, end;
+	struct svc_removed_data data;
 
 	if (!bt_gatt_client_is_ready(device->gatt_client))
 		return;
@@ -2469,13 +2497,19 @@ static void gatt_service_removed(struct gatt_db_attribute *attr,
 
 	store_services(device);
 
-	/*
-	 * TODO: Notify the profiles somehow. It may be sufficient for each
-	 * profile to register a service_removed handler.
-	 */
-
 	g_dbus_emit_property_changed(dbus_conn, device->path,
 						DEVICE_INTERFACE, "UUIDs");
+
+	data.attr = attr;
+	data.client = device->gatt_client;
+
+	g_slist_foreach(device->gatt_callbacks, notify_gatt_service_removed,
+									&data);
+
+	/*
+	 * TODO: Remove profiles matching this UUID if no other GATT services
+	 * with the same UUID exist.
+	 */
 }
 
 static struct btd_device *device_new(struct btd_adapter *adapter,
@@ -3560,6 +3594,16 @@ static void attio_disconnected(gpointer data, gpointer user_data)
 		attio->dcfunc(attio->user_data);
 }
 
+static void gatt_disconnected(gpointer data, gpointer user_data)
+{
+	struct gatt_cb_data *gatt_data = data;
+
+	DBG("");
+
+	if (gatt_data->disconn_func)
+		gatt_data->disconn_func(gatt_data->user_data);
+}
+
 static void att_disconnected_cb(void *user_data)
 {
 	struct btd_device *device = user_data;
@@ -3578,6 +3622,7 @@ static void att_disconnected_cb(void *user_data)
 	DBG("%s (%d)", strerror(err), err);
 
 	g_slist_foreach(device->attios, attio_disconnected, NULL);
+	g_slist_foreach(device->gatt_callbacks, gatt_disconnected, NULL);
 
 	if (!device_get_auto_connect(device)) {
 		DBG("Automatic connection disabled");
@@ -3651,7 +3696,15 @@ static void register_gatt_services(struct browse_req *req)
 
 	device_probe_profiles(device, req->profiles_added);
 
-	if (device->attios == NULL && device->attios_offline == NULL)
+	/*
+	 * TODO: This check seems unnecessary. We may not always want to cleanup
+	 * the connection since there will always be built-in plugins who want
+	 * to interact with remote GATT services. Even if we didn't have those,
+	 * the GATT D-Bus API will need to interact with these, so we should
+	 * later remove this check entirely.
+	 */
+	if (device->attios == NULL && device->attios_offline == NULL &&
+						device->gatt_callbacks == NULL)
 		attio_cleanup(device);
 
 	device_svc_resolved(device, device->bdaddr_type, 0);
@@ -3661,6 +3714,18 @@ static void register_gatt_services(struct browse_req *req)
 	browse_request_free(req);
 }
 
+static void notify_gatt_client_ready(gpointer data, gpointer user_data)
+{
+	struct gatt_cb_data *gatt_data = data;
+	struct btd_device *device = user_data;
+
+	DBG("");
+
+	if (gatt_data->ready_func)
+		gatt_data->ready_func(device->gatt_client, device->client_db,
+							gatt_data->user_data);
+}
+
 static void gatt_client_ready_cb(bool success, uint8_t att_ecode,
 								void *user_data)
 {
@@ -3689,11 +3754,9 @@ static void gatt_client_ready_cb(bool success, uint8_t att_ecode,
 	if (device->browse)
 		register_gatt_services(device->browse);
 
-	/*
-	 * TODO: Change attio callbacks to accept a gatt-client instead of a
-	 * GAttrib.
-	 */
 	g_slist_foreach(device->attios, attio_connected, device->attrib);
+	g_slist_foreach(device->gatt_callbacks, notify_gatt_client_ready,
+									device);
 }
 
 static void gatt_client_service_changed(uint16_t start_handle,
@@ -5080,7 +5143,8 @@ gboolean btd_device_remove_attio_callback(struct btd_device *device, guint id)
 
 	g_free(attio);
 
-	if (device->attios != NULL || device->attios_offline != NULL)
+	if (device->attios != NULL || device->attios_offline != NULL ||
+						device->gatt_callbacks != NULL)
 		return TRUE;
 
 	attio_cleanup(device);
@@ -5088,6 +5152,82 @@ gboolean btd_device_remove_attio_callback(struct btd_device *device, guint id)
 	return TRUE;
 }
 
+unsigned int btd_device_add_gatt_callbacks(struct btd_device *device,
+			btd_gatt_client_ready_t ready_func,
+			btd_gatt_service_removed_t service_removed_func,
+			btd_gatt_disconnect_t disconnect_func,
+			void *user_data)
+{
+	struct gatt_cb_data *gatt_data;
+
+	gatt_data = new0(struct gatt_cb_data, 1);
+	if (!gatt_data)
+		return 0;
+
+	if (device->next_gatt_cb_id < 1)
+		device->next_gatt_cb_id = 1;
+
+	device_set_auto_connect(device, TRUE);
+
+	gatt_data->id = device->next_gatt_cb_id++;
+	gatt_data->ready_func = ready_func;
+	gatt_data->svc_removed_func = service_removed_func;
+	gatt_data->disconn_func = disconnect_func;
+	gatt_data->user_data = user_data;
+
+	/*
+	 * TODO: The connection might be incoming from attrib-server (see
+	 * btd_device_add_attio_callback). I don't think this is a good place to
+	 * attach the GAttrib to the device. We should come up with a more
+	 * unified flow for attaching the GAttrib, bt_att, and bt_gatt_client
+	 * for incoming and outgoing connections.
+	 */
+	device->gatt_callbacks = g_slist_append(device->gatt_callbacks,
+								gatt_data);
+
+	if (ready_func && bt_gatt_client_is_ready(device->gatt_client))
+		ready_func(device->gatt_client, device->client_db, user_data);
+
+	return gatt_data->id;
+}
+
+static int gatt_cb_id_cmp(gconstpointer a, gconstpointer b)
+{
+	const struct gatt_cb_data *gatt_data = a;
+	guint id = GPOINTER_TO_UINT(b);
+
+	return gatt_data->id - id;
+}
+
+bool btd_device_remove_gatt_callbacks(struct btd_device *device,
+							unsigned int id)
+{
+	struct gatt_cb_data *gatt_data;
+	GSList *l;
+
+	l = g_slist_find_custom(device->gatt_callbacks, GUINT_TO_POINTER(id),
+								gatt_cb_id_cmp);
+	if (!l)
+		return false;
+
+	gatt_data = l->data;
+	device->gatt_callbacks = g_slist_remove(device->gatt_callbacks,
+								gatt_data);
+	free(gatt_data);
+
+	/*
+	 * TODO: Consider removing this check and avoiding cleanup as it seems
+	 * unnecessary.
+	 */
+	if (device->attios != NULL || device->attios_offline != NULL ||
+						device->gatt_callbacks != NULL)
+		return true;
+
+	attio_cleanup(device);
+
+	return true;
+}
+
 void btd_device_set_pnpid(struct btd_device *device, uint16_t source,
 			uint16_t vendor, uint16_t product, uint16_t version)
 {
diff --git a/src/gatt-callbacks.h b/src/gatt-callbacks.h
new file mode 100644
index 0000000..2ac1800
--- /dev/null
+++ b/src/gatt-callbacks.h
@@ -0,0 +1,36 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2014  Google Inc.
+ *
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ */
+
+#include <stdint.h>
+#include <stdbool.h>
+
+typedef void (*btd_gatt_client_ready_t) (struct bt_gatt_client *client,
+							struct gatt_db *db,
+							void *user_data);
+typedef void (*btd_gatt_service_removed_t) (struct bt_gatt_client *client,
+					struct gatt_db_attribute *attrib,
+					void *user_data);
+typedef void (*btd_gatt_disconnect_t) (void *user_data);
+
+unsigned int btd_device_add_gatt_callbacks(struct btd_device *device,
+			btd_gatt_client_ready_t ready_func,
+			btd_gatt_service_removed_t service_removed_func,
+			btd_gatt_disconnect_t disconnect_func,
+			void *user_data);
+bool btd_device_remove_gatt_callbacks(struct btd_device *device,
+							unsigned int id);
-- 
2.2.0.rc0.207.ga3a616c

