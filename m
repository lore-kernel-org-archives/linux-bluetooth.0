Return-Path: <cyrus@holtmann.org>
From: Michael Janssen <jamuraa@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Michael Janssen <jamuraa@chromium.org>
Subject: [BlueZ v3 02/15] core: advertising: add LEAdvertisingManager stubs
Date: Thu, 19 Mar 2015 10:34:24 -0700
Message-Id: <1426786477-27229-3-git-send-email-jamuraa@chromium.org>
In-Reply-To: <1426786477-27229-1-git-send-email-jamuraa@chromium.org>
References: <1426786477-27229-1-git-send-email-jamuraa@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Introducing src/advertising-manager which will implement the
org.bluez.LEAdvertisingManager1 D-Bus interface defined in
doc/advertising-api.txt.  Each LE-capable controller gets
an instance of the interface.
---
 Makefile.am               |   1 +
 src/adapter.c             |  19 +++++++
 src/advertising-manager.c | 132 ++++++++++++++++++++++++++++++++++++++++++++++
 src/advertising-manager.h |  25 +++++++++
 4 files changed, 177 insertions(+)
 create mode 100644 src/advertising-manager.c
 create mode 100644 src/advertising-manager.h

diff --git a/Makefile.am b/Makefile.am
index 90bb86b..1ddf3f2 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -175,6 +175,7 @@ src_bluetoothd_SOURCES = $(builtin_sources) \
 			src/uinput.h \
 			src/plugin.h src/plugin.c \
 			src/storage.h src/storage.c \
+			src/advertising-manager.h src/advertising-manager.c \
 			src/agent.h src/agent.c \
 			src/error.h src/error.c \
 			src/adapter.h src/adapter.c \
diff --git a/src/adapter.c b/src/adapter.c
index 6eeb2f9..dbce2c9 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -74,6 +74,7 @@
 #include "attrib/gatt.h"
 #include "attrib-server.h"
 #include "gatt-database.h"
+#include "advertising-manager.h"
 #include "eir.h"
 
 #define ADAPTER_INTERFACE	"org.bluez.Adapter1"
@@ -210,6 +211,7 @@ struct btd_adapter {
 	sdp_list_t *services;		/* Services associated to adapter */
 
 	struct btd_gatt_database *database;
+	struct btd_advertising_manager *adv_manager;
 
 	gboolean initialized;
 
@@ -4607,6 +4609,9 @@ static void adapter_remove(struct btd_adapter *adapter)
 	btd_gatt_database_destroy(adapter->database);
 	adapter->database = NULL;
 
+	btd_advertising_manager_destroy(adapter->adv_manager);
+	adapter->adv_manager = NULL;
+
 	g_slist_free(adapter->pin_callbacks);
 	adapter->pin_callbacks = NULL;
 
@@ -6671,6 +6676,20 @@ static int adapter_register(struct btd_adapter *adapter)
 		return -EINVAL;
 	}
 
