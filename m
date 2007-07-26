Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Bastien Nocera <hadess@hadess.net>
To: BlueZ Hackers <bluez-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="=-paSGR2scE3RhxCujCXMw"
Date: Thu, 26 Jul 2007 19:49:16 +0100
Message-Id: <1185475756.3641.329.camel@cookie.hadess.net>
Mime-Version: 1.0
Subject: [Bluez-devel] [PATCH] bluez-gnome: "search" button for the device
	selection
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


--=-paSGR2scE3RhxCujCXMw
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

For comments (but pretty much finished), to give you an idea of the way
it'd work. The search button starts a discovery on the default adapter,
and becomes unsensitive.

The search button becomes sensitive again when all discoveries
(including those possibly launched on other adapters) are finished.

-- 
Bastien Nocera <hadess@hadess.net> 

--=-paSGR2scE3RhxCujCXMw
Content-Disposition: attachment;
	filename=bluez-gnome-implement-search-button.patch
Content-Type: text/x-patch; name=bluez-gnome-implement-search-button.patch;
	charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Index: bluetooth-device-selection.c
===================================================================
RCS file: /cvsroot/bluez/gnome/common/bluetooth-device-selection.c,v
retrieving revision 1.3
diff -u -p -r1.3 bluetooth-device-selection.c
--- bluetooth-device-selection.c	25 Jul 2007 18:01:44 -0000	1.3
+++ bluetooth-device-selection.c	26 Jul 2007 18:16:41 -0000
@@ -52,6 +52,13 @@ struct _BluetoothDeviceSelectionPrivate 
 	GtkTreeSelection *selection;
 	GtkTreeModel *model;
 	GtkWidget *label;
+
+	/* Widgets/UI bits that can be shown or hidden */
+	GtkCellRenderer *bonded_cell;
+	GtkWidget *search_button;
+
+	guint show_bonded : 1;
+	guint show_search : 1;
 };
 
 G_DEFINE_TYPE(BluetoothDeviceSelection, bluetooth_device_selection, GTK_TYPE_VBOX)
