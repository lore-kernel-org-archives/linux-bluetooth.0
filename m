Return-Path: <cyrus@holtmann.org>
From: Arik Nemtsov <arik@wizery.com>
To: <linux-bluetooth@vger.kernel.org>
Cc: Arik Nemtsov <arik@wizery.com>
Subject: [PATCH 3/3] proximity: tx power: implement tx power server
Date: Sun, 11 Mar 2012 11:23:19 +0200
Message-Id: <1331457799-26506-4-git-send-email-arik@wizery.com>
In-Reply-To: <1331457799-26506-1-git-send-email-arik@wizery.com>
References: <1331457799-26506-1-git-send-email-arik@wizery.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The profile is implemented in txpower.[ch]. A GATT service is registered
with a read callback on the Tx power level attribute.

The Tx power of each LE device is requested from the controller on
connection. Upon receipt, it is cached in a connected_device structure.
When a remote device asks for its Tx power level, the cached value is
returned. The cache is deleted on disconnection.
---
 Makefile.am          |    3 +-
 proximity/reporter.c |   48 +--------
 proximity/txpower.c  |  292 ++++++++++++++++++++++++++++++++++++++++++++++++++
 proximity/txpower.h  |   24 ++++
 4 files changed, 321 insertions(+), 46 deletions(-)
 create mode 100644 proximity/txpower.c
 create mode 100644 proximity/txpower.h

diff --git a/Makefile.am b/Makefile.am
index 0295ce2..d6e1b87 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -206,7 +206,8 @@ builtin_sources += proximity/main.c \
 			proximity/monitor.h proximity/monitor.c \
 			proximity/reporter.h proximity/reporter.c \
 			proximity/linkloss.h proximity/linkloss.c \
-			proximity/immalert.h proximity/immalert.c
+			proximity/immalert.h proximity/immalert.c \
+			proximity/txpower.h proximity/txpower.c
 endif
 
 if SERVICEPLUGIN
diff --git a/proximity/reporter.c b/proximity/reporter.c
index d540233..0da08cc 100644
--- a/proximity/reporter.c
+++ b/proximity/reporter.c
@@ -46,6 +46,7 @@
 #include "reporter.h"
 #include "linkloss.h"
 #include "immalert.h"
+#include "txpower.h"
 
 #define BLUEZ_SERVICE "org.bluez"
 
@@ -74,50 +75,6 @@ const char *get_alert_level_string(uint8_t level)
 	return "unknown";
 }
 
