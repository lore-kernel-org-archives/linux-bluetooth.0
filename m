Return-Path: <cyrus@holtmann.org>
From: Antti =?ISO-8859-1?Q?Kaijanm=E4ki?= <antti@kaijanmaki.net>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1214806701.11537.14.camel@violet.holtmann.net>
References: <1214310088.6643.87.camel@peura.elisa-laajakaista.fi>
	<1214527364.4435.14.camel@cookie.hadess.net>
	<1214548448.6624.61.camel@peura.elisa-laajakaista.fi>
	<1214804856.7011.8.camel@peura.elisa-laajakaista.fi>
	<1214806701.11537.14.camel@violet.holtmann.net>
Content-Type: multipart/mixed; boundary="=-JFTUYMbGTUyzRu9/uUdb"
Date: Mon, 30 Jun 2008 09:57:18 +0300
Message-Id: <1214809038.7011.13.camel@peura.elisa-laajakaista.fi>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Making library out of bluez-gnome
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


--=-JFTUYMbGTUyzRu9/uUdb
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

ma, 2008-06-30 kello 08:18 +0200, Marcel Holtmann kirjoitti:
> Hi Antti,
> 
> > > Yes, true. thanks! I thought that g_value_set_string() would not make a
> > > copy of the string. I just adapted the "device-selected" property so I
> > > suppose it's also leaking memory. 
> > 
> > patch attached.
> > It's against clean CVS without my other modifications.
> 
> please resend all patches and make sure that you use the exact same
> coding style that is used in the file you modify.

done. patches attached.


> Regards
> 
> Marcel
> 
> 
> 
> -------------------------------------------------------------------------
> Check out the new SourceForge.net Marketplace.
> It's the best place to buy or sell services for
> just about anything Open Source.
> http://sourceforge.net/services/buy/index.php
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel

--=-JFTUYMbGTUyzRu9/uUdb
Content-Disposition: attachment;
	filename=add_selected_device_name_property.patch
Content-Type: text/x-patch; name=add_selected_device_name_property.patch;
	charset=utf-8
Content-Transfer-Encoding: 7bit

Index: common/bluetooth-device-selection.c
===================================================================
RCS file: /cvsroot/bluez/gnome/common/bluetooth-device-selection.c,v
retrieving revision 1.20
diff -u -p -r1.20 bluetooth-device-selection.c
--- common/bluetooth-device-selection.c	12 Mar 2008 21:03:38 -0000	1.20
+++ common/bluetooth-device-selection.c	30 Jun 2008 06:51:32 -0000
@@ -207,6 +207,22 @@ bluetooth_device_selection_get_selected_
 	return address;
 }
 
