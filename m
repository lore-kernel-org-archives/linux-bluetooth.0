Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH BlueZ 5/5] gdbus: Add properties into Introspectable interface
Date: Thu, 19 Jul 2012 00:20:08 -0300
Message-Id: <1342668008-5522-6-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1342668008-5522-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1342668008-5522-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 gdbus/object.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/gdbus/object.c b/gdbus/object.c
index c19f1d7..e2e8b12 100644
--- a/gdbus/object.c
+++ b/gdbus/object.c
@@ -80,6 +80,7 @@ static void generate_interface_xml(GString *gstr, struct interface_data *iface)
 {
 	const GDBusMethodTable *method;
 	const GDBusSignalTable *signal;
+	const GDBusPropertyTable *property;
 
 	for (method = iface->methods; method && method->name; method++) {
 		gboolean deprecated = method->flags &
@@ -126,6 +127,26 @@ static void generate_interface_xml(GString *gstr, struct interface_data *iface)
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
+					"type=\"%s\" access=\"%s%s\"",
+					property->name,	property->type,
+					property->get ? "read" : "",
+					property->set ? "write" : "");
+
+		if (!deprecated)
+			g_string_append_printf(gstr, "/>\n");
+		else
+			g_string_append_printf(gstr,
+				">\n\t\t\t<annotation"
+				" name=\"org.freedesktop.DBus.Deprecated\""
+				" value=\"true\"/>\n\t\t</property>\n");
+	}
 }
 
 static void generate_introspection_xml(DBusConnection *conn,
-- 
1.7.11.2

