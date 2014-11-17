Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ 07/12] core: Introduce gatt-callbacks
Date: Mon, 17 Nov 2014 11:22:13 -0800
Message-Id: <1416252138-17477-8-git-send-email-armansito@chromium.org>
In-Reply-To: <1416252138-17477-1-git-send-email-armansito@chromium.org>
References: <1416252138-17477-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch introduces src/gatt-callbacks.h. This defines API functions
to get notified of bt_gatt_client related events, such as ready,
service changed, and disconnects. This is orthogonal and similar to the
existing attio.h functions, which we're aiming to deprecate.
---
 Makefile.am          |   1 +
 src/device.c         | 160 +++++++++++++++++++++++++++++++++++++++++++++++----
 src/gatt-callbacks.h |  42 ++++++++++++++
 3 files changed, 193 insertions(+), 10 deletions(-)
 create mode 100644 src/gatt-callbacks.h

diff --git a/Makefile.am b/Makefile.am
index c84d63a..a3ebe86 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -181,6 +181,7 @@ src_bluetoothd_SOURCES = $(builtin_sources) \
 			src/gatt-dbus.h src/gatt-dbus.c \
 			src/gatt.h src/gatt.c \
 			src/device.h src/device.c src/attio.h \
+			src/gatt-callbacks.h \
 			src/dbus-common.c src/dbus-common.h \
 			src/eir.h src/eir.c
 src_bluetoothd_LDADD = lib/libbluetooth-internal.la \
diff --git a/src/device.c b/src/device.c
index 3d0159e..df87292 100644
--- a/src/device.c
+++ b/src/device.c
@@ -57,6 +57,7 @@
 #include "attrib/gattrib.h"
 #include "attio.h"
 #include "device.h"
+#include "gatt-callbacks.h"
 #include "profile.h"
 #include "service.h"
 #include "dbus-common.h"
@@ -143,6 +144,14 @@ struct attio_data {
 	gpointer user_data;
 };
 
