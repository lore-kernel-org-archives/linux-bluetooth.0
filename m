Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Briglia <anderson.briglia@openbossa.org>
Subject: [PATCH BlueZ 07/11] Add display lock watcher on maemo6 plugin
Date: Mon, 26 Sep 2011 14:48:24 -0300
Message-Id: <1317059308-20038-8-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1317059308-20038-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1317059308-20038-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Anderson Briglia <anderson.briglia@openbossa.org>

Implements display status signal watcher in maemo6 plugin.
---
 plugins/maemo6.c |   28 ++++++++++++++++++++++++++++
 1 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/plugins/maemo6.c b/plugins/maemo6.c
index 00fb3fa..e380acd 100644
--- a/plugins/maemo6.c
+++ b/plugins/maemo6.c
@@ -46,12 +46,33 @@
 #define MCE_RADIO_STATES_CHANGE_REQ	"req_radio_states_change"
 #define MCE_RADIO_STATES_GET		"get_radio_states"
 #define MCE_RADIO_STATES_SIG		"radio_states_ind"
+#define MCE_TKLOCK_MODE_SIG		"tklock_mode_ind"
 
 static guint watch_id;
+static guint tklock_watch_id;
 static DBusConnection *conn = NULL;
 static gboolean mce_bt_set = FALSE;
 static gboolean mce_bt_on = FALSE;
 
+static gboolean mce_tklock_mode_cb(DBusConnection *connection,
+					DBusMessage *message, void *user_data)
+{
+	DBusMessageIter args;
+	const char *sigvalue;
+
+	if (!dbus_message_iter_init(message, &args)) {
+		error("message has no arguments");
+	} else if (dbus_message_iter_get_arg_type(&args) != DBUS_TYPE_STRING) {
+		error("argument is not string");
+	} else {
+
+		dbus_message_iter_get_basic(&args, &sigvalue);
+		DBG("got signal with value %s", sigvalue);
+	}
+
+	return TRUE;
+}
+
 static gboolean mce_signal_callback(DBusConnection *connection,
 					DBusMessage *message, void *user_data)
 {
@@ -204,6 +225,10 @@ static int mce_probe(struct btd_adapter *adapter)
 					MCE_SIGNAL_IF, MCE_RADIO_STATES_SIG,
 					mce_signal_callback, adapter, NULL);
 
+	tklock_watch_id = g_dbus_add_signal_watch(conn, NULL, MCE_SIGNAL_PATH,
+					MCE_SIGNAL_IF, MCE_TKLOCK_MODE_SIG,
+					mce_tklock_mode_cb, adapter, NULL);
+
 	btd_adapter_register_powered_callback(adapter, adapter_powered);
 
 	return 0;
@@ -216,6 +241,9 @@ static void mce_remove(struct btd_adapter *adapter)
 	if (watch_id > 0)
 		g_dbus_remove_watch(conn, watch_id);
 
+	if (tklock_watch_id > 0)
+		g_dbus_remove_watch(conn, tklock_watch_id);
+
 	btd_adapter_unregister_powered_callback(adapter, adapter_powered);
 }
 
-- 
1.7.6.1

