Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 4/7] client: Add set-advertise-name command
Date: Fri,  4 Aug 2017 15:21:05 +0300
Message-Id: <20170804122108.26472-4-luiz.dentz@gmail.com>
In-Reply-To: <20170804122108.26472-1-luiz.dentz@gmail.com>
References: <20170804122108.26472-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds set-advertise-name which enables the use of adapter
name/alias in the scan response:

[bluetooth]# set-advertise-name on
[bluetooth]# advertise on

@ MGMT Command: Add Advertising (0x003e) plen 11
        Instance: 1
        Flags: 0x00000043
          Switch into Connectable mode
          Advertise as Discoverable
          Add Local Name in Scan Response
        Duration: 0
        Timeout: 0
        Advertising data length: 0
        Scan response length: 0
---
 client/advertising.c | 21 +++++++++++++++++++++
 client/advertising.h |  1 +
 client/main.c        | 22 ++++++++++++++++++++++
 3 files changed, 44 insertions(+)

diff --git a/client/advertising.c b/client/advertising.c
index 81fa85118..67e87c7ca 100644
--- a/client/advertising.c
+++ b/client/advertising.c
@@ -49,6 +49,7 @@ static uint16_t ad_manufacturer_id;
 static uint8_t ad_manufacturer_data[25];
 static uint8_t ad_manufacturer_data_len = 0;
 static gboolean ad_tx_power = FALSE;
+static gboolean ad_name = FALSE;
 
 static void ad_release(DBusConnection *conn)
 {
@@ -252,6 +253,20 @@ static gboolean get_tx_power(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
+static gboolean include_name_exists(const GDBusPropertyTable *property,
+							void *data)
+{
+	return ad_name;
+}
+
+static gboolean get_include_name(const GDBusPropertyTable *property,
+				DBusMessageIter *iter, void *user_data)
+{
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_BOOLEAN, &ad_name);
+
+	return TRUE;
+}
+
 static const GDBusPropertyTable ad_props[] = {
 	{ "Type", "s", get_type },
 	{ "ServiceUUIDs", "as", get_uuids, NULL, uuids_exists },
@@ -259,6 +274,7 @@ static const GDBusPropertyTable ad_props[] = {
 	{ "ManufacturerData", "a{qv}", get_manufacturer_data, NULL,
 						manufacturer_data_exists },
 	{ "IncludeTxPower", "b", get_tx_power, NULL, tx_power_exists },
+	{ "IncludeName", "b", get_include_name, NULL, include_name_exists },
 	{ }
 };
 
@@ -453,3 +469,8 @@ void ad_advertise_tx_power(gboolean value)
 {
 	ad_tx_power = value;
 }
+
+void ad_advertise_name(gboolean value)
+{
+	ad_name = value;
+}
diff --git a/client/advertising.h b/client/advertising.h
index 86384656c..a41a2742d 100644
--- a/client/advertising.h
+++ b/client/advertising.h
@@ -28,3 +28,4 @@ void ad_advertise_uuids(const char *arg);
 void ad_advertise_service(const char *arg);
 void ad_advertise_manufacturer(const char *arg);
 void ad_advertise_tx_power(gboolean value);
+void ad_advertise_name(gboolean value);
diff --git a/client/main.c b/client/main.c
index 17de7f81f..44de8c0a0 100644
--- a/client/main.c
+++ b/client/main.c
@@ -2362,6 +2362,26 @@ static void cmd_set_advertise_tx_power(const char *arg)
 	rl_printf("Invalid argument\n");
 }
 
+static void cmd_set_advertise_name(const char *arg)
+{
+	if (arg == NULL || strlen(arg) == 0) {
+		rl_printf("Missing on/off argument\n");
+		return;
+	}
+
+	if (strcmp(arg, "on") == 0 || strcmp(arg, "yes") == 0) {
+		ad_advertise_name(TRUE);
+		return;
+	}
+
+	if (strcmp(arg, "off") == 0 || strcmp(arg, "no") == 0) {
+		ad_advertise_name(FALSE);
+		return;
+	}
+
+	rl_printf("Invalid argument\n");
+}
+
 static const struct {
 	const char *cmd;
 	const char *arg;
@@ -2406,6 +2426,8 @@ static const struct {
 	{ "set-advertise-tx-power", "<on/off>",
 			cmd_set_advertise_tx_power,
 			"Enable/disable TX power to be advertised" },
+	{ "set-advertise-name", "<on/off>", cmd_set_advertise_name,
+			"Enable/disable local name to be advertised" },
 	{ "set-scan-filter-uuids", "[uuid1 uuid2 ...]",
 			cmd_set_scan_filter_uuids, "Set scan filter uuids" },
 	{ "set-scan-filter-rssi", "[rssi]", cmd_set_scan_filter_rssi,
-- 
2.13.3

