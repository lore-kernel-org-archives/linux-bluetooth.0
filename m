Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ 01/17] core: gatt: Introduce gatt-client.
Date: Fri, 19 Dec 2014 13:35:49 -0800
Message-Id: <1419024965-10375-2-git-send-email-armansito@chromium.org>
In-Reply-To: <1419024965-10375-1-git-send-email-armansito@chromium.org>
References: <1419024965-10375-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch introduces src/gatt-client, which will implement the D-Bus
API outlined in doc/gatt-api.txt for the GATT client role.
---
 Makefile.am       |   1 +
 src/device.c      |  24 ++++++++-
 src/gatt-client.c | 142 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/gatt-client.h |  30 ++++++++++++
 4 files changed, 196 insertions(+), 1 deletion(-)
 create mode 100644 src/gatt-client.c
 create mode 100644 src/gatt-client.h

diff --git a/Makefile.am b/Makefile.am
index f2b22ae..02bfacc 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -181,6 +181,7 @@ src_bluetoothd_SOURCES = $(builtin_sources) \
 			src/service.h src/service.c \
 			src/gatt-dbus.h src/gatt-dbus.c \
 			src/gatt.h src/gatt.c \
+			src/gatt-client.h src/gatt-client.c \
 			src/device.h src/device.c src/attio.h \
 			src/dbus-common.c src/dbus-common.h \
 			src/eir.h src/eir.c
diff --git a/src/device.c b/src/device.c
index 2e55281..f13d9aa 100644
--- a/src/device.c
+++ b/src/device.c
@@ -59,6 +59,7 @@
 #include "attrib/gattrib.h"
 #include "attio.h"
 #include "device.h"
+#include "gatt-client.h"
 #include "profile.h"
 #include "service.h"
 #include "dbus-common.h"
