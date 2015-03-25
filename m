Return-Path: <cyrus@holtmann.org>
From: Jakub Pawlowski <jpawlowski@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Pawlowski <jpawlowski@google.com>
Subject: [PATCH v5 4/8] core: adapter: Add parameter parsing to SetDiscoveryFilter
Date: Wed, 25 Mar 2015 01:18:57 -0700
Message-Id: <1427271541-7509-4-git-send-email-jpawlowski@google.com>
In-Reply-To: <1427271541-7509-1-git-send-email-jpawlowski@google.com>
References: <1427271541-7509-1-git-send-email-jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds parameter parsing, and basic internal logic checks to
SetDiscoveryFilter method.
---
 src/adapter.c | 202 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 202 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index 8bf23d1..fd2cd58 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -90,6 +90,10 @@
 
 #define SCAN_TYPE_BREDR (1 << BDADDR_BREDR)
 #define SCAN_TYPE_LE ((1 << BDADDR_LE_PUBLIC) | (1 << BDADDR_LE_RANDOM))
+#define SCAN_TYPE_DUAL (SCAN_TYPE_BREDR | SCAN_TYPE_LE)
+
+#define	DISTANCE_VAL_INVALID	0x7FFF
+#define	PATHLOSS_MAX 137
 
 static DBusConnection *dbus_conn = NULL;
 
@@ -144,6 +148,13 @@ struct conn_param {
 	uint16_t timeout;
 };
 
