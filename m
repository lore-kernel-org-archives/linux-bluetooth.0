Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 07/10] telephony-ofono: simplify watches handling logic
Date: Wed,  5 Jan 2011 17:59:44 +0200
Message-Id: <1294243187-1849-8-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1294243187-1849-1-git-send-email-luiz.dentz@gmail.com>
References: <1294243187-1849-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

---
 audio/telephony-ofono.c |   85 ++++++++++++++++++----------------------------
 1 files changed, 33 insertions(+), 52 deletions(-)

diff --git a/audio/telephony-ofono.c b/audio/telephony-ofono.c
index c554305..00b24f9 100644
--- a/audio/telephony-ofono.c
+++ b/audio/telephony-ofono.c
@@ -56,6 +56,7 @@ static DBusConnection *connection = NULL;
 static char *modem_obj_path = NULL;
 static char *last_dialed_number = NULL;
 static GSList *calls = NULL;
+static GSList *watches = NULL;
 static GSList *pending = NULL;
 
 #define OFONO_BUS_NAME "org.ofono"
@@ -65,13 +66,6 @@ static GSList *pending = NULL;
 #define OFONO_VCMANAGER_INTERFACE "org.ofono.VoiceCallManager"
 #define OFONO_VC_INTERFACE "org.ofono.VoiceCall"
 
-static guint registration_watch = 0;
-static guint device_watch = 0;
-static guint modem_added_watch = 0;
-static guint modem_removed_watch = 0;
-static guint call_added_watch = 0;
-static guint call_removed_watch = 0;
-
 /* HAL battery namespace key values */
 static int battchg_cur = -1;    /* "battery.charge_level.current" */
 static int battchg_last = -1;   /* "battery.charge_level.last_full" */
@@ -1130,6 +1124,18 @@ static gboolean handle_hal_property_modified(DBusConnection *conn,
 	return TRUE;
 }
 
+static void add_watch(const char *sender, const char *path,
+				const char *interface, const char *member,
+				GDBusSignalFunction function)
+{
+	guint watch;
+
+	watch = g_dbus_add_signal_watch(connection, sender, path, interface,
+					member, function, NULL, NULL);
+
+	watches = g_slist_prepend(watches, GUINT_TO_POINTER(watch));
+}
+
 static void hal_find_device_reply(DBusPendingCall *call, void *user_data)
 {
 	DBusMessage *reply;
@@ -1170,11 +1176,8 @@ static void hal_find_device_reply(DBusPendingCall *call, void *user_data)
 
 	DBG("telephony-ofono: found battery device at %s", path);
 
-	device_watch = g_dbus_add_signal_watch(connection, NULL, path,
-					"org.freedesktop.Hal.Device",
-					"PropertyModified",
-					handle_hal_property_modified,
-					NULL, NULL);
+	add_watch(NULL, path, "org.freedesktop.Hal.Device",
+			"PropertyModified", handle_hal_property_modified);
 
 	hal_get_integer(path, "battery.charge_level.last_full", &battchg_last);
 	hal_get_integer(path, "battery.charge_level.current", &battchg_cur);
@@ -1191,40 +1194,16 @@ int telephony_init(void)
 
 	connection = dbus_bus_get(DBUS_BUS_SYSTEM, NULL);
 
-
-	registration_watch = g_dbus_add_signal_watch(connection,
-						OFONO_BUS_NAME, NULL,
-						OFONO_NETWORKREG_INTERFACE,
-						"PropertyChanged",
-						handle_network_property_changed,
-						NULL, NULL);
-
-	modem_added_watch = g_dbus_add_signal_watch(connection,
-						OFONO_BUS_NAME, NULL,
-						OFONO_MANAGER_INTERFACE,
-						"ModemAdded",
-						handle_manager_modem_added,
-						NULL, NULL);
-
-	modem_removed_watch = g_dbus_add_signal_watch(connection,
-						OFONO_BUS_NAME, NULL,
-						OFONO_MANAGER_INTERFACE,
-						"ModemRemoved",
-						handle_manager_modem_removed,
-						NULL, NULL);
-	call_added_watch = g_dbus_add_signal_watch(connection,
-						OFONO_BUS_NAME, NULL,
-						OFONO_VCMANAGER_INTERFACE,
-						"CallAdded",
-						handle_vcmanager_call_added,
-						NULL, NULL);
-
-	call_removed_watch = g_dbus_add_signal_watch(connection,
-						OFONO_BUS_NAME, NULL,
-						OFONO_VCMANAGER_INTERFACE,
-						"CallRemoved",
-						handle_vcmanager_call_removed,
-						NULL, NULL);
+	add_watch(OFONO_BUS_NAME, NULL, OFONO_NETWORKREG_INTERFACE,
+			"PropertyChanged", handle_network_property_changed);
+	add_watch(OFONO_BUS_NAME, NULL, OFONO_MANAGER_INTERFACE,
+			"ModemAdded", handle_manager_modem_added);
+	add_watch(OFONO_BUS_NAME, NULL, OFONO_MANAGER_INTERFACE,
+			"ModemRemoved", handle_manager_modem_removed);
+	add_watch(OFONO_BUS_NAME, NULL, OFONO_VCMANAGER_INTERFACE,
+			"CallAdded", handle_vcmanager_call_added);
+	add_watch(OFONO_BUS_NAME, NULL, OFONO_VCMANAGER_INTERFACE,
+			"CallRemoved", handle_vcmanager_call_removed);
 
 	ret = send_method_call(OFONO_BUS_NAME, OFONO_PATH,
 				OFONO_MANAGER_INTERFACE, "GetModems",
@@ -1247,6 +1226,11 @@ int telephony_init(void)
 	return ret;
 }
 
+static void remove_watch(gpointer data)
+{
+	g_dbus_remove_watch(connection, GPOINTER_TO_UINT(data));
+}
+
 void telephony_exit(void)
 {
 	DBG("");
@@ -1257,12 +1241,9 @@ void telephony_exit(void)
 	if (modem_obj_path)
 		modem_removed(modem_obj_path);
 
-	g_dbus_remove_watch(connection, registration_watch);
-	g_dbus_remove_watch(connection, modem_added_watch);
-	g_dbus_remove_watch(connection, modem_removed_watch);
-	g_dbus_remove_watch(connection, call_added_watch);
-	g_dbus_remove_watch(connection, call_removed_watch);
-	g_dbus_remove_watch(connection, device_watch);
+	g_slist_foreach(watches, (GFunc) remove_watch, NULL);
+	g_slist_free(watches);
+	watches = NULL;
 
 	g_slist_foreach(pending, (GFunc) dbus_pending_call_cancel, NULL);
 	g_slist_foreach(pending, (GFunc) dbus_pending_call_unref, NULL);
-- 
1.7.1

