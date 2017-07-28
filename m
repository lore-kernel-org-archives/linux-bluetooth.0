Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/5] core: Add GetDiscoveryFilters
Date: Fri, 28 Jul 2017 15:07:52 +0300
Message-Id: <20170728120754.5263-3-luiz.dentz@gmail.com>
In-Reply-To: <20170728120754.5263-1-luiz.dentz@gmail.com>
References: <20170728120754.5263-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

In order to extend SetDiscoveryFilter with more filters the application
might have to query what filters are available.
---
 doc/adapter-api.txt |  7 +++++
 src/adapter.c       | 86 +++++++++++++++++++++++++++++++++++++----------------
 2 files changed, 67 insertions(+), 26 deletions(-)

diff --git a/doc/adapter-api.txt b/doc/adapter-api.txt
index 03b56119d..c2898694d 100644
--- a/doc/adapter-api.txt
+++ b/doc/adapter-api.txt
@@ -114,6 +114,13 @@ Methods		void StartDiscovery()
 					 org.bluez.Error.NotSupported
 					 org.bluez.Error.Failed
 
+		array{string} GetDiscoveryFilters()
+
+			Return available filters that can be given to
+			SetDiscoveryFilter.
+
+			Possible errors: None
+
 Properties	string Address [readonly]
 
 			The Bluetooth device address.
diff --git a/src/adapter.c b/src/adapter.c
index a2c8b44b9..01860515d 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2136,7 +2136,7 @@ static DBusMessage *start_discovery(DBusConnection *conn,
 	return dbus_message_new_method_return(msg);
 }
 
-static bool parse_uuids(DBusMessageIter *value, GSList **uuids)
+static bool parse_uuids(DBusMessageIter *value, struct discovery_filter *filter)
 {
 	DBusMessageIter arriter;
 
@@ -2161,7 +2161,7 @@ static bool parse_uuids(DBusMessageIter *value, GSList **uuids)
 		bt_uuid_to_uuid128(&uuid, &u128);
 		bt_uuid_to_string(&u128, uuidstr, sizeof(uuidstr));
 
-		*uuids = g_slist_prepend(*uuids, strdup(uuidstr));
+		filter->uuids = g_slist_prepend(filter->uuids, strdup(uuidstr));
 
 		dbus_message_iter_next(&arriter);
 	}
@@ -2169,33 +2169,35 @@ static bool parse_uuids(DBusMessageIter *value, GSList **uuids)
 	return true;
 }
 
-static bool parse_rssi(DBusMessageIter *value, int16_t *rssi)
+static bool parse_rssi(DBusMessageIter *value, struct discovery_filter *filter)
 {
 	if (dbus_message_iter_get_arg_type(value) != DBUS_TYPE_INT16)
 		return false;
 
-	dbus_message_iter_get_basic(value, rssi);
+	dbus_message_iter_get_basic(value, &filter->rssi);
 	/* -127 <= RSSI <= +20 (spec V4.2 [Vol 2, Part E] 7.7.65.2) */
-	if (*rssi > 20 || *rssi < -127)
+	if (filter->rssi > 20 || filter->rssi < -127)
 		return false;
 
 	return true;
 }
 
-static bool parse_pathloss(DBusMessageIter *value, uint16_t *pathloss)
+static bool parse_pathloss(DBusMessageIter *value,
+				struct discovery_filter *filter)
 {
 	if (dbus_message_iter_get_arg_type(value) != DBUS_TYPE_UINT16)
 		return false;
 
-	dbus_message_iter_get_basic(value, pathloss);
+	dbus_message_iter_get_basic(value, &filter->pathloss);
 	/* pathloss filter must be smaller that PATHLOSS_MAX */
-	if (*pathloss > PATHLOSS_MAX)
+	if (filter->pathloss > PATHLOSS_MAX)
 		return false;
 
 	return true;
 }
 
