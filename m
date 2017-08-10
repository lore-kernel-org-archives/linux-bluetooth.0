Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v8 05/14] advertising: Add Includes property
Date: Thu, 10 Aug 2017 16:32:42 +0300
Message-Id: <20170810133251.23920-5-luiz.dentz@gmail.com>
In-Reply-To: <20170810133251.23920-1-luiz.dentz@gmail.com>
References: <20170810133251.23920-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This enables using the all the supporting includes.

Note: IncludeTxPower has been moved under Includes as well since it was
still experimental.
---
 doc/advertising-api.txt |   8 +-
 src/advertising.c       | 196 ++++++++++++++++++++++++------------------------
 2 files changed, 104 insertions(+), 100 deletions(-)

diff --git a/doc/advertising-api.txt b/doc/advertising-api.txt
index c39b5ec55..65f1331a9 100644
--- a/doc/advertising-api.txt
+++ b/doc/advertising-api.txt
@@ -61,11 +61,13 @@ Properties	string Type
 			Service Data elements to include. The keys are the
 			UUID to associate with the data.
 
-		bool IncludeTxPower
+		array{string} Includes
 
-			Includes the Tx Power in the advertising packet.
-			If missing, the Tx Power is not included.
+			List of features to be included in the advertising
+			packet.
 
+			Possible values: as found on
+					LEAdvertisingManager.SupportedIncludes
 
 LE Advertising Manager hierarchy
 ================================
diff --git a/src/advertising.c b/src/advertising.c
index a16c6a560..6d54814d5 100644
--- a/src/advertising.c
+++ b/src/advertising.c
@@ -63,7 +63,7 @@ struct btd_adv_client {
 	GDBusProxy *proxy;
 	DBusMessage *reg;
 	uint8_t type; /* Advertising type */
-	bool include_tx_power;
+	uint32_t flags;
 	struct bt_ad *data;
 	uint8_t instance;
 };
@@ -194,45 +194,39 @@ static void client_disconnect_cb(DBusConnection *conn, void *user_data)
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
@@ -245,7 +239,7 @@ static bool parse_service_uuids(GDBusProxy *proxy, struct bt_ad *data)
 		if (bt_string_to_uuid(&uuid, uuid_str) < 0)
 			goto fail;
 
-		if (!bt_ad_add_service_uuid(data, &uuid))
+		if (!bt_ad_add_service_uuid(client->data, &uuid))
 			goto fail;
 
 		dbus_message_iter_next(&ariter);
@@ -254,23 +248,21 @@ static bool parse_service_uuids(GDBusProxy *proxy, struct bt_ad *data)
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
+	DBusMessageIter ariter;
 
-	if (!g_dbus_proxy_get_property(proxy, "SolicitUUIDs", &iter))
-		return true;
-
-	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_ARRAY)
+	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_ARRAY)
 		return false;
 
-	dbus_message_iter_recurse(&iter, &ariter);
+	dbus_message_iter_recurse(iter, &ariter);
 
-	bt_ad_clear_solicit_uuid(data);
+	bt_ad_clear_solicit_uuid(client->data);
 
 	while (dbus_message_iter_get_arg_type(&ariter) == DBUS_TYPE_STRING) {
 		const char *uuid_str;
@@ -283,7 +275,7 @@ static bool parse_solicit_uuids(GDBusProxy *proxy, struct bt_ad *data)
 		if (bt_string_to_uuid(&uuid, uuid_str) < 0)
 			goto fail;
 
-		if (!bt_ad_add_solicit_uuid(data, &uuid))
+		if (!bt_ad_add_solicit_uuid(client->data, &uuid))
 			goto fail;
 
 		dbus_message_iter_next(&ariter);
@@ -292,23 +284,21 @@ static bool parse_solicit_uuids(GDBusProxy *proxy, struct bt_ad *data)
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
-
-	if (!g_dbus_proxy_get_property(proxy, "ManufacturerData", &iter))
-		return true;
+	DBusMessageIter entries;
 
-	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_ARRAY)
+	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_ARRAY)
 		return false;
 
-	dbus_message_iter_recurse(&iter, &entries);
+	dbus_message_iter_recurse(iter, &entries);
 
-	bt_ad_clear_manufacturer_data(data);
+	bt_ad_clear_manufacturer_data(client->data);
 
 	while (dbus_message_iter_get_arg_type(&entries)
 						== DBUS_TYPE_DICT_ENTRY) {
@@ -339,8 +329,8 @@ static bool parse_manufacturer_data(GDBusProxy *proxy, struct bt_ad *data)
 
 		DBG("Adding ManufacturerData for %04x", manuf_id);
 
-		if (!bt_ad_add_manufacturer_data(data, manuf_id, manuf_data,
-									len))
+		if (!bt_ad_add_manufacturer_data(client->data, manuf_id,
+							manuf_data, len))
 			goto fail;
 
 		dbus_message_iter_next(&entries);
@@ -349,23 +339,21 @@ static bool parse_manufacturer_data(GDBusProxy *proxy, struct bt_ad *data)
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
-
-	if (!g_dbus_proxy_get_property(proxy, "ServiceData", &iter))
-		return true;
+	DBusMessageIter entries;
 
-	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_ARRAY)
+	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_ARRAY)
 		return false;
 
