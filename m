Return-Path: <cyrus@holtmann.org>
From: Jakub Pawlowski <jpawlowski@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Pawlowski <jpawlowski@google.com>
Subject: [PATCH v6 5/8] core: adapter: set the filter for each discovery client
Date: Mon, 30 Mar 2015 16:32:17 -0700
Message-Id: <1427758340-14949-5-git-send-email-jpawlowski@google.com>
In-Reply-To: <1427758340-14949-1-git-send-email-jpawlowski@google.com>
References: <1427758340-14949-1-git-send-email-jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds logic for setting, updating and deleting discovery
filter for each client.

Note that the filter is not used yet, making use from filter will
be added in following patches.
---
 src/adapter.c | 120 ++++++++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 113 insertions(+), 7 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 004e685..166e74e 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -160,6 +160,7 @@ struct watch_client {
 	struct btd_adapter *adapter;
 	char *owner;
 	guint watch;
+	struct discovery_filter *discovery_filter;
 };
 
 struct service_auth {
@@ -209,6 +210,9 @@ struct btd_adapter {
 	uint8_t discovery_enable;	/* discovery enabled/disabled */
 	bool discovery_suspended;	/* discovery has been suspended */
 	GSList *discovery_list;		/* list of discovery clients */
+	GSList *set_filter_list;	/* list of clients that specified
+					 * filter, but don't scan yet
+					 */
 	GSList *discovery_found;	/* list of found devices */
 	guint discovery_idle_timeout;	/* timeout between discovery runs */
 	guint passive_scan_timeout;	/* timeout between passive scans */
@@ -1358,6 +1362,15 @@ static uint8_t get_scan_type(struct btd_adapter *adapter)
 	return type;
 }
 
+static void free_discovery_filter(struct discovery_filter *discovery_filter)
+{
+	if (!discovery_filter)
+		return;
+
+	g_slist_free_full(discovery_filter->uuids, g_free);
+	g_free(discovery_filter);
+}
+
 static void trigger_start_discovery(struct btd_adapter *adapter, guint delay);
 
 static void start_discovery_complete(uint8_t status, uint16_t length,
@@ -1657,9 +1670,17 @@ static void discovery_destroy(void *user_data)
 
 	DBG("owner %s", client->owner);
 
+	adapter->set_filter_list = g_slist_remove(adapter->set_filter_list,
+								client);
+
 	adapter->discovery_list = g_slist_remove(adapter->discovery_list,
 								client);
 
+	if (client->discovery_filter) {
+		free_discovery_filter(client->discovery_filter);
+		client->discovery_filter = NULL;
+	}
+
 	g_free(client->owner);
 	g_free(client);
 
@@ -1696,6 +1717,9 @@ static void discovery_disconnect(DBusConnection *conn, void *user_data)
 
 	DBG("owner %s", client->owner);
 
+	adapter->set_filter_list = g_slist_remove(adapter->set_filter_list,
+								client);
+
 	adapter->discovery_list = g_slist_remove(adapter->discovery_list,
 								client);
 
@@ -1729,36 +1753,74 @@ static void discovery_disconnect(DBusConnection *conn, void *user_data)
 				stop_discovery_complete, adapter, NULL);
 }
 
