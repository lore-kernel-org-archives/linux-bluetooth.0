Return-Path: <cyrus@holtmann.org>
From: Bastien Nocera <hadess@hadess.net>
To: BlueZ Hackers <bluez-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="=-m/1SmOsrW6vbx8Qqj565"
Date: Fri, 25 Jan 2008 02:28:39 +0000
Message-Id: <1201228119.2389.20.camel@cookie.hadess.net>
Mime-Version: 1.0
Subject: [Bluez-devel] [PATCH] Make device selection look better
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


--=-m/1SmOsrW6vbx8Qqj565
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Heya,

Here's a patch to make the device selection widget look better, from the
bug http://bugzilla.gnome.org/show_bug.cgi?id=505222

Before:
http://bugzilla.gnome.org/attachment.cgi?id=103695&action=view
After:
http://bugzilla.gnome.org/attachment.cgi?id=103696&action=view

Cheers

--=-m/1SmOsrW6vbx8Qqj565
Content-Disposition: attachment; filename=bluez-gnome-selector-hig-2.patch
Content-Type: text/x-patch; name=bluez-gnome-selector-hig-2.patch;
	charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Index: bluetooth-device-selection.c
===================================================================
RCS file: /cvsroot/bluez/gnome/common/bluetooth-device-selection.c,v
retrieving revision 1.10
diff -u -p -r1.10 bluetooth-device-selection.c
--- bluetooth-device-selection.c	17 Dec 2007 01:09:28 -0000	1.10
+++ bluetooth-device-selection.c	25 Jan 2008 02:25:52 -0000
@@ -297,36 +297,13 @@ filter_category_changed_cb (GtkComboBox 
 	g_object_notify (G_OBJECT(self), "device-category-filter");
 }
 
