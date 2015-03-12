Return-Path: <cyrus@holtmann.org>
From: Michael Janssen <jamuraa@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Michael Janssen <jamuraa@chromium.org>
Subject: [BlueZ 03/12] advertising-manager: Implement RegisterAdvertisement
Date: Thu, 12 Mar 2015 10:11:50 -0700
Message-Id: <1426180319-16509-4-git-send-email-jamuraa@chromium.org>
In-Reply-To: <1426180319-16509-1-git-send-email-jamuraa@chromium.org>
References: <1426180319-16509-1-git-send-email-jamuraa@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Implement the RegisterAdvertisement method of the LEAdvertisingManager1
interface.
---
 src/advertising-manager.c | 297 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 295 insertions(+), 2 deletions(-)

diff --git a/src/advertising-manager.c b/src/advertising-manager.c
index 754b6ff..76dcad9 100644
--- a/src/advertising-manager.c
+++ b/src/advertising-manager.c
@@ -19,27 +19,318 @@
 
 #include "advertising-manager.h"
 
+#include <stdbool.h>
+#include <stdint.h>
+
 #include <dbus/dbus.h>
 #include <gdbus/gdbus.h>
 
+#include <lib/bluetooth.h>
+#include <lib/bluetooth/sdp.h>
+
 #include "adapter.h"
 #include "dbus-common.h"
+#include "error.h"
 #include "log.h"
+#include "src/shared/queue.h"
 #include "src/shared/util.h"
 
 #define LE_ADVERTISING_MGR_IFACE "org.bluez.LEAdvertisingManager1"
+#define LE_ADVERTISEMENT_IFACE "org.bluez.LEAdvertisement1"
 
 struct btd_advertising_manager {
 	struct btd_adapter *adapter;
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
+	DBusMessage *reg;
+	GDBusClient *client;
+	GDBusProxy *proxy;
+	uint8_t type; /* Advertising type */
+	bool random;
+	bool published;
 };
 
+static bool match_advertisement_path(const void *a, const void *b)
+{
+	const struct advertisement *ad = a;
+	const char *path = b;
+
+	return g_strcmp0(ad->path, path);
+}
+
+static void advertisement_free(struct advertisement *ad)
+{
+	if (ad->client) {
+		g_dbus_client_set_disconnect_watch(ad->client, NULL, NULL);
+		g_dbus_client_set_proxy_handlers(ad->client, NULL, NULL, NULL,
+									NULL);
+		g_dbus_client_set_ready_watch(ad->client, NULL, NULL);
+		g_dbus_client_unref(ad->client);
+	}
+
+	if (ad->proxy)
+		g_dbus_proxy_unref(ad->proxy);
+
+	if (ad->reg)
+		dbus_message_unref(ad->reg);
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
+static void proxy_added_cb(GDBusProxy *proxy, void *user_data)
+{
+	struct advertisement *ad = user_data;
+	const char *iface, *path;
+
+	iface = g_dbus_proxy_get_interface(proxy);
+	path = g_dbus_proxy_get_path(proxy);
+
+	if (g_strcmp0(iface, LE_ADVERTISEMENT_IFACE))
+		return;
+
+	DBG("Object added to advertisement - path: %s iface: %s", path, iface);
+
+	ad->proxy = g_dbus_proxy_ref(proxy);
+}
+
+static void proxy_removed_cb(GDBusProxy *proxy, void *user_data)
+{
+	struct advertisement *ad = user_data;
+
+	DBG("Proxy removed, removing ad: %s", ad->path);
+
+	advertisement_remove(ad);
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
+static void property_changed_cb(GDBusProxy *proxy, const char *name,
+					DBusMessageIter *iter, void *user_data)
+{
+	struct advertisement *ad = user_data;
+
+	if (!parse_advertisement(ad)) {
+		error("Failed to parse updated advertisement");
+		return;
+	}
+}
+
+static void client_ready_cb(GDBusClient *client, void *user_data)
+{
+	struct advertisement *ad = user_data;
+
+	DBusMessage *reply;
+
+	bool fail = false;
+
+	if (!ad->proxy) {
+		error("No advertisement object!");
+		fail = true;
+		reply = btd_error_failed(ad->reg,
+					"No advertisement object found");
+		goto reply;
+	}
+
+	if (!parse_advertisement(ad)) {
+		error("Failed to add advertisement to controller");
+		fail = true;
+		reply = btd_error_failed(ad->reg,
+				"Failed to add advertisement to controller");
+		goto reply;
+	}
+
+	if (g_dbus_proxy_set_property_watch(ad->proxy, property_changed_cb, ad)
+								== FALSE) {
+		error("Failed to set up property watch for advertisement");
+		reply = btd_error_failed(ad->reg,
+					"Can't watch advertisement object");
+		goto reply;
+	}
+
+	DBG("Advertisement registered: %s", ad->path);
+
+	reply = dbus_message_new_method_return(ad->reg);
+
+reply:
+	g_dbus_send_message(btd_get_dbus_connection(), reply);
+	dbus_message_unref(ad->reg);
+	ad->reg = NULL;
+
+	if (fail)
+		advertisement_remove(ad);
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
+	ad->reg = dbus_message_ref(msg);
+
+	g_dbus_client_set_disconnect_watch(ad->client, client_disconnect_cb,
+									ad);
+
+	g_dbus_client_set_proxy_handlers(ad->client, proxy_added_cb,
+						proxy_removed_cb, NULL, ad);
+
+	g_dbus_client_set_ready_watch(ad->client, client_ready_cb, ad);
+
+	ad->random = false;
+	ad->published = false;
+
+	return ad;
+
+fail:
+	advertisement_free(ad);
+	return NULL;
+}
+
 static DBusMessage *register_advertisement(DBusConnection *conn,
 						DBusMessage *msg,
 						void *user_data)
 {
+	struct btd_advertising_manager *manager = user_data;
+	DBusMessageIter args;
+	const char *path;
+	struct advertisement *ad;
+
 	DBG("RegisterAdvertisement");
 
-	/* TODO */
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
 	return NULL;
 }
 
@@ -79,13 +370,15 @@ advertising_manager_create(struct btd_adapter *adapter)
 	if (!g_dbus_register_interface(btd_get_dbus_connection(),
 						adapter_get_path(adapter),
 						LE_ADVERTISING_MGR_IFACE,
-						methods, NULL, NULL, adapter,
+						methods, NULL, NULL, manager,
 						NULL)) {
 		error("Failed to register " LE_ADVERTISING_MGR_IFACE);
 		free(manager);
 		return NULL;
 	}
 
+	manager->adverts = queue_new();
+
 	return manager;
 }
 
-- 
2.2.0.rc0.207.ga3a616c

