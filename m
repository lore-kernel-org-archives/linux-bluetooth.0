Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/7] Fix coding styling issues in src/error.c
Date: Wed,  8 Dec 2010 18:25:55 -0200
Message-Id: <1291839961-14940-1-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/error.c |   26 +++++++++-----------------
 1 files changed, 9 insertions(+), 17 deletions(-)

diff --git a/src/error.c b/src/error.c
index 3c09567..0d33fb5 100644
--- a/src/error.c
+++ b/src/error.c
@@ -51,8 +51,7 @@ DBusHandlerResult error_common_reply(DBusConnection *conn, DBusMessage *msg,
 
 DBusMessage *btd_error_invalid_args(DBusMessage *msg)
 {
-	return g_dbus_create_error(msg, ERROR_INTERFACE
-					".InvalidArguments",
+	return g_dbus_create_error(msg, ERROR_INTERFACE ".InvalidArguments",
 					"Invalid arguments in method call");
 }
 
@@ -64,49 +63,42 @@ DBusMessage *btd_error_busy(DBusMessage *msg)
 
 DBusMessage *btd_error_already_exists(DBusMessage *msg)
 {
-	return g_dbus_create_error(msg,
-				ERROR_INTERFACE ".AlreadyExists",
-				"Already Exists");
+	return g_dbus_create_error(msg, ERROR_INTERFACE ".AlreadyExists",
+					"Already Exists");
 }
 
 DBusMessage *btd_error_not_supported(DBusMessage *msg)
 {
-	return g_dbus_create_error(msg, ERROR_INTERFACE
-					".NotSupported",
+	return g_dbus_create_error(msg, ERROR_INTERFACE ".NotSupported",
 					"Operation is not supported");
 }
 
 DBusMessage *btd_error_not_connected(DBusMessage *msg)
 {
-	return g_dbus_create_error(msg, ERROR_INTERFACE
-					".NotConnected",
+	return g_dbus_create_error(msg, ERROR_INTERFACE ".NotConnected",
 					"Not Connected");
 }
 
 DBusMessage *btd_error_in_progress(DBusMessage *msg)
 {
-	return g_dbus_create_error(msg, ERROR_INTERFACE
-					".InProgress",
+	return g_dbus_create_error(msg, ERROR_INTERFACE ".InProgress",
 					"In Progress");
 }
 
 DBusMessage *btd_error_not_available(DBusMessage *msg)
 {
-	return g_dbus_create_error(msg, ERROR_INTERFACE
-					".NotAvailable",
+	return g_dbus_create_error(msg, ERROR_INTERFACE ".NotAvailable",
 					"Operation currently not available");
 }
 
 DBusMessage *btd_error_does_not_exist(DBusMessage *msg)
 {
-	return g_dbus_create_error(msg, ERROR_INTERFACE
-					".DoesNotExist",
+	return g_dbus_create_error(msg, ERROR_INTERFACE ".DoesNotExist",
 					"Does Not Exist");
 }
 
 DBusMessage *btd_error_not_authorized(DBusMessage *msg)
 {
-	return g_dbus_create_error(msg, ERROR_INTERFACE
-					".NotAuthorized",
+	return g_dbus_create_error(msg, ERROR_INTERFACE ".NotAuthorized",
 					"Operation Not Authorized");
 }
-- 
1.7.3.2

