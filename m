Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Bastien Nocera <hadess@hadess.net>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1185481079.3641.339.camel@cookie.hadess.net>
References: <1185475756.3641.329.camel@cookie.hadess.net>
	<1185481079.3641.339.camel@cookie.hadess.net>
Content-Type: multipart/mixed; boundary="=-6BPHY6nMNtPjFM5qgSee"
Date: Fri, 27 Jul 2007 10:18:41 +0100
Message-Id: <1185527921.2848.1.camel@cookie.hadess.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] [PATCH] bluez-gnome: "search" button
	for	the	device selection
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


--=-6BPHY6nMNtPjFM5qgSee
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, 2007-07-26 at 21:17 +0100, Bastien Nocera wrote:
> On Thu, 2007-07-26 at 19:49 +0100, Bastien Nocera wrote:
> > For comments (but pretty much finished), to give you an idea of the way
> > it'd work. The search button starts a discovery on the default adapter,
> > and becomes unsensitive.
> > 
> > The search button becomes sensitive again when all discoveries
> > (including those possibly launched on other adapters) are finished.
> 
> Updated patch against current CVS.
> 
> Renames show_status to show_bonded, as per the property. Adds a property
> to show/hide the search button, and a way for applications hiding the
> search button to automatically start the search.
> 
> I'm just not certain about the client.c changes for tracking the last
> discovery.

Updated patch to avoid tracking the number of discoveries, it's not
useful as we only handle discovery on the default adapter.

-- 
Bastien Nocera <hadess@hadess.net> 

--=-6BPHY6nMNtPjFM5qgSee
Content-Disposition: attachment;
	filename=bluez-gnome-implement-search-button-3.patch
Content-Type: text/x-patch; name=bluez-gnome-implement-search-button-3.patch;
	charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Index: bluetooth-device-selection.c
===================================================================
RCS file: /cvsroot/bluez/gnome/common/bluetooth-device-selection.c,v
retrieving revision 1.4
diff -u -p -r1.4 bluetooth-device-selection.c
--- bluetooth-device-selection.c	26 Jul 2007 19:39:01 -0000	1.4
+++ bluetooth-device-selection.c	27 Jul 2007 09:14:28 -0000
@@ -53,9 +53,12 @@ struct _BluetoothDeviceSelectionPrivate 
 	GtkTreeModel *model;
 	GtkWidget *label;
 
-	/* Whether the bonded icon is shown */
+	/* Widgets/UI bits that can be shown or hidden */
 	GtkCellRenderer *bonded_cell;
-	guint show_status : 1;
+	GtkWidget *search_button;
+
+	guint show_bonded : 1;
+	guint show_search : 1;
 };
 
 G_DEFINE_TYPE(BluetoothDeviceSelection, bluetooth_device_selection, GTK_TYPE_VBOX)
@@ -150,6 +153,15 @@ type_to_text (GtkTreeViewColumn *column,
 	g_object_set (cell, "text", bluetooth_type_to_string (type), NULL);
 }
 
+void
+bluetooth_device_start_discovery (BluetoothDeviceSelection *self)
+{
+	BluetoothDeviceSelectionPrivate *priv = BLUETOOTH_DEVICE_SELECTION_GET_PRIVATE(self);
+
+	gtk_widget_set_sensitive (GTK_WIDGET(priv->search_button), FALSE);
+	bluetooth_client_discover_devices (priv->client, NULL);
+}
+
 gchar *
 bluetooth_device_selection_get_selected_device (BluetoothDeviceSelection *self)
 {
@@ -167,6 +179,23 @@ bluetooth_device_selection_get_selected_
 }
 
 static void
