Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH BlueZ v4 07/15] gdbus: Add properties into Introspectable interface
Date: Thu,  4 Oct 2012 04:26:31 -0300
Message-Id: <1349335599-12443-8-git-send-email-lucas.de.marchi@gmail.com>
In-Reply-To: <1349335599-12443-1-git-send-email-lucas.de.marchi@gmail.com>
References: <1349335599-12443-1-git-send-email-lucas.de.marchi@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Lucas De Marchi <lucas.demarchi@profusion.mobi>

---
 gdbus/object.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/gdbus/object.c b/gdbus/object.c
index 4509f76..c145328 100644
--- a/gdbus/object.c
+++ b/gdbus/object.c
@@ -95,6 +95,7 @@ static void generate_interface_xml(GString *gstr, struct interface_data *iface)
 {
 	const GDBusMethodTable *method;
 	const GDBusSignalTable *signal;
+	const GDBusPropertyTable *property;
 
 	for (method = iface->methods; method && method->name; method++) {
 		gboolean deprecated = method->flags &
@@ -147,6 +148,24 @@ static void generate_interface_xml(GString *gstr, struct interface_data *iface)
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
1.7.12.2

