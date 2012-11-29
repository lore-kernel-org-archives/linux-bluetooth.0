Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH BlueZ 1/3] gdbus: Don't register DBus.Properties with no properties
Date: Thu, 29 Nov 2012 11:19:31 -0200
Message-Id: <1354195173-12750-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Delay registering DBus.Properties interface until the moment there are
properties on that path. This is needed for objects that currently don't
expose any property to not export the interface.
---
 gdbus/object.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/gdbus/object.c b/gdbus/object.c
index 3101ca6..47116bd 100644
--- a/gdbus/object.c
+++ b/gdbus/object.c
@@ -1213,9 +1213,6 @@ static struct generic_data *object_path_ref(DBusConnection *connection,
 					manager_methods, manager_signals,
 					NULL, data, NULL);
 
-	add_interface(data, DBUS_INTERFACE_PROPERTIES, properties_methods,
-					properties_signals, NULL, data, NULL);
-
 	return data;
 }
 
@@ -1336,6 +1333,12 @@ gboolean g_dbus_register_interface(DBusConnection *connection,
 		return FALSE;
 	}
 
+	if (properties != NULL && !find_interface(data->interfaces,
+						DBUS_INTERFACE_PROPERTIES))
+		add_interface(data, DBUS_INTERFACE_PROPERTIES,
+				properties_methods, properties_signals, NULL,
+				data, NULL);
+
 	add_interface(data, name, methods, signals, properties, user_data,
 								destroy);
 
-- 
1.8.0.1

