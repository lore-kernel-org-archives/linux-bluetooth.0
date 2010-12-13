Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 01/10] Add btd_error_no_such_adapter()
Date: Mon, 13 Dec 2010 19:32:58 -0200
Message-Id: <1292275987-13799-2-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1292275987-13799-1-git-send-email-padovan@profusion.mobi>
References: <1292275987-13799-1-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/device.c  |    6 ------
 src/error.c   |    6 ++++++
 src/error.h   |    1 +
 src/manager.c |   13 +++----------
 4 files changed, 10 insertions(+), 16 deletions(-)

diff --git a/src/device.c b/src/device.c
index 91b9d23..7ceac8b 100644
--- a/src/device.c
+++ b/src/device.c
@@ -171,12 +171,6 @@ static DBusHandlerResult error_failed_errno(DBusConnection *conn,
 	return error_failed(conn, msg, desc);
 }
 
-static inline DBusMessage *no_such_adapter(DBusMessage *msg)
-{
-	return g_dbus_create_error(msg, ERROR_INTERFACE ".NoSuchAdapter",
-							"No such adapter");
-}
-
 static void browse_request_free(struct browse_req *req)
 {
 	if (req->listener_id)
diff --git a/src/error.c b/src/error.c
index e1f0598..013de96 100644
--- a/src/error.c
+++ b/src/error.c
@@ -108,3 +108,9 @@ DBusMessage *btd_error_not_authorized(DBusMessage *msg)
 	return g_dbus_create_error(msg, ERROR_INTERFACE ".NotAuthorized",
 					"Operation Not Authorized");
 }
+
+DBusMessage *btd_error_no_such_adapter(DBusMessage *msg)
+{
+	return g_dbus_create_error(msg, ERROR_INTERFACE ".NoSuchAdapter",
+					"No such adapter");
+}
diff --git a/src/error.h b/src/error.h
index 9d80fa0..a4e32fe 100644
--- a/src/error.h
+++ b/src/error.h
@@ -40,3 +40,4 @@ DBusMessage *btd_error_not_available(DBusMessage *msg);
 DBusMessage *btd_error_in_progress(DBusMessage *msg);
 DBusMessage *btd_error_does_not_exist(DBusMessage *msg);
 DBusMessage *btd_error_not_authorized(DBusMessage *msg);
+DBusMessage *btd_error_no_such_adapter(DBusMessage *msg);
diff --git a/src/manager.c b/src/manager.c
index ccaa1a2..c8ec7e5 100644
--- a/src/manager.c
+++ b/src/manager.c
@@ -59,13 +59,6 @@ const char *manager_get_base_path(void)
 	return base_path;
 }
 
-static inline DBusMessage *no_such_adapter(DBusMessage *msg)
-{
-	return g_dbus_create_error(msg,
-			ERROR_INTERFACE ".NoSuchAdapter",
-			"No such adapter");
-}
-
 static DBusMessage *default_adapter(DBusConnection *conn,
 					DBusMessage *msg, void *data)
 {
@@ -75,7 +68,7 @@ static DBusMessage *default_adapter(DBusConnection *conn,
 
 	adapter = manager_find_adapter_by_id(default_adapter_id);
 	if (!adapter)
-		return no_such_adapter(msg);
+		return btd_error_no_such_adapter(msg);
 
 	reply = dbus_message_new_method_return(msg);
 	if (!reply)
@@ -108,7 +101,7 @@ static DBusMessage *find_adapter(DBusConnection *conn,
 		path = adapter_any_get_path();
 		if (path != NULL)
 			goto done;
-		return no_such_adapter(msg);
+		return btd_error_no_such_adapter(msg);
 	} else if (!strncmp(pattern, "hci", 3) && strlen(pattern) >= 4) {
 		dev_id = atoi(pattern + 3);
 		adapter = manager_find_adapter_by_id(dev_id);
@@ -116,7 +109,7 @@ static DBusMessage *find_adapter(DBusConnection *conn,
 		adapter = manager_find_adapter_by_address(pattern);
 
 	if (!adapter)
-		return no_such_adapter(msg);
+		return btd_error_no_such_adapter(msg);
 
 	path = adapter_get_path(adapter);
 
-- 
1.7.3.2

