Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 5/7] client: Add set-advertise-service command
Date: Thu, 11 Aug 2016 15:14:50 +0300
Message-Id: <1470917692-8878-6-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1470917692-8878-1-git-send-email-luiz.dentz@gmail.com>
References: <1470917692-8878-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds set-advertise-service which can be used set UUID data to be
advertised:

set-advertise-service [uuid][data=[xx xx ...]
[bluetooth]# set-advertise-service 180D 0xff 0xff
[bluetooth]# advertise on

@ Advertising Added: 1
< HCI Command: LE Set Advertising Data (0x08|0x0008) plen 32
        Length: 9
        Flags: 0x02
          LE General Discoverable Mode
        Service Data (UUID 0x180d): ffff
---
 client/advertising.c | 128 +++++++++++++++++++++++++++++++++++++++++++++++++++
 client/main.c        |   8 ++++
 2 files changed, 136 insertions(+)

diff --git a/client/advertising.c b/client/advertising.c
index e74221f..3e4e10c 100644
--- a/client/advertising.c
+++ b/client/advertising.c
@@ -42,6 +42,9 @@ static gboolean registered = FALSE;
 static char *ad_type = NULL;
 static char **ad_uuids = NULL;
 static size_t ad_uuids_len = 0;
+static char *ad_service_uuid = NULL;
+static uint8_t ad_service_data[25];
+static uint8_t ad_service_data_len = 0;
 
 static void ad_release(DBusConnection *conn)
 {
@@ -134,9 +137,85 @@ static gboolean get_uuids(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
+static void append_array_variant(DBusMessageIter *iter, int type, void *val,
+							int n_elements)
+{
+	DBusMessageIter variant, array;
+	char type_sig[2] = { type, '\0' };
+	char array_sig[3] = { DBUS_TYPE_ARRAY, type, '\0' };
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_VARIANT,
+						array_sig, &variant);
+
+	dbus_message_iter_open_container(&variant, DBUS_TYPE_ARRAY,
+						type_sig, &array);
+
+	if (dbus_type_is_fixed(type) == TRUE) {
+		dbus_message_iter_append_fixed_array(&array, type, val,
+							n_elements);
+	} else if (type == DBUS_TYPE_STRING || type == DBUS_TYPE_OBJECT_PATH) {
+		const char ***str_array = val;
+		int i;
+
+		for (i = 0; i < n_elements; i++)
+			dbus_message_iter_append_basic(&array, type,
+							&((*str_array)[i]));
+	}
+
+	dbus_message_iter_close_container(&variant, &array);
+
+	dbus_message_iter_close_container(iter, &variant);
+}
+
+static void dict_append_basic_array(DBusMessageIter *dict, int key_type,
+					const void *key, int type, void *val,
+					int n_elements)
+{
+	DBusMessageIter entry;
+
+	dbus_message_iter_open_container(dict, DBUS_TYPE_DICT_ENTRY,
+						NULL, &entry);
+
+	dbus_message_iter_append_basic(&entry, key_type, key);
+
+	append_array_variant(&entry, type, val, n_elements);
+
+	dbus_message_iter_close_container(dict, &entry);
+}
+
+static void dict_append_array(DBusMessageIter *dict, const char *key, int type,
+				void *val, int n_elements)
+{
+	dict_append_basic_array(dict, DBUS_TYPE_STRING, &key, type, val,
+								n_elements);
+}
+
+static gboolean service_data_exists(const GDBusPropertyTable *property,
+								void *data)
+{
+	return ad_service_uuid != NULL;
+}
+
+static gboolean get_service_data(const GDBusPropertyTable *property,
+				DBusMessageIter *iter, void *user_data)
+{
+	DBusMessageIter dict;
+	const uint8_t *data = ad_service_data;
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY, "{sv}", &dict);
+
+	dict_append_array(&dict, ad_service_uuid, DBUS_TYPE_BYTE, &data,
+							ad_service_data_len);
+
+	dbus_message_iter_close_container(iter, &dict);
+
+	return TRUE;
+}
+
 static const GDBusPropertyTable ad_props[] = {
 	{ "Type", "s", get_type },
 	{ "ServiceUUIDs", "as", get_uuids, NULL, uuids_exists },
+	{ "ServiceData", "a{sv}", get_service_data, NULL, service_data_exists },
 	{ }
 };
 
@@ -220,3 +299,52 @@ void ad_advertise_uuids(const char *arg)
 
 	ad_uuids_len = g_strv_length(ad_uuids);
 }
+
+static void ad_clear_service(void)
+{
+	g_free(ad_service_uuid);
+	ad_service_uuid = NULL;
+	memset(ad_service_data, 0, sizeof(ad_service_data));
+	ad_service_data_len = 0;
+}
+
+void ad_advertise_service(const char *arg)
+{
+	wordexp_t w;
+	unsigned int i;
+
+	if (wordexp(arg, &w, WRDE_NOCMD)) {
+		rl_printf("Invalid argument\n");
+		return;
+	}
+
+	ad_clear_service();
+
+	if (w.we_wordc == 0)
+		goto done;
+
+	ad_service_uuid = g_strdup(w.we_wordv[0]);
+
+	for (i = 1; i < w.we_wordc; i++) {
+		long int val;
+		char *endptr = NULL;
+
+		if (i >= G_N_ELEMENTS(ad_service_data)) {
+			rl_printf("Too much data\n");
+			goto done;
+		}
+
+		val = strtol(w.we_wordv[i], &endptr, 0);
+		if (!endptr || *endptr != '\0' || val > UINT8_MAX) {
+			rl_printf("Invalid value at index %d\n", i);
+			ad_clear_service();
+			goto done;
+		}
+
+		ad_service_data[ad_service_data_len] = val;
+		ad_service_data_len++;
+	}
+
+done:
+	wordfree(&w);
+}
diff --git a/client/main.c b/client/main.c
index d6b52c4..72c2cd9 100644
--- a/client/main.c
+++ b/client/main.c
@@ -1878,6 +1878,11 @@ static void cmd_set_advertise_uuids(const char *arg)
 	ad_advertise_uuids(arg);
 }
 
+static void cmd_set_advertise_service(const char *arg)
+{
+	ad_advertise_service(arg);
+}
+
 static const struct {
 	const char *cmd;
 	const char *arg;
@@ -1911,6 +1916,9 @@ static const struct {
 							ad_generator},
 	{ "set-advertise-uuids", "[uuid1 uuid2 ...]",
 			cmd_set_advertise_uuids, "Set advertise uuids" },
+	{ "set-advertise-service", "[uuid][data=[xx xx ...]",
+			cmd_set_advertise_service,
+			"Set advertise service data" },
 	{ "set-scan-filter-uuids", "[uuid1 uuid2 ...]",
 			cmd_set_scan_filter_uuids, "Set scan filter uuids" },
 	{ "set-scan-filter-rssi", "[rssi]", cmd_set_scan_filter_rssi,
-- 
2.7.4

