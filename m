Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Bastien Nocera <hadess@hadess.net>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1185315051.3641.189.camel@cookie.hadess.net>
References: <1185293793.3641.129.camel@cookie.hadess.net>
	<1185311688.7111.72.camel@violet>
	<1185315051.3641.189.camel@cookie.hadess.net>
Content-Type: multipart/mixed; boundary="=-UC64DdqwgLH9BMod3nNW"
Date: Wed, 25 Jul 2007 00:09:01 +0100
Message-Id: <1185318541.3641.195.camel@cookie.hadess.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] [PATCH] Make BluetoothClient work on all adapters
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


--=-UC64DdqwgLH9BMod3nNW
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, 2007-07-24 at 23:10 +0100, Bastien Nocera wrote:
> On Tue, 2007-07-24 at 23:14 +0200, Marcel Holtmann wrote:
<snip>
> > However this includes that we have to monitor if the default adapter
> > changes or one adapter gets removed while being in the adapter selector
> > widget or device selector widget.
> 
> Fair enough, I knew this would be a sticky point. I'm trying to fix it
> up so that we use the default adapter by default with "NULL" passed as
> the adapter.

Here goes. This should correctly kill the disco on the old default
adapter and re-enable it on the new default adapter, when the default
adapter changes.

If the default adapter changes but we didn't start a discovery using the
default adapter, then it's up to the application to start/stop it
anyway.

It will also make all the functions taking an adapter use the default
adapter when NULL is passed.

We should also kill discovery on all the devices when the object goes
away, and move the treestore, and dbus connection to the class, rather
than using statics. But that's for another patch.

That should allow the rest of the wizard cleanups getting in, as well as
the device selector, and then the browse menu implementation.

Cheers

-- 
Bastien Nocera <hadess@hadess.net> 

--=-UC64DdqwgLH9BMod3nNW
Content-Disposition: attachment;
	filename=bluez-gnome-client-handle-default-adapter.patch
Content-Type: text/x-patch;
	name=bluez-gnome-client-handle-default-adapter.patch;
	charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Index: client.c
===================================================================
RCS file: /cvsroot/bluez/gnome/common/client.c,v
retrieving revision 1.17
diff -u -p -r1.17 client.c
--- client.c	24 Jul 2007 21:23:59 -0000	1.17
+++ client.c	24 Jul 2007 23:03:02 -0000
@@ -35,9 +35,9 @@
 
 #include "dbus-glue.h"
 
-static DBusGConnection *conn;
+static DBusGConnection *conn = NULL;
 
-static GtkTreeStore *store;
+static GtkTreeStore *store = NULL;
 
 #define BLUETOOTH_CLIENT_GET_PRIVATE(obj) (G_TYPE_INSTANCE_GET_PRIVATE((obj), \
 				BLUETOOTH_TYPE_CLIENT, BluetoothClientPrivate))
@@ -46,20 +46,44 @@ typedef struct _BluetoothClientPrivate B
 
 struct _BluetoothClientPrivate {
 	gboolean registered;
+	gchar *default_adapter;
+	gboolean discovery_on_default;
 };
 