@@ -70,7 +77,7 @@ name_to_text (GtkTreeViewColumn *column,
 	 * Bluetooth address, with the ":" replaced by "-" */
 	if (name == NULL) {
 		name = g_strdup (address);
-		g_strdelimit (address, ":", '-');
+		g_strdelimit (name, ":", '-');
 	}
 
 	g_object_set (cell, "text", name ? name : address, NULL);
@@ -122,6 +129,20 @@ type_to_icon (GtkTreeViewColumn *column,
 }
 
 static void
+bonded_to_icon (GtkTreeViewColumn *column, GtkCellRenderer *cell,
+	      GtkTreeModel *model, GtkTreeIter *iter, gpointer data)
+{
+	gboolean bonded;
+
+	gtk_tree_model_get (model, iter, COLUMN_BONDED, &bonded, -1);
+
+	if (bonded == FALSE)
+		g_object_set (cell, "stock-id", NULL, NULL);
+	else
+		g_object_set (cell, "stock-id", GTK_STOCK_DIALOG_AUTHENTICATION, NULL);
+}
+
+static void
 type_to_text (GtkTreeViewColumn *column, GtkCellRenderer *cell,
 	      GtkTreeModel *model, GtkTreeIter *iter, gpointer data)
 {
@@ -132,6 +153,15 @@ type_to_text (GtkTreeViewColumn *column,
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
@@ -149,6 +179,23 @@ bluetooth_device_selection_get_selected_
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
@@ -166,10 +213,12 @@ static void
 bluetooth_device_selection_init(BluetoothDeviceSelection *self)
 {
 	BluetoothDeviceSelectionPrivate *priv = BLUETOOTH_DEVICE_SELECTION_GET_PRIVATE(self);
-	GtkWidget *tree, *scrolled, *frame, *box;
+	GtkWidget *tree, *scrolled, *frame, *box, *hbox;
 	GtkCellRenderer *renderer;
 	GtkTreeViewColumn *column;
 
+	priv->show_bonded = TRUE;
+
 	gtk_box_set_spacing (GTK_BOX(self), 6);
 	gtk_box_set_homogeneous (GTK_BOX(self), FALSE);
 	gtk_container_set_border_width (GTK_CONTAINER(self), 8);
@@ -184,7 +233,9 @@ bluetooth_device_selection_init(Bluetoot
 
 	priv->client = bluetooth_client_new ();
 
-	//FIXME add a frame around it
+	g_signal_connect (G_OBJECT(priv->client), "discoveries-completed",
+			  G_CALLBACK(discoveries_completed), self);
+
 	/* Create the scrolled window */
 	scrolled = gtk_scrolled_window_new (NULL, NULL);
 
@@ -207,6 +258,7 @@ bluetooth_device_selection_init(Bluetoot
 
 	gtk_tree_view_column_set_title (column, _("Device"));
 
+	/* The type icon */
 	renderer = gtk_cell_renderer_pixbuf_new ();
 	gtk_tree_view_column_set_spacing (column, 4);
 	gtk_tree_view_column_pack_start (column, renderer, FALSE);
@@ -214,12 +266,20 @@ bluetooth_device_selection_init(Bluetoot
 	gtk_tree_view_column_set_cell_data_func (column, renderer,
 						 type_to_icon, NULL, NULL);
 
+	/* The device name */
 	renderer = gtk_cell_renderer_text_new ();
 	gtk_tree_view_column_pack_start (column, renderer, TRUE);
 
 	gtk_tree_view_column_set_cell_data_func (column, renderer,
 						 name_to_text, NULL, NULL);
 
+	/* The bonded icon */
+	priv->bonded_cell = gtk_cell_renderer_pixbuf_new ();
+	gtk_tree_view_column_pack_end (column, priv->bonded_cell, FALSE);
+
+	gtk_tree_view_column_set_cell_data_func (column, priv->bonded_cell,
+						 bonded_to_icon, NULL, NULL);
+
 	gtk_tree_view_append_column (GTK_TREE_VIEW(tree), column);
 
 	gtk_tree_view_column_set_min_width (GTK_TREE_VIEW_COLUMN(column), 280);
@@ -241,10 +301,17 @@ bluetooth_device_selection_init(Bluetoot
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
 
@@ -259,7 +326,9 @@ bluetooth_device_selection_finalize (GOb
 enum {
 	PROP_0,
 	PROP_TITLE,
-	PROP_DEVICE_SELECTED
+	PROP_DEVICE_SELECTED,
+	PROP_SHOW_BONDING,
+	PROP_SHOW_SEARCH
 };
 
 static void
@@ -281,6 +350,16 @@ bluetooth_device_selection_set_property 
 			g_free (str);
 		}
 		break;
+	case PROP_SHOW_BONDING:
+		priv->show_bonded = g_value_get_boolean (value);
+		if (priv->bonded_cell != NULL)
+			g_object_set (G_OBJECT (priv->bonded_cell), "visible", priv->show_bonded, NULL);
+		break;
+	case PROP_SHOW_SEARCH:
+		priv->show_search = g_value_get_boolean (value);
+		if (priv->search_button != NULL)
+			g_object_set (G_OBJECT (priv->search_button), "visible", priv->show_search, NULL);
+		break;
 	default:
 		G_OBJECT_WARN_INVALID_PROPERTY_ID(object, prop_id, pspec);
 		break;
@@ -292,11 +371,18 @@ bluetooth_device_selection_get_property 
 					 GValue *value, GParamSpec *pspec)
 {
 	BluetoothDeviceSelection *self = BLUETOOTH_DEVICE_SELECTION(object);
+	BluetoothDeviceSelectionPrivate *priv = BLUETOOTH_DEVICE_SELECTION_GET_PRIVATE(object);
 
 	switch (prop_id) {
 	case PROP_DEVICE_SELECTED:
 		g_value_set_string (value, bluetooth_device_selection_get_selected_device (self));
 		break;
+	case PROP_SHOW_BONDING:
+		g_value_set_boolean (value, priv->show_bonded);
+		break;
+	case PROP_SHOW_SEARCH:
+		g_value_set_boolean (value, priv->show_search);
+		break;
 	default:
 		G_OBJECT_WARN_INVALID_PROPERTY_ID(object, prop_id, pspec);
 		break;
@@ -328,6 +414,12 @@ bluetooth_device_selection_class_init (B
 	g_object_class_install_property (G_OBJECT_CLASS(klass),
 					 PROP_DEVICE_SELECTED, g_param_spec_string ("device-selected",
 										    NULL, NULL, NULL, G_PARAM_READABLE));
+	g_object_class_install_property (G_OBJECT_CLASS(klass),
+					 PROP_SHOW_BONDING, g_param_spec_boolean ("show-bonding",
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
+++ bluetooth-device-selection.h	26 Jul 2007 18:16:42 -0000
@@ -58,6 +58,7 @@ GType bluetooth_device_selection_get_typ
 
 GtkWidget *bluetooth_device_selection_new (const gchar *title);
 gchar *bluetooth_device_selection_get_selected_device (BluetoothDeviceSelection *sel);
+void bluetooth_device_start_discovery (BluetoothDeviceSelection *sel);
 
 G_END_DECLS
 
Index: client.c
===================================================================
RCS file: /cvsroot/bluez/gnome/common/client.c,v
retrieving revision 1.18
diff -u -p -r1.18 client.c
--- client.c	25 Jul 2007 07:43:59 -0000	1.18
+++ client.c	26 Jul 2007 18:16:42 -0000
@@ -48,8 +48,18 @@ typedef struct _BluetoothClientPrivate B
 
 struct _BluetoothClientPrivate {
 	gboolean registered;
+
+	/* The number of discoveries in progress */
+	guint discoveries;
+};
+
+enum {
+	DISCOVERIES_COMPLETED,
+	LAST_SIGNAL
 };
 
+static int client_table_signals[LAST_SIGNAL] = { 0 };
+
 G_DEFINE_TYPE(BluetoothClient, bluetooth_client, G_TYPE_OBJECT)
 
 static void bluetooth_client_init(BluetoothClient *self)
@@ -190,7 +200,7 @@ static void insert_device(DBusGProxy *ob
 	const char *name = NULL;
 	guint type;
 	guint32 class = 0;
-	gboolean trusted = FALSE, connected = FALSE;
+	gboolean bonded = FALSE, connected = FALSE;
 	gboolean cont;
 
 	dbus_g_proxy_call(object, "GetRemoteName", NULL,
@@ -203,7 +213,7 @@ static void insert_device(DBusGProxy *ob
 
 	dbus_g_proxy_call(object, "HasBonding", NULL,
 				G_TYPE_STRING, address, G_TYPE_INVALID,
-				G_TYPE_BOOLEAN, &trusted, G_TYPE_INVALID);
+				G_TYPE_BOOLEAN, &bonded, G_TYPE_INVALID);
 
 	dbus_g_proxy_call(object, "IsConnected", NULL,
 				G_TYPE_STRING, address, G_TYPE_INVALID,
@@ -227,7 +237,7 @@ static void insert_device(DBusGProxy *ob
 						COLUMN_RSSI, rssi,
 						COLUMN_NAME, name,
 						COLUMN_TYPE, type,
-						COLUMN_TRUSTED, trusted,
+						COLUMN_BONDED, bonded,
 						COLUMN_CONNECTED, connected, -1);
 			return;
 		}
@@ -242,7 +252,7 @@ static void insert_device(DBusGProxy *ob
 					COLUMN_RSSI, rssi,
 					COLUMN_NAME, name,
 					COLUMN_TYPE, type,
-					COLUMN_TRUSTED, trusted,
+					COLUMN_BONDED, bonded,
 					COLUMN_CONNECTED, connected, -1);
 }
 
@@ -448,6 +458,9 @@ static void add_adapter(const char *path
 	dbus_g_proxy_connect_signal(object, "RemoteNameUpdated",
 				G_CALLBACK(name_updated), tree_path, NULL);
 
+	dbus_g_proxy_add_signal(object, "DiscoveryCompleted",
+				G_TYPE_INVALID);
+
 	update_adapter(object, &iter);
 }
 
@@ -498,6 +511,17 @@ static void default_adapter_changed(DBus
 	g_free(temp);
 }
 
+static void discovery_completed(DBusGProxy *object,
+				gpointer user_data)
+{
+	BluetoothClient *self = BLUETOOTH_CLIENT(user_data);
+	BluetoothClientPrivate *priv = BLUETOOTH_CLIENT_GET_PRIVATE(self);
+
+	priv->discoveries--;
+	if (priv->discoveries == 0)
+		g_signal_emit(G_OBJECT(self), client_table_signals[DISCOVERIES_COMPLETED], 0);
+}
+
 static void setup_manager(void)
 {
 	DBusGProxy *object;
@@ -592,6 +616,15 @@ static void bluetooth_client_class_init(
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
@@ -684,8 +717,22 @@ gboolean bluetooth_client_discover_devic
 						COLUMN_OBJECT, &object, -1);
 
 		if (g_ascii_strcasecmp(path, adapter) == 0) {
-			dbus_g_proxy_call(object, "DiscoverDevices",
-							NULL, G_TYPE_INVALID);
+			BluetoothClientPrivate *priv = BLUETOOTH_CLIENT_GET_PRIVATE(self);
+
+			priv->discoveries++;
+			/* Disconnect any lingering signals, to avoid the callback
+			 * being called twice */
+			dbus_g_proxy_disconnect_signal(object, "DiscoveryCompleted",
+						       G_CALLBACK(discovery_completed),
+						       self);
+			dbus_g_proxy_connect_signal(object, "DiscoveryCompleted",
+						    G_CALLBACK(discovery_completed),
+						    self, NULL);
+
+			if (dbus_g_proxy_call(object, "DiscoverDevices",
+							NULL, G_TYPE_INVALID))
+				priv->discoveries--;
+
 			return TRUE;
 		}
 
Index: client.h
===================================================================
RCS file: /cvsroot/bluez/gnome/common/client.h,v
retrieving revision 1.12
diff -u -p -r1.12 client.h
--- client.h	24 Jul 2007 21:23:59 -0000	1.12
+++ client.h	26 Jul 2007 18:16:42 -0000
@@ -51,6 +51,8 @@ struct _BluetoothClient {
 
 struct _BluetoothClientClass {
 	GObjectClass parent_class;
+
+	void (*discoveries_completed) (BluetoothClient *self);
 };
 
 GType bluetooth_client_get_type(void);
@@ -66,7 +68,7 @@ enum {
 	COLUMN_RSSI,
 	COLUMN_NAME,
 	COLUMN_TYPE,
-	COLUMN_TRUSTED,
+	COLUMN_BONDED,
 	COLUMN_CONNECTED,
 };
 
Index: test-client.c
===================================================================
RCS file: /cvsroot/bluez/gnome/common/test-client.c,v
retrieving revision 1.8
diff -u -p -r1.8 test-client.c
--- test-client.c	24 Jul 2007 21:21:29 -0000	1.8
+++ test-client.c	26 Jul 2007 18:16:42 -0000
@@ -112,7 +112,7 @@ static void create_window(void)
 
 	gtk_tree_view_insert_column_with_attributes(GTK_TREE_VIEW(tree), -1,
 					"Trusted", gtk_cell_renderer_text_new(),
-						"text", COLUMN_TRUSTED, NULL);
+						"text", COLUMN_BONDED, NULL);
 
 	gtk_tree_view_insert_column_with_attributes(GTK_TREE_VIEW(tree), -1,
 					"Connected", gtk_cell_renderer_text_new(),

--=-paSGR2scE3RhxCujCXMw
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
--=-paSGR2scE3RhxCujCXMw
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--=-paSGR2scE3RhxCujCXMw--
