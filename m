Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v8 12/14] client: Enable set-advertise-name to set LocalName
Date: Thu, 10 Aug 2017 16:32:49 +0300
Message-Id: <20170810133251.23920-12-luiz.dentz@gmail.com>
In-Reply-To: <20170810133251.23920-1-luiz.dentz@gmail.com>
References: <20170810133251.23920-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This enables set-advertise-name to use LocalName property:

[bluetooth]# set-advertise-name blah
[bluetooth]# advertise on

@ MGMT Command: Add Advertising (0x003e) plen 17
        Instance: 1
        Flags: 0x00000003
          Switch into Connectable mode
          Advertise as Discoverable
        Duration: 0
        Timeout: 0
        Advertising data length: 0
        Scan response length: 6
        Name (complete): blah
---
 client/advertising.c | 24 ++++++++++++++++++++++++
 client/advertising.h |  1 +
 client/main.c        |  4 ++--
 3 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/client/advertising.c b/client/advertising.c
index 35e582afc..571b6e619 100644
--- a/client/advertising.c
+++ b/client/advertising.c
@@ -57,6 +57,7 @@ struct manufacturer_data {
 static struct ad {
 	bool registered;
 	char *type;
+	char *local_name;
 	char **uuids;
 	size_t uuids_len;
 	struct service_data service;
@@ -290,6 +291,19 @@ static gboolean get_includes(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
+static gboolean local_name_exits(const GDBusPropertyTable *property, void *data)
+{
+	return ad.local_name ? TRUE : FALSE;
+}
+
+static gboolean get_local_name(const GDBusPropertyTable *property,
+				DBusMessageIter *iter, void *user_data)
+{
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &ad.local_name);
+
+	return TRUE;
+}
+
 static const GDBusPropertyTable ad_props[] = {
 	{ "Type", "s", get_type },
 	{ "ServiceUUIDs", "as", get_uuids, NULL, uuids_exists },
@@ -297,6 +311,7 @@ static const GDBusPropertyTable ad_props[] = {
 	{ "ManufacturerData", "a{qv}", get_manufacturer_data, NULL,
 						manufacturer_data_exists },
 	{ "Includes", "as", get_includes, NULL, includes_exists },
+	{ "LocalName", "s", get_local_name, NULL, local_name_exits },
 	{ }
 };
 
@@ -495,6 +510,15 @@ void ad_advertise_tx_power(bool value)
 void ad_advertise_name(bool value)
 {
 	ad.name = value;
+
+	if (!value)
+		free(ad.local_name);
+}
+
+void ad_advertise_local_name(const char *name)
+{
+	free(ad.local_name);
+	ad.local_name = strdup(name);
 }
 
 void ad_advertise_appearance(bool value)
diff --git a/client/advertising.h b/client/advertising.h
index 77fc1cca5..255743562 100644
--- a/client/advertising.h
+++ b/client/advertising.h
@@ -30,3 +30,4 @@ void ad_advertise_manufacturer(const char *arg);
 void ad_advertise_tx_power(bool value);
 void ad_advertise_name(bool value);
 void ad_advertise_appearance(bool value);
+void ad_advertise_local_name(const char *name);
diff --git a/client/main.c b/client/main.c
index 0bc2a8896..328a5ee3a 100644
--- a/client/main.c
+++ b/client/main.c
@@ -2379,7 +2379,7 @@ static void cmd_set_advertise_name(const char *arg)
 		return;
 	}
 
-	rl_printf("Invalid argument\n");
+	ad_advertise_local_name(arg);
 }
 
 static void cmd_set_advertise_appearance(const char *arg)
@@ -2446,7 +2446,7 @@ static const struct {
 	{ "set-advertise-tx-power", "<on/off>",
 			cmd_set_advertise_tx_power,
 			"Enable/disable TX power to be advertised" },
-	{ "set-advertise-name", "<on/off>", cmd_set_advertise_name,
+	{ "set-advertise-name", "<on/off/name>", cmd_set_advertise_name,
 			"Enable/disable local name to be advertised" },
 	{ "set-advertise-appearance", "<value>", cmd_set_advertise_appearance,
 			"Set custom appearance to be advertised" },
-- 
2.13.4