+/* returns true if client was already discovering, false otherwise. *client
+ * will point to discovering client, or client that have pre-set his filter.
+ */
+static bool get_discovery_client(struct btd_adapter *adapter,
+				 const char *owner,
+				 struct watch_client **client)
+{
+	GSList *list = g_slist_find_custom(adapter->discovery_list, owner,
+				   compare_sender);
+	if (list) {
+		*client = list->data;
+		return true;
+	}
+
+	list = g_slist_find_custom(adapter->set_filter_list, owner,
+				   compare_sender);
+	if (list) {
+		*client = list->data;
+		return false;
+	}
+
+	*client = NULL;
+	return false;
+}
+
 static DBusMessage *start_discovery(DBusConnection *conn,
 					DBusMessage *msg, void *user_data)
 {
 	struct btd_adapter *adapter = user_data;
 	const char *sender = dbus_message_get_sender(msg);
 	struct watch_client *client;
-	GSList *list;
+	bool is_discovering;
 
 	DBG("sender %s", sender);
 
 	if (!(adapter->current_settings & MGMT_SETTING_POWERED))
 		return btd_error_not_ready(msg);
 
+	is_discovering = get_discovery_client(adapter, sender, &client);
+
 	/*
 	 * Every client can only start one discovery, if the client
 	 * already started a discovery then return an error.
 	 */
-	list = g_slist_find_custom(adapter->discovery_list, sender,
-						compare_sender);
-	if (list)
+	if (is_discovering)
 		return btd_error_busy(msg);
 
+	/*
+	 * If there was pre-set filter, just reconnect it to discovery_list,
+	 * and trigger scan.
+	 */
+	if (client) {
+		adapter->set_filter_list = g_slist_remove(
+					     adapter->set_filter_list, client);
+		adapter->discovery_list = g_slist_prepend(
+					     adapter->discovery_list, client);
+		trigger_start_discovery(adapter, 0);
+		return dbus_message_new_method_return(msg);
+	}
+
 	client = g_new0(struct watch_client, 1);
 
 	client->adapter = adapter;
 	client->owner = g_strdup(sender);
+	client->discovery_filter = NULL;
 	client->watch = g_dbus_add_disconnect_watch(dbus_conn, sender,
 						discovery_disconnect, client,
 						discovery_destroy);
-
 	adapter->discovery_list = g_slist_prepend(adapter->discovery_list,
 								client);
 
@@ -1953,9 +2015,10 @@ static DBusMessage *set_discovery_filter(DBusConnection *conn,
 					 DBusMessage *msg, void *user_data)
 {
 	struct btd_adapter *adapter = user_data;
+	struct watch_client *client;
 	struct discovery_filter *discovery_filter;
-
 	const char *sender = dbus_message_get_sender(msg);
+	bool is_discovering;
 
 	DBG("sender %s", sender);
 
@@ -1966,7 +2029,38 @@ static DBusMessage *set_discovery_filter(DBusConnection *conn,
 	if (!parse_discovery_filter_dict(&discovery_filter, msg))
 		return btd_error_invalid_args(msg);
 
-	return btd_error_failed(msg, "Not implemented yet");
+	is_discovering = get_discovery_client(adapter, sender, &client);
+
+	if (client) {
+		free_discovery_filter(client->discovery_filter);
+		client->discovery_filter = discovery_filter;
+
+		if (discovery_filter || is_discovering)
+			return dbus_message_new_method_return(msg);
+
+		/* Removing pre-set filter */
+		adapter->set_filter_list = g_slist_remove(
+					      adapter->set_filter_list,
+					      client);
+		g_free(client->owner);
+		g_free(client);
+		DBG("successfully cleared pre-set filter");
+	} else if (discovery_filter) {
+		/* Client pre-setting his filter for first time */
+		client = g_new0(struct watch_client, 1);
+		client->adapter = adapter;
+		client->owner = g_strdup(sender);
+		client->discovery_filter = discovery_filter;
+		client->watch = g_dbus_add_disconnect_watch(dbus_conn, sender,
+						discovery_disconnect, client,
+						discovery_destroy);
+		adapter->set_filter_list = g_slist_prepend(
+					     adapter->set_filter_list, client);
+
+		DBG("successfully pre-set filter");
+	}
+
+	return dbus_message_new_method_return(msg);
 }
 
 static DBusMessage *stop_discovery(DBusConnection *conn,
@@ -5194,6 +5288,18 @@ static void adapter_stop(struct btd_adapter *adapter)
 
 	cancel_passive_scanning(adapter);
 
+	while (adapter->set_filter_list) {
+		struct watch_client *client;
+
+		client = adapter->set_filter_list->data;
+
+		/* g_dbus_remove_watch will remove the client from the
+		 * adapter's list and free it using the discovery_destroy
+		 * function.
+		 */
+		g_dbus_remove_watch(dbus_conn, client->watch);
+	}
+
 	while (adapter->discovery_list) {
 		struct watch_client *client;
 
-- 
2.2.0.rc0.207.ga3a616c

