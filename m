Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/3] tools/mpris-player: Forward player signals
Date: Fri, 11 Oct 2013 14:53:24 +0300
Message-Id: <1381492404-25765-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1381492404-25765-1-git-send-email-luiz.dentz@gmail.com>
References: <1381492404-25765-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Forward signals received from player in the session bus to the system
bus where bluetoothd can catch them.
---
 tools/mpris-player.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/tools/mpris-player.c b/tools/mpris-player.c
index 03b8875..c94330c 100644
--- a/tools/mpris-player.c
+++ b/tools/mpris-player.c
@@ -543,8 +543,8 @@ static void remove_player(DBusConnection *conn, const char *sender)
 	g_free(owner);
 }
 
-static gboolean properties_changed(DBusConnection *conn,
-					DBusMessage *msg, void *user_data)
+static gboolean player_signal(DBusConnection *conn, DBusMessage *msg,
+								void *user_data)
 {
 	DBusMessage *signal;
 	DBusMessageIter iter, args;
@@ -558,17 +558,15 @@ static gboolean properties_changed(DBusConnection *conn,
 	if (owner == NULL)
 		goto done;
 
-	signal = dbus_message_new_signal(path, DBUS_INTERFACE_PROPERTIES,
-							"PropertiesChanged");
+	signal = dbus_message_new_signal(path, dbus_message_get_interface(msg),
+						dbus_message_get_member(msg));
 	if (signal == NULL) {
-		fprintf(stderr, "Unable to allocate new %s.PropertisChanged"
-					" signal", DBUS_INTERFACE_PROPERTIES);
+		fprintf(stderr, "Unable to allocate new %s.%s signal",
+						dbus_message_get_interface(msg),
+						dbus_message_get_member(msg));
 		goto done;
 	}
 
-	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_STRING)
-		return DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
-
 	dbus_message_iter_init_append(signal, &args);
 
 	append_iter(&args, &iter);
@@ -2512,7 +2510,7 @@ int main(int argc, char *argv[])
 {
 	GOptionContext *context;
 	GError *error = NULL;
-	guint owner_watch, properties_watch;
+	guint owner_watch, properties_watch, signal_watch;
 	struct sigaction sa;
 
 	context = g_option_context_new(NULL);
@@ -2554,10 +2552,14 @@ int main(int argc, char *argv[])
 						name_owner_changed,
 						NULL, NULL);
 
-
 	properties_watch = g_dbus_add_properties_watch(session, NULL, NULL,
 							MPRIS_PLAYER_INTERFACE,
-							properties_changed,
+							player_signal,
+							NULL, NULL);
+
+	signal_watch = g_dbus_add_signal_watch(session, NULL, NULL,
+							MPRIS_PLAYER_INTERFACE,
+							NULL, player_signal,
 							NULL, NULL);
 
 	memset(&sa, 0, sizeof(sa));
@@ -2578,6 +2580,7 @@ int main(int argc, char *argv[])
 
 	g_dbus_remove_watch(session, owner_watch);
 	g_dbus_remove_watch(session, properties_watch);
+	g_dbus_remove_watch(session, signal_watch);
 
 	g_dbus_client_unref(client);
 
-- 
1.8.3.1

