Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 1/3] client: add FileTransfer.MoveFile implementation
Date: Fri, 12 Aug 2011 15:46:42 +0300
Message-Id: <1313153204-16301-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 client/ftp.c |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/client/ftp.c b/client/ftp.c
index e81d443..4c04eda 100644
--- a/client/ftp.c
+++ b/client/ftp.c
@@ -316,6 +316,25 @@ static DBusMessage *copy_file(DBusConnection *connection,
 static DBusMessage *move_file(DBusConnection *connection,
 				DBusMessage *message, void *user_data)
 {
+	struct ftp_data *ftp = user_data;
+	struct obc_session *session = ftp->session;
+	GwObex *obex = obc_session_get_obex(session);
+	const char *filename, *destname;
+	int err;
+
+	if (dbus_message_get_args(message, NULL,
+				DBUS_TYPE_STRING, &filename,
+				DBUS_TYPE_STRING, &destname,
+				DBUS_TYPE_INVALID) == FALSE)
+		return g_dbus_create_error(message,
+				"org.openobex.Error.InvalidArguments", NULL);
+
+	if (gw_obex_move(obex, filename, destname, &err) == FALSE) {
+		return g_dbus_create_error(message,
+				"org.openobex.Error.Failed",
+				"%s", OBEX_ResponseToString(err));
+	}
+
 	return dbus_message_new_method_return(message);
 }
 
-- 
1.7.6

