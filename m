Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 10/10] src: use btd_error_failed()
Date: Mon, 13 Dec 2010 19:33:07 -0200
Message-Id: <1292275987-13799-11-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1292275987-13799-10-git-send-email-padovan@profusion.mobi>
References: <1292275987-13799-1-git-send-email-padovan@profusion.mobi>
 <1292275987-13799-2-git-send-email-padovan@profusion.mobi>
 <1292275987-13799-3-git-send-email-padovan@profusion.mobi>
 <1292275987-13799-4-git-send-email-padovan@profusion.mobi>
 <1292275987-13799-5-git-send-email-padovan@profusion.mobi>
 <1292275987-13799-6-git-send-email-padovan@profusion.mobi>
 <1292275987-13799-7-git-send-email-padovan@profusion.mobi>
 <1292275987-13799-8-git-send-email-padovan@profusion.mobi>
 <1292275987-13799-9-git-send-email-padovan@profusion.mobi>
 <1292275987-13799-10-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/adapter.c |   37 +++++++++++++------------------------
 src/device.c  |   44 ++++++++++++--------------------------------
 2 files changed, 25 insertions(+), 56 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index e37b200..47ee26a 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -146,12 +146,6 @@ static inline DBusMessage *adapter_not_ready(DBusMessage *msg)
 			"Adapter is not ready");
 }
 
