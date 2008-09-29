Return-Path: <cyrus@holtmann.org>
Subject: [PATCH] Use "Icon" and "Alias" properties
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-RNX4vdxtX2s+WOVO0itt"
Date: Mon, 29 Sep 2008 10:04:51 +0100
Message-Id: <1222679091.6509.0.camel@snoogens.fab.redhat.com>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-RNX4vdxtX2s+WOVO0itt
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Rather than doing it ouselves.

--=-RNX4vdxtX2s+WOVO0itt
Content-Disposition: attachment; filename="0001-Add-Alias-and-Icon-columns-to-the-Client.patch"
Content-Type: text/x-patch; name="0001-Add-Alias-and-Icon-columns-to-the-Client.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

>From 2fdc9f88921878ca803917d25bfa2c78c9febb71 Mon Sep 17 00:00:00 2001
From: Bastien Nocera <hadess@hadess.net>
Date: Thu, 25 Sep 2008 20:09:19 -0700
Subject: [PATCH] Add Alias and Icon columns to the Client

This will allow us to clean up the helper code in the UI
functions as bluetoothd already does most of the work for us.
---
 common/bluetooth-client.c |   31 +++++++++++++++++++++++++++----
 common/bluetooth-client.h |    2 ++
 2 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/common/bluetooth-client.c b/common/bluetooth-client.c
