Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 06/10] telephony-ofono: fix not canceling pending calls on exit
Date: Wed,  5 Jan 2011 17:59:43 +0200
Message-Id: <1294243187-1849-7-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1294243187-1849-1-git-send-email-luiz.dentz@gmail.com>
References: <1294243187-1849-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

---
 audio/telephony-ofono.c |   19 ++++++++++++++++++-
 1 files changed, 18 insertions(+), 1 deletions(-)

diff --git a/audio/telephony-ofono.c b/audio/telephony-ofono.c
index e1b6422..c554305 100644
--- a/audio/telephony-ofono.c
+++ b/audio/telephony-ofono.c
@@ -56,6 +56,7 @@ static DBusConnection *connection = NULL;
 static char *modem_obj_path = NULL;
 static char *last_dialed_number = NULL;
 static GSList *calls = NULL;
+static GSList *pending = NULL;
 
 #define OFONO_BUS_NAME "org.ofono"
 #define OFONO_PATH "/"
@@ -226,7 +227,7 @@ static int send_method_call(const char *dest, const char *path,
 	}
 
 	dbus_pending_call_set_notify(call, cb, user_data, NULL);
-	dbus_pending_call_unref(call);
+	pending = g_slist_prepend(pending, call);
 	dbus_message_unref(msg);
 
 	return 0;
@@ -610,6 +611,12 @@ static struct voice_call *call_new(const char *path, DBusMessageIter *properties
 	return vc;
 }
 
+static void remove_pending(DBusPendingCall *call)
+{
+	pending = g_slist_remove(pending, call);
+	dbus_pending_call_unref(call);
+}
+
 static void call_added(const char *path, DBusMessageIter *properties)
 {
 	struct voice_call *vc;
@@ -668,6 +675,7 @@ static void get_calls_reply(DBusPendingCall *call, void *user_data)
 
 done:
 	dbus_message_unref(reply);
+	remove_pending(call);
 }
 
 static void handle_network_property(const char *property, DBusMessageIter *variant)
@@ -783,6 +791,7 @@ static void get_properties_reply(DBusPendingCall *call, void *user_data)
 
 done:
 	dbus_message_unref(reply);
+	remove_pending(call);
 }
 
 static void modem_added(const char *path)
@@ -842,6 +851,7 @@ static void get_modems_reply(DBusPendingCall *call, void *user_data)
 
 done:
 	dbus_message_unref(reply);
+	remove_pending(call);
 }
 
 static gboolean handle_network_property_changed(DBusConnection *conn,
@@ -1052,6 +1062,7 @@ static void hal_battery_level_reply(DBusPendingCall *call, void *user_data)
 	}
 done:
 	dbus_message_unref(reply);
+	remove_pending(call);
 }
 
 static void hal_get_integer(const char *path, const char *key, void *user_data)
@@ -1170,6 +1181,7 @@ static void hal_find_device_reply(DBusPendingCall *call, void *user_data)
 	hal_get_integer(path, "battery.charge_level.design", &battchg_design);
 done:
 	dbus_message_unref(reply);
+	remove_pending(call);
 }
 
 int telephony_init(void)
@@ -1252,6 +1264,11 @@ void telephony_exit(void)
 	g_dbus_remove_watch(connection, call_removed_watch);
 	g_dbus_remove_watch(connection, device_watch);
 
+	g_slist_foreach(pending, (GFunc) dbus_pending_call_cancel, NULL);
+	g_slist_foreach(pending, (GFunc) dbus_pending_call_unref, NULL);
+	g_slist_free(pending);
+	pending = NULL;
+
 	dbus_connection_unref(connection);
 	connection = NULL;
 
-- 
1.7.1

