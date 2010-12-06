Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 9/9] Add btd_error_not_authorized()
Date: Mon,  6 Dec 2010 17:10:48 -0200
Message-Id: <1291662648-10651-9-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1291662648-10651-8-git-send-email-padovan@profusion.mobi>
References: <1291662648-10651-1-git-send-email-padovan@profusion.mobi>
 <1291662648-10651-2-git-send-email-padovan@profusion.mobi>
 <1291662648-10651-3-git-send-email-padovan@profusion.mobi>
 <1291662648-10651-4-git-send-email-padovan@profusion.mobi>
 <1291662648-10651-5-git-send-email-padovan@profusion.mobi>
 <1291662648-10651-6-git-send-email-padovan@profusion.mobi>
 <1291662648-10651-7-git-send-email-padovan@profusion.mobi>
 <1291662648-10651-8-git-send-email-padovan@profusion.mobi>
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
index ac78fbd..0805492 100644
--- a/attrib/client.c
+++ b/attrib/client.c
@@ -191,12 +191,6 @@ static int watcher_cmp(gconstpointer a, gconstpointer b)
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
@@ -502,7 +496,7 @@ static DBusMessage *unregister_watcher(DBusConnection *conn,
 	l = g_slist_find_custom(prim->watchers, match, watcher_cmp);
 	watcher_free(match);
 	if (!l)
-		return not_authorized(msg);
+		return btd_error_not_authorized(msg);
 
 	watcher = l->data;
 	g_dbus_remove_watch(conn, watcher->id);
diff --git a/plugins/service.c b/plugins/service.c
index 406ee7d..5267671 100644
--- a/plugins/service.c
+++ b/plugins/service.c
@@ -348,12 +348,6 @@ static inline DBusMessage *failed_strerror(DBusMessage *msg, int err)
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
@@ -555,7 +549,7 @@ static void auth_cb(DBusError *derr, void *user_data)
 	if (derr) {
 		error("Access denied: %s", derr->message);
 
-		reply = not_authorized(auth->msg);
+		reply = btd_error_not_authorized(auth->msg);
 		dbus_message_unref(auth->msg);
 		g_dbus_send_message(auth->conn, reply);
 		goto done;
@@ -612,20 +606,20 @@ static DBusMessage *request_authorization(DBusConnection *conn,
 	if (!user_record) {
 		user_record = find_record(serv_adapter_any, handle, sender);
 		if (!user_record)
-			return not_authorized(msg);
+			return btd_error_not_authorized(msg);
 	}
 
 	record = sdp_record_find(user_record->handle);
 	if (record == NULL)
-		return not_authorized(msg);
+		return btd_error_not_authorized(msg);
 
 	if (sdp_get_service_classes(record, &services) < 0) {
 		sdp_record_free(record);
-		return not_authorized(msg);
+		return btd_error_not_authorized(msg);
 	}
 
 	if (services == NULL)
-		return not_authorized(msg);
+		return btd_error_not_authorized(msg);
 
 	uuid = services->data;
 	uuid128 = sdp_uuid_to_uuid128(uuid);
@@ -634,7 +628,7 @@ static DBusMessage *request_authorization(DBusConnection *conn,
 
 	if (sdp_uuid2strn(uuid128, uuid_str, MAX_LEN_UUID_STR) < 0) {
 		bt_free(uuid128);
-		return not_authorized(msg);
+		return btd_error_not_authorized(msg);
 	}
 	bt_free(uuid128);
 
@@ -662,7 +656,7 @@ static DBusMessage *request_authorization(DBusConnection *conn,
 		serv_adapter->pending_list = g_slist_remove(serv_adapter->pending_list,
 									auth);
 		g_free(auth);
-		return not_authorized(msg);
+		return btd_error_not_authorized(msg);
 	}
 
 	return NULL;
@@ -690,7 +684,7 @@ static DBusMessage *cancel_authorization(DBusConnection *conn,
 
 	btd_cancel_authorization(&src, &auth->dst);
 
-	reply = not_authorized(auth->msg);
+	reply = btd_error_not_authorized(auth->msg);
 	dbus_message_unref(auth->msg);
 	g_dbus_send_message(auth->conn, reply);
 
diff --git a/src/adapter.c b/src/adapter.c
index 2d47856..9199f24 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -164,12 +164,6 @@ static inline DBusMessage *not_in_progress(DBusMessage *msg, const char *str)
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
@@ -1666,7 +1660,7 @@ static DBusMessage *cancel_device_creation(DBusConnection *conn,
 		return not_in_progress(msg, "Device creation not in progress");
 
 	if (!device_is_creating(device, sender))
-		return not_authorized(msg);
+		return btd_error_not_authorized(msg);
 
 	device_set_temporary(device, TRUE);
 
diff --git a/src/device.c b/src/device.c
index 3f94efc..cfe00c5 100644
--- a/src/device.c
+++ b/src/device.c
@@ -727,17 +727,13 @@ static DBusMessage *cancel_discover(DBusConnection *conn,
 
 	if (!dbus_message_is_method_call(device->browse->msg, DEVICE_INTERFACE,
 					"DiscoverServices"))
-		return g_dbus_create_error(msg,
-				ERROR_INTERFACE ".NotAuthorized",
-				"Not Authorized");
+		return btd_error_not_authorized(msg);
 
 	requestor = browse_request_get_requestor(device->browse);
 
 	/* only the discover requestor can cancel the inquiry process */
 	if (!requestor || !g_str_equal(requestor, sender))
-		return g_dbus_create_error(msg,
-				ERROR_INTERFACE ".NotAuthorized",
-				"Not Authorized");
+		return btd_error_not_authorized(msg);
 
 	discover_services_reply(device->browse, -ECANCELED, NULL);
 
diff --git a/src/error.c b/src/error.c
index 7c7d14e..3c09567 100644
--- a/src/error.c
+++ b/src/error.c
@@ -103,3 +103,10 @@ DBusMessage *btd_error_does_not_exist(DBusMessage *msg)
 					".DoesNotExist",
 					"Does Not Exist");
 }
+
+DBusMessage *btd_error_not_authorized(DBusMessage *msg)
+{
+	return g_dbus_create_error(msg, ERROR_INTERFACE
+					".NotAuthorized",
+					"Operation Not Authorized");
+}
diff --git a/src/error.h b/src/error.h
index 0ecbf6e..a7028bd 100644
--- a/src/error.h
+++ b/src/error.h
@@ -38,3 +38,4 @@ DBusMessage *btd_error_not_connected(DBusMessage *msg);
 DBusMessage *btd_error_not_available(DBusMessage *msg);
 DBusMessage *btd_error_in_progress(DBusMessage *msg);
 DBusMessage *btd_error_does_not_exist(DBusMessage *msg);
+DBusMessage *btd_error_not_authorized(DBusMessage *msg);
-- 
1.7.3.2

