Return-Path: <cyrus@holtmann.org>
From: Jakub Pawlowski <jpawlowski@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Pawlowski <jpawlowski@google.com>
Subject: [PATCH v9] client: main: add support for SetDiscoveryFilter
Date: Tue, 28 Apr 2015 00:04:55 -0700
Message-Id: <1430204695-22711-1-git-send-email-jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds set-scan-filter-* commands to sample DBus client that
might be used to modify discovery filter.

set-scan-filter-uuids - sets filter uuids field
set-scan-filter-rssi - sets filter rssi and clears pathloss
set-scan-filter-pathloss - sets filter pathloss and clears rssi
set-scan-filter-transport - sets filter transport
set-scan-filter-clear - clears filter

Sample output:
[bluetooth]# power on
Changing power on succeeded
[bluetooth]# set-scan-filter-uuids babe
SetDiscoveryFilter success
[bluetooth]# set-scan-filter-transport le
SetDiscoveryFilter success
[bluetooth]# set-scan-filter-rssi -69
SetDiscoveryFilter success
[bluetooth]# scan on
Discovery started
[CHG] Controller 00:1A:7D:DA:71:13 Discovering: yes
[CHG] Device 44:89:1C:C5:67:94 RSSI: -66
[CHG] Device 44:89:1C:C5:67:94 TxPower: -21
[CHG] Device 44:89:1C:C5:67:94 RSSI: -65
[CHG] Device 44:89:1C:C5:67:94 RSSI: -58
[CHG] Device 44:89:1C:C5:67:94 RSSI: -64
[CHG] Device 44:89:1C:C5:67:94 RSSI: -59
[CHG] Device 44:89:1C:C5:67:94 RSSI: -65
[CHG] Device 44:89:1C:C5:67:94 RSSI: -59
[CHG] Device 44:89:1C:C5:67:94 RSSI: -64
[bluetooth]# set-scan-filter-rssi -90
SetDiscoveryFilter success
[CHG] Device 44:89:1C:C5:67:94 RSSI: -76
[CHG] Device 44:89:1C:C5:67:94 RSSI: -82
[CHG] Device 44:89:1C:C5:67:94 RSSI: -75
[CHG] Device 44:89:1C:C5:67:94 RSSI: -81
[CHG] Device 44:89:1C:C5:67:94 RSSI: -76
[CHG] Device 44:89:1C:C5:67:94 RSSI: -76
[CHG] Device 44:89:1C:C5:67:94 RSSI: -81
[CHG] Device 44:89:1C:C5:67:94 RSSI: -75
[CHG] Device 44:89:1C:C5:67:94 RSSI: -82
[CHG] Device 44:89:1C:C5:67:94 RSSI: -82
[bluetooth]# scan off
[CHG] Device 44:89:1C:C5:67:94 TxPower is nil
[CHG] Device 44:89:1C:C5:67:94 RSSI is nil
Discovery stopped
[CHG] Controller 00:1A:7D:DA:71:13 Discovering: no
---
 client/main.c | 227 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 227 insertions(+)

diff --git a/client/main.c b/client/main.c
index 46ef72a..41e95b2 100644
--- a/client/main.c
+++ b/client/main.c
@@ -902,6 +902,222 @@ static void cmd_scan(const char *arg)
 	}
 }
 
