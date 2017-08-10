Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v8 06/14] client: Add set-advertise-name and set-advertise-appearance
Date: Thu, 10 Aug 2017 16:32:43 +0300
Message-Id: <20170810133251.23920-6-luiz.dentz@gmail.com>
In-Reply-To: <20170810133251.23920-1-luiz.dentz@gmail.com>
References: <20170810133251.23920-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

set-advertise-appearance enables the use of adapter's appearance in the
scan response:

[bluetooth]# set-advertise-appearance on
[bluetooth]# advertise on

    @ MGMT Command: Add Advertising (0x003e) plen 11
            Instance: 1
            Flags: 0x00000023
              Switch into Connectable mode
              Advertise as Discoverable
              Add Appearance field to Scan Response
            Duration: 0
            Timeout: 0
            Advertising data length: 0
            Scan response length: 0

set-advertise-name enables the use of adapter's name/alias in the
scan response:

[bluetooth]# set-advertise-name on
[bluetooth]# advertise on

    @ MGMT Command: Add Advertising (0x003e) plen 11
            Instance: 1
            Flags: 0x00000043
              Switch into Connectable mode
              Advertise as Discoverable
              Add Local Name in Scan Response
            Duration: 0
            Timeout: 0
            Advertising data length: 0
            Scan response length: 0
---
 client/advertising.c | 166 +++++++++++++++++++++++++++++++++------------------
 client/advertising.h |   4 +-
 client/main.c        |  48 ++++++++++++++-
 3 files changed, 156 insertions(+), 62 deletions(-)

diff --git a/client/advertising.c b/client/advertising.c
index 81fa85118..35e582afc 100644
--- a/client/advertising.c
+++ b/client/advertising.c
@@ -28,6 +28,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <stdint.h>
+#include <stdbool.h>
 #include <readline/readline.h>
 #include <wordexp.h>
 
@@ -38,21 +39,36 @@
 #define AD_PATH "/org/bluez/advertising"
 #define AD_IFACE "org.bluez.LEAdvertisement1"
 
-static gboolean registered = FALSE;
-static char *ad_type = NULL;
-static char **ad_uuids = NULL;
-static size_t ad_uuids_len = 0;
-static char *ad_service_uuid = NULL;
-static uint8_t ad_service_data[25];
-static uint8_t ad_service_data_len = 0;
-static uint16_t ad_manufacturer_id;
-static uint8_t ad_manufacturer_data[25];
-static uint8_t ad_manufacturer_data_len = 0;
-static gboolean ad_tx_power = FALSE;
+struct ad_data {
+	uint8_t data[25];
+	uint8_t len;
+};
+
+struct service_data {
+	char *uuid;
+	struct ad_data data;
+};
+
+struct manufacturer_data {
+	uint16_t id;
+	struct ad_data data;
+};
+
+static struct ad {
+	bool registered;
+	char *type;
+	char **uuids;
+	size_t uuids_len;
+	struct service_data service;
+	struct manufacturer_data manufacturer;
+	bool tx_power;
+	bool name;
+	bool appearance;
+} ad;
 
 static void ad_release(DBusConnection *conn)
 {
-	registered = FALSE;
+	ad.registered = false;
 
 	g_dbus_unregister_interface(conn, AD_PATH, AD_IFACE);
 }
