Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 8/8] client: Add advertise.discoverable-timeout command
Date: Tue, 22 May 2018 12:50:11 +0300
Message-Id: <20180522095011.517-8-luiz.dentz@gmail.com>
In-Reply-To: <20180522095011.517-1-luiz.dentz@gmail.com>
References: <20180522095011.517-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds advertise.discoverable-timeout command which can be used to
limit the amount of time the advertisement is discoverable:

[bluetooth]# advertise.discoverable on
[bluetooth]# advertise.discoverable-timeout 10
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
@ MGMT Event: Advertising Added (0x0023) plen 1
        Instance: 1
@ MGMT Event: Command Complete (0x0001) plen 4
      Add Advertising (0x003e) plen 1
        Status: Success (0x00)
        Instance: 1
@ MGMT Command: Add Advertising (0x003e) plen 14
        Instance: 1
        Flags: 0x00000001
          Switch into Connectable mode
        Duration: 0
        Timeout: 0
        Advertising data length: 3
        Flags: 0x00
        Scan response length: 0
---
 client/advertising.c | 38 ++++++++++++++++++++++++++++++++++++++
 client/advertising.h |  1 +
 client/main.c        | 22 ++++++++++++++++++++++
 3 files changed, 61 insertions(+)

diff --git a/client/advertising.c b/client/advertising.c
index 8abf4785b..73f2f3df8 100644
--- a/client/advertising.c
+++ b/client/advertising.c
@@ -66,6 +66,7 @@ static struct ad {
 	uint16_t local_appearance;
 	uint16_t duration;
 	uint16_t timeout;
+	uint16_t discoverable_to;
 	char **uuids;
 	size_t uuids_len;
 	struct service_data service;
@@ -424,6 +425,21 @@ static gboolean get_discoverable(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
+static gboolean discoverable_timeout_exits(const GDBusPropertyTable *property,
+							void *data)
+{
+	return ad.discoverable_to;
+}
+
+static gboolean get_discoverable_timeout(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *user_data)
+{
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT16,
+							&ad.discoverable_to);
+
+	return TRUE;
+}
+
 static const GDBusPropertyTable ad_props[] = {
 	{ "Type", "s", get_type },
 	{ "ServiceUUIDs", "as", get_uuids, NULL, uuids_exists },
@@ -432,6 +448,8 @@ static const GDBusPropertyTable ad_props[] = {
 						manufacturer_data_exists },
 	{ "Data", "a{yv}", get_data, NULL, data_exists },
 	{ "Discoverable", "b", get_discoverable, NULL, discoverable_exists },
+	{ "DiscoverableTimeout", "q", get_discoverable_timeout, NULL,
+						discoverable_timeout_exits },
 	{ "Includes", "as", get_includes, NULL, includes_exists },
 	{ "LocalName", "s", get_local_name, NULL, local_name_exits },
 	{ "Appearance", "q", get_appearance, NULL, appearance_exits },
@@ -750,6 +768,26 @@ void ad_advertise_discoverable(DBusConnection *conn, dbus_bool_t *value)
 	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
 
+void ad_advertise_discoverable_timeout(DBusConnection *conn, long int *value)
+{
+	if (!value) {
+		if (ad.discoverable_to)
+			bt_shell_printf("Timeout: %u sec\n",
+					ad.discoverable_to);
+		return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+	}
+
+	if (ad.discoverable_to == *value)
+		return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+
+	ad.discoverable_to = *value;
+
+	g_dbus_emit_property_changed(conn, AD_PATH, AD_IFACE,
+					"DiscoverableTimeout");
+
+	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+}
+
 void ad_advertise_tx_power(DBusConnection *conn, dbus_bool_t *value)
 {
 	if (!value) {
diff --git a/client/advertising.h b/client/advertising.h
index 599190866..fe3a7c8c6 100644
--- a/client/advertising.h
+++ b/client/advertising.h
@@ -40,3 +40,4 @@ void ad_advertise_timeout(DBusConnection *conn, long int *value);
 void ad_advertise_data(DBusConnection *conn, int argc, char *argv[]);
 void ad_disable_data(DBusConnection *conn);
 void ad_advertise_discoverable(DBusConnection *conn, dbus_bool_t *value);
+void ad_advertise_discoverable_timeout(DBusConnection *conn, long int *value);
diff --git a/client/main.c b/client/main.c
index 26ce94947..180f841ae 100644
--- a/client/main.c
+++ b/client/main.c
@@ -2228,6 +2228,25 @@ static void cmd_advertise_discoverable(int argc, char *argv[])
 	ad_advertise_discoverable(dbus_conn, &discoverable);
 }
 
+static void cmd_advertise_discoverable_timeout(int argc, char *argv[])
+{
+	long int value;
+	char *endptr = NULL;
+
+	if (argc < 2) {
+		ad_advertise_discoverable_timeout(dbus_conn, NULL);
+		return;
+	}
+
+	value = strtol(argv[1], &endptr, 0);
+	if (!endptr || *endptr != '\0' || value > UINT16_MAX) {
+		bt_shell_printf("Invalid argument\n");
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	ad_advertise_discoverable_timeout(dbus_conn, &value);
+}
+
 static void cmd_advertise_tx_power(int argc, char *argv[])
 {
 	dbus_bool_t powered;
@@ -2420,6 +2439,9 @@ static const struct bt_shell_menu advertise_menu = {
 			"Set/Get advertise data" },
 	{ "discoverable", "[on/off]", cmd_advertise_discoverable,
 			"Set/Get advertise discoverable" },
+	{ "discoverable-timeout", "[seconds]",
+			cmd_advertise_discoverable_timeout,
+			"Set/Get advertise discoverable timeout" },
 	{ "tx-power", "[on/off]", cmd_advertise_tx_power,
 			"Show/Enable/Disable TX power to be advertised",
 							NULL },
-- 
2.14.3

