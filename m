Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: [PATCH BlueZ 6/7] client: Introduce
 ad_disable_{uuids,service,manufacturer}
From: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <1b7b4b83-e67a-c23a-8da3-9b86cc0b275e@jp.fujitsu.com>
Message-ID: <6dd38981-a3d2-2b53-1337-8a4465dd041a@jp.fujitsu.com>
Date: Fri, 16 Feb 2018 14:51:37 +0900
MIME-Version: 1.0
In-Reply-To: <1b7b4b83-e67a-c23a-8da3-9b86cc0b275e@jp.fujitsu.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 client/advertising.c | 39 ++++++++++++++++++++++++++++++++++++---
 client/advertising.h |  3 +++
 2 files changed, 39 insertions(+), 3 deletions(-)

diff --git a/client/advertising.c b/client/advertising.c
index f1b08c0b6..3cfc318ba 100644
--- a/client/advertising.c
+++ b/client/advertising.c
@@ -507,6 +507,13 @@ void ad_unregister(DBusConnection *conn, GDBusProxy *manager)
 	}
 }
 
+static void ad_clear_uuids(void)
+{
+	g_strfreev(ad.uuids);
+	ad.uuids = NULL;
+	ad.uuids_len = 0;
+}
+
 void ad_advertise_uuids(DBusConnection *conn, int argc, char *argv[])
 {
 	if (argc < 2 || !strlen(argv[1])) {
@@ -514,9 +521,7 @@ void ad_advertise_uuids(DBusConnection *conn, int argc, char *argv[])
 		return;
 	}
 
-	g_strfreev(ad.uuids);
-	ad.uuids = NULL;
-	ad.uuids_len = 0;
+	ad_clear_uuids();
 
 	ad.uuids = g_strdupv(&argv[1]);
 	if (!ad.uuids) {
@@ -529,6 +534,15 @@ void ad_advertise_uuids(DBusConnection *conn, int argc, char *argv[])
 	g_dbus_emit_property_changed(conn, AD_PATH, AD_IFACE, "ServiceUUIDs");
 }
 
+void ad_disable_uuids(DBusConnection *conn)
+{
+	if (!ad.uuids)
+		return;
+
+	ad_clear_uuids();
+	g_dbus_emit_property_changed(conn, AD_PATH, AD_IFACE, "ServiceUUIDs");
+}
+
 static void ad_clear_service(void)
 {
 	g_free(ad.service.uuid);
@@ -578,6 +592,15 @@ void ad_advertise_service(DBusConnection *conn, int argc, char *argv[])
 	g_dbus_emit_property_changed(conn, AD_PATH, AD_IFACE, "ServiceData");
 }
 
+void ad_disable_service(DBusConnection *conn)
+{
+	if (!ad.service.uuid)
+		return;
+
+	ad_clear_service();
+	g_dbus_emit_property_changed(conn, AD_PATH, AD_IFACE, "ServiceData");
+}
+
 static void ad_clear_manufacturer(void)
 {
 	memset(&ad.manufacturer, 0, sizeof(ad.manufacturer));
@@ -634,6 +657,16 @@ void ad_advertise_manufacturer(DBusConnection *conn, int argc, char *argv[])
 							"ManufacturerData");
 }
 
+void ad_disable_manufacturer(DBusConnection *conn)
+{
+	if (!ad.manufacturer.id && !ad.manufacturer.data.len)
+		return;
+
+	ad_clear_manufacturer();
+	g_dbus_emit_property_changed(conn, AD_PATH, AD_IFACE,
+							"ManufacturerData");
+}
+
 void ad_advertise_tx_power(DBusConnection *conn, dbus_bool_t *value)
 {
 	if (!value) {
diff --git a/client/advertising.h b/client/advertising.h
index 13e076438..b73d33b13 100644
--- a/client/advertising.h
+++ b/client/advertising.h
@@ -25,8 +25,11 @@ void ad_register(DBusConnection *conn, GDBusProxy *manager, const char *type);
 void ad_unregister(DBusConnection *conn, GDBusProxy *manager);
 
 void ad_advertise_uuids(DBusConnection *conn, int argc, char *argv[]);
+void ad_disable_uuids(DBusConnection *conn);
 void ad_advertise_service(DBusConnection *conn, int argc, char *argv[]);
+void ad_disable_service(DBusConnection *conn);
 void ad_advertise_manufacturer(DBusConnection *conn, int argc, char *argv[]);
+void ad_disable_manufacturer(DBusConnection *conn);
 void ad_advertise_tx_power(DBusConnection *conn, dbus_bool_t *value);
 void ad_advertise_name(DBusConnection *conn, bool value);
 void ad_advertise_appearance(DBusConnection *conn, bool value);
-- 
2.14.1

