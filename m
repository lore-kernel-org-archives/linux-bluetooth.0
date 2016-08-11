Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 6/7] client: Add set-advertise-manufacturer command
Date: Thu, 11 Aug 2016 15:14:51 +0300
Message-Id: <1470917692-8878-7-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1470917692-8878-1-git-send-email-luiz.dentz@gmail.com>
References: <1470917692-8878-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds set-advertise-manufacturer which can be used set manfacturer
spefic data to be advertised:

set-advertise-manufacturer [id][data=[xx xx ...]
[bluetooth]# set-advertise-manufacturer 0xffff 0x00 0x01 0x02 0x03
[bluetooth]# advertise on

@ Advertising Added: 1
< HCI Command: LE Set Advertising Data (0x08|0x0008) plen 32
        Length: 11
        Flags: 0x02
          LE General Discoverable Mode
        Company: internal use (65535)
          Data: 00010203
---
 client/advertising.c | 81 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 client/main.c        |  8 ++++++
 2 files changed, 89 insertions(+)

diff --git a/client/advertising.c b/client/advertising.c
index 3e4e10c..5176bc5 100644
--- a/client/advertising.c
+++ b/client/advertising.c
@@ -45,6 +45,9 @@ static size_t ad_uuids_len = 0;
 static char *ad_service_uuid = NULL;
 static uint8_t ad_service_data[25];
 static uint8_t ad_service_data_len = 0;
+static uint16_t ad_manufacturer_id;
+static uint8_t ad_manufacturer_data[25];
+static uint8_t ad_manufacturer_data_len = 0;
 
 static void ad_release(DBusConnection *conn)
 {
@@ -212,10 +215,35 @@ static gboolean get_service_data(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
+static gboolean manufacturer_data_exists(const GDBusPropertyTable *property,
+								void *data)
+{
+	return ad_manufacturer_id != 0;
+}
+
+static gboolean get_manufacturer_data(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *user_data)
+{
+	DBusMessageIter dict;
+	const uint8_t *data = ad_manufacturer_data;
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY, "{qv}", &dict);
+
+	dict_append_basic_array(&dict, DBUS_TYPE_UINT16, &ad_manufacturer_id,
+					DBUS_TYPE_BYTE, &data,
+					ad_manufacturer_data_len);
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
+	{ "ManufacturerData", "a{qv}", get_manufacturer_data, NULL,
+						manufacturer_data_exists },
 	{ }
 };
 
@@ -348,3 +376,56 @@ void ad_advertise_service(const char *arg)
 done:
 	wordfree(&w);
 }
+
+static void ad_clear_manufacturer(void)
+{
+	ad_manufacturer_id = 0;
+	memset(ad_manufacturer_data, 0, sizeof(ad_manufacturer_data));
+	ad_manufacturer_data_len = 0;
+}
+
+void ad_advertise_manufacturer(const char *arg)
+{
+	wordexp_t w;
+	unsigned int i;
+	char *endptr = NULL;
+	long int val;
+
+	if (wordexp(arg, &w, WRDE_NOCMD)) {
+		rl_printf("Invalid argument\n");
+		return;
+	}
+
+	ad_clear_manufacturer();
+
+	if (w.we_wordc == 0)
+		goto done;
+
+	val = strtol(w.we_wordv[0], &endptr, 0);
+	if (!endptr || *endptr != '\0' || val > UINT16_MAX) {
+		rl_printf("Invalid manufacture id\n");
+		goto done;
+	}
+
+	ad_manufacturer_id = val;
+
+	for (i = 1; i < w.we_wordc; i++) {
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
+		ad_manufacturer_data[ad_manufacturer_data_len] = val;
+		ad_manufacturer_data_len++;
+	}
+
+done:
+	wordfree(&w);
+}
diff --git a/client/main.c b/client/main.c
index 72c2cd9..41a0af3 100644
--- a/client/main.c
+++ b/client/main.c
@@ -1883,6 +1883,11 @@ static void cmd_set_advertise_service(const char *arg)
 	ad_advertise_service(arg);
 }
 
+static void cmd_set_advertise_manufacturer(const char *arg)
+{
+	ad_advertise_service(arg);
+}
+
 static const struct {
 	const char *cmd;
 	const char *arg;
@@ -1919,6 +1924,9 @@ static const struct {
 	{ "set-advertise-service", "[uuid][data=[xx xx ...]",
 			cmd_set_advertise_service,
 			"Set advertise service data" },
+	{ "set-advertise-manufacturer", "[id][data=[xx xx ...]",
+			cmd_set_advertise_manufacturer,
+			"Set advertise manufacturer data" },
 	{ "set-scan-filter-uuids", "[uuid1 uuid2 ...]",
 			cmd_set_scan_filter_uuids, "Set scan filter uuids" },
 	{ "set-scan-filter-rssi", "[rssi]", cmd_set_scan_filter_rssi,
-- 
2.7.4

