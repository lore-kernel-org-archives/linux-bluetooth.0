Return-Path: <cyrus@holtmann.org>
From: =?iso-8859-2?Q?RISK=D3?= Gergely <gergely@risko.hu>
To: linux-bluetooth@vger.kernel.org,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Context Devel mailing list <context-devel@projects.maemo.org>
Subject: Re: [PATCH] Add introspection interface to the output of introspection calls.
References: <87eiqq3ge7.fsf@bubble.risko.hu> <87k50hoee1.fsf@bubble.risko.hu>
	<2d5a2c100909020746t63bcd89bj1b25d053a6f4f9ca@mail.gmail.com>
	<87pra9nspo.fsf@bubble.risko.hu> <20090914141816.GA17774@jh-x301>
Date: Mon, 14 Sep 2009 17:52:43 +0300
In-Reply-To: <20090914141816.GA17774@jh-x301> (Johan Hedberg's message of
	"Mon, 14 Sep 2009 17:18:16 +0300")
Message-ID: <871vm9fuis.fsf@bubble.risko.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Mon, 14 Sep 2009 17:18:16 +0300, Johan Hedberg <johan.hedberg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> writes:

> declared as part of the XML. Could you still do the following please:

Thank you for all of your advise, here is the result.

BR,
Gergely

>From 91b64b5cd3b174317bde5f9ccf4cc1d420086eb7 Mon Sep 17 00:00:00 2001
From: Gergely Risko <gergely@risko.hu>
Date: Mon, 14 Sep 2009 17:46:29 +0300
Subject: [PATCH] Add introspection interface description into the DBus introspection replies.

---
 gdbus/object.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/gdbus/object.c b/gdbus/object.c
index 3186921..811c2e1 100644
--- a/gdbus/object.c
+++ b/gdbus/object.c
@@ -155,7 +155,13 @@ static void generate_introspection_xml(DBusConnection *conn,
 
 	gstr = g_string_new(DBUS_INTROSPECT_1_0_XML_DOCTYPE_DECL_NODE);
 
-	g_string_append_printf(gstr, "<node name=\"%s\">\n", path);
+	g_string_append_printf(gstr,
+		"<node name=\"%s\">\n"
+		"\t<interface name=\"org.freedesktop.DBus.Introspectable\">\n"
+		"\t\t<method name=\"Introspect\">\n"
+		"\t\t\t<arg name=\"xml_data\" type=\"s\" direction=\"out\"/>\n"
+		"\t\t</method>\n"
+		"\t</interface>\n", path);
 
 	for (list = data->interfaces; list; list = list->next) {
 		struct interface_data *iface = list->data;
-- 
1.6.0.4

