Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Bastien Nocera <hadess@hadess.net>
To: BlueZ Hackers <bluez-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="=-ZF5ibF178cZFSynhZfTi"
Date: Wed, 25 Jul 2007 17:07:26 +0100
Message-Id: <1185379646.3641.257.camel@cookie.hadess.net>
Mime-Version: 1.0
Subject: [Bluez-devel] [PATCH] BluetoothDeviceSelection fixes
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


--=-ZF5ibF178cZFSynhZfTi
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

As discussed with Marcel:
- make the selected device changed a signal as well
- add a convenience function to get the selected device
- use the above changes in the test program
- don't forget to translate it

-- 
Bastien Nocera <hadess@hadess.net> 

--=-ZF5ibF178cZFSynhZfTi
Content-Disposition: attachment;
	filename=bluez-gnome-device-selection-fixes.patch
Content-Type: text/x-patch; name=bluez-gnome-device-selection-fixes.patch;
	charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Index: common/bluetooth-device-selection.c
===================================================================
RCS file: /cvsroot/bluez/gnome/common/bluetooth-device-selection.c,v
retrieving revision 1.2
diff -u -p -r1.2 bluetooth-device-selection.c
--- common/bluetooth-device-selection.c	25 Jul 2007 14:28:47 -0000	1.2
+++ common/bluetooth-device-selection.c	25 Jul 2007 15:49:13 -0000
@@ -35,6 +35,13 @@
 
 #include "bluetooth-device-selection.h"
 
+enum {
+	SELECTED_DEVICE_CHANGED,
+	LAST_SIGNAL
+};
+
+static int selection_table_signals[LAST_SIGNAL] = { 0 };
+
 #define BLUETOOTH_DEVICE_SELECTION_GET_PRIVATE(obj) (G_TYPE_INSTANCE_GET_PRIVATE((obj), \
 										 BLUETOOTH_TYPE_DEVICE_SELECTOR, BluetoothDeviceSelectionPrivate))
 
@@ -49,8 +56,9 @@ struct _BluetoothDeviceSelectionPrivate 
 
 G_DEFINE_TYPE(BluetoothDeviceSelection, bluetooth_device_selection, GTK_TYPE_VBOX)
 
