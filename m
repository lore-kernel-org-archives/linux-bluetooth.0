Return-Path: <cyrus@holtmann.org>
From: Michael Janssen <jamuraa@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Michael Janssen <jamuraa@chromium.org>
Subject: [BlueZ v5 02/13] core/advertising: Implement RegisterAdvertisement
Date: Wed, 25 Mar 2015 16:00:50 -0700
Message-Id: <1427324461-27651-3-git-send-email-jamuraa@chromium.org>
In-Reply-To: <1427324461-27651-1-git-send-email-jamuraa@chromium.org>
References: <1427324461-27651-1-git-send-email-jamuraa@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Initial implementation of the RegisterAdvertisement function of the
LEAdvertisingManager1 interface.
---
 Makefile.am               |   2 +-
 src/adapter.c             |   2 +-
 src/advertising-manager.c | 132 ----------------
 src/advertising-manager.h |  25 ---
 src/advertising.c         | 386 ++++++++++++++++++++++++++++++++++++++++++++++
 src/advertising.h         |  25 +++
 6 files changed, 413 insertions(+), 159 deletions(-)
 delete mode 100644 src/advertising-manager.c
 delete mode 100644 src/advertising-manager.h
 create mode 100644 src/advertising.c
 create mode 100644 src/advertising.h

diff --git a/Makefile.am b/Makefile.am
index db2978e..676d929 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -175,7 +175,7 @@ src_bluetoothd_SOURCES = $(builtin_sources) \
 			src/uinput.h \
 			src/plugin.h src/plugin.c \
 			src/storage.h src/storage.c \
-			src/advertising-manager.h src/advertising-manager.c \
+			src/advertising.h src/advertising.c \
 			src/agent.h src/agent.c \
 			src/error.h src/error.c \
 			src/adapter.h src/adapter.c \
diff --git a/src/adapter.c b/src/adapter.c
index dbce2c9..0c66e2c 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -74,7 +74,7 @@
 #include "attrib/gatt.h"
 #include "attrib-server.h"
 #include "gatt-database.h"
-#include "advertising-manager.h"
+#include "advertising.h"
 #include "eir.h"
 
 #define ADAPTER_INTERFACE	"org.bluez.Adapter1"
