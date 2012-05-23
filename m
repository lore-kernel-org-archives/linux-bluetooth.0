Return-Path: <cyrus@holtmann.org>
From: Henrique Dante de Almeida <hdante@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH 06/11] gdbus: use GDBusArgInfo to generate introspection
Date: Wed, 23 May 2012 10:20:03 -0300
Message-Id: <1337779208-3555-7-git-send-email-hdante@profusion.mobi>
In-Reply-To: <1337779208-3555-1-git-send-email-hdante@profusion.mobi>
References: <1337779208-3555-1-git-send-email-hdante@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Lucas De Marchi <lucas.demarchi@profusion.mobi>

By using GDBusArgInfo in methods and signals, the introspection
generation is much simpler and we can add each argument name.
---
 gdbus/object.c |   75 +++++++++++---------------------------------------------
 1 file changed, 14 insertions(+), 61 deletions(-)

diff --git a/gdbus/object.c b/gdbus/object.c
index 2ddc574..3ac6a0b 100644
--- a/gdbus/object.c
+++ b/gdbus/object.c
@@ -59,68 +59,20 @@ struct security_data {
 	void *iface_user_data;
 };
 
-static void print_arguments(GString *gstr, const char *sig,
+static void print_arguments(GString *gstr, const GDBusArgInfo *args,
 						const char *direction)
 {
-	int i;
-
-	for (i = 0; sig[i]; i++) {
-		char type[32];
-		int struct_level, dict_level;
-		unsigned int len;
-		gboolean complete;
-
-		complete = FALSE;
-		struct_level = dict_level = 0;
-
-		/* Gather enough data to have a single complete type */
-		for (len = 0; len < (sizeof(type) - 1) && sig[i]; len++, i++) {
-			switch (sig[i]) {
-			case '(':
-				struct_level++;
-				break;
-			case ')':
-				struct_level--;
-				if (struct_level <= 0 && dict_level <= 0)
-					complete = TRUE;
-				break;
-			case '{':
-				dict_level++;
-				break;
-			case '}':
-				dict_level--;
-				if (struct_level <= 0 && dict_level <= 0)
-					complete = TRUE;
-				break;
-			case 'a':
-				break;
-			default:
-				if (struct_level <= 0 && dict_level <= 0)
-					complete = TRUE;
-				break;
-			}
-
-			type[len] = sig[i];
-
-			if (complete)
-				break;
-		}
-
-		type[len + 1] = '\0';
-
-		if (!complete) {
-			error("Unexpected signature: %s", sig);
-			return;
-		}
+	for (; args && args->name; args++) {
+		g_string_append_printf(gstr,
+					"\t\t\t<arg name=\"%s\" type=\"%s\"",
+					args->name, args->signature);
 
 		if (direction)
 			g_string_append_printf(gstr,
-					"\t\t\t<arg type=\"%s\" direction=\"%s\"/>\n",
-					type, direction);
+					" direction=\"%s\"/>\n", direction);
 		else
-			g_string_append_printf(gstr,
-					"\t\t\t<arg type=\"%s\"/>\n",
-					type);
+			g_string_append_printf(gstr, "/>\n");
+
 	}
 }
 
@@ -130,26 +82,27 @@ static void generate_interface_xml(GString *gstr, struct interface_data *iface)
 	const GDBusSignalTable *signal;
 
 	for (method = iface->methods; method && method->name; method++) {
-		if (!strlen(method->signature) && !strlen(method->reply))
+		if (!(method->in_args && method->in_args->name) &&
+				!(method->out_args && method->out_args->name))
 			g_string_append_printf(gstr, "\t\t<method name=\"%s\"/>\n",
 								method->name);
 		else {
 			g_string_append_printf(gstr, "\t\t<method name=\"%s\">\n",
 								method->name);
-			print_arguments(gstr, method->signature, "in");
-			print_arguments(gstr, method->reply, "out");
+			print_arguments(gstr, method->in_args, "in");
+			print_arguments(gstr, method->out_args, "out");
 			g_string_append_printf(gstr, "\t\t</method>\n");
 		}
 	}
 
 	for (signal = iface->signals; signal && signal->name; signal++) {
-		if (!strlen(signal->signature))
+		if (!(signal->args && signal->args->name))
 			g_string_append_printf(gstr, "\t\t<signal name=\"%s\"/>\n",
 								signal->name);
 		else {
 			g_string_append_printf(gstr, "\t\t<signal name=\"%s\">\n",
 								signal->name);
-			print_arguments(gstr, signal->signature, NULL);
+			print_arguments(gstr, signal->args, NULL);
 			g_string_append_printf(gstr, "\t\t</signal>\n");
 		}
 	}
-- 
1.7.9.5

