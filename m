Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v6 5/7] advertising: Add IncludeAppearance property
Date: Fri,  4 Aug 2017 16:26:13 +0300
Message-Id: <20170804132615.31174-5-luiz.dentz@gmail.com>
In-Reply-To: <20170804132615.31174-1-luiz.dentz@gmail.com>
References: <20170804132615.31174-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds support to include appearance in the advertisement data
with use of IncludeAppearance property.
---
 doc/advertising-api.txt |   6 ++
 src/advertising.c       | 189 ++++++++++++++++++++++++------------------------
 2 files changed, 100 insertions(+), 95 deletions(-)

diff --git a/doc/advertising-api.txt b/doc/advertising-api.txt
index bcf415c1c..3dbc2270f 100644
--- a/doc/advertising-api.txt
+++ b/doc/advertising-api.txt
@@ -66,6 +66,12 @@ Properties	string Type
 			Includes the Tx Power in the advertising packet.
 			If missing, the Tx Power is not included.
 
+		uint16 IncludeAppearance
+
+			Includes Appearance in the advertising packet.
+
+			Possible values: as found on Device.Appearance
+
 		bool IncludeName
 
 			Include adapter Name, or Alias if set, as scan
diff --git a/src/advertising.c b/src/advertising.c
index 7a1b083bc..a39b82774 100644
--- a/src/advertising.c
+++ b/src/advertising.c
@@ -65,6 +65,7 @@ struct btd_adv_client {
 	uint8_t type; /* Advertising type */
 	bool include_tx_power;
 	bool include_name;
+	bool include_appearance;
 	struct bt_ad *data;
 	uint8_t instance;
 };
@@ -176,45 +177,39 @@ static void client_disconnect_cb(DBusConnection *conn, void *user_data)
 	client_remove(user_data);
 }
 
-static bool parse_type(GDBusProxy *proxy, uint8_t *type)
+static bool parse_type(DBusMessageIter *iter, struct btd_adv_client *client)
 {
-	DBusMessageIter iter;
 	const char *msg_type;
 
-	if (!g_dbus_proxy_get_property(proxy, "Type", &iter))
+	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_STRING)
 		return false;
 
-	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_STRING)
-		return false;
-
-	dbus_message_iter_get_basic(&iter, &msg_type);
+	dbus_message_iter_get_basic(iter, &msg_type);
 
 	if (!g_strcmp0(msg_type, "broadcast")) {
-		*type = AD_TYPE_BROADCAST;
+		client->type = AD_TYPE_BROADCAST;
 		return true;
 	}
 
 	if (!g_strcmp0(msg_type, "peripheral")) {
-		*type = AD_TYPE_PERIPHERAL;
+		client->type = AD_TYPE_PERIPHERAL;
 		return true;
 	}
 
 	return false;
 }
 
-static bool parse_service_uuids(GDBusProxy *proxy, struct bt_ad *data)
+static bool parse_service_uuids(DBusMessageIter *iter,
+					struct btd_adv_client *client)
 {
-	DBusMessageIter iter, ariter;
-
-	if (!g_dbus_proxy_get_property(proxy, "ServiceUUIDs", &iter))
-		return true;
+	DBusMessageIter ariter;
 
-	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_ARRAY)
+	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_ARRAY)
 		return false;
 
-	dbus_message_iter_recurse(&iter, &ariter);
+	dbus_message_iter_recurse(iter, &ariter);
 
-	bt_ad_clear_service_uuid(data);
+	bt_ad_clear_service_uuid(client->data);
 
 	while (dbus_message_iter_get_arg_type(&ariter) == DBUS_TYPE_STRING) {
 		const char *uuid_str;
@@ -227,7 +222,7 @@ static bool parse_service_uuids(GDBusProxy *proxy, struct bt_ad *data)
 		if (bt_string_to_uuid(&uuid, uuid_str) < 0)
 			goto fail;
 
-		if (!bt_ad_add_service_uuid(data, &uuid))
+		if (!bt_ad_add_service_uuid(client->data, &uuid))
 			goto fail;
 
 		dbus_message_iter_next(&ariter);
@@ -236,23 +231,21 @@ static bool parse_service_uuids(GDBusProxy *proxy, struct bt_ad *data)
 	return true;
 
 fail:
-	bt_ad_clear_service_uuid(data);
+	bt_ad_clear_service_uuid(client->data);
 	return false;
 }
 
-static bool parse_solicit_uuids(GDBusProxy *proxy, struct bt_ad *data)
+static bool parse_solicit_uuids(DBusMessageIter *iter,
+					struct btd_adv_client *client)
 {
-	DBusMessageIter iter, ariter;
-
-	if (!g_dbus_proxy_get_property(proxy, "SolicitUUIDs", &iter))
-		return true;
+	DBusMessageIter ariter;
 
-	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_ARRAY)
+	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_ARRAY)
 		return false;
 
