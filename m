Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Bastien Nocera <hadess@hadess.net>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1194365925.15726.19.camel@cookie.hadess.net>
References: <1194365925.15726.19.camel@cookie.hadess.net>
Content-Type: multipart/mixed; boundary="=-bcFlYm+3E8WBOH/f4/Nb"
Date: Tue, 06 Nov 2007 18:47:52 +0000
Message-Id: <1194374872.15726.32.camel@cookie.hadess.net>
Mime-Version: 1.0
Subject: [Bluez-devel] Add filters to device selection (was Re:
	[PATCH]	allow the chooser widget to show search as an afterthought)
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


--=-bcFlYm+3E8WBOH/f4/Nb
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

A bigger updated patch,

On Tue, 2007-11-06 at 16:18 +0000, Bastien Nocera wrote:
> Heya,
> 
> The current device selection widget doesn't allow to show the search
> button after the widget has been created, which is a bit of a pain.
> 
> The attached patch shows the search button by default in the test
> application and fixes the above problem.

The attached patch adds 2 (optional) drop-downs to show only devices
matching a certain filter.

- Add properties about whether to show the category filter, and the
device filter, and whether to show/hide those selections
- Make bluetooth_type_to_string return const (as they are const) and
mark those strings for translations
- Add a category enum to bluetooth-device-selection.h
- Add the ability to pass NULL to bluetooth_client_get_model_with_filter
(to get a list of known devices on the default adapter, but without
hiding the bonded, and otherwise not discovered yet devices)

So, the TODO list looks like:
- make the drop-downs look better
- convenience functions to change the filters programmatically (eg.
gnome-phone-manager would default to showing phones)
- add more category filters (would require client.[ch] changes), such as
"Recent devices", and "Discovered devices".

Cheers

--=-bcFlYm+3E8WBOH/f4/Nb
Content-Disposition: attachment;
	filename=bluez-gnome-device-selection-add-filters.patch
Content-Type: text/x-patch; name=bluez-gnome-device-selection-add-filters.patch;
	charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Index: common/bluetooth-device-selection.c
===================================================================
RCS file: /cvsroot/bluez/gnome/common/bluetooth-device-selection.c,v
retrieving revision 1.9
diff -u -p -r1.9 bluetooth-device-selection.c
--- common/bluetooth-device-selection.c	9 Aug 2007 08:35:19 -0000	1.9
+++ common/bluetooth-device-selection.c	6 Nov 2007 18:38:02 -0000
@@ -49,19 +49,42 @@ typedef struct _BluetoothDeviceSelection
 struct _BluetoothDeviceSelectionPrivate {
 	BluetoothClient *client;
 	GtkTreeSelection *selection;
-	GtkTreeModel *model;
+	GtkTreeModel *model, *filter;
 	GtkWidget *label;
 
 	/* Widgets/UI bits that can be shown or hidden */
 	GtkCellRenderer *bonded_cell;
 	GtkWidget *search_button;
+	GtkWidget *device_type_label, *device_type;
+	GtkWidget *device_category_label, *device_category;
+
+	/* Current filter */
+	int device_type_filter;
+	int device_category_filter;
 
 	guint show_bonded : 1;
 	guint show_search : 1;
+	guint show_device_type : 1;
+	guint show_device_category : 1;
 };
 
 G_DEFINE_TYPE(BluetoothDeviceSelection, bluetooth_device_selection, GTK_TYPE_VBOX)
 
+static const char *
+bluetooth_device_category_to_string (int type)
+{
+	switch (type) {
+	case BLUETOOTH_CATEGORY_ALL:
+		return N_("All categories");
+	case BLUETOOTH_CATEGORY_BONDED:
+		return N_("Bonded");
+	case BLUETOOTH_CATEGORY_TRUSTED:
+		return N_("Trusted");
+	default:
+		return N_("Unknown");
+	}
+}
+
 static void
 name_to_text (GtkTreeViewColumn *column, GtkCellRenderer *cell,
 	      GtkTreeModel *model, GtkTreeIter *iter, gpointer data)
@@ -173,7 +196,7 @@ bluetooth_device_selection_get_selected_
 	if (selected == FALSE)
 		return NULL;
 