+search_button_clicked (GtkButton *button, gpointer user_data)
+{
+	BluetoothDeviceSelection *self = BLUETOOTH_DEVICE_SELECTION(user_data);
+
+	bluetooth_device_start_discovery (self);
+}
+
+static void
+discoveries_completed (BluetoothClient *client, gpointer user_data)
+{
+	BluetoothDeviceSelection *self = BLUETOOTH_DEVICE_SELECTION(user_data);
+	BluetoothDeviceSelectionPrivate *priv = BLUETOOTH_DEVICE_SELECTION_GET_PRIVATE(self);
+
+	gtk_widget_set_sensitive (GTK_WIDGET(priv->search_button), TRUE);
+}
+
+static void
 select_browse_device_callback (GtkTreeSelection *selection, gpointer user_data)
 {
 	BluetoothDeviceSelection *self = user_data;
@@ -184,11 +213,11 @@ static void
 bluetooth_device_selection_init(BluetoothDeviceSelection *self)
 {
 	BluetoothDeviceSelectionPrivate *priv = BLUETOOTH_DEVICE_SELECTION_GET_PRIVATE(self);
-	GtkWidget *tree, *scrolled, *frame, *box;
+	GtkWidget *tree, *scrolled, *frame, *box, *hbox;
 	GtkCellRenderer *renderer;
 	GtkTreeViewColumn *column;
 
-	priv->show_status = TRUE;
+	priv->show_bonded = TRUE;
 
 	gtk_box_set_spacing (GTK_BOX(self), 6);
 	gtk_box_set_homogeneous (GTK_BOX(self), FALSE);
@@ -204,7 +233,9 @@ bluetooth_device_selection_init(Bluetoot
 
 	priv->client = bluetooth_client_new ();
 
-	//FIXME add a frame around it
+	g_signal_connect (G_OBJECT(priv->client), "discoveries-completed",
+			  G_CALLBACK(discoveries_completed), self);
+
 	/* Create the scrolled window */
 	scrolled = gtk_scrolled_window_new (NULL, NULL);
 
@@ -270,10 +301,17 @@ bluetooth_device_selection_init(Bluetoot
 		g_object_unref (priv->model);
 	}
 
-	bluetooth_client_discover_devices (priv->client, NULL);
-
 	gtk_container_add (GTK_CONTAINER(scrolled), tree);
-	gtk_container_add (GTK_CONTAINER(box), scrolled);
+	gtk_box_pack_start (GTK_BOX(box), scrolled, TRUE, TRUE, 6);
+
+	hbox = gtk_hbox_new (FALSE, 0);
+	priv->search_button = gtk_button_new_with_label (_("Search"));
+	g_signal_connect (G_OBJECT(priv->search_button), "clicked",
+			  G_CALLBACK(search_button_clicked), self);
+	gtk_box_pack_start (GTK_BOX(box), hbox, FALSE, FALSE, 0);
+	gtk_box_pack_start (GTK_BOX(hbox), priv->search_button,
+			    FALSE, FALSE, 0);
+
 	gtk_widget_show_all (scrolled);
 }
 
@@ -289,7 +327,8 @@ enum {
 	PROP_0,
 	PROP_TITLE,
 	PROP_DEVICE_SELECTED,
-	PROP_SHOW_BONDING
+	PROP_SHOW_BONDING,
+	PROP_SHOW_SEARCH
 };
 
 static void
@@ -312,9 +351,14 @@ bluetooth_device_selection_set_property 
 		}
 		break;
 	case PROP_SHOW_BONDING:
-		priv->show_status = g_value_get_boolean (value);
+		priv->show_bonded = g_value_get_boolean (value);
 		if (priv->bonded_cell != NULL)
-			g_object_set (G_OBJECT (priv->bonded_cell), "visible", priv->show_status, NULL);
+			g_object_set (G_OBJECT (priv->bonded_cell), "visible", priv->show_bonded, NULL);
+		break;
+	case PROP_SHOW_SEARCH:
+		priv->show_search = g_value_get_boolean (value);
+		if (priv->search_button != NULL)
+			g_object_set (G_OBJECT (priv->search_button), "visible", priv->show_search, NULL);
 		break;
 	default:
 		G_OBJECT_WARN_INVALID_PROPERTY_ID(object, prop_id, pspec);
@@ -334,7 +378,10 @@ bluetooth_device_selection_get_property 
 		g_value_set_string (value, bluetooth_device_selection_get_selected_device (self));
 		break;
 	case PROP_SHOW_BONDING:
-		g_value_set_boolean (value, priv->show_status);
+		g_value_set_boolean (value, priv->show_bonded);
+		break;
+	case PROP_SHOW_SEARCH:
+		g_value_set_boolean (value, priv->show_search);
 		break;
 	default:
 		G_OBJECT_WARN_INVALID_PROPERTY_ID(object, prop_id, pspec);
@@ -369,7 +416,10 @@ bluetooth_device_selection_class_init (B
 										    NULL, NULL, NULL, G_PARAM_READABLE));
 	g_object_class_install_property (G_OBJECT_CLASS(klass),
 					 PROP_SHOW_BONDING, g_param_spec_boolean ("show-bonding",
-										    NULL, NULL, TRUE, G_PARAM_READWRITE));
+										  NULL, NULL, TRUE, G_PARAM_READWRITE));
+	g_object_class_install_property (G_OBJECT_CLASS(klass),
+					 PROP_SHOW_SEARCH, g_param_spec_boolean ("show-search",
+										 NULL, NULL, TRUE, G_PARAM_READWRITE));
 }
 
 GtkWidget *
