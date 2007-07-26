Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Bastien Nocera <hadess@hadess.net>
To: BlueZ Hackers <bluez-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="=-SfSWgwDcm6Ux+tqYsZ3+"
Date: Thu, 26 Jul 2007 15:13:23 +0100
Message-Id: <1185459203.3641.287.camel@cookie.hadess.net>
Mime-Version: 1.0
Subject: [Bluez-devel] [PATCH] Show the trusted icon in the treeview
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


--=-SfSWgwDcm6Ux+tqYsZ3+
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

I added a property to be able to show/hide a trusted (bonded) icon in
the list view, it's shown by default.

There's also a one-liner to avoid changing the address rather than the
name, when a device doesn't have a name (ie. it still displayed
00:00:00:00:00:00 rather than 00-00-00-00-00-00, but changed the address
to that).

-- 
Bastien Nocera <hadess@hadess.net> 

--=-SfSWgwDcm6Ux+tqYsZ3+
Content-Disposition: attachment;
	filename=bluez-gnome-selection-show-trusted-icon-prop.patch
Content-Type: text/x-patch;
	name=bluez-gnome-selection-show-trusted-icon-prop.patch;
	charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Index: bluetooth-device-selection.c
===================================================================
RCS file: /cvsroot/bluez/gnome/common/bluetooth-device-selection.c,v
retrieving revision 1.3
diff -u -p -r1.3 bluetooth-device-selection.c
--- bluetooth-device-selection.c	25 Jul 2007 18:01:44 -0000	1.3
+++ bluetooth-device-selection.c	26 Jul 2007 14:09:54 -0000
@@ -52,6 +52,10 @@ struct _BluetoothDeviceSelectionPrivate 
 	GtkTreeSelection *selection;
 	GtkTreeModel *model;
 	GtkWidget *label;
+
+	/* Whether the trusted icon is shown */
+	GtkCellRenderer *trusted_cell;
+	guint show_trusted : 1;
 };
 
 G_DEFINE_TYPE(BluetoothDeviceSelection, bluetooth_device_selection, GTK_TYPE_VBOX)
