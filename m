Return-Path: <cyrus@holtmann.org>
From: Bastien Nocera <hadess@hadess.net>
To: BlueZ Hackers <bluez-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="=-jGftZKSckJVrsqXQozay"
Date: Fri, 25 Jan 2008 02:22:00 +0000
Message-Id: <1201227720.2389.17.camel@cookie.hadess.net>
Mime-Version: 1.0
Subject: [Bluez-devel] [PATCH] client.c cleanup
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


--=-jGftZKSckJVrsqXQozay
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Heya,

Some time ago I had problems with client.c's architecture. It would
allow me to easily report completed discoveries without causing crashes.

The attached patch moves all the static variables into the main
BluetoothClient object, and instead of return a new object when using
_new() we return an existing instance of the client.

This makes no changes to the external API for the BluetoothClient, and
should work just as well as older versions did.

A couple of bugs I found in client.c:
- launch test-client with a dongle inserted, remove and reinsert the
dongle, the bdaddr of the device is not set anymore
- launch test-client without a dongle inserted, insert it, the bdaddr is
not set and there's no children to the adapter (although there are if
inserted when started)
- launch test-client with a dongle inserted, remove it, add another one,
the set of known devices underneath hasn't changed

All those problems exist in the old version of client.c, and I intend on
fixing them, as well as making the search button work as expected in the
device selection widget.

Cheers

--=-jGftZKSckJVrsqXQozay
Content-Disposition: attachment; filename=bluez-gnome-client-less-static.patch
Content-Type: text/x-patch; name=bluez-gnome-client-less-static.patch;
	charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Index: client.c
===================================================================
RCS file: /cvsroot/bluez/gnome/common/client.c,v
retrieving revision 1.36
diff -u -p -r1.36 client.c
--- client.c	17 Dec 2007 01:09:28 -0000	1.36
+++ client.c	25 Jan 2008 02:11:18 -0000
@@ -36,11 +36,7 @@
 
 #include "dbus-glue.h"
 
-static DBusGConnection *conn = NULL;
-
-static GtkTreeStore *store = NULL;
-
-static gchar *default_adapter = NULL;
+static BluetoothClient *self = NULL;
 
 #define BLUETOOTH_CLIENT_GET_PRIVATE(obj) (G_TYPE_INSTANCE_GET_PRIVATE((obj), \
 				BLUETOOTH_TYPE_CLIENT, BluetoothClientPrivate))
