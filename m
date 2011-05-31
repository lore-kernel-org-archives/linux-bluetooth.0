Return-Path: <cyrus@holtmann.org>
From: Rafal Michalski <michalski.raf@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Rafal Michalski <michalski.raf@gmail.com>
Subject: [PATCH v3] Fix disconnect devices after enabling offline mode
Date: Tue, 31 May 2011 15:37:10 +0200
Message-Id: <1306849030-12332-1-git-send-email-michalski.raf@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Previously paired and connected devices were disconnected automatically
after turning bluetooth off directly via bluetooth UI. This patch makes
that also other ways of turning bluetooth off (which should lead to
disconnecting paired and connected devices), such as enabling offline
mode (which turns bluetooth off as well), can be handled properly.
---
 plugins/maemo6.c |    4 ++--
 src/adapter.c    |   38 +++++++++++++++++++++++++++++++++++++-
 src/adapter.h    |    2 +-
 3 files changed, 40 insertions(+), 4 deletions(-)

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
index c30febc..60f03dc 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -142,6 +142,8 @@ struct btd_adapter {
 
 	gint ref;
 
+	guint timer_id;
+
 	GSList *powered_callbacks;
 
 	gboolean name_stored;
@@ -2331,6 +2333,7 @@ void btd_adapter_start(struct btd_adapter *adapter)
 	adapter->pairable_timeout = get_pairable_timeout(address);
 	adapter->state = STATE_IDLE;
 	adapter->mode = MODE_CONNECTABLE;
+	adapter->timer_id = 0;
 
 	if (main_opts.le)
 		adapter_ops->enable_le(adapter->dev_id);
@@ -3454,6 +3457,21 @@ int btd_adapter_restore_powered(struct btd_adapter *adapter)
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
+	adapter->timer_id = 0;
+
+	return FALSE;
+}
+
 int btd_adapter_switch_online(struct btd_adapter *adapter)
 {
 	if (!adapter_ops)
@@ -3462,10 +3480,15 @@ int btd_adapter_switch_online(struct btd_adapter *adapter)
 	if (adapter->up)
 		return 0;
 
+	if (adapter->timer_id) {
+		g_source_remove(adapter->timer_id);
+		adapter->timer_id = 0;
+	}
+
 	return adapter_ops->set_powered(adapter->dev_id, TRUE);
 }
 
-int btd_adapter_switch_offline(struct btd_adapter *adapter)
+int btd_adapter_switch_offline(struct btd_adapter *adapter, gboolean clean)
 {
 	if (!adapter_ops)
 		return -EINVAL;
@@ -3473,6 +3496,19 @@ int btd_adapter_switch_offline(struct btd_adapter *adapter)
 	if (!adapter->up)
 		return 0;
 
+	if (adapter->timer_id)
+		return 0;
+
+	if (clean && adapter->connections) {
+		g_slist_foreach(adapter->connections,
+					(GFunc) disconnect_device, NULL);
+
+		adapter->timer_id = g_timeout_add_seconds(3,
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