@@ -70,7 +74,7 @@ name_to_text (GtkTreeViewColumn *column,
 	 * Bluetooth address, with the ":" replaced by "-" */
 	if (name == NULL) {
 		name = g_strdup (address);
-		g_strdelimit (address, ":", '-');
+		g_strdelimit (name, ":", '-');
 	}
 
 	g_object_set (cell, "text", name ? name : address, NULL);
@@ -122,6 +126,21 @@ type_to_icon (GtkTreeViewColumn *column,
 }
 
 static void
+trusted_to_icon (GtkTreeViewColumn *column, GtkCellRenderer *cell,
+	      GtkTreeModel *model, GtkTreeIter *iter, gpointer data)
+{
+	gboolean trusted;
+	char *addr;
+
+	gtk_tree_model_get (model, iter, COLUMN_TRUSTED, &trusted, COLUMN_ADDRESS, &addr, -1);
+
+	if (trusted == FALSE)
+		g_object_set (cell, "stock-id", NULL, NULL);
+	else
+		g_object_set (cell, "stock-id", GTK_STOCK_DIALOG_AUTHENTICATION, NULL);
+}
+
+static void
 type_to_text (GtkTreeViewColumn *column, GtkCellRenderer *cell,
 	      GtkTreeModel *model, GtkTreeIter *iter, gpointer data)
 {
@@ -170,6 +189,8 @@ bluetooth_device_selection_init(Bluetoot
 	GtkCellRenderer *renderer;
 	GtkTreeViewColumn *column;
 
+	priv->show_trusted = TRUE;
+
 	gtk_box_set_spacing (GTK_BOX(self), 6);
 	gtk_box_set_homogeneous (GTK_BOX(self), FALSE);
 	gtk_container_set_border_width (GTK_CONTAINER(self), 8);
@@ -207,6 +228,7 @@ bluetooth_device_selection_init(Bluetoot
 
 	gtk_tree_view_column_set_title (column, _("Device"));
 
+	/* The type icon */
 	renderer = gtk_cell_renderer_pixbuf_new ();
 	gtk_tree_view_column_set_spacing (column, 4);
 	gtk_tree_view_column_pack_start (column, renderer, FALSE);
@@ -214,12 +236,20 @@ bluetooth_device_selection_init(Bluetoot
 	gtk_tree_view_column_set_cell_data_func (column, renderer,
 						 type_to_icon, NULL, NULL);
 
+	/* The device name */
 	renderer = gtk_cell_renderer_text_new ();
 	gtk_tree_view_column_pack_start (column, renderer, TRUE);
 
 	gtk_tree_view_column_set_cell_data_func (column, renderer,
 						 name_to_text, NULL, NULL);
 
+	/* The trusted icon */
+	priv->trusted_cell = gtk_cell_renderer_pixbuf_new ();
+	gtk_tree_view_column_pack_end (column, priv->trusted_cell, FALSE);
+
+	gtk_tree_view_column_set_cell_data_func (column, priv->trusted_cell,
+						 trusted_to_icon, NULL, NULL);
+
 	gtk_tree_view_append_column (GTK_TREE_VIEW(tree), column);
 
 	gtk_tree_view_column_set_min_width (GTK_TREE_VIEW_COLUMN(column), 280);
@@ -259,7 +289,8 @@ bluetooth_device_selection_finalize (GOb
 enum {
 	PROP_0,
 	PROP_TITLE,
-	PROP_DEVICE_SELECTED
+	PROP_DEVICE_SELECTED,
+	PROP_SHOW_BONDING
 };
 
 static void
@@ -281,6 +312,11 @@ bluetooth_device_selection_set_property 
 			g_free (str);
 		}
 		break;
+	case PROP_SHOW_BONDING:
+		priv->show_trusted = g_value_get_boolean (value);
+		if (priv->trusted_cell != NULL)
+			g_object_set (G_OBJECT (priv->trusted_cell), "visible", priv->show_trusted, NULL);
+		break;
 	default:
 		G_OBJECT_WARN_INVALID_PROPERTY_ID(object, prop_id, pspec);
 		break;
@@ -292,11 +328,15 @@ bluetooth_device_selection_get_property 
 					 GValue *value, GParamSpec *pspec)
 {
 	BluetoothDeviceSelection *self = BLUETOOTH_DEVICE_SELECTION(object);
+	BluetoothDeviceSelectionPrivate *priv = BLUETOOTH_DEVICE_SELECTION_GET_PRIVATE(object);
 
 	switch (prop_id) {
 	case PROP_DEVICE_SELECTED:
 		g_value_set_string (value, bluetooth_device_selection_get_selected_device (self));
 		break;
+	case PROP_SHOW_BONDING:
+		g_value_set_boolean (value, priv->show_trusted);
+		break;
 	default:
 		G_OBJECT_WARN_INVALID_PROPERTY_ID(object, prop_id, pspec);
 		break;
@@ -328,6 +368,9 @@ bluetooth_device_selection_class_init (B
 	g_object_class_install_property (G_OBJECT_CLASS(klass),
 					 PROP_DEVICE_SELECTED, g_param_spec_string ("device-selected",
 										    NULL, NULL, NULL, G_PARAM_READABLE));
+	g_object_class_install_property (G_OBJECT_CLASS(klass),
+					 PROP_SHOW_BONDING, g_param_spec_boolean ("show-bonding",
+										    NULL, NULL, TRUE, G_PARAM_READWRITE));
 }
 
 GtkWidget *

--=-SfSWgwDcm6Ux+tqYsZ3+
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
--=-SfSWgwDcm6Ux+tqYsZ3+
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--=-SfSWgwDcm6Ux+tqYsZ3+--