-static void name_to_text (GtkTreeViewColumn *column, GtkCellRenderer *cell,
-			  GtkTreeModel *model, GtkTreeIter *iter, gpointer data)
+static void
+name_to_text (GtkTreeViewColumn *column, GtkCellRenderer *cell,
+	      GtkTreeModel *model, GtkTreeIter *iter, gpointer data)
 {
 	gchar *address;
 	gchar *name;
@@ -71,8 +79,9 @@ static void name_to_text (GtkTreeViewCol
 	g_free (address);
 }
 
-static void type_to_icon (GtkTreeViewColumn *column, GtkCellRenderer *cell,
-			  GtkTreeModel *model, GtkTreeIter *iter, gpointer data)
+static void
+type_to_icon (GtkTreeViewColumn *column, GtkCellRenderer *cell,
+	      GtkTreeModel *model, GtkTreeIter *iter, gpointer data)
 {
 	guint type;
 
@@ -112,8 +121,9 @@ static void type_to_icon (GtkTreeViewCol
 	}
 }
 
-static void type_to_text (GtkTreeViewColumn *column, GtkCellRenderer *cell,
-			  GtkTreeModel *model, GtkTreeIter *iter, gpointer data)
+static void
+type_to_text (GtkTreeViewColumn *column, GtkCellRenderer *cell,
+	      GtkTreeModel *model, GtkTreeIter *iter, gpointer data)
 {
 	guint type;
 
@@ -122,17 +132,41 @@ static void type_to_text (GtkTreeViewCol
 	g_object_set (cell, "text", bluetooth_type_to_string (type), NULL);
 }
 
-static void select_browse_device_callback (GtkTreeSelection *selection, gpointer user_data)
+gchar *
+bluetooth_device_selection_get_selected_device (BluetoothDeviceSelection *self)
+{
+	BluetoothDeviceSelectionPrivate *priv = BLUETOOTH_DEVICE_SELECTION_GET_PRIVATE(self);
+	GtkTreeIter iter;
+	gchar *address;
+	gboolean selected;
+
+	selected = gtk_tree_selection_get_selected (priv->selection, NULL, &iter);
+	if (selected == FALSE)
+		return NULL;
+
+	gtk_tree_model_get (priv->model, &iter, COLUMN_ADDRESS, &address, -1);
+	return address;
+}
+
+static void
+select_browse_device_callback (GtkTreeSelection *selection, gpointer user_data)
 {
 	BluetoothDeviceSelection *self = user_data;
+	gchar *address;
 
 	g_object_notify (G_OBJECT(self), "device-selected");
+	address = bluetooth_device_selection_get_selected_device (self);
+	g_signal_emit (G_OBJECT (self),
+		       selection_table_signals[SELECTED_DEVICE_CHANGED],
+		       0, address);
+	g_free (address);
 }
 
-static void bluetooth_device_selection_init(BluetoothDeviceSelection *self)
+static void
+bluetooth_device_selection_init(BluetoothDeviceSelection *self)
 {
 	BluetoothDeviceSelectionPrivate *priv = BLUETOOTH_DEVICE_SELECTION_GET_PRIVATE(self);
-	GtkWidget *tree, *scrolled;
+	GtkWidget *tree, *scrolled, *frame, *box;
 	GtkCellRenderer *renderer;
 	GtkTreeViewColumn *column;
 
@@ -140,10 +174,13 @@ static void bluetooth_device_selection_i
 	gtk_box_set_homogeneous (GTK_BOX(self), FALSE);
 	gtk_container_set_border_width (GTK_CONTAINER(self), 8);
 
-	priv->label = gtk_label_new (NULL);
-	gtk_misc_set_alignment (GTK_MISC(priv->label), 0, 0);
-	gtk_box_pack_start (GTK_BOX(self), priv->label, FALSE, FALSE, 0);
-	gtk_widget_show (priv->label);
+	frame = gtk_frame_new ("");
+	priv->label = gtk_frame_get_label_widget (GTK_FRAME(frame));
+	gtk_frame_set_shadow_type (GTK_FRAME(frame), GTK_SHADOW_NONE);
+	gtk_container_add (GTK_CONTAINER(self), frame);
+
+	box = gtk_vbox_new (FALSE, 8);
+	gtk_container_add (GTK_CONTAINER(frame), box);
 
 	priv->client = bluetooth_client_new ();
 
@@ -207,11 +244,12 @@ static void bluetooth_device_selection_i
 	bluetooth_client_discover_devices (priv->client, NULL);
 
 	gtk_container_add (GTK_CONTAINER(scrolled), tree);
-	gtk_container_add (GTK_CONTAINER(self), scrolled);
+	gtk_container_add (GTK_CONTAINER(box), scrolled);
 	gtk_widget_show_all (scrolled);
 }
 
-static void bluetooth_device_selection_finalize (GObject *object)
+static void
+bluetooth_device_selection_finalize (GObject *object)
 {
 	BluetoothDeviceSelectionPrivate *priv = BLUETOOTH_DEVICE_SELECTION_GET_PRIVATE(object);
 
@@ -224,8 +262,9 @@ enum {
 	PROP_DEVICE_SELECTED
 };
 
-static void bluetooth_device_selection_set_property (GObject *object, guint prop_id,
-						     const GValue *value, GParamSpec *pspec)
+static void
+bluetooth_device_selection_set_property (GObject *object, guint prop_id,
+					 const GValue *value, GParamSpec *pspec)
 {
 	BluetoothDeviceSelectionPrivate *priv = BLUETOOTH_DEVICE_SELECTION_GET_PRIVATE(object);
 
@@ -248,27 +287,15 @@ static void bluetooth_device_selection_s
 	}
 }
 
-static void bluetooth_device_selection_get_property (GObject *object, guint prop_id,
-						     GValue *value, GParamSpec *pspec)
+static void
+bluetooth_device_selection_get_property (GObject *object, guint prop_id,
+					 GValue *value, GParamSpec *pspec)
 {
-	BluetoothDeviceSelectionPrivate *priv = BLUETOOTH_DEVICE_SELECTION_GET_PRIVATE(object);
+	BluetoothDeviceSelection *self = BLUETOOTH_DEVICE_SELECTION(object);
 
 	switch (prop_id) {
 	case PROP_DEVICE_SELECTED:
-		{
-			GtkTreeIter iter;
-			gboolean selected;
-
-			selected = gtk_tree_selection_get_selected (priv->selection, NULL, &iter);
-			if (selected == FALSE) {
-				g_value_set_string (value, NULL);
-			} else {
-				char *address;
-
-				gtk_tree_model_get (priv->model, &iter, COLUMN_ADDRESS, &address, -1);
-				g_value_take_string (value, address);
-			}
-		}
+		g_value_set_string (value, bluetooth_device_selection_get_selected_device (self));
 		break;
 	default:
 		G_OBJECT_WARN_INVALID_PROPERTY_ID(object, prop_id, pspec);
@@ -276,7 +303,8 @@ static void bluetooth_device_selection_g
 	}
 }
 
-static void bluetooth_device_selection_class_init (BluetoothDeviceSelectionClass *klass)
+static void
+bluetooth_device_selection_class_init (BluetoothDeviceSelectionClass *klass)
 {
 	g_type_class_add_private(klass, sizeof(BluetoothDeviceSelectionPrivate));
 
@@ -285,6 +313,15 @@ static void bluetooth_device_selection_c
 	G_OBJECT_CLASS(klass)->set_property = bluetooth_device_selection_set_property;
 	G_OBJECT_CLASS(klass)->get_property = bluetooth_device_selection_get_property;
 
+	selection_table_signals[SELECTED_DEVICE_CHANGED] =
+		g_signal_new ("selected-device-changed",
+			      G_TYPE_FROM_CLASS (klass),
+			      G_SIGNAL_RUN_LAST,
+			      G_STRUCT_OFFSET (BluetoothDeviceSelectionClass, selected_device_changed),
+			      NULL, NULL,
+			      g_cclosure_marshal_VOID__STRING,
+			      G_TYPE_NONE, 1, G_TYPE_STRING);
+
 	g_object_class_install_property (G_OBJECT_CLASS(klass),
 					 PROP_TITLE, g_param_spec_string ("title",
 									  NULL, NULL, NULL, G_PARAM_WRITABLE));
@@ -293,9 +330,11 @@ static void bluetooth_device_selection_c
 										    NULL, NULL, NULL, G_PARAM_READABLE));
 }
 
