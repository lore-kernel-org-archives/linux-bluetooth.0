Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/7] client: Add set-advertise-uuids command
Date: Thu, 11 Aug 2016 15:14:49 +0300
Message-Id: <1470917692-8878-5-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1470917692-8878-1-git-send-email-luiz.dentz@gmail.com>
References: <1470917692-8878-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds set-advertise-uuids which can be used set UUIDs to be
advertised:

set-advertise-uuids [uuid1 uuid2...]
[bluetooth]# set-advertise-uuids 180D 180F
[bluetooth]# advertise on

@ Advertising Added: 1
< HCI Command: LE Set Advertising Data (0x08|0x0008) plen 32
        Length: 9
        Flags: 0x02
          LE General Discoverable Mode
        16-bit Service UUIDs (complete): 2 entries
          Heart Rate (0x180d)
          Battery Service (0x180f)
---
 client/advertising.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 client/main.c        |  7 +++++++
 2 files changed, 50 insertions(+)

diff --git a/client/advertising.c b/client/advertising.c
index 34e3f59..e74221f 100644
--- a/client/advertising.c
+++ b/client/advertising.c
@@ -40,6 +40,8 @@
 
 static gboolean registered = FALSE;
 static char *ad_type = NULL;
+static char **ad_uuids = NULL;
+static size_t ad_uuids_len = 0;
 
 static void ad_release(DBusConnection *conn)
 {
@@ -110,8 +112,31 @@ static gboolean get_type(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
+static gboolean uuids_exists(const GDBusPropertyTable *property, void *data)
+{
+	return ad_uuids_len != 0;
+}
+
+static gboolean get_uuids(const GDBusPropertyTable *property,
+				DBusMessageIter *iter, void *user_data)
+{
+	DBusMessageIter array;
+	size_t i;
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY, "as", &array);
+
+	for (i = 0; i < ad_uuids_len; i++)
+		dbus_message_iter_append_basic(&array, DBUS_TYPE_STRING,
+							&ad_uuids[i]);
+
+	dbus_message_iter_close_container(iter, &array);
+
+	return TRUE;
+}
+
 static const GDBusPropertyTable ad_props[] = {
 	{ "Type", "s", get_type },
+	{ "ServiceUUIDs", "as", get_uuids, NULL, uuids_exists },
 	{ }
 };
 
@@ -177,3 +202,21 @@ void ad_unregister(DBusConnection *conn, GDBusProxy *manager)
 		return;
 	}
 }
+
+void ad_advertise_uuids(const char *arg)
+{
+	g_strfreev(ad_uuids);
+	ad_uuids = NULL;
+	ad_uuids_len = 0;
+
+	if (!arg || !strlen(arg))
+		return;
+
+	ad_uuids = g_strsplit(arg, " ", -1);
+	if (!ad_uuids) {
+		rl_printf("Failed to parse input\n");
+		return;
+	}
+
+	ad_uuids_len = g_strv_length(ad_uuids);
+}
diff --git a/client/main.c b/client/main.c
index 471879f..d6b52c4 100644
--- a/client/main.c
+++ b/client/main.c
@@ -1873,6 +1873,11 @@ static char *ad_generator(const char *text, int state)
 	return NULL;
 }
 
+static void cmd_set_advertise_uuids(const char *arg)
+{
+	ad_advertise_uuids(arg);
+}
+
 static const struct {
 	const char *cmd;
 	const char *arg;
@@ -1904,6 +1909,8 @@ static const struct {
 	{ "advertise",    "<on/off/type>", cmd_advertise,
 				"Enable/disable advertising with given type",
 							ad_generator},
+	{ "set-advertise-uuids", "[uuid1 uuid2 ...]",
+			cmd_set_advertise_uuids, "Set advertise uuids" },
 	{ "set-scan-filter-uuids", "[uuid1 uuid2 ...]",
 			cmd_set_scan_filter_uuids, "Set scan filter uuids" },
 	{ "set-scan-filter-rssi", "[rssi]", cmd_set_scan_filter_rssi,
-- 
2.7.4

