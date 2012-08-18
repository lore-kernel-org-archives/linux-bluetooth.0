Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH BlueZ v3 07/15] gdbus: Add properties into Introspectable interface
Date: Sat, 18 Aug 2012 03:50:54 -0300
Message-Id: <1345272662-2850-8-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1345272662-2850-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1345272662-2850-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 gdbus/object.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/gdbus/object.c b/gdbus/object.c
index 22b8ebb..df75116 100644
--- a/gdbus/object.c
+++ b/gdbus/object.c
@@ -90,6 +90,7 @@ static void generate_interface_xml(GString *gstr, struct interface_data *iface)
 {
 	const GDBusMethodTable *method;
 	const GDBusSignalTable *signal;
+	const GDBusPropertyTable *property;
 
 	for (method = iface->methods; method && method->name; method++) {
 		gboolean deprecated = method->flags &
@@ -142,6 +143,24 @@ static void generate_interface_xml(GString *gstr, struct interface_data *iface)
 			g_string_append_printf(gstr, "\t\t</signal>\n");
 		}
 	}
+
+	for (property = iface->properties; property && property->name;
+								property++) {
+		gboolean deprecated = property->flags &
+					G_DBUS_PROPERTY_FLAG_DEPRECATED;
+
+		g_string_append_printf(gstr, "\t\t<property name=\"%s\""
+					" type=\"%s\" access=\"%s%s\"",
+					property->name,	property->type,
+					property->get ? "read" : "",
+					property->set ? "write" : "");
+
+		if (!deprecated)
+			g_string_append_printf(gstr, "/>\n");
+		else
+			g_string_append_printf(gstr,
+				G_DBUS_ANNOTATE_DEPRECATED(">\n\t\t\t"));
+	}
 }
 
 static void generate_introspection_xml(DBusConnection *conn,
-- 
1.7.11.5