+struct discovery_filter {
+	uint8_t type;
+	uint16_t pathloss;
+	int16_t rssi;
+	GSList *uuids;
+};
+
 struct watch_client {
 	struct btd_adapter *adapter;
 	char *owner;
@@ -1759,9 +1770,200 @@ static DBusMessage *start_discovery(DBusConnection *conn,
 	return dbus_message_new_method_return(msg);
 }
 
+static bool parse_uuids(DBusMessageIter *value,
+					 GSList **uuids)
+{
+	DBusMessageIter arriter;
+
+	if (dbus_message_iter_get_arg_type(value) != DBUS_TYPE_ARRAY)
+		return false;
+
+	dbus_message_iter_recurse(value, &arriter);
+	while (dbus_message_iter_get_arg_type(&arriter) != DBUS_TYPE_INVALID) {
+		bt_uuid_t uuid, u128;
+		char uuidstr[MAX_LEN_UUID_STR + 1];
+		char *uuid_param;
+
+		if (dbus_message_iter_get_arg_type(&arriter) !=
+						DBUS_TYPE_STRING)
+			return false;
+
+		dbus_message_iter_get_basic(&arriter, &uuid_param);
+
+		if (bt_string_to_uuid(&uuid, uuid_param))
+			return false;
+
+		bt_uuid_to_uuid128(&uuid, &u128);
+		bt_uuid_to_string(&u128, uuidstr, sizeof(uuidstr));
+
+		*uuids = g_slist_prepend(*uuids, strdup(uuidstr));
+
+		dbus_message_iter_next(&arriter);
+	}
+
+	return true;
+}
+
+static bool parse_rssi(DBusMessageIter *value, int16_t *rssi)
+{
+	if (dbus_message_iter_get_arg_type(value) != DBUS_TYPE_INT16)
+		return false;
+
+	dbus_message_iter_get_basic(value, rssi);
+	/* -127 <= RSSI <= +20 (spec V4.2 [Vol 2, Part E] 7.7.65.2) */
+	if (*rssi > 20 || *rssi < -127)
+		return false;
+
+	return true;
+}
+
+static bool parse_pathloss(DBusMessageIter *value,
+					    uint16_t *pathloss)
+{
+	if (dbus_message_iter_get_arg_type(value) != DBUS_TYPE_UINT16)
+		return false;
+
+	dbus_message_iter_get_basic(value, pathloss);
+	/* pathloss filter must be smaller that PATHLOSS_MAX */
+	if (*pathloss > PATHLOSS_MAX)
+		return false;
+
+	return true;
+}
+
+static bool parse_transport(DBusMessageIter *value,
+					     uint8_t *transport)
+{
+	char *transport_str;
+
+	if (dbus_message_iter_get_arg_type(value) != DBUS_TYPE_STRING)
+		return false;
+
+	dbus_message_iter_get_basic(value, &transport_str);
+
+	if (!strcmp(transport_str, "bredr"))
+		*transport = SCAN_TYPE_BREDR;
+	else if (!strcmp(transport_str, "le"))
+		*transport = SCAN_TYPE_LE;
+	else if (!strcmp(transport_str, "auto"))
+		*transport = SCAN_TYPE_DUAL;
+	else
+		return false;
+
+	return true;
+}
+
+static bool parse_discovery_filter_entry(char *key, DBusMessageIter *value,
+					struct discovery_filter *filter)
+{
+	if (!strcmp("UUIDs", key))
+		return parse_uuids(value, &filter->uuids);
+
+	if (!strcmp("RSSI", key))
+		return parse_rssi(value, &filter->rssi);
+
+	if (!strcmp("Pathloss", key))
+		return parse_pathloss(value, &filter->pathloss);
+
+	if (!strcmp("Transport", key))
+		return parse_transport(value, &filter->type);
+
+	DBG("Unknown key parameter: %s!\n", key);
+	return false;
+}
+
+/* This method is responsible for parsing parameters to SetDiscoveryFilter. If
+ * filter in msg was empty, sets *filter to NULL. If whole parsing was
+ * successful, sets *filter to proper value.
+ * Returns false on any error, and true on success.
+ */
+static bool parse_discovery_filter_dict(struct discovery_filter **filter,
+					DBusMessage *msg)
+{
+	DBusMessageIter iter, subiter, dictiter, variantiter;
+	bool is_empty = true;
+
+	*filter = g_try_malloc(sizeof(**filter));
+	if (!*filter)
+		return false;
+
+	(*filter)->uuids = NULL;
+	(*filter)->pathloss = DISTANCE_VAL_INVALID;
+	(*filter)->rssi = DISTANCE_VAL_INVALID;
+	(*filter)->type = SCAN_TYPE_DUAL;
+
+	dbus_message_iter_init(msg, &iter);
+	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_ARRAY ||
+	    dbus_message_iter_get_element_type(&iter) != DBUS_TYPE_DICT_ENTRY)
+		return false;
+
+	dbus_message_iter_recurse(&iter, &subiter);
+	do {
+		int type = dbus_message_iter_get_arg_type(&subiter);
+		char *key;
+
+		if (type == DBUS_TYPE_INVALID)
+			break;
+
+		is_empty = false;
+		dbus_message_iter_recurse(&subiter, &dictiter);
+
+		dbus_message_iter_get_basic(&dictiter, &key);
+		if (!dbus_message_iter_next(&dictiter))
+			goto invalid_args;
+
+		if (dbus_message_iter_get_arg_type(&dictiter) !=
+							     DBUS_TYPE_VARIANT)
+			goto invalid_args;
+
+		dbus_message_iter_recurse(&dictiter, &variantiter);
+
+		if (!parse_discovery_filter_entry(key, &variantiter, *filter))
+			goto invalid_args;
+
+		dbus_message_iter_next(&subiter);
+	} while (true);
+
+	if (is_empty) {
+		g_free(*filter);
+		*filter = NULL;
+		return true;
+	}
+
+	/* only pathlos or rssi can be set, never both */
+	if ((*filter)->pathloss != DISTANCE_VAL_INVALID &&
+	    (*filter)->rssi != DISTANCE_VAL_INVALID)
+		goto invalid_args;
+
+	DBG("filtered discovery params: transport: %d rssi: %d pathloss: %d",
+	    (*filter)->type, (*filter)->rssi, (*filter)->pathloss);
+
+	return true;
+
+invalid_args:
+	g_slist_free_full((*filter)->uuids, g_free);
+	g_free(*filter);
+	*filter = NULL;
+	return false;
+}
+
 static DBusMessage *set_discovery_filter(DBusConnection *conn,
 					 DBusMessage *msg, void *user_data)
 {
+	struct btd_adapter *adapter = user_data;
+	struct discovery_filter *discovery_filter;
+
+	const char *sender = dbus_message_get_sender(msg);
+
+	DBG("sender %s", sender);
+
+	if (!(adapter->current_settings & MGMT_SETTING_POWERED))
+		return btd_error_not_ready(msg);
+
+	/* parse parameters */
+	if (!parse_discovery_filter_dict(&discovery_filter, msg))
+		return btd_error_invalid_args(msg);
+
 	return btd_error_failed(msg, "Not implemented yet");
 }
 
-- 
2.2.0.rc0.207.ga3a616c

