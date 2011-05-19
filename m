Return-Path: <cyrus@holtmann.org>
From: Rafal Michalski <michalski.raf@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Rafal Michalski <michalski.raf@gmail.com>
Subject: [PATCH v2] Fix disconnect devices after enabling offline mode
Date: Thu, 19 May 2011 10:12:20 +0200
Message-Id: <1305792740-32536-1-git-send-email-michalski.raf@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Previously paired and connected devices were disconnected automatically
after turning bluetooth off directly via bluetooth UI. This patch makes
that also other ways of turning bluetooth off (which should lead to
disconnecting paired and connected devices), such as enabling offline
mode (which turns bluetooth off as well), can be handled properly.
---
 plugins/maemo6.c |   49 ++++++++++++++++++++++++++++++++++++++++++++-----
 src/adapter.c    |    5 +++++
 src/adapter.h    |    1 +
 3 files changed, 50 insertions(+), 5 deletions(-)

diff --git a/plugins/maemo6.c b/plugins/maemo6.c
index 56f2664..851f6e1 100644
--- a/plugins/maemo6.c
+++ b/plugins/maemo6.c
@@ -30,6 +30,7 @@
 #include <dbus/dbus.h>
 
 #include "adapter.h"
+#include "device.h"
 #include "plugin.h"
 #include "log.h"
 #include "gdbus.h"
@@ -52,12 +53,33 @@ static DBusConnection *conn = NULL;
 static gboolean mce_bt_set = FALSE;
 static gboolean collision = FALSE;
 
+static struct maemo6 {
+	struct btd_adapter *adapter;
+	guint timer_id;
+} *maemo6_adapter_data = NULL;
+
+static void disconnect_device(struct btd_device *device, gpointer user_data)
+{
+	device_request_disconnect(device, NULL);
+}
+
+static gboolean switch_off_timeout(gpointer user_data)
+{
+	struct maemo6 *maemo6_adapter = user_data;
+	btd_adapter_switch_offline(maemo6_adapter->adapter);
+	maemo6_adapter->timer_id = 0;
+
+	return FALSE;
+}
+
 static gboolean mce_signal_callback(DBusConnection *connection,
 					DBusMessage *message, void *user_data)
 {
 	DBusMessageIter args;
 	uint32_t sigvalue;
-	struct btd_adapter *adapter = user_data;
+	struct maemo6 *maemo6_adapter = user_data;
+	GSList *connections =
+		adapter_get_connected_device_list(maemo6_adapter->adapter);
 
 	DBG("received mce signal");
 
@@ -74,10 +96,20 @@ static gboolean mce_signal_callback(DBusConnection *connection,
 		mce_bt_set = sigvalue & MCE_RADIO_STATE_BLUETOOTH ?
 								TRUE : FALSE;
 
+		if (maemo6_adapter->timer_id) {
+			g_source_remove(maemo6_adapter->timer_id);
+			maemo6_adapter->timer_id = 0;
+		}
+
 		if (mce_bt_set)
-			btd_adapter_switch_online(adapter);
-		else
-			btd_adapter_switch_offline(adapter);
+			btd_adapter_switch_online(maemo6_adapter->adapter);
+		else if (connections) {
+			g_slist_foreach(connections,
+					(GFunc) disconnect_device, NULL);
+			maemo6_adapter->timer_id = g_timeout_add_seconds(3,
+					switch_off_timeout, maemo6_adapter);
+		} else
+			btd_adapter_switch_offline(maemo6_adapter->adapter);
 	}
 
 	return TRUE;
@@ -200,9 +232,13 @@ static int mce_probe(struct btd_adapter *adapter)
 	dbus_pending_call_unref(call);
 	dbus_message_unref(msg);
 
+	maemo6_adapter_data = g_new0(struct maemo6, 1);
+	maemo6_adapter_data->adapter = adapter;
+
 	watch_id = g_dbus_add_signal_watch(conn, NULL, MCE_SIGNAL_PATH,
 					MCE_SIGNAL_IF, MCE_RADIO_STATES_SIG,
-					mce_signal_callback, adapter, NULL);
+					mce_signal_callback,
+					maemo6_adapter_data, NULL);
 
 	btd_adapter_register_powered_callback(adapter, adapter_powered);
 
@@ -216,6 +252,9 @@ static void mce_remove(struct btd_adapter *adapter)
 	if (watch_id > 0)
 		g_dbus_remove_watch(conn, watch_id);
 
+	g_free(maemo6_adapter_data);
+	maemo6_adapter_data = NULL;
+
 	btd_adapter_unregister_powered_callback(adapter, adapter_powered);
 }
 
diff --git a/src/adapter.c b/src/adapter.c
index c30febc..736c1b3 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -1192,6 +1192,11 @@ struct btd_device *adapter_get_device(DBusConnection *conn,
 						DEVICE_TYPE_BREDR);
 }
 
+GSList *adapter_get_connected_device_list(struct btd_adapter *adapter)
+{
+	return adapter->connections;
+}
+
 static int start_discovery(struct btd_adapter *adapter)
 {
 	/* Do not start if suspended */
diff --git a/src/adapter.h b/src/adapter.h
index 3526849..313ffd3 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -106,6 +106,7 @@ void adapter_get_address(struct btd_adapter *adapter, bdaddr_t *bdaddr);
 void adapter_set_state(struct btd_adapter *adapter, int state);
 int adapter_get_state(struct btd_adapter *adapter);
 int adapter_get_discover_type(struct btd_adapter *adapter);
+GSList *adapter_get_connected_device_list(struct btd_adapter *adapter);
 struct remote_dev_info *adapter_search_found_devices(struct btd_adapter *adapter,
 						struct remote_dev_info *match);
 void adapter_update_found_devices(struct btd_adapter *adapter, bdaddr_t *bdaddr,
-- 
1.6.3.3