-	dbus_message_iter_recurse(&iter, &ariter);
+	dbus_message_iter_recurse(iter, &ariter);
 
-	bt_ad_clear_solicit_uuid(data);
+	bt_ad_clear_solicit_uuid(client->data);
 
 	while (dbus_message_iter_get_arg_type(&ariter) == DBUS_TYPE_STRING) {
 		const char *uuid_str;
@@ -265,7 +258,7 @@ static bool parse_solicit_uuids(GDBusProxy *proxy, struct bt_ad *data)
 		if (bt_string_to_uuid(&uuid, uuid_str) < 0)
 			goto fail;
 
-		if (!bt_ad_add_solicit_uuid(data, &uuid))
+		if (!bt_ad_add_solicit_uuid(client->data, &uuid))
 			goto fail;
 
 		dbus_message_iter_next(&ariter);
@@ -274,23 +267,21 @@ static bool parse_solicit_uuids(GDBusProxy *proxy, struct bt_ad *data)
 	return true;
 
 fail:
-	bt_ad_clear_solicit_uuid(data);
+	bt_ad_clear_solicit_uuid(client->data);
 	return false;
 }
 
-static bool parse_manufacturer_data(GDBusProxy *proxy, struct bt_ad *data)
+static bool parse_manufacturer_data(DBusMessageIter *iter,
+					struct btd_adv_client *client)
 {
-	DBusMessageIter iter, entries;
+	DBusMessageIter entries;
 
-	if (!g_dbus_proxy_get_property(proxy, "ManufacturerData", &iter))
-		return true;
-
-	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_ARRAY)
+	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_ARRAY)
 		return false;
 
-	dbus_message_iter_recurse(&iter, &entries);
+	dbus_message_iter_recurse(iter, &entries);
 
-	bt_ad_clear_manufacturer_data(data);
+	bt_ad_clear_manufacturer_data(client->data);
 
 	while (dbus_message_iter_get_arg_type(&entries)
 						== DBUS_TYPE_DICT_ENTRY) {
@@ -321,8 +312,8 @@ static bool parse_manufacturer_data(GDBusProxy *proxy, struct bt_ad *data)
 
 		DBG("Adding ManufacturerData for %04x", manuf_id);
 
-		if (!bt_ad_add_manufacturer_data(data, manuf_id, manuf_data,
-									len))
+		if (!bt_ad_add_manufacturer_data(client->data, manuf_id,
+							manuf_data, len))
 			goto fail;
 
 		dbus_message_iter_next(&entries);
@@ -331,23 +322,21 @@ static bool parse_manufacturer_data(GDBusProxy *proxy, struct bt_ad *data)
 	return true;
 
 fail:
-	bt_ad_clear_manufacturer_data(data);
+	bt_ad_clear_manufacturer_data(client->data);
 	return false;
 }
 
-static bool parse_service_data(GDBusProxy *proxy, struct bt_ad *data)
+static bool parse_service_data(DBusMessageIter *iter,
+					struct btd_adv_client *client)
 {
-	DBusMessageIter iter, entries;
+	DBusMessageIter entries;
 
-	if (!g_dbus_proxy_get_property(proxy, "ServiceData", &iter))
-		return true;
-
-	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_ARRAY)
+	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_ARRAY)
 		return false;
 
-	dbus_message_iter_recurse(&iter, &entries);
+	dbus_message_iter_recurse(iter, &entries);
 
-	bt_ad_clear_service_data(data);
+	bt_ad_clear_service_data(client->data);
 
 	while (dbus_message_iter_get_arg_type(&entries)
 						== DBUS_TYPE_DICT_ENTRY) {
@@ -382,7 +371,8 @@ static bool parse_service_data(GDBusProxy *proxy, struct bt_ad *data)
 
 		DBG("Adding ServiceData for %s", uuid_str);
 
-		if (!bt_ad_add_service_data(data, &uuid, service_data, len))
+		if (!bt_ad_add_service_data(client->data, &uuid, service_data,
+									len))
 			goto fail;
 
 		dbus_message_iter_next(&entries);
@@ -391,46 +381,72 @@ static bool parse_service_data(GDBusProxy *proxy, struct bt_ad *data)
 	return true;
 
 fail:
-	bt_ad_clear_service_data(data);
+	bt_ad_clear_service_data(client->data);
 	return false;
 }
 
