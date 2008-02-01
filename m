Return-Path: <cyrus@holtmann.org>
From: Bastien Nocera <hadess@hadess.net>
To: BlueZ Hackers <bluez-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="=-vYQYAyggrWx3pMPyk6Gk"
Date: Fri, 01 Feb 2008 11:42:43 +0000
Message-Id: <1201866163.2389.311.camel@cookie.hadess.net>
Mime-Version: 1.0
Subject: [Bluez-devel] [PATCH] Send DefaultAdapterChanged more often
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


--=-vYQYAyggrWx3pMPyk6Gk
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Before the patch, we only used to send the DefaultAdapter changed from
one adapter to another, never when there wasn't a new default adapter.

This allows us to remove bad tricks from client.c as well.

Both patches attached. The bluez-gnome patch includes the changes from
the client.c cleanup thread.

Try plugging/unplugging your adapters after the patching, and the
treeview will magically change its contents.

Cheers

--=-vYQYAyggrWx3pMPyk6Gk
Content-Disposition: attachment;
	filename=bluez-utils-more-default-adapter-signal.patch
Content-Type: text/x-patch; name=bluez-utils-more-default-adapter-signal.patch;
	charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Index: dbus-hci.c
===================================================================
RCS file: /cvsroot/bluez/utils/hcid/dbus-hci.c,v
retrieving revision 1.35
diff -u -p -r1.35 dbus-hci.c
--- dbus-hci.c	28 Jan 2008 10:38:40 -0000	1.35
+++ dbus-hci.c	1 Feb 2008 11:31:14 -0000
@@ -532,7 +532,7 @@ int hcid_dbus_unregister_device(uint16_t
 
 	ret = unregister_adapter_path(path);
 
-	if (ret == 0 && get_default_adapter() == id) {
+	if (ret == 0 && (get_default_adapter() == id || get_default_adapter() < 0)) {
 		int new_default = hci_get_route(NULL);
 		set_default_adapter(new_default);
 		if (new_default >= 0) {
@@ -543,6 +543,13 @@ int hcid_dbus_unregister_device(uint16_t
 							"DefaultAdapterChanged",
 							DBUS_TYPE_STRING, &pptr,
 							DBUS_TYPE_INVALID);
+		} else {
+			*path = '\0';
+			dbus_connection_emit_signal(connection, BASE_PATH,
+							MANAGER_INTERFACE,
+							"DefaultAdapterChanged",
+							DBUS_TYPE_STRING, &pptr,
+							DBUS_TYPE_INVALID);
 		}
 	}
 
@@ -551,7 +558,7 @@ int hcid_dbus_unregister_device(uint16_t
 
 int hcid_dbus_start_device(uint16_t id)
 {
-	char path[MAX_PATH_LENGTH];
+	char path[MAX_PATH_LENGTH], *pptr;
 	struct hci_dev_info di;
 	struct adapter* adapter;
 	struct hci_conn_list_req *cl = NULL;
@@ -633,10 +640,17 @@ int hcid_dbus_start_device(uint16_t id)
 					DBUS_TYPE_STRING, &mode,
 					DBUS_TYPE_INVALID);
 
-failed:
-	if (ret == 0 && get_default_adapter() < 0)
+	if (get_default_adapter() < 0) {
 		set_default_adapter(id);
+		pptr = path;
+		dbus_connection_emit_signal(connection, BASE_PATH,
+					    MANAGER_INTERFACE,
+					    "DefaultAdapterChanged",
+					    DBUS_TYPE_STRING, &pptr,
+					    DBUS_TYPE_INVALID);
+	}
 
+failed:
 	if (dd >= 0)
 		hci_close_dev(dd);
 

--=-vYQYAyggrWx3pMPyk6Gk
Content-Disposition: attachment;
	filename=bluez-gnome-handle-default-adapter.patch
Content-Type: text/x-patch; name=bluez-gnome-handle-default-adapter.patch;
	charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Index: bluetooth-device-selection.c
===================================================================
RCS file: /cvsroot/bluez/gnome/common/bluetooth-device-selection.c,v
retrieving revision 1.11
diff -u -p -r1.11 bluetooth-device-selection.c
--- bluetooth-device-selection.c	29 Jan 2008 17:03:22 -0000	1.11
+++ bluetooth-device-selection.c	1 Feb 2008 11:39:38 -0000
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
@@ -293,10 +297,45 @@ filter_category_changed_cb (GtkComboBox 
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
+	if (adapter == NULL) {
+		gtk_widget_set_sensitive (GTK_WIDGET (priv->treeview), FALSE);
+		gtk_tree_view_set_model (GTK_TREE_VIEW(priv->treeview), NULL);
+	}
+
+	if (priv->model) {
+		g_object_unref (priv->model);
+		priv->model = NULL;
+	}
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
+		gtk_widget_set_sensitive (GTK_WIDGET (priv->treeview), TRUE);
+	}
+}
+
 static GtkWidget *
 create_treeview (BluetoothDeviceSelection *self)
 {
@@ -370,13 +409,14 @@ create_treeview (BluetoothDeviceSelectio
 		priv->filter = gtk_tree_model_filter_new (priv->model, NULL);
 		gtk_tree_model_filter_set_visible_func (GTK_TREE_MODEL_FILTER (priv->filter),
 							filter_func, self, NULL);
-	}
-	if (priv->model) {
 		gtk_tree_view_set_model (GTK_TREE_VIEW(tree), priv->filter);
 		g_object_unref (priv->filter);
+	} else {
+		gtk_widget_set_sensitive (GTK_WIDGET (tree), FALSE);
 	}
 
 	gtk_container_add (GTK_CONTAINER(scrolled), tree);
+	priv->treeview = tree;
 
 	return scrolled;
 }
@@ -537,6 +577,9 @@ bluetooth_device_selection_init(Bluetoot
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
+++ client.c	1 Feb 2008 11:39:39 -0000
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
@@ -733,10 +763,21 @@ static void remove_adapter(const char *p
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
 
@@ -759,14 +800,16 @@ static void adapter_removed(DBusGProxy *
 static void default_adapter_changed(DBusGProxy *object,
 				const char *path, gpointer user_data)
 {
-	BluetoothClientPrivate *priv = BLUETOOTH_CLIENT_GET_PRIVATE(user_data);
-	gchar *temp;
-	
-	temp = priv->default_adapter;
-	priv->default_adapter = g_ascii_strcasecmp(path, "") ? g_strdup(path) : NULL;
-	g_free(temp);
+	BluetoothClient *client = (BluetoothClient *) user_data;
+	BluetoothClientPrivate *priv = BLUETOOTH_CLIENT_GET_PRIVATE(client);
+
+	g_free(priv->default_adapter);
+	if (path != NULL && *path != '\0')
+		priv->default_adapter = g_strdup(path);
+	else
+		priv->default_adapter = NULL;
 
-	g_message ("new default adapter: %s", priv->default_adapter);
+	g_object_notify (G_OBJECT (client), "default-adapter");
 }
 
 static void discovery_completed(DBusGProxy *object,
@@ -896,9 +939,12 @@ static void bluetooth_client_set_propert
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
@@ -907,6 +953,8 @@ static void bluetooth_client_get_propert
 
 static void bluetooth_client_class_init(BluetoothClientClass *klass)
 {
+	GObjectClass *object_class;
+
 	g_type_class_add_private(klass, sizeof(BluetoothClientPrivate));
 
 	G_OBJECT_CLASS(klass)->finalize = bluetooth_client_finalize;
@@ -924,6 +972,12 @@ static void bluetooth_client_class_init(
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
+++ test-client.c	1 Feb 2008 11:39:39 -0000
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

--=-vYQYAyggrWx3pMPyk6Gk
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--=-vYQYAyggrWx3pMPyk6Gk
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--=-vYQYAyggrWx3pMPyk6Gk--
