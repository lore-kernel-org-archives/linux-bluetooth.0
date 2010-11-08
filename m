Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 9/9] Add __btd_error_not_authorized()
Date: Mon,  8 Nov 2010 04:29:47 -0200
Message-Id: <1289197787-16715-10-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1289197787-16715-9-git-send-email-padovan@profusion.mobi>
References: <1289197787-16715-1-git-send-email-padovan@profusion.mobi>
 <1289197787-16715-2-git-send-email-padovan@profusion.mobi>
 <1289197787-16715-3-git-send-email-padovan@profusion.mobi>
 <1289197787-16715-4-git-send-email-padovan@profusion.mobi>
 <1289197787-16715-5-git-send-email-padovan@profusion.mobi>
 <1289197787-16715-6-git-send-email-padovan@profusion.mobi>
 <1289197787-16715-7-git-send-email-padovan@profusion.mobi>
 <1289197787-16715-8-git-send-email-padovan@profusion.mobi>
 <1289197787-16715-9-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 attrib/client.c   |    8 +-------
 plugins/service.c |   22 ++++++++--------------
 src/adapter.c     |    8 +-------
 src/device.c      |    8 ++------
 src/error.c       |    7 +++++++
 src/error.h       |    1 +
 6 files changed, 20 insertions(+), 34 deletions(-)

diff --git a/attrib/client.c b/attrib/client.c
index cd6e401..aadb28c 100644
--- a/attrib/client.c
+++ b/attrib/client.c
@@ -190,12 +190,6 @@ static int watcher_cmp(gconstpointer a, gconstpointer b)
 	return g_strcmp0(watcher->path, match->path);
 }
 
-static inline DBusMessage *not_authorized(DBusMessage *msg)
-{
-	return g_dbus_create_error(msg, ERROR_INTERFACE ".NotAuthorized",
-			"Not authorized");
-}
-
 static void append_char_dict(DBusMessageIter *iter, struct characteristic *chr)
 {
 	DBusMessageIter dict;
@@ -501,7 +495,7 @@ static DBusMessage *unregister_watcher(DBusConnection *conn,
 	l = g_slist_find_custom(prim->watchers, match, watcher_cmp);
 	watcher_free(match);
 	if (!l)
-		return not_authorized(msg);
+		return __btd_error_not_authorized(msg);
 
 	watcher = l->data;
 	g_dbus_remove_watch(conn, watcher->id);
diff --git a/plugins/service.c b/plugins/service.c
index b9f4b97..4e815fb 100644
--- a/plugins/service.c
+++ b/plugins/service.c
@@ -350,12 +350,6 @@ static inline DBusMessage *failed_strerror(DBusMessage *msg, int err)
 							"%s", strerror(err));
 }
 
-static inline DBusMessage *not_authorized(DBusMessage *msg)
-{
-	return g_dbus_create_error(msg, ERROR_INTERFACE ".NotAuthorized",
-					"Not Authorized");
-}
-
 static int add_xml_record(DBusConnection *conn, const char *sender,
 			struct service_adapter *serv_adapter,
 			const char *record, dbus_uint32_t *handle)
