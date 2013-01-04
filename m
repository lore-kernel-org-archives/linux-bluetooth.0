Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.de.marchi@gmail.com>
Subject: [PATCH BlueZ 2/3] gdbus: Simplify generated introspection
Date: Thu,  3 Jan 2013 23:21:04 -0200
Message-Id: <1357262465-19231-2-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1357262465-19231-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1357262465-19231-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Lucas De Marchi <lucas.de.marchi@gmail.com>

The generated introspection is not supposed to be read as is by human,
so there's no point in printing the indentation or writing more code to
use auto-close tags.

If it's desired to read the raw xml file, user can always use other
tools to transform the output such as "xmllint --format".

This also fixes a missing </property> when property is deprecated.
---
 gdbus/object.c | 103 +++++++++++++++++++++------------------------------------
 1 file changed, 38 insertions(+), 65 deletions(-)

diff --git a/gdbus/object.c b/gdbus/object.c
index b9cb284..2b6ae31 100644
--- a/gdbus/object.c
+++ b/gdbus/object.c
@@ -97,7 +97,7 @@ static void print_arguments(GString *gstr, const GDBusArgInfo *args,
 {
 	for (; args && args->name; args++) {
 		g_string_append_printf(gstr,
-					"\t\t\t<arg name=\"%s\" type=\"%s\"",
+					"<arg name=\"%s\" type=\"%s\"",
 					args->name, args->signature);
 
 		if (direction)
@@ -109,15 +109,15 @@ static void print_arguments(GString *gstr, const GDBusArgInfo *args,
 	}
 }
 
-#define G_DBUS_ANNOTATE(prefix_, name_, value_)				\
-	prefix_ "<annotation name=\"org.freedesktop.DBus." name_ "\" "	\
-	"value=\"" value_ "\"/>\n"
+#define G_DBUS_ANNOTATE(name_, value_)				\
+	"<annotation name=\"org.freedesktop.DBus." name_ "\" "	\
+	"value=\"" value_ "\"/>"
 
-#define G_DBUS_ANNOTATE_DEPRECATED(prefix_) \
-	G_DBUS_ANNOTATE(prefix_, "Deprecated", "true")
+#define G_DBUS_ANNOTATE_DEPRECATED \
+	G_DBUS_ANNOTATE("Deprecated", "true")
 
-#define G_DBUS_ANNOTATE_NOREPLY(prefix_) \
-	G_DBUS_ANNOTATE(prefix_, "Method.NoReply", "true")
+#define G_DBUS_ANNOTATE_NOREPLY \
+	G_DBUS_ANNOTATE("Method.NoReply", "true")
 
 static gboolean check_experimental(int flags, int flag)
 {
@@ -134,85 +134,58 @@ static void generate_interface_xml(GString *gstr, struct interface_data *iface)
 	const GDBusPropertyTable *property;
 
 	for (method = iface->methods; method && method->name; method++) {
-		gboolean deprecated = method->flags &
-						G_DBUS_METHOD_FLAG_DEPRECATED;
-		gboolean noreply = method->flags &
-						G_DBUS_METHOD_FLAG_NOREPLY;
-
 		if (check_experimental(method->flags,
 					G_DBUS_METHOD_FLAG_EXPERIMENTAL))
 			continue;
 
-		if (!deprecated && !noreply &&
-				!(method->in_args && method->in_args->name) &&
-				!(method->out_args && method->out_args->name))
-			g_string_append_printf(gstr,
-						"\t\t<method name=\"%s\"/>\n",
-						method->name);
-		else {
+		g_string_append_printf(gstr, "<method name=\"%s\">",
+								method->name);
+		print_arguments(gstr, method->in_args, "in");
+		print_arguments(gstr, method->out_args, "out");
+
+		if (method->flags & G_DBUS_METHOD_FLAG_DEPRECATED)
 			g_string_append_printf(gstr,
-						"\t\t<method name=\"%s\">\n",
-						method->name);
-			print_arguments(gstr, method->in_args, "in");
-			print_arguments(gstr, method->out_args, "out");
-
-			if (deprecated)
-				g_string_append_printf(gstr,
-					G_DBUS_ANNOTATE_DEPRECATED("\t\t\t"));
-			if (noreply)
-				g_string_append_printf(gstr,
-					G_DBUS_ANNOTATE_NOREPLY("\t\t\t"));
-
-			g_string_append_printf(gstr, "\t\t</method>\n");
-		}
+						G_DBUS_ANNOTATE_DEPRECATED);
+
+		if (method->flags & G_DBUS_METHOD_FLAG_NOREPLY)
+			g_string_append_printf(gstr, G_DBUS_ANNOTATE_NOREPLY);
+
+		g_string_append_printf(gstr, "</method>");
 	}
 
 	for (signal = iface->signals; signal && signal->name; signal++) {
-		gboolean deprecated = signal->flags &
-						G_DBUS_SIGNAL_FLAG_DEPRECATED;
-
 		if (check_experimental(signal->flags,
 					G_DBUS_SIGNAL_FLAG_EXPERIMENTAL))
 			continue;
 
-		if (!deprecated && !(signal->args && signal->args->name))
-			g_string_append_printf(gstr,
-						"\t\t<signal name=\"%s\"/>\n",
-						signal->name);
-		else {
-			g_string_append_printf(gstr,
-						"\t\t<signal name=\"%s\">\n",
-						signal->name);
-			print_arguments(gstr, signal->args, NULL);
+		g_string_append_printf(gstr, "<signal name=\"%s\">",
+								signal->name);
+		print_arguments(gstr, signal->args, NULL);
 
-			if (deprecated)
-				g_string_append_printf(gstr,
-					G_DBUS_ANNOTATE_DEPRECATED("\t\t\t"));
+		if (signal->flags & G_DBUS_SIGNAL_FLAG_DEPRECATED)
+			g_string_append_printf(gstr,
+						G_DBUS_ANNOTATE_DEPRECATED);
 
-			g_string_append_printf(gstr, "\t\t</signal>\n");
-		}
+		g_string_append_printf(gstr, "</signal>\n");
 	}
 
 	for (property = iface->properties; property && property->name;
 								property++) {
-		gboolean deprecated = property->flags &
-					G_DBUS_PROPERTY_FLAG_DEPRECATED;
-
 		if (check_experimental(property->flags,
 					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL))
 			continue;
 
-		g_string_append_printf(gstr, "\t\t<property name=\"%s\""
-					" type=\"%s\" access=\"%s%s\"",
+		g_string_append_printf(gstr, "<property name=\"%s\""
+					" type=\"%s\" access=\"%s%s\">",
 					property->name,	property->type,
 					property->get ? "read" : "",
 					property->set ? "write" : "");
 
-		if (!deprecated)
-			g_string_append_printf(gstr, "/>\n");
-		else
+		if (property->flags & G_DBUS_PROPERTY_FLAG_DEPRECATED)
 			g_string_append_printf(gstr,
-				G_DBUS_ANNOTATE_DEPRECATED(">\n\t\t\t"));
+						G_DBUS_ANNOTATE_DEPRECATED);
+
+		g_string_append_printf(gstr, "</property>");
 	}
 }
 
@@ -228,30 +201,30 @@ static void generate_introspection_xml(DBusConnection *conn,
 
 	gstr = g_string_new(DBUS_INTROSPECT_1_0_XML_DOCTYPE_DECL_NODE);
 
-	g_string_append_printf(gstr, "<node>\n");
+	g_string_append_printf(gstr, "<node>");
 
 	for (list = data->interfaces; list; list = list->next) {
 		struct interface_data *iface = list->data;
 
-		g_string_append_printf(gstr, "\t<interface name=\"%s\">\n",
+		g_string_append_printf(gstr, "<interface name=\"%s\">",
 								iface->name);
 
 		generate_interface_xml(gstr, iface);
 
-		g_string_append_printf(gstr, "\t</interface>\n");
+		g_string_append_printf(gstr, "</interface>");
 	}
 
 	if (!dbus_connection_list_registered(conn, path, &children))
 		goto done;
 
 	for (i = 0; children[i]; i++)
-		g_string_append_printf(gstr, "\t<node name=\"%s\"/>\n",
+		g_string_append_printf(gstr, "<node name=\"%s\"/>",
 								children[i]);
 
 	dbus_free_string_array(children);
 
 done:
-	g_string_append_printf(gstr, "</node>\n");
+	g_string_append_printf(gstr, "</node>");
 
 	data->introspect = g_string_free(gstr, FALSE);
 }
-- 
1.8.1