+struct gatt_cb_data {
+	unsigned int id;
+	btd_gatt_client_ready_t ready_func;
+	btd_gatt_client_service_changed_t svc_chngd_func;
+	btd_gatt_disconnect_t disconn_func;
+	void *user_data;
+};
+
 struct svc_callback {
 	unsigned int id;
 	guint idle_id;
@@ -214,6 +223,8 @@ struct btd_device {
 	unsigned int att_disconn_id;
 
 	struct bt_gatt_client *gatt_client;	/* GATT client cache */
+	GSList		*gatt_callbacks;
+	unsigned int	next_gatt_cb_id;
 
 	struct bearer_state bredr_state;
 	struct bearer_state le_state;
@@ -548,6 +559,7 @@ static void device_free(gpointer user_data)
 	g_slist_free_full(device->attios, g_free);
 	g_slist_free_full(device->attios_offline, g_free);
 	g_slist_free_full(device->svc_callbacks, svc_dev_remove);
+	g_slist_free_full(device->gatt_callbacks, g_free);
 
 	attio_cleanup(device);
 
@@ -3430,6 +3442,16 @@ static void attio_disconnected(gpointer data, gpointer user_data)
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
@@ -3448,6 +3470,7 @@ static void att_disconnected_cb(void *user_data)
 	DBG("%s (%d)", strerror(err), err);
 
 	g_slist_foreach(device->attios, attio_disconnected, NULL);
+	g_slist_foreach(device->gatt_callbacks, gatt_disconnected, NULL);
 
 	if (!device_get_auto_connect(device)) {
 		DBG("Automatic connection disabled");
@@ -3552,7 +3575,14 @@ static void register_gatt_services(struct browse_req *req)
 
 	device_probe_profiles(device, req->profiles_added);
 
-	if (device->attios == NULL && device->attios_offline == NULL)
+	/* TODO: This check seems unnecessary. We may not always want to cleanup
+	 * the connection since there will always be built-in plugins who want
+	 * to interact with remote GATT services. Even if we didn't have those,
+	 * the GATT D-Bus API will need to interact with these, so we should
+	 * later remove this check entirely.
+	 */
+	if (device->attios == NULL && device->attios_offline == NULL &&
+						device->gatt_callbacks == NULL)
 		attio_cleanup(device);
 
 	g_dbus_emit_property_changed(dbus_conn, device->path,
@@ -3565,6 +3595,17 @@ static void register_gatt_services(struct browse_req *req)
 	browse_request_free(req);
 }
 
+static void notify_gatt_client_ready(gpointer data, gpointer user_data)
+{
+	struct gatt_cb_data *gatt_data = data;
+	struct bt_gatt_client *client = user_data;
+
+	DBG("");
+
+	if (gatt_data->ready_func)
+		gatt_data->ready_func(client, gatt_data->user_data);
+}
+
 static void gatt_client_ready_cb(bool success, uint8_t att_ecode,
 								void *user_data)
 {
@@ -3592,11 +3633,30 @@ static void gatt_client_ready_cb(bool success, uint8_t att_ecode,
 	if (device->browse)
 		register_gatt_services(device->browse);
 
-	/*
-	 * TODO: Change attio callbacks to accept a gatt-client instead of a
-	 * GAttrib.
-	 */
 	g_slist_foreach(device->attios, attio_connected, device->attrib);
+	g_slist_foreach(device->gatt_callbacks, notify_gatt_client_ready,
+							device->gatt_client);
+}
+
+struct svc_chngd_data {
+	struct bt_gatt_client *client;
+	uint16_t start_handle;
+	uint16_t end_handle;
+};
+
+static void notify_gatt_svc_chngd(gpointer data, gpointer user_data)
+{
+	struct gatt_cb_data *gatt_data = data;
+	struct svc_chngd_data *svc_data = user_data;
+
+	DBG("start: 0x%04x, end: 0x%04x", svc_data->start_handle,
+							svc_data->end_handle);
+
+	if (gatt_data->svc_chngd_func)
+		gatt_data->svc_chngd_func(svc_data->client,
+							svc_data->start_handle,
+							svc_data->end_handle,
+							gatt_data->user_data);
 }
 
 static void gatt_client_service_changed(uint16_t start_handle,
@@ -3604,14 +3664,17 @@ static void gatt_client_service_changed(uint16_t start_handle,
 							void *user_data)
 {
 	struct btd_device *device = user_data;
+	struct svc_chngd_data data;
 
 	DBG("gatt-client: Service Changed: start 0x%04x, end: 0x%04x",
 						start_handle, end_handle);
 
-	/*
-	 * TODO: Notify clients that services changed so they can handle it
-	 * directly. Remove the profile if a service was removed.
-	 */
+	memset(&data, 0, sizeof(data));
+	data.client = device->gatt_client;
+	data.start_handle = start_handle;
+	data.end_handle = end_handle;
+
+	g_slist_foreach(device->gatt_callbacks, notify_gatt_svc_chngd, &data);
 	device_browse_primary(device, NULL);
 }
 
@@ -4980,7 +5043,8 @@ gboolean btd_device_remove_attio_callback(struct btd_device *device, guint id)
 
 	g_free(attio);
 
-	if (device->attios != NULL || device->attios_offline != NULL)
+	if (device->attios != NULL || device->attios_offline != NULL ||
+						device->gatt_callbacks != NULL)
 		return TRUE;
 
 	attio_cleanup(device);
@@ -4988,6 +5052,82 @@ gboolean btd_device_remove_attio_callback(struct btd_device *device, guint id)
 	return TRUE;
 }
 
+unsigned int btd_device_add_gatt_callbacks(struct btd_device *device,
+			btd_gatt_client_ready_t ready_func,
+			btd_gatt_client_service_changed_t service_changed_func,
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
+	gatt_data->svc_chngd_func = service_changed_func;
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
+		ready_func(device->gatt_client, user_data);
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
index 0000000..b449fcd
--- /dev/null
+++ b/src/gatt-callbacks.h
@@ -0,0 +1,42 @@
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
+ *
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+#include <stdint.h>
+#include <stdbool.h>
+
+typedef void (*btd_gatt_client_ready_t) (struct bt_gatt_client *client,
+							void *user_data);
+typedef void (*btd_gatt_client_service_changed_t) (
+						struct bt_gatt_client *client,
+						uint16_t start_handle,
+						uint16_t end_handle,
+						void *user_data);
+typedef void (*btd_gatt_disconnect_t) (void *user_data);
+
+unsigned int btd_device_add_gatt_callbacks(struct btd_device *device,
+			btd_gatt_client_ready_t ready_func,
+			btd_gatt_client_service_changed_t service_changed_func,
+			btd_gatt_disconnect_t disconnect_func,
+			void *user_data);
+bool btd_device_remove_gatt_callbacks(struct btd_device *device,
+							unsigned int id);
-- 
2.1.0.rc2.206.gedb03e5