-	gtk_tree_model_get (priv->model, &iter, COLUMN_ADDRESS, &address, -1);
+	gtk_tree_model_get (priv->filter, &iter, COLUMN_ADDRESS, &address, -1);
 	return address;
 }
 
@@ -210,13 +233,78 @@ select_browse_device_callback (GtkTreeSe
 	g_free (address);
 }
 
+static gboolean
+filter_type_func (GtkTreeModel *model, GtkTreeIter *iter, BluetoothDeviceSelectionPrivate *priv)
+{
+	int type;
+
+	if (priv->device_type_filter == BLUETOOTH_TYPE_ANY)
+		return TRUE;
+
+	gtk_tree_model_get (model, iter, COLUMN_TYPE, &type, -1);
+	return (type == priv->device_type_filter);
+}
+
+static gboolean
+filter_category_func (GtkTreeModel *model, GtkTreeIter *iter, BluetoothDeviceSelectionPrivate *priv)
+{
+	if (priv->device_category_filter == BLUETOOTH_CATEGORY_ALL)
+		return TRUE;
+
+	if (priv->device_category_filter == BLUETOOTH_CATEGORY_BONDED) {
+		gboolean bonded;
+
+		gtk_tree_model_get (model, iter, COLUMN_BONDED, &bonded, -1);
+		return bonded;
+	}
+	if (priv->device_category_filter == BLUETOOTH_CATEGORY_TRUSTED) {
+		gboolean trusted;
+
+		gtk_tree_model_get (model, iter, COLUMN_TRUSTED, &trusted, -1);
+		return trusted;
+	}
+
+	return FALSE;
+}
+
+static gboolean
+filter_func (GtkTreeModel *model, GtkTreeIter *iter, gpointer data)
+{
+	BluetoothDeviceSelection *self = BLUETOOTH_DEVICE_SELECTION (data);
+	BluetoothDeviceSelectionPrivate *priv = BLUETOOTH_DEVICE_SELECTION_GET_PRIVATE(self);
+
+	return filter_type_func (model, iter, priv) && filter_category_func (model, iter, priv);
+}
+
+static void
+filter_type_changed_cb (GtkComboBox *widget, gpointer data)
+{
+	BluetoothDeviceSelection *self = BLUETOOTH_DEVICE_SELECTION (data);
+	BluetoothDeviceSelectionPrivate *priv = BLUETOOTH_DEVICE_SELECTION_GET_PRIVATE(self);
+
+	priv->device_type_filter = gtk_combo_box_get_active (GTK_COMBO_BOX(priv->device_type));
+	gtk_tree_model_filter_refilter (GTK_TREE_MODEL_FILTER (priv->filter));
+	g_object_notify (G_OBJECT(self), "device-type-filter");
+}
+static void
+filter_category_changed_cb (GtkComboBox *widget, gpointer data)
+{
+	BluetoothDeviceSelection *self = BLUETOOTH_DEVICE_SELECTION (data);
+	BluetoothDeviceSelectionPrivate *priv = BLUETOOTH_DEVICE_SELECTION_GET_PRIVATE(self);
+
+	priv->device_category_filter = gtk_combo_box_get_active (GTK_COMBO_BOX(priv->device_category));
+	gtk_tree_model_filter_refilter (GTK_TREE_MODEL_FILTER (priv->filter));
+	g_object_notify (G_OBJECT(self), "device-category-filter");
+}
+
 static void
 bluetooth_device_selection_init(BluetoothDeviceSelection *self)
 {
 	BluetoothDeviceSelectionPrivate *priv = BLUETOOTH_DEVICE_SELECTION_GET_PRIVATE(self);
-	GtkWidget *tree, *scrolled, *frame, *box, *hbox;
+	GtkWidget *tree, *scrolled, *frame, *box, *hbox, *table;
 	GtkCellRenderer *renderer;
 	GtkTreeViewColumn *column;
+	int i;
 
 	priv->show_bonded = FALSE;
 	priv->show_search = FALSE;
@@ -299,25 +387,78 @@ bluetooth_device_selection_init(Bluetoot
 	g_signal_connect (G_OBJECT(priv->selection), "changed",
 			  G_CALLBACK(select_browse_device_callback), self);
 
-	priv->model = bluetooth_client_get_model_for_adapter (priv->client, NULL);
+	/* Set the model, and filter */
+	priv->model = bluetooth_client_get_model_with_filter (priv->client, NULL, NULL, NULL);
+	priv->filter = gtk_tree_model_filter_new (priv->model, NULL);
+	gtk_tree_model_filter_set_visible_func (GTK_TREE_MODEL_FILTER (priv->filter),
+						filter_func, self, NULL);
 	if (priv->model) {
-		gtk_tree_view_set_model (GTK_TREE_VIEW(tree), priv->model);
-		g_object_unref (priv->model);
+		gtk_tree_view_set_model (GTK_TREE_VIEW(tree), priv->filter);
+		g_object_unref (priv->filter);
 	}
 
 	gtk_container_add (GTK_CONTAINER(scrolled), tree);
 	gtk_box_pack_start (GTK_BOX(box), scrolled, TRUE, TRUE, 6);
 
+	/* Setup the device filter widgets */
+	table = gtk_table_new (2, 2, TRUE);
+	gtk_box_pack_start (GTK_BOX(box), table, FALSE, FALSE, 0);
+
+	priv->device_type_label = gtk_label_new_with_mnemonic (_("Device _type:"));
+	gtk_label_set_justify (GTK_LABEL(priv->device_type_label), GTK_JUSTIFY_RIGHT);
+	priv->device_type = gtk_combo_box_new_text ();
+	/* The types match the types used in client.h */
+	for (i = 0; i < BLUETOOTH_TYPE_NUM_TYPES; i++) {
+		gtk_combo_box_append_text (GTK_COMBO_BOX(priv->device_type),
+					   _(bluetooth_type_to_string (i)));
+	}
+	g_signal_connect (G_OBJECT (priv->device_type), "changed",
+			  G_CALLBACK(filter_type_changed_cb), self);
+	gtk_combo_box_set_active (GTK_COMBO_BOX(priv->device_type), priv->device_type_filter);
+	gtk_table_attach (GTK_TABLE (table), GTK_WIDGET (priv->device_type_label),
+				   0, 1, 0, 1,
+				   GTK_FILL | GTK_EXPAND, 0, 0, 0);
+	gtk_table_attach (GTK_TABLE (table), GTK_WIDGET (priv->device_type),
+				   1, 2, 0, 1,
+				   GTK_FILL | GTK_EXPAND, 0, 0, 0);
+	if (priv->show_device_type) {
+		gtk_widget_show (priv->device_type_label);
+		gtk_widget_show (priv->device_type);
+	}
+
+	priv->device_category_label = gtk_label_new_with_mnemonic (_("Device _category:"));
+	gtk_label_set_justify (GTK_LABEL(priv->device_category_label), GTK_JUSTIFY_RIGHT);
+	priv->device_category = gtk_combo_box_new_text ();
+	for (i = 0; i < BLUETOOTH_CATEGORY_NUM_CATEGORIES; i++) {
+		gtk_combo_box_append_text (GTK_COMBO_BOX(priv->device_category),
+					   _(bluetooth_device_category_to_string (i)));
+	}
+	g_signal_connect (G_OBJECT (priv->device_category), "changed",
+			  G_CALLBACK(filter_category_changed_cb), self);
+	gtk_combo_box_set_active (GTK_COMBO_BOX(priv->device_category), priv->device_category_filter);
+	gtk_table_attach (GTK_TABLE (table), GTK_WIDGET (priv->device_category_label),
+				   0, 1, 1, 2,
+				   GTK_FILL | GTK_EXPAND, 0, 0, 0);
+	gtk_table_attach (GTK_TABLE (table), GTK_WIDGET (priv->device_category),
+				   1, 2, 1, 2,
+				   GTK_FILL | GTK_EXPAND, 0, 0, 0);
+	if (priv->show_device_category) {
+		gtk_widget_show (priv->device_category_label);
+		gtk_widget_show (priv->device_category);
+	}
+
+	/* Setup the search button */
 	hbox = gtk_hbox_new (FALSE, 0);
 	priv->search_button = gtk_button_new_with_label (_("Search"));
 	g_signal_connect (G_OBJECT(priv->search_button), "clicked",
 			  G_CALLBACK(search_button_clicked), self);
 	gtk_box_pack_start (GTK_BOX(box), hbox, FALSE, FALSE, 0);
-	if (priv->show_search == TRUE)
-		gtk_box_pack_start (GTK_BOX(hbox), priv->search_button,
-				    FALSE, FALSE, 0);
+	gtk_widget_show_all (GTK_WIDGET (self));
 
-	gtk_widget_show_all (scrolled);
+	gtk_box_pack_start (GTK_BOX(hbox), priv->search_button,
+			    FALSE, FALSE, 0);
+	if (priv->show_search)
+		gtk_widget_show (priv->search_button);
 
 	bluetooth_device_selection_start_discovery (self);
 }
@@ -335,7 +476,11 @@ enum {
 	PROP_TITLE,
 	PROP_DEVICE_SELECTED,
 	PROP_SHOW_BONDING,
-	PROP_SHOW_SEARCH
+	PROP_SHOW_SEARCH,
+	PROP_SHOW_DEVICE_TYPE,
+	PROP_SHOW_DEVICE_CATEGORY,
+	PROP_DEVICE_TYPE_FILTER,
+	PROP_DEVICE_CATEGORY_FILTER
 };
 
 static void
@@ -364,8 +509,25 @@ bluetooth_device_selection_set_property 
 		break;
 	case PROP_SHOW_SEARCH:
 		priv->show_search = g_value_get_boolean (value);
-		if (priv->search_button != NULL)
-			g_object_set (G_OBJECT (priv->search_button), "visible", priv->show_search, NULL);
+		g_object_set (G_OBJECT (priv->search_button), "visible", priv->show_search, NULL);
+		break;
+	case PROP_SHOW_DEVICE_TYPE:
+		priv->show_device_type = g_value_get_boolean (value);
+		g_object_set (G_OBJECT (priv->device_type_label), "visible", priv->show_device_type, NULL);
+		g_object_set (G_OBJECT (priv->device_type), "visible", priv->show_device_type, NULL);
+		break;
+	case PROP_SHOW_DEVICE_CATEGORY:
+		priv->show_device_category = g_value_get_boolean (value);
+		g_object_set (G_OBJECT (priv->device_category_label), "visible", priv->show_device_category, NULL);
+		g_object_set (G_OBJECT (priv->device_category), "visible", priv->show_device_category, NULL);
+		break;
+	case PROP_DEVICE_TYPE_FILTER:
+		priv->device_type_filter = g_value_get_int (value);
+		gtk_combo_box_set_active (GTK_COMBO_BOX(priv->device_type), priv->device_type_filter);
+		break;
+	case PROP_DEVICE_CATEGORY_FILTER:
+		priv->device_category_filter = g_value_get_int (value);
+		gtk_combo_box_set_active (GTK_COMBO_BOX(priv->device_category), priv->device_category_filter);
 		break;
 	default:
 		G_OBJECT_WARN_INVALID_PROPERTY_ID(object, prop_id, pspec);
@@ -390,6 +552,18 @@ bluetooth_device_selection_get_property 
 	case PROP_SHOW_SEARCH:
 		g_value_set_boolean (value, priv->show_search);
 		break;
+	case PROP_SHOW_DEVICE_TYPE:
+		g_value_set_boolean (value, priv->show_device_type);
+		break;
+	case PROP_SHOW_DEVICE_CATEGORY:
+		g_value_set_boolean (value, priv->show_device_category);
+		break;
+	case PROP_DEVICE_TYPE_FILTER:
+		g_value_set_int (value, priv->device_type_filter);
+		break;
+	case PROP_DEVICE_CATEGORY_FILTER:
+		g_value_set_int (value, priv->device_category_filter);
+		break;
 	default:
 		G_OBJECT_WARN_INVALID_PROPERTY_ID(object, prop_id, pspec);
 		break;
@@ -427,6 +601,18 @@ bluetooth_device_selection_class_init (B
 	g_object_class_install_property (G_OBJECT_CLASS(klass),
 					 PROP_SHOW_SEARCH, g_param_spec_boolean ("show-search",
 										 NULL, NULL, FALSE, G_PARAM_READWRITE));
+	g_object_class_install_property (G_OBJECT_CLASS(klass),
+					 PROP_SHOW_DEVICE_TYPE, g_param_spec_boolean ("show-device-type",
+										      NULL, NULL, TRUE, G_PARAM_READWRITE));
+	g_object_class_install_property (G_OBJECT_CLASS(klass),
+					 PROP_SHOW_DEVICE_CATEGORY, g_param_spec_boolean ("show-device-category",
+											  NULL, NULL, TRUE, G_PARAM_READWRITE));
+	g_object_class_install_property (G_OBJECT_CLASS(klass),
+					 PROP_DEVICE_TYPE_FILTER, g_param_spec_int ("device-type-filter", NULL, NULL,
+										    0, BLUETOOTH_TYPE_NUM_TYPES, 0, G_PARAM_READWRITE));
+	g_object_class_install_property (G_OBJECT_CLASS(klass),
+					 PROP_DEVICE_CATEGORY_FILTER, g_param_spec_int ("device-category-filter", NULL, NULL,
+					 						0, BLUETOOTH_CATEGORY_NUM_CATEGORIES, 0, G_PARAM_READWRITE));
 }
 
 GtkWidget *
Index: common/bluetooth-device-selection.h
===================================================================
RCS file: /cvsroot/bluez/gnome/common/bluetooth-device-selection.h,v
retrieving revision 1.5
diff -u -p -r1.5 bluetooth-device-selection.h
--- common/bluetooth-device-selection.h	9 Aug 2007 08:35:19 -0000	1.5
+++ common/bluetooth-device-selection.h	6 Nov 2007 18:38:02 -0000
@@ -41,6 +41,13 @@ G_BEGIN_DECLS
 #define BLUETOOTH_GET_DEVICE_SELECTION_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS((obj), \
 				BLUETOOTH_TYPE_DEVICE_SELECTION, BluetoothDeviceSelectionClass))
 