+	/* Don't start advertising managers on non-LE controllers. */
+	if (adapter->supported_settings & MGMT_SETTING_LE) {
+		adapter->adv_manager = btd_advertising_manager_new(adapter);
+		if (!adapter->adv_manager) {
+			error("Failed to register LEAdvertisingManager1 "
+						"interface for adapter");
+			btd_gatt_database_destroy(adapter->database);
+			adapter->database = NULL;
+			return -EINVAL;
+		}
+	} else {
+		info("Not starting LEAdvertisingManager, LE not supported");
+	}
+
 	db = btd_gatt_database_get_db(adapter->database);
 	adapter->db_id = gatt_db_register(db, services_modified,
 							services_modified,
diff --git a/src/advertising-manager.c b/src/advertising-manager.c
new file mode 100644
index 0000000..c3f85c2
--- /dev/null
+++ b/src/advertising-manager.c
@@ -0,0 +1,132 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2015  Google Inc.
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
+#include "advertising-manager.h"
+
+#include <stdint.h>
+#include <stdbool.h>
+
+#include <dbus/dbus.h>
+#include <gdbus/gdbus.h>
+
+#include "lib/bluetooth.h"
+#include "lib/sdp.h"
+
+#include "adapter.h"
+#include "dbus-common.h"
+#include "log.h"
+#include "src/shared/util.h"
+
+#define LE_ADVERTISING_MGR_IFACE "org.bluez.LEAdvertisingManager1"
+#define LE_ADVERTISEMENT_IFACE "org.bluez.LEAdvertisement1"
+
+struct btd_advertising_manager {
+	struct btd_adapter *adapter;
+};
+
+static DBusMessage *register_advertisement(DBusConnection *conn,
+						DBusMessage *msg,
+						void *user_data)
+{
+	DBG("RegisterAdvertisement");
+
+	/* TODO */
+	return NULL;
+}
+
+static DBusMessage *unregister_advertisement(DBusConnection *conn,
+						DBusMessage *msg,
+						void *user_data)
+{
+	DBG("UnregisterAdvertisement");
+
+	/* TODO */
+	return NULL;
+}
+
+static const GDBusMethodTable methods[] = {
+	{ GDBUS_EXPERIMENTAL_ASYNC_METHOD("RegisterAdvertisement",
+					GDBUS_ARGS({ "advertisement", "o" },
+							{ "options", "a{sv}" }),
+					NULL, register_advertisement) },
+	{ GDBUS_EXPERIMENTAL_ASYNC_METHOD("UnregisterAdvertisement",
+						GDBUS_ARGS({ "service", "o" }),
+						NULL,
+						unregister_advertisement) },
+	{ }
+};
+
+static void advertising_manager_destroy(void *user_data)
+{
+	struct btd_advertising_manager *manager = user_data;
+
+	free(manager);
+}
+
+static struct btd_advertising_manager *
+advertising_manager_create(struct btd_adapter *adapter)
+{
+	struct btd_advertising_manager *manager;
+
+	manager = new0(struct btd_advertising_manager, 1);
+	if (!manager)
+		return NULL;
+
+	manager->adapter = adapter;
+
+	if (!g_dbus_register_interface(btd_get_dbus_connection(),
+						adapter_get_path(adapter),
+						LE_ADVERTISING_MGR_IFACE,
+						methods, NULL, NULL, manager,
+						advertising_manager_destroy)) {
+		error("Failed to register " LE_ADVERTISING_MGR_IFACE);
+		free(manager);
+		return NULL;
+	}
+
+	return manager;
+}
+
+struct btd_advertising_manager *
+btd_advertising_manager_new(struct btd_adapter *adapter)
+{
+	struct btd_advertising_manager *manager;
+
+	if (!adapter)
+		return NULL;
+
+	manager = advertising_manager_create(adapter);
+	if (!manager)
+		return NULL;
+
+	DBG("LE Advertising Manager created for adapter: %s",
+						adapter_get_path(adapter));
+
+	return manager;
+}
+
+void btd_advertising_manager_destroy(struct btd_advertising_manager *manager)
+{
+	if (!manager)
+		return;
+
+	g_dbus_unregister_interface(btd_get_dbus_connection(),
+					adapter_get_path(manager->adapter),
+					LE_ADVERTISING_MGR_IFACE);
+}
diff --git a/src/advertising-manager.h b/src/advertising-manager.h
new file mode 100644
index 0000000..4046013
--- /dev/null
+++ b/src/advertising-manager.h
@@ -0,0 +1,25 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2015  Google Inc.
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
+struct btd_adapter;
+struct btd_advertising_manager;
+
+struct btd_advertising_manager *btd_advertising_manager_new(
+						struct btd_adapter *adapter);
+void btd_advertising_manager_destroy(struct btd_advertising_manager *manager);
-- 
2.2.0.rc0.207.ga3a616c

