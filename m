Return-Path: <cyrus@holtmann.org>
From: Arik Nemtsov <arik@wizery.com>
To: <linux-bluetooth@vger.kernel.org>
Cc: Arik Nemtsov <arik@wizery.com>
Subject: [PATCH 7/8] proximity: immediate alert: implement immediate alert server
Date: Thu,  8 Mar 2012 15:57:11 +0200
Message-Id: <1331215032-27695-8-git-send-email-arik@wizery.com>
In-Reply-To: <1331215032-27695-1-git-send-email-arik@wizery.com>
References: <1331215032-27695-1-git-send-email-arik@wizery.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The profile is implemented in immalert.[ch]. A GATT service is
registered with a write callback on the immediate alert level attribute.
This attribute is write-only and is maintained per remote device.

When a remote device write a raises or lowers the alert level,
an appropriate PropertyChanged signal is emitted. When the alert level
of a device is non-zero, a callback is registered on its disconnection.
When the callback is called, the alert level of the device is reset to
zero and an appropriate signal is emitted.
---
 Makefile.am          |    3 +-
 proximity/immalert.c |  288 ++++++++++++++++++++++++++++++++++++++++++++++++++
 proximity/immalert.h |   26 +++++
 proximity/reporter.c |   42 +-------
 4 files changed, 319 insertions(+), 40 deletions(-)
 create mode 100644 proximity/immalert.c
 create mode 100644 proximity/immalert.h

diff --git a/Makefile.am b/Makefile.am
index 0a253af..0295ce2 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -205,7 +205,8 @@ builtin_sources += proximity/main.c \
 			proximity/manager.h proximity/manager.c \
 			proximity/monitor.h proximity/monitor.c \
 			proximity/reporter.h proximity/reporter.c \
-			proximity/linkloss.h proximity/linkloss.c
+			proximity/linkloss.h proximity/linkloss.c \
+			proximity/immalert.h proximity/immalert.c
 endif
 
 if SERVICEPLUGIN