-static void register_tx_power(struct btd_adapter *adapter)
-{
-	uint16_t start_handle, h;
-	const int svc_size = 4;
-	uint8_t atval[256];
-	bt_uuid_t uuid;
-
-	bt_uuid16_create(&uuid, TX_POWER_SVC_UUID);
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
-	att_put_u16(TX_POWER_SVC_UUID, &atval[0]);
-	attrib_db_add(adapter, h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 2);
-
-	/* Power level characteristic */
-	bt_uuid16_create(&uuid, GATT_CHARAC_UUID);
-	atval[0] = ATT_CHAR_PROPER_READ | ATT_CHAR_PROPER_NOTIFY;
-	att_put_u16(h + 1, &atval[1]);
-	att_put_u16(POWER_LEVEL_CHR_UUID, &atval[3]);
-	attrib_db_add(adapter, h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 5);
-
-	/* Power level value */
-	bt_uuid16_create(&uuid, POWER_LEVEL_CHR_UUID);
-	att_put_u8(0x00, &atval[0]);
-	attrib_db_add(adapter, h++, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 1);
-
-	/* Client characteristic configuration */
-	bt_uuid16_create(&uuid, GATT_CLIENT_CHARAC_CFG_UUID);
-	atval[0] = 0x00;
-	atval[1] = 0x00;
-	attrib_db_add(adapter, h++, &uuid, ATT_NONE, ATT_NONE, atval, 2);
-
-	g_assert(h - start_handle == svc_size);
-}
-
 static DBusMessage *get_properties(DBusConnection *conn,
 					DBusMessage *msg, void *data)
 {
@@ -251,7 +208,7 @@ int reporter_init(struct btd_adapter *adapter)
 	radapter->conn = conn;
 
 	register_link_loss(adapter, radapter->conn);
-	register_tx_power(adapter);
+	register_tx_power(adapter, radapter->conn);
 	register_imm_alert(adapter, radapter->conn);
 
 	/*
@@ -309,6 +266,7 @@ void reporter_exit(struct btd_adapter *adapter)
 
 	unregister_link_loss(adapter);
 	unregister_imm_alert(adapter);
+	unregister_tx_power(adapter);
 	dbus_connection_unref(radapter->conn);
 
 	reporter_adapters = g_slist_remove(reporter_adapters, radapter);
diff --git a/proximity/txpower.c b/proximity/txpower.c
new file mode 100644
index 0000000..4b2e65d
--- /dev/null
+++ b/proximity/txpower.c
@@ -0,0 +1,292 @@
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
+#include "reporter.h"
+#include "txpower.h"
+
+#define MIN_TX_POWER_LEVEL (-100)
+
+#define BLUEZ_SERVICE "org.bluez"
+
+struct tx_power_adapter {
+	struct btd_adapter *adapter;
+	DBusConnection *conn;
+	GSList *connected_devices;
+	guint watch;
+};
+
+struct connected_device {
+	struct btd_device *device;
+	struct tx_power_adapter *adapter;
+	int8_t tx_power_level;
+};
+
+static GSList *tx_power_adapters;
+
+static int tpdevice_cmp(gconstpointer a, gconstpointer b)
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
+find_connected_device(struct tx_power_adapter *ta, struct btd_device *device)
+{
+	GSList *l = g_slist_find_custom(ta->connected_devices, device,
+					tpdevice_cmp);
+	if (!l)
+		return NULL;
+
+	return l->data;
+}
+
+static int tpadapter_cmp(gconstpointer a, gconstpointer b)
+{
+	const struct tx_power_adapter *ta = a;
+	const struct btd_adapter *adapter = b;
+
+	if (ta->adapter == adapter)
+		return 0;
+
+	return -1;
+}
+
+static struct tx_power_adapter *
+find_tx_power_adapter(struct btd_adapter *adapter)
+{
+	GSList *l = g_slist_find_custom(tx_power_adapters, adapter,
+					tpadapter_cmp);
+	if (!l)
+		return NULL;
+
+	return l->data;
+}
+
+/* condev can be NULL */
+static void tx_power_remove_condev(struct connected_device *condev)
+{
+	struct tx_power_adapter *ta;
+
+	if (!condev)
+		return;
+
+	ta = condev->adapter;
+
+	if (condev->device)
+		btd_device_unref(condev->device);
+
+	ta->connected_devices = g_slist_remove(ta->connected_devices, condev);
+	g_free(condev);
+}
+
+static uint8_t tx_power_attrib_read(struct attribute *a, gpointer user_data,
+				    struct btd_device *device)
+{
+	struct tx_power_adapter *ta = user_data;
+	struct connected_device *condev;
+	int8_t value = MIN_TX_POWER_LEVEL;
+
+	if (!device)
+		goto out;
+
+	condev = find_connected_device(ta, device);
+	if (!condev)
+		goto out;
+
+	value = condev->tx_power_level;
+
+out:
+	attrib_db_update(ta->adapter, a->handle, NULL, (uint8_t *)&value,
+			 sizeof(value), NULL);
+	DBG("Tx power level: %d", value);
+	return 0;
+}
+
+static void tx_power_read_cb(struct btd_adapter *adapter,
+			     struct btd_device *dev, int8_t level,
+			     gpointer user_data)
+{
+	struct tx_power_adapter *ta = user_data;
+	struct connected_device *condev;
+
+	ta = find_tx_power_adapter(adapter);
+	if (!ta)
+		return;
+
+	condev = find_connected_device(ta, dev);
+	if (!condev)
+		return;
+
+	condev->tx_power_level = level;
+	DBG("updated tx power level of %p to %d", dev, level);
+}
+
+static gboolean handle_property_change(DBusConnection *conn, DBusMessage *msg,
+				       void *data)
+{
+	struct tx_power_adapter *ta = data;
+	DBusMessageIter iter, sub;
+	const char *property;
+	dbus_bool_t conn_state;
+	struct btd_device *device;
+	struct connected_device *condev;
+	const char *obj_path = dbus_message_get_path(msg);
+
+	DBG("path %s", obj_path);
+
+	dbus_message_iter_init(msg, &iter);
+
+	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_STRING) {
+		error("Unexpected signature in device PropertyChanged signal");
+		return TRUE;
+	}
+
+	dbus_message_iter_get_basic(&iter, &property);
+	DBG("property %s", property);
+
+	dbus_message_iter_next(&iter);
+	dbus_message_iter_recurse(&iter, &sub);
+	if (!g_str_equal(property, "Connected"))
+		return TRUE;
+
+	device = adapter_get_device_by_path(ta->adapter, obj_path);
+	if (!device)
+		return TRUE;
+
+	dbus_message_iter_get_basic(&sub, &conn_state);
+	DBG("Connected %d", conn_state);
+	if (conn_state) {
+		/* we only care about LE devices */
+		if (device_is_bredr(device))
+			return TRUE;
+
+		condev = g_new0(struct connected_device, 1);
+		condev->device = btd_device_ref(device);
+		condev->adapter = ta;
+		condev->tx_power_level = MIN_TX_POWER_LEVEL;
+		ta->connected_devices = g_slist_append(ta->connected_devices,
+						       condev);
+
+		/*
+		 * Get the Tx power to this device. It cannot change during
+		 * an LE connection.
+		 */
+		adapter_read_tx_power(ta->adapter, device,
+				      TX_POWER_CURRENT_POWER,
+				      tx_power_read_cb, ta);
+
+		DBG("added connecting device %p", device);
+	} else {
+		condev = find_connected_device(ta, device);
+		if (condev) {
+			tx_power_remove_condev(condev);
+			DBG("removed disconnecting device %p", device);
+		}
+	}
+
+	return TRUE;
+}
+
+void register_tx_power(struct btd_adapter *adapter, DBusConnection *conn)
+{
+	gboolean svc_added;
+	bt_uuid_t uuid;
+	struct tx_power_adapter *ta;
+
+	bt_uuid16_create(&uuid, TX_POWER_SVC_UUID);
+
+	ta = g_new0(struct tx_power_adapter, 1);
+	ta->adapter = adapter;
+	ta->conn = conn;
+
+	tx_power_adapters = g_slist_append(tx_power_adapters, ta);
+
+	/* Tx Power Service */
+	svc_added = gatt_service_add(adapter,
+				     GATT_PRIM_SVC_UUID, &uuid,
+				     /* Power level characteristic */
+				     GATT_OPT_CHR_UUID, POWER_LEVEL_CHR_UUID,
+				     GATT_OPT_CHR_PROPS, ATT_CHAR_PROPER_READ,
+				     GATT_OPT_CHR_VALUE_CB, ATTRIB_READ,
+				     tx_power_attrib_read, ta,
+				     GATT_OPT_INVALID);
+
+	if (!svc_added)
+		goto err;
+
+	/* watch for connecting/disconnecting devices */
+	ta->watch = g_dbus_add_signal_watch(ta->conn,
+			BLUEZ_SERVICE, NULL, DEVICE_INTERFACE,
+			"PropertyChanged", handle_property_change,
+			ta, NULL);
+
+	DBG("Tx Power service added");
+	return;
+
+err:
+	error("Error adding Tx Power service");
+	unregister_tx_power(adapter);
+}
+
+static void remove_condev_list_item(gpointer data, gpointer user_data)
+{
+	struct connected_device *condev = data;
+
+	tx_power_remove_condev(condev);
+}
+
+void unregister_tx_power(struct btd_adapter *adapter)
+{
+	struct tx_power_adapter *ta = find_tx_power_adapter(adapter);
+	if (!ta)
+		return;
+
+	g_dbus_remove_watch(ta->conn, ta->watch);
+
+	g_slist_foreach(ta->connected_devices, remove_condev_list_item, NULL);
+	dbus_connection_unref(ta->conn);
+
+	tx_power_adapters = g_slist_remove(tx_power_adapters, ta);
+	g_free(ta);
+}
diff --git a/proximity/txpower.h b/proximity/txpower.h
new file mode 100644
index 0000000..91c9dcc
--- /dev/null
+++ b/proximity/txpower.h
@@ -0,0 +1,24 @@
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
+void register_tx_power(struct btd_adapter *adapter, DBusConnection *conn);
+void unregister_tx_power(struct btd_adapter *adapter);
-- 
1.7.5.4

