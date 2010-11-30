Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/3] Fix not canceling pending calls on maemo6 telephony driver exit
Date: Tue, 30 Nov 2010 14:26:15 +0200
Message-Id: <1291119975-9460-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1291119975-9460-1-git-send-email-luiz.dentz@gmail.com>
References: <1291119975-9460-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

This happens when the driver exit is called quickly after init due to
adapter power changes.
---
 audio/telephony-maemo6.c |   21 ++++++++++++++++++++-
 1 files changed, 20 insertions(+), 1 deletions(-)

diff --git a/audio/telephony-maemo6.c b/audio/telephony-maemo6.c
index 7853bae..bfd3ba1 100644
--- a/audio/telephony-maemo6.c
+++ b/audio/telephony-maemo6.c
@@ -150,6 +150,7 @@ static DBusConnection *connection = NULL;
 
 static GSList *calls = NULL;
 static GSList *watches = NULL;
+static GSList *pending = NULL;
 
 /* Reference count for determining the call indicator status */
 static GSList *active_calls = NULL;
@@ -592,7 +593,7 @@ static int send_method_call(const char *dest, const char *path,
 	}
 
 	dbus_pending_call_set_notify(call, cb, user_data, NULL);
-	dbus_pending_call_unref(call);
+	pending = g_slist_prepend(pending, call);
 	dbus_message_unref(msg);
 
 	return 0;
@@ -1312,6 +1313,12 @@ static gboolean iter_get_basic_args(DBusMessageIter *iter,
 	return type == DBUS_TYPE_INVALID ? TRUE : FALSE;
 }
 
+static void remove_pending(DBusPendingCall *call)
+{
+	pending = g_slist_remove(pending, call);
+	dbus_pending_call_unref(call);
+}
+
 static void hal_battery_level_reply(DBusPendingCall *call, void *user_data)
 {
 	DBusError err;
@@ -1360,8 +1367,10 @@ static void hal_battery_level_reply(DBusPendingCall *call, void *user_data)
 
 		telephony_update_indicator(maemo_indicators, "battchg", new);
 	}
+
 done:
 	dbus_message_unref(reply);
+	remove_pending(call);
 }
 
 static void hal_get_integer(const char *path, const char *key, void *user_data)
@@ -1556,6 +1565,7 @@ static void get_property_reply(DBusPendingCall *call, void *user_data)
 done:
 	g_free(prop);
 	dbus_message_unref(reply);
+	remove_pending(call);
 }
 
 static int get_property(const char *iface, const char *prop)
@@ -1615,6 +1625,7 @@ static void call_info_reply(DBusPendingCall *call, void *user_data)
 
 done:
 	dbus_message_unref(reply);
+	remove_pending(call);
 }
 
 
@@ -1665,6 +1676,7 @@ static void phonebook_read_reply(DBusPendingCall *call, void *user_data)
 
 done:
 	dbus_message_unref(reply);
+	remove_pending(call);
 }
 
 static void csd_init(void)
@@ -1843,6 +1855,7 @@ static void modem_state_reply(DBusPendingCall *call, void *user_data)
 		handle_modem_state(reply);
 
 	dbus_message_unref(reply);
+	remove_pending(call);
 }
 
 static gboolean signal_filter(DBusConnection *conn, DBusMessage *msg,
@@ -1940,6 +1953,7 @@ static void hal_find_device_reply(DBusPendingCall *call, void *user_data)
 
 done:
 	dbus_message_unref(reply);
+	remove_pending(call);
 }
 
 int telephony_init(void)
@@ -2016,6 +2030,11 @@ void telephony_exit(void)
 	g_slist_free(calls);
 	calls = NULL;
 
+	g_slist_foreach(pending, (GFunc) dbus_pending_call_cancel, NULL);
+	g_slist_foreach(pending, (GFunc) remove_pending, NULL);
+	g_slist_free(pending);
+	pending = NULL;
+
 	g_slist_foreach(watches, (GFunc) remove_watch, NULL);
 	g_slist_free(watches);
 	watches = NULL;
-- 
1.7.1