diff --git a/proximity/immalert.c b/proximity/immalert.c
new file mode 100644
index 0000000..b75abd2
--- /dev/null
+++ b/proximity/immalert.c
@@ -0,0 +1,288 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2012 Texas Instruments Corporation
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <glib.h>
+#include <bluetooth/uuid.h>
+#include <adapter.h>
+
+#include <dbus/dbus.h>
+#include <gdbus.h>
+
+#include "log.h"
+#include "att.h"
+#include "gattrib.h"
+#include "gatt-service.h"
+#include "attrib-server.h"
+#include "device.h"
+#include "attio.h"
+#include "dbus-common.h"
+#include "reporter.h"
+#include "immalert.h"
+
+struct imm_alert_adapter {
+	struct btd_adapter *adapter;
+	DBusConnection *conn;
+	GSList *connected_devices;
+};
+
+struct connected_device {
+	struct btd_device *device;
+	struct imm_alert_adapter *adapter;
+	uint8_t alert_level;
+	guint callback_id;
+};
+
+static GSList *imm_alert_adapters;
+
+static int imdevice_cmp(gconstpointer a, gconstpointer b)
+{
+	const struct connected_device *condev = a;
+	const struct btd_device *device = b;
+
+	if (condev->device == device)
+		return 0;
+
+	return -1;
+}
+
+static struct connected_device *
+find_connected_device(struct imm_alert_adapter *ia, struct btd_device *device)
+{
+	GSList *l = g_slist_find_custom(ia->connected_devices, device,
+					imdevice_cmp);
+	if (!l)
+		return NULL;
+
+	return l->data;
+}
+
+static int imadapter_cmp(gconstpointer a, gconstpointer b)
+{
+	const struct imm_alert_adapter *imadapter = a;
+	const struct btd_adapter *adapter = b;
+
+	if (imadapter->adapter == adapter)
+		return 0;
+
+	return -1;
+}
+
+static struct imm_alert_adapter *
+find_imm_alert_adapter(struct btd_adapter *adapter)
+{
+	GSList *l = g_slist_find_custom(imm_alert_adapters, adapter,
+					imadapter_cmp);
+	if (!l)
+		return NULL;
+
+	return l->data;
+}
+
+const char *imm_get_alert_level(struct btd_device *device)
+{
+	struct imm_alert_adapter *imadapter;
+	struct connected_device *condev;
+
+	if (!device)
+		return get_alert_level_string(NO_ALERT);
+
+	imadapter = find_imm_alert_adapter(device_get_adapter(device));
+	if (!imadapter)
+		return get_alert_level_string(NO_ALERT);
+
+	condev = find_connected_device(imadapter, device);
+	if (!condev)
+		return get_alert_level_string(NO_ALERT);
+
+	return get_alert_level_string(condev->alert_level);
+}
+
+static void imm_alert_emit_alert_signal(struct connected_device *condev,
+					uint8_t alert_level)
+{
+	struct imm_alert_adapter *adapter;
+	const char *path, *alert_level_str;
+
+	if (!condev)
+		return;
+
+	adapter = condev->adapter;
+	path = device_get_path(condev->device);
+	alert_level_str = get_alert_level_string(alert_level);
+
+	DBG("alert %s remote %s", alert_level_str, path);
+
+	emit_property_changed(adapter->conn, path,
+			PROXIMITY_REPORTER_INTERFACE, "ImmediateAlertLevel",
+			DBUS_TYPE_STRING, &alert_level_str);
+}
+
+static void imm_alert_remove_condev(struct connected_device *condev)
+{
+	struct imm_alert_adapter *ia;
+
+	if (!condev)
+		return;
+
+	ia = condev->adapter;
+
+	if (condev->callback_id && condev->device)
+		btd_device_remove_attio_callback(condev->device,
+						 condev->callback_id);
+
+	if (condev->device)
+		btd_device_unref(condev->device);
+
+	ia->connected_devices = g_slist_remove(ia->connected_devices, condev);
+	g_free(condev);
+}
+
+/* condev can be NULL */
+static void imm_alert_disc_cb(gpointer user_data)
+{
+	struct connected_device *condev = user_data;
+
+	if (!condev)
+		return;
+
+	DBG("immediate alert remove device %p", condev->device);
+
+	imm_alert_emit_alert_signal(condev, NO_ALERT);
+	imm_alert_remove_condev(condev);
+}
+
+static uint8_t imm_alert_alert_lvl_write(struct attribute *a,
+			gpointer user_data, struct btd_device *device)
+{
+	uint8_t value;
+	struct imm_alert_adapter *ia = user_data;
+	struct connected_device *condev = NULL;
+
+	if (!device)
+		goto set_error;
+
+	condev = find_connected_device(ia, device);
+
+	if (a->len == 0) {
+		DBG("Illegal alert level length");
+		goto set_error;
+	}
+
+	value = a->data[0];
+	if (value != NO_ALERT && value != MILD_ALERT && value != HIGH_ALERT) {
+		DBG("Illegal alert value");
+		goto set_error;
+	}
+
+	/* Register a disconnect cb if the alert level is non-zero */
+	if (value != NO_ALERT && !condev) {
+		condev = g_new0(struct connected_device, 1);
+		condev->device = btd_device_ref(device);
+		condev->adapter = ia;
+		condev->callback_id = btd_device_add_attio_callback(device,
+					NULL, imm_alert_disc_cb, condev);
+		ia->connected_devices = g_slist_append(ia->connected_devices,
+						       condev);
+		DBG("added connected dev %p", device);
+	}
+
+	if (value != NO_ALERT) {
+		condev->alert_level = value;
+		imm_alert_emit_alert_signal(condev, value);
+	}
+
+	/*
+	 * Emit NO_ALERT if the alert level was non-zero before. This is
+	 * guaranteed when there's a condev.
+	 */
+	if (value == NO_ALERT && condev)
+		imm_alert_disc_cb(condev);
+
+	DBG("alert level set to %d by device %p", value, device);
+	return 0;
+
+set_error:
+	error("Set immediate alert level for dev %p", device);
+	/* remove alerts by erroneous devices */
+	imm_alert_disc_cb(condev);
+	return ATT_ECODE_IO;
+}
+
+void register_imm_alert(struct btd_adapter *adapter, DBusConnection *conn)
+{
+	gboolean svc_added;
+	bt_uuid_t uuid;
+	struct imm_alert_adapter *imadapter;
+
+	bt_uuid16_create(&uuid, IMMEDIATE_ALERT_SVC_UUID);
+
+	imadapter = g_new0(struct imm_alert_adapter, 1);
+	imadapter->adapter = adapter;
+	imadapter->conn = dbus_connection_ref(conn);
+
+	imm_alert_adapters = g_slist_append(imm_alert_adapters, imadapter);
+
+	/* Immediate Alert Service */
+	svc_added = gatt_service_add(adapter,
+		GATT_PRIM_SVC_UUID, &uuid,
+		/* Alert level characteristic */
+		GATT_OPT_CHR_UUID, ALERT_LEVEL_CHR_UUID,
+		GATT_OPT_CHR_PROPS,
+			ATT_CHAR_PROPER_WRITE_WITHOUT_RESP,
+		GATT_OPT_CHR_VALUE_CB, ATTRIB_WRITE,
+			imm_alert_alert_lvl_write, imadapter,
+		GATT_OPT_INVALID);
+
+	if (!svc_added) {
+		unregister_imm_alert(adapter);
+		return;
+	}
+
+	DBG("Immediate Alert service added");
+}
+
+static void remove_condev_list_item(gpointer data, gpointer user_data)
+{
+	struct connected_device *condev = data;
+
+	imm_alert_remove_condev(condev);
+}
+
+void unregister_imm_alert(struct btd_adapter *adapter)
+{
+	struct imm_alert_adapter *imadapter;
+
+	imadapter = find_imm_alert_adapter(adapter);
+	if (!adapter)
+		return;
+
+	g_slist_foreach(imadapter->connected_devices, remove_condev_list_item,
+			NULL);
+	dbus_connection_unref(imadapter->conn);
+
+	imm_alert_adapters = g_slist_remove(imm_alert_adapters, imadapter);
+	g_free(imadapter);
+}
diff --git a/proximity/immalert.h b/proximity/immalert.h
new file mode 100644
index 0000000..8ef2d8a
--- /dev/null
+++ b/proximity/immalert.h
@@ -0,0 +1,26 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2012  Texas Instruments Corporation
+ *
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+void register_imm_alert(struct btd_adapter *adapter, DBusConnection *conn);
+void unregister_imm_alert(struct btd_adapter *adapter);
+const char *imm_get_alert_level(struct btd_device *device);
diff --git a/proximity/reporter.c b/proximity/reporter.c
index f791460..4972aa2 100644
--- a/proximity/reporter.c
+++ b/proximity/reporter.c
@@ -39,6 +39,7 @@
 #include "attrib-server.h"
 #include "reporter.h"
 #include "linkloss.h"
