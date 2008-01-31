Return-Path: <cyrus@holtmann.org>
From: Bastien Nocera <hadess@hadess.net>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1201791472.2389.275.camel@cookie.hadess.net>
References: <1201227720.2389.17.camel@cookie.hadess.net>
	<1201626119.6218.15.camel@violet>
	<1201714289.2389.227.camel@cookie.hadess.net>
	<1201791472.2389.275.camel@cookie.hadess.net>
Content-Type: multipart/mixed; boundary="=-ers8OyYHdkE4V3yf2A5V"
Date: Thu, 31 Jan 2008 17:48:07 +0000
Message-Id: <1201801687.2389.286.camel@cookie.hadess.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] [PATCH] client.c cleanup
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


--=-ers8OyYHdkE4V3yf2A5V
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


On Thu, 2008-01-31 at 14:57 +0000, Bastien Nocera wrote:
<snip>
> And also a patch for client.c to get the device address again when the
> device changes mode, so we can change it in the tree from the default
> all-zeros address to the real one.
> 
> I'll fix the other bugs now.

Does the above without the forward declaration, plus:
- add the "default-adapter" property, and property changes notification
- listen to default-adapter changes in the selection widget, and change
the tree model if it changes (so we only show the devices for the
current default)
- remove devices from the list when an adapter is removed, so they don't
appear in the treeview
- show "unknown" in the treeview when a device is of unknown type

It fixes all the UI problems I mentioned in the original e-mail. Next up
would be making the search button work.

About the hcid bug, should GetInfo fail when the bdaddr for the device
isn't available, or should it just give out empty information?

Cheers

--=-ers8OyYHdkE4V3yf2A5V
Content-Disposition: attachment; filename=bluez-gnome-fix-multi-adapters.patch
Content-Type: text/x-patch; name=bluez-gnome-fix-multi-adapters.patch;
	charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Index: bluetooth-device-selection.c
===================================================================
RCS file: /cvsroot/bluez/gnome/common/bluetooth-device-selection.c,v
retrieving revision 1.11
diff -u -p -r1.11 bluetooth-device-selection.c
--- bluetooth-device-selection.c	29 Jan 2008 17:03:22 -0000	1.11
+++ bluetooth-device-selection.c	31 Jan 2008 17:29:00 -0000
@@ -54,6 +54,7 @@ struct _BluetoothDeviceSelectionPrivate 
 
 	/* Widgets/UI bits that can be shown or hidden */
 	GtkCellRenderer *bonded_cell;
+	GtkWidget *treeview;
 	GtkWidget *search_button;
 	GtkWidget *device_type_label, *device_type;
 	GtkWidget *device_category_label, *device_category;
@@ -171,8 +172,10 @@ type_to_text (GtkTreeViewColumn *column,
 	guint type;
 
 	gtk_tree_model_get (model, iter, COLUMN_TYPE, &type, -1);
-
-	g_object_set (cell, "text", bluetooth_type_to_string (type), NULL);
+	if (type == BLUETOOTH_TYPE_ANY)
+		g_object_set (cell, "text", _("Unknown"), NULL);
+	else
+		g_object_set (cell, "text", bluetooth_type_to_string (type), NULL);
 }
 
 void
@@ -283,7 +286,8 @@ filter_type_changed_cb (GtkComboBox *wid
 	BluetoothDeviceSelectionPrivate *priv = BLUETOOTH_DEVICE_SELECTION_GET_PRIVATE(self);
 
 	priv->device_type_filter = gtk_combo_box_get_active (GTK_COMBO_BOX(priv->device_type));
-	gtk_tree_model_filter_refilter (GTK_TREE_MODEL_FILTER (priv->filter));
+	if (priv->filter)
+		gtk_tree_model_filter_refilter (GTK_TREE_MODEL_FILTER (priv->filter));
 	g_object_notify (G_OBJECT(self), "device-type-filter");
 }
 static void
@@ -293,10 +297,40 @@ filter_category_changed_cb (GtkComboBox 
 	BluetoothDeviceSelectionPrivate *priv = BLUETOOTH_DEVICE_SELECTION_GET_PRIVATE(self);
 
 	priv->device_category_filter = gtk_combo_box_get_active (GTK_COMBO_BOX(priv->device_category));
-	gtk_tree_model_filter_refilter (GTK_TREE_MODEL_FILTER (priv->filter));
+	if (priv->filter)
+		gtk_tree_model_filter_refilter (GTK_TREE_MODEL_FILTER (priv->filter));
 	g_object_notify (G_OBJECT(self), "device-category-filter");
 }
 
