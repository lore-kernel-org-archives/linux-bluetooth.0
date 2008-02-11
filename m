Return-Path: <cyrus@holtmann.org>
From: Bastien Nocera <hadess@hadess.net>
To: BlueZ Hackers <bluez-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="=-Eqnw5HzFON9cfCZeYf0Q"
Date: Mon, 11 Feb 2008 17:30:11 +0000
Message-Id: <1202751011.3491.165.camel@cookie.hadess.net>
Mime-Version: 1.0
Subject: [Bluez-devel] [PATCH] Make search button (and discovery) work
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


--=-Eqnw5HzFON9cfCZeYf0Q
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Heya,

Seems that some bits of client.c got mistakenly commented. The #endif
should be before the call to DiscoverDevices, not after.

So I fixed this up and finished the work to make the search button
behave as expected. I guess we should have it by default now.

Cheers

PS: BZ http://bugzilla.gnome.org/show_bug.cgi?id=515784

--=-Eqnw5HzFON9cfCZeYf0Q
Content-Disposition: attachment;
	filename=bluez-gnome-make-search-button-work.patch
Content-Type: text/x-patch; name=bluez-gnome-make-search-button-work.patch;
	charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Index: bluetooth-device-selection.c
===================================================================
RCS file: /cvsroot/bluez/gnome/common/bluetooth-device-selection.c,v
retrieving revision 1.14
diff -u -p -u -p -r1.14 bluetooth-device-selection.c
--- bluetooth-device-selection.c	10 Feb 2008 17:46:51 -0000	1.14
+++ bluetooth-device-selection.c	11 Feb 2008 17:19:34 -0000
@@ -172,7 +172,7 @@ type_to_text (GtkTreeViewColumn *column,
 	guint type;
 
 	gtk_tree_model_get (model, iter, COLUMN_TYPE, &type, -1);
-	if (type == BLUETOOTH_TYPE_ANY)
+	if (type == 0)
 		g_object_set (cell, "text", _("Unknown"), NULL);
 	else
 		g_object_set (cell, "text", bluetooth_type_to_string (type), NULL);
@@ -211,16 +211,24 @@ search_button_clicked (GtkButton *button
 	bluetooth_device_selection_start_discovery (self);
 }
 
-#if 0
 static void
-discoveries_completed (BluetoothClient *client, gpointer user_data)
+discovery_started (BluetoothClient *client, const char *adapter_path, gboolean is_default, gpointer user_data)
 {
 	BluetoothDeviceSelection *self = BLUETOOTH_DEVICE_SELECTION(user_data);
 	BluetoothDeviceSelectionPrivate *priv = BLUETOOTH_DEVICE_SELECTION_GET_PRIVATE(self);
 
-	gtk_widget_set_sensitive (GTK_WIDGET(priv->search_button), TRUE);
+	if (is_default)
+		gtk_widget_set_sensitive (GTK_WIDGET(priv->search_button), FALSE);
+}
+static void
+discovery_completed (BluetoothClient *client, const char *adapter_path, gboolean is_default, gpointer user_data)
+{
+	BluetoothDeviceSelection *self = BLUETOOTH_DEVICE_SELECTION(user_data);
+	BluetoothDeviceSelectionPrivate *priv = BLUETOOTH_DEVICE_SELECTION_GET_PRIVATE(self);
+
+	if (is_default)
+		gtk_widget_set_sensitive (GTK_WIDGET(priv->search_button), TRUE);
 }
-#endif
 
 static void
 select_browse_device_callback (GtkTreeSelection *selection, gpointer user_data)
@@ -245,7 +253,7 @@ filter_type_func (GtkTreeModel *model, G
 		return TRUE;
 
 	gtk_tree_model_get (model, iter, COLUMN_TYPE, &type, -1);
-	return (type == priv->device_type_filter);
+	return (type & priv->device_type_filter);
 }
 
 static gboolean
@@ -285,7 +293,7 @@ filter_type_changed_cb (GtkComboBox *wid
 	BluetoothDeviceSelection *self = BLUETOOTH_DEVICE_SELECTION (data);
 	BluetoothDeviceSelectionPrivate *priv = BLUETOOTH_DEVICE_SELECTION_GET_PRIVATE(self);
 
-	priv->device_type_filter = gtk_combo_box_get_active (GTK_COMBO_BOX(priv->device_type));
+	priv->device_type_filter = 1 << gtk_combo_box_get_active (GTK_COMBO_BOX(priv->device_type));
 	if (priv->filter)
 		gtk_tree_model_filter_refilter (GTK_TREE_MODEL_FILTER (priv->filter));
 	g_object_notify (G_OBJECT(self), "device-type-filter");
@@ -441,10 +449,10 @@ bluetooth_device_selection_init(Bluetoot
 
 	priv->client = bluetooth_client_new ();
 
-#if 0
-	g_signal_connect (G_OBJECT(priv->client), "discoveries-completed",
-			  G_CALLBACK(discoveries_completed), self);
-#endif
+	g_signal_connect (G_OBJECT(priv->client), "discovery-started",
+			  G_CALLBACK(discovery_started), self);
+	g_signal_connect (G_OBJECT(priv->client), "discovery-completed",
+			  G_CALLBACK(discovery_completed), self);
 
 	tooltips = gtk_tooltips_new ();
 
@@ -567,7 +575,7 @@ bluetooth_device_selection_init(Bluetoot
 	/* The types match the types used in client.h */
 	for (i = 0; i < BLUETOOTH_TYPE_NUM_TYPES; i++) {
 		gtk_combo_box_append_text (GTK_COMBO_BOX(priv->device_type),
-					   _(bluetooth_type_to_string (i)));
+					   _(bluetooth_type_to_string (1 << i)));
 	}
 	g_signal_connect (G_OBJECT (priv->device_type), "changed",
 			  G_CALLBACK(filter_type_changed_cb), self);
@@ -579,8 +587,6 @@ bluetooth_device_selection_init(Bluetoot
 
 	g_signal_connect (priv->client, "notify::default-adapter",
 			  G_CALLBACK (default_adapter_changed), self);
-
-	bluetooth_device_selection_start_discovery (self);
 }
 
 static void
Index: client.c
===================================================================
RCS file: /cvsroot/bluez/gnome/common/client.c,v
retrieving revision 1.40
diff -u -p -u -p -r1.40 client.c
--- client.c	2 Feb 2008 04:09:39 -0000	1.40
+++ client.c	11 Feb 2008 17:19:34 -0000
@@ -52,7 +52,8 @@ struct _BluetoothClientPrivate {
 };
 
 enum {
-	DISCOVERIES_COMPLETED,
+	DISCOVERY_STARTED,
+	DISCOVERY_COMPLETED,
 	LAST_SIGNAL
 };
 
@@ -264,7 +265,8 @@ static void insert_device(DBusGProxy *ob
 						COLUMN_TYPE, type,
 						COLUMN_BONDED, bonded,
 						COLUMN_TRUSTED, trusted,
-						COLUMN_CONNECTED, connected, -1);
+						COLUMN_CONNECTED, connected,
+						COLUMN_DISCOVERING, FALSE, -1);
 			return;
 		}
 
@@ -280,7 +282,8 @@ static void insert_device(DBusGProxy *ob
 					COLUMN_TYPE, type,
 					COLUMN_BONDED, bonded,
 					COLUMN_TRUSTED, trusted,
-					COLUMN_CONNECTED, connected, -1);
+					COLUMN_CONNECTED, connected,
+					COLUMN_DISCOVERING, FALSE, -1);
 }
 
 static void invalidate_device(DBusGProxy *object,
@@ -624,6 +627,55 @@ static void mode_changed(DBusGProxy *obj
 	}
 }
 