+gchar *
+bluetooth_device_selection_get_selected_device_name (BluetoothDeviceSelection *self)
+{
+	BluetoothDeviceSelectionPrivate *priv = BLUETOOTH_DEVICE_SELECTION_GET_PRIVATE(self);
+	GtkTreeIter iter;
+	gchar *name;
+	gboolean selected;
+
+	selected = gtk_tree_selection_get_selected (priv->selection, NULL, &iter);
+	if (selected == FALSE)
+		return NULL;
+
+	gtk_tree_model_get (priv->filter, &iter, COLUMN_NAME, &name, -1);
+	return name;
+}
+
 static void
 search_button_clicked (GtkButton *button, gpointer user_data)
 {
@@ -617,6 +633,7 @@ enum {
 	PROP_0,
 	PROP_TITLE,
 	PROP_DEVICE_SELECTED,
+	PROP_DEVICE_SELECTED_NAME,
 	PROP_SHOW_BONDING,
 	PROP_SHOW_SEARCH,
 	PROP_SHOW_DEVICE_TYPE,
@@ -688,6 +705,9 @@ bluetooth_device_selection_get_property 
 	case PROP_DEVICE_SELECTED:
 		g_value_set_string (value, bluetooth_device_selection_get_selected_device (self));
 		break;
+	case PROP_DEVICE_SELECTED_NAME:
+		g_value_take_string (value, bluetooth_device_selection_get_selected_device_name (self));
+		break;
 	case PROP_SHOW_BONDING:
 		g_value_set_boolean (value, priv->show_bonded);
 		break;
@@ -738,6 +758,9 @@ bluetooth_device_selection_class_init (B
 					 PROP_DEVICE_SELECTED, g_param_spec_string ("device-selected",
 										    NULL, NULL, NULL, G_PARAM_READABLE));
 	g_object_class_install_property (G_OBJECT_CLASS(klass),
+					 PROP_DEVICE_SELECTED_NAME, g_param_spec_string ("device-selected-name",
+										    NULL, NULL, NULL, G_PARAM_READABLE));
+	g_object_class_install_property (G_OBJECT_CLASS(klass),
 					 PROP_SHOW_BONDING, g_param_spec_boolean ("show-bonding",
 										  NULL, NULL, FALSE, G_PARAM_READWRITE));
 	g_object_class_install_property (G_OBJECT_CLASS(klass),

--=-JFTUYMbGTUyzRu9/uUdb
Content-Disposition: attachment;
	filename*0=fix_memory_leak_in_bluetooth_device_selection_get_property.pa;
	filename*1=tch
Content-Type: text/x-patch;
	name=fix_memory_leak_in_bluetooth_device_selection_get_property.patch;
	charset=utf-8
Content-Transfer-Encoding: 7bit

Index: common/bluetooth-device-selection.c
===================================================================
RCS file: /cvsroot/bluez/gnome/common/bluetooth-device-selection.c,v
retrieving revision 1.20
diff -u -p -r1.20 bluetooth-device-selection.c
--- common/bluetooth-device-selection.c	12 Mar 2008 21:03:38 -0000	1.20
+++ common/bluetooth-device-selection.c	30 Jun 2008 05:42:40 -0000
@@ -686,7 +686,7 @@ bluetooth_device_selection_get_property 
 
 	switch (prop_id) {
 	case PROP_DEVICE_SELECTED:
-		g_value_set_string (value, bluetooth_device_selection_get_selected_device (self));
+		g_value_take_string (value, bluetooth_device_selection_get_selected_device (self));
 		break;
 	case PROP_SHOW_BONDING:
 		g_value_set_boolean (value, priv->show_bonded);

--=-JFTUYMbGTUyzRu9/uUdb
Content-Disposition: attachment;
	filename=hide_filters_box_when_not_needed.patch
Content-Type: text/x-patch; name=hide_filters_box_when_not_needed.patch;
	charset=utf-8
Content-Transfer-Encoding: 7bit

Index: common/bluetooth-device-selection.c
===================================================================
RCS file: /cvsroot/bluez/gnome/common/bluetooth-device-selection.c,v
retrieving revision 1.20
diff -u -p -r1.20 bluetooth-device-selection.c
--- common/bluetooth-device-selection.c	12 Mar 2008 21:03:38 -0000	1.20
+++ common/bluetooth-device-selection.c	30 Jun 2008 06:45:17 -0000
@@ -62,6 +62,7 @@ struct _BluetoothDeviceSelectionPrivate 
 	GtkWidget *search_button;
 	GtkWidget *device_type_label, *device_type;
 	GtkWidget *device_category_label, *device_category;
+	GtkWidget *filters_vbox;
 
 	/* Current filter */
 	int device_type_filter;
@@ -517,7 +518,8 @@ bluetooth_device_selection_init(Bluetoot
 	vbox = gtk_vbox_new (FALSE, 6);
 	gtk_widget_show (vbox);
 	gtk_box_pack_start (GTK_BOX (self), vbox, FALSE, TRUE, 0);
-
+	priv->filters_vbox = vbox;
+	
 	/* The filters */
 	str = g_strdup_printf ("<b>%s</b>", _("Show Only Bluetooth Devices With..."));
 	label = gtk_label_new (str);
@@ -596,7 +598,11 @@ bluetooth_device_selection_init(Bluetoot
 		gtk_widget_show (priv->device_type_label);
 		gtk_widget_show (priv->device_type);
 	}
-
+	
+	/* if filters are not visible hide the vbox */
+	if (!priv->show_device_type && !priv->show_device_category)
+		gtk_widget_hide (priv->filters_vbox);
+	
 	priv->default_adapter_changed_id = g_signal_connect (priv->client, "notify::default-adapter",
 							     G_CALLBACK (default_adapter_changed), self);
 }
@@ -657,11 +663,19 @@ bluetooth_device_selection_set_property 
 		priv->show_device_type = g_value_get_boolean (value);
 		g_object_set (G_OBJECT (priv->device_type_label), "visible", priv->show_device_type, NULL);
 		g_object_set (G_OBJECT (priv->device_type), "visible", priv->show_device_type, NULL);
+		if (priv->show_device_type || priv->show_device_category)
+			g_object_set (G_OBJECT (priv->filters_vbox), "visible", TRUE, NULL);
+		else
+			g_object_set (G_OBJECT (priv->filters_vbox), "visible", FALSE, NULL);
 		break;
 	case PROP_SHOW_DEVICE_CATEGORY:
 		priv->show_device_category = g_value_get_boolean (value);
 		g_object_set (G_OBJECT (priv->device_category_label), "visible", priv->show_device_category, NULL);
 		g_object_set (G_OBJECT (priv->device_category), "visible", priv->show_device_category, NULL);
+		if (priv->show_device_type || priv->show_device_category)
+			g_object_set (G_OBJECT (priv->filters_vbox), "visible", TRUE, NULL);
+		else
+			g_object_set (G_OBJECT (priv->filters_vbox), "visible", FALSE, NULL);
 		break;
 	case PROP_DEVICE_TYPE_FILTER:
 		priv->device_type_filter = g_value_get_int (value);

--=-JFTUYMbGTUyzRu9/uUdb
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
--=-JFTUYMbGTUyzRu9/uUdb
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--=-JFTUYMbGTUyzRu9/uUdb--