+static void default_adapter_changed (GObject    *gobject,
+				     GParamSpec *arg1,
+				     gpointer    data)
+{
+	BluetoothDeviceSelection *self = BLUETOOTH_DEVICE_SELECTION (data);
+	BluetoothDeviceSelectionPrivate *priv = BLUETOOTH_DEVICE_SELECTION_GET_PRIVATE(self);
+	char *adapter;
+
+	g_object_get (gobject, "default-adapter", &adapter, NULL);
+
+	if (adapter == NULL)
+		gtk_tree_view_set_model (GTK_TREE_VIEW(priv->treeview), NULL);
+
+	if (priv->model)
+		g_object_unref (priv->model);
+
+	if (adapter == NULL)
+		return;
+
+	priv->model = bluetooth_client_get_model_with_filter (priv->client, NULL, NULL, NULL);
+	if (priv->model) {
+		priv->filter = gtk_tree_model_filter_new (priv->model, NULL);
+		gtk_tree_model_filter_set_visible_func (GTK_TREE_MODEL_FILTER (priv->filter),
+							filter_func, self, NULL);
+		gtk_tree_view_set_model (GTK_TREE_VIEW(priv->treeview), priv->filter);
+		g_object_unref (priv->filter);
+	}
+}
+
 static GtkWidget *
 create_treeview (BluetoothDeviceSelection *self)
 {
@@ -370,13 +404,12 @@ create_treeview (BluetoothDeviceSelectio
 		priv->filter = gtk_tree_model_filter_new (priv->model, NULL);
 		gtk_tree_model_filter_set_visible_func (GTK_TREE_MODEL_FILTER (priv->filter),
 							filter_func, self, NULL);
-	}
-	if (priv->model) {
 		gtk_tree_view_set_model (GTK_TREE_VIEW(tree), priv->filter);
 		g_object_unref (priv->filter);
 	}
 
 	gtk_container_add (GTK_CONTAINER(scrolled), tree);
+	priv->treeview = tree;
 
 	return scrolled;
 }
@@ -537,6 +570,9 @@ bluetooth_device_selection_init(Bluetoot
 		gtk_widget_show (priv->device_type);
 	}
 
+	g_signal_connect (priv->client, "notify::default-adapter",
+			  G_CALLBACK (default_adapter_changed), self);
+
 	bluetooth_device_selection_start_discovery (self);
 }
 
Index: client.c
===================================================================
RCS file: /cvsroot/bluez/gnome/common/client.c,v
retrieving revision 1.37
diff -u -p -r1.37 client.c
--- client.c	29 Jan 2008 17:00:58 -0000	1.37
+++ client.c	31 Jan 2008 17:29:00 -0000
@@ -56,10 +56,17 @@ enum {
 	LAST_SIGNAL
 };
 
+enum {
+	PROP_0,
+	PROP_DEFAULT_ADAPTER
+};
+
 static int client_table_signals[LAST_SIGNAL] = { 0 };
 
 G_DEFINE_TYPE(BluetoothClient, bluetooth_client, G_TYPE_OBJECT)
 
+static void update_adapter(DBusGProxy *object, GtkTreeIter *iter, BluetoothClient *client);
+
 static gboolean find_iter_for_object(DBusGProxy *object,
 				     BluetoothClient *client,
 				     GtkTreeIter *iter)
@@ -84,11 +91,6 @@ static gboolean find_iter_for_object(DBu
 	return FALSE;
 }
 
-static void mode_changed(DBusGProxy *object,
-				const char *mode, gpointer user_data)
-{
-}
-
 static void timeout_changed(DBusGProxy *object,
 				const guint32 timeout, gpointer user_data)
 {
@@ -596,6 +598,34 @@ failover:
 		g_error_free(error);
 }
 