+#include "immalert.h"
 
 static DBusConnection *connection;
 
@@ -100,44 +101,6 @@ static void register_tx_power(struct btd_adapter *adapter)
 	g_assert(h - start_handle == svc_size);
 }
 
-static void register_immediate_alert(struct btd_adapter *adapter)
-{
-	uint16_t start_handle, h;
-	const int svc_size = 3;
-	uint8_t atval[256];
-	bt_uuid_t uuid;
-
-	bt_uuid16_create(&uuid, IMMEDIATE_ALERT_SVC_UUID);
-	start_handle = attrib_db_find_avail(adapter, &uuid, svc_size);
-	if (start_handle == 0) {
-		error("Not enough free handles to register service");
-		return;
-	}
-
-	DBG("start_handle=0x%04x", start_handle);
-
-	h = start_handle;
-
-	/* Primary service definition */
-	bt_uuid16_create(&uuid, GATT_PRIM_SVC_UUID);
-	att_put_u16(IMMEDIATE_ALERT_SVC_UUID, &atval[0]);
-	attrib_db_add(adapter, h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 2);
-
-	/* Alert level characteristic */
-	bt_uuid16_create(&uuid, GATT_CHARAC_UUID);
-	atval[0] = ATT_CHAR_PROPER_WRITE_WITHOUT_RESP;
-	att_put_u16(h + 1, &atval[1]);
-	att_put_u16(ALERT_LEVEL_CHR_UUID, &atval[3]);
-	attrib_db_add(adapter, h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 5);
-
-	/* Alert level value */
-	bt_uuid16_create(&uuid, ALERT_LEVEL_CHR_UUID);
-	att_put_u8(NO_ALERT, &atval[0]);
-	attrib_db_add(adapter, h++, &uuid, ATT_NONE, ATT_NONE, atval, 1);
-
-	g_assert(h - start_handle == svc_size);
-}
-
 int reporter_init(struct btd_adapter *adapter)
 {
 	if (!main_opts.attrib_server) {
@@ -152,7 +115,7 @@ int reporter_init(struct btd_adapter *adapter)
 
 	register_link_loss(adapter, connection);
 	register_tx_power(adapter);
-	register_immediate_alert(adapter);
+	register_imm_alert(adapter, connection);
 
 	return 0;
 }
@@ -160,5 +123,6 @@ int reporter_init(struct btd_adapter *adapter)
 void reporter_exit(struct btd_adapter *adapter)
 {
 	unregister_link_loss(adapter);
+	unregister_imm_alert(adapter);
 	dbus_connection_unref(connection);
 }
-- 
1.7.5.4