index 3ecb51c..21946c5 100644
--- a/common/bluetooth-client.c
+++ b/common/bluetooth-client.c
@@ -268,6 +268,16 @@ static void device_changed(DBusGProxy *device, const char *property,
 
 		gtk_tree_store_set(priv->store, &iter,
 					BLUETOOTH_COLUMN_NAME, name, -1);
+	} else if (g_str_equal(property, "Alias") == TRUE) {
+		const gchar *alias = g_value_get_string(value);
+
+		gtk_tree_store_set(priv->store, &iter,
+					BLUETOOTH_COLUMN_ALIAS, alias, -1);
+	} else if (g_str_equal(property, "Icon") == TRUE) {
+		const gchar *icon = g_value_get_string(value);
+
+		gtk_tree_store_set(priv->store, &iter,
+					BLUETOOTH_COLUMN_ICON, icon, -1);
 	} else if (g_str_equal(property, "Paired") == TRUE) {
 		gboolean paired = g_value_get_boolean(value);
 
@@ -293,7 +303,7 @@ static void add_device(DBusGProxy *adapter, GtkTreeIter *parent,
 	BluetoothClientPrivate *priv = BLUETOOTH_CLIENT_GET_PRIVATE(client);
 	DBusGProxy *device;
 	GValue *value;
-	const gchar *address, *name;
+	const gchar *address, *name, *icon, *alias;
 	gboolean paired, trusted, connected;
 	guint type;
 	gint rssi;
@@ -316,6 +326,9 @@ static void add_device(DBusGProxy *adapter, GtkTreeIter *parent,
 		value = g_hash_table_lookup(hash, "Name");
 		name = value ? g_value_get_string(value) : NULL;
 
+		value = g_hash_table_lookup(hash, "Alias");
+		alias = value ? g_value_get_string(value) : NULL;
+
 		value = g_hash_table_lookup(hash, "Class");
 		type = class_to_type(g_value_get_uint(value));
 
@@ -330,9 +343,14 @@ static void add_device(DBusGProxy *adapter, GtkTreeIter *parent,
 
 		value = g_hash_table_lookup(hash, "Connected");
 		connected = value ? g_value_get_boolean(value) : FALSE;
+
+		value = g_hash_table_lookup(hash, "Icon");
+		icon = value ? g_value_get_string(value) : "bluetooth";
 	} else {
 		address = NULL;
 		name = NULL;
+		alias = NULL;
+		icon = NULL;
 		type = BLUETOOTH_TYPE_ANY;
 		rssi = 0;
 		paired = FALSE;
@@ -353,7 +371,9 @@ static void add_device(DBusGProxy *adapter, GtkTreeIter *parent,
 			gtk_tree_store_set(priv->store, &iter,
 					BLUETOOTH_COLUMN_ADDRESS, address,
 					BLUETOOTH_COLUMN_NAME, name,
+					BLUETOOTH_COLUMN_ALIAS, alias,
 					BLUETOOTH_COLUMN_TYPE, type,
+					BLUETOOTH_COLUMN_ICON, icon,
 					BLUETOOTH_COLUMN_RSSI, rssi, -1);
 
 			if (device != NULL) {
@@ -374,7 +394,9 @@ static void add_device(DBusGProxy *adapter, GtkTreeIter *parent,
 				BLUETOOTH_COLUMN_PROXY, device,
 				BLUETOOTH_COLUMN_ADDRESS, address,
 				BLUETOOTH_COLUMN_NAME, name,
+				BLUETOOTH_COLUMN_ALIAS, alias,
 				BLUETOOTH_COLUMN_TYPE, type,
+				BLUETOOTH_COLUMN_ICON, icon,
 				BLUETOOTH_COLUMN_RSSI, rssi,
 				BLUETOOTH_COLUMN_PAIRED, paired,
 				BLUETOOTH_COLUMN_TRUSTED, trusted,
@@ -402,6 +424,7 @@ static void device_found(DBusGProxy *adapter, const char *address,
 
 	DBG("client %p address %s", client, address);
 
+	//FIXME what is the name actually used for here?
 	if (hash != NULL) {
 		value = g_hash_table_lookup(hash, "Name");
 		name = value ? g_value_get_string(value) : NULL;
@@ -649,9 +672,9 @@ static void bluetooth_client_init(BluetoothClient *client)
 	DBG("client %p", client);
 
 	priv->store = gtk_tree_store_new(_BLUETOOTH_NUM_COLUMNS, G_TYPE_OBJECT,
-			G_TYPE_STRING, G_TYPE_STRING, G_TYPE_UINT, G_TYPE_INT,
-			G_TYPE_BOOLEAN, G_TYPE_BOOLEAN, G_TYPE_BOOLEAN,
-					G_TYPE_BOOLEAN, G_TYPE_BOOLEAN);
+			G_TYPE_STRING, G_TYPE_STRING, G_TYPE_STRING, G_TYPE_STRING,
+			G_TYPE_UINT, G_TYPE_INT, G_TYPE_BOOLEAN, G_TYPE_BOOLEAN,
+			G_TYPE_BOOLEAN, G_TYPE_BOOLEAN, G_TYPE_BOOLEAN);
 
 	priv->dbus = dbus_g_proxy_new_for_name(connection, DBUS_SERVICE_DBUS,
 				DBUS_PATH_DBUS, DBUS_INTERFACE_DBUS);
diff --git a/common/bluetooth-client.h b/common/bluetooth-client.h
index f95745c..2e1e901 100644
--- a/common/bluetooth-client.h
+++ b/common/bluetooth-client.h
@@ -89,6 +89,8 @@ enum {
 	BLUETOOTH_COLUMN_PROXY,
 	BLUETOOTH_COLUMN_ADDRESS,
 	BLUETOOTH_COLUMN_NAME,
+	BLUETOOTH_COLUMN_ALIAS,
+	BLUETOOTH_COLUMN_ICON,
 	BLUETOOTH_COLUMN_TYPE,
 	BLUETOOTH_COLUMN_RSSI,
 	BLUETOOTH_COLUMN_DEFAULT,
-- 
1.6.0.1


--=-RNX4vdxtX2s+WOVO0itt
Content-Disposition: attachment; filename="0002-Remove-use-of-type_to_icon.patch"
Content-Type: text/x-patch; name="0002-Remove-use-of-type_to_icon.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

>From e93f7c579707ccbb4918f2590bfdc2d774c906ba Mon Sep 17 00:00:00 2001
From: Bastien Nocera <hadess@hadess.net>
Date: Thu, 25 Sep 2008 20:13:18 -0700
Subject: [PATCH] Remove use of type_to_icon()

Given to use directly in the BLUETOOTH_COLUMN_ICON now
---
 common/helper.c |   48 ++----------------------------------------------
 1 files changed, 2 insertions(+), 46 deletions(-)

diff --git a/common/helper.c b/common/helper.c
index 5191c1a..292957c 100644
--- a/common/helper.c
+++ b/common/helper.c
@@ -30,50 +30,6 @@
 
 #include <bluetooth-client.h>
 
-static void type_to_icon(GtkTreeViewColumn *column, GtkCellRenderer *cell,
-			GtkTreeModel *model, GtkTreeIter *iter, gpointer data)
-{
-	guint type;
-
-	gtk_tree_model_get(model, iter, BLUETOOTH_COLUMN_TYPE, &type, -1);
-
-	switch (type) {
-	case BLUETOOTH_TYPE_PHONE:
-		g_object_set(cell, "icon-name", "phone", NULL);
-		break;
-	case BLUETOOTH_TYPE_MODEM:
-		g_object_set(cell, "icon-name", "modem", NULL);
-		break;
-	case BLUETOOTH_TYPE_COMPUTER:
-		g_object_set(cell, "icon-name", "computer", NULL);
-		break;
-	case BLUETOOTH_TYPE_NETWORK:
-		g_object_set(cell, "icon-name", "network-wireless", NULL);
-		break;
-	case BLUETOOTH_TYPE_HEADSET:
-		g_object_set(cell, "icon-name", "stock_headphones", NULL);
-		break;
-	case BLUETOOTH_TYPE_HEADPHONE:
-		g_object_set(cell, "icon-name", "stock_headphones", NULL);
-		break;
-	case BLUETOOTH_TYPE_KEYBOARD:
-		g_object_set(cell, "icon-name", "input-keyboard", NULL);
-		break;
-	case BLUETOOTH_TYPE_MOUSE:
-		g_object_set(cell, "icon-name", "input-mouse", NULL);
-		break;
-	case BLUETOOTH_TYPE_CAMERA:
-		g_object_set(cell, "icon-name", "camera-photo", NULL);
-		break;
-	case BLUETOOTH_TYPE_PRINTER:
-		g_object_set(cell, "icon-name", "printer", NULL);
-		break;
-	default:
-		g_object_set(cell, "icon-name", "bluetooth", NULL);
-		break;
-	}
-}
-
 static void name_to_text(GtkTreeViewColumn *column, GtkCellRenderer *cell,
 			GtkTreeModel *model, GtkTreeIter *iter, gpointer data)
 {
@@ -155,8 +111,8 @@ GtkWidget *create_tree(GtkTreeModel *model, gboolean icons)
 		renderer = gtk_cell_renderer_pixbuf_new();
 		gtk_tree_view_column_set_spacing(column, 4);
 		gtk_tree_view_column_pack_start(column, renderer, FALSE);
-		gtk_tree_view_column_set_cell_data_func(column, renderer,
-						type_to_icon, NULL, NULL);
+		gtk_tree_view_column_add_attribute(column, renderer,
+						   "icon-name", BLUETOOTH_COLUMN_ICON);
 	}
 
 	renderer = gtk_cell_renderer_text_new();
-- 
1.6.0.1


--=-RNX4vdxtX2s+WOVO0itt
Content-Disposition: attachment; filename="0003-Remove-use-of-name_to_text.patch"
Content-Type: text/x-patch; name="0003-Remove-use-of-name_to_text.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

>From dfc323f48817602d721afb7b9851766f803ce5e8 Mon Sep 17 00:00:00 2001
From: Bastien Nocera <hadess@hadess.net>
Date: Thu, 25 Sep 2008 20:15:29 -0700
Subject: [PATCH] Remove use of name_to_text()

We use BLUETOOTH_COLUMN_ALIAS now
---
 common/helper.c |   23 ++---------------------
 1 files changed, 2 insertions(+), 21 deletions(-)

diff --git a/common/helper.c b/common/helper.c
index 292957c..fe5f95e 100644
--- a/common/helper.c
+++ b/common/helper.c
@@ -30,25 +30,6 @@
 
 #include <bluetooth-client.h>
 
-static void name_to_text(GtkTreeViewColumn *column, GtkCellRenderer *cell,
-			GtkTreeModel *model, GtkTreeIter *iter, gpointer data)
-{
-	gchar *address, *name;
-
-	gtk_tree_model_get(model, iter, BLUETOOTH_COLUMN_ADDRESS, &address,
-						BLUETOOTH_COLUMN_NAME, &name, -1);
-
-	if (name == NULL) {
-		name = g_strdup(address);
-		g_strdelimit(name, ":", '-');
-	}
-
-	g_object_set(cell, "text", name ? name : address, NULL);
-
-	g_free(name);
-	g_free(address);
-}
-
 static void connected_to_icon(GtkTreeViewColumn *column, GtkCellRenderer *cell,
 			GtkTreeModel *model, GtkTreeIter *iter, gpointer data)
 {
@@ -117,8 +98,8 @@ GtkWidget *create_tree(GtkTreeModel *model, gboolean icons)
 
 	renderer = gtk_cell_renderer_text_new();
 	gtk_tree_view_column_pack_start(column, renderer, TRUE);
-	gtk_tree_view_column_set_cell_data_func(column, renderer,
-						name_to_text, NULL, NULL);
+	gtk_tree_view_column_add_attribute(column, renderer,
+					   "text", BLUETOOTH_COLUMN_ALIAS);
 
 	gtk_tree_view_insert_column_with_data_func(GTK_TREE_VIEW(tree), -1,
 				"Connected", gtk_cell_renderer_pixbuf_new(),
-- 
1.6.0.1


--=-RNX4vdxtX2s+WOVO0itt--

