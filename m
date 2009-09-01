Return-Path: <cyrus@holtmann.org>
From: =?iso-8859-2?Q?RISK=D3?= Gergely <gergely@risko.hu>
To: linux-bluetooth@vger.kernel.org
Cc: Context Devel mailing list <context-devel@projects.maemo.org>
Subject: [PATCH] bluez git HEAD doesn't put introspection methods into the introspection output
Date: Tue, 01 Sep 2009 17:10:08 +0300
Message-ID: <87eiqq3ge7.fsf@bubble.risko.hu>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--=-=-=

Hi,

I have the following problem:
4252@17:04 errge@lisa:~$ qdbus --system org.bluez
/
Cannot introspect object / at org.bluez:
org.freedesktop.DBus.Error.UnknownInterface (Interface 'org.freedesktop.DBus.Introspectable' was not found)

This is caused by the fact that:
  - QtDBus is buggy as hell, :)
  - BlueZ doesn't include introspection API in the introspection output.

Either of the causes got solved, the whole issue is solved.  After
checking the code of QtDBus I decided to go with the second.  See the
attached patch.  After applying it everything works fine:
4252@17:04 errge@lisa:~$ qdbus --system org.bluez
/
/org
/org/bluez
/org/bluez/9746
/org/bluez/9746/any
/org/bluez/9746/hci0
/org/bluez/test

If you need clarification or have comments about any of these, please
don't hesitate to reply!

Thanks in advance,
Gergely


--=-=-=
Content-Type: text/x-diff
Content-Disposition: inline; filename=bluez-introspection.diff

diff --git a/gdbus/object.c b/gdbus/object.c
index 3186921..8091a95 100644
--- a/gdbus/object.c
+++ b/gdbus/object.c
@@ -156,6 +156,11 @@ static void generate_introspection_xml(DBusConnection *conn,
 	gstr = g_string_new(DBUS_INTROSPECT_1_0_XML_DOCTYPE_DECL_NODE);
 
 	g_string_append_printf(gstr, "<node name=\"%s\">\n", path);
+	g_string_append_printf(gstr, "\t<interface name=\"org.freedesktop.DBus.Introspectable\">\n");
+	g_string_append_printf(gstr, "\t\t<method name=\"Introspect\">\n");
+	g_string_append_printf(gstr, "\t\t\t<arg name=\"xml_data\" type=\"s\" direction=\"out\"/>\n");
+	g_string_append_printf(gstr, "\t\t</method>\n");
+	g_string_append_printf(gstr, "\t</interface>\n");
 
 	for (list = data->interfaces; list; list = list->next) {
 		struct interface_data *iface = list->data;

--=-=-=--