Index: bluetooth-device-selection.h
===================================================================
RCS file: /cvsroot/bluez/gnome/common/bluetooth-device-selection.h,v
retrieving revision 1.2
diff -u -p -r1.2 bluetooth-device-selection.h
--- bluetooth-device-selection.h	25 Jul 2007 18:01:44 -0000	1.2
+++ bluetooth-device-selection.h	27 Jul 2007 09:14:29 -0000
@@ -58,6 +58,7 @@ GType bluetooth_device_selection_get_typ
 
 GtkWidget *bluetooth_device_selection_new (const gchar *title);
 gchar *bluetooth_device_selection_get_selected_device (BluetoothDeviceSelection *sel);
+void bluetooth_device_start_discovery (BluetoothDeviceSelection *sel);
 
 G_END_DECLS
 
Index: client.c
===================================================================
RCS file: /cvsroot/bluez/gnome/common/client.c,v
retrieving revision 1.19
diff -u -p -r1.19 client.c
--- client.c	26 Jul 2007 19:39:01 -0000	1.19
+++ client.c	27 Jul 2007 09:14:29 -0000
@@ -50,6 +50,13 @@ struct _BluetoothClientPrivate {
 	gboolean registered;
 };
 
+enum {
+	DISCOVERIES_COMPLETED,
+	LAST_SIGNAL
+};
+
+static int client_table_signals[LAST_SIGNAL] = { 0 };
+
 G_DEFINE_TYPE(BluetoothClient, bluetooth_client, G_TYPE_OBJECT)
 
 static void bluetooth_client_init(BluetoothClient *self)
@@ -448,6 +455,9 @@ static void add_adapter(const char *path
 	dbus_g_proxy_connect_signal(object, "RemoteNameUpdated",
 				G_CALLBACK(name_updated), tree_path, NULL);
 
+	dbus_g_proxy_add_signal(object, "DiscoveryCompleted",
+				G_TYPE_INVALID);
+
 	update_adapter(object, &iter);
 }
 
@@ -498,6 +508,14 @@ static void default_adapter_changed(DBus
 	g_free(temp);
 }
 
+static void discovery_completed(DBusGProxy *object,
+				gpointer user_data)
+{
+	BluetoothClient *self = BLUETOOTH_CLIENT(user_data);
+
+	g_signal_emit(G_OBJECT(self), client_table_signals[DISCOVERIES_COMPLETED], 0);
+}
+
 static void setup_manager(void)
 {
 	DBusGProxy *object;
@@ -592,6 +610,15 @@ static void bluetooth_client_class_init(
 			G_TYPE_INT, G_TYPE_STRING, G_TYPE_UINT,
 			G_TYPE_BOOLEAN, G_TYPE_BOOLEAN);
 
+	client_table_signals[DISCOVERIES_COMPLETED] =
+		g_signal_new ("discoveries-completed",
+			      G_TYPE_FROM_CLASS (klass),
+			      G_SIGNAL_RUN_LAST,
+			      G_STRUCT_OFFSET (BluetoothClientClass, discoveries_completed),
+			      NULL, NULL,
+			      g_cclosure_marshal_VOID__VOID,
+			      G_TYPE_NONE, 0, G_TYPE_NONE);
+
 	setup_dbus();
 
 	setup_manager();
@@ -684,8 +711,18 @@ gboolean bluetooth_client_discover_devic
 						COLUMN_OBJECT, &object, -1);
 
 		if (g_ascii_strcasecmp(path, adapter) == 0) {
+			/* Disconnect any lingering signals, to avoid the callback
+			 * being called twice */
+			dbus_g_proxy_disconnect_signal(object, "DiscoveryCompleted",
+						       G_CALLBACK(discovery_completed),
+						       self);
+			dbus_g_proxy_connect_signal(object, "DiscoveryCompleted",
+						    G_CALLBACK(discovery_completed),
+						    self, NULL);
+
 			dbus_g_proxy_call(object, "DiscoverDevices",
 							NULL, G_TYPE_INVALID);
+
 			return TRUE;
 		}
 
Index: client.h
===================================================================
RCS file: /cvsroot/bluez/gnome/common/client.h,v
retrieving revision 1.13
diff -u -p -r1.13 client.h
--- client.h	26 Jul 2007 19:39:01 -0000	1.13
+++ client.h	27 Jul 2007 09:14:29 -0000
@@ -51,6 +51,8 @@ struct _BluetoothClient {
 
 struct _BluetoothClientClass {
 	GObjectClass parent_class;
+
+	void (*discoveries_completed) (BluetoothClient *self);
 };
 
 GType bluetooth_client_get_type(void);

--=-6BPHY6nMNtPjFM5qgSee
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
--=-6BPHY6nMNtPjFM5qgSee
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--=-6BPHY6nMNtPjFM5qgSee--
