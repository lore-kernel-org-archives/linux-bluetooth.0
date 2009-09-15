Return-Path: <cyrus@holtmann.org>
From: =?iso-8859-2?Q?RISK=D3?= Gergely <gergely@risko.hu>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Context Devel mailing list <context-devel@projects.maemo.org>
Subject: Re: [PATCH] Add introspection interface to the output of  introspection calls.
References: <87eiqq3ge7.fsf@bubble.risko.hu> <87k50hoee1.fsf@bubble.risko.hu>
	<2d5a2c100909020746t63bcd89bj1b25d053a6f4f9ca@mail.gmail.com>
	<87pra9nspo.fsf@bubble.risko.hu> <20090914141816.GA17774@jh-x301>
	<871vm9fuis.fsf@bubble.risko.hu> <20090914211145.GA16947@jh-x301>
	<2d5a2c100909150350r2e453cb6h5c4fe95c8638f9e9@mail.gmail.com>
Date: Tue, 15 Sep 2009 15:28:36 +0300
In-Reply-To: <2d5a2c100909150350r2e453cb6h5c4fe95c8638f9e9@mail.gmail.com>
	(Luiz Augusto von Dentz's message of "Tue, 15 Sep 2009 07:50:42
	-0300")
Message-ID: <87ws40e6iz.fsf@bubble.risko.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Thank you for the comments, you are both right, Introspection should be
handled generally and not specially in the code.  So I have done the
necessary modifications and modified the handling of introspection calls
in gdbus/object.c to use the generic_message infrastructure.

Comments?

Cheers,
Gergely

>From 2188640a694ba9dd14f59ed250f8a37f3a1bec34 Mon Sep 17 00:00:00 2001
From: Gergely Risko <gergely+context@risko.hu>
Date: Tue, 15 Sep 2009 15:23:24 +0300
Subject: [PATCH] gdbus: handle introspection generally in generic_message.

Previously it was a specific case, now introspection is just another
interface, which is always implemented.  It is registered/unregistered
when an object path is referenced first/last.
---
 gdbus/object.c |   57 +++++++++++++++++++++++++++++++++++--------------------
 1 files changed, 36 insertions(+), 21 deletions(-)

diff --git a/gdbus/object.c b/gdbus/object.c
index 811c2e1..3b6d3f2 100644
--- a/gdbus/object.c
+++ b/gdbus/object.c
@@ -155,13 +155,7 @@ static void generate_introspection_xml(DBusConnection *conn,
 
 	gstr = g_string_new(DBUS_INTROSPECT_1_0_XML_DOCTYPE_DECL_NODE);
 
-	g_string_append_printf(gstr,
-		"<node name=\"%s\">\n"
-		"\t<interface name=\"org.freedesktop.DBus.Introspectable\">\n"
-		"\t\t<method name=\"Introspect\">\n"
-		"\t\t\t<arg name=\"xml_data\" type=\"s\" direction=\"out\"/>\n"
-		"\t\t</method>\n"
-		"\t</interface>\n", path);
+	g_string_append_printf(gstr, "<node name=\"%s\">\n", path);
 
 	for (list = data->interfaces; list; list = list->next) {
 		struct interface_data *iface = list->data;
@@ -189,14 +183,15 @@ done:
 	data->introspect = g_string_free(gstr, FALSE);
 }
 
-static DBusHandlerResult introspect(DBusConnection *connection,
-				DBusMessage *message, struct generic_data *data)
+static DBusMessage *introspect(DBusConnection *connection,
+				DBusMessage *message, void *data_)
 {
+	struct generic_data *data = (struct generic_data *) data_;
 	DBusMessage *reply;
 
 	if (!dbus_message_has_signature(message, DBUS_TYPE_INVALID_AS_STRING)) {
 		error("Unexpected signature to introspect call");
-		return DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
+		return NULL;
 	}
 
 	if (!data->introspect)
@@ -205,16 +200,12 @@ static DBusHandlerResult introspect(DBusConnection *connection,
 
 	reply = dbus_message_new_method_return(message);
 	if (!reply)
-		return DBUS_HANDLER_RESULT_NEED_MEMORY;
+		return NULL;
 
 	dbus_message_append_args(reply, DBUS_TYPE_STRING, &data->introspect,
 					DBUS_TYPE_INVALID);
 
-	dbus_connection_send(connection, reply, NULL);
-
-	dbus_message_unref(reply);
-
-	return DBUS_HANDLER_RESULT_HANDLED;
+	return reply;
 }
 
 static void generic_unregister(DBusConnection *connection, void *user_data)
@@ -250,11 +241,6 @@ static DBusHandlerResult generic_message(DBusConnection *connection,
 	GDBusMethodTable *method;
 	const char *interface;
 
-	if (dbus_message_is_method_call(message,
-					DBUS_INTERFACE_INTROSPECTABLE,
-								"Introspect"))
-		return introspect(connection, message, data);
-
 	interface = dbus_message_get_interface(message);
 
 	iface = find_interface(data->interfaces, interface);
@@ -335,10 +321,16 @@ done:
 	g_free(parent_path);
 }
 
+static GDBusMethodTable introspect_methods[] = {
+	{ "Introspect",	"",	"s", introspect	},
+	{ }
+};
+
 static struct generic_data *object_path_ref(DBusConnection *connection,
 							const char *path)
 {
 	struct generic_data *data;
+	struct interface_data *iface;
 
 	if (dbus_connection_get_object_path_data(connection, path,
 						(void *) &data) == TRUE) {
@@ -363,12 +355,23 @@ static struct generic_data *object_path_ref(DBusConnection *connection,
 
 	invalidate_parent_data(connection, path);
 
+	/* Register the introspection interface */
+	iface = g_new0(struct interface_data, 1);
+	iface->name = g_strdup("org.freedesktop.DBus.Introspectable"); // TODO: macro
+	iface->methods = introspect_methods;
+	iface->signals = NULL;
+	iface->properties = NULL;
+	iface->user_data = data;
+	iface->destroy = NULL;
+	data->interfaces = g_slist_append(data->interfaces, iface);
+
 	return data;
 }
 
 static void object_path_unref(DBusConnection *connection, const char *path)
 {
 	struct generic_data *data = NULL;
+	struct interface_data *iface;
 
 	if (dbus_connection_get_object_path_data(connection, path,
 						(void *) &data) == FALSE)
@@ -382,6 +385,18 @@ static void object_path_unref(DBusConnection *connection, const char *path)
 	if (data->refcount > 0)
 		return;
 
+	/* Free the introspection interface */
+	iface = find_interface(data->interfaces, "org.freedesktop.DBus.Introspectable");
+	if (iface) {
+		data->interfaces = g_slist_remove(data->interfaces, iface);
+
+		if (iface->destroy)
+			iface->destroy(iface->user_data);
+
+		g_free(iface->name);
+		g_free(iface);
+	}
+
 	invalidate_parent_data(connection, path);
 
 	dbus_connection_unregister_object_path(connection, path);
-- 
1.6.0.4



On Tue, 15 Sep 2009 07:50:42 -0300, Luiz Augusto von Dentz <luiz.dentz@gmail.com> writes:

> Hi,
>
> On Mon, Sep 14, 2009 at 6:11 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
>> Thanks! The patch has now been pushed upstream.
>>
>> One thing that came to my mind is that it might be possible to simplify
>> the code by making the introspection interface less of a special case
>> within gdbus:
>>
>> Instead of hard coding this XML snippet and handling the Introspect method
>> call separately from the rest of the method calls for a particular object
>> path gdbus could use its own public interface registration system
>> (i.e. g_dbus_register_interface) to implicitly register the Introspectable
>> interface as the first interface when creating new object paths. This way
>> the existing interface callback mechanism would do most of the work and
>> there wouldn't be a need to explicitly add the extra snippet to the XML
>> output like your patch now does.
>>
>> Any thoughts on this?
>
> Yep, that sounds better for me too.
>
> About the qdbus tool, I remember having this issue some time ago, but
> it seems that any instance of QDBusInterface triggers introspect, but
> qdbus code add another check for Introspectable interface which seems
> unnecessary because it does that to call introspect again.
