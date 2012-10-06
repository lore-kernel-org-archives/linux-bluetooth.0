Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.de.marchi@gmail.com>
Subject: [PATCH BlueZ 1/6] gdbus: Fix up Properties.Set() code path
Date: Sat,  6 Oct 2012 04:10:43 -0300
Message-Id: <1349507448-9595-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Lucas De Marchi <lucas.de.marchi@gmail.com>

Minor fixes to make setter actually work:

	- Add propdata in pending_property_set
	- Break loop when we are removing propdata from list and we
	  found it
	- in_args and out_args were swapped
	- interface and method name arguments were swapped
---
 gdbus/object.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/gdbus/object.c b/gdbus/object.c
index 444728c..66431de 100644
--- a/gdbus/object.c
+++ b/gdbus/object.c
@@ -433,6 +433,8 @@ static struct property_data *remove_pending_property_data(
 		propdata = l->data;
 		if (propdata->id != id)
 			continue;
+
+		break;
 	}
 
 	if (l == NULL)
@@ -844,7 +846,7 @@ static DBusMessage *properties_set(DBusConnection *connection,
 					"Invalid argument type: '%c'",
 					dbus_message_iter_get_arg_type(&iter));
 
-	dbus_message_iter_get_basic(&iter, &name);
+	dbus_message_iter_get_basic(&iter, &interface);
 	dbus_message_iter_next(&iter);
 
 	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_STRING)
@@ -852,7 +854,7 @@ static DBusMessage *properties_set(DBusConnection *connection,
 					"Invalid argument type: '%c'",
 					dbus_message_iter_get_arg_type(&iter));
 
-	dbus_message_iter_get_basic(&iter, &interface);
+	dbus_message_iter_get_basic(&iter, &name);
 	dbus_message_iter_next(&iter);
 
 	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_VARIANT)
@@ -887,6 +889,7 @@ static DBusMessage *properties_set(DBusConnection *connection,
 	propdata = g_new(struct property_data, 1);
 	propdata->id = next_pending_property++;
 	propdata->message = dbus_message_ref(message);
+	pending_property_set = g_slist_prepend(pending_property_set, propdata);
 
 	property->set(property, &sub, propdata->id, iface->user_data);
 
@@ -898,9 +901,10 @@ static const GDBusMethodTable properties_methods[] = {
 			GDBUS_ARGS({ "interface", "s" }, { "name", "s" }),
 			GDBUS_ARGS({ "value", "v" }),
 			properties_get) },
-	{ GDBUS_ASYNC_METHOD("Set", NULL,
+	{ GDBUS_ASYNC_METHOD("Set",
 			GDBUS_ARGS({ "interface", "s" }, { "name", "s" },
 							{ "value", "v" }),
+			NULL,
 			properties_set) },
 	{ GDBUS_METHOD("GetAll",
 			GDBUS_ARGS({ "interface", "s" }),
-- 
1.7.12.2

