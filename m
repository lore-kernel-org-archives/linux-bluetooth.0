Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/5] adapter: Discovery filter discoverable
Date: Thu, 26 Jul 2018 17:17:20 +0300
Message-Id: <20180726141723.20199-2-luiz.dentz@gmail.com>
In-Reply-To: <20180726141723.20199-1-luiz.dentz@gmail.com>
References: <20180726141723.20199-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This implements the discovery filter discoverable and tracks which
clients had enabled it and restores the settings when the last client
enabling it exits.
---
 src/adapter.c | 56 +++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 54 insertions(+), 2 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index f92c897c7..bd9edddc6 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -157,6 +157,7 @@ struct discovery_filter {
 	int16_t rssi;
 	GSList *uuids;
 	bool duplicate;
+	bool discoverable;
 };
 
 struct watch_client {
@@ -214,6 +215,7 @@ struct btd_adapter {
 
 	bool discovering;		/* discovering property state */
 	bool filtered_discovery;	/* we are doing filtered discovery */
+	bool filtered_discoverable;	/* we are doing filtered discovery */
 	bool no_scan_restart_delay;	/* when this flag is set, restart scan
 					 * without delay */
 	uint8_t discovery_type;		/* current active discovery type */
@@ -1842,6 +1844,16 @@ static void discovery_free(void *user_data)
 	g_free(client);
 }
 
+static bool set_filtered_discoverable(struct btd_adapter *adapter, bool enable)
+{
+	if (adapter->filtered_discoverable == enable)
+		return true;
+
+	adapter->filtered_discoverable = enable;
+
+	return set_discoverable(adapter, enable, 0);
+}
+
 static void discovery_remove(struct watch_client *client)
 {
 	struct btd_adapter *adapter = client->adapter;
@@ -1854,6 +1866,22 @@ static void discovery_remove(struct watch_client *client)
 	adapter->discovery_list = g_slist_remove(adapter->discovery_list,
 								client);
 
+	if (adapter->filtered_discoverable &&
+			client->discovery_filter->discoverable) {
+		GSList *l;
+
+		for (l = adapter->discovery_list; l; l = g_slist_next(l)) {
+			struct watch_client *client = l->data;
+
+			if (client->discovery_filter->discoverable)
+				break;
+		}
+
+		/* Disable filtered discoverable if there are no clients */
+		if (!l)
+			set_filtered_discoverable(adapter, false);
+	}
+
 	discovery_free(client);
 
 	/*
@@ -2224,6 +2252,15 @@ static DBusMessage *start_discovery(DBusConnection *conn,
 					     adapter->set_filter_list, client);
 		adapter->discovery_list = g_slist_prepend(
 					      adapter->discovery_list, client);
+
+		/* Reset discoverable filter if already set */
+		if (adapter->current_settings & MGMT_OP_SET_DISCOVERABLE)
+			goto done;
+
+		/* Set discoverable if filter requires and it*/
+		if (client->discovery_filter->discoverable)
+			set_filtered_discoverable(adapter, true);
+
 		goto done;
 	}
 
@@ -2348,6 +2385,17 @@ static bool parse_duplicate_data(DBusMessageIter *value,
 	return true;
 }
 
+static bool parse_discoverable(DBusMessageIter *value,
+					struct discovery_filter *filter)
+{
+	if (dbus_message_iter_get_arg_type(value) != DBUS_TYPE_BOOLEAN)
+		return false;
+
+	dbus_message_iter_get_basic(value, &filter->discoverable);
+
+	return true;
+}
+
 struct filter_parser {
 	const char *name;
 	bool (*func)(DBusMessageIter *iter, struct discovery_filter *filter);
@@ -2357,6 +2405,7 @@ struct filter_parser {
 	{ "Pathloss", parse_pathloss },
 	{ "Transport", parse_transport },
 	{ "DuplicateData", parse_duplicate_data },
+	{ "Discoverable", parse_discoverable },
 	{ }
 };
 
@@ -2396,6 +2445,7 @@ static bool parse_discovery_filter_dict(struct btd_adapter *adapter,
 	(*filter)->rssi = DISTANCE_VAL_INVALID;
 	(*filter)->type = get_scan_type(adapter);
 	(*filter)->duplicate = false;
+	(*filter)->discoverable = false;
 
 	dbus_message_iter_init(msg, &iter);
 	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_ARRAY ||
@@ -2441,8 +2491,10 @@ static bool parse_discovery_filter_dict(struct btd_adapter *adapter,
 		goto invalid_args;
 
 	DBG("filtered discovery params: transport: %d rssi: %d pathloss: %d "
-		" duplicate data: %s ", (*filter)->type, (*filter)->rssi,
-		(*filter)->pathloss, (*filter)->duplicate ? "true" : "false");
+		" duplicate data: %s discoverable %s", (*filter)->type,
+		(*filter)->rssi, (*filter)->pathloss,
+		(*filter)->duplicate ? "true" : "false",
+		(*filter)->discoverable ? "true" : "false");
 
 	return true;
 
-- 
2.17.1

