Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ 2/3] Serialize powering up/down in maemo6 plugin
Date: Mon, 12 Sep 2011 09:06:31 -0300
Message-Id: <1315829192-30924-2-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1315829192-30924-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1315829192-30924-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch fixes wrong adapter state when using Management interface.
When bluetoothd starts, the adapter should be switched to the state
informed by Maemo6 MCE. In the current implementation, Maemo6 plugin
sends set powered command when the adapter is still powering up, the
last command sent fails(kernel returns EALREADY).
---
 plugins/maemo6.c |  136 +++++++++++++++++++++++++++---------------------------
 1 files changed, 68 insertions(+), 68 deletions(-)

diff --git a/plugins/maemo6.c b/plugins/maemo6.c
index 56f2664..00fb3fa 100644
--- a/plugins/maemo6.c
+++ b/plugins/maemo6.c
@@ -50,7 +50,7 @@
 static guint watch_id;
 static DBusConnection *conn = NULL;
 static gboolean mce_bt_set = FALSE;
-static gboolean collision = FALSE;
+static gboolean mce_bt_on = FALSE;
 
 static gboolean mce_signal_callback(DBusConnection *connection,
 					DBusMessage *message, void *user_data)
@@ -58,6 +58,7 @@ static gboolean mce_signal_callback(DBusConnection *connection,
 	DBusMessageIter args;
 	uint32_t sigvalue;
 	struct btd_adapter *adapter = user_data;
+	int err;
 
 	DBG("received mce signal");
 
@@ -71,13 +72,16 @@ static gboolean mce_signal_callback(DBusConnection *connection,
 
 		/* set the adapter according to the mce signal
 		   and remember the value */
-		mce_bt_set = sigvalue & MCE_RADIO_STATE_BLUETOOTH ?
-								TRUE : FALSE;
+		mce_bt_on = sigvalue & MCE_RADIO_STATE_BLUETOOTH ? TRUE : FALSE;
 
-		if (mce_bt_set)
-			btd_adapter_switch_online(adapter);
+		if (mce_bt_on)
+			err = btd_adapter_switch_online(adapter);
 		else
-			btd_adapter_switch_offline(adapter);
+			err = btd_adapter_switch_offline(adapter);
+
+		if (err == 0)
+			mce_bt_set = TRUE;
+
 	}
 
 	return TRUE;
@@ -85,46 +89,43 @@ static gboolean mce_signal_callback(DBusConnection *connection,
 
 static void read_radio_states_cb(DBusPendingCall *call, void *user_data)
 {
-	DBusError err;
+	DBusError derr;
 	DBusMessage *reply;
 	dbus_uint32_t radio_states;
 	struct btd_adapter *adapter = user_data;
+	int err;
 
 	reply = dbus_pending_call_steal_reply(call);
 
-	dbus_error_init(&err);
-	if (dbus_set_error_from_message(&err, reply)) {
+	dbus_error_init(&derr);
+	if (dbus_set_error_from_message(&derr, reply)) {
 		error("mce replied with an error: %s, %s",
-				err.name, err.message);
-		dbus_error_free(&err);
+				derr.name, derr.message);
+		dbus_error_free(&derr);
 		goto done;
 	}
 
-	dbus_error_init(&err);
-	if (dbus_message_get_args(reply, &err,
+	dbus_error_init(&derr);
+	if (dbus_message_get_args(reply, &derr,
 				DBUS_TYPE_UINT32, &radio_states,
 				DBUS_TYPE_INVALID) == FALSE) {
 		error("unable to parse get_radio_states reply: %s, %s",
-							err.name, err.message);
-		dbus_error_free(&err);
+							derr.name, derr.message);
+		dbus_error_free(&derr);
 		goto done;
 	}
 
 	DBG("radio_states: %d", radio_states);
 
-	mce_bt_set = radio_states & MCE_RADIO_STATE_BLUETOOTH ? TRUE : FALSE;
+	mce_bt_on = radio_states & MCE_RADIO_STATE_BLUETOOTH ? TRUE : FALSE;
 
-	/* check if the adapter has not completed the initial power
-	 * cycle, if so delay action to mce_notify_powered */
-	collision = mce_bt_set && adapter_powering_down(adapter);
-
-	if (collision)
-		goto done;
-
-	if (mce_bt_set)
-		btd_adapter_switch_online(adapter);
+	if (mce_bt_on)
+		err = btd_adapter_switch_online(adapter);
 	else
-		btd_adapter_switch_offline(adapter);
+		err = btd_adapter_switch_offline(adapter);
+
+	if (err == 0)
+		mce_bt_set = TRUE;
 
 done:
 	dbus_message_unref(reply);
@@ -133,73 +134,72 @@ done:
 static void adapter_powered(struct btd_adapter *adapter, gboolean powered)
 {
 	DBusMessage *msg;
-	dbus_uint32_t radio_states = 0;
-	dbus_uint32_t radio_mask = MCE_RADIO_STATE_BLUETOOTH;
 	static gboolean startup = TRUE;
 
 	DBG("adapter_powered called with %d", powered);
 
 	if (startup) {
+		DBusPendingCall *call;
+
+		/* Initialization: sync adapter state and MCE radio state */
+
+		DBG("Startup: reading MCE Bluetooth radio state...");
 		startup = FALSE;
-		return;
-	}
 
-	/* check if the plugin got the get_radio_states reply from the
-	 * mce when the adapter was not yet down during the power
-	 * cycling when bluetoothd is started */
-	if (collision) {
-		error("maemo6: powered state collision");
-		collision = FALSE;
+		msg = dbus_message_new_method_call(MCE_SERVICE,
+					MCE_REQUEST_PATH, MCE_REQUEST_IF,
+					MCE_RADIO_STATES_GET);
 
-		if (mce_bt_set)
-			btd_adapter_switch_online(adapter);
+		if (!dbus_connection_send_with_reply(conn, msg, &call, -1)) {
+			error("calling %s failed", MCE_RADIO_STATES_GET);
+			dbus_message_unref(msg);
+			return;
+		}
 
+		dbus_pending_call_set_notify(call, read_radio_states_cb,
+								adapter, NULL);
+		dbus_pending_call_unref(call);
+		dbus_message_unref(msg);
 		return;
 	}
 
-	/* nothing to do if the states match */
-	if (mce_bt_set == powered)
+	/* MCE initiated operation */
+	if (mce_bt_set == TRUE) {
+		mce_bt_set = FALSE;
 		return;
+	}
 
-	/* set the mce value according to the state of the adapter */
-	msg = dbus_message_new_method_call(MCE_SERVICE, MCE_REQUEST_PATH,
-				MCE_REQUEST_IF, MCE_RADIO_STATES_CHANGE_REQ);
+	/* Non MCE operation: set MCE according to adapter state */
+	if (mce_bt_on != powered) {
+		dbus_uint32_t radio_states;
+		dbus_uint32_t radio_mask = MCE_RADIO_STATE_BLUETOOTH;
 
-	if (powered)
-		radio_states = MCE_RADIO_STATE_BLUETOOTH;
+		msg = dbus_message_new_method_call(MCE_SERVICE,
+					MCE_REQUEST_PATH, MCE_REQUEST_IF,
+					MCE_RADIO_STATES_CHANGE_REQ);
 
-	dbus_message_append_args(msg, DBUS_TYPE_UINT32, &radio_states,
-				DBUS_TYPE_UINT32, &radio_mask,
-				DBUS_TYPE_INVALID);
+		radio_states = (powered ? MCE_RADIO_STATE_BLUETOOTH : 0);
 
-	if (dbus_connection_send(conn, msg, NULL))
-		mce_bt_set = powered;
-	else
-		error("calling %s failed", MCE_RADIO_STATES_CHANGE_REQ);
+		DBG("Changing MCE Bluetooth radio state to: %d", radio_states);
 
-	dbus_message_unref(msg);
+		dbus_message_append_args(msg, DBUS_TYPE_UINT32, &radio_states,
+					DBUS_TYPE_UINT32, &radio_mask,
+					DBUS_TYPE_INVALID);
+
+		if (dbus_connection_send(conn, msg, NULL))
+			mce_bt_on = powered;
+		else
+			error("calling %s failed", MCE_RADIO_STATES_CHANGE_REQ);
+
+		dbus_message_unref(msg);
+	}
 }
 
 static int mce_probe(struct btd_adapter *adapter)
 {
-	DBusMessage *msg;
-	DBusPendingCall *call;
 
 	DBG("path %s", adapter_get_path(adapter));
 
-	msg = dbus_message_new_method_call(MCE_SERVICE, MCE_REQUEST_PATH,
-					MCE_REQUEST_IF, MCE_RADIO_STATES_GET);
-
-	if (!dbus_connection_send_with_reply(conn, msg, &call, -1)) {
-		error("calling %s failed", MCE_RADIO_STATES_GET);
-		dbus_message_unref(msg);
-		return -1;
-	}
-
-	dbus_pending_call_set_notify(call, read_radio_states_cb, adapter, NULL);
-	dbus_pending_call_unref(call);
-	dbus_message_unref(msg);
-
 	watch_id = g_dbus_add_signal_watch(conn, NULL, MCE_SIGNAL_PATH,
 					MCE_SIGNAL_IF, MCE_RADIO_STATES_SIG,
 					mce_signal_callback, adapter, NULL);
-- 
1.7.6