+static void default_adapter_changed(DBusGProxy *object,
+					const char *path, BluetoothClient *self);
+
 G_DEFINE_TYPE(BluetoothClient, bluetooth_client, G_TYPE_OBJECT)
 
 static void bluetooth_client_init(BluetoothClient *self)
 {
 	BluetoothClientPrivate *priv = BLUETOOTH_CLIENT_GET_PRIVATE(self);
+	DBusGProxy *object;
+
+	object = dbus_g_proxy_new_for_name(conn, "org.bluez",
+					"/org/bluez", "org.bluez.Manager");
+
+	dbus_g_proxy_add_signal(object, "DefaultAdapterChanged",
+				G_TYPE_STRING, G_TYPE_INVALID);
+
+	dbus_g_proxy_connect_signal(object, "DefaultAdapterChanged",
+				G_CALLBACK(default_adapter_changed), conn, NULL);
+
+	manager_default_adapter(object, &priv->default_adapter, NULL);
 
 	priv->registered = FALSE;
 }
 
 static void bluetooth_client_finalize(GObject *object)
 {
-	//BluetoothClientPrivate *priv = BLUETOOTH_CLIENT_GET_PRIVATE(object);
+	BluetoothClient *self = BLUETOOTH_CLIENT (object);
+	BluetoothClientPrivate *priv = BLUETOOTH_CLIENT_GET_PRIVATE(self);
+
+	g_free(priv->default_adapter);
+	priv->default_adapter = NULL;
+
+	//FIXME cancel disco on _all_ devices
+	//bluetooth_client_cancel_discovery(self, NULL);
 }
 
 static void bluetooth_client_set_property(GObject *object, guint prop_id,
@@ -351,9 +375,7 @@ static void update_adapter(DBusGProxy *o
 	gtk_tree_store_set(store, iter, COLUMN_ADDRESS, address,
 						COLUMN_NAME, name, -1);
 
-	//adapter_list_remote_devices(object, &array, &error);
-
-	adapter_list_bondings(object, &array, &error);
+	adapter_list_remote_devices(object, &array, &error);
 
 	if (error == NULL) {
 		while (*array) {
@@ -488,11 +510,30 @@ static void adapter_removed(DBusGProxy *
 	remove_adapter(path);
 }
 
+static void default_adapter_changed(DBusGProxy *object,
+					const char *path, BluetoothClient *self)
+{
+	BluetoothClientPrivate *priv = BLUETOOTH_CLIENT_GET_PRIVATE(self);
+	gboolean discovery_on_default;
+
+	discovery_on_default = priv->discovery_on_default;
+
+	/* If we started a discovery on the default adapter, cancel it
+	 * and restart a new one on the new default adapter */
+	if (discovery_on_default)
+		bluetooth_client_cancel_discovery(self, NULL);
+
+	g_free(priv->default_adapter);
+	priv->default_adapter = g_strdup(path);
+
+	if (discovery_on_default)
+		bluetooth_client_discover_devices(self, NULL);
+}
+
 static void setup_manager(void)
 {
 	DBusGProxy *object;
 	GError *error = NULL;
-	char *default_adapter = NULL;
 	char **array = NULL;
 
 	object = dbus_g_proxy_new_for_name(conn, "org.bluez",
@@ -510,8 +551,6 @@ static void setup_manager(void)
 	dbus_g_proxy_connect_signal(object, "AdapterRemoved",
 				G_CALLBACK(adapter_removed), conn, NULL);
 
-	manager_default_adapter(object, &default_adapter, NULL);
-
 	manager_list_adapters(object, &array, &error);
 
 	if (error == NULL) {
@@ -646,11 +685,15 @@ gboolean bluetooth_client_create_bonding
 
 gboolean bluetooth_client_discover_devices(BluetoothClient *self, gchar *adapter)
 {
+	BluetoothClientPrivate *priv = BLUETOOTH_CLIENT_GET_PRIVATE(self);
 	GtkTreeIter iter;
 	gboolean cont;
 
 	cont = gtk_tree_model_get_iter_first(GTK_TREE_MODEL(store), &iter);
 
+	if (!adapter && !priv->default_adapter)
+		return FALSE;
+
 	while (cont == TRUE) {
 		DBusGProxy *object;
 		gchar *path;
@@ -659,9 +702,12 @@ gboolean bluetooth_client_discover_devic
 						COLUMN_PATH, &path,
 						COLUMN_OBJECT, &object, -1);
 
-		if (g_ascii_strcasecmp(path, adapter) == 0) {
+		if ((adapter == NULL && g_ascii_strcasecmp(path, priv->default_adapter) == 0)
+		    || g_ascii_strcasecmp(path, adapter) == 0) {
 			dbus_g_proxy_call(object, "DiscoverDevices",
 							NULL, G_TYPE_INVALID);
+			if (!adapter)
+				priv->discovery_on_default = TRUE;
 			return TRUE;
 		}
 
@@ -673,10 +719,13 @@ gboolean bluetooth_client_discover_devic
 
 gboolean bluetooth_client_cancel_discovery(BluetoothClient *self, gchar *adapter)
 {
+	BluetoothClientPrivate *priv = BLUETOOTH_CLIENT_GET_PRIVATE(self);
 	GtkTreeIter iter;
 	gboolean cont;
 
 	cont = gtk_tree_model_get_iter_first(GTK_TREE_MODEL(store), &iter);
+	if (!adapter && !priv->default_adapter)
+		return FALSE;
 
 	while (cont == TRUE) {
 		DBusGProxy *object;
@@ -686,9 +735,12 @@ gboolean bluetooth_client_cancel_discove
 						COLUMN_PATH, &path,
 						COLUMN_OBJECT, &object, -1);
 
-		if (g_ascii_strcasecmp(path, adapter) == 0) {
+		if ((adapter == NULL && g_ascii_strcasecmp(path, priv->default_adapter) == 0)
+		    || g_ascii_strcasecmp(path, adapter) == 0) {
 			dbus_g_proxy_call(object, "CancelDiscovery",
 							NULL, G_TYPE_INVALID);
+			if (!adapter)
+				priv->discovery_on_default = FALSE;
 			return TRUE;
 		}
 
@@ -786,19 +838,24 @@ static gboolean device_active_filter(Gtk
 GtkTreeModel *bluetooth_client_get_model_for_adapter(BluetoothClient *self,
 								gchar *adapter)
 {
+	BluetoothClientPrivate *priv = BLUETOOTH_CLIENT_GET_PRIVATE(self);
 	GtkTreeModel *model;
 	GtkTreeIter iter;
 	gboolean cont;
 
 	cont = gtk_tree_model_get_iter_first(GTK_TREE_MODEL(store), &iter);
 
+	if (!adapter && !priv->default_adapter)
+		return FALSE;
+
 	while (cont == TRUE) {
 		gchar *path;
 
 		gtk_tree_model_get(GTK_TREE_MODEL(store), &iter,
 						COLUMN_PATH, &path, -1);
 
-		if (!g_ascii_strcasecmp(path, adapter)) {
+		if ((adapter == NULL && !g_ascii_strcasecmp(path, priv->default_adapter))
+		    || !g_ascii_strcasecmp(path, adapter)) {
 			GtkTreePath *path;
 
 			path = gtk_tree_model_get_path(GTK_TREE_MODEL(store), &iter);

--=-UC64DdqwgLH9BMod3nNW
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
--=-UC64DdqwgLH9BMod3nNW
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--=-UC64DdqwgLH9BMod3nNW--
