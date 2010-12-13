Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 04/10] plugins: use btd_error_failed()
Date: Mon, 13 Dec 2010 19:33:01 -0200
Message-Id: <1292275987-13799-5-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1292275987-13799-4-git-send-email-padovan@profusion.mobi>
References: <1292275987-13799-1-git-send-email-padovan@profusion.mobi>
 <1292275987-13799-2-git-send-email-padovan@profusion.mobi>
 <1292275987-13799-3-git-send-email-padovan@profusion.mobi>
 <1292275987-13799-4-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 plugins/service.c |   22 ++++------------------
 1 files changed, 4 insertions(+), 18 deletions(-)

diff --git a/plugins/service.c b/plugins/service.c
index a442d53..f44aa92 100644
--- a/plugins/service.c
+++ b/plugins/service.c
@@ -337,17 +337,6 @@ static void exit_callback(DBusConnection *conn, void *user_data)
 	g_free(user_record);
 }
 
-static inline DBusMessage *failed(DBusMessage *msg)
-{
-	return g_dbus_create_error(msg, ERROR_INTERFACE ".Failed", "Failed");
-}
-
-static inline DBusMessage *failed_strerror(DBusMessage *msg, int err)
-{
-	return g_dbus_create_error(msg, ERROR_INTERFACE ".Failed",
-							"%s", strerror(err));
-}
-
 static int add_xml_record(DBusConnection *conn, const char *sender,
 			struct service_adapter *serv_adapter,
 			const char *record, dbus_uint32_t *handle)
@@ -412,9 +401,7 @@ static DBusMessage *update_record(DBusConnection *conn, DBusMessage *msg,
 	if (err < 0) {
 		sdp_record_free(sdp_record);
 		error("Failed to update the service record");
-		return g_dbus_create_error(msg,
-				ERROR_INTERFACE ".Failed",
-				"%s", strerror(EIO));
+		return btd_error_failed(msg, strerror(-err));
 	}
 
 	return dbus_message_new_method_return(msg);
@@ -449,9 +436,8 @@ static DBusMessage *update_xml_record(DBusConnection *conn,
 	if (!sdp_record) {
 		error("Parsing of XML service record failed");
 		sdp_record_free(sdp_record);
-		return g_dbus_create_error(msg,
-				ERROR_INTERFACE ".Failed",
-				"%s", strerror(EIO));
+		return btd_error_failed(msg,
+					"Parsing of XML service record failed");
 	}
 
 	return update_record(conn, msg, serv_adapter, handle, sdp_record);
@@ -494,7 +480,7 @@ static DBusMessage *add_service_record(DBusConnection *conn,
 	sender = dbus_message_get_sender(msg);
 	err = add_xml_record(conn, sender, serv_adapter, record, &handle);
 	if (err < 0)
-		return failed_strerror(msg, err);
+		return btd_error_failed(msg, strerror(-err));
 
 	reply = dbus_message_new_method_return(msg);
 	if (!reply)
-- 
1.7.3.2

