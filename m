Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: [RFC v0 4/5] adapter: add RequestDiscoverable() and ReleaseDiscoverable()
Date: Thu,  6 Jun 2013 15:18:58 +0100
Message-Id: <1370528339-7921-4-git-send-email-gustavo@padovan.org>
In-Reply-To: <1370528339-7921-1-git-send-email-gustavo@padovan.org>
References: <1370528339-7921-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

With those two methods BlueZ is now aware of client lifetime and can set
Discoverable back to False if all clients exit or call
ReleaseDiscoverable()
---
 src/adapter.c | 110 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 110 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index bb5737e..c59b526 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -169,6 +169,7 @@ struct btd_adapter {
 	GSList *connections;		/* Connected devices */
 	GSList *devices;		/* Devices structure pointers */
 	GSList *connect_list;		/* Devices to connect when found */
+	GSList *discoverable_list;	/* list fo discoverable sessions */
 	struct btd_device *connect_le;	/* LE device waiting to be connected */
 	sdp_list_t *services;		/* Services associated to adapter */
 
@@ -1699,6 +1700,111 @@ static DBusMessage *stop_discovery(DBusConnection *conn,
 	return dbus_message_new_method_return(msg);
 }
 
+static void discoverable_destroy(void *user_data)
+{
+	struct watch_client *client = user_data;
+	struct btd_adapter *adapter = client->adapter;
+
+	DBG("owner %s", client->owner);
+
+	adapter->discoverable_list = g_slist_remove(adapter->discoverable_list,
+								client);
+
+	g_free(client->owner);
+	g_free(client);
+}
+
+static void discoverable_disconnect(DBusConnection *conn, void *user_data)
+{
+	struct watch_client *client = user_data;
+	struct btd_adapter *adapter = client->adapter;
+
+	DBG("owner %s", client->owner);
+
+	adapter->discoverable_list = g_slist_remove(adapter->discoverable_list,
+								client);
+
+	if (adapter->discoverable_list)
+		return;
+
+	set_discoverable(adapter, 0x00, 0);
+}
+
+static DBusMessage *request_discoverable(DBusConnection *conn,
+					DBusMessage *msg, void *user_data)
+{
+	struct btd_adapter *adapter = user_data;
+	const char *sender = dbus_message_get_sender(msg);
+	struct watch_client *client;
+
+	DBG("sender %s", sender);
+
+	if (!(adapter->current_settings & MGMT_SETTING_POWERED))
+		return btd_error_not_ready(msg);
+
+	/*
+	 * Every client can only start one discoverable session, if the client
+	 * already started a discoverable session then return an error.
+	 */
+	if (g_slist_find_custom(adapter->discoverable_list, sender,
+						compare_sender))
+		return btd_error_busy(msg);
+
+	client = g_new0(struct watch_client, 1);
+
+	client->adapter = adapter;
+	client->owner = g_strdup(sender);
+	client->watch = g_dbus_add_disconnect_watch(dbus_conn, sender,
+						discoverable_disconnect, client,
+						discoverable_destroy);
+
+	adapter->discoverable_list = g_slist_prepend(adapter->discoverable_list,
+								client);
+	if (adapter->current_settings & MGMT_SETTING_DISCOVERABLE)
+		return dbus_message_new_method_return(msg);
+
+	if (!set_discoverable(adapter,0x01, 0))
+		return btd_error_failed(msg, "Failed to set Discoverable");
+
+	return dbus_message_new_method_return(msg);
+}
+
+static DBusMessage *release_discoverable(DBusConnection *conn,
+					DBusMessage *msg, void *user_data)
+{
+	struct btd_adapter *adapter = user_data;
+	const char *sender = dbus_message_get_sender(msg);
+	struct watch_client *client;
+	GSList *list;
+
+	DBG("sender %s", sender);
+
+	if (!(adapter->current_settings & MGMT_SETTING_POWERED))
+		return btd_error_not_ready(msg);
+
+	list = g_slist_find_custom(adapter->discoverable_list, sender,
+						compare_sender);
+	if (!list)
+		return btd_error_failed(msg, "No discovery started");
+
+	client = list->data;
+
+	/*
+	 * The destroy function will cleanup the client information and
+	 * also remove it from the list of discoverable clients.
+	 */
+	g_dbus_remove_watch(dbus_conn, client->watch);
+
+	/* If it is the last session set discoverable to false */
+	if (adapter->discoverable_list)
+		return dbus_message_new_method_return(msg);
+
+	if (!set_discoverable(adapter,0x00, 0))
+		return btd_error_failed(msg, "Failed to set Discoverable");
+
+	return dbus_message_new_method_return(msg);
+}
+
 static gboolean property_get_address(const GDBusPropertyTable *property,
 					DBusMessageIter *iter, void *user_data)
 {
@@ -2153,6 +2259,10 @@ static DBusMessage *remove_device(DBusConnection *conn,
 static const GDBusMethodTable adapter_methods[] = {
 	{ GDBUS_METHOD("StartDiscovery", NULL, NULL, start_discovery) },
 	{ GDBUS_METHOD("StopDiscovery", NULL, NULL, stop_discovery) },
+	{ GDBUS_METHOD("RequestDiscoverable", NULL, NULL,
+						request_discoverable) },
+	{ GDBUS_METHOD("ReleaseDiscoverable", NULL, NULL,
+						release_discoverable) },
 	{ GDBUS_ASYNC_METHOD("RemoveDevice",
 			GDBUS_ARGS({ "device", "o" }), NULL, remove_device) },
 	{ }
-- 
1.8.1.4

