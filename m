Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [BlueZ v3 08/10] gdbus: add Method.NoReply annotation to introspection
Date: Fri, 27 Apr 2012 18:14:43 -0300
Message-Id: <1335561285-3332-9-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1335561285-3332-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1335561285-3332-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 gdbus/object.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/gdbus/object.c b/gdbus/object.c
index 52803c0..1a75b45 100644
--- a/gdbus/object.c
+++ b/gdbus/object.c
@@ -163,6 +163,9 @@ static void generate_interface_xml(GString *gstr, struct interface_data *iface)
 		gboolean deprecated = method->flags &
 						G_DBUS_METHOD_FLAG_DEPRECATED;
 
+		gboolean noreply = method->flags &
+						G_DBUS_METHOD_FLAG_NOREPLY;
+
 		if (!deprecated && !strlen(method->decorated_signature) &&
 					!strlen(method->decorated_reply))
 			g_string_append_printf(gstr, "\t\t<method name=\"%s\"/>\n",
@@ -176,6 +179,10 @@ static void generate_interface_xml(GString *gstr, struct interface_data *iface)
 			if (deprecated)
 				g_string_append_printf(gstr, "\t\t\t<annotation name=\"org.freedesktop.DBus.Deprecated\" value=\"true\"/>\n");
 
+			if (noreply)
+				g_string_append_printf(gstr, "\t\t\t<annotation name=\"org.freedesktop.DBus.Method.NoReply\" value=\"true\"/>\n");
+
+
 			g_string_append_printf(gstr, "\t\t</method>\n");
 		}
 	}
-- 
1.7.10

