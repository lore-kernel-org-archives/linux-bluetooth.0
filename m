Return-Path: <cyrus@holtmann.org>
From: Bastien Nocera <hadess@hadess.net>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20080311102907.kkvnan148sgo8o8k@wmlab.csie.ncu.edu.tw>
References: <20080311102907.kkvnan148sgo8o8k@wmlab.csie.ncu.edu.tw>
Content-Type: multipart/mixed; boundary="=-50MDLL2AwpcjvNMEk7zc"
Date: Tue, 11 Mar 2008 18:35:26 +0000
Message-Id: <1205260526.30595.91.camel@cookie.hadess.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] [PATCH] bluez-gnome access
	volatile	while	adapter-changed
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


--=-50MDLL2AwpcjvNMEk7zc
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


On Tue, 2008-03-11 at 10:29 +0800, Ming-I Hsieh wrote:
> Hi, hadess
> 
> Thanks, I had got the patch from bugzilla and it work fine to fix this  
> problem.

This patch makes sure we're not receiving signals when the client object
is still alive, but the front-end device selection widget is gone.

Cheers

--=-50MDLL2AwpcjvNMEk7zc
Content-Disposition: attachment;
	filename=bluez-gnome-device-removal-crash-2.patch
Content-Type: text/x-patch; name=bluez-gnome-device-removal-crash-2.patch;
	charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Index: common/bluetooth-device-selection.c
===================================================================
RCS file: /cvsroot/bluez/gnome/common/bluetooth-device-selection.c,v
retrieving revision 1.19
diff -u -p -u -p -r1.19 bluetooth-device-selection.c
--- common/bluetooth-device-selection.c	7 Mar 2008 15:00:57 -0000	1.19
+++ common/bluetooth-device-selection.c	11 Mar 2008 15:44:23 -0000
@@ -54,6 +54,7 @@ struct _BluetoothDeviceSelectionPrivate 
 
 	gulong discov_started_id;
 	gulong discov_completed_id;
+	gulong default_adapter_changed_id;
 
 	/* Widgets/UI bits that can be shown or hidden */
 	GtkCellRenderer *bonded_cell;
@@ -596,8 +597,8 @@ bluetooth_device_selection_init(Bluetoot
 		gtk_widget_show (priv->device_type);
 	}
 
-	g_signal_connect (priv->client, "notify::default-adapter",
-			  G_CALLBACK (default_adapter_changed), self);
+	priv->default_adapter_changed_id = g_signal_connect (priv->client, "notify::default-adapter",
+							     G_CALLBACK (default_adapter_changed), self);
 }
 
 static void
@@ -607,6 +608,7 @@ bluetooth_device_selection_finalize (GOb
 
 	g_signal_handler_disconnect (G_OBJECT(priv->client), priv->discov_started_id);
 	g_signal_handler_disconnect (G_OBJECT(priv->client), priv->discov_completed_id);
+	g_signal_handler_disconnect (G_OBJECT(priv->client), priv->default_adapter_changed_id);
 
 	bluetooth_client_cancel_discovery (priv->client, NULL);
 }
Index: common/client.c
===================================================================
RCS file: /cvsroot/bluez/gnome/common/client.c,v
retrieving revision 1.43
diff -u -p -u -p -r1.43 client.c
--- common/client.c	7 Mar 2008 14:13:48 -0000	1.43
+++ common/client.c	11 Mar 2008 15:44:24 -0000
@@ -47,6 +47,7 @@ struct _BluetoothClientPrivate {
 	gboolean registered;
 
 	DBusGConnection *conn;
+	DBusGProxy *manager_object;
 	GtkTreeStore *store;
 	gchar *default_adapter;
 };
@@ -897,34 +898,33 @@ static void default_adapter_changed(DBus
 static void setup_manager(BluetoothClient *client)
 {
 	BluetoothClientPrivate *priv = BLUETOOTH_CLIENT_GET_PRIVATE(client);
-	DBusGProxy *object;
 	GError *error = NULL;
 	char **array = NULL;
 
-	object = dbus_g_proxy_new_for_name(priv->conn, "org.bluez",
+	priv->manager_object = dbus_g_proxy_new_for_name(priv->conn, "org.bluez",
 					"/org/bluez", "org.bluez.Manager");
 
-	dbus_g_proxy_add_signal(object, "AdapterAdded",
+	dbus_g_proxy_add_signal(priv->manager_object, "AdapterAdded",
 					G_TYPE_STRING, G_TYPE_INVALID);
 
-	dbus_g_proxy_connect_signal(object, "AdapterAdded",
+	dbus_g_proxy_connect_signal(priv->manager_object, "AdapterAdded",
 				G_CALLBACK(adapter_added), client, NULL);
 
-	dbus_g_proxy_add_signal(object, "AdapterRemoved",
+	dbus_g_proxy_add_signal(priv->manager_object, "AdapterRemoved",
 					G_TYPE_STRING, G_TYPE_INVALID);
 
-	dbus_g_proxy_connect_signal(object, "AdapterRemoved",
+	dbus_g_proxy_connect_signal(priv->manager_object, "AdapterRemoved",
 				G_CALLBACK(adapter_removed), client, NULL);
 
-	dbus_g_proxy_add_signal(object, "DefaultAdapterChanged",
+	dbus_g_proxy_add_signal(priv->manager_object, "DefaultAdapterChanged",
 					G_TYPE_STRING, G_TYPE_INVALID);
 
-	dbus_g_proxy_connect_signal(object, "DefaultAdapterChanged",
+	dbus_g_proxy_connect_signal(priv->manager_object, "DefaultAdapterChanged",
 			G_CALLBACK(default_adapter_changed), client, NULL);
 
-	manager_default_adapter(object, &priv->default_adapter, NULL);
+	manager_default_adapter(priv->manager_object, &priv->default_adapter, NULL);
 
-	manager_list_adapters(object, &array, &error);
+	manager_list_adapters(priv->manager_object, &array, &error);
 
 	if (error == NULL) {
 		while (*array) {
@@ -974,9 +974,16 @@ static void bluetooth_client_finalize(GO
 {
 	BluetoothClientPrivate *priv = BLUETOOTH_CLIENT_GET_PRIVATE(object);
 
+	/* Disconnect the handlers from setup_manager() */
+	g_signal_handlers_disconnect_by_func (priv->manager_object, adapter_added, object);
+	g_signal_handlers_disconnect_by_func (priv->manager_object, adapter_removed, object);
+	g_signal_handlers_disconnect_by_func (priv->manager_object, default_adapter_changed,
+					      object);
+
 	priv->registered = FALSE;
 	g_free(priv->default_adapter);
 	g_object_unref(G_OBJECT(priv->store));
+	g_object_unref (priv->manager_object);
 }
 
 static void bluetooth_client_init(BluetoothClient *client)

--=-50MDLL2AwpcjvNMEk7zc
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--=-50MDLL2AwpcjvNMEk7zc
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--=-50MDLL2AwpcjvNMEk7zc--
