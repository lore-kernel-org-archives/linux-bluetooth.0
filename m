Return-Path: <cyrus@holtmann.org>
From: Jakub Pawlowski <jpawlowski@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Pawlowski <jpawlowski@google.com>
Subject: [PATCH BlueZ 2/4] core: adapter: Add parameter parsing to StartFilteredDiscovery
Date: Sat,  7 Feb 2015 16:44:54 -0800
Message-Id: <1423356294-14063-1-git-send-email-jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds parameter parsing and basic checks to
StartFilteredDiscovery method.
---
 src/adapter.c | 144 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 144 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index af6fafb..bece847 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -82,6 +82,8 @@
 #define TEMP_DEV_TIMEOUT (3 * 60)
 #define BONDING_TIMEOUT (2 * 60)
 
+#define	DISTNACE_VAL_INVALID	0x7FFF
+
 static DBusConnection *dbus_conn = NULL;
 
 static bool kernel_conn_control = false;
@@ -1744,10 +1746,152 @@ static DBusMessage *start_discovery(DBusConnection *conn,
 	return dbus_message_new_method_return(msg);
 }
 
+static bool parse_filtered_discovery_dict(char *key, DBusMessageIter *value,
+				    GSList *uuids, int16_t *rssi,
+				    uint16_t *pathloss)
+{
+	uint8_t type;
+
+	if (strcmp("UUIDs", key) == 0) {
+		DBusMessageIter arriter;
+
+		if (dbus_message_iter_get_arg_type(value) != DBUS_TYPE_ARRAY)
+			return false;
+		dbus_message_iter_recurse(value, &arriter);
+		while ((type = dbus_message_iter_get_arg_type(&arriter)) !=
+							DBUS_TYPE_INVALID) {
+			char *uuid_str;
+			char *result_uuid;
+			uuid_t uuid_tmp;
+
+			if (dbus_message_iter_get_arg_type(&arriter) !=
+							DBUS_TYPE_STRING)
+				return false;
+
+			dbus_message_iter_get_basic(&arriter, &uuid_str);
+			if (bt_string2uuid(&uuid_tmp, uuid_str) < 0)
+				return false;
+
+			result_uuid = bt_uuid2string(&uuid_tmp);
+
+			uuids = g_slist_prepend(uuids, result_uuid);
+
+		dbus_message_iter_next(&arriter);
+		}
+	} else if (strcmp("RSSI", key) == 0) {
+		if (dbus_message_iter_get_arg_type(value) != DBUS_TYPE_INT16)
+			return false;
+		dbus_message_iter_get_basic(value, rssi);
+		if (*rssi > 0 || *rssi < -127)
+			return false;
+	} else if (strcmp("pathloss", key) == 0) {
+		if (dbus_message_iter_get_arg_type(value) != DBUS_TYPE_UINT16)
+			return false;
+		dbus_message_iter_get_basic(value, pathloss);
+		if (*pathloss > 127)
+			return false;
+	} else {
+		DBG("Unknown key parameter: %s!\n", key);
+		return false;
+	}
+
+	return true;
+}
+
 static DBusMessage *start_filtered_discovery(DBusConnection *conn,
 					DBusMessage *msg, void *user_data)
 {
+	struct btd_adapter *adapter = user_data;
+	const char *sender = dbus_message_get_sender(msg);
+	DBusMessageIter iter, subiter, dictiter, variantiter;
+	uint16_t pathloss = DISTNACE_VAL_INVALID;
+	int16_t rssi = DISTNACE_VAL_INVALID;
+	GSList *uuids = NULL;
+	char *type_str;
+	uint8_t type;
+	GSList *list;
+
+	DBG("sender %s", sender);
+
+	if (!(adapter->current_settings & MGMT_SETTING_POWERED))
+		return btd_error_not_ready(msg);
+
+	/*
+	 * Every client can only start one discovery, if the client
+	 * already started a discovery then return an error.
+	 */
+	list = g_slist_find_custom(adapter->discovery_list, sender,
+						compare_sender);
+	if (list)
+		return btd_error_busy(msg);
+
+	/* parse parameters */
+	dbus_message_iter_init(msg, &iter);
+
+	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_ARRAY ||
+	    dbus_message_iter_get_element_type(&iter) != DBUS_TYPE_DICT_ENTRY)
+		return btd_error_invalid_args(msg);
+
+	dbus_message_iter_recurse(&iter, &subiter);
+	do {
+		int type = dbus_message_iter_get_arg_type(&subiter);
+
+		if (type == DBUS_TYPE_INVALID)
+			break;
+
+		if (type == DBUS_TYPE_DICT_ENTRY) {
+			char *key;
+
+			dbus_message_iter_recurse(&subiter, &dictiter);
+
+			dbus_message_iter_get_basic(&dictiter, &key);
+			if (!dbus_message_iter_next(&dictiter))
+				return btd_error_invalid_args(msg);
+
+			if (dbus_message_iter_get_arg_type(&dictiter) !=
+							DBUS_TYPE_VARIANT)
+				return btd_error_invalid_args(msg);
+
+			dbus_message_iter_recurse(&dictiter, &variantiter);
+
+			if (!parse_filtered_discovery_dict(key, &variantiter,
+						uuids, &rssi, &pathloss))
+				goto invalid_args;
+		}
+
+		dbus_message_iter_next(&subiter);
+	} while (true);
+
+	if (!dbus_message_iter_next(&iter)) {
+		type = 7;
+	} else {
+		if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_STRING)
+			goto invalid_args;
+
+		dbus_message_iter_get_basic(&iter, &type_str);
+
+		if (strcmp(type_str, "bredr") == 0)
+			type = 1;
+		else if (strcmp(type_str, "le") == 0)
+			type = 6;
+		else if (strcmp(type_str, "auto") == 0)
+			type = 7;
+		else
+			goto invalid_args;
+	}
+
+	/* only pathlos or rssi can be set, never both*/
+	if (pathloss != DISTNACE_VAL_INVALID && rssi != DISTNACE_VAL_INVALID)
+		goto invalid_args;
+
+	DBG("filtered discovery params: type: %d rssi: %d pathloss: %d", type,
+							 rssi, pathloss);
+	g_slist_free_full(uuids, g_free);
 	return btd_error_failed(msg, "Not implemented yet");
+
+invalid_args:
+	g_slist_free_full(uuids, g_free);
+	return btd_error_invalid_args(msg);
 }
 
 static DBusMessage *stop_discovery(DBusConnection *conn,
-- 
2.2.0.rc0.207.ga3a616c

