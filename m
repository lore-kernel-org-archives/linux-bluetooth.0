Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v5 6/7] client: Add set-advertise-name command
Date: Fri,  4 Aug 2017 16:22:44 +0300
Message-Id: <20170804132245.30824-6-luiz.dentz@gmail.com>
In-Reply-To: <20170804132245.30824-1-luiz.dentz@gmail.com>
References: <20170804132245.30824-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds set-advertise-name which enables the use of adapter
name/alias in the scan response:

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
---
 client/advertising.c | 163 ++++++++++++++++++++++++++++++++-------------------
 client/advertising.h |   5 +-
 client/main.c        |  30 ++++++++--
 3 files changed, 131 insertions(+), 67 deletions(-)

diff --git a/client/advertising.c b/client/advertising.c
index 67e87c7ca..a90127b9c 100644
--- a/client/advertising.c
+++ b/client/advertising.c
@@ -28,6 +28,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <stdint.h>
+#include <stdbool.h>
 #include <readline/readline.h>
 #include <wordexp.h>
 
@@ -38,22 +39,36 @@
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
-static gboolean ad_name = FALSE;
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
@@ -95,7 +110,7 @@ static void register_reply(DBusMessage *message, void *user_data)
 	dbus_error_init(&error);
 
 	if (dbus_set_error_from_message(&error, message) == FALSE) {
-		registered = TRUE;
+		ad.registered = true;
 		rl_printf("Advertising object registered\n");
 	} else {
 		rl_printf("Failed to register advertisement: %s\n", error.name);
@@ -112,8 +127,8 @@ static gboolean get_type(const GDBusPropertyTable *property,
 {
 	const char *type = "peripheral";
 
-	if (!ad_type || strlen(ad_type) > 0)
-		type = ad_type;
+	if (!ad.type || strlen(ad.type) > 0)
+		type = ad.type;
 
 	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &type);
 
@@ -122,7 +137,7 @@ static gboolean get_type(const GDBusPropertyTable *property,
 
 static gboolean uuids_exists(const GDBusPropertyTable *property, void *data)
 {
-	return ad_uuids_len != 0;
+	return ad.uuids_len != 0;
 }
 
 static gboolean get_uuids(const GDBusPropertyTable *property,
@@ -133,9 +148,9 @@ static gboolean get_uuids(const GDBusPropertyTable *property,
 
 	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY, "as", &array);
 
-	for (i = 0; i < ad_uuids_len; i++)
+	for (i = 0; i < ad.uuids_len; i++)
 		dbus_message_iter_append_basic(&array, DBUS_TYPE_STRING,
-							&ad_uuids[i]);
+							&ad.uuids[i]);
 
 	dbus_message_iter_close_container(iter, &array);
 
@@ -198,19 +213,19 @@ static void dict_append_array(DBusMessageIter *dict, const char *key, int type,
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
 
@@ -220,20 +235,19 @@ static gboolean get_service_data(const GDBusPropertyTable *property,
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
 
@@ -242,13 +256,15 @@ static gboolean get_manufacturer_data(const GDBusPropertyTable *property,
 
 static gboolean tx_power_exists(const GDBusPropertyTable *property, void *data)
 {
-	return ad_tx_power;
+	return ad.tx_power;
 }
 
 static gboolean get_tx_power(const GDBusPropertyTable *property,
 				DBusMessageIter *iter, void *user_data)
 {
-	dbus_message_iter_append_basic(iter, DBUS_TYPE_BOOLEAN, &ad_tx_power);
+	dbus_bool_t b = ad.tx_power;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_BOOLEAN, &b);
 
 	return TRUE;
 }
@@ -256,13 +272,31 @@ static gboolean get_tx_power(const GDBusPropertyTable *property,
 static gboolean include_name_exists(const GDBusPropertyTable *property,
 							void *data)
 {
-	return ad_name;
+	return ad.name;
 }
 
 static gboolean get_include_name(const GDBusPropertyTable *property,
 				DBusMessageIter *iter, void *user_data)
 {
-	dbus_message_iter_append_basic(iter, DBUS_TYPE_BOOLEAN, &ad_name);
+	dbus_bool_t b = ad.name;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_BOOLEAN, &b);
+
+	return TRUE;
+}
+
+static gboolean include_appearance_exists(const GDBusPropertyTable *property,
+							void *data)
+{
+	return ad.appearance;
+}
+
+static gboolean get_include_appearance(const GDBusPropertyTable *property,
+				DBusMessageIter *iter, void *user_data)
+{
+	dbus_bool_t b = ad.appearance;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_BOOLEAN, &b);
 
 	return TRUE;
 }
@@ -275,17 +309,19 @@ static const GDBusPropertyTable ad_props[] = {
 						manufacturer_data_exists },
 	{ "IncludeTxPower", "b", get_tx_power, NULL, tx_power_exists },
 	{ "IncludeName", "b", get_include_name, NULL, include_name_exists },
+	{ "IncludeAppearance", "b", get_include_appearance, NULL,
+						include_appearance_exists },
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
@@ -316,7 +352,7 @@ static void unregister_reply(DBusMessage *message, void *user_data)
 	dbus_error_init(&error);
 
 	if (dbus_set_error_from_message(&error, message) == FALSE) {
-		registered = FALSE;
+		ad.registered = false;
 		rl_printf("Advertising object unregistered\n");
 		if (g_dbus_unregister_interface(conn, AD_PATH,
 							AD_IFACE) == FALSE)
@@ -333,7 +369,7 @@ void ad_unregister(DBusConnection *conn, GDBusProxy *manager)
 	if (!manager)
 		ad_release(conn);
 
-	if (!registered)
+	if (!ad.registered)
 		return;
 
 	if (g_dbus_proxy_method_call(manager, "UnregisterAdvertisement",
@@ -346,34 +382,33 @@ void ad_unregister(DBusConnection *conn, GDBusProxy *manager)
 
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
@@ -385,13 +420,14 @@ void ad_advertise_service(const char *arg)
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
@@ -403,8 +439,8 @@ void ad_advertise_service(const char *arg)
 			goto done;
 		}
 
-		ad_service_data[ad_service_data_len] = val;
-		ad_service_data_len++;
+		data->data[data->len] = val;
+		data->len++;
 	}
 
 done:
@@ -413,9 +449,7 @@ done:
 
 static void ad_clear_manufacturer(void)
 {
-	ad_manufacturer_id = 0;
-	memset(ad_manufacturer_data, 0, sizeof(ad_manufacturer_data));
-	ad_manufacturer_data_len = 0;
+	memset(&ad.manufacturer, 0, sizeof(ad.manufacturer));
 }
 
 void ad_advertise_manufacturer(const char *arg)
@@ -424,6 +458,7 @@ void ad_advertise_manufacturer(const char *arg)
 	unsigned int i;
 	char *endptr = NULL;
 	long int val;
+	struct ad_data *data;
 
 	if (wordexp(arg, &w, WRDE_NOCMD)) {
 		rl_printf("Invalid argument\n");
@@ -441,10 +476,11 @@ void ad_advertise_manufacturer(const char *arg)
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
@@ -456,8 +492,8 @@ void ad_advertise_manufacturer(const char *arg)
 			goto done;
 		}
 
-		ad_manufacturer_data[ad_manufacturer_data_len] = val;
-		ad_manufacturer_data_len++;
+		data->data[data->len] = val;
+		data->len++;
 	}
 
 done:
@@ -465,12 +501,17 @@ done:
 }
 
 
-void ad_advertise_tx_power(gboolean value)
+void ad_advertise_tx_power(bool value)
+{
+	ad.tx_power = value;
+}
+
+void ad_advertise_name(bool value)
 {
-	ad_tx_power = value;
+	ad.name = value;
 }
 
-void ad_advertise_name(gboolean value)
+void ad_advertise_appearance(bool value)
 {
-	ad_name = value;
+	ad.appearance = value;
 }
diff --git a/client/advertising.h b/client/advertising.h
index a41a2742d..77fc1cca5 100644
--- a/client/advertising.h
+++ b/client/advertising.h
@@ -27,5 +27,6 @@ void ad_unregister(DBusConnection *conn, GDBusProxy *manager);
 void ad_advertise_uuids(const char *arg);
 void ad_advertise_service(const char *arg);
 void ad_advertise_manufacturer(const char *arg);
-void ad_advertise_tx_power(gboolean value);
-void ad_advertise_name(gboolean value);
+void ad_advertise_tx_power(bool value);
+void ad_advertise_name(bool value);
+void ad_advertise_appearance(bool value);
diff --git a/client/main.c b/client/main.c
index 44de8c0a0..0bc2a8896 100644
--- a/client/main.c
+++ b/client/main.c
@@ -2350,12 +2350,12 @@ static void cmd_set_advertise_tx_power(const char *arg)
 	}
 
 	if (strcmp(arg, "on") == 0 || strcmp(arg, "yes") == 0) {
-		ad_advertise_tx_power(TRUE);
+		ad_advertise_tx_power(true);
 		return;
 	}
 
 	if (strcmp(arg, "off") == 0 || strcmp(arg, "no") == 0) {
-		ad_advertise_tx_power(FALSE);
+		ad_advertise_tx_power(false);
 		return;
 	}
 
@@ -2370,12 +2370,32 @@ static void cmd_set_advertise_name(const char *arg)
 	}
 
 	if (strcmp(arg, "on") == 0 || strcmp(arg, "yes") == 0) {
-		ad_advertise_name(TRUE);
+		ad_advertise_name(true);
 		return;
 	}
 
 	if (strcmp(arg, "off") == 0 || strcmp(arg, "no") == 0) {
-		ad_advertise_name(FALSE);
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
 
@@ -2428,6 +2448,8 @@ static const struct {
 			"Enable/disable TX power to be advertised" },
 	{ "set-advertise-name", "<on/off>", cmd_set_advertise_name,
 			"Enable/disable local name to be advertised" },
+	{ "set-advertise-appearance", "<value>", cmd_set_advertise_appearance,
+			"Set custom appearance to be advertised" },
 	{ "set-scan-filter-uuids", "[uuid1 uuid2 ...]",
 			cmd_set_scan_filter_uuids, "Set scan filter uuids" },
 	{ "set-scan-filter-rssi", "[rssi]", cmd_set_scan_filter_rssi,
-- 
2.13.3

