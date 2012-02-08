Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 12/13 v3] client: remove use of gobex in ftp module
Date: Wed,  8 Feb 2012 11:44:08 +0200
Message-Id: <1328694249-22225-12-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1328694249-22225-1-git-send-email-luiz.dentz@gmail.com>
References: <1328694249-22225-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

gobex should not be use directly as it can interfere with ongoing
requests of the session.
---
 client/ftp.c |   17 ++++++-----------
 1 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/client/ftp.c b/client/ftp.c
index fdadf43..92fcaad 100644
--- a/client/ftp.c
+++ b/client/ftp.c
@@ -52,7 +52,7 @@ struct ftp_data {
 	DBusMessage *msg;
 };
 
-static void async_cb(GObex *obex, GError *err, GObexPacket *rsp,
+static void async_cb(struct obc_session *session, GError *err,
 							gpointer user_data)
 {
 	DBusMessage *reply, *msg = user_data;
@@ -72,7 +72,6 @@ static DBusMessage *change_folder(DBusConnection *connection,
 {
 	struct ftp_data *ftp = user_data;
 	struct obc_session *session = ftp->session;
-	GObex *obex = obc_session_get_obex(session);
 	const char *folder;
 	GError *err = NULL;
 
@@ -82,7 +81,7 @@ static DBusMessage *change_folder(DBusConnection *connection,
 		return g_dbus_create_error(message,
 				"org.openobex.Error.InvalidArguments", NULL);
 
-	g_obex_setpath(obex, folder, async_cb, message, &err);
+	obc_session_setpath(session, folder, async_cb, message, &err);
 	if (err != NULL) {
 		DBusMessage *reply;
 		reply =  g_dbus_create_error(message,
@@ -235,7 +234,6 @@ static DBusMessage *create_folder(DBusConnection *connection,
 {
 	struct ftp_data *ftp = user_data;
 	struct obc_session *session = ftp->session;
-	GObex *obex = obc_session_get_obex(session);
 	const char *folder;
 	GError *err = NULL;
 
@@ -245,7 +243,7 @@ static DBusMessage *create_folder(DBusConnection *connection,
 		return g_dbus_create_error(message,
 				"org.openobex.Error.InvalidArguments", NULL);
 
-	g_obex_mkdir(obex, folder, async_cb, message, &err);
+	obc_session_mkdir(session, folder, async_cb, message, &err);
 	if (err != NULL) {
 		DBusMessage *reply;
 		reply = g_dbus_create_error(message,
@@ -340,7 +338,6 @@ static DBusMessage *copy_file(DBusConnection *connection,
 {
 	struct ftp_data *ftp = user_data;
 	struct obc_session *session = ftp->session;
-	GObex *obex = obc_session_get_obex(session);
 	const char *filename, *destname;
 	GError *err = NULL;
 
@@ -351,7 +348,7 @@ static DBusMessage *copy_file(DBusConnection *connection,
 		return g_dbus_create_error(message,
 				"org.openobex.Error.InvalidArguments", NULL);
 
-	g_obex_copy(obex, filename, destname, async_cb, message, &err);
+	obc_session_copy(session, filename, destname, async_cb, message, &err);
 	if (err != NULL) {
 		DBusMessage *reply;
 		reply = g_dbus_create_error(message,
@@ -371,7 +368,6 @@ static DBusMessage *move_file(DBusConnection *connection,
 {
 	struct ftp_data *ftp = user_data;
 	struct obc_session *session = ftp->session;
-	GObex *obex = obc_session_get_obex(session);
 	const char *filename, *destname;
 	GError *err = NULL;
 
@@ -382,7 +378,7 @@ static DBusMessage *move_file(DBusConnection *connection,
 		return g_dbus_create_error(message,
 				"org.openobex.Error.InvalidArguments", NULL);
 
-	g_obex_move(obex, filename, destname, async_cb, message, &err);
+	obc_session_move(session, filename, destname, async_cb, message, &err);
 	if (err != NULL) {
 		DBusMessage *reply;
 		reply = g_dbus_create_error(message,
@@ -402,7 +398,6 @@ static DBusMessage *delete(DBusConnection *connection,
 {
 	struct ftp_data *ftp = user_data;
 	struct obc_session *session = ftp->session;
-	GObex *obex = obc_session_get_obex(session);
 	const char *file;
 	GError *err = NULL;
 
@@ -412,7 +407,7 @@ static DBusMessage *delete(DBusConnection *connection,
 		return g_dbus_create_error(message,
 				"org.openobex.Error.InvalidArguments", NULL);
 
-	g_obex_delete(obex, file, async_cb, message, &err);
+	obc_session_delete(session, file, async_cb, message, &err);
 	if (err != NULL) {
 		DBusMessage *reply;
 		reply = g_dbus_create_error(message,
-- 
1.7.7.6

