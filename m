Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v7 9/9] advertising: Consolidate Include* into a single property
Date: Mon,  7 Aug 2017 16:28:20 +0300
Message-Id: <20170807132820.20334-9-luiz.dentz@gmail.com>
In-Reply-To: <20170807132820.20334-1-luiz.dentz@gmail.com>
References: <20170807132820.20334-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes it easier to add new features and makes the code a lot
cleaner as well.

Note: Advertising related APIs are still experimental so it still possible
to make changes like this.
---
 client/advertising.c    | 52 +++++++++++-------------------
 doc/advertising-api.txt | 19 +++--------
 src/advertising.c       | 86 ++++++++++++++++++-------------------------------
 3 files changed, 55 insertions(+), 102 deletions(-)

diff --git a/client/advertising.c b/client/advertising.c
index a90127b9c..35e582afc 100644
--- a/client/advertising.c
+++ b/client/advertising.c
@@ -254,49 +254,38 @@ static gboolean get_manufacturer_data(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
-static gboolean tx_power_exists(const GDBusPropertyTable *property, void *data)
+static gboolean includes_exists(const GDBusPropertyTable *property, void *data)
 {
-	return ad.tx_power;
+	return ad.tx_power || ad.name || ad.appearance;
 }
 
-static gboolean get_tx_power(const GDBusPropertyTable *property,
+static gboolean get_includes(const GDBusPropertyTable *property,
 				DBusMessageIter *iter, void *user_data)
 {
-	dbus_bool_t b = ad.tx_power;
+	DBusMessageIter array;
 
-	dbus_message_iter_append_basic(iter, DBUS_TYPE_BOOLEAN, &b);
+	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY, "as", &array);
 
-	return TRUE;
-}
+	if (ad.tx_power) {
+		const char *str = "tx-power";
 
-static gboolean include_name_exists(const GDBusPropertyTable *property,
-							void *data)
-{
-	return ad.name;
-}
+		dbus_message_iter_append_basic(&array, DBUS_TYPE_STRING, &str);
+	}
 
-static gboolean get_include_name(const GDBusPropertyTable *property,
-				DBusMessageIter *iter, void *user_data)
-{
-	dbus_bool_t b = ad.name;
+	if (ad.name) {
+		const char *str = "local-name";
 
-	dbus_message_iter_append_basic(iter, DBUS_TYPE_BOOLEAN, &b);
+		dbus_message_iter_append_basic(&array, DBUS_TYPE_STRING, &str);
+	}
 
-	return TRUE;
-}
+	if (ad.appearance) {
+		const char *str = "appearance";
 
-static gboolean include_appearance_exists(const GDBusPropertyTable *property,
-							void *data)
-{
-	return ad.appearance;
-}
+		dbus_message_iter_append_basic(&array, DBUS_TYPE_STRING, &str);
+	}
 
-static gboolean get_include_appearance(const GDBusPropertyTable *property,
-				DBusMessageIter *iter, void *user_data)
-{
-	dbus_bool_t b = ad.appearance;
+	dbus_message_iter_close_container(iter, &array);
 
-	dbus_message_iter_append_basic(iter, DBUS_TYPE_BOOLEAN, &b);
 
 	return TRUE;
 }
@@ -307,10 +296,7 @@ static const GDBusPropertyTable ad_props[] = {
 	{ "ServiceData", "a{sv}", get_service_data, NULL, service_data_exists },
 	{ "ManufacturerData", "a{qv}", get_manufacturer_data, NULL,
 						manufacturer_data_exists },
-	{ "IncludeTxPower", "b", get_tx_power, NULL, tx_power_exists },
-	{ "IncludeName", "b", get_include_name, NULL, include_name_exists },
-	{ "IncludeAppearance", "b", get_include_appearance, NULL,
-						include_appearance_exists },
+	{ "Includes", "as", get_includes, NULL, includes_exists },
 	{ }
 };
 
diff --git a/doc/advertising-api.txt b/doc/advertising-api.txt
index 40e5f4e5c..28f96a81e 100644
--- a/doc/advertising-api.txt
+++ b/doc/advertising-api.txt
@@ -61,22 +61,13 @@ Properties	string Type
 			Service Data elements to include. The keys are the
 			UUID to associate with the data.
 
-		bool IncludeTxPower
+		array{string} Includes
 
-			Includes the Tx Power in the advertising packet.
-			If missing, the Tx Power is not included.
-
-		uint16 IncludeAppearance
-
-			Includes Appearance in the advertising packet.
-
-			Possible values: as found on Device.Appearance
-
-		bool IncludeName
-
-			Include adapter Name, or Alias if set, as scan
-			response data.
+			List of features to be included in the advertising
+			packet.
 
+			Possible values: as found on
+					LEAdvertisingManager.SupportedIncludes
 
 LE Advertising Manager hierarchy
 ================================
diff --git a/src/advertising.c b/src/advertising.c
index efc790807..940264482 100644
--- a/src/advertising.c
+++ b/src/advertising.c
@@ -63,9 +63,7 @@ struct btd_adv_client {
 	GDBusProxy *proxy;
 	DBusMessage *reg;
 	uint8_t type; /* Advertising type */
-	bool include_tx_power;
-	bool include_name;
-	bool include_appearance;
+	uint32_t flags;
 	struct bt_ad *data;
 	uint8_t instance;
 };
@@ -404,49 +402,46 @@ fail:
 	return false;
 }
 