-static inline DBusMessage *failed_strerror(DBusMessage *msg, int err)
-{
-	return g_dbus_create_error(msg, ERROR_INTERFACE ".Failed",
-							"%s", strerror(err));
-}
-
 static inline DBusMessage *not_in_progress(DBusMessage *msg, const char *str)
 {
 	return g_dbus_create_error(msg, ERROR_INTERFACE ".NotInProgress",
@@ -523,7 +517,7 @@ static DBusMessage *set_discoverable(DBusConnection *conn, DBusMessage *msg,
 
 	err = set_mode(adapter, mode, msg);
 	if (err < 0)
-		return failed_strerror(msg, -err);
+		return btd_error_failed(msg, strerror(-err));
 
 	return NULL;
 }
@@ -548,7 +542,7 @@ static DBusMessage *set_powered(DBusConnection *conn, DBusMessage *msg,
 
 	err = set_mode(adapter, mode, msg);
 	if (err < 0)
-		return failed_strerror(msg, -err);
+		return btd_error_failed(msg, strerror(-err));
 
 	return NULL;
 }
@@ -570,7 +564,7 @@ static DBusMessage *set_pairable(DBusConnection *conn, DBusMessage *msg,
 
 	err = set_mode(adapter, MODE_DISCOVERABLE, NULL);
 	if (err < 0 && msg)
-		return failed_strerror(msg, -err);
+		return btd_error_failed(msg, strerror(-err));
 
 store:
 
@@ -775,7 +769,7 @@ static void confirm_mode_cb(struct agent *agent, DBusError *derr, void *data)
 
 	err = set_mode(req->adapter, req->mode, NULL);
 	if (err < 0)
-		reply = failed_strerror(req->msg, -err);
+		reply = btd_error_failed(req->msg, strerror(-err));
 	else
 		reply = dbus_message_new_method_return(req->msg);
 
@@ -906,7 +900,7 @@ static DBusMessage *set_name(DBusConnection *conn, DBusMessage *msg,
 	if (adapter->up) {
 		int err = adapter_ops->set_name(adapter->dev_id, name);
 		if (err < 0)
-			return failed_strerror(msg, err);
+			return btd_error_failed(msg, strerror(-err));
 
 		adapter->name_stored = TRUE;
 	}
@@ -1185,7 +1179,7 @@ static DBusMessage *adapter_start_discovery(DBusConnection *conn,
 
 	err = start_discovery(adapter);
 	if (err < 0)
-		return failed_strerror(msg, -err);
+		return btd_error_failed(msg, strerror(-err));
 
 done:
 	req = create_session(adapter, conn, msg, 0,
@@ -1208,8 +1202,7 @@ static DBusMessage *adapter_stop_discovery(DBusConnection *conn,
 
 	req = find_session(adapter->disc_sessions, sender);
 	if (!req)
-		return g_dbus_create_error(msg, ERROR_INTERFACE ".Failed",
-				"Invalid discovery session");
+		return btd_error_failed(msg, "Invalid discovery session");
 
 	session_unref(req);
 	info("Stopping discovery");
@@ -1446,7 +1439,7 @@ static DBusMessage *request_session(DBusConnection *conn,
 					confirm_mode_cb, req, NULL);
 	if (err < 0) {
 		session_unref(req);
-		return failed_strerror(msg, -err);
+		return btd_error_failed(msg, strerror(-err));
 	}
 
 	return NULL;
@@ -1461,8 +1454,7 @@ static DBusMessage *release_session(DBusConnection *conn,
 
 	req = find_session(adapter->mode_sessions, sender);
 	if (!req)
-		return g_dbus_create_error(msg, ERROR_INTERFACE ".Failed",
-				"No Mode to release");
+		return btd_error_failed(msg, "Invalid Session");
 
 	session_unref(req);
 
@@ -1622,7 +1614,7 @@ static DBusMessage *create_device(DBusConnection *conn,
 	err = device_browse(device, conn, msg, NULL, FALSE);
 	if (err < 0) {
 		adapter_remove_device(conn, adapter, device, TRUE);
-		return failed_strerror(msg, -err);
+		return btd_error_failed(msg, strerror(-err));
 	}
 
 	return NULL;
@@ -1676,8 +1668,7 @@ static DBusMessage *create_paired_device(DBusConnection *conn,
 
 	device = adapter_get_device(conn, adapter, address);
 	if (!device)
-		return g_dbus_create_error(msg,
-				ERROR_INTERFACE ".Failed",
+		return btd_error_failed(msg,
 				"Unable to create a new device object");
 
 	return device_create_bonding(device, conn, msg, agent_path, cap);
@@ -1788,9 +1779,7 @@ static DBusMessage *register_agent(DBusConnection *conn, DBusMessage *msg,
 	agent = agent_create(adapter, name, path, cap,
 				(agent_remove_cb) agent_removed, adapter);
 	if (!agent)
-		return g_dbus_create_error(msg,
-				ERROR_INTERFACE ".Failed",
-				"Failed to create a new agent");
+		return btd_error_failed(msg, "Failed to create a new agent");
 
 	adapter->agent = agent;
 
@@ -2334,7 +2323,7 @@ static void set_mode_complete(struct btd_adapter *adapter)
 		DBusMessage *reply;
 
 		if (err < 0)
-			reply = failed_strerror(msg, -err);
+			reply = btd_error_failed(msg, strerror(-err));
 		else
 			reply = g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
 
diff --git a/src/device.c b/src/device.c
index 0f4dc0b..cec2153 100644
--- a/src/device.c
+++ b/src/device.c
@@ -157,20 +157,6 @@ static uint16_t uuid_list[] = {
 
 static GSList *device_drivers = NULL;
 
-static DBusHandlerResult error_failed(DBusConnection *conn,
-					DBusMessage *msg, const char * desc)
-{
-	return error_common_reply(conn, msg, ERROR_INTERFACE ".Failed", desc);
-}
-
-static DBusHandlerResult error_failed_errno(DBusConnection *conn,
-						DBusMessage *msg, int err)
-{
-	const char *desc = strerror(err);
-
-	return error_failed(conn, msg, desc);
-}
-
 static void browse_request_free(struct browse_req *req)
 {
 	if (req->listener_id)
@@ -380,9 +366,7 @@ static DBusMessage *set_alias(DBusConnection *conn, DBusMessage *msg,
 	err = write_device_alias(srcaddr, dstaddr,
 			g_str_equal(alias, "") ? NULL : alias);
 	if (err < 0)
-		return g_dbus_create_error(msg,
-				ERROR_INTERFACE ".Failed",
-				"%s", strerror(-err));
+		return btd_error_failed(msg, strerror(-err));
 
 	g_free(device->alias);
 	device->alias = g_str_equal(alias, "") ? NULL : g_strdup(alias);
@@ -412,9 +396,7 @@ static DBusMessage *set_trust(DBusConnection *conn, DBusMessage *msg,
 
 	err = write_trust(srcaddr, dstaddr, GLOBAL_TRUST, value);
 	if (err < 0)
-		return g_dbus_create_error(msg,
-				ERROR_INTERFACE ".Failed",
-				"%s", strerror(-err));
+		return btd_error_failed(msg, strerror(-err));
 
 	device->trusted = value;
 
@@ -526,12 +508,9 @@ static DBusMessage *set_blocked(DBusConnection *conn, DBusMessage *msg,
 	case 0:
 		return dbus_message_new_method_return(msg);
 	case EINVAL:
-		return g_dbus_create_error(msg,
-					ERROR_INTERFACE ".NotSupported",
-					"Kernel lacks blacklist support");
+		return btd_error_failed(msg, "Kernel lacks blacklist support");
 	default:
-		return g_dbus_create_error(msg, ERROR_INTERFACE ".Failed",
-						"%s", strerror(-err));
+		return btd_error_failed(msg, strerror(-err));
 	}
 }
 
@@ -627,8 +606,7 @@ static DBusMessage *discover_services(DBusConnection *conn,
 	return NULL;
 
 fail:
-	return g_dbus_create_error(msg, ERROR_INTERFACE ".Failed",
-					"Discovery Failed");
+	return btd_error_failed(msg, strerror(-err));
 }
 
 static const char *browse_request_get_requestor(struct browse_req *req)
@@ -1473,7 +1451,9 @@ send_reply:
 	else if (dbus_message_is_method_call(req->msg, ADAPTER_INTERFACE,
 						"CreateDevice")) {
 		if (err < 0) {
-			error_failed_errno(req->conn, req->msg, -err);
+			DBusMessage *reply;
+			reply = btd_error_failed(req->msg, strerror(-err));
+			g_dbus_send_message(req->conn, reply);
 			goto cleanup;
 		}
 
@@ -1544,7 +1524,9 @@ static void primary_cb(GSList *services, int err, gpointer user_data)
 	struct btd_device *device = req->device;
 
 	if (err) {
-		error_failed_errno(req->conn, req->msg, -err);
+		DBusMessage *reply;
+		reply = btd_error_failed(req->msg, strerror(-err));
+		g_dbus_send_message(req->conn, reply);
 		goto done;
 	}
 
@@ -2000,9 +1982,7 @@ DBusMessage *device_create_bonding(struct btd_device *device,
 				BT_IO_OPT_INVALID);
 	if (io == NULL) {
 		DBusMessage *reply;
-		reply = g_dbus_create_error(msg,
-				ERROR_INTERFACE ".ConnectionAttemptFailed",
-				"%s", err->message);
+		reply = btd_error_failed(msg, err->message);
 		error("bt_io_connect: %s", err->message);
 		g_error_free(err);
 		return reply;
-- 
1.7.3.2

