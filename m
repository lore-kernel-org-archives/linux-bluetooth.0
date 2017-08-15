Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] client: Emit PropertiesChanged if advertising changes
Date: Tue, 15 Aug 2017 11:18:42 +0300
Message-Id: <20170815081842.14872-2-luiz.dentz@gmail.com>
In-Reply-To: <20170815081842.14872-1-luiz.dentz@gmail.com>
References: <20170815081842.14872-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This allows bluetoothd to detect changes done by the user without
having to rely on advertise command to unregister and register again:

bluetooth]# set-advertise-name blah
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

[bluetooth]# set-advertise-name bleh

@ MGMT Command: Add Advertising (0x003e) plen 17
        Instance: 1
        Flags: 0x00000003
          Switch into Connectable mode
          Advertise as Discoverable
        Duration: 0
        Timeout: 0
        Advertising data length: 0
        Scan response length: 6
        Name (complete): bleh
---
 client/advertising.c | 49 ++++++++++++++++++++++++++++++++++++++++---------
 client/advertising.h | 16 ++++++++--------
 client/main.c        | 22 +++++++++++-----------
 3 files changed, 59 insertions(+), 28 deletions(-)

diff --git a/client/advertising.c b/client/advertising.c
index 696621be3..72c4ccb21 100644
--- a/client/advertising.c
+++ b/client/advertising.c
@@ -399,7 +399,7 @@ void ad_unregister(DBusConnection *conn, GDBusProxy *manager)
 	}
 }
 
-void ad_advertise_uuids(const char *arg)
+void ad_advertise_uuids(DBusConnection *conn, const char *arg)
 {
 	g_strfreev(ad.uuids);
 	ad.uuids = NULL;
@@ -415,6 +415,8 @@ void ad_advertise_uuids(const char *arg)
 	}
 
 	ad.uuids_len = g_strv_length(ad.uuids);
+
+	g_dbus_emit_property_changed(conn, AD_PATH, AD_IFACE, "ServiceUUIDs");
 }
 
 static void ad_clear_service(void)
@@ -423,7 +425,7 @@ static void ad_clear_service(void)
 	memset(&ad.service, 0, sizeof(ad.service));
 }
 
-void ad_advertise_service(const char *arg)
+void ad_advertise_service(DBusConnection *conn, const char *arg)
 {
 	wordexp_t w;
 	unsigned int i;
@@ -462,6 +464,8 @@ void ad_advertise_service(const char *arg)
 		data->len++;
 	}
 
+	g_dbus_emit_property_changed(conn, AD_PATH, AD_IFACE, "ServiceData");
+
 done:
 	wordfree(&w);
 }
@@ -471,7 +475,7 @@ static void ad_clear_manufacturer(void)
 	memset(&ad.manufacturer, 0, sizeof(ad.manufacturer));
 }
 
-void ad_advertise_manufacturer(const char *arg)
+void ad_advertise_manufacturer(DBusConnection *conn, const char *arg)
 {
 	wordexp_t w;
 	unsigned int i;
@@ -515,39 +519,66 @@ void ad_advertise_manufacturer(const char *arg)
 		data->len++;
 	}
 
+	g_dbus_emit_property_changed(conn, AD_PATH, AD_IFACE,
+							"ManufacturerData");
+
 done:
 	wordfree(&w);
 }
 
-
-void ad_advertise_tx_power(bool value)
+void ad_advertise_tx_power(DBusConnection *conn, bool value)
 {
+	if (ad.tx_power == value)
+		return;
+
 	ad.tx_power = value;
+
+	g_dbus_emit_property_changed(conn, AD_PATH, AD_IFACE, "Includes");
 }
 
-void ad_advertise_name(bool value)
+void ad_advertise_name(DBusConnection *conn, bool value)
 {
+	if (ad.name == value)
+		return;
+
 	ad.name = value;
 
 	if (!value)
 		free(ad.local_name);
+
+	g_dbus_emit_property_changed(conn, AD_PATH, AD_IFACE, "Includes");
 }
 
-void ad_advertise_local_name(const char *name)
+void ad_advertise_local_name(DBusConnection *conn, const char *name)
 {
+	if (ad.local_name && !strcmp(name, ad.local_name))
+		return;
+
 	free(ad.local_name);
 	ad.local_name = strdup(name);
+
+	g_dbus_emit_property_changed(conn, AD_PATH, AD_IFACE, "LocalName");
 }
 
-void ad_advertise_appearance(bool value)
+void ad_advertise_appearance(DBusConnection *conn, bool value)
 {
+	if (ad.appearance == value)
+		return;
+
 	ad.appearance = value;
 
 	if (!value)
 		ad.local_appearance = UINT16_MAX;
+
+	g_dbus_emit_property_changed(conn, AD_PATH, AD_IFACE, "Includes");
 }
 
