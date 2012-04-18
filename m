Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH BlueZ 4/5] gdbus: use argument name in method introspection
Date: Wed, 18 Apr 2012 13:48:01 -0300
Message-Id: <1334767682-27121-4-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1334767682-27121-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1334767682-27121-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 gdbus/object.c |   34 +++++++++++++++++++++++++++++-----
 1 file changed, 29 insertions(+), 5 deletions(-)

diff --git a/gdbus/object.c b/gdbus/object.c
index bfd1873..3f82865 100644
--- a/gdbus/object.c
+++ b/gdbus/object.c
@@ -66,6 +66,7 @@ static void print_arguments(GString *gstr, const char *sig,
 	int i;
 
 	for (i = 0; sig[i]; i++) {
+		char name[64];
 		char type[32];
 		int struct_level, dict_level;
 		unsigned int len;
@@ -113,15 +114,38 @@ static void print_arguments(GString *gstr, const char *sig,
 		}
 
 		type[len + 1] = '\0';
+		len = 0;
+
+		/* Check if there is an arg name */
+		if (sig[i + 1] == '[') {
+			len = sizeof(" name=\"") - 1;
+			memcpy(name, " name=\"", len);
+
+			for (i += 2; len < (sizeof(name) - 1); i++, len++) {
+				if (sig[i] == '\0') {
+					error("Unexpected signature: %s", sig);
+					return;
+				}
+
+				if (sig[i] == ']')
+					break;
+
+				name[len] = sig[i];
+			}
+
+			name[len++] = '\"';
+		}
+
+		name[len] = '\0';
 
 		if (direction)
 			g_string_append_printf(gstr,
-					"\t\t\t<arg type=\"%s\" direction=\"%s\"/>\n",
-					type, direction);
+					"\t\t\t<arg%s type=\"%s\" direction=\"%s\"/>\n",
+					name, type, direction);
 		else
 			g_string_append_printf(gstr,
-					"\t\t\t<arg type=\"%s\"/>\n",
-					type);
+					"\t\t\t<arg%s type=\"%s\"/>\n",
+					name, type);
 	}
 }
 
@@ -137,7 +161,7 @@ static void generate_interface_xml(GString *gstr, struct interface_data *iface)
 		else {
 			g_string_append_printf(gstr, "\t\t<method name=\"%s\">\n",
 								method->name);
-			print_arguments(gstr, method->signature, "in");
+			print_arguments(gstr, method->decorated_signature, "in");
 			print_arguments(gstr, method->reply, "out");
 			g_string_append_printf(gstr, "\t\t</method>\n");
 		}
-- 
1.7.10

