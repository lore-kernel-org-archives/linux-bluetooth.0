Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [RFC 1/2] gdbus: Add argument name to introspection xml
Date: Tue, 15 Nov 2011 03:43:52 -0200
Message-Id: <1321335833-16907-2-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1321335833-16907-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1321335833-16907-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 gdbus/gdbus.h  |    1 +
 gdbus/object.c |   37 ++++++++++++++++++++++++++-----------
 2 files changed, 27 insertions(+), 11 deletions(-)

diff --git a/gdbus/gdbus.h b/gdbus/gdbus.h
index a0583e6..dcd6c1e 100644
--- a/gdbus/gdbus.h
+++ b/gdbus/gdbus.h
@@ -89,6 +89,7 @@ typedef struct {
 	GDBusMethodFunction function;
 	GDBusMethodFlags flags;
 	unsigned int privilege;
+	const char *arg_names;
 } GDBusMethodTable;
 
 typedef struct {
diff --git a/gdbus/object.c b/gdbus/object.c
index 8bc12f5..d7108d6 100644
--- a/gdbus/object.c
+++ b/gdbus/object.c
@@ -60,11 +60,15 @@ struct security_data {
 };
 
 static void print_arguments(GString *gstr, const char *sig,
-						const char *direction)
+				const char *arg_names, const char *direction)
 {
-	int i;
+	int i, j;
+	gchar **names;
+
+	if (arg_names != NULL)
+		names = g_strsplit(arg_names, ",", 0);
 
-	for (i = 0; sig[i]; i++) {
+	for (j = 0, i = 0; sig[i]; i++) {
 		char type[32];
 		int struct_level, dict_level;
 		unsigned int len;
@@ -107,16 +111,26 @@ static void print_arguments(GString *gstr, const char *sig,
 				break;
 		}
 
+		if (arg_names != NULL && names[j] != NULL) {
+			g_string_append_printf(gstr,
+					"\t\t\t<arg name=\"%s\" type=\"%s\"",
+					names[j], type);
+			j++;
+		} else
+			g_string_append_printf(gstr,
+					"\t\t\t<arg type=\"%s\"",
+					type);
 
 		if (direction)
 			g_string_append_printf(gstr,
-					"\t\t\t<arg type=\"%s\" direction=\"%s\"/>\n",
-					type, direction);
+					" direction=\"%s\"/>\n",
+					direction);
 		else
-			g_string_append_printf(gstr,
-					"\t\t\t<arg type=\"%s\"/>\n",
-					type);
+			g_string_append_printf(gstr, "/>\n");
 	}
+
+	if (arg_names != NULL)
+		g_strfreev(names);
 }
 
 static void generate_interface_xml(GString *gstr, struct interface_data *iface)
@@ -131,8 +145,9 @@ static void generate_interface_xml(GString *gstr, struct interface_data *iface)
 		else {
 			g_string_append_printf(gstr, "\t\t<method name=\"%s\">\n",
 								method->name);
-			print_arguments(gstr, method->signature, "in");
-			print_arguments(gstr, method->reply, "out");
+			print_arguments(gstr, method->signature,
+						method->arg_names, "in");
+			print_arguments(gstr, method->reply, NULL, "out");
 			g_string_append_printf(gstr, "\t\t</method>\n");
 		}
 	}
@@ -144,7 +159,7 @@ static void generate_interface_xml(GString *gstr, struct interface_data *iface)
 		else {
 			g_string_append_printf(gstr, "\t\t<signal name=\"%s\">\n",
 								signal->name);
-			print_arguments(gstr, signal->signature, NULL);
+			print_arguments(gstr, signal->signature, NULL, NULL);
 			g_string_append_printf(gstr, "\t\t</signal>\n");
 		}
 	}
-- 
1.7.7.3

