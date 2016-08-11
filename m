Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 7/7] client: Add set-advertise-tx-power command
Date: Thu, 11 Aug 2016 15:14:52 +0300
Message-Id: <1470917692-8878-8-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1470917692-8878-1-git-send-email-luiz.dentz@gmail.com>
References: <1470917692-8878-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds set-advertise-tx-power which can be used include TX power
in the advertisement data:

set-advertise-manufacturer <on/off>
[bluetooth]# set-advertise-tx-power on
[bluetooth]# advertise on

@ Advertising Added: 1
< HCI Command: LE Set Aidvertising Data (0x08|0x0008) plen 32
        Length: 6
        Flags: 0x02
          LE General Discoverable Mode
        TX power: 9 dBm
---
 client/advertising.c | 21 +++++++++++++++++++++
 client/main.c        | 25 ++++++++++++++++++++++++-
 2 files changed, 45 insertions(+), 1 deletion(-)

diff --git a/client/advertising.c b/client/advertising.c
index 5176bc5..62201d5 100644
--- a/client/advertising.c
+++ b/client/advertising.c
@@ -48,6 +48,7 @@ static uint8_t ad_service_data_len = 0;
 static uint16_t ad_manufacturer_id;
 static uint8_t ad_manufacturer_data[25];
 static uint8_t ad_manufacturer_data_len = 0;
+static gboolean ad_tx_power = FALSE;
 
 static void ad_release(DBusConnection *conn)
 {
@@ -238,12 +239,26 @@ static gboolean get_manufacturer_data(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
+static gboolean tx_power_exists(const GDBusPropertyTable *property, void *data)
+{
+	return ad_tx_power;
+}
+
+static gboolean get_tx_power(const GDBusPropertyTable *property,
+				DBusMessageIter *iter, void *user_data)
+{
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_BOOLEAN, &ad_tx_power);
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
+	{ "IncludeTxPower", "b", get_tx_power, NULL, tx_power_exists },
 	{ }
 };
 
@@ -429,3 +444,9 @@ void ad_advertise_manufacturer(const char *arg)
 done:
 	wordfree(&w);
 }
+
+
+void ad_advertise_tx_power(gboolean value)
+{
+	ad_tx_power = value;
+}
diff --git a/client/main.c b/client/main.c
index 41a0af3..1ceddb0 100644
--- a/client/main.c
+++ b/client/main.c
@@ -1885,7 +1885,27 @@ static void cmd_set_advertise_service(const char *arg)
 
 static void cmd_set_advertise_manufacturer(const char *arg)
 {
-	ad_advertise_service(arg);
+	ad_advertise_manufacturer(arg);
+}
+
+static void cmd_set_advertise_tx_power(const char *arg)
+{
+	if (arg == NULL || strlen(arg) == 0) {
+		rl_printf("Missing on/off argument\n");
+		return;
+	}
+
+	if (strcmp(arg, "on") == 0 || strcmp(arg, "yes") == 0) {
+		ad_advertise_tx_power(TRUE);
+		return;
+	}
+
+	if (strcmp(arg, "off") == 0 || strcmp(arg, "no") == 0) {
+		ad_advertise_tx_power(FALSE);
+		return;
+	}
+
+	rl_printf("Invalid argument\n");
 }
 
 static const struct {
@@ -1927,6 +1947,9 @@ static const struct {
 	{ "set-advertise-manufacturer", "[id][data=[xx xx ...]",
 			cmd_set_advertise_manufacturer,
 			"Set advertise manufacturer data" },
+	{ "set-advertise-tx-power", "<on/off>",
+			cmd_set_advertise_tx_power,
+			"Enable/disable TX power to be advertised" },
 	{ "set-scan-filter-uuids", "[uuid1 uuid2 ...]",
 			cmd_set_scan_filter_uuids, "Set scan filter uuids" },
 	{ "set-scan-filter-rssi", "[rssi]", cmd_set_scan_filter_rssi,
-- 
2.7.4

