Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 4/8] client: Add advertise.discoverable command
Date: Tue, 22 May 2018 12:50:07 +0300
Message-Id: <20180522095011.517-4-luiz.dentz@gmail.com>
In-Reply-To: <20180522095011.517-1-luiz.dentz@gmail.com>
References: <20180522095011.517-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds advertise.discoverable command which can be used to set it
own instance:

[bluetooth]# advertise.discoverable on
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
 client/advertising.c | 35 +++++++++++++++++++++++++++++++++++
 client/advertising.h |  1 +
 client/main.c        | 17 +++++++++++++++++
 3 files changed, 53 insertions(+)

diff --git a/client/advertising.c b/client/advertising.c
index 39f99467b..cb0ca4a57 100644
--- a/client/advertising.c
+++ b/client/advertising.c
@@ -71,6 +71,7 @@ static struct ad {
 	struct service_data service;
 	struct manufacturer_data manufacturer;
 	struct data data;
+	bool discoverable;
 	bool tx_power;
 	bool name;
 	bool appearance;
@@ -401,6 +402,21 @@ static gboolean get_data(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
+static gboolean discoverable_exists(const GDBusPropertyTable *property,
+							void *data)
+{
+	return ad.discoverable;
+}
+
+static gboolean get_discoverable(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *user_data)
+{
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_BOOLEAN,
+							&ad.discoverable);
+
+	return TRUE;
+}
+
 static const GDBusPropertyTable ad_props[] = {
 	{ "Type", "s", get_type },
 	{ "ServiceUUIDs", "as", get_uuids, NULL, uuids_exists },
@@ -408,6 +424,7 @@ static const GDBusPropertyTable ad_props[] = {
 	{ "ManufacturerData", "a{qv}", get_manufacturer_data, NULL,
 						manufacturer_data_exists },
 	{ "Data", "a{yv}", get_data, NULL, data_exists },
+	{ "Discoverable", "b", get_discoverable, NULL, discoverable_exists },
 	{ "Includes", "as", get_includes, NULL, includes_exists },
 	{ "LocalName", "s", get_local_name, NULL, local_name_exits },
 	{ "Appearance", "q", get_appearance, NULL, appearance_exits },
@@ -708,6 +725,24 @@ void ad_disable_data(DBusConnection *conn)
 	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
 
+void ad_advertise_discoverable(DBusConnection *conn, dbus_bool_t *value)
+{
+	if (!value) {
+		bt_shell_printf("Discoverable: %s\n",
+				ad.discoverable ? "on" : "off");
+		return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+	}
+
+	if (ad.discoverable == *value)
+		return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+
+	ad.discoverable = *value;
+
+	g_dbus_emit_property_changed(conn, AD_PATH, AD_IFACE, "Discoverable");
+
+	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+}
+
 void ad_advertise_tx_power(DBusConnection *conn, dbus_bool_t *value)
 {
 	if (!value) {
diff --git a/client/advertising.h b/client/advertising.h
index 12b4d69c1..599190866 100644
--- a/client/advertising.h
+++ b/client/advertising.h
@@ -39,3 +39,4 @@ void ad_advertise_duration(DBusConnection *conn, long int *value);
 void ad_advertise_timeout(DBusConnection *conn, long int *value);
 void ad_advertise_data(DBusConnection *conn, int argc, char *argv[]);
 void ad_disable_data(DBusConnection *conn);
+void ad_advertise_discoverable(DBusConnection *conn, dbus_bool_t *value);
diff --git a/client/main.c b/client/main.c
index 52d807946..26ce94947 100644
--- a/client/main.c
+++ b/client/main.c
@@ -2213,6 +2213,21 @@ static void cmd_advertise_data(int argc, char *argv[])
 	ad_advertise_data(dbus_conn, argc, argv);
 }
 
+static void cmd_advertise_discoverable(int argc, char *argv[])
+{
+	dbus_bool_t discoverable;
+
+	if (argc < 2) {
+		ad_advertise_discoverable(dbus_conn, NULL);
+		return;
+	}
+
+	if (!parse_argument(argc, argv, NULL, NULL, &discoverable, NULL))
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+
+	ad_advertise_discoverable(dbus_conn, &discoverable);
+}
+
 static void cmd_advertise_tx_power(int argc, char *argv[])
 {
 	dbus_bool_t powered;
@@ -2403,6 +2418,8 @@ static const struct bt_shell_menu advertise_menu = {
 			"Set/Get advertise manufacturer data" },
 	{ "data", "[type] [data=xx xx ...]", cmd_advertise_data,
 			"Set/Get advertise data" },
+	{ "discoverable", "[on/off]", cmd_advertise_discoverable,
+			"Set/Get advertise discoverable" },
 	{ "tx-power", "[on/off]", cmd_advertise_tx_power,
 			"Show/Enable/Disable TX power to be advertised",
 							NULL },
-- 
2.14.3