@@ -557,7 +551,7 @@ static void auth_cb(DBusError *derr, void *user_data)
 	if (derr) {
 		error("Access denied: %s", derr->message);
 
-		reply = not_authorized(auth->msg);
+		reply = __btd_error_not_authorized(auth->msg);
 		dbus_message_unref(auth->msg);
 		g_dbus_send_message(auth->conn, reply);
 		goto done;
@@ -614,20 +608,20 @@ static DBusMessage *request_authorization(DBusConnection *conn,
 	if (!user_record) {
 		user_record = find_record(serv_adapter_any, handle, sender);
 		if (!user_record)
-			return not_authorized(msg);
+			return __btd_error_not_authorized(msg);
 	}
 
 	record = sdp_record_find(user_record->handle);
 	if (record == NULL)
-		return not_authorized(msg);
+		return __btd_error_not_authorized(msg);
 
 	if (sdp_get_service_classes(record, &services) < 0) {
 		sdp_record_free(record);
-		return not_authorized(msg);
+		return __btd_error_not_authorized(msg);
 	}
 
 	if (services == NULL)
-		return not_authorized(msg);
+		return __btd_error_not_authorized(msg);
 
 	uuid = services->data;
 	uuid128 = sdp_uuid_to_uuid128(uuid);
@@ -636,7 +630,7 @@ static DBusMessage *request_authorization(DBusConnection *conn,
 
 	if (sdp_uuid2strn(uuid128, uuid_str, MAX_LEN_UUID_STR) < 0) {
 		bt_free(uuid128);
-		return not_authorized(msg);
+		return __btd_error_not_authorized(msg);
 	}
 	bt_free(uuid128);
 
@@ -664,7 +658,7 @@ static DBusMessage *request_authorization(DBusConnection *conn,
 		serv_adapter->pending_list = g_slist_remove(serv_adapter->pending_list,
 									auth);
 		g_free(auth);
-		return not_authorized(msg);
+		return __btd_error_not_authorized(msg);
 	}
 
 	return NULL;
@@ -692,7 +686,7 @@ static DBusMessage *cancel_authorization(DBusConnection *conn,
 
 	btd_cancel_authorization(&src, &auth->dst);
 
-	reply = not_authorized(auth->msg);
+	reply = __btd_error_not_authorized(auth->msg);
 	dbus_message_unref(auth->msg);
 	g_dbus_send_message(auth->conn, reply);
 
diff --git a/src/adapter.c b/src/adapter.c
index 68ae6e4..9ca41cb 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -166,12 +166,6 @@ static inline DBusMessage *not_in_progress(DBusMessage *msg, const char *str)
 								"%s", str);
 }
 
-static inline DBusMessage *not_authorized(DBusMessage *msg)
-{
-	return g_dbus_create_error(msg, ERROR_INTERFACE ".NotAuthorized",
-			"Not authorized");
-}
-
 static int found_device_cmp(const struct remote_dev_info *d1,
 			const struct remote_dev_info *d2)
 {
@@ -1713,7 +1707,7 @@ static DBusMessage *cancel_device_creation(DBusConnection *conn,
 		return not_in_progress(msg, "Device creation not in progress");
 
 	if (!device_is_creating(device, sender))
-		return not_authorized(msg);
+		return __btd_error_not_authorized(msg);
 
 	device_set_temporary(device, TRUE);
 
diff --git a/src/device.c b/src/device.c
index f72a9b5..5d5f23d 100644
--- a/src/device.c
+++ b/src/device.c
@@ -729,17 +729,13 @@ static DBusMessage *cancel_discover(DBusConnection *conn,
 
 	if (!dbus_message_is_method_call(device->browse->msg, DEVICE_INTERFACE,
 					"DiscoverServices"))
-		return g_dbus_create_error(msg,
-				ERROR_INTERFACE ".NotAuthorized",
-				"Not Authorized");
+		return __btd_error_not_authorized(msg);
 
 	requestor = browse_request_get_requestor(device->browse);
 
 	/* only the discover requestor can cancel the inquiry process */
 	if (!requestor || !g_str_equal(requestor, sender))
-		return g_dbus_create_error(msg,
-				ERROR_INTERFACE ".NotAuthorized",
-				"Not Authorized");
+		return __btd_error_not_authorized(msg);
 
 	discover_services_reply(device->browse, -ECANCELED, NULL);
 
diff --git a/src/error.c b/src/error.c
index c8e5ed7..c382f58 100644
--- a/src/error.c
+++ b/src/error.c
@@ -103,3 +103,10 @@ DBusMessage *__btd_error_does_not_exist(DBusMessage *msg)
 					".DoesNotExist",
 					"Does Not Exist");
 }
+
+DBusMessage *__btd_error_not_authorized(DBusMessage *msg)
+{
+	return g_dbus_create_error(msg, ERROR_INTERFACE
+					".NotAuthorized",
+					"Operation Not Authorized");
+}
diff --git a/src/error.h b/src/error.h
index bd8d724..a970c92 100644
--- a/src/error.h
+++ b/src/error.h
@@ -38,3 +38,4 @@ DBusMessage *__btd_error_not_connected(DBusMessage *msg);
 DBusMessage *__btd_error_not_available(DBusMessage *msg);
 DBusMessage *__btd_error_in_progress(DBusMessage *msg);
 DBusMessage *__btd_error_does_not_exist(DBusMessage *msg);
+DBusMessage *__btd_error_not_authorized(DBusMessage *msg);
-- 
1.7.3.1

