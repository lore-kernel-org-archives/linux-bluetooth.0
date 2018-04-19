Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 7/7] client: Add support for setting advertising Data property
Date: Thu, 19 Apr 2018 16:46:30 +0300
Message-Id: <20180419134630.15624-7-luiz.dentz@gmail.com>
In-Reply-To: <20180419134630.15624-1-luiz.dentz@gmail.com>
References: <20180419134630.15624-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds data command to advertise menu which can be used to set
an arbitrary/profile specific advertising type and data:

[bluetooth]# data 0x26 0x01 0x01 0x00
---
 client/advertising.c | 158 +++++++++++++++++++++++++++++++++++++--------------
 client/advertising.h |   2 +
 client/main.c        |  13 +++++
 3 files changed, 130 insertions(+), 43 deletions(-)

diff --git a/client/advertising.c b/client/advertising.c
index 152a22a56..045133aa3 100644
--- a/client/advertising.c
+++ b/client/advertising.c
@@ -54,6 +54,11 @@ struct manufacturer_data {
 	struct ad_data data;
 };
 
+struct data {
+	uint8_t type;
+	struct ad_data data;
+};
+
 static struct ad {
 	bool registered;
 	char *type;
@@ -65,6 +70,7 @@ static struct ad {
 	size_t uuids_len;
 	struct service_data service;
 	struct manufacturer_data manufacturer;
+	struct data data;
 	bool tx_power;
 	bool name;
 	bool appearance;
@@ -373,12 +379,35 @@ static gboolean get_timeout(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
+static gboolean data_exists(const GDBusPropertyTable *property, void *data)
+{
+	return ad.data.type != 0;
+}
+
+static gboolean get_data(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *user_data)
+{
+	DBusMessageIter dict;
+	struct ad_data *data = &ad.data.data;
+	uint8_t *val = data->data;
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY, "{yv}", &dict);
+
+	g_dbus_dict_append_basic_array(&dict, DBUS_TYPE_BYTE, &ad.data.type,
+					DBUS_TYPE_BYTE, &val, data->len);
+
+	dbus_message_iter_close_container(iter, &dict);
+
+	return TRUE;
+}
+
 static const GDBusPropertyTable ad_props[] = {
 	{ "Type", "s", get_type },
 	{ "ServiceUUIDs", "as", get_uuids, NULL, uuids_exists },
 	{ "ServiceData", "a{sv}", get_service_data, NULL, service_data_exists },
 	{ "ManufacturerData", "a{qv}", get_manufacturer_data, NULL,
 						manufacturer_data_exists },
+	{ "Data", "a{yv}", get_data, NULL, data_exists },
 	{ "Includes", "as", get_includes, NULL, includes_exists },
 	{ "LocalName", "s", get_local_name, NULL, local_name_exits },
 	{ "Appearance", "q", get_appearance, NULL, appearance_exits },
@@ -508,46 +537,55 @@ static void ad_clear_service(void)
 	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
 
-void ad_advertise_service(DBusConnection *conn, int argc, char *argv[])
+static bool ad_add_data(struct ad_data *data, int argc, char *argv[])
 {
 	unsigned int i;
-	struct ad_data *data;
 
-	if (argc < 2 || !strlen(argv[1])) {
-		if (ad.service.uuid) {
-			print_uuid(ad.service.uuid);
-			bt_shell_hexdump(ad.service.data.data,
-						ad.service.data.len);
-		}
-		return bt_shell_noninteractive_quit(EXIT_SUCCESS);
-	}
+	memset(data, 0, sizeof(*data));
 
-	ad_clear_service();
-
-	ad.service.uuid = g_strdup(argv[1]);
-	data = &ad.service.data;
-
-	for (i = 2; i < (unsigned int) argc; i++) {
+	for (i = 0; i < (unsigned int) argc; i++) {
 		long int val;
 		char *endptr = NULL;
 
 		if (i >= G_N_ELEMENTS(data->data)) {
 			bt_shell_printf("Too much data\n");
-			ad_clear_service();
-			return;
+			return false;
 		}
 
 		val = strtol(argv[i], &endptr, 0);
 		if (!endptr || *endptr != '\0' || val > UINT8_MAX) {
 			bt_shell_printf("Invalid value at index %d\n", i);
-			ad_clear_service();
-			return;
+			return false;
 		}
 
 		data->data[data->len] = val;
 		data->len++;
 	}
 
+	return true;
+}
+
+void ad_advertise_service(DBusConnection *conn, int argc, char *argv[])
+{
+	struct ad_data data;
+
+	if (argc < 2 || !strlen(argv[1])) {
+		if (ad.service.uuid) {
+			print_uuid(ad.service.uuid);
+			bt_shell_hexdump(ad.service.data.data,
+						ad.service.data.len);
+		}
+		return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+	}
+
+	if (!ad_add_data(&data, argc - 2, argv + 2))
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+
+	ad_clear_service();
+
+	ad.service.uuid = g_strdup(argv[1]);
+	ad.service.data = data;
+
 	g_dbus_emit_property_changed(conn, AD_PATH, AD_IFACE, "ServiceData");
 
 	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
@@ -573,10 +611,9 @@ static void ad_clear_manufacturer(void)
 
 void ad_advertise_manufacturer(DBusConnection *conn, int argc, char *argv[])
 {
-	unsigned int i;
 	char *endptr = NULL;
 	long int val;
-	struct ad_data *data;
+	struct ad_data data;
 
 	if (argc < 2 || !strlen(argv[1])) {
 		if (ad.manufacturer.data.len) {
@@ -589,34 +626,18 @@ void ad_advertise_manufacturer(DBusConnection *conn, int argc, char *argv[])
 		return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 	}
 
-	ad_clear_manufacturer();
-
 	val = strtol(argv[1], &endptr, 0);
 	if (!endptr || *endptr != '\0' || val > UINT16_MAX) {
 		bt_shell_printf("Invalid manufacture id\n");
 		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 	}
 
-	ad.manufacturer.id = val;
-	data = &ad.manufacturer.data;
-
-	for (i = 2; i < (unsigned int) argc; i++) {
-		if (i >= G_N_ELEMENTS(data->data)) {
-			bt_shell_printf("Too much data\n");
-			ad_clear_manufacturer();
-			return bt_shell_noninteractive_quit(EXIT_FAILURE);
-		}
-
-		val = strtol(argv[i], &endptr, 0);
-		if (!endptr || *endptr != '\0' || val > UINT8_MAX) {
-			bt_shell_printf("Invalid value at index %d\n", i);
-			ad_clear_manufacturer();
-			return bt_shell_noninteractive_quit(EXIT_FAILURE);
-		}
+	if (!ad_add_data(&data, argc - 2, argv + 2))
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 
-		data->data[data->len] = val;
-		data->len++;
-	}
+	ad_clear_manufacturer();
+	ad.manufacturer.id = val;
+	ad.manufacturer.data = data;
 
 	g_dbus_emit_property_changed(conn, AD_PATH, AD_IFACE,
 							"ManufacturerData");
@@ -636,6 +657,57 @@ void ad_disable_manufacturer(DBusConnection *conn)
 	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
 
+static void ad_clear_data(void)
+{
+	memset(&ad.manufacturer, 0, sizeof(ad.manufacturer));
+
+	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+}
+
+void ad_advertise_data(DBusConnection *conn, int argc, char *argv[])
+{
+	char *endptr = NULL;
+	long int val;
+	struct ad_data data;
+
+	if (argc < 2 || !strlen(argv[1])) {
+		if (ad.manufacturer.data.len) {
+			bt_shell_printf("Type: 0x%02x\n", ad.data.type);
+			bt_shell_hexdump(ad.data.data.data, ad.data.data.len);
+		}
+
+		return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+	}
+
+	val = strtol(argv[1], &endptr, 0);
+	if (!endptr || *endptr != '\0' || val > UINT8_MAX) {
+		bt_shell_printf("Invalid type\n");
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	if (!ad_add_data(&data, argc - 2, argv + 2))
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+
+	ad_clear_data();
+	ad.data.type = val;
+	ad.data.data = data;
+
+	g_dbus_emit_property_changed(conn, AD_PATH, AD_IFACE, "Data");
+
+	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+}
+
+void ad_disable_data(DBusConnection *conn)
+{
+	if (!ad.data.type && !ad.data.data.len)
+		return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+
+	ad_clear_data();
+	g_dbus_emit_property_changed(conn, AD_PATH, AD_IFACE, "Data");
+
+	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+}
+
 void ad_advertise_tx_power(DBusConnection *conn, dbus_bool_t *value)
 {
 	if (!value) {
diff --git a/client/advertising.h b/client/advertising.h
index b73d33b13..12b4d69c1 100644
--- a/client/advertising.h
+++ b/client/advertising.h
@@ -37,3 +37,5 @@ void ad_advertise_local_name(DBusConnection *conn, const char *name);
 void ad_advertise_local_appearance(DBusConnection *conn, long int *value);
 void ad_advertise_duration(DBusConnection *conn, long int *value);
 void ad_advertise_timeout(DBusConnection *conn, long int *value);
+void ad_advertise_data(DBusConnection *conn, int argc, char *argv[]);
+void ad_disable_data(DBusConnection *conn);
diff --git a/client/main.c b/client/main.c
index b96278d45..d0d7f2a8f 100644
--- a/client/main.c
+++ b/client/main.c
@@ -2185,6 +2185,11 @@ static void cmd_advertise_manufacturer(int argc, char *argv[])
 	ad_advertise_manufacturer(dbus_conn, argc, argv);
 }
 
+static void cmd_advertise_data(int argc, char *argv[])
+{
+	ad_advertise_data(dbus_conn, argc, argv);
+}
+
 static void cmd_advertise_tx_power(int argc, char *argv[])
 {
 	dbus_bool_t powered;
@@ -2302,6 +2307,11 @@ static void ad_clear_manufacturer(void)
 	ad_disable_manufacturer(dbus_conn);
 }
 
+static void ad_clear_data(void)
+{
+	ad_disable_data(dbus_conn);
+}
+
 static void ad_clear_tx_power(void)
 {
 	dbus_bool_t powered = false;
@@ -2337,6 +2347,7 @@ static const struct clear_entry ad_clear[] = {
 	{ "uuids",		ad_clear_uuids },
 	{ "service",		ad_clear_service },
 	{ "manufacturer",	ad_clear_manufacturer },
+	{ "data",		ad_clear_data },
 	{ "tx-power",		ad_clear_tx_power },
 	{ "name",		ad_clear_name },
 	{ "appearance",		ad_clear_appearance },
@@ -2367,6 +2378,8 @@ static const struct bt_shell_menu advertise_menu = {
 	{ "manufacturer", "[id] [data=xx xx ...]",
 			cmd_advertise_manufacturer,
 			"Set/Get advertise manufacturer data" },
+	{ "data", "[type] [data=xx xx ...]", cmd_advertise_data,
+			"Set/Get advertise data" },
 	{ "tx-power", "[on/off]", cmd_advertise_tx_power,
 			"Show/Enable/Disable TX power to be advertised",
 							NULL },
-- 
2.14.3