+static void discovery_event(DBusGProxy *object,
+			    BluetoothClient *client,
+			    gboolean starting)
+{
+	BluetoothClientPrivate *priv = BLUETOOTH_CLIENT_GET_PRIVATE(client);
+	GtkTreeIter iter;
+	char *adapter;
+	gboolean is_default;
+
+	if (find_iter_for_object(object, BLUETOOTH_CLIENT(client), &iter) == FALSE)
+		return;
+
+	gtk_tree_store_set(priv->store, &iter, COLUMN_DISCOVERING, starting, -1);
+	g_message ("set the device disco to %d", starting);
+
+	/* Find out whether we're checking the default adapter */
+	is_default = FALSE;
+	gtk_tree_model_get (GTK_TREE_MODEL (priv->store), &iter, COLUMN_PATH, &adapter, -1);
+	if (priv->default_adapter != NULL) {
+		if (g_str_equal (priv->default_adapter, adapter) != FALSE)
+			is_default = TRUE;
+	}
+
+	if (starting)
+		g_signal_emit(G_OBJECT(client), client_table_signals[DISCOVERY_STARTED],
+			      0, adapter, is_default);
+	else
+		g_signal_emit(G_OBJECT(client), client_table_signals[DISCOVERY_COMPLETED],
+			      0, adapter, is_default);
+	g_message ("discovery_%s %s %d", starting ? "started" : "completed", adapter, is_default);
+	g_free (adapter);
+}
+
+static void discovery_completed(DBusGProxy *object,
+				gpointer user_data)
+{
+	BluetoothClient *client = BLUETOOTH_CLIENT(user_data);
+
+	discovery_event (object, client, FALSE);
+}
+
+static void discovery_started(DBusGProxy *object,
+			      gpointer user_data)
+{
+	BluetoothClient *client = BLUETOOTH_CLIENT(user_data);
+
+	discovery_event (object, client, TRUE);
+}
+
 static void add_adapter(const char *path, BluetoothClient *client)
 {
 	BluetoothClientPrivate *priv = BLUETOOTH_CLIENT_GET_PRIVATE(client);
@@ -741,8 +793,16 @@ static void add_adapter(const char *path
 	dbus_g_proxy_connect_signal(object, "TrustRemoved",
 				G_CALLBACK(trust_removed), client, NULL);
 
+	dbus_g_proxy_add_signal(object, "DiscoveryStarted", G_TYPE_INVALID);
+
+	dbus_g_proxy_connect_signal(object, "DiscoveryStarted",
+				G_CALLBACK(discovery_started), client, NULL);
+
 	dbus_g_proxy_add_signal(object, "DiscoveryCompleted", G_TYPE_INVALID);
 
+	dbus_g_proxy_connect_signal(object, "DiscoveryCompleted",
+				G_CALLBACK(discovery_completed), client, NULL);
+
 	update_adapter(object, &iter, client);
 }
 
@@ -810,18 +870,6 @@ static void default_adapter_changed(DBus
 	g_object_notify (G_OBJECT (client), "default-adapter");
 }
 
-#if 0
-static void discovery_completed(DBusGProxy *object,
-				gpointer user_data)
-{
-	BluetoothClient *client = BLUETOOTH_CLIENT(user_data);
-
-	g_signal_emit(G_OBJECT(client), client_table_signals[DISCOVERIES_COMPLETED], 0);
-
-	g_message ("discovery_completed");
-}
-#endif
-
 static void setup_manager(BluetoothClient *client)
 {
 	BluetoothClientPrivate *priv = BLUETOOTH_CLIENT_GET_PRIVATE(client);
@@ -913,10 +961,10 @@ static void bluetooth_client_init(Blueto
 
 	priv->registered = FALSE;
 
-	priv->store = gtk_tree_store_new(11, G_TYPE_STRING, G_TYPE_BOOLEAN,
+	priv->store = gtk_tree_store_new(NUM_COLS, G_TYPE_STRING, G_TYPE_BOOLEAN,
 			G_TYPE_OBJECT, G_TYPE_STRING, G_TYPE_UINT,
 			G_TYPE_INT, G_TYPE_STRING, G_TYPE_UINT,
-			G_TYPE_BOOLEAN, G_TYPE_BOOLEAN, G_TYPE_BOOLEAN);
+			G_TYPE_BOOLEAN, G_TYPE_BOOLEAN, G_TYPE_BOOLEAN, G_TYPE_BOOLEAN);
 
 	setup_dbus(client);
 
@@ -961,15 +1009,25 @@ static void bluetooth_client_class_init(
 	G_OBJECT_CLASS(klass)->set_property = bluetooth_client_set_property;
 	G_OBJECT_CLASS(klass)->get_property = bluetooth_client_get_property;
 
-	client_table_signals[DISCOVERIES_COMPLETED] =
-		g_signal_new ("discoveries-completed",
+	client_table_signals[DISCOVERY_STARTED] =
+		g_signal_new ("discovery-started",
+				G_TYPE_FROM_CLASS (klass),
+				G_SIGNAL_RUN_LAST,
+				G_STRUCT_OFFSET (BluetoothClientClass,
+							discovery_started),
+				NULL, NULL,
+				marshal_VOID__STRING_BOOLEAN,
+				G_TYPE_NONE, 2, G_TYPE_STRING, G_TYPE_BOOLEAN);
+
+	client_table_signals[DISCOVERY_COMPLETED] =
+		g_signal_new ("discovery-completed",
 				G_TYPE_FROM_CLASS (klass),
 				G_SIGNAL_RUN_LAST,
 				G_STRUCT_OFFSET (BluetoothClientClass,
-							discoveries_completed),
+							discovery_completed),
 				NULL, NULL,
-				g_cclosure_marshal_VOID__VOID,
-				G_TYPE_NONE, 0, G_TYPE_NONE);
+				marshal_VOID__STRING_BOOLEAN,
+				G_TYPE_NONE, 2, G_TYPE_STRING, G_TYPE_BOOLEAN);
 
 	object_class = (GObjectClass *) klass;
 
@@ -1248,20 +1306,12 @@ gboolean bluetooth_client_discover_devic
 
 		gtk_tree_model_get(GTK_TREE_MODEL(priv->store), &iter,
 						COLUMN_PATH, &path,
-						COLUMN_OBJECT, &object, -1);
+						COLUMN_OBJECT, &object,
+						-1);
 
 		if (g_ascii_strcasecmp(path, adapter) == 0) {
-#if 0
-			/* Disconnect any lingering signals, to avoid the callback
-			 * being called twice */
-			dbus_g_proxy_disconnect_signal(object, "DiscoveryCompleted",
-					G_CALLBACK(discovery_completed), client);
-			dbus_g_proxy_connect_signal(object, "DiscoveryCompleted",
-				G_CALLBACK(discovery_completed), client, NULL);
-
 			dbus_g_proxy_call(object, "DiscoverDevices",
 							NULL, G_TYPE_INVALID);
-#endif
 			return TRUE;
 		}
 
Index: client.h
===================================================================
RCS file: /cvsroot/bluez/gnome/common/client.h,v
retrieving revision 1.22
diff -u -p -u -p -r1.22 client.h
--- client.h	2 Feb 2008 04:09:39 -0000	1.22
+++ client.h	11 Feb 2008 17:19:34 -0000
@@ -52,7 +52,8 @@ struct _BluetoothClient {
 struct _BluetoothClientClass {
 	GObjectClass parent_class;
 
-	void (*discoveries_completed) (BluetoothClient *self);
+	void (*discovery_started) (BluetoothClient *self, const char *adapter_path, gboolean is_default);
+	void (*discovery_completed) (BluetoothClient *self, const char *adapter_path, gboolean is_default);
 };
 
 GType bluetooth_client_get_type(void);
@@ -71,22 +72,26 @@ enum {
 	COLUMN_BONDED,
 	COLUMN_TRUSTED,
 	COLUMN_CONNECTED,
+	COLUMN_DISCOVERING,
+	NUM_COLS
 };
 
 enum {
-	BLUETOOTH_TYPE_ANY,
-	BLUETOOTH_TYPE_PHONE,
-	BLUETOOTH_TYPE_MODEM,
-	BLUETOOTH_TYPE_COMPUTER,
-	BLUETOOTH_TYPE_NETWORK,
-	BLUETOOTH_TYPE_HEADSET,
-	BLUETOOTH_TYPE_KEYBOARD,
-	BLUETOOTH_TYPE_MOUSE,
-	BLUETOOTH_TYPE_CAMERA,
-	BLUETOOTH_TYPE_PRINTER,
-	BLUETOOTH_TYPE_NUM_TYPES
+	BLUETOOTH_TYPE_ANY        = 1,
+	BLUETOOTH_TYPE_PHONE      = 1 << 1,
+	BLUETOOTH_TYPE_MODEM      = 1 << 2,
+	BLUETOOTH_TYPE_COMPUTER   = 1 << 3,
+	BLUETOOTH_TYPE_NETWORK    = 1 << 4,
+	BLUETOOTH_TYPE_HEADSET    = 1 << 5,
+	BLUETOOTH_TYPE_KEYBOARD   = 1 << 6,
+	BLUETOOTH_TYPE_MOUSE      = 1 << 7,
+	BLUETOOTH_TYPE_CAMERA     = 1 << 8,
+	BLUETOOTH_TYPE_PRINTER    = 1 << 9 
 };
 
+#define BLUETOOTH_TYPE_NUM_TYPES 10
+#define BLUETOOTH_TYPE_INPUT (BLUETOOTH_TYPE_KEYBOARD | BLUETOOTH_TYPE_MOUSE)
+
 const gchar *bluetooth_type_to_string(guint type);
 
 gboolean bluetooth_client_register_passkey_agent(BluetoothClient *self,
Index: marshal.list
===================================================================
RCS file: /cvsroot/bluez/gnome/common/marshal.list,v
retrieving revision 1.3
diff -u -p -u -p -r1.3 marshal.list
--- marshal.list	6 Feb 2008 23:59:27 -0000	1.3
+++ marshal.list	11 Feb 2008 17:19:34 -0000
@@ -1,4 +1,5 @@
 VOID:STRING,UINT,INT
 VOID:STRING,STRING
+VOID:STRING,BOOLEAN
 VOID:STRING,STRING,UINT64
 VOID:UINT64

--=-Eqnw5HzFON9cfCZeYf0Q
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--=-Eqnw5HzFON9cfCZeYf0Q
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--=-Eqnw5HzFON9cfCZeYf0Q--
