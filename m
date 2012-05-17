Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH BlueZ v6 09/15] gdbus: loop over args to check message signature
Date: Thu, 17 May 2012 15:20:06 -0300
Message-Id: <1337278812-4837-10-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1337278812-4837-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1337278812-4837-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 gdbus/object.c |   34 +++++++++++++++++++++++++++-------
 1 file changed, 27 insertions(+), 7 deletions(-)

diff --git a/gdbus/object.c b/gdbus/object.c
index 3ac6a0b..b187bb5 100644
--- a/gdbus/object.c
+++ b/gdbus/object.c
@@ -374,6 +374,27 @@ static struct interface_data *find_interface(GSList *interfaces,
 	return NULL;
 }
 
+static gboolean g_dbus_args_have_signature(const GDBusArgInfo *args,
+							DBusMessage *message)
+{
+	const char *sig = dbus_message_get_signature(message);
+	const char *p = NULL;
+
+	for (; args && args->signature && *sig; args++) {
+		p = args->signature;
+
+		for (; *sig && *p; sig++, p++) {
+			if (*p != *sig)
+				return FALSE;
+		}
+	}
+
+	if (*sig || (p && *p) || (args && args->signature))
+		return FALSE;
+
+	return TRUE;
+}
+
 static DBusHandlerResult generic_message(DBusConnection *connection,
 					DBusMessage *message, void *user_data)
 {
@@ -394,8 +415,8 @@ static DBusHandlerResult generic_message(DBusConnection *connection,
 							method->name) == FALSE)
 			continue;
 
-		if (dbus_message_has_signature(message,
-						method->signature) == FALSE)
+		if (g_dbus_args_have_signature(method->in_args,
+							message) == FALSE)
 			continue;
 
 		if (check_privilege(connection, message, method,
@@ -552,7 +573,7 @@ static void object_path_unref(DBusConnection *connection, const char *path)
 
 static gboolean check_signal(DBusConnection *conn, const char *path,
 				const char *interface, const char *name,
-				const char **args)
+				const GDBusArgInfo **args)
 {
 	struct generic_data *data = NULL;
 	struct interface_data *iface;
@@ -575,7 +596,7 @@ static gboolean check_signal(DBusConnection *conn, const char *path,
 
 	for (signal = iface->signals; signal && signal->name; signal++) {
 		if (!strcmp(signal->name, name)) {
-			*args = signal->signature;
+			*args = signal->args;
 			break;
 		}
 	}
@@ -597,7 +618,7 @@ static dbus_bool_t emit_signal_valist(DBusConnection *conn,
 {
 	DBusMessage *signal;
 	dbus_bool_t ret;
-	const char *signature, *args;
+	const GDBusArgInfo *args;
 
 	if (!check_signal(conn, path, interface, name, &args))
 		return FALSE;
@@ -612,8 +633,7 @@ static dbus_bool_t emit_signal_valist(DBusConnection *conn,
 	if (!ret)
 		goto fail;
 
-	signature = dbus_message_get_signature(signal);
-	if (strcmp(args, signature) != 0) {
+	if (g_dbus_args_have_signature(args, signal) == FALSE) {
 		error("%s.%s: expected signature'%s' but got '%s'",
 				interface, name, args, signature);
 		ret = FALSE;
-- 
1.7.10.2

