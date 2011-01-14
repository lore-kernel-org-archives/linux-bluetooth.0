Return-Path: <cyrus@holtmann.org>
From: Daniel Wagner <wagi@monom.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Daniel Wagner <daniel.wagner@bmw-carit.de>
Subject: [PATCH v0 2/2] gdbus: Remove root node 'name' attribute in introspection
Date: Fri, 14 Jan 2011 16:14:21 +0100
Message-Id: <1295018061-5849-3-git-send-email-wagi@monom.org>
In-Reply-To: <1295018061-5849-1-git-send-email-wagi@monom.org>
References: <1295018061-5849-1-git-send-email-wagi@monom.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Daniel Wagner <daniel.wagner@bmw-carit.de>

generate_introspection_xml generates the root <node> tags with a
'name' attribute. This seems to be a valid attribute but it is not
consistent with the way the D-Bus daemon generates empty nodes.

For example if we register "/foo/bar", D-Bus daemon will generate for
"/foo" a introspection which looks like this:


<!DOCTYPE node PUBLIC "-//freedesktop//DTD D-BUS Object Introspection 1.0//EN"
"http://www.freedesktop.org/standards/dbus/1.0/introspect.dtd">
<node>
  <node name="bar"/>
</node>


and generate_introspection_xml generates for "/foo/bar":


<!DOCTYPE node PUBLIC "-//freedesktop//DTD D-BUS Object Introspection 1.0//EN"
"http://www.freedesktop.org/standards/dbus/1.0/introspect.dtd">
<node name="/foo/bar">
</node>


Just don't add the 'name' attribute to the root node.  The GLib
binding for D-Bus does it the same way.
---
 gdbus/object.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gdbus/object.c b/gdbus/object.c
index 49006ec..eaa2e1a 100644
--- a/gdbus/object.c
+++ b/gdbus/object.c
@@ -162,7 +162,7 @@ static void generate_introspection_xml(DBusConnection *conn,
 
 	gstr = g_string_new(DBUS_INTROSPECT_1_0_XML_DOCTYPE_DECL_NODE);
 
-	g_string_append_printf(gstr, "<node name=\"%s\">\n", path);
+	g_string_append_printf(gstr, "<node>\n");
 
 	for (list = data->interfaces; list; list = list->next) {
 		struct interface_data *iface = list->data;
-- 
1.7.3.4

