Return-Path: <cyrus@holtmann.org>
From: =?iso-8859-2?Q?RISK=D3?= Gergely <gergely@risko.hu>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Context Devel mailing list <context-devel@projects.maemo.org>
Subject: Re: [PATCH] Add introspection interface to the output of introspection calls.
References: <87k50hoee1.fsf@bubble.risko.hu>
	<2d5a2c100909020746t63bcd89bj1b25d053a6f4f9ca@mail.gmail.com>
	<87pra9nspo.fsf@bubble.risko.hu> <20090914141816.GA17774@jh-x301>
	<871vm9fuis.fsf@bubble.risko.hu> <20090914211145.GA16947@jh-x301>
	<2d5a2c100909150350r2e453cb6h5c4fe95c8638f9e9@mail.gmail.com>
	<87ws40e6iz.fsf@bubble.risko.hu> <20090915152240.GA4378@jh-x301>
	<87eiq7du6t.fsf@bubble.risko.hu> <20090916113959.GA4314@jh-x301>
Date: Wed, 16 Sep 2009 15:03:12 +0300
In-Reply-To: <20090916113959.GA4314@jh-x301> (Johan Hedberg's message of "Wed,
	16 Sep 2009 14:39:59 +0300")
Message-ID: <8763bjdrlr.fsf@bubble.risko.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Thanks for the quick reply.

On Wed, 16 Sep 2009 14:39:59 +0300, Johan Hedberg <johan.hedberg@gmail.com> writes:

> Looks good to me, except for the following (rather minor) issues:

All of them fixed in the patch at the end of the mail

>> +static void add_interface(struct generic_data *data, const char *name,
>> +			     GDBusMethodTable *methods,
>> +			     GDBusSignalTable *signals,
>> +			     GDBusPropertyTable *properties,
>> +			     void *user_data,
>> +			     GDBusDestroyFunction destroy)
>
> There seems to be mixed tabs & spaces here for indentation. Can you
> confirm this? We only use tabs for indentation in BlueZ (which I believe
> is also the usual kernel coding style).

Hmm, interesting...  And then they just don't care about "correct"
indentation in respect to the opening parantheses in the previous line.
Yeah, my Emacs config lines up things even with spaces if needed, but I
fixed the patch as requested.

>> +static gboolean remove_interface(struct generic_data *data, const char *name)
>> +{
>> +	struct interface_data *iface;
>> +
>> +	iface = find_interface(data->interfaces, name);
>> +	if (iface) {
>> +		data->interfaces = g_slist_remove(data->interfaces, iface);
>> +
>> +		if (iface->destroy)
>> +			iface->destroy(iface->user_data);
>> +
>> +		g_free(iface->name);
>> +		g_free(iface);
>> +		return TRUE;
>> +	} else
>> +		return FALSE;
>> +}
>
> Marcel usually likes to do this as follows (and I agree with him):
>
> iface = find_interface(data->interfaces, name);
> if (!iface)
> 	return FALSE;
>
> ...rest of the code...
>
> return TRUE;
>
> That saves you one level of indentation for most of the function and could
> be considered also esier to read.

Agree, fixed.

Gergely

>From 68b79f26969017d62118734ac8f118d973445cf9 Mon Sep 17 00:00:00 2001
From: Gergely Risko <gergely@risko.hu>
Date: Tue, 15 Sep 2009 15:23:24 +0300
Subject: [PATCH] gdbus: handle introspection generally in generic_message.

Previously it was a specific case, now introspection is just another
interface, which is always implemented.  It is registered/unregistered
when an object path is referenced first/last.
---
 gdbus/object.c |  101 ++++++++++++++++++++++++++++++++------------------------
 1 files changed, 58 insertions(+), 43 deletions(-)

diff --git a/gdbus/object.c b/gdbus/object.c
index 811c2e1..fde01ad 100644
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
+				DBusMessage *message, void *user_data)
 {
+	struct generic_data *data = user_data;
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
@@ -335,6 +321,31 @@ done:
 	g_free(parent_path);
 }
 