+static void mode_changed(DBusGProxy *object,
+				const char *mode, gpointer user_data)
+{
+	BluetoothClient *client = (BluetoothClient *) user_data;
+	BluetoothClientPrivate *priv = BLUETOOTH_CLIENT_GET_PRIVATE(client);
+	GtkTreeIter iter;
+	gboolean cont;
+
+	cont = gtk_tree_model_get_iter_first(GTK_TREE_MODEL(priv->store), &iter);
+
+	while (cont == TRUE) {
+		DBusGProxy *o;
+
+		gtk_tree_model_get(GTK_TREE_MODEL(priv->store), &iter,
+						COLUMN_OBJECT, &o, -1);
+
+		if (object == o) {
+			gtk_tree_store_set(priv->store, &iter,
+						COLUMN_ACTIVE, TRUE, -1);
+			update_adapter(object, &iter, client);
+
+			return;
+		}
+
+		cont = gtk_tree_model_iter_next(GTK_TREE_MODEL(priv->store), &iter);
+	}
+}
+
 static void add_adapter(const char *path, BluetoothClient *client)
 {
 	BluetoothClientPrivate *priv = BLUETOOTH_CLIENT_GET_PRIVATE(client);
@@ -715,6 +745,11 @@ static void add_adapter(const char *path
 
 	dbus_g_proxy_add_signal(object, "DiscoveryCompleted", G_TYPE_INVALID);
 
+	if (priv->default_adapter == NULL) {
+		priv->default_adapter = g_ascii_strcasecmp(path, "") ? g_strdup(path) : NULL;
+		g_object_notify (G_OBJECT (client), "default-adapter");
+	}
+
 	update_adapter(object, &iter, client);
 }
 
@@ -733,10 +768,21 @@ static void remove_adapter(const char *p
 						COLUMN_PATH, &value, -1);
 
 		if (g_ascii_strcasecmp(path, value) == 0) {
+			GtkTreeIter child;
+
 			gtk_tree_store_set(priv->store, &iter,
 						COLUMN_ACTIVE, FALSE,
 						COLUMN_ADDRESS, NULL,
 						COLUMN_NAME, NULL, -1);
+
+			/* Remove the children */
+			if (gtk_tree_model_iter_children(GTK_TREE_MODEL(priv->store),
+							 &child, &iter) == FALSE)
+				return;
+
+			cont = gtk_tree_store_remove (priv->store, &child);
+			while (cont != FALSE)
+				cont = gtk_tree_store_remove (priv->store, &child);
 			return;
 		}
 
@@ -759,14 +805,15 @@ static void adapter_removed(DBusGProxy *
 static void default_adapter_changed(DBusGProxy *object,
 				const char *path, gpointer user_data)
 {
-	BluetoothClientPrivate *priv = BLUETOOTH_CLIENT_GET_PRIVATE(user_data);
+	BluetoothClient *client = (BluetoothClient *) user_data;
+	BluetoothClientPrivate *priv = BLUETOOTH_CLIENT_GET_PRIVATE(client);
 	gchar *temp;
 	
 	temp = priv->default_adapter;
 	priv->default_adapter = g_ascii_strcasecmp(path, "") ? g_strdup(path) : NULL;
 	g_free(temp);
 
-	g_message ("new default adapter: %s", priv->default_adapter);
+	g_object_notify (G_OBJECT (client), "default-adapter");
 }
 
 static void discovery_completed(DBusGProxy *object,
@@ -896,9 +943,12 @@ static void bluetooth_client_set_propert
 static void bluetooth_client_get_property(GObject *object, guint prop_id,
 					GValue *value, GParamSpec *pspec)
 {
-	//BluetoothClientPrivate *priv = BLUETOOTH_CLIENT_GET_PRIVATE(object);
+	BluetoothClientPrivate *priv = BLUETOOTH_CLIENT_GET_PRIVATE(object);
 
 	switch (prop_id) {
+	case PROP_DEFAULT_ADAPTER:
+		g_value_set_string (value, priv->default_adapter);
+		break;
 	default:
 		G_OBJECT_WARN_INVALID_PROPERTY_ID(object, prop_id, pspec);
 		break;
@@ -907,6 +957,8 @@ static void bluetooth_client_get_propert
 
 static void bluetooth_client_class_init(BluetoothClientClass *klass)
 {
+	GObjectClass *object_class;
+
 	g_type_class_add_private(klass, sizeof(BluetoothClientPrivate));
 
 	G_OBJECT_CLASS(klass)->finalize = bluetooth_client_finalize;
@@ -924,6 +976,12 @@ static void bluetooth_client_class_init(
 				g_cclosure_marshal_VOID__VOID,
 				G_TYPE_NONE, 0, G_TYPE_NONE);
 
+	object_class = (GObjectClass *) klass;
+
+	g_object_class_install_property (object_class, PROP_DEFAULT_ADAPTER,
+					 g_param_spec_string ("default-adapter", NULL, NULL,
+							      NULL, G_PARAM_READABLE));
+
 	dbus_g_object_register_marshaller(marshal_VOID__STRING_UINT_INT,
 				G_TYPE_NONE, G_TYPE_STRING, G_TYPE_UINT,
 						G_TYPE_INT, G_TYPE_INVALID);
Index: test-client.c
===================================================================
RCS file: /cvsroot/bluez/gnome/common/test-client.c,v
retrieving revision 1.11
diff -u -p -r1.11 test-client.c
--- test-client.c	31 Jul 2007 18:22:47 -0000	1.11
+++ test-client.c	31 Jan 2008 17:29:00 -0000
@@ -41,6 +41,17 @@ static void delete_callback(GtkWidget *w
 	gtk_main_quit();
 }
 
+static void default_adapter_changed (GObject    *gobject,
+				     GParamSpec *arg1,
+				     gpointer    user_data)
+{
+	char *adapter;
+
+	g_object_get (gobject, "default-adapter", &adapter, NULL);
+	g_message ("default adapter changed: %s", adapter);
+	g_free (adapter);
+}
+
 static void create_window(void)
 {
 	GtkWidget *window;
@@ -135,6 +146,8 @@ static void create_window(void)
 
 	g_signal_connect(G_OBJECT(window), "delete-event",
 					G_CALLBACK(delete_callback), NULL);
+	g_signal_connect(G_OBJECT(client), "notify::default-adapter",
+			 G_CALLBACK(default_adapter_changed), client);
 
 	gtk_widget_show_all(window);
 }

--=-ers8OyYHdkE4V3yf2A5V
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--=-ers8OyYHdkE4V3yf2A5V
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--=-ers8OyYHdkE4V3yf2A5V--
