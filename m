Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [BlueZ v3 07/10] gdbus: add Deprecated annotation to introspection
Date: Fri, 27 Apr 2012 18:14:42 -0300
Message-Id: <1335561285-3332-8-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1335561285-3332-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1335561285-3332-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 gdbus/object.c |   18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/gdbus/object.c b/gdbus/object.c
index acbaad0..52803c0 100644
--- a/gdbus/object.c
+++ b/gdbus/object.c
@@ -160,7 +160,10 @@ static void generate_interface_xml(GString *gstr, struct interface_data *iface)
 	const GDBusSignalTable *signal;
 
 	for (method = iface->methods; method && method->name; method++) {
-		if (!strlen(method->decorated_signature) &&
+		gboolean deprecated = method->flags &
+						G_DBUS_METHOD_FLAG_DEPRECATED;
+
+		if (!deprecated && !strlen(method->decorated_signature) &&
 					!strlen(method->decorated_reply))
 			g_string_append_printf(gstr, "\t\t<method name=\"%s\"/>\n",
 								method->name);
@@ -169,18 +172,29 @@ static void generate_interface_xml(GString *gstr, struct interface_data *iface)
 								method->name);
 			print_arguments(gstr, method->decorated_signature, "in");
 			print_arguments(gstr, method->decorated_reply, "out");
+
+			if (deprecated)
+				g_string_append_printf(gstr, "\t\t\t<annotation name=\"org.freedesktop.DBus.Deprecated\" value=\"true\"/>\n");
+
 			g_string_append_printf(gstr, "\t\t</method>\n");
 		}
 	}
 
 	for (signal = iface->signals; signal && signal->name; signal++) {
-		if (!strlen(signal->decorated_signature))
+		gboolean deprecated = signal->flags &
+						G_DBUS_SIGNAL_FLAG_DEPRECATED;
+
+		if (!deprecated && !strlen(signal->decorated_signature))
 			g_string_append_printf(gstr, "\t\t<signal name=\"%s\"/>\n",
 								signal->name);
 		else {
 			g_string_append_printf(gstr, "\t\t<signal name=\"%s\">\n",
 								signal->name);
 			print_arguments(gstr, signal->decorated_signature, NULL);
+
+			if (deprecated)
+				g_string_append_printf(gstr, "\t\t\t<annotation name=\"org.freedesktop.DBus.Deprecated\" value=\"true\"/>\n");
+
 			g_string_append_printf(gstr, "\t\t</signal>\n");
 		}
 	}
-- 
1.7.10

