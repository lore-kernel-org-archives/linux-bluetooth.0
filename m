Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Bastien Nocera <hadess@hadess.net>
To: BlueZ Hackers <bluez-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="=-REWbEXe8/ROXmhvOZaxi"
Date: Tue, 24 Jul 2007 17:16:33 +0100
Message-Id: <1185293793.3641.129.camel@cookie.hadess.net>
Mime-Version: 1.0
Subject: [Bluez-devel] [PATCH] Make BluetoothClient work on all adapters
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


--=-REWbEXe8/ROXmhvOZaxi
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

With this patch, we can now pass a NULL as the adapter to work with all
the adapters. This is for use in the upcoming patch for the selector
widget.

-- 
Bastien Nocera <hadess@hadess.net> 

--=-REWbEXe8/ROXmhvOZaxi
Content-Disposition: attachment;
	filename=bluez-gnome-client-handle-all-adapters.patch
Content-Type: text/x-patch; name=bluez-gnome-client-handle-all-adapters.patch;
	charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Index: common/client.c
===================================================================
RCS file: /cvsroot/bluez/gnome/common/client.c,v
retrieving revision 1.16
diff -u -p -r1.16 client.c
--- common/client.c	20 May 2007 12:04:32 -0000	1.16
+++ common/client.c	24 Jul 2007 16:12:18 -0000
@@ -59,7 +59,7 @@ static void bluetooth_client_init(Blueto
 
 static void bluetooth_client_finalize(GObject *object)
 {
-	//BluetoothClientPrivate *priv = BLUETOOTH_CLIENT_GET_PRIVATE(object);
+	bluetooth_client_cancel_discovery(BLUETOOTH_CLIENT (object), NULL);
 }
 
 static void bluetooth_client_set_property(GObject *object, guint prop_id,
@@ -351,9 +351,7 @@ static void update_adapter(DBusGProxy *o
 	gtk_tree_store_set(store, iter, COLUMN_ADDRESS, address,
 						COLUMN_NAME, name, -1);
 
-	//adapter_list_remote_devices(object, &array, &error);
-
-	adapter_list_bondings(object, &array, &error);
+	adapter_list_remote_devices(object, &array, &error);
 
 	if (error == NULL) {
 		while (*array) {
@@ -587,11 +585,6 @@ BluetoothClient *bluetooth_client_new(vo
 	return BLUETOOTH_CLIENT(g_object_new(BLUETOOTH_TYPE_CLIENT, NULL));
 }
 
-void bluetooth_client_destroy(BluetoothClient *self)
-{
-	g_object_unref(self);
-}
-
 gboolean bluetooth_client_register_passkey_agent(BluetoothClient *self,
 		const char *path, const char *address, const void *info)
 {
@@ -652,8 +645,9 @@ gboolean bluetooth_client_create_bonding
 gboolean bluetooth_client_discover_devices(BluetoothClient *self, gchar *adapter)
 {
 	GtkTreeIter iter;
-	gboolean cont;
+	gboolean cont, retval;
 
+	retval = FALSE;
 	cont = gtk_tree_model_get_iter_first(GTK_TREE_MODEL(store), &iter);
 
 	while (cont == TRUE) {
@@ -664,23 +658,27 @@ gboolean bluetooth_client_discover_devic
 						COLUMN_PATH, &path,
 						COLUMN_OBJECT, &object, -1);
 
-		if (g_ascii_strcasecmp(path, adapter) == 0) {
+		if ((adapter == NULL && path != NULL)
+		    || g_ascii_strcasecmp(path, adapter) == 0) {
 			dbus_g_proxy_call(object, "DiscoverDevices",
 							NULL, G_TYPE_INVALID);
-			return TRUE;
+			if (adapter != NULL)
+				return TRUE;
+			retval = TRUE;
 		}
 
 		cont = gtk_tree_model_iter_next(GTK_TREE_MODEL(store), &iter);
 	}
 
-	return FALSE;
+	return retval;
 }
 
 gboolean bluetooth_client_cancel_discovery(BluetoothClient *self, gchar *adapter)
 {
 	GtkTreeIter iter;
-	gboolean cont;
+	gboolean cont, retval;
 
+	retval = FALSE;
 	cont = gtk_tree_model_get_iter_first(GTK_TREE_MODEL(store), &iter);
 
 	while (cont == TRUE) {
@@ -691,16 +689,19 @@ gboolean bluetooth_client_cancel_discove
 						COLUMN_PATH, &path,
 						COLUMN_OBJECT, &object, -1);
 
-		if (g_ascii_strcasecmp(path, adapter) == 0) {
+		if ((adapter == NULL && path != NULL)
+		    || g_ascii_strcasecmp(path, adapter) == 0) {
 			dbus_g_proxy_call(object, "CancelDiscovery",
 							NULL, G_TYPE_INVALID);
-			return TRUE;
+			if (adapter != NULL)
+				return TRUE;
+			retval = TRUE;
 		}
 
 		cont = gtk_tree_model_iter_next(GTK_TREE_MODEL(store), &iter);
 	}
 
-	return FALSE;
+	return retval;
 }
 
 GtkTreeModel *bluetooth_client_get_model(BluetoothClient *self)
@@ -803,7 +804,8 @@ GtkTreeModel *bluetooth_client_get_model
 		gtk_tree_model_get(GTK_TREE_MODEL(store), &iter,
 						COLUMN_PATH, &path, -1);
 
-		if (!g_ascii_strcasecmp(path, adapter)) {
+		if ((adapter == NULL && path != NULL)
+		    || !g_ascii_strcasecmp(path, adapter)) {
 			GtkTreePath *path;
 
 			path = gtk_tree_model_get_path(GTK_TREE_MODEL(store), &iter);
Index: common/client.h
===================================================================
RCS file: /cvsroot/bluez/gnome/common/client.h,v
retrieving revision 1.11
diff -u -p -r1.11 client.h
--- common/client.h	3 Apr 2007 22:45:08 -0000	1.11
+++ common/client.h	24 Jul 2007 16:12:18 -0000
@@ -57,8 +57,6 @@ GType bluetooth_client_get_type(void);
 
 BluetoothClient *bluetooth_client_new(void);
 
-void bluetooth_client_destroy(BluetoothClient *self);
-
 enum {
 	COLUMN_PATH,
 	COLUMN_ACTIVE,

--=-REWbEXe8/ROXmhvOZaxi
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
--=-REWbEXe8/ROXmhvOZaxi
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--=-REWbEXe8/ROXmhvOZaxi--
