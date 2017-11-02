Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 3/7] client: Add set-advertise-{duration, timeout}
Date: Thu,  2 Nov 2017 16:43:48 +0200
Message-Id: <20171102144352.32353-3-luiz.dentz@gmail.com>
In-Reply-To: <20171102144352.32353-1-luiz.dentz@gmail.com>
References: <20171102144352.32353-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds the following command which can be used to control the
advertisement intervals:

[bluetooth]# set-advertise-duration 4
[bluetooth]# set-advertise-timeout 4
[bluetooth]# advertise on
[CHG] Controller B8:8A:60:D8:17:D7 SupportedInstances: 0x04
[CHG] Controller B8:8A:60:D8:17:D7 ActiveInstances: 0x01
Advertising object registered
[CHG] Controller B8:8A:60:D8:17:D7 SupportedInstances: 0x05
[CHG] Controller B8:8A:60:D8:17:D7 ActiveInstances: 0x00
---
 client/advertising.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 client/advertising.h |  2 ++
 client/main.c        | 42 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 94 insertions(+)

diff --git a/client/advertising.c b/client/advertising.c
index e950aa278..56093f387 100644
--- a/client/advertising.c
+++ b/client/advertising.c
@@ -59,6 +59,8 @@ static struct ad {
 	char *type;
 	char *local_name;
 	uint16_t local_appearance;
+	uint16_t duration;
+	uint16_t timeout;
 	char **uuids;
 	size_t uuids_len;
 	struct service_data service;
@@ -323,6 +325,32 @@ static gboolean get_appearance(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
+static gboolean duration_exits(const GDBusPropertyTable *property, void *data)
+{
+	return ad.duration;
+}
+
+static gboolean get_duration(const GDBusPropertyTable *property,
+				DBusMessageIter *iter, void *user_data)
+{
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT16, &ad.duration);
+
+	return TRUE;
+}
+
+static gboolean timeout_exits(const GDBusPropertyTable *property, void *data)
+{
+	return ad.timeout;
+}
+
+static gboolean get_timeout(const GDBusPropertyTable *property,
+				DBusMessageIter *iter, void *user_data)
+{
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT16, &ad.timeout);
+
+	return TRUE;
+}
+
 static const GDBusPropertyTable ad_props[] = {
 	{ "Type", "s", get_type },
 	{ "ServiceUUIDs", "as", get_uuids, NULL, uuids_exists },
@@ -332,6 +360,8 @@ static const GDBusPropertyTable ad_props[] = {
 	{ "Includes", "as", get_includes, NULL, includes_exists },
 	{ "LocalName", "s", get_local_name, NULL, local_name_exits },
 	{ "Appearance", "q", get_appearance, NULL, appearance_exits },
+	{ "Duration", "q", get_duration, NULL, duration_exits },
+	{ "Timeout", "q", get_timeout, NULL, timeout_exits },
 	{ }
 };
 
@@ -592,3 +622,23 @@ void ad_advertise_local_appearance(DBusConnection *conn, uint16_t value)
 
 	g_dbus_emit_property_changed(conn, AD_PATH, AD_IFACE, "Appearance");
 }
+
+void ad_advertise_duration(DBusConnection *conn, uint16_t value)
+{
+	if (ad.duration == value)
+		return;
+
+	ad.duration = value;
+
+	g_dbus_emit_property_changed(conn, AD_PATH, AD_IFACE, "Duration");
+}
+
+void ad_advertise_timeout(DBusConnection *conn, uint16_t value)
+{
+	if (ad.timeout == value)
+		return;
+
+	ad.timeout = value;
+
+	g_dbus_emit_property_changed(conn, AD_PATH, AD_IFACE, "Timeout");
+}
diff --git a/client/advertising.h b/client/advertising.h
index 6868518e7..bb9aed210 100644
--- a/client/advertising.h
+++ b/client/advertising.h
@@ -32,3 +32,5 @@ void ad_advertise_name(DBusConnection *conn, bool value);
 void ad_advertise_appearance(DBusConnection *conn, bool value);
 void ad_advertise_local_name(DBusConnection *conn, const char *name);
 void ad_advertise_local_appearance(DBusConnection *conn, uint16_t value);
+void ad_advertise_duration(DBusConnection *conn, uint16_t value);
+void ad_advertise_timeout(DBusConnection *conn, uint16_t value);
diff --git a/client/main.c b/client/main.c
index 3536c9524..37a411ba9 100644
--- a/client/main.c
+++ b/client/main.c
@@ -2376,6 +2376,44 @@ static void cmd_set_advertise_appearance(const char *arg)
 	ad_advertise_local_appearance(dbus_conn, value);
 }
 
+static void cmd_set_advertise_duration(const char *arg)
+{
+	long int value;
+	char *endptr = NULL;
+
+	if (arg == NULL || strlen(arg) == 0) {
+		rl_printf("Missing value argument\n");
+		return;
+	}
+
+	value = strtol(arg, &endptr, 0);
+	if (!endptr || *endptr != '\0' || value > UINT16_MAX) {
+		rl_printf("Invalid argument\n");
+		return;
+	}
+
+	ad_advertise_duration(dbus_conn, value);
+}
+
+static void cmd_set_advertise_timeout(const char *arg)
+{
+	long int value;
+	char *endptr = NULL;
+
+	if (arg == NULL || strlen(arg) == 0) {
+		rl_printf("Missing value argument\n");
+		return;
+	}
+
+	value = strtol(arg, &endptr, 0);
+	if (!endptr || *endptr != '\0' || value > UINT16_MAX) {
+		rl_printf("Invalid argument\n");
+		return;
+	}
+
+	ad_advertise_timeout(dbus_conn, value);
+}
+
 static const struct {
 	const char *cmd;
 	const char *arg;
@@ -2428,6 +2466,10 @@ static const struct {
 			"Enable/disable local name to be advertised" },
 	{ "set-advertise-appearance", "<value>", cmd_set_advertise_appearance,
 			"Set custom appearance to be advertised" },
+	{ "set-advertise-duration", "<seconds>", cmd_set_advertise_duration,
+			"Set advertise duration" },
+	{ "set-advertise-timeout", "<seconds>", cmd_set_advertise_timeout,
+			"Set advertise timeout" },
 	{ "set-scan-filter-uuids", "[uuid1 uuid2 ...]",
 			cmd_set_scan_filter_uuids, "Set scan filter uuids" },
 	{ "set-scan-filter-rssi", "[rssi]", cmd_set_scan_filter_rssi,
-- 
2.13.6

