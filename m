Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH BlueZ v4 02/15] gdbus: Use macros to add annotations
Date: Thu,  4 Oct 2012 04:26:26 -0300
Message-Id: <1349335599-12443-3-git-send-email-lucas.de.marchi@gmail.com>
In-Reply-To: <1349335599-12443-1-git-send-email-lucas.de.marchi@gmail.com>
References: <1349335599-12443-1-git-send-email-lucas.de.marchi@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Lucas De Marchi <lucas.demarchi@profusion.mobi>

Besides being more readable this way it avoids going over 80 chars.
---
 gdbus/object.c | 40 ++++++++++++++++++++++++++++------------
 1 file changed, 28 insertions(+), 12 deletions(-)

diff --git a/gdbus/object.c b/gdbus/object.c
index 9689006..24e8285 100644
--- a/gdbus/object.c
+++ b/gdbus/object.c
@@ -76,6 +76,16 @@ static void print_arguments(GString *gstr, const GDBusArgInfo *args,
 	}
 }
 
+#define G_DBUS_ANNOTATE(prefix_, name_, value_)				\
+	prefix_ "<annotation name=\"org.freedesktop.DBus." name_ "\" "	\
+	"value=\"" value_ "\"/>\n"
+
+#define G_DBUS_ANNOTATE_DEPRECATED(prefix_) \
+	G_DBUS_ANNOTATE(prefix_, "Deprecated", "true")
+
+#define G_DBUS_ANNOTATE_NOREPLY(prefix_) \
+	G_DBUS_ANNOTATE(prefix_, "Method.NoReply", "true")
+
 static void generate_interface_xml(GString *gstr, struct interface_data *iface)
 {
 	const GDBusMethodTable *method;
@@ -90,19 +100,22 @@ static void generate_interface_xml(GString *gstr, struct interface_data *iface)
 		if (!deprecated && !noreply &&
 				!(method->in_args && method->in_args->name) &&
 				!(method->out_args && method->out_args->name))
-			g_string_append_printf(gstr, "\t\t<method name=\"%s\"/>\n",
-								method->name);
+			g_string_append_printf(gstr,
+						"\t\t<method name=\"%s\"/>\n",
+						method->name);
 		else {
-			g_string_append_printf(gstr, "\t\t<method name=\"%s\">\n",
-								method->name);
+			g_string_append_printf(gstr,
+						"\t\t<method name=\"%s\">\n",
+						method->name);
 			print_arguments(gstr, method->in_args, "in");
 			print_arguments(gstr, method->out_args, "out");
 
 			if (deprecated)
-				g_string_append_printf(gstr, "\t\t\t<annotation name=\"org.freedesktop.DBus.Deprecated\" value=\"true\"/>\n");
-
+				g_string_append_printf(gstr,
+					G_DBUS_ANNOTATE_DEPRECATED("\t\t\t"));
 			if (noreply)
-				g_string_append_printf(gstr, "\t\t\t<annotation name=\"org.freedesktop.DBus.Method.NoReply\" value=\"true\"/>\n");
+				g_string_append_printf(gstr,
+					G_DBUS_ANNOTATE_NOREPLY("\t\t\t"));
 
 			g_string_append_printf(gstr, "\t\t</method>\n");
 		}
@@ -113,15 +126,18 @@ static void generate_interface_xml(GString *gstr, struct interface_data *iface)
 						G_DBUS_SIGNAL_FLAG_DEPRECATED;
 
 		if (!deprecated && !(signal->args && signal->args->name))
-			g_string_append_printf(gstr, "\t\t<signal name=\"%s\"/>\n",
-								signal->name);
+			g_string_append_printf(gstr,
+						"\t\t<signal name=\"%s\"/>\n",
+						signal->name);
 		else {
-			g_string_append_printf(gstr, "\t\t<signal name=\"%s\">\n",
-								signal->name);
+			g_string_append_printf(gstr,
+						"\t\t<signal name=\"%s\">\n",
+						signal->name);
 			print_arguments(gstr, signal->args, NULL);
 
 			if (deprecated)
-				g_string_append_printf(gstr, "\t\t\t<annotation name=\"org.freedesktop.DBus.Deprecated\" value=\"true\"/>\n");
+				g_string_append_printf(gstr,
+					G_DBUS_ANNOTATE_DEPRECATED("\t\t\t"));
 
 			g_string_append_printf(gstr, "\t\t</signal>\n");
 		}
-- 
1.7.12.2