diff --git a/src/advertising-manager.c b/src/advertising-manager.c
deleted file mode 100644
index c3f85c2..0000000
--- a/src/advertising-manager.c
+++ /dev/null
@@ -1,132 +0,0 @@
-/*
- *
- *  BlueZ - Bluetooth protocol stack for Linux
- *
- *  Copyright (C) 2015  Google Inc.
- *
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- */
-
-#include "advertising-manager.h"
-
-#include <stdint.h>
-#include <stdbool.h>
-
-#include <dbus/dbus.h>
-#include <gdbus/gdbus.h>
-
-#include "lib/bluetooth.h"
-#include "lib/sdp.h"
-
-#include "adapter.h"
-#include "dbus-common.h"
-#include "log.h"
-#include "src/shared/util.h"
-
-#define LE_ADVERTISING_MGR_IFACE "org.bluez.LEAdvertisingManager1"
-#define LE_ADVERTISEMENT_IFACE "org.bluez.LEAdvertisement1"
-
-struct btd_advertising_manager {
-	struct btd_adapter *adapter;
-};
-
-static DBusMessage *register_advertisement(DBusConnection *conn,
-						DBusMessage *msg,
-						void *user_data)
-{
-	DBG("RegisterAdvertisement");
-
-	/* TODO */
-	return NULL;
-}
-
-static DBusMessage *unregister_advertisement(DBusConnection *conn,
-						DBusMessage *msg,
-						void *user_data)
-{
-	DBG("UnregisterAdvertisement");
-
-	/* TODO */
-	return NULL;
-}
-
-static const GDBusMethodTable methods[] = {
-	{ GDBUS_EXPERIMENTAL_ASYNC_METHOD("RegisterAdvertisement",
-					GDBUS_ARGS({ "advertisement", "o" },
-							{ "options", "a{sv}" }),
-					NULL, register_advertisement) },
-	{ GDBUS_EXPERIMENTAL_ASYNC_METHOD("UnregisterAdvertisement",
-						GDBUS_ARGS({ "service", "o" }),
-						NULL,
-						unregister_advertisement) },
-	{ }
-};
-
-static void advertising_manager_destroy(void *user_data)
-{
-	struct btd_advertising_manager *manager = user_data;
-
-	free(manager);
-}
-
-static struct btd_advertising_manager *
-advertising_manager_create(struct btd_adapter *adapter)
-{
-	struct btd_advertising_manager *manager;
-
-	manager = new0(struct btd_advertising_manager, 1);
-	if (!manager)
-		return NULL;
-
-	manager->adapter = adapter;
-
-	if (!g_dbus_register_interface(btd_get_dbus_connection(),
-						adapter_get_path(adapter),
-						LE_ADVERTISING_MGR_IFACE,
-						methods, NULL, NULL, manager,
-						advertising_manager_destroy)) {
-		error("Failed to register " LE_ADVERTISING_MGR_IFACE);
-		free(manager);
-		return NULL;
-	}
-
-	return manager;
-}
-
-struct btd_advertising_manager *
-btd_advertising_manager_new(struct btd_adapter *adapter)
-{
-	struct btd_advertising_manager *manager;
-
-	if (!adapter)
-		return NULL;
-
-	manager = advertising_manager_create(adapter);
-	if (!manager)
-		return NULL;
-
-	DBG("LE Advertising Manager created for adapter: %s",
-						adapter_get_path(adapter));
-
-	return manager;
-}
-
-void btd_advertising_manager_destroy(struct btd_advertising_manager *manager)
-{
-	if (!manager)
-		return;
-
-	g_dbus_unregister_interface(btd_get_dbus_connection(),
-					adapter_get_path(manager->adapter),
-					LE_ADVERTISING_MGR_IFACE);
-}
diff --git a/src/advertising-manager.h b/src/advertising-manager.h
deleted file mode 100644
index 4046013..0000000
--- a/src/advertising-manager.h
+++ /dev/null
@@ -1,25 +0,0 @@
-/*
- *
- *  BlueZ - Bluetooth protocol stack for Linux
- *
- *  Copyright (C) 2015  Google Inc.
- *
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- */
-
-struct btd_adapter;
-struct btd_advertising_manager;
-
-struct btd_advertising_manager *btd_advertising_manager_new(
-						struct btd_adapter *adapter);
-void btd_advertising_manager_destroy(struct btd_advertising_manager *manager);
diff --git a/src/advertising.c b/src/advertising.c
new file mode 100644
index 0000000..eb70177
--- /dev/null
+++ b/src/advertising.c
@@ -0,0 +1,386 @@
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
+#include "advertising.h"
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
+#include "error.h"
+#include "log.h"
+#include "src/shared/queue.h"
+#include "src/shared/util.h"
+
+#define LE_ADVERTISING_MGR_IFACE "org.bluez.LEAdvertisingManager1"
+#define LE_ADVERTISEMENT_IFACE "org.bluez.LEAdvertisement1"
+
+struct btd_advertising_manager {
+	struct btd_adapter *adapter;
+	struct queue *adverts;
+};
+
+#define AD_TYPE_BROADCAST 0
+#define AD_TYPE_PERIPHERAL 1
+
+struct advertisement {
+	struct btd_advertising_manager *manager;
+	char *owner;
+	char *path;
+	GDBusClient *client;
+	GDBusProxy *proxy;
+	DBusMessage *reg;
+	uint8_t type; /* Advertising type */
+	bool published;
+};
+
+static bool match_advertisement_path(const void *a, const void *b)
+{
+	const struct advertisement *ad = a;
+	const char *path = b;
+
+	return g_strcmp0(ad->path, path);
+}
+
+static void advertisement_free(void *data)
+{
+	struct advertisement *ad = data;
+
+	if (ad->client) {
+		g_dbus_client_set_disconnect_watch(ad->client, NULL, NULL);
+		g_dbus_client_unref(ad->client);
+	}
+
+	if (ad->proxy)
+		g_dbus_proxy_unref(ad->proxy);
+
+	if (ad->owner)
+		g_free(ad->owner);
+
+	if (ad->path)
+		g_free(ad->path);
+
+	free(ad);
+}
+
+static gboolean advertisement_free_idle_cb(void *data)
+{
+	advertisement_free(data);
+
+	return FALSE;
+}
+
+static void advertisement_release(void *data)
+{
+	struct advertisement *ad = data;
+	DBusMessage *message;
+
+	DBG("Releasing advertisement %s, %s", ad->owner, ad->path);
+
+	message = dbus_message_new_method_call(ad->owner, ad->path,
+							LE_ADVERTISEMENT_IFACE,
+							"Release");
+
+	if (message == NULL) {
+		error("Couldn't allocate D-Bus message");
+		return;
+	}
+
+	g_dbus_send_message(btd_get_dbus_connection(), message);
+}
+
+static void advertisement_destroy(void *data)
+{
+	advertisement_release(data);
+	advertisement_free(data);
+}
+
+
+static void advertisement_remove(void *data)
+{
+	struct advertisement *ad = data;
+
+	g_dbus_client_set_disconnect_watch(ad->client, NULL, NULL);
+
+	queue_remove(ad->manager->adverts, ad);
+
+	g_idle_add(advertisement_free_idle_cb, ad);
+}
+
+static void client_disconnect_cb(DBusConnection *conn, void *user_data)
+{
+	DBG("Client disconnected");
+
+	advertisement_remove(user_data);
+}
+
+static bool parse_advertising_type(GDBusProxy *proxy, uint8_t *type)
+{
+	DBusMessageIter iter;
+	const char *msg_type;
+
+	if (!g_dbus_proxy_get_property(proxy, "Type", &iter))
+		return false;
+
+	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_STRING)
+		return false;
+
+	dbus_message_iter_get_basic(&iter, &msg_type);
+
+	if (!g_strcmp0(msg_type, "broadcast")) {
+		*type = AD_TYPE_BROADCAST;
+		return true;
+	}
+
+	if (!g_strcmp0(msg_type, "peripheral")) {
+		*type = AD_TYPE_PERIPHERAL;
+		return true;
+	}
+
+	return false;
+}
+
+static void refresh_advertisement(struct advertisement *ad)
+{
+	DBG("Refreshing advertisement: %s", ad->path);
+	if (!ad->published) {
+		/* TODO: MGMT API call to update the advertisement */
+	}
+}
+
+static bool parse_advertisement(struct advertisement *ad)
+{
+	if (!parse_advertising_type(ad->proxy, &ad->type)) {
+		error("Failed to read \"Type\" property of advertisement");
+		return false;
+	}
+
+	/* TODO: parse the remaining properties into a shared structure */
+
+	refresh_advertisement(ad);
+
+	return true;
+}
+
+static void advertisement_proxy_added(GDBusProxy *proxy, void *data)
+{
+	struct advertisement *ad = data;
+	DBusMessage *reply;
+
+	if (!parse_advertisement(ad)) {
+		error("Failed to parse advertisement");
+
+		reply = btd_error_failed(ad->reg,
+					"Failed to register advertisement");
+		goto done;
+	}
+
+	g_dbus_client_set_disconnect_watch(ad->client, client_disconnect_cb,
+									ad);
+
+	reply = dbus_message_new_method_return(ad->reg);
+
+	DBG("Advertisement registered: %s", ad->path);
+
+done:
+	g_dbus_send_message(btd_get_dbus_connection(), reply);
+
+	dbus_message_unref(ad->reg);
+	ad->reg = NULL;
+}
+
+static struct advertisement *advertisement_create(DBusConnection *conn,
+					DBusMessage *msg, const char *path)
+{
+	struct advertisement *ad;
+	const char *sender = dbus_message_get_sender(msg);
+
+	if (!path || !g_str_has_prefix(path, "/"))
+		return NULL;
+
+	ad = new0(struct advertisement, 1);
+	if (!ad)
+		return NULL;
+
+	ad->published = false;
+
+	ad->client = g_dbus_client_new_full(conn, sender, path, path);
+	if (!ad->client)
+		goto fail;
+
+	ad->owner = g_strdup(sender);
+	if (!ad->owner)
+		goto fail;
+
+	ad->path = g_strdup(path);
+	if (!ad->path)
+		goto fail;
+
+	DBG("Adding proxy for %s", path);
+	ad->proxy = g_dbus_proxy_new(ad->client, path, LE_ADVERTISEMENT_IFACE);
+	if (!ad->proxy)
+		goto fail;
+
+	g_dbus_client_set_proxy_handlers(ad->client, advertisement_proxy_added,
+								NULL, NULL, ad);
+
+	ad->reg = dbus_message_ref(msg);
+
+	return ad;
+
+fail:
+	advertisement_free(ad);
+	return NULL;
+}
+
+static DBusMessage *register_advertisement(DBusConnection *conn,
+						DBusMessage *msg,
+						void *user_data)
+{
+	struct btd_advertising_manager *manager = user_data;
+	DBusMessageIter args;
+	const char *path;
+	struct advertisement *ad;
+
+	DBG("RegisterAdvertisement");
+
+	if (!dbus_message_iter_init(msg, &args))
+		return btd_error_invalid_args(msg);
+
+	if (dbus_message_iter_get_arg_type(&args) != DBUS_TYPE_OBJECT_PATH)
+		return btd_error_invalid_args(msg);
+
+	dbus_message_iter_get_basic(&args, &path);
+
+	if (queue_find(manager->adverts, match_advertisement_path, path))
+		return btd_error_already_exists(msg);
+
+	/* TODO: support more than one advertisement */
+	if (!queue_isempty(manager->adverts))
+		return btd_error_failed(msg, "Already advertising");
+
+	dbus_message_iter_next(&args);
+
+	if (dbus_message_iter_get_arg_type(&args) != DBUS_TYPE_ARRAY)
+		return btd_error_invalid_args(msg);
+
+	ad = advertisement_create(conn, msg, path);
+	if (!ad)
+		return btd_error_failed(msg,
+					"Failed to register advertisement");
+
+	DBG("Registered advertisement at path %s", path);
+
+	ad->manager = manager;
+	queue_push_tail(manager->adverts, ad);
+
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
+	queue_destroy(manager->adverts, advertisement_destroy);
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
+	manager->adverts = queue_new();
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
diff --git a/src/advertising.h b/src/advertising.h
new file mode 100644
index 0000000..4046013
--- /dev/null
+++ b/src/advertising.h
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