-static bool parse_include_tx_power(GDBusProxy *proxy, bool *included)
+static bool parse_include_tx_power(DBusMessageIter *iter,
+					struct btd_adv_client *client)
 {
-	DBusMessageIter iter;
 	dbus_bool_t b;
 
-	if (!g_dbus_proxy_get_property(proxy, "IncludeTxPower", &iter))
-		return true;
-
-	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_BOOLEAN)
+	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_BOOLEAN)
 		return false;
 
-	dbus_message_iter_get_basic(&iter, &b);
+	dbus_message_iter_get_basic(iter, &b);
 
-	*included = b;
+	client->include_tx_power = b;
 
 	return true;
 }
 
-static bool parse_include_name(GDBusProxy *proxy, bool *included)
+static bool parse_include_name(DBusMessageIter *iter,
+					struct btd_adv_client *client)
 {
-	DBusMessageIter iter;
 	dbus_bool_t b;
 
-	if (!g_dbus_proxy_get_property(proxy, "IncludeName", &iter))
-		return true;
+	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_BOOLEAN)
+		return false;
+
+	dbus_message_iter_get_basic(iter, &b);
+
+	if (client->manager->supported_flags & MGMT_ADV_FLAG_LOCAL_NAME)
+		client->include_name = b;
+
+	return true;
+}
+
+static bool parse_include_appearance(DBusMessageIter *iter,
+					struct btd_adv_client *client)
+{
+	dbus_bool_t b;
 
-	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_BOOLEAN)
+	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_BOOLEAN)
 		return false;
 
-	dbus_message_iter_get_basic(&iter, &b);
+	dbus_message_iter_get_basic(iter, &b);
 
-	*included = b;
+	if (client->manager->supported_flags & MGMT_ADV_FLAG_APPEARANCE)
+		client->include_appearance = b;
 
 	return true;
 }
 
+static struct adv_parser {
+	const char *name;
+	bool (*func)(DBusMessageIter *iter, struct btd_adv_client *client);
+} parsers[] = {
+	{ "Type", parse_type },
+	{ "UUIDs", parse_service_uuids },
+	{ "SolicitUUIDs", parse_solicit_uuids },
+	{ "ManufacturerData", parse_manufacturer_data },
+	{ "ServiceData", parse_service_data },
+	{ "IncludeTxPower", parse_include_tx_power },
+	{ "IncludeName", parse_include_name },
+	{ "IncludeAppearance", parse_include_appearance },
+	{ },
+};
+
 static void add_client_complete(struct btd_adv_client *client, uint8_t status)
 {
 	DBusMessage *reply;
@@ -520,6 +536,9 @@ static DBusMessage *refresh_advertisement(struct btd_adv_client *client)
 	if (client->include_name)
 		flags |= MGMT_ADV_FLAG_LOCAL_NAME;
 
+	if (client->include_appearance)
+		flags |= MGMT_ADV_FLAG_APPEARANCE;
+
 	adv_data = bt_ad_generate(client->data, &adv_data_len);
 
 	if (!adv_data || (adv_data_len > calc_max_adv_len(client, flags))) {
@@ -566,39 +585,19 @@ static DBusMessage *refresh_advertisement(struct btd_adv_client *client)
 
 static DBusMessage *parse_advertisement(struct btd_adv_client *client)
 {
-	if (!parse_type(client->proxy, &client->type)) {
-		error("Failed to read \"Type\" property of advertisement");
-		goto fail;
-	}
+	struct adv_parser *parser;
 
-	if (!parse_service_uuids(client->proxy, client->data)) {
-		error("Property \"ServiceUUIDs\" failed to parse");
-		goto fail;
-	}
+	for (parser = parsers; parser && parser->name; parser++) {
+		DBusMessageIter iter;
 
-	if (!parse_solicit_uuids(client->proxy, client->data)) {
-		error("Property \"SolicitUUIDs\" failed to parse");
-		goto fail;
-	}
+		if (!g_dbus_proxy_get_property(client->proxy, parser->name,
+								&iter))
+			continue;
 
-	if (!parse_manufacturer_data(client->proxy, client->data)) {
-		error("Property \"ManufacturerData\" failed to parse");
-		goto fail;
-	}
-
-	if (!parse_service_data(client->proxy, client->data)) {
-		error("Property \"ServiceData\" failed to parse");
-		goto fail;
-	}
-
-	if (!parse_include_tx_power(client->proxy, &client->include_tx_power)) {
-		error("Property \"IncludeTxPower\" failed to parse");
-		goto fail;
-	}
-
-	if (!parse_include_name(client->proxy, &client->include_name)) {
-		error("Property \"IncludeName\" failed to parse");
-		goto fail;
+		if (!parser->func(&iter, client)) {
+			error("Error parsing %s property", parser->name);
+			goto fail;
+		}
 	}
 
 	return refresh_advertisement(client);
-- 
2.13.3