@@ -49,6 +45,10 @@ typedef struct _BluetoothClientPrivate B
 
 struct _BluetoothClientPrivate {
 	gboolean registered;
+
+	DBusGConnection *conn;
+	GtkTreeStore *store;
+	gchar *default_adapter;
 };
 
 enum {
@@ -60,40 +60,28 @@ static int client_table_signals[LAST_SIG
 
 G_DEFINE_TYPE(BluetoothClient, bluetooth_client, G_TYPE_OBJECT)
 
-static void bluetooth_client_init(BluetoothClient *self)
+static gboolean find_iter_for_object(DBusGProxy *object,
+				     BluetoothClient *client,
+				     GtkTreeIter *iter)
 {
-	BluetoothClientPrivate *priv = BLUETOOTH_CLIENT_GET_PRIVATE(self);
-
-	priv->registered = FALSE;
-}
+	BluetoothClientPrivate *priv = BLUETOOTH_CLIENT_GET_PRIVATE(client);
+	gboolean cont;
 
-static void bluetooth_client_finalize(GObject *object)
-{
-	//BluetoothClientPrivate *priv = BLUETOOTH_CLIENT_GET_PRIVATE(object);
-}
+	if (gtk_tree_model_get_iter_first(GTK_TREE_MODEL(priv->store), iter) == FALSE)
+		return FALSE;
 
-static void bluetooth_client_set_property(GObject *object, guint prop_id,
-					const GValue *value, GParamSpec *pspec)
-{
-	//BluetoothClientPrivate *priv = BLUETOOTH_CLIENT_GET_PRIVATE(object);
+	cont = TRUE;
+	while (cont == TRUE) {
+		DBusGProxy *o;
 
-	switch (prop_id) {
-	default:
-		G_OBJECT_WARN_INVALID_PROPERTY_ID(object, prop_id, pspec);
-		break;
+		gtk_tree_model_get(GTK_TREE_MODEL(priv->store), iter,
+						COLUMN_OBJECT, &o, -1);
+		if (o == object)
+			return TRUE;
+		cont = gtk_tree_model_iter_next(GTK_TREE_MODEL(priv->store), iter);
 	}
-}
 
-static void bluetooth_client_get_property(GObject *object, guint prop_id,
-					GValue *value, GParamSpec *pspec)
-{
-	//BluetoothClientPrivate *priv = BLUETOOTH_CLIENT_GET_PRIVATE(object);
-
-	switch (prop_id) {
-	default:
-		G_OBJECT_WARN_INVALID_PROPERTY_ID(object, prop_id, pspec);
-		break;
-	}
+	return FALSE;
 }
 
 static void mode_changed(DBusGProxy *object,
@@ -109,12 +97,15 @@ static void timeout_changed(DBusGProxy *
 static void name_changed(DBusGProxy *object,
 				const char *name, gpointer user_data)
 {
-	GtkTreePath *path = user_data;
+	BluetoothClient *client = BLUETOOTH_CLIENT(user_data);
+	BluetoothClientPrivate *priv = BLUETOOTH_CLIENT_GET_PRIVATE(client);
+
 	GtkTreeIter iter;
 
-	gtk_tree_model_get_iter(GTK_TREE_MODEL(store), &iter, path);
+	if (find_iter_for_object(object, BLUETOOTH_CLIENT(client), &iter) == FALSE)
+		return;
 
-	gtk_tree_store_set(store, &iter, COLUMN_NAME, name, -1);
+	gtk_tree_store_set(priv->store, &iter, COLUMN_NAME, name, -1);
 }
 
 static void minor_changed(DBusGProxy *object,
@@ -194,8 +185,10 @@ static guint class_to_type(guint32 class
 }
 
 static void insert_device(DBusGProxy *object, GtkTreeIter *parent,
+			BluetoothClient *client,
 			const char *address, const int rssi, gboolean active)
 {
+	BluetoothClientPrivate *priv = BLUETOOTH_CLIENT_GET_PRIVATE(client);
 	GtkTreeIter iter;
 	GHashTable *hash = NULL;
 	GValue *value;
@@ -251,7 +244,7 @@ static void insert_device(DBusGProxy *ob
 	else
 		connected = g_value_get_boolean(value);
 
-	cont = gtk_tree_model_iter_children(GTK_TREE_MODEL(store),
+	cont = gtk_tree_model_iter_children(GTK_TREE_MODEL(priv->store),
 							&iter, parent);
 
 	type = class_to_type(class);
@@ -259,11 +252,11 @@ static void insert_device(DBusGProxy *ob
 	while (cont == TRUE) {
 		gchar *value;
 
-		gtk_tree_model_get(GTK_TREE_MODEL(store), &iter,
+		gtk_tree_model_get(GTK_TREE_MODEL(priv->store), &iter,
 						COLUMN_ADDRESS, &value, -1);
 
 		if (g_ascii_strcasecmp(address, value) == 0) {
-			gtk_tree_store_set(store, &iter,
+			gtk_tree_store_set(priv->store, &iter,
 						COLUMN_ACTIVE, active,
 						COLUMN_CLASS, class,
 						COLUMN_RSSI, rssi,
@@ -275,10 +268,10 @@ static void insert_device(DBusGProxy *ob
 			return;
 		}
 
-		cont = gtk_tree_model_iter_next(GTK_TREE_MODEL(store), &iter);
+		cont = gtk_tree_model_iter_next(GTK_TREE_MODEL(priv->store), &iter);
 	}
 
-	gtk_tree_store_insert_with_values(store, &iter, parent, -1,
+	gtk_tree_store_insert_with_values(priv->store, &iter, parent, -1,
 					COLUMN_ACTIVE, active,
 					COLUMN_ADDRESS, address,
 					COLUMN_CLASS, class,
@@ -291,231 +284,243 @@ static void insert_device(DBusGProxy *ob
 }
 
 static void invalidate_device(DBusGProxy *object,
-				GtkTreeIter *parent, const char *address)
+				GtkTreeIter *parent,
+				BluetoothClient *client,
+				const char *address)
 {
+	BluetoothClientPrivate *priv = BLUETOOTH_CLIENT_GET_PRIVATE(client);
 	GtkTreeIter iter;
 	gboolean cont;
 
-	cont = gtk_tree_model_iter_children(GTK_TREE_MODEL(store),
+	cont = gtk_tree_model_iter_children(GTK_TREE_MODEL(priv->store),
 							&iter, parent);
 
 	while (cont == TRUE) {
 		gchar *value;
 
-		gtk_tree_model_get(GTK_TREE_MODEL(store), &iter,
+		gtk_tree_model_get(GTK_TREE_MODEL(priv->store), &iter,
 						COLUMN_ADDRESS, &value, -1);
 
 		if (g_ascii_strcasecmp(address, value) == 0) {
-			gtk_tree_store_set(store, &iter,
+			gtk_tree_store_set(priv->store, &iter,
 						COLUMN_ACTIVE, FALSE, -1);
 			return;
 		}
 
-		cont = gtk_tree_model_iter_next(GTK_TREE_MODEL(store), &iter);
+		cont = gtk_tree_model_iter_next(GTK_TREE_MODEL(priv->store), &iter);
 	}
 }
 
 static void change_connected(DBusGProxy *object, GtkTreeIter *parent,
+			        BluetoothClient *client,
 				const char *address, gboolean connected)
 {
+	BluetoothClientPrivate *priv = BLUETOOTH_CLIENT_GET_PRIVATE(client);
 	GtkTreeIter iter;
 	gboolean cont;
 
-	cont = gtk_tree_model_iter_children(GTK_TREE_MODEL(store),
+	cont = gtk_tree_model_iter_children(GTK_TREE_MODEL(priv->store),
 							&iter, parent);
 
 	while (cont == TRUE) {
 		gchar *value;
 
-		gtk_tree_model_get(GTK_TREE_MODEL(store), &iter,
+		gtk_tree_model_get(GTK_TREE_MODEL(priv->store), &iter,
 						COLUMN_ADDRESS, &value, -1);
 
 		if (g_ascii_strcasecmp(address, value) == 0) {
-			gtk_tree_store_set(store, &iter,
+			gtk_tree_store_set(priv->store, &iter,
 					COLUMN_CONNECTED, connected, -1);
 			return;
 		}
 
-		cont = gtk_tree_model_iter_next(GTK_TREE_MODEL(store), &iter);
+		cont = gtk_tree_model_iter_next(GTK_TREE_MODEL(priv->store), &iter);
 	}
 }
 
 static void rename_device(DBusGProxy *object, GtkTreeIter *parent,
+					BluetoothClient *client,
 					const char *address, const char *name)
 {
+	BluetoothClientPrivate *priv = BLUETOOTH_CLIENT_GET_PRIVATE(client);
 	GtkTreeIter iter;
 	gboolean cont;
 
-	cont = gtk_tree_model_iter_children(GTK_TREE_MODEL(store),
+	cont = gtk_tree_model_iter_children(GTK_TREE_MODEL(priv->store),
 							&iter, parent);
 
 	while (cont == TRUE) {
 		gchar *value;
 
-		gtk_tree_model_get(GTK_TREE_MODEL(store), &iter,
+		gtk_tree_model_get(GTK_TREE_MODEL(priv->store), &iter,
 						COLUMN_ADDRESS, &value, -1);
 
 		if (g_ascii_strcasecmp(address, value) == 0) {
-			gtk_tree_store_set(store, &iter,
+			gtk_tree_store_set(priv->store, &iter,
 						COLUMN_NAME, name, -1);
 			return;
 		}
 
-		cont = gtk_tree_model_iter_next(GTK_TREE_MODEL(store), &iter);
+		cont = gtk_tree_model_iter_next(GTK_TREE_MODEL(priv->store), &iter);
 	}
 }
 
 static void change_bonded(DBusGProxy *object, GtkTreeIter *parent,
+					BluetoothClient *client,
 					const char *address, gboolean bonded)
 {
+	BluetoothClientPrivate *priv = BLUETOOTH_CLIENT_GET_PRIVATE(client);
 	GtkTreeIter iter;
 	gboolean cont;
 
-	cont = gtk_tree_model_iter_children(GTK_TREE_MODEL(store),
+	cont = gtk_tree_model_iter_children(GTK_TREE_MODEL(priv->store),
 							&iter, parent);
 
 	while (cont == TRUE) {
 		gchar *value;
 
-		gtk_tree_model_get(GTK_TREE_MODEL(store), &iter,
+		gtk_tree_model_get(GTK_TREE_MODEL(priv->store), &iter,
 						COLUMN_ADDRESS, &value, -1);
 
 		if (g_ascii_strcasecmp(address, value) == 0) {
-			gtk_tree_store_set(store, &iter,
+			gtk_tree_store_set(priv->store, &iter,
 						COLUMN_BONDED, bonded, -1);
 			return;
 		}
 
-		cont = gtk_tree_model_iter_next(GTK_TREE_MODEL(store), &iter);
+		cont = gtk_tree_model_iter_next(GTK_TREE_MODEL(priv->store), &iter);
 	}
 }
 
 static void change_trusted(DBusGProxy *object, GtkTreeIter *parent,
+					BluetoothClient *client,
 					const char *address, gboolean trusted)
 {
+	BluetoothClientPrivate *priv = BLUETOOTH_CLIENT_GET_PRIVATE(client);
 	GtkTreeIter iter;
 	gboolean cont;
 
-	cont = gtk_tree_model_iter_children(GTK_TREE_MODEL(store),
+	cont = gtk_tree_model_iter_children(GTK_TREE_MODEL(priv->store),
 							&iter, parent);
 
 	while (cont == TRUE) {
 		gchar *value;
 
-		gtk_tree_model_get(GTK_TREE_MODEL(store), &iter,
+		gtk_tree_model_get(GTK_TREE_MODEL(priv->store), &iter,
 						COLUMN_ADDRESS, &value, -1);
 
 		if (g_ascii_strcasecmp(address, value) == 0) {
-			gtk_tree_store_set(store, &iter,
+			gtk_tree_store_set(priv->store, &iter,
 						COLUMN_TRUSTED, trusted, -1);
 			return;
 		}
 
-		cont = gtk_tree_model_iter_next(GTK_TREE_MODEL(store), &iter);
+		cont = gtk_tree_model_iter_next(GTK_TREE_MODEL(priv->store), &iter);
 	}
 }
 
 static void device_found(DBusGProxy *object, const char *address,
 		const unsigned int class, const int rssi, gpointer user_data)
 {
-	GtkTreePath *path = user_data;
 	GtkTreeIter iter;
 
-	gtk_tree_model_get_iter(GTK_TREE_MODEL(store), &iter, path);
+	if (find_iter_for_object(object, BLUETOOTH_CLIENT(user_data), &iter) == FALSE)
+		return;
 
-	insert_device(object, &iter, address, rssi, TRUE);
+	insert_device(object, &iter, BLUETOOTH_CLIENT(user_data), address, rssi, TRUE);
 }
 
 static void device_disappeared(DBusGProxy *object,
 				const char *address, gpointer user_data)
 {
-	GtkTreePath *path = user_data;
 	GtkTreeIter iter;
 
-	gtk_tree_model_get_iter(GTK_TREE_MODEL(store), &iter, path);
+	if (find_iter_for_object(object, BLUETOOTH_CLIENT(user_data), &iter) == FALSE)
+		return;
 
-	invalidate_device(object, &iter, address);
+	invalidate_device(object, &iter, BLUETOOTH_CLIENT(user_data), address);
 }
 
 static void device_connected(DBusGProxy *object,
 				const char *address, gpointer user_data)
 {
-	GtkTreePath *path = user_data;
 	GtkTreeIter iter;
 
-	gtk_tree_model_get_iter(GTK_TREE_MODEL(store), &iter, path);
+	if (find_iter_for_object(object, BLUETOOTH_CLIENT(user_data), &iter) == FALSE)
+		return;
 
-	change_connected(object, &iter, address, TRUE);
+	change_connected(object, &iter, BLUETOOTH_CLIENT(user_data), address, TRUE);
 }
 
 static void device_disconnected(DBusGProxy *object,
 				const char *address, gpointer user_data)
 {
-	GtkTreePath *path = user_data;
 	GtkTreeIter iter;
 
-	gtk_tree_model_get_iter(GTK_TREE_MODEL(store), &iter, path);
+	if (find_iter_for_object(object, BLUETOOTH_CLIENT(user_data), &iter) == FALSE)
+		return;
 
-	change_connected(object, &iter, address, FALSE);
+	change_connected(object, &iter, BLUETOOTH_CLIENT(user_data), address, FALSE);
 }
 
 static void name_updated(DBusGProxy *object,
 		const char *address, const char *name, gpointer user_data)
 {
-	GtkTreePath *path = user_data;
 	GtkTreeIter iter;
 
-	gtk_tree_model_get_iter(GTK_TREE_MODEL(store), &iter, path);
+	if (find_iter_for_object(object, BLUETOOTH_CLIENT(user_data), &iter) == FALSE)
+		return;
 
-	rename_device(object, &iter, address, name);
+	rename_device(object, &iter, BLUETOOTH_CLIENT(user_data), address, name);
 }
 
 static void bonding_created(DBusGProxy *object,
 				const char *address, gpointer user_data)
 {
-	GtkTreePath *path = user_data;
 	GtkTreeIter iter;
 
-	gtk_tree_model_get_iter(GTK_TREE_MODEL(store), &iter, path);
+	if (find_iter_for_object(object, BLUETOOTH_CLIENT(user_data), &iter) == FALSE)
+		return;
 
-	change_bonded(object, &iter, address, TRUE);
+	change_bonded(object, &iter, BLUETOOTH_CLIENT(user_data), address, TRUE);
 }
 
 static void bonding_removed(DBusGProxy *object,
 				const char *address, gpointer user_data)
 {
-	GtkTreePath *path = user_data;
 	GtkTreeIter iter;
 
-	gtk_tree_model_get_iter(GTK_TREE_MODEL(store), &iter, path);
+	if (find_iter_for_object(object, BLUETOOTH_CLIENT(user_data), &iter) == FALSE)
+		return;
 
-	change_bonded(object, &iter, address, FALSE);
+	change_bonded(object, &iter, BLUETOOTH_CLIENT(user_data), address, FALSE);
 }
 
 static void trust_added(DBusGProxy *object,
 				const char *address, gpointer user_data)
 {
-	GtkTreePath *path = user_data;
 	GtkTreeIter iter;
 
-	gtk_tree_model_get_iter(GTK_TREE_MODEL(store), &iter, path);
+	if (find_iter_for_object(object, BLUETOOTH_CLIENT(user_data), &iter) == FALSE)
+		return;
 
-	change_trusted(object, &iter, address, TRUE);
+	change_trusted(object, &iter, BLUETOOTH_CLIENT(user_data), address, TRUE);
 }
 
 static void trust_removed(DBusGProxy *object,
 				const char *address, gpointer user_data)
 {
-	GtkTreePath *path = user_data;
 	GtkTreeIter iter;
 
-	gtk_tree_model_get_iter(GTK_TREE_MODEL(store), &iter, path);
+	if (find_iter_for_object(object, BLUETOOTH_CLIENT(user_data), &iter) == FALSE)
+		return;
 
-	change_trusted(object, &iter, address, FALSE);
+	change_trusted(object, &iter, BLUETOOTH_CLIENT(user_data), address, FALSE);
 }
 
-static void update_adapter(DBusGProxy *object, GtkTreeIter *iter)
+static void update_adapter(DBusGProxy *object, GtkTreeIter *iter, BluetoothClient *client)
 {
+	BluetoothClientPrivate *priv = BLUETOOTH_CLIENT_GET_PRIVATE(client);
 	GError *error = NULL;
 	char **array = NULL;
 	char *address = NULL, *mode = NULL;
@@ -535,14 +540,14 @@ static void update_adapter(DBusGProxy *o
 
 	adapter_get_minor_class(object, &minor, NULL);
 
-	gtk_tree_store_set(store, iter, COLUMN_ADDRESS, address,
+	gtk_tree_store_set(priv->store, iter, COLUMN_ADDRESS, address,
 						COLUMN_NAME, name, -1);
 
 	adapter_list_connections(object, &array, &error);
 
 	if (error == NULL) {
 		while (*array) {
-			insert_device(object, iter, *array, 0, FALSE);
+			insert_device(object, iter, client, *array, 0, FALSE);
 			array++;
 		}
 	} else {
@@ -555,7 +560,7 @@ static void update_adapter(DBusGProxy *o
 
 	if (error == NULL) {
 		while (*array) {
-			insert_device(object, iter, *array, 0, FALSE);
+			insert_device(object, iter, client, *array, 0, FALSE);
 			array++;
 		}
 	} else {
@@ -568,7 +573,7 @@ static void update_adapter(DBusGProxy *o
 
 	if (error == NULL) {
 		while (*array) {
-			insert_device(object, iter, *array, 0, FALSE);
+			insert_device(object, iter, client, *array, 0, FALSE);
 			array++;
 		}
 	} else {
@@ -584,228 +589,232 @@ failover:
 
 	if (error == NULL) {
 		while (*array) {
-			insert_device(object, iter, *array, 0, FALSE);
+			insert_device(object, iter, client, *array, 0, FALSE);
 			array++;
 		}
 	} else
 		g_error_free(error);
 }
 
-static void add_adapter(const char *path)
+static void add_adapter(const char *path, BluetoothClient *client)
 {
+	BluetoothClientPrivate *priv = BLUETOOTH_CLIENT_GET_PRIVATE(client);
 	DBusGProxy *object;
 	GtkTreeIter iter;
-	GtkTreePath *tree_path;
 	gboolean cont;
 
-	cont = gtk_tree_model_get_iter_first(GTK_TREE_MODEL(store), &iter);
+	cont = gtk_tree_model_get_iter_first(GTK_TREE_MODEL(priv->store), &iter);
 
 	while (cont == TRUE) {
 		gchar *value;
 
-		gtk_tree_model_get(GTK_TREE_MODEL(store), &iter,
+		gtk_tree_model_get(GTK_TREE_MODEL(priv->store), &iter,
 						COLUMN_PATH, &value,
 						COLUMN_OBJECT, &object, -1);
 
 		if (g_ascii_strcasecmp(path, value) == 0) {
-			gtk_tree_store_set(store, &iter,
+			gtk_tree_store_set(priv->store, &iter,
 						COLUMN_ACTIVE, TRUE, -1);
 
-			update_adapter(object, &iter);
+			update_adapter(object, &iter, client);
 
 			return;
 		}
 
-		cont = gtk_tree_model_iter_next(GTK_TREE_MODEL(store), &iter);
+		cont = gtk_tree_model_iter_next(GTK_TREE_MODEL(priv->store), &iter);
 	}
 
-	object = dbus_g_proxy_new_for_name(conn, "org.bluez",
+	object = dbus_g_proxy_new_for_name(priv->conn, "org.bluez",
 						path, "org.bluez.Adapter");
 
-	gtk_tree_store_insert_with_values(store, &iter, NULL, -1,
+	gtk_tree_store_insert_with_values(priv->store, &iter, NULL, -1,
 						COLUMN_PATH, path,
 						COLUMN_ACTIVE, TRUE,
 						COLUMN_OBJECT, object, -1);
 
 	g_object_unref(object);
 
-	tree_path = gtk_tree_model_get_path(GTK_TREE_MODEL(store), &iter);
-
 	dbus_g_proxy_add_signal(object, "ModeChanged",
 					G_TYPE_STRING, G_TYPE_INVALID);
 
 	dbus_g_proxy_connect_signal(object, "ModeChanged",
-				G_CALLBACK(mode_changed), tree_path, NULL);
+				G_CALLBACK(mode_changed), client, NULL);
 
 	dbus_g_proxy_add_signal(object, "DiscoverableTimeoutChanged",
 					G_TYPE_UINT, G_TYPE_INVALID);
 
 	dbus_g_proxy_connect_signal(object, "DiscoverableTimeoutChanged",
-				G_CALLBACK(timeout_changed), tree_path, NULL);
+				G_CALLBACK(timeout_changed), client, NULL);
 
 	dbus_g_proxy_add_signal(object, "NameChanged",
 					G_TYPE_STRING, G_TYPE_INVALID);
 
 	dbus_g_proxy_connect_signal(object, "NameChanged",
-				G_CALLBACK(name_changed), tree_path, NULL);
+				G_CALLBACK(name_changed), client, NULL);
 
 	dbus_g_proxy_add_signal(object, "MinorClassChanged",
 					G_TYPE_STRING, G_TYPE_INVALID);
 
 	dbus_g_proxy_connect_signal(object, "MinorClassChanged",
-				G_CALLBACK(minor_changed), tree_path, NULL);
+				G_CALLBACK(minor_changed), client, NULL);
 
 	dbus_g_proxy_add_signal(object, "RemoteDeviceFound",
 						G_TYPE_STRING, G_TYPE_UINT,
 						G_TYPE_INT, G_TYPE_INVALID);
 
 	dbus_g_proxy_connect_signal(object, "RemoteDeviceFound",
-				G_CALLBACK(device_found), tree_path, NULL);
+				G_CALLBACK(device_found), client, NULL);
 
 	dbus_g_proxy_add_signal(object, "RemoteDeviceDisappeared",
 						G_TYPE_STRING, G_TYPE_INVALID);
 
 	dbus_g_proxy_connect_signal(object, "RemoteDeviceDisappeared",
-				G_CALLBACK(device_disappeared), tree_path, NULL);
+				G_CALLBACK(device_disappeared), client, NULL);
 
 	dbus_g_proxy_add_signal(object, "RemoteDeviceConnected",
 						G_TYPE_STRING, G_TYPE_INVALID);
 
 	dbus_g_proxy_connect_signal(object, "RemoteDeviceConnected",
-				G_CALLBACK(device_connected), tree_path, NULL);
+				G_CALLBACK(device_connected), client, NULL);
 
 	dbus_g_proxy_add_signal(object, "RemoteDeviceDisconnected",
 						G_TYPE_STRING, G_TYPE_INVALID);
 
 	dbus_g_proxy_connect_signal(object, "RemoteDeviceDisconnected",
-				G_CALLBACK(device_disconnected), tree_path, NULL);
+				G_CALLBACK(device_disconnected), client, NULL);
 
 	dbus_g_proxy_add_signal(object, "RemoteNameUpdated",
 				G_TYPE_STRING, G_TYPE_STRING, G_TYPE_INVALID);
 
 	dbus_g_proxy_connect_signal(object, "RemoteNameUpdated",
-				G_CALLBACK(name_updated), tree_path, NULL);
+				G_CALLBACK(name_updated), client, NULL);
 
 	dbus_g_proxy_add_signal(object, "BondingCreated",
 						G_TYPE_STRING, G_TYPE_INVALID);
 
 	dbus_g_proxy_connect_signal(object, "BondingCreated",
-				G_CALLBACK(bonding_created), tree_path, NULL);
+				G_CALLBACK(bonding_created), client, NULL);
 
 	dbus_g_proxy_add_signal(object, "BondingRemoved",
 						G_TYPE_STRING, G_TYPE_INVALID);
 
 	dbus_g_proxy_connect_signal(object, "BondingRemoved",
-				G_CALLBACK(bonding_removed), tree_path, NULL);
+				G_CALLBACK(bonding_removed), client, NULL);
 
 	dbus_g_proxy_add_signal(object, "TrustAdded",
 						G_TYPE_STRING, G_TYPE_INVALID);
 
 	dbus_g_proxy_connect_signal(object, "TrustAdded",
-				G_CALLBACK(trust_added), tree_path, NULL);
+				G_CALLBACK(trust_added), client, NULL);
 
 	dbus_g_proxy_add_signal(object, "TrustRemoved",
 						G_TYPE_STRING, G_TYPE_INVALID);
 
 	dbus_g_proxy_connect_signal(object, "TrustRemoved",
-				G_CALLBACK(trust_removed), tree_path, NULL);
+				G_CALLBACK(trust_removed), client, NULL);
 
 	dbus_g_proxy_add_signal(object, "DiscoveryCompleted", G_TYPE_INVALID);
 
-	update_adapter(object, &iter);
+	update_adapter(object, &iter, client);
 }
 
-static void remove_adapter(const char *path)
+static void remove_adapter(const char *path, BluetoothClient *client)
 {
+	BluetoothClientPrivate *priv = BLUETOOTH_CLIENT_GET_PRIVATE(client);
 	GtkTreeIter iter;
 	gboolean cont;
 
-	cont = gtk_tree_model_get_iter_first(GTK_TREE_MODEL(store), &iter);
+	cont = gtk_tree_model_get_iter_first(GTK_TREE_MODEL(priv->store), &iter);
 
 	while (cont == TRUE) {
 		gchar *value;
 
-		gtk_tree_model_get(GTK_TREE_MODEL(store), &iter,
+		gtk_tree_model_get(GTK_TREE_MODEL(priv->store), &iter,
 						COLUMN_PATH, &value, -1);
 
 		if (g_ascii_strcasecmp(path, value) == 0) {
-			gtk_tree_store_set(store, &iter,
+			gtk_tree_store_set(priv->store, &iter,
 						COLUMN_ACTIVE, FALSE,
 						COLUMN_ADDRESS, NULL,
 						COLUMN_NAME, NULL, -1);
 			return;
 		}
 
-		cont = gtk_tree_model_iter_next(GTK_TREE_MODEL(store), &iter);
+		cont = gtk_tree_model_iter_next(GTK_TREE_MODEL(priv->store), &iter);
 	}
 }
 
 static void adapter_added(DBusGProxy *object,
 				const char *path, gpointer user_data)
 {
-	add_adapter(path);
+	add_adapter(path, BLUETOOTH_CLIENT(user_data));
 }
 
 static void adapter_removed(DBusGProxy *object,
 				const char *path, gpointer user_data)
 {
-	remove_adapter(path);
+	remove_adapter(path, BLUETOOTH_CLIENT(user_data));
 }
 
 static void default_adapter_changed(DBusGProxy *object,
 				const char *path, gpointer user_data)
 {
-	gchar *temp = default_adapter;
-
-	default_adapter = g_ascii_strcasecmp(path, "") ? g_strdup(path) : NULL;
-
+	BluetoothClientPrivate *priv = BLUETOOTH_CLIENT_GET_PRIVATE(user_data);
+	gchar *temp;
+	
+	temp = priv->default_adapter;
+	priv->default_adapter = g_ascii_strcasecmp(path, "") ? g_strdup(path) : NULL;
 	g_free(temp);
+
+	g_message ("new default adapter: %s", priv->default_adapter);
 }
 
 static void discovery_completed(DBusGProxy *object,
 				gpointer user_data)
 {
 #if 0
-	BluetoothClient *self = BLUETOOTH_CLIENT(user_data);
+	BluetoothClient *client = BLUETOOTH_CLIENT(user_data);
 
-	g_signal_emit(G_OBJECT(self), client_table_signals[DISCOVERIES_COMPLETED], 0);
+	g_signal_emit(G_OBJECT(client), client_table_signals[DISCOVERIES_COMPLETED], 0);
 #endif
+	g_message ("discovery_completed");
 }
 
-static void setup_manager(void)
+static void setup_manager(BluetoothClient *client)
 {
+	BluetoothClientPrivate *priv = BLUETOOTH_CLIENT_GET_PRIVATE(client);
 	DBusGProxy *object;
 	GError *error = NULL;
 	char **array = NULL;
 
-	object = dbus_g_proxy_new_for_name(conn, "org.bluez",
+	object = dbus_g_proxy_new_for_name(priv->conn, "org.bluez",
 					"/org/bluez", "org.bluez.Manager");
 
 	dbus_g_proxy_add_signal(object, "AdapterAdded",
 					G_TYPE_STRING, G_TYPE_INVALID);
 
 	dbus_g_proxy_connect_signal(object, "AdapterAdded",
-				G_CALLBACK(adapter_added), conn, NULL);
+				G_CALLBACK(adapter_added), client, NULL);
 
 	dbus_g_proxy_add_signal(object, "AdapterRemoved",
 					G_TYPE_STRING, G_TYPE_INVALID);
 
 	dbus_g_proxy_connect_signal(object, "AdapterRemoved",
-				G_CALLBACK(adapter_removed), conn, NULL);
+				G_CALLBACK(adapter_removed), client, NULL);
 
 	dbus_g_proxy_add_signal(object, "DefaultAdapterChanged",
 					G_TYPE_STRING, G_TYPE_INVALID);
 
 	dbus_g_proxy_connect_signal(object, "DefaultAdapterChanged",
-			G_CALLBACK(default_adapter_changed), conn, NULL);
+			G_CALLBACK(default_adapter_changed), client, NULL);
 
-	manager_default_adapter(object, &default_adapter, NULL);
+	manager_default_adapter(object, &priv->default_adapter, NULL);
 
 	manager_list_adapters(object, &array, &error);
 
 	if (error == NULL) {
 		while (*array) {
-			add_adapter(*array);
+			add_adapter(*array, client);
 			array++;
 		}
 	} else
@@ -815,25 +824,20 @@ static void setup_manager(void)
 static void name_owner_changed(DBusGProxy *object, const char *name,
 			const char *prev, const char *new, gpointer user_data)
 {
+	BluetoothClient *client = BLUETOOTH_CLIENT(user_data);
+
 	if (!g_ascii_strcasecmp(name, "org.bluez") && *new == '\0') {
-		/* disable adapters */
+		/* FIXME disable adapters */
 	}
 }
 
-static void setup_dbus(void)
+static void setup_dbus(BluetoothClient *client)
 {
+	BluetoothClientPrivate *priv = BLUETOOTH_CLIENT_GET_PRIVATE(client);
 	DBusGProxy *object;
 	GError *error = NULL;
 
-	dbus_g_object_register_marshaller(marshal_VOID__STRING_UINT_INT,
-				G_TYPE_NONE, G_TYPE_STRING, G_TYPE_UINT,
-						G_TYPE_INT, G_TYPE_INVALID);
-
-	dbus_g_object_register_marshaller(marshal_VOID__STRING_STRING,
-						G_TYPE_NONE, G_TYPE_STRING,
-						G_TYPE_STRING, G_TYPE_INVALID);
-
-	conn = dbus_g_bus_get(DBUS_BUS_SYSTEM, &error);
+	priv->conn = dbus_g_bus_get(DBUS_BUS_SYSTEM, &error);
 	if (error != NULL) {
 		g_printerr("Connecting to system bus failed: %s\n",
 							error->message);
@@ -841,7 +845,7 @@ static void setup_dbus(void)
 		return;
 	}
 
-	object = dbus_g_proxy_new_for_name(conn, DBUS_SERVICE_DBUS,
+	object = dbus_g_proxy_new_for_name(priv->conn, DBUS_SERVICE_DBUS,
 					DBUS_PATH_DBUS, DBUS_INTERFACE_DBUS);
 
 	dbus_g_proxy_add_signal(object, "NameOwnerChanged",
@@ -849,7 +853,56 @@ static void setup_dbus(void)
 					G_TYPE_STRING, G_TYPE_INVALID);
 
 	dbus_g_proxy_connect_signal(object, "NameOwnerChanged",
-				G_CALLBACK(name_owner_changed), NULL, NULL);
+				G_CALLBACK(name_owner_changed), client, NULL);
+}
+
+static void bluetooth_client_finalize(GObject *object)
+{
+	BluetoothClientPrivate *priv = BLUETOOTH_CLIENT_GET_PRIVATE(object);
+
+	priv->registered = FALSE;
+	g_free(priv->default_adapter);
+	g_object_unref(G_OBJECT(priv->store));
+}
+
+static void bluetooth_client_init(BluetoothClient *client)
+{
+	BluetoothClientPrivate *priv = BLUETOOTH_CLIENT_GET_PRIVATE(client);
+
+	priv->registered = FALSE;
+
+	priv->store = gtk_tree_store_new(11, G_TYPE_STRING, G_TYPE_BOOLEAN,
+			G_TYPE_OBJECT, G_TYPE_STRING, G_TYPE_UINT,
+			G_TYPE_INT, G_TYPE_STRING, G_TYPE_UINT,
+			G_TYPE_BOOLEAN, G_TYPE_BOOLEAN, G_TYPE_BOOLEAN);
+
+	setup_dbus(client);
+
+	setup_manager(client);
+}
+
+static void bluetooth_client_set_property(GObject *object, guint prop_id,
+					const GValue *value, GParamSpec *pspec)
+{
+	//BluetoothClientPrivate *priv = BLUETOOTH_CLIENT_GET_PRIVATE(object);
+
+	switch (prop_id) {
+	default:
+		G_OBJECT_WARN_INVALID_PROPERTY_ID(object, prop_id, pspec);
+		break;
+	}
+}
+
+static void bluetooth_client_get_property(GObject *object, guint prop_id,
+					GValue *value, GParamSpec *pspec)
+{
+	//BluetoothClientPrivate *priv = BLUETOOTH_CLIENT_GET_PRIVATE(object);
+
+	switch (prop_id) {
+	default:
+		G_OBJECT_WARN_INVALID_PROPERTY_ID(object, prop_id, pspec);
+		break;
+	}
 }
 
 static void bluetooth_client_class_init(BluetoothClientClass *klass)
@@ -861,11 +914,6 @@ static void bluetooth_client_class_init(
 	G_OBJECT_CLASS(klass)->set_property = bluetooth_client_set_property;
 	G_OBJECT_CLASS(klass)->get_property = bluetooth_client_get_property;
 
-	store = gtk_tree_store_new(11, G_TYPE_STRING, G_TYPE_BOOLEAN,
-			G_TYPE_OBJECT, G_TYPE_STRING, G_TYPE_UINT,
-			G_TYPE_INT, G_TYPE_STRING, G_TYPE_UINT,
-			G_TYPE_BOOLEAN, G_TYPE_BOOLEAN, G_TYPE_BOOLEAN);
-
 	client_table_signals[DISCOVERIES_COMPLETED] =
 		g_signal_new ("discoveries-completed",
 				G_TYPE_FROM_CLASS (klass),
@@ -876,35 +924,44 @@ static void bluetooth_client_class_init(
 				g_cclosure_marshal_VOID__VOID,
 				G_TYPE_NONE, 0, G_TYPE_NONE);
 
-	setup_dbus();
+	dbus_g_object_register_marshaller(marshal_VOID__STRING_UINT_INT,
+				G_TYPE_NONE, G_TYPE_STRING, G_TYPE_UINT,
+						G_TYPE_INT, G_TYPE_INVALID);
 
-	setup_manager();
+	dbus_g_object_register_marshaller(marshal_VOID__STRING_STRING,
+						G_TYPE_NONE, G_TYPE_STRING,
+						G_TYPE_STRING, G_TYPE_INVALID);
 }
 
 BluetoothClient *bluetooth_client_new(void)
 {
-	return BLUETOOTH_CLIENT(g_object_new(BLUETOOTH_TYPE_CLIENT, NULL));
+	if (self == NULL) {
+		self = BLUETOOTH_CLIENT(g_object_new(BLUETOOTH_TYPE_CLIENT, NULL));
+		return self;
+	} else {
+		return g_object_ref(self);
+	}
 }
 
-gboolean bluetooth_client_register_passkey_agent(BluetoothClient *self,
+gboolean bluetooth_client_register_passkey_agent(BluetoothClient *client,
 		const char *path, const char *address, const void *info)
 {
-	BluetoothClientPrivate *priv = BLUETOOTH_CLIENT_GET_PRIVATE(self);
+	BluetoothClientPrivate *priv = BLUETOOTH_CLIENT_GET_PRIVATE(client);
 	DBusGProxy *proxy;
 
 	if (priv->registered == FALSE) {
 		dbus_g_object_type_install_info(BLUETOOTH_TYPE_CLIENT, info);
 
-		dbus_g_connection_register_g_object(conn, path, G_OBJECT(self));
+		dbus_g_connection_register_g_object(priv->conn, path, G_OBJECT(client));
 
 		priv->registered = TRUE;
 	}
 
-	if (default_adapter == NULL)
+	if (priv->default_adapter == NULL)
 		return FALSE;
 
-	proxy = dbus_g_proxy_new_for_name(conn, "org.bluez",
-				default_adapter, "org.bluez.Security");
+	proxy = dbus_g_proxy_new_for_name(priv->conn, "org.bluez",
+				priv->default_adapter, "org.bluez.Security");
 
 	security_register_passkey_agent(proxy, path, address, NULL);
 
@@ -919,25 +976,26 @@ static void create_bonding_reply(DBusGPr
 	//g_printf("create bonding reply\n");
 }
 
-gboolean bluetooth_client_create_bonding(BluetoothClient *self,
+gboolean bluetooth_client_create_bonding(BluetoothClient *client,
 					gchar *adapter, const gchar *address)
 {
+	BluetoothClientPrivate *priv = BLUETOOTH_CLIENT_GET_PRIVATE(client);
 	GtkTreeIter iter;
 	gboolean cont;
 
 	if (adapter == NULL)
-		adapter = default_adapter;
+		adapter = priv->default_adapter;
 
 	if (adapter == NULL)
 		return FALSE;
 
-	cont = gtk_tree_model_get_iter_first(GTK_TREE_MODEL(store), &iter);
+	cont = gtk_tree_model_get_iter_first(GTK_TREE_MODEL(priv->store), &iter);
 
 	while (cont == TRUE) {
 		DBusGProxy *object;
 		gchar *path;
 
-		gtk_tree_model_get(GTK_TREE_MODEL(store), &iter,
+		gtk_tree_model_get(GTK_TREE_MODEL(priv->store), &iter,
 						COLUMN_PATH, &path,
 						COLUMN_OBJECT, &object, -1);
 
@@ -947,7 +1005,7 @@ gboolean bluetooth_client_create_bonding
 			return TRUE;
 		}
 
-		cont = gtk_tree_model_iter_next(GTK_TREE_MODEL(store), &iter);
+		cont = gtk_tree_model_iter_next(GTK_TREE_MODEL(priv->store), &iter);
 	}
 
 	return FALSE;
@@ -959,25 +1017,26 @@ static void remove_bonding_reply(DBusGPr
 	//g_printf("remove bonding reply\n");
 }
 
-gboolean bluetooth_client_remove_bonding(BluetoothClient *self,
+gboolean bluetooth_client_remove_bonding(BluetoothClient *client,
 					gchar *adapter, const gchar *address)
 {
+	BluetoothClientPrivate *priv = BLUETOOTH_CLIENT_GET_PRIVATE(client);
 	GtkTreeIter iter;
 	gboolean cont;
 
 	if (adapter == NULL)
-		adapter = default_adapter;
+		adapter = priv->default_adapter;
 
 	if (adapter == NULL)
 		return FALSE;
 
-	cont = gtk_tree_model_get_iter_first(GTK_TREE_MODEL(store), &iter);
+	cont = gtk_tree_model_get_iter_first(GTK_TREE_MODEL(priv->store), &iter);
 
 	while (cont == TRUE) {
 		DBusGProxy *object;
 		gchar *path;
 
-		gtk_tree_model_get(GTK_TREE_MODEL(store), &iter,
+		gtk_tree_model_get(GTK_TREE_MODEL(priv->store), &iter,
 						COLUMN_PATH, &path,
 						COLUMN_OBJECT, &object, -1);
 
@@ -987,7 +1046,7 @@ gboolean bluetooth_client_remove_bonding
 			return TRUE;
 		}
 
-		cont = gtk_tree_model_iter_next(GTK_TREE_MODEL(store), &iter);
+		cont = gtk_tree_model_iter_next(GTK_TREE_MODEL(priv->store), &iter);
 	}
 
 	return FALSE;
@@ -999,25 +1058,26 @@ static void set_trusted_reply(DBusGProxy
 	//g_printf("set trusted reply\n");
 }
 
-gboolean bluetooth_client_set_trusted(BluetoothClient *self,
+gboolean bluetooth_client_set_trusted(BluetoothClient *client,
 					gchar *adapter, const gchar *address)
 {
+	BluetoothClientPrivate *priv = BLUETOOTH_CLIENT_GET_PRIVATE(client);
 	GtkTreeIter iter;
 	gboolean cont;
 
 	if (adapter == NULL)
-		adapter = default_adapter;
+		adapter = priv->default_adapter;
 
 	if (adapter == NULL)
 		return FALSE;
 
-	cont = gtk_tree_model_get_iter_first(GTK_TREE_MODEL(store), &iter);
+	cont = gtk_tree_model_get_iter_first(GTK_TREE_MODEL(priv->store), &iter);
 
 	while (cont == TRUE) {
 		DBusGProxy *object;
 		gchar *path;
 
-		gtk_tree_model_get(GTK_TREE_MODEL(store), &iter,
+		gtk_tree_model_get(GTK_TREE_MODEL(priv->store), &iter,
 						COLUMN_PATH, &path,
 						COLUMN_OBJECT, &object, -1);
 
@@ -1027,7 +1087,7 @@ gboolean bluetooth_client_set_trusted(Bl
 			return TRUE;
 		}
 
-		cont = gtk_tree_model_iter_next(GTK_TREE_MODEL(store), &iter);
+		cont = gtk_tree_model_iter_next(GTK_TREE_MODEL(priv->store), &iter);
 	}
 
 	return FALSE;
@@ -1039,25 +1099,26 @@ static void remove_trust_reply(DBusGProx
 	//g_printf("remove trust reply\n");
 }
 
-gboolean bluetooth_client_remove_trust(BluetoothClient *self,
+gboolean bluetooth_client_remove_trust(BluetoothClient *client,
 					gchar *adapter, const gchar *address)
 {
+	BluetoothClientPrivate *priv = BLUETOOTH_CLIENT_GET_PRIVATE(client);
 	GtkTreeIter iter;
 	gboolean cont;
 
 	if (adapter == NULL)
-		adapter = default_adapter;
+		adapter = priv->default_adapter;
 
 	if (adapter == NULL)
 		return FALSE;
 
-	cont = gtk_tree_model_get_iter_first(GTK_TREE_MODEL(store), &iter);
+	cont = gtk_tree_model_get_iter_first(GTK_TREE_MODEL(priv->store), &iter);
 
 	while (cont == TRUE) {
 		DBusGProxy *object;
 		gchar *path;
 
-		gtk_tree_model_get(GTK_TREE_MODEL(store), &iter,
+		gtk_tree_model_get(GTK_TREE_MODEL(priv->store), &iter,
 						COLUMN_PATH, &path,
 						COLUMN_OBJECT, &object, -1);
 
@@ -1067,7 +1128,7 @@ gboolean bluetooth_client_remove_trust(B
 			return TRUE;
 		}
 
-		cont = gtk_tree_model_iter_next(GTK_TREE_MODEL(store), &iter);
+		cont = gtk_tree_model_iter_next(GTK_TREE_MODEL(priv->store), &iter);
 	}
 
 	return FALSE;
@@ -1079,25 +1140,26 @@ static void disconnect_remote_device_rep
 	//g_printf("disconnect remote device reply\n");
 }
 
-gboolean bluetooth_client_disconnect(BluetoothClient *self,
+gboolean bluetooth_client_disconnect(BluetoothClient *client,
 					gchar *adapter, const gchar *address)
 {
+	BluetoothClientPrivate *priv = BLUETOOTH_CLIENT_GET_PRIVATE(client);
 	GtkTreeIter iter;
 	gboolean cont;
 
 	if (adapter == NULL)
-		adapter = default_adapter;
+		adapter = priv->default_adapter;
 
 	if (adapter == NULL)
 		return FALSE;
 
-	cont = gtk_tree_model_get_iter_first(GTK_TREE_MODEL(store), &iter);
+	cont = gtk_tree_model_get_iter_first(GTK_TREE_MODEL(priv->store), &iter);
 
 	while (cont == TRUE) {
 		DBusGProxy *object;
 		gchar *path;
 
-		gtk_tree_model_get(GTK_TREE_MODEL(store), &iter,
+		gtk_tree_model_get(GTK_TREE_MODEL(priv->store), &iter,
 						COLUMN_PATH, &path,
 						COLUMN_OBJECT, &object, -1);
 
@@ -1107,71 +1169,74 @@ gboolean bluetooth_client_disconnect(Blu
 			return TRUE;
 		}
 
-		cont = gtk_tree_model_iter_next(GTK_TREE_MODEL(store), &iter);
+		cont = gtk_tree_model_iter_next(GTK_TREE_MODEL(priv->store), &iter);
 	}
 
 	return FALSE;
 }
 
-gboolean bluetooth_client_discover_devices(BluetoothClient *self, gchar *adapter)
+gboolean bluetooth_client_discover_devices(BluetoothClient *client, gchar *adapter)
 {
+	BluetoothClientPrivate *priv = BLUETOOTH_CLIENT_GET_PRIVATE(client);
 	GtkTreeIter iter;
 	gboolean cont;
 
 	if (adapter == NULL)
-		adapter = default_adapter;
+		adapter = priv->default_adapter;
 
 	if (adapter == NULL)
 		return FALSE;
 
-	cont = gtk_tree_model_get_iter_first(GTK_TREE_MODEL(store), &iter);
+	cont = gtk_tree_model_get_iter_first(GTK_TREE_MODEL(priv->store), &iter);
 
 	while (cont == TRUE) {
 		DBusGProxy *object;
 		gchar *path;
 
-		gtk_tree_model_get(GTK_TREE_MODEL(store), &iter,
+		gtk_tree_model_get(GTK_TREE_MODEL(priv->store), &iter,
 						COLUMN_PATH, &path,
 						COLUMN_OBJECT, &object, -1);
 
 		if (g_ascii_strcasecmp(path, adapter) == 0) {
+#if 0
 			/* Disconnect any lingering signals, to avoid the callback
 			 * being called twice */
 			dbus_g_proxy_disconnect_signal(object, "DiscoveryCompleted",
-					G_CALLBACK(discovery_completed), self);
+					G_CALLBACK(discovery_completed), client);
 			dbus_g_proxy_connect_signal(object, "DiscoveryCompleted",
-				G_CALLBACK(discovery_completed), self, NULL);
+				G_CALLBACK(discovery_completed), client, NULL);
 
 			dbus_g_proxy_call(object, "DiscoverDevices",
 							NULL, G_TYPE_INVALID);
-
+#endif
 			return TRUE;
 		}
 
-		cont = gtk_tree_model_iter_next(GTK_TREE_MODEL(store), &iter);
+		cont = gtk_tree_model_iter_next(GTK_TREE_MODEL(priv->store), &iter);
 	}
 
 	return FALSE;
 }
 
-gboolean bluetooth_client_cancel_discovery(BluetoothClient *self, gchar *adapter)
+gboolean bluetooth_client_cancel_discovery(BluetoothClient *client, gchar *adapter)
 {
+	BluetoothClientPrivate *priv = BLUETOOTH_CLIENT_GET_PRIVATE(client);
 	GtkTreeIter iter;
 	gboolean cont;
 
 	if (adapter == NULL)
-		adapter = default_adapter;
+		adapter = priv->default_adapter;
 
 	if (adapter == NULL)
 		return FALSE;
 
-	cont = gtk_tree_model_get_iter_first(GTK_TREE_MODEL(store), &iter);
+	cont = gtk_tree_model_get_iter_first(GTK_TREE_MODEL(priv->store), &iter);
 
 	while (cont == TRUE) {
 		DBusGProxy *object;
 		gchar *path;
 
-		gtk_tree_model_get(GTK_TREE_MODEL(store), &iter,
+		gtk_tree_model_get(GTK_TREE_MODEL(priv->store), &iter,
 						COLUMN_PATH, &path,
 						COLUMN_OBJECT, &object, -1);
 
@@ -1181,26 +1246,29 @@ gboolean bluetooth_client_cancel_discove
 			return TRUE;
 		}
 
-		cont = gtk_tree_model_iter_next(GTK_TREE_MODEL(store), &iter);
+		cont = gtk_tree_model_iter_next(GTK_TREE_MODEL(priv->store), &iter);
 	}
 
 	return FALSE;
 }
 
-GtkTreeModel *bluetooth_client_get_model(BluetoothClient *self)
+GtkTreeModel *bluetooth_client_get_model(BluetoothClient *client)
 {
-	g_object_ref(store);
+	BluetoothClientPrivate *priv = BLUETOOTH_CLIENT_GET_PRIVATE(client);
+
+	g_object_ref(priv->store);
 
-	return GTK_TREE_MODEL(store);
+	return GTK_TREE_MODEL(priv->store);
 }
 
-GtkTreeModel *bluetooth_client_get_model_simple(BluetoothClient *self)
+GtkTreeModel *bluetooth_client_get_model_simple(BluetoothClient *client)
 {
+	BluetoothClientPrivate *priv = BLUETOOTH_CLIENT_GET_PRIVATE(client);
 	GtkTreeModel *model;
 	GtkTreeIter iter;
 	gboolean cont;
 
-	model = gtk_tree_model_filter_new(GTK_TREE_MODEL(store), NULL);
+	model = gtk_tree_model_filter_new(GTK_TREE_MODEL(priv->store), NULL);
 
 	gtk_tree_model_filter_set_visible_column(GTK_TREE_MODEL_FILTER(model),
 								COLUMN_ACTIVE);
@@ -1208,29 +1276,29 @@ GtkTreeModel *bluetooth_client_get_model
 	if (gtk_tree_model_iter_n_children(model, NULL) != 1)
 		return model;
 
-	cont = gtk_tree_model_get_iter_first(GTK_TREE_MODEL(store), &iter);
+	cont = gtk_tree_model_get_iter_first(GTK_TREE_MODEL(priv->store), &iter);
 
 	while (cont == TRUE) {
 		gboolean active;
 
-		gtk_tree_model_get(GTK_TREE_MODEL(store), &iter,
+		gtk_tree_model_get(GTK_TREE_MODEL(priv->store), &iter,
 						COLUMN_ACTIVE, &active, -1);
 
 		if (active == TRUE) {
 			GtkTreePath *path;
 
-			path = gtk_tree_model_get_path(GTK_TREE_MODEL(store), &iter);
+			path = gtk_tree_model_get_path(GTK_TREE_MODEL(priv->store), &iter);
 
 			g_object_unref(model);
 
-			model = gtk_tree_model_filter_new(GTK_TREE_MODEL(store), path);
+			model = gtk_tree_model_filter_new(GTK_TREE_MODEL(priv->store), path);
 
 			gtk_tree_path_free(path);
 
 			break;
 		}
 
-		cont = gtk_tree_model_iter_next(GTK_TREE_MODEL(store), &iter);
+		cont = gtk_tree_model_iter_next(GTK_TREE_MODEL(priv->store), &iter);
 	}
 
 	return model;
@@ -1253,11 +1321,12 @@ static gboolean adapter_list_filter(GtkT
 	return active;
 }
 
-GtkTreeModel *bluetooth_client_get_model_adapter_list(BluetoothClient *self)
+GtkTreeModel *bluetooth_client_get_model_adapter_list(BluetoothClient *client)
 {
+	BluetoothClientPrivate *priv = BLUETOOTH_CLIENT_GET_PRIVATE(client);
 	GtkTreeModel *model;
 
-	model = gtk_tree_model_filter_new(GTK_TREE_MODEL(store), NULL);
+	model = gtk_tree_model_filter_new(GTK_TREE_MODEL(priv->store), NULL);
 
 	gtk_tree_model_filter_set_visible_func(GTK_TREE_MODEL_FILTER(model),
 					adapter_list_filter, NULL, NULL);
@@ -1275,33 +1344,34 @@ static gboolean device_active_filter(Gtk
 	return active;
 }
 
-GtkTreeModel *bluetooth_client_get_model_for_adapter(BluetoothClient *self,
+GtkTreeModel *bluetooth_client_get_model_for_adapter(BluetoothClient *client,
 								gchar *adapter)
 {
+	BluetoothClientPrivate *priv = BLUETOOTH_CLIENT_GET_PRIVATE(client);
 	GtkTreeModel *model;
 	GtkTreeIter iter;
 	gboolean cont;
 
 	if (adapter == NULL)
-		adapter = default_adapter;
+		adapter = priv->default_adapter;
 
 	if (adapter == NULL)
 		return NULL;
 
-	cont = gtk_tree_model_get_iter_first(GTK_TREE_MODEL(store), &iter);
+	cont = gtk_tree_model_get_iter_first(GTK_TREE_MODEL(priv->store), &iter);
 
 	while (cont == TRUE) {
 		gchar *path;
 
-		gtk_tree_model_get(GTK_TREE_MODEL(store), &iter,
+		gtk_tree_model_get(GTK_TREE_MODEL(priv->store), &iter,
 						COLUMN_PATH, &path, -1);
 
 		if (g_ascii_strcasecmp(path, adapter) == 0) {
 			GtkTreePath *path;
 
-			path = gtk_tree_model_get_path(GTK_TREE_MODEL(store), &iter);
+			path = gtk_tree_model_get_path(GTK_TREE_MODEL(priv->store), &iter);
 
-			model = gtk_tree_model_filter_new(GTK_TREE_MODEL(store), path);
+			model = gtk_tree_model_filter_new(GTK_TREE_MODEL(priv->store), path);
 
 			gtk_tree_model_filter_set_visible_func(GTK_TREE_MODEL_FILTER(model),
 							device_active_filter, NULL, NULL);
@@ -1311,40 +1381,41 @@ GtkTreeModel *bluetooth_client_get_model
 			return model;
 		}
 
-		cont = gtk_tree_model_iter_next(GTK_TREE_MODEL(store), &iter);
+		cont = gtk_tree_model_iter_next(GTK_TREE_MODEL(priv->store), &iter);
 	}
 
 	return NULL;
 }
 
-GtkTreeModel *bluetooth_client_get_model_with_filter(BluetoothClient *self,
+GtkTreeModel *bluetooth_client_get_model_with_filter(BluetoothClient *client,
 			gchar *adapter, GtkTreeModelFilterVisibleFunc func,
 								gpointer data)
 {
+	BluetoothClientPrivate *priv = BLUETOOTH_CLIENT_GET_PRIVATE(client);
 	GtkTreeModel *model;
 	GtkTreeIter iter;
 	gboolean cont;
 
 	if (adapter == NULL)
-		adapter = default_adapter;
+		adapter = priv->default_adapter;
 
 	if (adapter == NULL)
 		return NULL;
 
-	cont = gtk_tree_model_get_iter_first(GTK_TREE_MODEL(store), &iter);
+	cont = gtk_tree_model_get_iter_first(GTK_TREE_MODEL(priv->store), &iter);
 
 	while (cont == TRUE) {
 		gchar *path;
 
-		gtk_tree_model_get(GTK_TREE_MODEL(store), &iter,
+		gtk_tree_model_get(GTK_TREE_MODEL(priv->store), &iter,
 						COLUMN_PATH, &path, -1);
 
 		if (g_ascii_strcasecmp(path, adapter) == 0) {
 			GtkTreePath *path;
 
-			path = gtk_tree_model_get_path(GTK_TREE_MODEL(store), &iter);
+			path = gtk_tree_model_get_path(GTK_TREE_MODEL(priv->store), &iter);
 
-			model = gtk_tree_model_filter_new(GTK_TREE_MODEL(store), path);
+			model = gtk_tree_model_filter_new(GTK_TREE_MODEL(priv->store), path);
 
 			if (func != NULL)
 				gtk_tree_model_filter_set_visible_func(GTK_TREE_MODEL_FILTER(model),
@@ -1355,7 +1426,7 @@ GtkTreeModel *bluetooth_client_get_model
 			return model;
 		}
 
-		cont = gtk_tree_model_iter_next(GTK_TREE_MODEL(store), &iter);
+		cont = gtk_tree_model_iter_next(GTK_TREE_MODEL(priv->store), &iter);
 	}
 
 	return NULL;
@@ -1374,9 +1445,9 @@ static gboolean device_bonded_filter(Gtk
 			connected == TRUE) ? TRUE : FALSE;
 }
 
-GtkTreeModel *bluetooth_client_get_model_bonded_list(BluetoothClient *self,
+GtkTreeModel *bluetooth_client_get_model_bonded_list(BluetoothClient *client,
 								gchar *adapter)
 {
-	return bluetooth_client_get_model_with_filter(self, adapter,
+	return bluetooth_client_get_model_with_filter(client, adapter,
 						device_bonded_filter, NULL);
 }

--=-jGftZKSckJVrsqXQozay
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--=-jGftZKSckJVrsqXQozay
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--=-jGftZKSckJVrsqXQozay--