-	dbus_message_iter_recurse(&iter, &entries);
+	dbus_message_iter_recurse(iter, &entries);
 
-	bt_ad_clear_service_data(data);
+	bt_ad_clear_service_data(client->data);
 
 	while (dbus_message_iter_get_arg_type(&entries)
 						== DBUS_TYPE_DICT_ENTRY) {
@@ -400,7 +388,8 @@ static bool parse_service_data(GDBusProxy *proxy, struct bt_ad *data)
 
 		DBG("Adding ServiceData for %s", uuid_str);
 
-		if (!bt_ad_add_service_data(data, &uuid, service_data, len))
+		if (!bt_ad_add_service_data(client->data, &uuid, service_data,
+									len))
 			goto fail;
 
 		dbus_message_iter_next(&entries);
@@ -409,28 +398,67 @@ static bool parse_service_data(GDBusProxy *proxy, struct bt_ad *data)
 	return true;
 
 fail:
-	bt_ad_clear_service_data(data);
+	bt_ad_clear_service_data(client->data);
 	return false;
 }
 
-static bool parse_include_tx_power(GDBusProxy *proxy, bool *included)
-{
-	DBusMessageIter iter;
-	dbus_bool_t b;
+static struct adv_include {
+	uint8_t flag;
+	const char *name;
+} includes[] = {
+	{ MGMT_ADV_FLAG_TX_POWER, "tx-power" },
+	{ MGMT_ADV_FLAG_APPEARANCE, "appearance" },
+	{ MGMT_ADV_FLAG_LOCAL_NAME, "local-name" },
+	{ },
+};
 
-	if (!g_dbus_proxy_get_property(proxy, "IncludeTxPower", &iter))
-		return true;
+static bool parse_includes(DBusMessageIter *iter,
+					struct btd_adv_client *client)
+{
+	DBusMessageIter entries;
 
-	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_BOOLEAN)
+	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_ARRAY)
 		return false;
 
-	dbus_message_iter_get_basic(&iter, &b);
+	dbus_message_iter_recurse(iter, &entries);
+
+	while (dbus_message_iter_get_arg_type(&entries) == DBUS_TYPE_STRING) {
+		const char *str;
+		struct adv_include *inc;
+
+		dbus_message_iter_get_basic(&entries, &str);
+
+		for (inc = includes; inc && inc->name; inc++) {
+			if (strcmp(str, inc->name))
+				continue;
+
+			if (!(client->manager->supported_flags & inc->flag))
+				continue;
+
+			DBG("Including Feature: %s", str);
+
+			client->flags |= inc->flag;
+		}
 
-	*included = b;
+		dbus_message_iter_next(&entries);
+	}
 
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
+	{ "Includes", parse_includes },
+	{ },
+};
+
 static void add_client_complete(struct btd_adv_client *client, uint8_t status)
 {
 	DBusMessage *reply;
@@ -517,8 +545,7 @@ static DBusMessage *refresh_advertisement(struct btd_adv_client *client)
 	if (client->type == AD_TYPE_PERIPHERAL)
 		flags = MGMT_ADV_FLAG_CONNECTABLE | MGMT_ADV_FLAG_DISCOV;
 
-	if (client->include_tx_power)
-		flags |= MGMT_ADV_FLAG_TX_POWER;
+	flags |= client->flags;
 
 	adv_data = bt_ad_generate(client->data, &adv_data_len);
 
@@ -566,34 +593,19 @@ static DBusMessage *refresh_advertisement(struct btd_adv_client *client)
 
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
-
-	if (!parse_solicit_uuids(client->proxy, client->data)) {
-		error("Property \"SolicitUUIDs\" failed to parse");
-		goto fail;
-	}
-
-	if (!parse_manufacturer_data(client->proxy, client->data)) {
-		error("Property \"ManufacturerData\" failed to parse");
-		goto fail;
-	}
+	for (parser = parsers; parser && parser->name; parser++) {
+		DBusMessageIter iter;
 
-	if (!parse_service_data(client->proxy, client->data)) {
-		error("Property \"ServiceData\" failed to parse");
-		goto fail;
-	}
+		if (!g_dbus_proxy_get_property(client->proxy, parser->name,
+								&iter))
+			continue;
 
-	if (!parse_include_tx_power(client->proxy, &client->include_tx_power)) {
-		error("Property \"IncludeTxPower\" failed to parse");
-		goto fail;
+		if (!parser->func(&iter, client)) {
+			error("Error parsing %s property", parser->name);
+			goto fail;
+		}
 	}
 
 	return refresh_advertisement(client);
@@ -774,16 +786,6 @@ static gboolean get_active_instances(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
-static struct adv_include {
-	uint8_t flag;
-	const char *name;
-} includes[] = {
-	{ MGMT_ADV_FLAG_TX_POWER, "tx-power" },
-	{ MGMT_ADV_FLAG_APPEARANCE, "appearance" },
-	{ MGMT_ADV_FLAG_LOCAL_NAME, "local-name" },
-	{ },
-};
-
 static void append_include(struct btd_adv_manager *manager,
 						DBusMessageIter *iter)
 {
-- 
2.13.4