+static void append_variant(DBusMessageIter *iter, int type, void *val)
+{
+	DBusMessageIter value;
+	char sig[2] = { type, '\0' };
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_VARIANT, sig, &value);
+
+	dbus_message_iter_append_basic(&value, type, val);
+
+	dbus_message_iter_close_container(iter, &value);
+}
+
+static void dict_append_entry(DBusMessageIter *dict, const char *key,
+							int type, void *val)
+{
+	DBusMessageIter entry;
+
+	if (type == DBUS_TYPE_STRING) {
+		const char *str = *((const char **) val);
+
+		if (str == NULL)
+			return;
+	}
+
+	dbus_message_iter_open_container(dict, DBUS_TYPE_DICT_ENTRY,
+							NULL, &entry);
+
+	dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING, &key);
+
+	append_variant(&entry, type, val);
+
+	dbus_message_iter_close_container(dict, &entry);
+}
+
+#define	DISTANCE_VAL_INVALID	0x7FFF
+
+struct set_discovery_filter_args {
+	char *transport;
+	dbus_uint16_t rssi;
+	dbus_int16_t pathloss;
+	GSList *uuids;
+};
+
+static void set_discovery_filter_setup(DBusMessageIter *iter,
+					   void *user_data)
+{
+	struct set_discovery_filter_args *args = user_data;
+	DBusMessageIter dict;
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
+			    DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
+			    DBUS_TYPE_STRING_AS_STRING
+			    DBUS_TYPE_VARIANT_AS_STRING
+			    DBUS_DICT_ENTRY_END_CHAR_AS_STRING, &dict);
+
+	if (args->uuids != NULL) {
+		DBusMessageIter entry, value, arrayIter;
+		char *uuids = "UUIDs";
+		GSList *l;
+
+		dbus_message_iter_open_container(&dict, DBUS_TYPE_DICT_ENTRY,
+						 NULL, &entry);
+		/* dict key */
+		dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING,
+					       &uuids);
+
+		dbus_message_iter_open_container(&entry, DBUS_TYPE_VARIANT,
+						 "as", &value);
+
+		dbus_message_iter_open_container(&value, DBUS_TYPE_ARRAY, "s",
+						 &arrayIter);
+
+		for (l = args->uuids; l != NULL; l = g_slist_next(l))
+			/* list->data contains string representation of uuid */
+			dbus_message_iter_append_basic(&arrayIter,
+						       DBUS_TYPE_STRING,
+						       &l->data);
+
+		dbus_message_iter_close_container(&value, &arrayIter);
+
+		/* close vararg*/
+		dbus_message_iter_close_container(&entry, &value);
+
+		/* close entry */
+		dbus_message_iter_close_container(&dict, &entry);
+	}
+
+	if (args->pathloss != DISTANCE_VAL_INVALID)
+		dict_append_entry(&dict, "Pathloss", DBUS_TYPE_UINT16,
+				  &args->pathloss);
+
+	if (args->rssi != DISTANCE_VAL_INVALID)
+		dict_append_entry(&dict, "RSSI", DBUS_TYPE_INT16, &args->rssi);
+
+	if (args->transport != NULL)
+		dict_append_entry(&dict, "Transport", DBUS_TYPE_STRING,
+				  &args->transport);
+
+	dbus_message_iter_close_container(iter, &dict);
+}
+
+
+static void set_discovery_filter_reply(DBusMessage *message,
+				       void *user_data)
+{
+	DBusError error;
+
+	dbus_error_init(&error);
+	if (dbus_set_error_from_message(&error, message) == TRUE) {
+		rl_printf("SetDiscoveryFilter failed: %s\n", error.name);
+		dbus_error_free(&error);
+		return;
+	}
+
+	rl_printf("SetDiscoveryFilter success\n");
+}
+
+static gint filtered_scan_rssi = DISTANCE_VAL_INVALID;
+static gint filtered_scan_pathloss = DISTANCE_VAL_INVALID;
+static GSList *filtered_scan_uuids;
+static char *filtered_scan_transport;
+
+static void cmd_set_scan_filter_commit(void)
+{
+	struct set_discovery_filter_args args;
+
+	args.uuids = NULL;
+	args.pathloss = filtered_scan_pathloss;
+	args.rssi = filtered_scan_rssi;
+	args.transport = filtered_scan_transport;
+	args.uuids = filtered_scan_uuids;
+
+	if (check_default_ctrl() == FALSE)
+		return;
+
+	if (g_dbus_proxy_method_call(default_ctrl, "SetDiscoveryFilter",
+		set_discovery_filter_setup, set_discovery_filter_reply,
+		&args, NULL) == FALSE) {
+		rl_printf("Failed to set discovery filter\n");
+		return;
+	}
+}
+
+static void cmd_set_scan_filter_uuids(const char *arg)
+{
+	char *uuid_str, *saveptr, *uuids, *uuidstmp;
+
+	g_slist_free_full(filtered_scan_uuids, g_free);
+	filtered_scan_uuids = NULL;
+
+	if (!arg || !strlen(arg))
+		return;
+
+	uuids = g_strdup(arg);
+	for (uuidstmp = uuids; ; uuidstmp = NULL) {
+		uuid_str = strtok_r(uuidstmp, " \t", &saveptr);
+		if (uuid_str == NULL)
+			break;
+	    filtered_scan_uuids = g_slist_append(filtered_scan_uuids,
+							strdup(uuid_str));
+	}
+
+	g_free(uuids);
+
+	cmd_set_scan_filter_commit();
+}
+
+static void cmd_set_scan_filter_rssi(const char *arg)
+{
+	filtered_scan_pathloss = DISTANCE_VAL_INVALID;
+
+	if (!arg || !strlen(arg))
+		filtered_scan_rssi = DISTANCE_VAL_INVALID;
+	else
+		filtered_scan_rssi = atoi(arg);
+
+	cmd_set_scan_filter_commit();
+}
+
+static void cmd_set_scan_filter_pathloss(const char *arg)
+{
+	filtered_scan_rssi = DISTANCE_VAL_INVALID;
+
+	if (!arg || !strlen(arg))
+		filtered_scan_pathloss = DISTANCE_VAL_INVALID;
+	else
+		filtered_scan_pathloss = atoi(arg);
+
+	cmd_set_scan_filter_commit();
+}
+
+static void cmd_set_scan_filter_transport(const char *arg)
+{
+	g_free(filtered_scan_transport);
+
+	if (!arg || !strlen(arg))
+		filtered_scan_transport = NULL;
+	else
+		filtered_scan_transport = g_strdup(arg);
+
+	cmd_set_scan_filter_commit();
+}
+
+static void cmd_set_scan_filter_clear(const char *arg)
+{
+	/* set default values for all options */
+	filtered_scan_rssi = DISTANCE_VAL_INVALID;
+	filtered_scan_pathloss = DISTANCE_VAL_INVALID;
+	g_slist_free_full(filtered_scan_uuids, g_free);
+	filtered_scan_uuids = NULL;
+	g_free(filtered_scan_transport);
+	filtered_scan_transport = NULL;
+
+	cmd_set_scan_filter_commit();
+}
+
 static struct GDBusProxy *find_device(const char *arg)
 {
 	GDBusProxy *proxy;
@@ -1478,6 +1694,17 @@ static const struct {
 							capability_generator},
 	{ "default-agent",NULL,       cmd_default_agent,
 				"Set agent as the default one" },
+	{ "set-scan-filter-uuids", "[uuid1 uuid2 ...]",
+			cmd_set_scan_filter_uuids, "Set scan filter uuids" },
+	{ "set-scan-filter-rssi", "[rssi]", cmd_set_scan_filter_rssi,
+				"Set scan filter rssi, and clears pathloss" },
+	{ "set-scan-filter-pathloss", "[pathloss]",
+						cmd_set_scan_filter_pathloss,
+				"Set scan filter pathloss, and clears rssi" },
+	{ "set-scan-filter-transport", "[transport]",
+		cmd_set_scan_filter_transport, "Set scan filter transport" },
+	{ "set-scan-filter-clear", "", cmd_set_scan_filter_clear,
+						"Clears discovery filter." },
 	{ "scan",         "<on/off>", cmd_scan, "Scan for devices" },
 	{ "info",         "[dev]",    cmd_info, "Device information",
 							dev_generator },
-- 
2.2.0.rc0.207.ga3a616c

