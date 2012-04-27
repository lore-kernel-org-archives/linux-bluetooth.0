Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [BlueZ v3 04/10] gdbus: use argument name in method introspection
Date: Fri, 27 Apr 2012 18:14:39 -0300
Message-Id: <1335561285-3332-5-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1335561285-3332-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1335561285-3332-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 gdbus/gdbus.h  |    6 ++---
 gdbus/object.c |   70 ++++++++++++++++++++++++++++++++++++++++----------------
 2 files changed, 53 insertions(+), 23 deletions(-)

diff --git a/gdbus/gdbus.h b/gdbus/gdbus.h
index a0583e6..a5843e0 100644
--- a/gdbus/gdbus.h
+++ b/gdbus/gdbus.h
@@ -84,8 +84,8 @@ typedef enum {
 
 typedef struct {
 	const char *name;
-	const char *signature;
-	const char *reply;
+	const char *decorated_signature;
+	const char *decorated_reply;
 	GDBusMethodFunction function;
 	GDBusMethodFlags flags;
 	unsigned int privilege;
@@ -93,7 +93,7 @@ typedef struct {
 
 typedef struct {
 	const char *name;
-	const char *signature;
+	const char *decorated_signature;
 	GDBusSignalFlags flags;
 } GDBusSignalTable;
 
diff --git a/gdbus/object.c b/gdbus/object.c
index 6133d8c..bae6e7f 100644
--- a/gdbus/object.c
+++ b/gdbus/object.c
@@ -69,6 +69,7 @@ static void print_arguments(GString *gstr, const char *sig,
 	int i;
 
 	for (i = 0; sig[i]; i++) {
+		const char *name;
 		char type[32];
 		int struct_level, dict_level;
 		unsigned int len;
@@ -112,19 +113,44 @@ static void print_arguments(GString *gstr, const char *sig,
 
 		type[len + 1] = '\0';
 
+		 /* Check if there is an arg name and parse it */
+		if (sig[i + 1] == '[') {
+			const char *name_end = name = &sig[i + 2];
+
+			for (;;) {
+				if (*name_end == '\0') {
+					error("Unexpected signature: %s", sig);
+					return;
+				}
+
+				if (*name_end == ']')
+					break;
+
+				name_end++;
+			}
+
+			len = name_end - name;
+			i += len + 2;
+		} else
+			name = NULL;
+
 		if (!complete) {
 			error("Unexpected signature: %s", sig);
 			return;
 		}
 
+		g_string_append_printf(gstr, "\t\t\t<arg type=\"%s\"", type);
+
 		if (direction)
-			g_string_append_printf(gstr,
-					"\t\t\t<arg type=\"%s\" direction=\"%s\"/>\n",
-					type, direction);
-		else
-			g_string_append_printf(gstr,
-					"\t\t\t<arg type=\"%s\"/>\n",
-					type);
+			g_string_append_printf(gstr, " direction=\"%s\"",
+								direction);
+
+		if (name)
+			g_string_append_printf(gstr, " name=\"%.*s\"",
+								len, name);
+
+
+		g_string_append_printf(gstr,"/>\n");
 	}
 }
 
@@ -134,26 +160,27 @@ static void generate_interface_xml(GString *gstr, struct interface_data *iface)
 	const GDBusSignalTable *signal;
 
 	for (method = iface->methods; method && method->name; method++) {
-		if (!strlen(method->signature) && !strlen(method->reply))
+		if (!strlen(method->decorated_signature) &&
+					!strlen(method->decorated_reply))
 			g_string_append_printf(gstr, "\t\t<method name=\"%s\"/>\n",
 								method->name);
 		else {
 			g_string_append_printf(gstr, "\t\t<method name=\"%s\">\n",
 								method->name);
-			print_arguments(gstr, method->signature, "in");
-			print_arguments(gstr, method->reply, "out");
+			print_arguments(gstr, method->decorated_signature, "in");
+			print_arguments(gstr, method->decorated_reply, "out");
 			g_string_append_printf(gstr, "\t\t</method>\n");
 		}
 	}
 
 	for (signal = iface->signals; signal && signal->name; signal++) {
-		if (!strlen(signal->signature))
+		if (!strlen(signal->decorated_signature))
 			g_string_append_printf(gstr, "\t\t<signal name=\"%s\"/>\n",
 								signal->name);
 		else {
 			g_string_append_printf(gstr, "\t\t<signal name=\"%s\">\n",
 								signal->name);
-			print_arguments(gstr, signal->signature, NULL);
+			print_arguments(gstr, signal->decorated_signature, NULL);
 			g_string_append_printf(gstr, "\t\t</signal>\n");
 		}
 	}
@@ -432,6 +459,7 @@ static DBusHandlerResult generic_message(DBusConnection *connection,
 	struct interface_data *iface;
 	const GDBusMethodTable *method;
 	const char *interface;
+	size_t i;
 
 	interface = dbus_message_get_interface(message);
 
@@ -439,14 +467,14 @@ static DBusHandlerResult generic_message(DBusConnection *connection,
 	if (iface == NULL)
 		return DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
 
-	for (method = iface->methods; method &&
-			method->name && method->function; method++) {
+	for (method = iface->methods, i = 0; method &&
+			method->name && method->function; method++, i++) {
 		if (dbus_message_is_method_call(message, iface->name,
 							method->name) == FALSE)
 			continue;
 
 		if (dbus_message_has_signature(message,
-						method->signature) == FALSE)
+					iface->method_signatures[i]) == FALSE)
 			continue;
 
 		if (check_privilege(connection, message, method,
@@ -550,7 +578,7 @@ static void undecorate_signals(struct interface_data *iface)
 	sigs[n] = NULL;
 
 	for (s = iface->signals, i = 0; s && s->name; s++, i++)
-		sigs[i] = undecorate_signature(s->signature);
+		sigs[i] = undecorate_signature(s->decorated_signature);
 
 	iface->signal_signatures = sigs;
 }
@@ -570,8 +598,8 @@ static void undecorate_methods(struct interface_data *iface)
 	reply_sigs[n] = NULL;
 
 	for (m = iface->methods, i = 0; m && m->name; m++, i++) {
-		sigs[i] = undecorate_signature(m->signature);
-		reply_sigs[i] = undecorate_signature(m->reply);
+		sigs[i] = undecorate_signature(m->decorated_signature);
+		reply_sigs[i] = undecorate_signature(m->decorated_reply);
 	}
 
 	iface->method_signatures = sigs;
@@ -685,6 +713,7 @@ static gboolean check_signal(DBusConnection *conn, const char *path,
 	struct generic_data *data = NULL;
 	struct interface_data *iface;
 	const GDBusSignalTable *signal;
+	size_t i;
 
 	*args = NULL;
 	if (!dbus_connection_get_object_path_data(conn, path,
@@ -701,9 +730,10 @@ static gboolean check_signal(DBusConnection *conn, const char *path,
 		return FALSE;
 	}
 
-	for (signal = iface->signals; signal && signal->name; signal++) {
+	for (signal = iface->signals, i = 0; signal && signal->name;
+							signal++, i++) {
 		if (!strcmp(signal->name, name)) {
-			*args = signal->signature;
+			*args = iface->signal_signatures[i];
 			break;
 		}
 	}
-- 
1.7.10

