Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v8 14/14] client: Enable set-advertise-appearance to set Appearance
Date: Thu, 10 Aug 2017 16:32:51 +0300
Message-Id: <20170810133251.23920-14-luiz.dentz@gmail.com>
In-Reply-To: <20170810133251.23920-1-luiz.dentz@gmail.com>
References: <20170810133251.23920-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This enables set-advertise-appearance to use Appearance property:

[bluetooth]# set-advertise-appearance 128
[bluetooth]# advertise on

@ MGMT Command: Add Advertising (0x003e) plen 15
        Instance: 1
        Flags: 0x00000003
          Switch into Connectable mode
          Advertise as Discoverable
        Duration: 0
        Timeout: 0
        Advertising data length: 4
        Appearance: Computer (0x0080)
        Scan response length: 0
---
 client/advertising.c | 28 +++++++++++++++++++++++++++-
 client/advertising.h |  1 +
 client/main.c        | 11 ++++++++++-
 3 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/client/advertising.c b/client/advertising.c
index 571b6e619..696621be3 100644
--- a/client/advertising.c
+++ b/client/advertising.c
@@ -58,6 +58,7 @@ static struct ad {
 	bool registered;
 	char *type;
 	char *local_name;
+	uint16_t local_appearance;
 	char **uuids;
 	size_t uuids_len;
 	struct service_data service;
@@ -65,7 +66,9 @@ static struct ad {
 	bool tx_power;
 	bool name;
 	bool appearance;
-} ad;
+} ad = {
+	.local_appearance = UINT16_MAX,
+};
 
 static void ad_release(DBusConnection *conn)
 {
@@ -304,6 +307,20 @@ static gboolean get_local_name(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
+static gboolean appearance_exits(const GDBusPropertyTable *property, void *data)
+{
+	return ad.local_appearance != UINT16_MAX ? TRUE : FALSE;
+}
+
+static gboolean get_appearance(const GDBusPropertyTable *property,
+				DBusMessageIter *iter, void *user_data)
+{
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT16,
+							&ad.local_appearance);
+
+	return TRUE;
+}
+
 static const GDBusPropertyTable ad_props[] = {
 	{ "Type", "s", get_type },
 	{ "ServiceUUIDs", "as", get_uuids, NULL, uuids_exists },
@@ -312,6 +329,7 @@ static const GDBusPropertyTable ad_props[] = {
 						manufacturer_data_exists },
 	{ "Includes", "as", get_includes, NULL, includes_exists },
 	{ "LocalName", "s", get_local_name, NULL, local_name_exits },
+	{ "Appearance", "q", get_appearance, NULL, appearance_exits },
 	{ }
 };
 
@@ -524,4 +542,12 @@ void ad_advertise_local_name(const char *name)
 void ad_advertise_appearance(bool value)
 {
 	ad.appearance = value;
+
+	if (!value)
+		ad.local_appearance = UINT16_MAX;
+}
+
+void ad_advertise_local_appearance(uint16_t value)
+{
+	ad.local_appearance = value;
 }
diff --git a/client/advertising.h b/client/advertising.h
index 255743562..5ea57adb3 100644
--- a/client/advertising.h
+++ b/client/advertising.h
@@ -31,3 +31,4 @@ void ad_advertise_tx_power(bool value);
 void ad_advertise_name(bool value);
 void ad_advertise_appearance(bool value);
 void ad_advertise_local_name(const char *name);
+void ad_advertise_local_appearance(uint16_t value);
diff --git a/client/main.c b/client/main.c
index 328a5ee3a..6b1c73f99 100644
--- a/client/main.c
+++ b/client/main.c
@@ -2384,6 +2384,9 @@ static void cmd_set_advertise_name(const char *arg)
 
 static void cmd_set_advertise_appearance(const char *arg)
 {
+	long int value;
+	char *endptr = NULL;
+
 	if (arg == NULL || strlen(arg) == 0) {
 		rl_printf("Missing value argument\n");
 		return;
@@ -2399,7 +2402,13 @@ static void cmd_set_advertise_appearance(const char *arg)
 		return;
 	}
 
-	rl_printf("Invalid argument\n");
+	value = strtol(arg, &endptr, 0);
+	if (!endptr || *endptr != '\0' || value > UINT16_MAX) {
+		rl_printf("Invalid argument\n");
+		return;
+	}
+
+	ad_advertise_local_appearance(value);
 }
 
 static const struct {
-- 
2.13.4

