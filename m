Return-Path: <cyrus@holtmann.org>
From: Michael Janssen <jamuraa@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Michael Janssen <jamuraa@chromium.org>
Subject: [BlueZ v6 02/13] core/advertising: Implement RegisterAdvertisement
Date: Thu, 26 Mar 2015 15:08:32 -0700
Message-Id: <1427407723-27232-3-git-send-email-jamuraa@chromium.org>
In-Reply-To: <1427407723-27232-1-git-send-email-jamuraa@chromium.org>
References: <1427407723-27232-1-git-send-email-jamuraa@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Initial implementation of the RegisterAdvertisement function of the
LEAdvertisingManager1 interface.
---
 src/advertising.c | 249 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 248 insertions(+), 1 deletion(-)

diff --git a/src/advertising.c b/src/advertising.c
index 2f1a09a..2be4343 100644
--- a/src/advertising.c
+++ b/src/advertising.c
@@ -30,7 +30,9 @@
 
 #include "adapter.h"
 #include "dbus-common.h"
+#include "error.h"
 #include "log.h"
+#include "src/shared/queue.h"
 #include "src/shared/util.h"
 
 #define LE_ADVERTISING_MGR_IFACE "org.bluez.LEAdvertisingManager1"
@@ -38,15 +40,256 @@
 
 struct btd_advertising {
 	struct btd_adapter *adapter;
+	struct queue *adverts;
 };
 
+#define AD_TYPE_BROADCAST 0
+#define AD_TYPE_PERIPHERAL 1
+
+struct advertisement {
+	struct btd_advertising *manager;
+	char *owner;
+	char *path;
+	GDBusClient *client;
+	GDBusProxy *proxy;
+	DBusMessage *reg;
+	uint8_t type; /* Advertising type */
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
+	if (!message) {
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
 static DBusMessage *register_advertisement(DBusConnection *conn,
 						DBusMessage *msg,
 						void *user_data)
 {
+	struct btd_advertising *manager = user_data;
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
 
@@ -76,6 +319,8 @@ static void advertising_manager_destroy(void *user_data)
 {
 	struct btd_advertising *manager = user_data;
 
+	queue_destroy(manager->adverts, advertisement_destroy);
+
 	free(manager);
 }
 
@@ -100,6 +345,8 @@ advertising_manager_create(struct btd_adapter *adapter)
 		return NULL;
 	}
 
+	manager->adverts = queue_new();
+
 	return manager;
 }
 
-- 
2.2.0.rc0.207.ga3a616c

