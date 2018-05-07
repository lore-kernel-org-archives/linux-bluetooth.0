Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/5] client: Add advertise.flags command
Date: Mon,  7 May 2018 19:14:02 +0300
Message-Id: <20180507161403.14181-4-luiz.dentz@gmail.com>
In-Reply-To: <20180507161403.14181-1-luiz.dentz@gmail.com>
References: <20180507161403.14181-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds advertise.flags command which can be used to set it own
instance:

[bluetooth]# advertise.flags 0x02
[bluetooth]# advertise on

@ MGMT Command: Add Advertising (0x003e) plen 14
        Instance: 1
        Flags: 0x00000001
          Switch into Connectable mode
        Duration: 0
        Timeout: 0
        Advertising data length: 3
        Flags: 0x02
          LE General Discoverable Mode
        Scan response length: 0
< HCI Command: LE Set Advertising Data (0x08|0x0008) plen 32
        Length: 3
        Flags: 0x02
          LE General Discoverable Mode
---
 client/advertising.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 client/advertising.h |  1 +
 client/main.c        |  7 +++++++
 3 files changed, 55 insertions(+)

diff --git a/client/advertising.c b/client/advertising.c
index 045133aa3..a0fc32eea 100644
--- a/client/advertising.c
+++ b/client/advertising.c
@@ -71,6 +71,7 @@ static struct ad {
 	struct service_data service;
 	struct manufacturer_data manufacturer;
 	struct data data;
+	uint8_t flags[1];
 	bool tx_power;
 	bool name;
 	bool appearance;
@@ -401,6 +402,26 @@ static gboolean get_data(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
+static gboolean flags_exists(const GDBusPropertyTable *property, void *data)
+{
+	return ad.flags[0];
+}
+
+static gboolean get_flags(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *user_data)
+{
+	DBusMessageIter array;
+	uint8_t *val = ad.flags;
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY, "y", &array);
+
+	dbus_message_iter_append_fixed_array(&array, DBUS_TYPE_BYTE, &val, 1);
+
+	dbus_message_iter_close_container(iter, &array);
+
+	return TRUE;
+}
+
 static const GDBusPropertyTable ad_props[] = {
 	{ "Type", "s", get_type },
 	{ "ServiceUUIDs", "as", get_uuids, NULL, uuids_exists },
@@ -408,6 +429,7 @@ static const GDBusPropertyTable ad_props[] = {
 	{ "ManufacturerData", "a{qv}", get_manufacturer_data, NULL,
 						manufacturer_data_exists },
 	{ "Data", "a{yv}", get_data, NULL, data_exists },
+	{ "Flags", "ay", get_flags, NULL, flags_exists },
 	{ "Includes", "as", get_includes, NULL, includes_exists },
 	{ "LocalName", "s", get_local_name, NULL, local_name_exits },
 	{ "Appearance", "q", get_appearance, NULL, appearance_exits },
@@ -708,6 +730,31 @@ void ad_disable_data(DBusConnection *conn)
 	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
 
+void ad_advertise_flags(DBusConnection *conn, int argc, char *argv[])
+{
+	char *endptr = NULL;
+	long int val;
+
+	if (argc < 2 || !strlen(argv[1])) {
+		if (ad.flags[0])
+			bt_shell_hexdump(ad.flags, sizeof(ad.flags));
+
+		return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+	}
+
+	val = strtol(argv[1], &endptr, 0);
+	if (!endptr || *endptr != '\0' || val > UINT8_MAX) {
+		bt_shell_printf("Invalid value\n");
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	ad.flags[0] = val;
+
+	g_dbus_emit_property_changed(conn, AD_PATH, AD_IFACE, "Flags");
+
+	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+}
+
 void ad_advertise_tx_power(DBusConnection *conn, dbus_bool_t *value)
 {
 	if (!value) {
diff --git a/client/advertising.h b/client/advertising.h
index 12b4d69c1..42e51c693 100644
--- a/client/advertising.h
+++ b/client/advertising.h
@@ -39,3 +39,4 @@ void ad_advertise_duration(DBusConnection *conn, long int *value);
 void ad_advertise_timeout(DBusConnection *conn, long int *value);
 void ad_advertise_data(DBusConnection *conn, int argc, char *argv[]);
 void ad_disable_data(DBusConnection *conn);
+void ad_advertise_flags(DBusConnection *conn, int argc, char *argv[]);
diff --git a/client/main.c b/client/main.c
index 54bd5371a..52ed159ad 100644
--- a/client/main.c
+++ b/client/main.c
@@ -2192,6 +2192,11 @@ static void cmd_advertise_data(int argc, char *argv[])
 	ad_advertise_data(dbus_conn, argc, argv);
 }
 
+static void cmd_advertise_flags(int argc, char *argv[])
+{
+	ad_advertise_flags(dbus_conn, argc, argv);
+}
+
 static void cmd_advertise_tx_power(int argc, char *argv[])
 {
 	dbus_bool_t powered;
@@ -2382,6 +2387,8 @@ static const struct bt_shell_menu advertise_menu = {
 			"Set/Get advertise manufacturer data" },
 	{ "data", "[type] [data=xx xx ...]", cmd_advertise_data,
 			"Set/Get advertise data" },
+	{ "flags", "[value]", cmd_advertise_flags,
+			"Set/Get advertise flags" },
 	{ "tx-power", "[on/off]", cmd_advertise_tx_power,
 			"Show/Enable/Disable TX power to be advertised",
 							NULL },
-- 
2.14.3