-GtkWidget *bluetooth_device_selection_new (const gchar *title)
+GtkWidget *
+bluetooth_device_selection_new (const gchar *title)
 {
 	return g_object_new(BLUETOOTH_TYPE_DEVICE_SELECTOR,
 			    "title", title,
 			    NULL);
 }
+
Index: common/bluetooth-device-selection.h
===================================================================
RCS file: /cvsroot/bluez/gnome/common/bluetooth-device-selection.h,v
retrieving revision 1.1
diff -u -p -r1.1 bluetooth-device-selection.h
--- common/bluetooth-device-selection.h	25 Jul 2007 10:28:56 -0000	1.1
+++ common/bluetooth-device-selection.h	25 Jul 2007 15:49:13 -0000
@@ -50,11 +50,14 @@ struct _BluetoothDeviceSelection {
 
 struct _BluetoothDeviceSelectionClass {
 	GtkVBoxClass parent_class;
+
+	void (*selected_device_changed) (BluetoothDeviceSelection *sel, gchar *device);
 };
 
 GType bluetooth_device_selection_get_type (void);
 
 GtkWidget *bluetooth_device_selection_new (const gchar *title);
+gchar *bluetooth_device_selection_get_selected_device (BluetoothDeviceSelection *sel);
 
 G_END_DECLS
 
Index: common/test-deviceselection.c
===================================================================
RCS file: /cvsroot/bluez/gnome/common/test-deviceselection.c,v
retrieving revision 1.1
diff -u -p -r1.1 test-deviceselection.c
--- common/test-deviceselection.c	25 Jul 2007 10:28:56 -0000	1.1
+++ common/test-deviceselection.c	25 Jul 2007 15:49:13 -0000
@@ -31,17 +31,18 @@
 #include "bluetooth-device-selection.h"
 
 static void device_selected_cb(GObject *object,
-				GParamSpec *spec, gpointer user_data)
+			       GParamSpec *spec, gpointer user_data)
 {
-	GtkDialog *dialog = user_data;
-	char *address;
+	g_message ("Property \"device-selected\" changed");
+}
 
-	g_object_get(object, "device-selected", &address, NULL);
+static void select_device_changed(BluetoothDeviceSelection *sel,
+				  gchar *address, gpointer user_data)
+{
+	GtkDialog *dialog = user_data;
 
 	gtk_dialog_set_response_sensitive(dialog,
-				GTK_RESPONSE_ACCEPT, address != NULL);
-
-	g_free(address);
+					  GTK_RESPONSE_ACCEPT, address != NULL);
 }
 
 int main(int argc, char **argv)
@@ -60,6 +61,8 @@ int main(int argc, char **argv)
 	gtk_window_set_default_size(GTK_WINDOW(dialog), 400, 300);
 
 	selector = bluetooth_device_selection_new("Select a device to setup");
+	g_signal_connect(selector, "selected-device-changed",
+			 G_CALLBACK(select_device_changed), dialog);
 	g_signal_connect(selector, "notify::device-selected",
 			 G_CALLBACK(device_selected_cb), dialog);
 	gtk_container_add(GTK_CONTAINER(GTK_DIALOG(dialog)->vbox), selector);
Index: po/POTFILES.in
===================================================================
RCS file: /cvsroot/bluez/gnome/po/POTFILES.in,v
retrieving revision 1.5
diff -u -p -r1.5 POTFILES.in
--- po/POTFILES.in	3 Apr 2007 18:01:52 -0000	1.5
+++ po/POTFILES.in	25 Jul 2007 15:49:13 -0000
@@ -1,5 +1,6 @@
 applet/main.c
 applet/bluetooth-applet.desktop.in
+common/bluetooth-device-selection.c
 properties/main.c
 properties/bluetooth-properties.desktop.in
 wizard/main.c

--=-ZF5ibF178cZFSynhZfTi
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
--=-ZF5ibF178cZFSynhZfTi
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--=-ZF5ibF178cZFSynhZfTi--