-static bool parse_include_tx_power(DBusMessageIter *iter,
-					struct btd_adv_client *client)
-{
-	dbus_bool_t b;
-
-	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_BOOLEAN)
-		return false;
-
-	dbus_message_iter_get_basic(iter, &b);
-
-	client->include_tx_power = b;
-
-	return true;
-}
+static struct adv_include {
+	uint8_t flag;
+	const char *name;
+} includes[] = {
+	{ MGMT_ADV_FLAG_TX_POWER, "tx-power" },
+	{ MGMT_ADV_FLAG_APPEARANCE, "appearance" },
+	{ MGMT_ADV_FLAG_LOCAL_NAME, "local-name" },
+	{ },
+};
 
-static bool parse_include_name(DBusMessageIter *iter,
+static bool parse_includes(DBusMessageIter *iter,
 					struct btd_adv_client *client)
 {
-	dbus_bool_t b;
+	DBusMessageIter entries;
 
-	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_BOOLEAN)
+	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_ARRAY)
 		return false;
 
-	dbus_message_iter_get_basic(iter, &b);
+	dbus_message_iter_recurse(iter, &entries);
+
+	while (dbus_message_iter_get_arg_type(&entries) == DBUS_TYPE_STRING) {
+		const char *str;
+		struct adv_include *inc;
 
-	if (client->manager->supported_flags & MGMT_ADV_FLAG_LOCAL_NAME)
-		client->include_name = b;
+		dbus_message_iter_get_basic(&entries, &str);
 
-	return true;
-}
+		for (inc = includes; inc && inc->name; inc++) {
+			if (strcmp(str, inc->name))
+				continue;
 
-static bool parse_include_appearance(DBusMessageIter *iter,
-					struct btd_adv_client *client)
-{
-	dbus_bool_t b;
+			if (!(client->manager->supported_flags & inc->flag))
+				continue;
 
-	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_BOOLEAN)
-		return false;
+			DBG("Including Feature: %s", str);
 
-	dbus_message_iter_get_basic(iter, &b);
+			client->flags |= inc->flag;
+		}
 
-	if (client->manager->supported_flags & MGMT_ADV_FLAG_APPEARANCE)
-		client->include_appearance = b;
+		dbus_message_iter_next(&entries);
+	}
 
 	return true;
 }
@@ -460,9 +455,7 @@ static struct adv_parser {
 	{ "SolicitUUIDs", parse_solicit_uuids },
 	{ "ManufacturerData", parse_manufacturer_data },
 	{ "ServiceData", parse_service_data },
-	{ "IncludeTxPower", parse_include_tx_power },
-	{ "IncludeName", parse_include_name },
-	{ "IncludeAppearance", parse_include_appearance },
+	{ "Includes", parse_includes },
 	{ },
 };
 
@@ -552,14 +545,7 @@ static DBusMessage *refresh_advertisement(struct btd_adv_client *client)
 	if (client->type == AD_TYPE_PERIPHERAL)
 		flags = MGMT_ADV_FLAG_CONNECTABLE | MGMT_ADV_FLAG_DISCOV;
 
-	if (client->include_tx_power)
-		flags |= MGMT_ADV_FLAG_TX_POWER;
-
-	if (client->include_name)
-		flags |= MGMT_ADV_FLAG_LOCAL_NAME;
-
-	if (client->include_appearance)
-		flags |= MGMT_ADV_FLAG_APPEARANCE;
+	flags |= client->flags;
 
 	adv_data = bt_ad_generate(client->data, &adv_data_len);
 
@@ -800,16 +786,6 @@ static gboolean get_active_instances(const GDBusPropertyTable *property,
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
2.13.3

