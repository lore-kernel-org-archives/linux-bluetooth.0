Return-Path: <cyrus@holtmann.org>
From: Henrique Dante de Almeida <hdante@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH 10/11] gdbus: add Deprecated annotation in introspection
Date: Wed, 23 May 2012 10:20:07 -0300
Message-Id: <1337779208-3555-11-git-send-email-hdante@profusion.mobi>
In-Reply-To: <1337779208-3555-1-git-send-email-hdante@profusion.mobi>
References: <1337779208-3555-1-git-send-email-hdante@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Lucas De Marchi <lucas.demarchi@profusion.mobi>

---
 gdbus/object.c |   19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/gdbus/object.c b/gdbus/object.c
index fcdd6ec..95947f3 100644
--- a/gdbus/object.c
+++ b/gdbus/object.c
@@ -82,7 +82,11 @@ static void generate_interface_xml(GString *gstr, struct interface_data *iface)
 	const GDBusSignalTable *signal;
 
 	for (method = iface->methods; method && method->name; method++) {
-		if (!(method->in_args && method->in_args->name) &&
+		gboolean deprecated = method->flags &
+						G_DBUS_METHOD_FLAG_DEPRECATED;
+
+		if (!deprecated &&
+				!(method->in_args && method->in_args->name) &&
 				!(method->out_args && method->out_args->name))
 			g_string_append_printf(gstr, "\t\t<method name=\"%s\"/>\n",
 								method->name);
@@ -91,18 +95,29 @@ static void generate_interface_xml(GString *gstr, struct interface_data *iface)
 								method->name);
 			print_arguments(gstr, method->in_args, "in");
 			print_arguments(gstr, method->out_args, "out");
+
+			if (deprecated)
+				g_string_append_printf(gstr, "\t\t\t<annotation name=\"org.freedesktop.DBus.Deprecated\" value=\"true\"/>\n");
+
 			g_string_append_printf(gstr, "\t\t</method>\n");
 		}
 	}
 
 	for (signal = iface->signals; signal && signal->name; signal++) {
-		if (!(signal->args && signal->args->name))
+		gboolean deprecated = signal->flags &
+						G_DBUS_SIGNAL_FLAG_DEPRECATED;
+
+		if (!deprecated && !(signal->args && signal->args->name))
 			g_string_append_printf(gstr, "\t\t<signal name=\"%s\"/>\n",
 								signal->name);
 		else {
 			g_string_append_printf(gstr, "\t\t<signal name=\"%s\">\n",
 								signal->name);
 			print_arguments(gstr, signal->args, NULL);
+
+			if (deprecated)
+				g_string_append_printf(gstr, "\t\t\t<annotation name=\"org.freedesktop.DBus.Deprecated\" value=\"true\"/>\n");
+
 			g_string_append_printf(gstr, "\t\t</signal>\n");
 		}
 	}
-- 
1.7.9.5