+enum {
+	BLUETOOTH_CATEGORY_ALL,
+	BLUETOOTH_CATEGORY_BONDED,
+	BLUETOOTH_CATEGORY_TRUSTED,
+	BLUETOOTH_CATEGORY_NUM_CATEGORIES
+};
+
 typedef struct _BluetoothDeviceSelection BluetoothDeviceSelection;
 typedef struct _BluetoothDeviceSelectionClass BluetoothDeviceSelectionClass;
 
Index: common/client.c
===================================================================
RCS file: /cvsroot/bluez/gnome/common/client.c,v
retrieving revision 1.35
diff -u -p -r1.35 client.c
--- common/client.c	3 Aug 2007 12:37:55 -0000	1.35
+++ common/client.c	6 Nov 2007 18:38:02 -0000
@@ -25,6 +25,7 @@
 #include <config.h>
 #endif
 
+#include <glib/gi18n-lib.h>
 #include <gtk/gtk.h>
 
 #include <dbus/dbus-glib.h>
@@ -121,29 +122,31 @@ static void minor_changed(DBusGProxy *ob
 {
 }
 
-gchar *bluetooth_type_to_string(guint type)
+const gchar *bluetooth_type_to_string(guint type)
 {
 	switch (type) {
+	case BLUETOOTH_TYPE_ANY:
+		return N_("All types");
 	case BLUETOOTH_TYPE_PHONE:
-		return "Phone";
+		return N_("Phone");
 	case BLUETOOTH_TYPE_MODEM:
-		return "Modem";
+		return N_("Modem");
 	case BLUETOOTH_TYPE_COMPUTER:
-		return "Computer";
+		return N_("Computer");
 	case BLUETOOTH_TYPE_NETWORK:
-		return "Network";
+		return N_("Network");
 	case BLUETOOTH_TYPE_HEADSET:
-		return "Headset";
+		return N_("Headset");
 	case BLUETOOTH_TYPE_KEYBOARD:
-		return "Keyboard";
+		return N_("Keyboard");
 	case BLUETOOTH_TYPE_MOUSE:
-		return "Mouse";
+		return N_("Mouse");
 	case BLUETOOTH_TYPE_CAMERA:
-		return "Camera";
+		return N_("Camera");
 	case BLUETOOTH_TYPE_PRINTER:
-		return "Printer";
+		return N_("Printer");
 	default:
-		return "Unknown";
+		return N_("Unknown");
 	}
 }
 
@@ -1343,8 +1346,9 @@ GtkTreeModel *bluetooth_client_get_model
 
 			model = gtk_tree_model_filter_new(GTK_TREE_MODEL(store), path);
 
-			gtk_tree_model_filter_set_visible_func(GTK_TREE_MODEL_FILTER(model),
-							func, data, NULL);
+			if (func != NULL)
+				gtk_tree_model_filter_set_visible_func(GTK_TREE_MODEL_FILTER(model),
+								       func, data, NULL);
 
 			gtk_tree_path_free(path);
 
Index: common/client.h
===================================================================
RCS file: /cvsroot/bluez/gnome/common/client.h,v
retrieving revision 1.20
diff -u -p -r1.20 client.h
--- common/client.h	2 Aug 2007 20:45:17 -0000	1.20
+++ common/client.h	6 Nov 2007 18:38:02 -0000
@@ -84,9 +84,10 @@ enum {
 	BLUETOOTH_TYPE_MOUSE,
 	BLUETOOTH_TYPE_CAMERA,
 	BLUETOOTH_TYPE_PRINTER,
+	BLUETOOTH_TYPE_NUM_TYPES
 };
 
-gchar *bluetooth_type_to_string(guint type);
+const gchar *bluetooth_type_to_string(guint type);
 
 gboolean bluetooth_client_register_passkey_agent(BluetoothClient *self,
 		const char *path, const char *address, const void *info);
Index: common/test-deviceselection.c
===================================================================
RCS file: /cvsroot/bluez/gnome/common/test-deviceselection.c,v
retrieving revision 1.2
diff -u -p -r1.2 test-deviceselection.c
--- common/test-deviceselection.c	25 Jul 2007 18:01:44 -0000	1.2
+++ common/test-deviceselection.c	6 Nov 2007 18:38:03 -0000
@@ -31,11 +31,23 @@
 #include "bluetooth-device-selection.h"
 
 static void device_selected_cb(GObject *object,
-				GParamSpec *spec, gpointer user_data)
+			       GParamSpec *spec, gpointer user_data)
 {
 	g_message ("Property \"device-selected\" changed");
 }
 