@@ -94,7 +110,7 @@ static void register_reply(DBusMessage *message, void *user_data)
 	dbus_error_init(&error);
 
 	if (dbus_set_error_from_message(&error, message) == FALSE) {
-		registered = TRUE;
+		ad.registered = true;
 		rl_printf("Advertising object registered\n");
 	} else {
 		rl_printf("Failed to register advertisement: %s\n", error.name);
@@ -111,8 +127,8 @@ static gboolean get_type(const GDBusPropertyTable *property,
 {
 	const char *type = "peripheral";
 
-	if (!ad_type || strlen(ad_type) > 0)
-		type = ad_type;
+	if (!ad.type || strlen(ad.type) > 0)
+		type = ad.type;
 
 	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &type);
 
@@ -121,7 +137,7 @@ static gboolean get_type(const GDBusPropertyTable *property,
 
 static gboolean uuids_exists(const GDBusPropertyTable *property, void *data)
 {
-	return ad_uuids_len != 0;
+	return ad.uuids_len != 0;
 }
 
 static gboolean get_uuids(const GDBusPropertyTable *property,
@@ -132,9 +148,9 @@ static gboolean get_uuids(const GDBusPropertyTable *property,
 
 	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY, "as", &array);
 
-	for (i = 0; i < ad_uuids_len; i++)
+	for (i = 0; i < ad.uuids_len; i++)
 		dbus_message_iter_append_basic(&array, DBUS_TYPE_STRING,
-							&ad_uuids[i]);
+							&ad.uuids[i]);
 
 	dbus_message_iter_close_container(iter, &array);
 
@@ -197,19 +213,19 @@ static void dict_append_array(DBusMessageIter *dict, const char *key, int type,
 static gboolean service_data_exists(const GDBusPropertyTable *property,
 								void *data)
 {
-	return ad_service_uuid != NULL;
+	return ad.service.uuid != NULL;
 }
 
 static gboolean get_service_data(const GDBusPropertyTable *property,
 				DBusMessageIter *iter, void *user_data)
 {
 	DBusMessageIter dict;
-	const uint8_t *data = ad_service_data;
+	struct ad_data *data = &ad.service.data;
 
 	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY, "{sv}", &dict);
 
-	dict_append_array(&dict, ad_service_uuid, DBUS_TYPE_BYTE, &data,
-							ad_service_data_len);
+	dict_append_array(&dict, ad.service.uuid, DBUS_TYPE_BYTE, &data->data,
+								data->len);
 
 	dbus_message_iter_close_container(iter, &dict);
 
@@ -219,35 +235,57 @@ static gboolean get_service_data(const GDBusPropertyTable *property,
 static gboolean manufacturer_data_exists(const GDBusPropertyTable *property,
 								void *data)
 {
-	return ad_manufacturer_id != 0;
+	return ad.manufacturer.id != 0;
 }
 
 static gboolean get_manufacturer_data(const GDBusPropertyTable *property,
 					DBusMessageIter *iter, void *user_data)
 {
 	DBusMessageIter dict;
-	const uint8_t *data = ad_manufacturer_data;
+	struct ad_data *data = &ad.manufacturer.data;
 
 	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY, "{qv}", &dict);
 
-	dict_append_basic_array(&dict, DBUS_TYPE_UINT16, &ad_manufacturer_id,
-					DBUS_TYPE_BYTE, &data,
-					ad_manufacturer_data_len);
+	dict_append_basic_array(&dict, DBUS_TYPE_UINT16, &ad.manufacturer.id,
+					DBUS_TYPE_BYTE, &data->data, data->len);
 
 	dbus_message_iter_close_container(iter, &dict);
 
 	return TRUE;
 }
 
-static gboolean tx_power_exists(const GDBusPropertyTable *property, void *data)
+static gboolean includes_exists(const GDBusPropertyTable *property, void *data)
 {
-	return ad_tx_power;
+	return ad.tx_power || ad.name || ad.appearance;
 }
 
-static gboolean get_tx_power(const GDBusPropertyTable *property,
+static gboolean get_includes(const GDBusPropertyTable *property,
 				DBusMessageIter *iter, void *user_data)
 {
-	dbus_message_iter_append_basic(iter, DBUS_TYPE_BOOLEAN, &ad_tx_power);
+	DBusMessageIter array;
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY, "as", &array);
+
+	if (ad.tx_power) {
+		const char *str = "tx-power";
+
+		dbus_message_iter_append_basic(&array, DBUS_TYPE_STRING, &str);
+	}
+
+	if (ad.name) {
+		const char *str = "local-name";
+
+		dbus_message_iter_append_basic(&array, DBUS_TYPE_STRING, &str);
+	}
+
+	if (ad.appearance) {
+		const char *str = "appearance";
+
+		dbus_message_iter_append_basic(&array, DBUS_TYPE_STRING, &str);
+	}
+
+	dbus_message_iter_close_container(iter, &array);
+
 
 	return TRUE;
 }
@@ -258,18 +296,18 @@ static const GDBusPropertyTable ad_props[] = {
 	{ "ServiceData", "a{sv}", get_service_data, NULL, service_data_exists },
 	{ "ManufacturerData", "a{qv}", get_manufacturer_data, NULL,
 						manufacturer_data_exists },
-	{ "IncludeTxPower", "b", get_tx_power, NULL, tx_power_exists },
+	{ "Includes", "as", get_includes, NULL, includes_exists },
 	{ }
 };
 
 void ad_register(DBusConnection *conn, GDBusProxy *manager, const char *type)
 {
-	if (registered == TRUE) {
+	if (ad.registered) {
 		rl_printf("Advertisement is already registered\n");
 		return;
 	}
 
-	ad_type = g_strdup(type);
+	ad.type = g_strdup(type);
 
 	if (g_dbus_register_interface(conn, AD_PATH, AD_IFACE, ad_methods,
 					NULL, ad_props, NULL, NULL) == FALSE) {
@@ -300,7 +338,7 @@ static void unregister_reply(DBusMessage *message, void *user_data)
 	dbus_error_init(&error);
 
 	if (dbus_set_error_from_message(&error, message) == FALSE) {
-		registered = FALSE;
+		ad.registered = false;
 		rl_printf("Advertising object unregistered\n");
 		if (g_dbus_unregister_interface(conn, AD_PATH,
 							AD_IFACE) == FALSE)
@@ -317,7 +355,7 @@ void ad_unregister(DBusConnection *conn, GDBusProxy *manager)
 	if (!manager)
 		ad_release(conn);
 
-	if (!registered)
+	if (!ad.registered)
 		return;
 
 	if (g_dbus_proxy_method_call(manager, "UnregisterAdvertisement",
@@ -330,34 +368,33 @@ void ad_unregister(DBusConnection *conn, GDBusProxy *manager)
 
 void ad_advertise_uuids(const char *arg)
 {
-	g_strfreev(ad_uuids);
-	ad_uuids = NULL;
-	ad_uuids_len = 0;
+	g_strfreev(ad.uuids);
+	ad.uuids = NULL;
+	ad.uuids_len = 0;
 
 	if (!arg || !strlen(arg))
 		return;
 
-	ad_uuids = g_strsplit(arg, " ", -1);
-	if (!ad_uuids) {
+	ad.uuids = g_strsplit(arg, " ", -1);
+	if (!ad.uuids) {
 		rl_printf("Failed to parse input\n");
 		return;
 	}
 
-	ad_uuids_len = g_strv_length(ad_uuids);
+	ad.uuids_len = g_strv_length(ad.uuids);
 }
 
 static void ad_clear_service(void)
 {
-	g_free(ad_service_uuid);
-	ad_service_uuid = NULL;
-	memset(ad_service_data, 0, sizeof(ad_service_data));
-	ad_service_data_len = 0;
+	g_free(ad.service.uuid);
+	memset(&ad.service, 0, sizeof(ad.service));
 }
 
 void ad_advertise_service(const char *arg)
 {
 	wordexp_t w;
 	unsigned int i;
+	struct ad_data *data;
 
 	if (wordexp(arg, &w, WRDE_NOCMD)) {
 		rl_printf("Invalid argument\n");
@@ -369,13 +406,14 @@ void ad_advertise_service(const char *arg)
 	if (w.we_wordc == 0)
 		goto done;
 
-	ad_service_uuid = g_strdup(w.we_wordv[0]);
+	ad.service.uuid = g_strdup(w.we_wordv[0]);
+	data = &ad.service.data;
 
 	for (i = 1; i < w.we_wordc; i++) {
 		long int val;
 		char *endptr = NULL;
 
-		if (i >= G_N_ELEMENTS(ad_service_data)) {
+		if (i >= G_N_ELEMENTS(data->data)) {
 			rl_printf("Too much data\n");
 			goto done;
 		}
@@ -387,8 +425,8 @@ void ad_advertise_service(const char *arg)
 			goto done;
 		}
 
-		ad_service_data[ad_service_data_len] = val;
-		ad_service_data_len++;
+		data->data[data->len] = val;
+		data->len++;
 	}
 
 done:
@@ -397,9 +435,7 @@ done:
 
 static void ad_clear_manufacturer(void)
 {
-	ad_manufacturer_id = 0;
-	memset(ad_manufacturer_data, 0, sizeof(ad_manufacturer_data));
-	ad_manufacturer_data_len = 0;
+	memset(&ad.manufacturer, 0, sizeof(ad.manufacturer));
 }
 
 void ad_advertise_manufacturer(const char *arg)
@@ -408,6 +444,7 @@ void ad_advertise_manufacturer(const char *arg)
 	unsigned int i;
 	char *endptr = NULL;
 	long int val;
+	struct ad_data *data;
 
 	if (wordexp(arg, &w, WRDE_NOCMD)) {
 		rl_printf("Invalid argument\n");
@@ -425,10 +462,11 @@ void ad_advertise_manufacturer(const char *arg)
 		goto done;
 	}
 
-	ad_manufacturer_id = val;
+	ad.manufacturer.id = val;
+	data = &ad.manufacturer.data;
 
 	for (i = 1; i < w.we_wordc; i++) {
-		if (i >= G_N_ELEMENTS(ad_service_data)) {
+		if (i >= G_N_ELEMENTS(data->data)) {
 			rl_printf("Too much data\n");
 			goto done;
 		}
@@ -440,8 +478,8 @@ void ad_advertise_manufacturer(const char *arg)
 			goto done;
 		}
 
-		ad_manufacturer_data[ad_manufacturer_data_len] = val;
-		ad_manufacturer_data_len++;
+		data->data[data->len] = val;
+		data->len++;
 	}
 
 done:
@@ -449,7 +487,17 @@ done:
 }
 
 
-void ad_advertise_tx_power(gboolean value)
+void ad_advertise_tx_power(bool value)
+{
+	ad.tx_power = value;
+}
+
+void ad_advertise_name(bool value)
+{
+	ad.name = value;
+}
+
+void ad_advertise_appearance(bool value)
 {
-	ad_tx_power = value;
+	ad.appearance = value;
 }
diff --git a/client/advertising.h b/client/advertising.h
index 86384656c..77fc1cca5 100644
--- a/client/advertising.h
+++ b/client/advertising.h
@@ -27,4 +27,6 @@ void ad_unregister(DBusConnection *conn, GDBusProxy *manager);
 void ad_advertise_uuids(const char *arg);
 void ad_advertise_service(const char *arg);
 void ad_advertise_manufacturer(const char *arg);
-void ad_advertise_tx_power(gboolean value);
+void ad_advertise_tx_power(bool value);
+void ad_advertise_name(bool value);
+void ad_advertise_appearance(bool value);
diff --git a/client/main.c b/client/main.c
index 17de7f81f..0bc2a8896 100644
--- a/client/main.c
+++ b/client/main.c
@@ -2350,12 +2350,52 @@ static void cmd_set_advertise_tx_power(const char *arg)
 	}
 
 	if (strcmp(arg, "on") == 0 || strcmp(arg, "yes") == 0) {
-		ad_advertise_tx_power(TRUE);
+		ad_advertise_tx_power(true);
 		return;
 	}
 
 	if (strcmp(arg, "off") == 0 || strcmp(arg, "no") == 0) {
-		ad_advertise_tx_power(FALSE);
+		ad_advertise_tx_power(false);
+		return;
+	}
+
+	rl_printf("Invalid argument\n");
+}
+
+static void cmd_set_advertise_name(const char *arg)
+{
+	if (arg == NULL || strlen(arg) == 0) {
+		rl_printf("Missing on/off argument\n");
+		return;
+	}
+
+	if (strcmp(arg, "on") == 0 || strcmp(arg, "yes") == 0) {
+		ad_advertise_name(true);
+		return;
+	}
+
+	if (strcmp(arg, "off") == 0 || strcmp(arg, "no") == 0) {
+		ad_advertise_name(false);
+		return;
+	}
+
+	rl_printf("Invalid argument\n");
+}
+
+static void cmd_set_advertise_appearance(const char *arg)
+{
+	if (arg == NULL || strlen(arg) == 0) {
+		rl_printf("Missing value argument\n");
+		return;
+	}
+
+	if (strcmp(arg, "on") == 0 || strcmp(arg, "yes") == 0) {
+		ad_advertise_appearance(true);
+		return;
+	}
+
+	if (strcmp(arg, "off") == 0 || strcmp(arg, "no") == 0) {
+		ad_advertise_appearance(false);
 		return;
 	}
 
@@ -2406,6 +2446,10 @@ static const struct {
 	{ "set-advertise-tx-power", "<on/off>",
 			cmd_set_advertise_tx_power,
 			"Enable/disable TX power to be advertised" },
+	{ "set-advertise-name", "<on/off>", cmd_set_advertise_name,
+			"Enable/disable local name to be advertised" },
+	{ "set-advertise-appearance", "<value>", cmd_set_advertise_appearance,
+			"Set custom appearance to be advertised" },
 	{ "set-scan-filter-uuids", "[uuid1 uuid2 ...]",
 			cmd_set_scan_filter_uuids, "Set scan filter uuids" },
 	{ "set-scan-filter-rssi", "[rssi]", cmd_set_scan_filter_rssi,
-- 
2.13.4