-static void
-bluetooth_device_selection_init(BluetoothDeviceSelection *self)
+static GtkWidget *
+create_treeview (BluetoothDeviceSelection *self)
 {
 	BluetoothDeviceSelectionPrivate *priv = BLUETOOTH_DEVICE_SELECTION_GET_PRIVATE(self);
-	GtkWidget *tree, *scrolled, *frame, *box, *hbox, *table;
+	GtkWidget *scrolled, *tree;
 	GtkCellRenderer *renderer;
 	GtkTreeViewColumn *column;
-	int i;
-
-	priv->show_bonded = FALSE;
-	priv->show_search = FALSE;
-
-	gtk_box_set_spacing (GTK_BOX(self), 6);
-	gtk_box_set_homogeneous (GTK_BOX(self), FALSE);
-	gtk_container_set_border_width (GTK_CONTAINER(self), 8);
-
-	frame = gtk_frame_new ("");
-	priv->label = gtk_frame_get_label_widget (GTK_FRAME(frame));
-	gtk_frame_set_shadow_type (GTK_FRAME(frame), GTK_SHADOW_NONE);
-	gtk_container_add (GTK_CONTAINER(self), frame);
-
-	box = gtk_vbox_new (FALSE, 8);
-	gtk_container_add (GTK_CONTAINER(frame), box);
-
-	priv->client = bluetooth_client_new ();
-
-#if 0
-	g_signal_connect (G_OBJECT(priv->client), "discoveries-completed",
-			  G_CALLBACK(discoveries_completed), self);
-#endif
 
 	/* Create the scrolled window */
 	scrolled = gtk_scrolled_window_new (NULL, NULL);
@@ -389,46 +366,137 @@ bluetooth_device_selection_init(Bluetoot
 
 	/* Set the model, and filter */
 	priv->model = bluetooth_client_get_model_with_filter (priv->client, NULL, NULL, NULL);
-	priv->filter = gtk_tree_model_filter_new (priv->model, NULL);
-	gtk_tree_model_filter_set_visible_func (GTK_TREE_MODEL_FILTER (priv->filter),
-						filter_func, self, NULL);
+	if (priv->model) {
+		priv->filter = gtk_tree_model_filter_new (priv->model, NULL);
+		gtk_tree_model_filter_set_visible_func (GTK_TREE_MODEL_FILTER (priv->filter),
+							filter_func, self, NULL);
+	}
 	if (priv->model) {
 		gtk_tree_view_set_model (GTK_TREE_VIEW(tree), priv->filter);
 		g_object_unref (priv->filter);
 	}
 
 	gtk_container_add (GTK_CONTAINER(scrolled), tree);
-	gtk_box_pack_start (GTK_BOX(box), scrolled, TRUE, TRUE, 6);
 
-	/* Setup the device filter widgets */
-	table = gtk_table_new (2, 2, TRUE);
-	gtk_box_pack_start (GTK_BOX(box), table, FALSE, FALSE, 0);
+	return scrolled;
+}
 
-	priv->device_type_label = gtk_label_new_with_mnemonic (_("Device _type:"));
-	gtk_label_set_justify (GTK_LABEL(priv->device_type_label), GTK_JUSTIFY_RIGHT);
-	priv->device_type = gtk_combo_box_new_text ();
-	/* The types match the types used in client.h */
-	for (i = 0; i < BLUETOOTH_TYPE_NUM_TYPES; i++) {
-		gtk_combo_box_append_text (GTK_COMBO_BOX(priv->device_type),
-					   _(bluetooth_type_to_string (i)));
-	}
-	g_signal_connect (G_OBJECT (priv->device_type), "changed",
-			  G_CALLBACK(filter_type_changed_cb), self);
-	gtk_combo_box_set_active (GTK_COMBO_BOX(priv->device_type), priv->device_type_filter);
-	gtk_table_attach (GTK_TABLE (table), GTK_WIDGET (priv->device_type_label),
-				   0, 1, 0, 1,
-				   GTK_FILL | GTK_EXPAND, 0, 0, 0);
-	gtk_table_attach (GTK_TABLE (table), GTK_WIDGET (priv->device_type),
-				   1, 2, 0, 1,
-				   GTK_FILL | GTK_EXPAND, 0, 0, 0);
-	if (priv->show_device_type) {
-		gtk_widget_show (priv->device_type_label);
-		gtk_widget_show (priv->device_type);
-	}
+static void
+bluetooth_device_selection_init(BluetoothDeviceSelection *self)
+{
+	BluetoothDeviceSelectionPrivate *priv = BLUETOOTH_DEVICE_SELECTION_GET_PRIVATE(self);
+	GtkTooltips *tooltips;
+	char *str;
+	int i;
+
+	GtkWidget *vbox;
+	GtkWidget *label;
+	GtkWidget *alignment;
+	GtkWidget *hbox;
+	GtkWidget *scrolled_window;
+	GtkWidget *table;
+
+	priv->show_bonded = FALSE;
+	priv->show_search = FALSE;
+
+	priv->client = bluetooth_client_new ();
+
+#if 0
+	g_signal_connect (G_OBJECT(priv->client), "discoveries-completed",
+			  G_CALLBACK(discoveries_completed), self);
+#endif
+
+	tooltips = gtk_tooltips_new ();
+
+	/* Setup the widget itself */
+	gtk_box_set_spacing (GTK_BOX(self), 18);
+	gtk_container_set_border_width (GTK_CONTAINER(self), 7);
+
+	vbox = gtk_vbox_new (FALSE, 0);
+	gtk_widget_show (vbox);
+	gtk_box_pack_start (GTK_BOX (self), vbox, TRUE, TRUE, 0);
+
+	/* The top level label */
+	str = g_strdup_printf ("<b>%s</b>", _("Recognized Bluetooth Devices"));
+	priv->label = gtk_label_new (str);
+	g_free (str);
+	gtk_widget_show (priv->label);
+	gtk_box_pack_start (GTK_BOX (vbox), priv->label, FALSE, TRUE, 0);
+	gtk_label_set_use_markup (GTK_LABEL (priv->label), TRUE);
+	gtk_misc_set_alignment (GTK_MISC (priv->label), 0, 0.5);
+
+	alignment = gtk_alignment_new (0.5, 0.5, 1, 1);
+	gtk_widget_show (alignment);
+	gtk_box_pack_start (GTK_BOX (vbox), alignment, TRUE, TRUE, 0);
+	gtk_alignment_set_padding (GTK_ALIGNMENT (alignment), 0, 0, 12, 0);
+
+	/* The treeview label */
+	vbox = gtk_vbox_new (FALSE, 6);
+	gtk_widget_show (vbox);
+	gtk_container_add (GTK_CONTAINER (alignment), vbox);
+
+	hbox = gtk_hbox_new (FALSE, 24);
+	gtk_widget_show (hbox);
+	gtk_box_pack_start (GTK_BOX (vbox), hbox, FALSE, TRUE, 0);
+
+	label = gtk_label_new_with_mnemonic (_("_Select a device from the following list:"));
+	gtk_widget_show (label);
+	gtk_box_pack_start (GTK_BOX (hbox), label, FALSE, TRUE, 0);
+	gtk_misc_set_alignment (GTK_MISC (label), 0, 1);
+
+	/* The search button */
+	priv->search_button = gtk_button_new_with_mnemonic (_("S_earch"));
+	gtk_box_pack_end (GTK_BOX (hbox), priv->search_button, FALSE, TRUE, 0);
+	g_signal_connect (G_OBJECT(priv->search_button), "clicked",
+			  G_CALLBACK(search_button_clicked), self);
+	if (priv->show_search)
+		gtk_widget_show (priv->search_button);
+
+	/* The treeview */
+	scrolled_window = create_treeview (self);
+	gtk_widget_show_all (scrolled_window);
+	gtk_box_pack_start (GTK_BOX (vbox), scrolled_window, TRUE, TRUE, 0);
+	gtk_scrolled_window_set_policy (GTK_SCROLLED_WINDOW (scrolled_window), GTK_POLICY_AUTOMATIC, GTK_POLICY_AUTOMATIC);
+	gtk_scrolled_window_set_shadow_type (GTK_SCROLLED_WINDOW (scrolled_window), GTK_SHADOW_IN);
+
+	vbox = gtk_vbox_new (FALSE, 6);
+	gtk_widget_show (vbox);
+	gtk_box_pack_start (GTK_BOX (self), vbox, FALSE, TRUE, 0);
+
+	/* The filters */
+	str = g_strdup_printf ("<b>%s</b>", _("Show Only Bluetooth Devices With..."));
+	label = gtk_label_new (str);
+	g_free (str);
+	gtk_widget_show (label);
+	gtk_box_pack_start (GTK_BOX (vbox), label, TRUE, TRUE, 0);
+	gtk_label_set_use_markup (GTK_LABEL (label), TRUE);
+	gtk_misc_set_alignment (GTK_MISC (label), 0, 0.5);
+
+	alignment = gtk_alignment_new (0.5, 0.5, 1, 1);
+	gtk_widget_show (alignment);
+	gtk_box_pack_start (GTK_BOX (vbox), alignment, TRUE, TRUE, 0);
+	gtk_alignment_set_padding (GTK_ALIGNMENT (alignment), 0, 0, 12, 0);
+
+	table = gtk_table_new (2, 2, FALSE);
+	gtk_widget_show (table);
+	gtk_container_add (GTK_CONTAINER (alignment), table);
+	gtk_table_set_row_spacings (GTK_TABLE (table), 12);
+	gtk_table_set_col_spacings (GTK_TABLE (table), 6);
+
+	/* The device category filter */
+	label = gtk_label_new_with_mnemonic (_("Device _category:"));
+	gtk_widget_show (label);
+	gtk_table_attach (GTK_TABLE (table), label, 0, 1, 1, 2,
+			  (GtkAttachOptions) (0),
+			  (GtkAttachOptions) (0), 0, 0);
+	gtk_misc_set_alignment (GTK_MISC (label), 0, 0.5);
 
-	priv->device_category_label = gtk_label_new_with_mnemonic (_("Device _category:"));
-	gtk_label_set_justify (GTK_LABEL(priv->device_category_label), GTK_JUSTIFY_RIGHT);
 	priv->device_category = gtk_combo_box_new_text ();
+	gtk_widget_show (priv->device_category);
+	gtk_table_attach (GTK_TABLE (table), priv->device_category, 1, 2, 1, 2,
+			  (GtkAttachOptions) (GTK_EXPAND | GTK_FILL),
+			  (GtkAttachOptions) (GTK_EXPAND | GTK_FILL), 0, 0);
+	gtk_tooltips_set_tip (tooltips, priv->device_category, _("Select the device category to filter above list"), NULL);
 	for (i = 0; i < BLUETOOTH_CATEGORY_NUM_CATEGORIES; i++) {
 		gtk_combo_box_append_text (GTK_COMBO_BOX(priv->device_category),
 					   _(bluetooth_device_category_to_string (i)));
@@ -436,29 +504,37 @@ bluetooth_device_selection_init(Bluetoot
 	g_signal_connect (G_OBJECT (priv->device_category), "changed",
 			  G_CALLBACK(filter_category_changed_cb), self);
 	gtk_combo_box_set_active (GTK_COMBO_BOX(priv->device_category), priv->device_category_filter);
-	gtk_table_attach (GTK_TABLE (table), GTK_WIDGET (priv->device_category_label),
-				   0, 1, 1, 2,
-				   GTK_FILL | GTK_EXPAND, 0, 0, 0);
-	gtk_table_attach (GTK_TABLE (table), GTK_WIDGET (priv->device_category),
-				   1, 2, 1, 2,
-				   GTK_FILL | GTK_EXPAND, 0, 0, 0);
 	if (priv->show_device_category) {
 		gtk_widget_show (priv->device_category_label);
 		gtk_widget_show (priv->device_category);
 	}
 
-	/* Setup the search button */
-	hbox = gtk_hbox_new (FALSE, 0);
-	priv->search_button = gtk_button_new_with_label (_("Search"));
-	g_signal_connect (G_OBJECT(priv->search_button), "clicked",
-			  G_CALLBACK(search_button_clicked), self);
-	gtk_box_pack_start (GTK_BOX(box), hbox, FALSE, FALSE, 0);
-	gtk_widget_show_all (GTK_WIDGET (self));
+	/* The device type filter */
+	label = gtk_label_new_with_mnemonic (_("Device _type:"));
+	gtk_widget_show (label);
+	gtk_table_attach (GTK_TABLE (table), label, 0, 1, 0, 1,
+			  (GtkAttachOptions) (0),
+			  (GtkAttachOptions) (GTK_EXPAND | GTK_FILL), 0, 0);
+	gtk_misc_set_alignment (GTK_MISC (label), 0, 0.5);
 
-	gtk_box_pack_start (GTK_BOX(hbox), priv->search_button,
-			    FALSE, FALSE, 0);
-	if (priv->show_search)
-		gtk_widget_show (priv->search_button);
+	priv->device_type = gtk_combo_box_new_text ();
+	gtk_widget_show (priv->device_type);
+	gtk_table_attach (GTK_TABLE (table), priv->device_type, 1, 2, 0, 1,
+			  (GtkAttachOptions) (GTK_EXPAND | GTK_FILL),
+			  (GtkAttachOptions) (GTK_EXPAND | GTK_FILL), 0, 0);
+	gtk_tooltips_set_tip (tooltips, priv->device_type, _("Select the device type to filter above list"), NULL);
+	/* The types match the types used in client.h */
+	for (i = 0; i < BLUETOOTH_TYPE_NUM_TYPES; i++) {
+		gtk_combo_box_append_text (GTK_COMBO_BOX(priv->device_type),
+					   _(bluetooth_type_to_string (i)));
+	}
+	g_signal_connect (G_OBJECT (priv->device_type), "changed",
+			  G_CALLBACK(filter_type_changed_cb), self);
+	gtk_combo_box_set_active (GTK_COMBO_BOX(priv->device_type), priv->device_type_filter);
+	if (priv->show_device_type) {
+		gtk_widget_show (priv->device_type_label);
+		gtk_widget_show (priv->device_type);
+	}
 
 	bluetooth_device_selection_start_discovery (self);
 }
Index: test-deviceselection.c
===================================================================
RCS file: /cvsroot/bluez/gnome/common/test-deviceselection.c,v
retrieving revision 1.3
diff -u -p -r1.3 test-deviceselection.c
--- test-deviceselection.c	17 Dec 2007 01:09:28 -0000	1.3
+++ test-deviceselection.c	25 Jan 2008 02:25:52 -0000
@@ -70,7 +70,7 @@ int main(int argc, char **argv)
 				GTK_STOCK_CONNECT, GTK_RESPONSE_ACCEPT, NULL);
 	gtk_dialog_set_response_sensitive(GTK_DIALOG(dialog),
 					GTK_RESPONSE_ACCEPT, FALSE);
-	gtk_window_set_default_size(GTK_WINDOW(dialog), 400, 300);
+	gtk_window_set_default_size(GTK_WINDOW(dialog), 400, 400);
 
 	selector = bluetooth_device_selection_new("Select a device to setup");
 	gtk_widget_show(selector);

--=-m/1SmOsrW6vbx8Qqj565
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--=-m/1SmOsrW6vbx8Qqj565
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--=-m/1SmOsrW6vbx8Qqj565--
