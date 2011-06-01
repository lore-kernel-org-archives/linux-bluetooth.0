Return-Path: <cyrus@holtmann.org>
From: Rafal Michalski <michalski.raf@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Rafal Michalski <michalski.raf@gmail.com>
Subject: [PATCH v4] Fix disconnect devices after enabling offline mode
Date: Wed,  1 Jun 2011 10:49:49 +0200
Message-Id: <1306918189-2333-1-git-send-email-michalski.raf@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Previously paired and connected devices were disconnected automatically
after turning bluetooth off directly via bluetooth UI. This patch makes
that also other ways of turning bluetooth off (which should lead to
disconnecting paired and connected devices), such as enabling offline
mode (which turns bluetooth off as well), can be handled properly.
---
 plugins/maemo6.c |    4 ++--
 src/adapter.c    |   47 ++++++++++++++++++++++++++++++++++++++++++++++-
 src/adapter.h    |    2 +-
 3 files changed, 49 insertions(+), 4 deletions(-)

diff --git a/plugins/maemo6.c b/plugins/maemo6.c
index 56f2664..d16ac9f 100644
--- a/plugins/maemo6.c
+++ b/plugins/maemo6.c
@@ -77,7 +77,7 @@ static gboolean mce_signal_callback(DBusConnection *connection,
 		if (mce_bt_set)
 			btd_adapter_switch_online(adapter);
 		else
-			btd_adapter_switch_offline(adapter);
+			btd_adapter_switch_offline(adapter, TRUE);
 	}
 
 	return TRUE;
@@ -124,7 +124,7 @@ static void read_radio_states_cb(DBusPendingCall *call, void *user_data)
 	if (mce_bt_set)
 		btd_adapter_switch_online(adapter);
 	else
-		btd_adapter_switch_offline(adapter);
+		btd_adapter_switch_offline(adapter, TRUE);
 
 done:
 	dbus_message_unref(reply);
diff --git a/src/adapter.c b/src/adapter.c
index c30febc..12c0174 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -77,6 +77,8 @@
 
 #define check_address(address) bachk(address)
 
+#define OFF_TIMER 3
+
 static DBusConnection *connection = NULL;
 static GSList *adapter_drivers = NULL;
 
@@ -142,6 +144,8 @@ struct btd_adapter {
 
 	gint ref;
 
+	guint off_timer;
+
 	GSList *powered_callbacks;
 
 	gboolean name_stored;
@@ -2331,6 +2335,7 @@ void btd_adapter_start(struct btd_adapter *adapter)
 	adapter->pairable_timeout = get_pairable_timeout(address);
 	adapter->state = STATE_IDLE;
 	adapter->mode = MODE_CONNECTABLE;
+	adapter->off_timer = 0;
 
 	if (main_opts.le)
 		adapter_ops->enable_le(adapter->dev_id);
@@ -2504,6 +2509,12 @@ int btd_adapter_stop(struct btd_adapter *adapter)
 	return 0;
 }
 
+static void off_timer_free(struct btd_adapter *adapter)
+{
+	g_source_remove(adapter->off_timer);
+	adapter->off_timer = 0;
+}
+
 static void adapter_free(gpointer user_data)
 {
 	struct btd_adapter *adapter = user_data;
@@ -2516,6 +2527,9 @@ static void adapter_free(gpointer user_data)
 	if (adapter->auth_idle_id)
 		g_source_remove(adapter->auth_idle_id);
 
+	if (adapter->off_timer)
+		off_timer_free(adapter);
+
 	sdp_list_free(adapter->services, NULL);
 
 	g_slist_foreach(adapter->found_devices, (GFunc) dev_info_free, NULL);
@@ -3454,6 +3468,21 @@ int btd_adapter_restore_powered(struct btd_adapter *adapter)
 	return adapter_ops->set_powered(adapter->dev_id, TRUE);
 }
 
+static void disconnect_device(struct btd_device *device, gpointer user_data)
+{
+	device_request_disconnect(device, NULL);
+}
+
+static gboolean switch_off_timeout(gpointer user_data)
+{
+	struct btd_adapter *adapter = user_data;
+
+	adapter_ops->set_powered(adapter->dev_id, FALSE);
+	adapter->off_timer = 0;
+
+	return FALSE;
+}
+
 int btd_adapter_switch_online(struct btd_adapter *adapter)
 {
 	if (!adapter_ops)
@@ -3462,10 +3491,13 @@ int btd_adapter_switch_online(struct btd_adapter *adapter)
 	if (adapter->up)
 		return 0;
 
+	if (adapter->off_timer)
+		off_timer_free(adapter);
+
 	return adapter_ops->set_powered(adapter->dev_id, TRUE);
 }
 
-int btd_adapter_switch_offline(struct btd_adapter *adapter)
+int btd_adapter_switch_offline(struct btd_adapter *adapter, gboolean clean)
 {
 	if (!adapter_ops)
 		return -EINVAL;
@@ -3473,6 +3505,19 @@ int btd_adapter_switch_offline(struct btd_adapter *adapter)
 	if (!adapter->up)
 		return 0;
 
+	if (adapter->off_timer)
+		return 0;
+
+	if (clean && adapter->connections) {
+		g_slist_foreach(adapter->connections,
+					(GFunc) disconnect_device, NULL);
+
+		adapter->off_timer = g_timeout_add_seconds(OFF_TIMER,
+					switch_off_timeout, adapter);
+
+		return 0;
+	}
+
 	return adapter_ops->set_powered(adapter->dev_id, FALSE);
 }
 
diff --git a/src/adapter.h b/src/adapter.h
index 3526849..ca40a1a 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -161,7 +161,7 @@ gboolean adapter_powering_down(struct btd_adapter *adapter);
 
 int btd_adapter_restore_powered(struct btd_adapter *adapter);
 int btd_adapter_switch_online(struct btd_adapter *adapter);
-int btd_adapter_switch_offline(struct btd_adapter *adapter);
+int btd_adapter_switch_offline(struct btd_adapter *adapter, gboolean clean);
 
 typedef void (*bt_hci_result_t) (uint8_t status, gpointer user_data);
 
-- 
1.6.3.3

