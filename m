Return-Path: <cyrus@holtmann.org>
From: Bastien Nocera <hadess@hadess.net>
To: BlueZ Hackers <bluez-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="=-YIeBG+OjhPKQpOoFfJw/"
Date: Thu, 06 Mar 2008 15:56:19 +0000
Message-Id: <1204818979.2640.117.camel@cookie.hadess.net>
Mime-Version: 1.0
Subject: [Bluez-devel] [PATCH] Show all the possibly known devices
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net


--=-YIeBG+OjhPKQpOoFfJw/
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Heya,

This patch makes the default client.c show all the known devices,
including the seen remote devices. Those can be easily filtered using
the drop-downs at the bottom of the dialogue.

It also doesn't query remotely to avoid problems with asking for a name
for a device we don't know about anymore.

Cheers

--=-YIeBG+OjhPKQpOoFfJw/
Content-Disposition: attachment;
	filename=bluez-gnome-device-selection-show-all-devices.patch
Content-Type: text/x-patch;
	name=bluez-gnome-device-selection-show-all-devices.patch;
	charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Index: client.c
===================================================================
RCS file: /cvsroot/bluez/gnome/common/client.c,v
retrieving revision 1.42
diff -u -p -u -p -r1.42 client.c
--- client.c	6 Mar 2008 10:54:29 -0000	1.42
+++ client.c	6 Mar 2008 15:45:35 -0000
@@ -204,7 +204,8 @@ static guint class_to_type(guint32 class
 
 static void insert_device(DBusGProxy *object, GtkTreeIter *parent,
 			BluetoothClient *client,
-			const char *address, const int rssi, gboolean active)
+			const char *address, const int rssi, gboolean active,
+			gboolean remote_lookup)
 {
 	BluetoothClientPrivate *priv = BLUETOOTH_CLIENT_GET_PRIVATE(client);
 	GtkTreeIter iter;
@@ -223,20 +224,28 @@ static void insert_device(DBusGProxy *ob
 				&hash, G_TYPE_INVALID);
 
 	value = (hash == NULL) ? NULL : g_hash_table_lookup(hash, "name");
-	if (value == NULL)
-		dbus_g_proxy_call(object, "GetRemoteName", NULL,
-				G_TYPE_STRING, address, G_TYPE_INVALID,
-				G_TYPE_STRING, &name, G_TYPE_INVALID);
-	else
+	if (value == NULL) {
+		if (remote_lookup) {
+			dbus_g_proxy_call(object, "GetRemoteName", NULL,
+					  G_TYPE_STRING, address, G_TYPE_INVALID,
+					  G_TYPE_STRING, &name, G_TYPE_INVALID);
+		} else {
+			name = g_strdup(address);
+		}
+	} else {
 		name = g_value_get_string(value);
+	}
 
 	value = (hash == NULL) ? NULL : g_hash_table_lookup(hash, "class");
-	if (value == NULL)
-		dbus_g_proxy_call(object, "GetRemoteClass", NULL,
-				G_TYPE_STRING, address, G_TYPE_INVALID,
-				G_TYPE_UINT, &class, G_TYPE_INVALID);
-	else
+	if (value == NULL) {
+		if (remote_lookup) {
+			dbus_g_proxy_call(object, "GetRemoteClass", NULL,
+					  G_TYPE_STRING, address, G_TYPE_INVALID,
+					  G_TYPE_UINT, &class, G_TYPE_INVALID);
+		}
+	} else {
 		class = g_value_get_uint(value);
+	}
 
 	value = (hash == NULL) ? NULL : g_hash_table_lookup(hash, "bonded");
 	if (value == NULL)
@@ -447,7 +456,7 @@ static void device_found(DBusGProxy *obj
 	if (find_iter_for_object(object, BLUETOOTH_CLIENT(user_data), &iter) == FALSE)
 		return;
 
-	insert_device(object, &iter, BLUETOOTH_CLIENT(user_data), address, rssi, TRUE);
+	insert_device(object, &iter, BLUETOOTH_CLIENT(user_data), address, rssi, TRUE, TRUE);
 }
 
 static void device_disappeared(DBusGProxy *object,
@@ -567,7 +576,7 @@ static void update_adapter(DBusGProxy *o
 
 	if (error == NULL) {
 		while (*array) {
-			insert_device(object, iter, client, *array, 0, FALSE);
+			insert_device(object, iter, client, *array, 0, FALSE, TRUE);
 			array++;
 		}
 	} else {
@@ -580,7 +589,7 @@ static void update_adapter(DBusGProxy *o
 
 	if (error == NULL) {
 		while (*array) {
-			insert_device(object, iter, client, *array, 0, FALSE);
+			insert_device(object, iter, client, *array, 0, FALSE, FALSE);
 			array++;
 		}
 	} else {
@@ -593,7 +602,7 @@ static void update_adapter(DBusGProxy *o
 
 	if (error == NULL) {
 		while (*array) {
-			insert_device(object, iter, client, *array, 0, FALSE);
+			insert_device(object, iter, client, *array, 0, FALSE, FALSE);
 			array++;
 		}
 	} else {
@@ -602,14 +611,12 @@ static void update_adapter(DBusGProxy *o
 		goto failover;
 	}
 
-	return;
-
 failover:
 	adapter_list_remote_devices(object, &array, &error);
 
 	if (error == NULL) {
 		while (*array) {
-			insert_device(object, iter, client, *array, 0, FALSE);
+			insert_device(object, iter, client, *array, 0, FALSE, FALSE);
 			array++;
 		}
 	} else

--=-YIeBG+OjhPKQpOoFfJw/
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--=-YIeBG+OjhPKQpOoFfJw/
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--=-YIeBG+OjhPKQpOoFfJw/--