-static bool parse_transport(DBusMessageIter *value, uint8_t *transport)
+static bool parse_transport(DBusMessageIter *value, 
+					struct discovery_filter *filter)
 {
 	char *transport_str;
 
@@ -2205,42 +2207,47 @@ static bool parse_transport(DBusMessageIter *value, uint8_t *transport)
 	dbus_message_iter_get_basic(value, &transport_str);
 
 	if (!strcmp(transport_str, "bredr"))
-		*transport = SCAN_TYPE_BREDR;
+		filter->type = SCAN_TYPE_BREDR;
 	else if (!strcmp(transport_str, "le"))
-		*transport = SCAN_TYPE_LE;
+		filter->type = SCAN_TYPE_LE;
 	else if (strcmp(transport_str, "auto"))
 		return false;
 
 	return true;
 }
 
-static bool parse_reset_data(DBusMessageIter *value, bool *duplicates)
+static bool parse_reset_data(DBusMessageIter *value,
+					struct discovery_filter *filter)
 {
 	if (dbus_message_iter_get_arg_type(value) != DBUS_TYPE_BOOLEAN)
 		return false;
 
-	dbus_message_iter_get_basic(value, duplicates);
+	dbus_message_iter_get_basic(value, &filter->reset);
 
 	return true;
 }
 
+struct filter_parser {
+	const char *name;
+	bool (*func)(DBusMessageIter *iter, struct discovery_filter *filter);
+} parsers[] = {
+	{ "UUIDs", parse_uuids },
+	{ "RSSI", parse_rssi },
+	{ "Pathloss", parse_pathloss },
+	{ "Transport", parse_transport },
+	{ "ResetData", parse_reset_data },
+	{ }
+};
+
 static bool parse_discovery_filter_entry(char *key, DBusMessageIter *value,
 						struct discovery_filter *filter)
 {
-	if (!strcmp("UUIDs", key))
-		return parse_uuids(value, &filter->uuids);
-
-	if (!strcmp("RSSI", key))
-		return parse_rssi(value, &filter->rssi);
+	struct filter_parser *parser;
 
-	if (!strcmp("Pathloss", key))
-		return parse_pathloss(value, &filter->pathloss);
-
-	if (!strcmp("Transport", key))
-		return parse_transport(value, &filter->type);
-
-	if (!strcmp("ResetData", key))
-		return parse_reset_data(value, &filter->reset);
+	for (parser = parsers; parser && parser->name; parser++) {
+		if (!strcmp(parser->name, key))
+			return parser->func(value, filter);
+	}
 
 	DBG("Unknown key parameter: %s!\n", key);
 	return false;
@@ -2952,6 +2959,30 @@ static DBusMessage *remove_device(DBusConnection *conn,
 	return NULL;
 }
 
+static DBusMessage *get_discovery_filters(DBusConnection *conn,
+					DBusMessage *msg, void *user_data)
+{
+	DBusMessage *reply;
+	DBusMessageIter iter, array;
+	struct filter_parser *parser;
+
+	reply = dbus_message_new_method_return(msg);
+
+	dbus_message_iter_init_append(reply, &iter);
+
+	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
+					DBUS_TYPE_STRING_AS_STRING, &array);
+
+	for (parser = parsers; parser && parser->name; parser++) {
+		dbus_message_iter_append_basic(&array, DBUS_TYPE_STRING,
+							&parser->name);
+	}
+
+	dbus_message_iter_close_container(&iter, &array);
+
+	return reply;
+}
+
 static const GDBusMethodTable adapter_methods[] = {
 	{ GDBUS_METHOD("StartDiscovery", NULL, NULL, start_discovery) },
 	{ GDBUS_METHOD("SetDiscoveryFilter",
@@ -2960,6 +2991,9 @@ static const GDBusMethodTable adapter_methods[] = {
 	{ GDBUS_METHOD("StopDiscovery", NULL, NULL, stop_discovery) },
 	{ GDBUS_ASYNC_METHOD("RemoveDevice",
 			GDBUS_ARGS({ "device", "o" }), NULL, remove_device) },
+	{ GDBUS_METHOD("GetDiscoveryFilters", NULL,
+			GDBUS_ARGS({ "filters", "as" }),
+			get_discovery_filters) },
 	{ }
 };
 
-- 
2.13.3

