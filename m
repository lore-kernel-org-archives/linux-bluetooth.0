Return-Path: <cyrus@holtmann.org>
From: =?iso-8859-2?Q?RISK=D3?= Gergely <gergely@risko.hu>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Add introspection interface to the output of introspection calls.
References: <87eiqq3ge7.fsf@bubble.risko.hu>
Date: Wed, 02 Sep 2009 13:00:06 +0300
In-Reply-To: <87eiqq3ge7.fsf@bubble.risko.hu> (=?iso-8859-2?Q?=22RISK=D3?=
 Gergely"'s message of
	"Tue, 01 Sep 2009 17:10:08 +0300")
Message-ID: <87k50hoee1.fsf@bubble.risko.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


---
 gdbus/object.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

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
-- 
1.6.0.4

Sorry about the previous patch, now I have used git format-patch instead
of attaching the diff by hand.
