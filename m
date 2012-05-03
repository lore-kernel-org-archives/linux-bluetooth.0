Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH BlueZ v4 11/13] gdbus: add Method.NoReply annotation in introspection
Date: Thu,  3 May 2012 09:29:00 -0300
Message-Id: <1336048142-1194-12-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1336048142-1194-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1336048142-1194-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 gdbus/object.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/gdbus/object.c b/gdbus/object.c
index 1511e88..e7b118c 100644
--- a/gdbus/object.c
+++ b/gdbus/object.c
@@ -84,8 +84,10 @@ static void generate_interface_xml(GString *gstr, struct interface_data *iface)
 	for (method = iface->methods; method && method->name; method++) {
 		gboolean deprecated = method->flags &
 						G_DBUS_METHOD_FLAG_DEPRECATED;
+		gboolean noreply = method->flags &
+						G_DBUS_METHOD_FLAG_NOREPLY;
 
-		if (!deprecated &&
+		if (!deprecated && !noreply &&
 				!(method->in_args && method->in_args->name) &&
 				!(method->out_args && method->out_args->name))
 			g_string_append_printf(gstr, "\t\t<method name=\"%s\"/>\n",
@@ -99,6 +101,9 @@ static void generate_interface_xml(GString *gstr, struct interface_data *iface)
 			if (deprecated)
 				g_string_append_printf(gstr, "\t\t\t<annotation name=\"org.freedesktop.DBus.Deprecated\" value=\"true\"/>\n");
 
+			if (noreply)
+				g_string_append_printf(gstr, "\t\t\t<annotation name=\"org.freedesktop.DBus.Method.NoReply\" value=\"true\"/>\n");
+
 			g_string_append_printf(gstr, "\t\t</method>\n");
 		}
 	}
-- 
1.7.10

