Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: [PATCH 6/9] adapter: add EnablePairing() and DisablePairing()
Date: Tue, 11 Jun 2013 11:56:24 +0100
Message-Id: <1370948187-3702-6-git-send-email-gustavo@padovan.org>
In-Reply-To: <1370948187-3702-1-git-send-email-gustavo@padovan.org>
References: <1370948187-3702-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

With those two methods BlueZ now has a pairing mode, when EnablePairing()
is called a Pairing Session is created Pairable and Discoverable are set
to True (if they weren't already set) and BlueZ track the lifetime of the
client. Many sessions can exist at the same time.

A session is released either by calling DisablePairing() or if the
client exits unexpectedly.

After the release of the last session Discoverable and Pairable are set
back to the value they had before the start of the first session.
---
 src/adapter.c | 129 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 129 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index bb5737e..06d1207 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -169,6 +169,8 @@ struct btd_adapter {
 	GSList *connections;		/* Connected devices */
 	GSList *devices;		/* Devices structure pointers */
 	GSList *connect_list;		/* Devices to connect when found */
+	uint32_t pairing_settings;	/* settings before pairing session*/
+	GSList *pairing_list;		/* list of pairing sessions */
 	struct btd_device *connect_le;	/* LE device waiting to be connected */
 	sdp_list_t *services;		/* Services associated to adapter */
 
@@ -1699,6 +1701,129 @@ static DBusMessage *stop_discovery(DBusConnection *conn,
 	return dbus_message_new_method_return(msg);
 }
 
+static void discoverable_destroy(void *user_data)
+{
+	struct watch_client *client = user_data;
+	struct btd_adapter *adapter = client->adapter;
+
+	DBG("owner %s", client->owner);
+
+	adapter->pairing_list = g_slist_remove(adapter->pairing_list,
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
+	adapter->pairing_list = g_slist_remove(adapter->pairing_list,
+								client);
+
+	if (adapter->pairing_list)
+		return;
+
+	set_discoverable(adapter,0x01, adapter->discoverable_timeout);
+	if (!(adapter->pairing_settings & MGMT_SETTING_DISCOVERABLE))
+		set_discoverable(adapter,0x00, 0);
+
+	if (!(adapter->pairing_settings & MGMT_SETTING_PAIRABLE))
+		set_mode(adapter, MGMT_OP_SET_PAIRABLE, 0x00);
+}
+
+static DBusMessage *enable_pairing(DBusConnection *conn, DBusMessage *msg,
+							void *user_data)
+{
+	struct btd_adapter *adapter = user_data;
+	const char *sender = dbus_message_get_sender(msg);
+	struct watch_client *client;
+	bool first;
+
+	DBG("sender %s", sender);
+
+	if (!(adapter->current_settings & MGMT_SETTING_POWERED))
+		return btd_error_not_ready(msg);
+
+	/*
+	 * Every client can only start one pairable session, if the client
+	 * already started a pairable session then return an error.
+	 */
+	if (g_slist_find_custom(adapter->pairing_list, sender,
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
+	first = (adapter->pairing_list == NULL);
+
+	adapter->pairing_list = g_slist_prepend(adapter->pairing_list,
+								client);
+
+	if (!first)
+		return dbus_message_new_method_return(msg);
+
+	adapter->pairing_settings = adapter->current_settings &
+		(MGMT_SETTING_DISCOVERABLE | MGMT_SETTING_PAIRABLE);
+
+	set_discoverable(adapter,0x01, 0);
+
+	if (!(adapter->pairing_settings & MGMT_SETTING_PAIRABLE))
+		set_mode(adapter, MGMT_OP_SET_PAIRABLE, 0x01);
+
+	return dbus_message_new_method_return(msg);
+}
+
+static DBusMessage *disable_pairing(DBusConnection *conn, DBusMessage *msg,
+							void *user_data)
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
+	list = g_slist_find_custom(adapter->pairing_list, sender,
+						compare_sender);
+	if (!list)
+		return btd_error_failed(msg, "No pairing session started");
+
+	client = list->data;
+
+	/*
+	 * The destroy function will cleanup the client information and
+	 * also remove it from the list of pairing clients.
+	 */
+	g_dbus_remove_watch(dbus_conn, client->watch);
+
+	/* If it is the last pairing session */
+	if (adapter->pairing_list)
+		return dbus_message_new_method_return(msg);
+
+	set_discoverable(adapter,0x01, adapter->discoverable_timeout);
+	if (!(adapter->pairing_settings & MGMT_SETTING_DISCOVERABLE))
+		set_discoverable(adapter,0x00, 0);
+
+	if (!(adapter->pairing_settings & MGMT_SETTING_PAIRABLE))
+		set_mode(adapter, MGMT_OP_SET_PAIRABLE, 0x00);
+
+	return dbus_message_new_method_return(msg);
+}
+
 static gboolean property_get_address(const GDBusPropertyTable *property,
 					DBusMessageIter *iter, void *user_data)
 {
@@ -2153,6 +2278,10 @@ static DBusMessage *remove_device(DBusConnection *conn,
 static const GDBusMethodTable adapter_methods[] = {
 	{ GDBUS_METHOD("StartDiscovery", NULL, NULL, start_discovery) },
 	{ GDBUS_METHOD("StopDiscovery", NULL, NULL, stop_discovery) },
+	{ GDBUS_METHOD("EnablePairing", NULL, NULL,
+						enable_pairing) },
+	{ GDBUS_METHOD("DisablePairing", NULL, NULL,
+						disable_pairing) },
 	{ GDBUS_ASYNC_METHOD("RemoveDevice",
 			GDBUS_ARGS({ "device", "o" }), NULL, remove_device) },
 	{ }
-- 
1.8.1.4

