Return-Path: <cyrus@holtmann.org>
From: Jakub Pawlowski <jpawlowski@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Pawlowski <jpawlowski@google.com>
Subject: [PATCH 5/7] core: adapter: properly set the filter for discovery
Date: Mon, 16 Mar 2015 12:51:34 -0700
Message-Id: <1426535496-25996-5-git-send-email-jpawlowski@google.com>
In-Reply-To: <1426535496-25996-1-git-send-email-jpawlowski@google.com>
References: <1426535496-25996-1-git-send-email-jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds logic for properly setting, updating and deleting
scan filter.

Note that the filter is not used yet, making proper use from filter
will be added in following patches.
---
 src/adapter.c | 112 +++++++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 104 insertions(+), 8 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 5c6fd65..59e7c97 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -158,6 +158,7 @@ struct watch_client {
 	struct btd_adapter *adapter;
 	char *owner;
 	guint watch;
+	struct discovery_filter *discovery_filter;
 };
 
 struct service_auth {
@@ -207,6 +208,9 @@ struct btd_adapter {
 	uint8_t discovery_enable;	/* discovery enabled/disabled */
 	bool discovery_suspended;	/* discovery has been suspended */
 	GSList *discovery_list;		/* list of discovery clients */
+	GSList *set_filter_list;	/* list of clients that specified
+					 * filter, but don't scan yet
+					 */
 	GSList *discovery_found;	/* list of found devices */
 	guint discovery_idle_timeout;	/* timeout between discovery runs */
 	guint passive_scan_timeout;	/* timeout between passive scans */
@@ -1355,6 +1359,17 @@ static uint8_t get_current_type(struct btd_adapter *adapter)
 	return type;
 }
 
+static void free_discovery_filter(struct discovery_filter *discovery_filter)
+{
+	if (!discovery_filter)
+		return;
+
+	if (discovery_filter->uuids)
+		g_slist_free_full(discovery_filter->uuids, g_free);
+
+	g_free(discovery_filter);
+}
+
 static void trigger_start_discovery(struct btd_adapter *adapter, guint delay);
 
 static void start_discovery_complete(uint8_t status, uint16_t length,
@@ -1654,9 +1669,17 @@ static void discovery_destroy(void *user_data)
 
 	DBG("owner %s", client->owner);
 
+	adapter->set_filter_list = g_slist_remove(adapter->set_filter_list,
+								client);
+
 	adapter->discovery_list = g_slist_remove(adapter->discovery_list,
 								client);
 
+	if (client->discovery_filter != NULL) {
+		free_discovery_filter(client->discovery_filter);
+		client->discovery_filter = NULL;
+	}
+
 	g_free(client->owner);
 	g_free(client);
 
@@ -1693,6 +1716,9 @@ static void discovery_disconnect(DBusConnection *conn, void *user_data)
 
 	DBG("owner %s", client->owner);
 
+	adapter->set_filter_list = g_slist_remove(adapter->set_filter_list,
+								client);
+
 	adapter->discovery_list = g_slist_remove(adapter->discovery_list,
 								client);
 
@@ -1748,16 +1774,28 @@ static DBusMessage *start_discovery(DBusConnection *conn,
 	if (list)
 		return btd_error_busy(msg);
 
-	client = g_new0(struct watch_client, 1);
+	/* If client called SetDiscoveryFilter before, use pre-set filter. */
+	list = g_slist_find_custom(adapter->set_filter_list, sender,
+				   compare_sender);
 
-	client->adapter = adapter;
-	client->owner = g_strdup(sender);
-	client->watch = g_dbus_add_disconnect_watch(dbus_conn, sender,
-						discovery_disconnect, client,
-						discovery_destroy);
+	if (list) {
+		client = list->data;
+		adapter->set_filter_list = g_slist_remove_link(
+					       adapter->set_filter_list, list);
+	} else {
+		client = g_new0(struct watch_client, 1);
+
+		client->adapter = adapter;
+		client->owner = g_strdup(sender);
+		client->discovery_filter = NULL;
+		client->watch = g_dbus_add_disconnect_watch(dbus_conn, sender,
+							discovery_disconnect,
+							client,
+							discovery_destroy);
+	}
 
 	adapter->discovery_list = g_slist_prepend(adapter->discovery_list,
-								client);
+						  client);
 
 	/*
 	 * Just trigger the discovery here. In case an already running
@@ -1922,8 +1960,9 @@ static DBusMessage *set_discovery_filter(DBusConnection *conn,
 					 DBusMessage *msg, void *user_data)
 {
 	struct btd_adapter *adapter = user_data;
+	struct watch_client *client;
 	struct discovery_filter *discovery_filter;
-
+	GSList *list;
 	const char *sender = dbus_message_get_sender(msg);
 
 	DBG("sender %s", sender);
@@ -1935,6 +1974,63 @@ static DBusMessage *set_discovery_filter(DBusConnection *conn,
 	if (!parse_discovery_filter_dict(&discovery_filter, msg))
 		return btd_error_invalid_args(msg);
 
+	list = g_slist_find_custom(adapter->discovery_list, sender,
+				   compare_sender);
+
+	if (!list) {
+		/* Client is not running any form of discovery. */
+		GSList *filter_list;
+
+		/* Check wether client already pre-set his filter. */
+		filter_list = g_slist_find_custom(adapter->set_filter_list,
+						   sender, compare_sender);
+
+		if (filter_list) {
+			client = filter_list->data;
+			free_discovery_filter(client->discovery_filter);
+
+			if (discovery_filter != NULL) {
+				/* just update existing pre-set filter */
+				client->discovery_filter = discovery_filter;
+				DBG("successfully modified pre-set filter");
+				return dbus_message_new_method_return(msg);
+			}
+
+			/* Removing pre-set filter */
+			adapter->set_filter_list = g_slist_remove(
+						      adapter->set_filter_list,
+						      client);
+			g_free(client->owner);
+			g_free(client);
+			DBG("successfully cleared pre-set filter");
+			return dbus_message_new_method_return(msg);
+		}
+		/* Client haven't pre-set his filter yet. */
+
+		/* If there's no filter, no need to set. */
+		if (discovery_filter == NULL)
+			return dbus_message_new_method_return(msg);
+
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
+		return dbus_message_new_method_return(msg);
+	}
+
+	/* Client have already started discovery. */
+	client = list->data;
+	free_discovery_filter(client->discovery_filter);
+	client->discovery_filter = discovery_filter;
+
 	return btd_error_failed(msg, "Not implemented yet");
 }
 
-- 
2.2.0.rc0.207.ga3a616c