@@ -223,6 +224,8 @@ struct btd_device {
 	struct gatt_db *db;			/* GATT db cache */
 	struct bt_gatt_client *client;		/* GATT client instance */
 
+	struct btd_gatt_client *client_dbus;
+
 	struct bearer_state bredr_state;
 	struct bearer_state le_state;
 
@@ -574,6 +577,9 @@ static void device_free(gpointer user_data)
 {
 	struct btd_device *device = user_data;
 
+	btd_gatt_client_destroy(device->client_dbus);
+	device->client_dbus = NULL;
+
 	g_slist_free_full(device->uuids, g_free);
 	g_slist_free_full(device->primaries, g_free);
 	g_slist_free_full(device->attios, g_free);
@@ -2695,6 +2701,8 @@ static void gatt_service_added(struct gatt_db_attribute *attr, void *user_data)
 		service_accept(l->data);
 
 	store_services(device);
+
+	btd_gatt_client_service_added(device->client_dbus, attr);
 }
 
 static gint prim_attr_cmp(gconstpointer a, gconstpointer b)
@@ -2765,6 +2773,8 @@ static void gatt_service_removed(struct gatt_db_attribute *attr,
 	g_free(prim);
 
 	store_services(device);
+
+	btd_gatt_client_service_removed(device->client_dbus, attr);
 }
 
 static struct btd_device *device_new(struct btd_adapter *adapter,
@@ -2791,6 +2801,15 @@ static struct btd_device *device_new(struct btd_adapter *adapter,
 	g_strdelimit(device->path, ":", '_');
 	g_free(address_up);
 
+	str2ba(address, &device->bdaddr);
+
+	device->client_dbus = btd_gatt_client_new(device);
+	if (!device->client_dbus) {
+		error("Failed to create btd_gatt_client");
+		device_free(device);
+		return NULL;
+	}
+
 	DBG("Creating device %s", device->path);
 
 	if (g_dbus_register_interface(dbus_conn,
@@ -2803,7 +2822,6 @@ static struct btd_device *device_new(struct btd_adapter *adapter,
 		return NULL;
 	}
 
-	str2ba(address, &device->bdaddr);
 	device->adapter = adapter;
 	device->temporary = TRUE;
 
@@ -3841,6 +3859,8 @@ static void att_disconnected_cb(int err, void *user_data)
 
 	g_slist_foreach(device->attios, attio_disconnected, NULL);
 
+	btd_gatt_client_disconnected(device->client_dbus);
+
 	if (!device_get_auto_connect(device)) {
 		DBG("Automatic connection disabled");
 		goto done;
@@ -3949,6 +3969,8 @@ static void gatt_client_ready_cb(bool success, uint8_t att_ecode,
 	device_accept_gatt_profiles(device);
 
 	g_slist_foreach(device->attios, attio_connected, device->attrib);
+
+	btd_gatt_client_ready(device->client_dbus);
 }
 
 static void gatt_client_service_changed(uint16_t start_handle,
diff --git a/src/gatt-client.c b/src/gatt-client.c
new file mode 100644
index 0000000..462753c
--- /dev/null
+++ b/src/gatt-client.c
@@ -0,0 +1,142 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2014  Google Inc.
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
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <stdbool.h>
+#include <stdint.h>
+
+#include <bluetooth/bluetooth.h>
+
+#include "log.h"
+#include "adapter.h"
+#include "device.h"
+#include "lib/uuid.h"
+#include "src/shared/queue.h"
+#include "src/shared/att.h"
+#include "src/shared/gatt-db.h"
+#include "src/shared/gatt-client.h"
+#include "src/shared/util.h"
+#include "gatt-client.h"
+
+struct btd_gatt_client {
+	struct btd_device *device;
+	char devaddr[18];
+	struct gatt_db *db;
+	struct bt_gatt_client *gatt;
+
+	struct queue *services;
+};
+
+static void service_free(void *data)
+{
+	/* TODO */
+}
+
+static void create_services(struct btd_gatt_client *client)
+{
+	DBG("Exporting objects for GATT services: %s", client->devaddr);
+
+	/* TODO */
+}
+
+struct btd_gatt_client *btd_gatt_client_new(struct btd_device *device)
+{
+	struct btd_gatt_client *client;
+	struct gatt_db *db;
+
+	if (!device)
+		return NULL;
+
+	db = btd_device_get_gatt_db(device);
+	if (!db)
+		return NULL;
+
+	client = new0(struct btd_gatt_client, 1);
+	if (!client)
+		return NULL;
+
+	client->services = queue_new();
+	if (!client->services) {
+		free(client);
+		return NULL;
+	}
+
+	client->device = device;
+	ba2str(device_get_address(device), client->devaddr);
+
+	client->db = gatt_db_ref(db);
+
+	return client;
+}
+
+void btd_gatt_client_destroy(struct btd_gatt_client *client)
+{
+	if (!client)
+		return;
+
+	queue_destroy(client->services, service_free);
+	bt_gatt_client_unref(client->gatt);
+	gatt_db_unref(client->db);
+	free(client);
+}
+
+void btd_gatt_client_ready(struct btd_gatt_client *client)
+{
+	struct bt_gatt_client *gatt;
+
+	if (!client)
+		return;
+
+	gatt = btd_device_get_gatt_client(client->device);
+	if (!gatt) {
+		error("GATT client not initialized");
+		return;
+	}
+
+	bt_gatt_client_unref(client->gatt);
+	client->gatt = bt_gatt_client_ref(gatt);
+
+	create_services(client);
+}
+
+void btd_gatt_client_service_added(struct btd_gatt_client *client,
+					struct gatt_db_attribute *attrib)
+{
+	/* TODO */
+}
+
+void btd_gatt_client_service_removed(struct btd_gatt_client *client,
+					struct gatt_db_attribute *attrib)
+{
+	/* TODO */
+}
+
+void btd_gatt_client_disconnected(struct btd_gatt_client *client)
+{
+	if (!client)
+		return;
+
+	DBG("Device disconnected. Cleaning up");
+
+	bt_gatt_client_unref(client->gatt);
+	client->gatt = NULL;
+}
diff --git a/src/gatt-client.h b/src/gatt-client.h
new file mode 100644
index 0000000..f6da3b0
--- /dev/null
+++ b/src/gatt-client.h
@@ -0,0 +1,30 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2014  Google Inc.
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
+ */
+
+struct btd_gatt_client;
+
+struct btd_gatt_client *btd_gatt_client_new(struct btd_device *device);
+void btd_gatt_client_destroy(struct btd_gatt_client *client);
+
+void btd_gatt_client_ready(struct btd_gatt_client *client);
+void btd_gatt_client_service_added(struct btd_gatt_client *client,
+					struct gatt_db_attribute *attrib);
+void btd_gatt_client_service_removed(struct btd_gatt_client *client,
+					struct gatt_db_attribute *attrib);
+void btd_gatt_client_disconnected(struct btd_gatt_client *client);
-- 
2.2.0.rc0.207.ga3a616c

