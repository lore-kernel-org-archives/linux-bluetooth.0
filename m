Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2] core: Remove RequestSession and ReleaseSession
Date: Thu, 13 Dec 2012 22:00:39 +0200
Message-Id: <1355428840-27065-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Sessions is no longer used by obexd and the concept is probably not
relevant anymore since BlueZ 5 don't remember powered state anymore.
---
 doc/adapter-api.txt |  26 +---------
 src/adapter.c       | 134 ----------------------------------------------------
 2 files changed, 1 insertion(+), 159 deletions(-)

diff --git a/doc/adapter-api.txt b/doc/adapter-api.txt
index 5d2ea65..1817f7c 100644
--- a/doc/adapter-api.txt
+++ b/doc/adapter-api.txt
@@ -14,31 +14,7 @@ Service		org.bluez
 Interface	org.bluez.Adapter1
 Object path	[variable prefix]/{hci0,hci1,...}
 
-Methods		void RequestSession()
-
-			This method requests a client session that provides
-			operational Bluetooth. A possible mode change must be
-			confirmed by the user via the agent.
-
-			Clients may request multiple sessions. All sessions
-			are released when adapter's mode is changed to off
-			state.
-
-			Possible Errors: org.bluez.Error.Rejected
-
-		void ReleaseSession()
-
-			Release a previously requested session. It sets
-			adapter to the mode in use on the moment of session
-			request.
-
-			Setting the powered or discoverable properties
-			changes adapter's mode persistently, such that session
-			release will not modify it.
-
-			Possible Errors: org.bluez.Error.DoesNotExist
-
-		void StartDiscovery()
+Methods		void StartDiscovery()
 
 			This method starts the device discovery session. This
 			includes an inquiry procedure and remote device name
diff --git a/src/adapter.c b/src/adapter.c
index 0a3297e..d4a03b9 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -339,18 +339,6 @@ static int adapter_set_mode(struct btd_adapter *adapter, uint8_t mode)
 	return err;
 }
 
-static struct session_req *find_session_by_msg(GSList *list, const DBusMessage *msg)
-{
-	for (; list; list = list->next) {
-		struct session_req *req = list->data;
-
-		if (req->msg == msg)
-			return req;
-	}
-
-	return NULL;
-}
-
 static int set_mode(struct btd_adapter *adapter, uint8_t new_mode)
 {
 	int err;
@@ -392,24 +380,6 @@ done:
 	return 0;
 }
 
-static void set_session_pending_mode(struct btd_adapter *adapter,
-					uint8_t new_mode, DBusMessage *msg)
-{
-	struct session_req *req;
-
-	/*
-	 * Schedule the reply to be sent when a mode-change notification
-	 * arrives. The reply will be sent by set_mode_complete().
-	 */
-	req = find_session_by_msg(adapter->mode_sessions, msg);
-	if (req) {
-		adapter->pending_mode = req;
-		session_ref(req);
-	} else
-		adapter->pending_mode = create_session(adapter, msg, new_mode,
-					SESSION_TYPE_MODE_SESSION, NULL);
-}
-
 static void set_discoverable(struct btd_adapter *adapter,
 			gboolean discoverable, GDBusPendingPropertySet id)
 {
@@ -732,45 +702,6 @@ static void session_unref(struct session_req *req)
 	session_free(req);
 }
 
-static void confirm_mode_cb(struct agent *agent, DBusError *derr, void *data)
-{
-	DBusConnection *conn = btd_get_dbus_connection();
-	struct session_req *req = data;
-	int err;
-	DBusMessage *reply;
-
-	req->got_reply = TRUE;
-
-	if (derr && dbus_error_is_set(derr)) {
-		reply = dbus_message_new_error(req->msg, derr->name,
-						derr->message);
-		g_dbus_send_message(conn, reply);
-		session_unref(req);
-		return;
-	}
-
-	err = set_mode(req->adapter, req->mode);
-	if (err >= 0 && req->adapter->mode != req->mode) {
-		set_session_pending_mode(req->adapter, req->mode, req->msg);
-		goto done;
-	}
-
-	if (err < 0)
-		reply = btd_error_failed(req->msg, strerror(-err));
-	else
-		reply = dbus_message_new_method_return(req->msg);
-
-	/*
-	 * Send reply immediately only if there was an error changing mode, or
-	 * change is not needed. Otherwise, reply is sent in
-	 * set_mode_complete.
-	 */
-	g_dbus_send_message(conn, reply);
-
-done:
-	session_unref(req);
-}
-
 static void set_discoverable_timeout(struct btd_adapter *adapter,
 				uint32_t timeout, GDBusPendingPropertySet id)
 {
@@ -1409,67 +1340,6 @@ static gboolean adapter_property_get_uuids(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
-static DBusMessage *request_session(DBusConnection *conn,
-					DBusMessage *msg, void *data)
-{
-	struct btd_adapter *adapter = data;
-	struct session_req *req;
-	const char *sender = dbus_message_get_sender(msg);
-	uint8_t new_mode;
-	int err;
-
-	if (!adapter->agent)
-		return btd_error_agent_not_available(msg);
-
-	if (!adapter->mode_sessions)
-		adapter->global_mode = adapter->mode;
-
-	if (adapter->discoverable)
-		new_mode = MODE_DISCOVERABLE;
-	else
-		new_mode = MODE_CONNECTABLE;
-
-	req = find_session(adapter->mode_sessions, sender);
-	if (req) {
-		session_ref(req);
-		return dbus_message_new_method_return(msg);
-	} else {
-		req = create_session(adapter, msg, new_mode,
-				SESSION_TYPE_MODE_SESSION, session_owner_exit);
-		adapter->mode_sessions = g_slist_append(adapter->mode_sessions,
-							req);
-	}
-
-	/* No need to change mode */
-	if (adapter->mode >= new_mode)
-		return dbus_message_new_method_return(msg);
-
-	err = agent_confirm_mode_change(adapter->agent, mode2str(new_mode),
-					confirm_mode_cb, req, NULL);
-	if (err < 0) {
-		session_unref(req);
-		return btd_error_failed(msg, strerror(-err));
-	}
-
-	return NULL;
-}
-
-static DBusMessage *release_session(DBusConnection *conn,
-					DBusMessage *msg, void *data)
-{
-	struct btd_adapter *adapter = data;
-	struct session_req *req;
-	const char *sender = dbus_message_get_sender(msg);
-
-	req = find_session(adapter->mode_sessions, sender);
-	if (!req)
-		return btd_error_failed(msg, "Invalid Session");
-
-	session_unref(req);
-
-	return dbus_message_new_method_return(msg);
-}
-
 static uint8_t parse_io_capability(const char *capability)
 {
 	if (g_str_equal(capability, ""))
@@ -1584,10 +1454,6 @@ static DBusMessage *unregister_agent(DBusConnection *conn, DBusMessage *msg,
 }
 
 static const GDBusMethodTable adapter_methods[] = {
-	{ GDBUS_ASYNC_METHOD("RequestSession", NULL, NULL,
-			request_session) },
-	{ GDBUS_METHOD("ReleaseSession", NULL, NULL,
-			release_session) },
 	{ GDBUS_METHOD("StartDiscovery", NULL, NULL,
 			adapter_start_discovery) },
 	{ GDBUS_ASYNC_METHOD("StopDiscovery", NULL, NULL,
-- 
1.7.11.7