+static void device_type_filter_selected_cb(GObject *object,
+					   GParamSpec *spec, gpointer user_data)
+{
+	g_message ("Property \"device-type-filter\" changed");
+}
+
+static void device_category_filter_selected_cb(GObject *object,
+				GParamSpec *spec, gpointer user_data)
+{
+	g_message ("Property \"device-category-filter\" changed");
+}
+
 static void select_device_changed(BluetoothDeviceSelection *sel,
 				  gchar *address, gpointer user_data)
 {
@@ -61,12 +73,18 @@ int main(int argc, char **argv)
 	gtk_window_set_default_size(GTK_WINDOW(dialog), 400, 300);
 
 	selector = bluetooth_device_selection_new("Select a device to setup");
+	gtk_widget_show(selector);
+	g_object_set(selector, "show-search", TRUE, NULL);
 	g_signal_connect(selector, "selected-device-changed",
 			 G_CALLBACK(select_device_changed), dialog);
 	g_signal_connect(selector, "notify::device-selected",
 			 G_CALLBACK(device_selected_cb), dialog);
+	g_signal_connect(selector, "notify::device-type-filter",
+			 G_CALLBACK(device_type_filter_selected_cb), dialog);
+	g_signal_connect(selector, "notify::device-category-filter",
+			 G_CALLBACK(device_category_filter_selected_cb), dialog);
 	gtk_container_add(GTK_CONTAINER(GTK_DIALOG(dialog)->vbox), selector);
-	gtk_widget_show_all(dialog);
+	gtk_widget_show(dialog);
 
 	response = gtk_dialog_run(GTK_DIALOG(dialog));
 
Index: po/POTFILES.in
===================================================================
RCS file: /cvsroot/bluez/gnome/po/POTFILES.in,v
retrieving revision 1.12
diff -u -p -r1.12 POTFILES.in
--- po/POTFILES.in	25 Aug 2007 16:12:32 -0000	1.12
+++ po/POTFILES.in	6 Nov 2007 18:38:03 -0000
@@ -1,4 +1,5 @@
 common/bluetooth-device-selection.c
+common/client.c
 applet/main.c
 applet/bluetooth-applet.desktop.in
 properties/main.c

--=-bcFlYm+3E8WBOH/f4/Nb
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
--=-bcFlYm+3E8WBOH/f4/Nb
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--=-bcFlYm+3E8WBOH/f4/Nb--