-void ad_advertise_local_appearance(uint16_t value)
+void ad_advertise_local_appearance(DBusConnection *conn, uint16_t value)
 {
+	if (ad.local_appearance == value)
+		return;
+
 	ad.local_appearance = value;
+
+	g_dbus_emit_property_changed(conn, AD_PATH, AD_IFACE, "Appearance");
 }
diff --git a/client/advertising.h b/client/advertising.h
index 5ea57adb3..6868518e7 100644
--- a/client/advertising.h
+++ b/client/advertising.h
@@ -24,11 +24,11 @@
 void ad_register(DBusConnection *conn, GDBusProxy *manager, const char *type);
 void ad_unregister(DBusConnection *conn, GDBusProxy *manager);
 
-void ad_advertise_uuids(const char *arg);
-void ad_advertise_service(const char *arg);
-void ad_advertise_manufacturer(const char *arg);
-void ad_advertise_tx_power(bool value);
-void ad_advertise_name(bool value);
-void ad_advertise_appearance(bool value);
-void ad_advertise_local_name(const char *name);
-void ad_advertise_local_appearance(uint16_t value);
+void ad_advertise_uuids(DBusConnection *conn, const char *arg);
+void ad_advertise_service(DBusConnection *conn, const char *arg);
+void ad_advertise_manufacturer(DBusConnection *conn, const char *arg);
+void ad_advertise_tx_power(DBusConnection *conn, bool value);
+void ad_advertise_name(DBusConnection *conn, bool value);
+void ad_advertise_appearance(DBusConnection *conn, bool value);
+void ad_advertise_local_name(DBusConnection *conn, const char *name);
+void ad_advertise_local_appearance(DBusConnection *conn, uint16_t value);
diff --git a/client/main.c b/client/main.c
index 6b1c73f99..276e7f184 100644
--- a/client/main.c
+++ b/client/main.c
@@ -2329,17 +2329,17 @@ static char *ad_generator(const char *text, int state)
 
 static void cmd_set_advertise_uuids(const char *arg)
 {
-	ad_advertise_uuids(arg);
+	ad_advertise_uuids(dbus_conn, arg);
 }
 
 static void cmd_set_advertise_service(const char *arg)
 {
-	ad_advertise_service(arg);
+	ad_advertise_service(dbus_conn, arg);
 }
 
 static void cmd_set_advertise_manufacturer(const char *arg)
 {
-	ad_advertise_manufacturer(arg);
+	ad_advertise_manufacturer(dbus_conn, arg);
 }
 
 static void cmd_set_advertise_tx_power(const char *arg)
@@ -2350,12 +2350,12 @@ static void cmd_set_advertise_tx_power(const char *arg)
 	}
 
 	if (strcmp(arg, "on") == 0 || strcmp(arg, "yes") == 0) {
-		ad_advertise_tx_power(true);
+		ad_advertise_tx_power(dbus_conn, true);
 		return;
 	}
 
 	if (strcmp(arg, "off") == 0 || strcmp(arg, "no") == 0) {
-		ad_advertise_tx_power(false);
+		ad_advertise_tx_power(dbus_conn, false);
 		return;
 	}
 
@@ -2370,16 +2370,16 @@ static void cmd_set_advertise_name(const char *arg)
 	}
 
 	if (strcmp(arg, "on") == 0 || strcmp(arg, "yes") == 0) {
-		ad_advertise_name(true);
+		ad_advertise_name(dbus_conn, true);
 		return;
 	}
 
 	if (strcmp(arg, "off") == 0 || strcmp(arg, "no") == 0) {
-		ad_advertise_name(false);
+		ad_advertise_name(dbus_conn, false);
 		return;
 	}
 
-	ad_advertise_local_name(arg);
+	ad_advertise_local_name(dbus_conn, arg);
 }
 
 static void cmd_set_advertise_appearance(const char *arg)
@@ -2393,12 +2393,12 @@ static void cmd_set_advertise_appearance(const char *arg)
 	}
 
 	if (strcmp(arg, "on") == 0 || strcmp(arg, "yes") == 0) {
-		ad_advertise_appearance(true);
+		ad_advertise_appearance(dbus_conn, true);
 		return;
 	}
 
 	if (strcmp(arg, "off") == 0 || strcmp(arg, "no") == 0) {
-		ad_advertise_appearance(false);
+		ad_advertise_appearance(dbus_conn, false);
 		return;
 	}
 
@@ -2408,7 +2408,7 @@ static void cmd_set_advertise_appearance(const char *arg)
 		return;
 	}
 
-	ad_advertise_local_appearance(value);
+	ad_advertise_local_appearance(dbus_conn, value);
 }
 
 static const struct {
-- 
2.13.4