+static GDBusMethodTable introspect_methods[] = {
+	{ "Introspect",	"",	"s", introspect	},
+	{ }
+};
+
+static void add_interface(struct generic_data *data, const char *name,
+				GDBusMethodTable *methods,
+				GDBusSignalTable *signals,
+				GDBusPropertyTable *properties,
+				void *user_data,
+				GDBusDestroyFunction destroy)
+{
+	struct interface_data *iface;
+
+	iface = g_new0(struct interface_data, 1);
+	iface->name = g_strdup(name);
+	iface->methods = methods;
+	iface->signals = signals;
+	iface->properties = properties;
+	iface->user_data = user_data;
+	iface->destroy = destroy;
+
+	data->interfaces = g_slist_append(data->interfaces, iface);
+}
+
 static struct generic_data *object_path_ref(DBusConnection *connection,
 							const char *path)
 {
@@ -363,9 +374,30 @@ static struct generic_data *object_path_ref(DBusConnection *connection,
 
 	invalidate_parent_data(connection, path);
 
+	add_interface(data, DBUS_INTERFACE_INTROSPECTABLE,
+			introspect_methods, NULL, NULL, data, NULL);
+
 	return data;
 }
 
+static gboolean remove_interface(struct generic_data *data, const char *name)
+{
+	struct interface_data *iface;
+
+	iface = find_interface(data->interfaces, name);
+	if (!iface)
+		return FALSE;
+
+	data->interfaces = g_slist_remove(data->interfaces, iface);
+
+	if (iface->destroy)
+		iface->destroy(iface->user_data);
+
+	g_free(iface->name);
+	g_free(iface);
+	return TRUE;
+}
+
 static void object_path_unref(DBusConnection *connection, const char *path)
 {
 	struct generic_data *data = NULL;
@@ -382,6 +414,8 @@ static void object_path_unref(DBusConnection *connection, const char *path)
 	if (data->refcount > 0)
 		return;
 
+	remove_interface(data, DBUS_INTERFACE_INTROSPECTABLE);
+
 	invalidate_parent_data(connection, path);
 
 	dbus_connection_unregister_object_path(connection, path);
@@ -474,7 +508,6 @@ gboolean g_dbus_register_interface(DBusConnection *connection,
 					GDBusDestroyFunction destroy)
 {
 	struct generic_data *data;
-	struct interface_data *iface;
 
 	data = object_path_ref(connection, path);
 	if (data == NULL)
@@ -483,16 +516,8 @@ gboolean g_dbus_register_interface(DBusConnection *connection,
 	if (find_interface(data->interfaces, name))
 		return FALSE;
 
-	iface = g_new0(struct interface_data, 1);
-
-	iface->name = g_strdup(name);
-	iface->methods = methods;
-	iface->signals = signals;
-	iface->properties = properties;
-	iface->user_data = user_data;
-	iface->destroy = destroy;
-
-	data->interfaces = g_slist_append(data->interfaces, iface);
+	add_interface(data, name, methods, signals,
+			properties, user_data, destroy);
 
 	g_free(data->introspect);
 	data->introspect = NULL;
@@ -504,7 +529,6 @@ gboolean g_dbus_unregister_interface(DBusConnection *connection,
 					const char *path, const char *name)
 {
 	struct generic_data *data = NULL;
-	struct interface_data *iface;
 
 	if (!path)
 		return FALSE;
@@ -516,18 +540,9 @@ gboolean g_dbus_unregister_interface(DBusConnection *connection,
 	if (data == NULL)
 		return FALSE;
 
-	iface = find_interface(data->interfaces, name);
-	if (!iface)
+	if (remove_interface(data, name) == FALSE)
 		return FALSE;
 
-	data->interfaces = g_slist_remove(data->interfaces, iface);
-
-	if (iface->destroy)
-		iface->destroy(iface->user_data);
-
-	g_free(iface->name);
-	g_free(iface);
-
 	g_free(data->introspect);
 	data->introspect = NULL;
 
-- 
1.6.0.4

