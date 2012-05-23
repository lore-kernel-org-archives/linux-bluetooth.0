Return-Path: <cyrus@holtmann.org>
From: Henrique Dante de Almeida <hdante@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH 11/11] gdbus: add Method.NoReply annotation in introspection
Date: Wed, 23 May 2012 10:20:08 -0300
Message-Id: <1337779208-3555-12-git-send-email-hdante@profusion.mobi>
In-Reply-To: <1337779208-3555-1-git-send-email-hdante@profusion.mobi>
References: <1337779208-3555-1-git-send-email-hdante@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Lucas De Marchi <lucas.demarchi@profusion.mobi>

---
 gdbus/object.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/gdbus/object.c b/gdbus/object.c
index 95947f3..dacbe58 100644
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
1.7.9.5

