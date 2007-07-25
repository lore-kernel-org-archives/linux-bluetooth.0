Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Bastien Nocera <hadess@hadess.net>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1185351983.7111.114.camel@violet>
References: <1185294455.3641.141.camel@cookie.hadess.net>
	<1185350671.7111.108.camel@violet>
	<1185351259.3641.228.camel@cookie.hadess.net>
	<1185351983.7111.114.camel@violet>
Content-Type: multipart/mixed; boundary="=-1r57R1hgsX1HSTdAKN8g"
Date: Wed, 25 Jul 2007 10:37:32 +0100
Message-Id: <1185356252.3641.236.camel@cookie.hadess.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] [PATCH] add device selector widget
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


--=-1r57R1hgsX1HSTdAKN8g
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, 2007-07-25 at 10:26 +0200, Marcel Holtmann wrote:
> Hi Bastien,
> 
> > > To shorten the widget names. We might better use _not_ the "Chooser"
> > > word since it looks like Gtk compat stuff because the other name was
> > > already taken by an older widget.
> > 
> > fair enough.
> > 
> > > So BluetoothDeviceButton, BluetoothDeviceSelection and
> > > BluetoothDeviceSelectionDialog might be appropriate. What do you think?
> > 
> > I'm not sure about the dialogue widgets, as I said, but the button and
> > the chooser widget would be very useful. Not convinced about the adapter
> > selector either though.
> 
> if we need a dialog for the button anyway, we can even provide it as a
> widget. Shouldn't be that much work, right? However we can fix the
> dialog part later on. The widget itself has to come first anyway.

It's just that the amount of code needed to customise the dialogue for
the need of the app (as in "Connect" button, title, selecting which
drop-downs to show) would be really close to creating a new dialogue.

I expect most applications to use the button selection widget anyway,
and for things like the wizard to use the treeview.

> The device selection widget is more important than an adapter selection
> widget, but I see the need for it since it wraps around D-Bus and allows
> us not to worry about the details. However there are use cases for the
> adapter selection. I have at least one when it comes to the Bluetooth
> Analyzer application and its planned live import support. And on the
> other hand we have that information inside the model anyway. Only need
> to export them into a combo box or tree view.

Ha. Yes, does have its uses. I can certainly hack on something like
that.

Here's an updated patch to common/, with the new widget name. I added
the bluetooth- to the filenames, as it's the GNOME way to show the whole
namespace in the header filename.

I think we'll need some changes to the client for when there's no
default adapter (ie. no adapter) and we show the widget, then plug in an
adapter. Any ideas how you would want that implemented?

Cheers

-- 
Bastien Nocera <hadess@hadess.net> 

--=-1r57R1hgsX1HSTdAKN8g
Content-Disposition: attachment;
	filename=bluez-gnome-add-device-selector-widget-2.patch
Content-Type: text/x-patch; name=bluez-gnome-add-device-selector-widget-2.patch;
	charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Index: Makefile.am
===================================================================
RCS file: /cvsroot/bluez/gnome/common/Makefile.am,v
retrieving revision 1.14
diff -u -p -r1.14 Makefile.am
--- Makefile.am	4 Apr 2007 19:02:31 -0000	1.14
+++ Makefile.am	25 Jul 2007 09:23:24 -0000
@@ -2,7 +2,8 @@
 noinst_LIBRARIES = libcommon.a
 
 libcommon_a_SOURCES = client.h client.c \
-		device-store.h device-store.c
+		device-store.h device-store.c \
+		bluetooth-device-selection.c bluetooth-device-selection.h
 
 AM_CFLAGS = @DBUS_CFLAGS@ @GTK_CFLAGS@
 
@@ -13,12 +14,14 @@ nodist_libcommon_a_SOURCES = $(BUILT_SOU
 
 CLEANFILES = $(BUILT_SOURCES)
 
-noinst_PROGRAMS = test-client test-agent
+noinst_PROGRAMS = test-client test-agent test-deviceselection
 
 test_client_LDADD = libcommon.a @GTK_LIBS@ @DBUS_LIBS@
 
 test_agent_LDADD = libcommon.a @DBUS_LIBS@
 
+test_deviceselection_LDADD = libcommon.a @GTK_LIBS@ @DBUS_LIBS@
+
 EXTRA_DIST = marshal.list dbus.xml passkey-agent.xml auth-agent.xml
 
 MAINTAINERCLEANFILES = Makefile.in
--- /dev/null	2007-07-22 16:17:31.708395854 +0100
+++ test-deviceselection.c	2007-07-25 10:22:23.000000000 +0100
@@ -0,0 +1,53 @@
+
+#include <gtk/gtk.h>
+#include "bluetooth-device-selection.h"
+
+static void device_selected_cb(GObject *object, GParamSpec *spec, gpointer user_data)
+{
+	GtkDialog *dialog = user_data;
+	char *address;
+
+	g_object_get(object, "device-selected", &address, NULL);
+	gtk_dialog_set_response_sensitive(dialog, GTK_RESPONSE_ACCEPT, address != NULL);
+	g_free(address);
+}
+
+int main(int argc, char **argv)
+{
+	GtkWidget *dialog, *selector;
+	int response;
+
+	gtk_init(&argc, &argv);
+
+	dialog = gtk_dialog_new_with_buttons("Browse devices",
+					     NULL,
+					     GTK_DIALOG_NO_SEPARATOR,
+					     GTK_STOCK_CANCEL,
+					     GTK_RESPONSE_REJECT,
+					     GTK_STOCK_CONNECT,
+					     GTK_RESPONSE_ACCEPT,
+					     NULL);
+	gtk_dialog_set_response_sensitive(dialog, GTK_RESPONSE_ACCEPT, FALSE);
+	gtk_window_set_default_size(GTK_WINDOW(dialog), 400, 300);
+
+	selector = bluetooth_device_selection_new("Select a device to setup");
+	g_signal_connect(selector, "notify::device-selected",
+			 G_CALLBACK(device_selected_cb), dialog);
+	gtk_container_add(GTK_CONTAINER(GTK_DIALOG(dialog)->vbox), selector);
+	gtk_widget_show_all(dialog);
+
+	response = gtk_dialog_run(GTK_DIALOG(dialog));
+
+	if (response == GTK_RESPONSE_ACCEPT) {
+		char *address;
+
+		g_object_get(selector, "device-selected", &address, NULL);
+		g_message("Selected device is: %s", address);
+		g_free(address);
+	}
+
+	gtk_widget_destroy(dialog);
+
+	return 0;
+}
+
--- /dev/null	2007-07-22 16:17:31.708395854 +0100
+++ bluetooth-device-selection.h	2007-07-25 10:19:41.000000000 +0100
@@ -0,0 +1,61 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2005-2007  Marcel Holtmann <marcel@holtmann.org>
+ *  Copyright (C) 2007       Bastien Nocera <hadess@hadess.net>
+ *
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+#ifndef __BLUETOOTH_DEVICE_SELECTION_H
+#define __BLUETOOTH_DEVICE_SELECTION_H
+
+#include <gtk/gtkvbox.h>
+
+G_BEGIN_DECLS
+
+#define BLUETOOTH_TYPE_DEVICE_SELECTOR (bluetooth_device_selection_get_type())
+#define BLUETOOTH_DEVICE_SELECTION(obj) (G_TYPE_CHECK_INSTANCE_CAST((obj), \
+				BLUETOOTH_TYPE_DEVICE_SELECTOR, BluetoothDeviceSelection))
+#define BLUETOOTH_DEVICE_SELECTION_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST((klass), \
+				BLUETOOTH_TYPE_DEVICE_SELECTOR, BluetoothDeviceSelectionClass))
+#define BLUETOOTH_IS_DEVICE_SELECTOR(obj) (G_TYPE_CHECK_INSTANCE_TYPE((obj), \
+						BLUETOOTH_TYPE_DEVICE_SELECTOR))
+#define BLUETOOTH_IS_DEVICE_SELECTOR_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE((klass), \
+						BLUETOOTH_TYPE_DEVICE_SELECTOR))
+#define BLUETOOTH_GET_DEVICE_SELECTOR_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS((obj), \
+				BLUETOOTH_TYPE_DEVICE_SELECTOR, BluetoothDeviceSelectionClass))
+
+typedef struct _BluetoothDeviceSelection BluetoothDeviceSelection;
+typedef struct _BluetoothDeviceSelectionClass BluetoothDeviceSelectionClass;
+
+struct _BluetoothDeviceSelection {
+	GtkVBox parent;
+};
+
+struct _BluetoothDeviceSelectionClass {
+	GtkVBoxClass parent_class;
+};
+
+GType bluetooth_device_selection_get_type (void);
+
+GtkWidget *bluetooth_device_selection_new (const gchar *title);
+
+G_END_DECLS
+
+#endif /* __BLUETOOTH_DEVICE_SELECTION_H */
--- /dev/null	2007-07-22 16:17:31.708395854 +0100
+++ bluetooth-device-selection.c	2007-07-25 10:26:14.000000000 +0100
@@ -0,0 +1,295 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2005-2007  Marcel Holtmann <marcel@holtmann.org>
+ *  Copyright (C) 2007       Bastien Nocera <hadess@hadess.net>
+ *
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+#include "config.h"
+
+#include <gtk/gtk.h>
+
+#include <glib/gi18n-lib.h>
+
+#include "client.h"
+#include "manager.h"
+#include "bluetooth-device-selection.h"
+
+#define BLUETOOTH_DEVICE_SELECTION_GET_PRIVATE(obj) (G_TYPE_INSTANCE_GET_PRIVATE((obj), \
+										 BLUETOOTH_TYPE_DEVICE_SELECTOR, BluetoothDeviceSelectionPrivate))
+
+typedef struct _BluetoothDeviceSelectionPrivate BluetoothDeviceSelectionPrivate;
+
+struct _BluetoothDeviceSelectionPrivate {
+	BluetoothClient *client;
+	GtkTreeSelection *selection;
+	GtkTreeModel *model;
+	GtkWidget *label;
+};
+
+G_DEFINE_TYPE(BluetoothDeviceSelection, bluetooth_device_selection, GTK_TYPE_VBOX)
+
+static void name_to_text (GtkTreeViewColumn *column, GtkCellRenderer *cell,
+			  GtkTreeModel *model, GtkTreeIter *iter, gpointer data)
+{
+	gchar *address;
+	gchar *name;
+
+	gtk_tree_model_get (model, iter, COLUMN_ADDRESS, &address,
+			    COLUMN_NAME, &name, -1);
+
+	/* If we don't have a name, replace the name with the
+	 * Bluetooth address, with the ":" replaced by "-" */
+	if (name == NULL) {
+		name = g_strdup (address);
+		g_strdelimit (address, ":", '-');
+	}
+
+	g_object_set (cell, "text", name ? name : address, NULL);
+
+	g_free (name);
+	g_free (address);
+}
+
+static void type_to_icon (GtkTreeViewColumn *column, GtkCellRenderer *cell,
+			  GtkTreeModel *model, GtkTreeIter *iter, gpointer data)
+{
+	guint type;
+
+	gtk_tree_model_get (model, iter, COLUMN_TYPE, &type, -1);
+
+	switch (type) {
+	case BLUETOOTH_TYPE_PHONE:
+		g_object_set (cell, "icon-name", "stock_cell-phone", NULL);
+		break;
+	case BLUETOOTH_TYPE_MODEM:
+		g_object_set (cell, "icon-name", "modem", NULL);
+		break;
+	case BLUETOOTH_TYPE_COMPUTER:
+		g_object_set (cell, "icon-name", "computer", NULL);
+		break;
+	case BLUETOOTH_TYPE_NETWORK:
+		g_object_set (cell, "icon-name", "network-wireless", NULL);
+		break;
+	case BLUETOOTH_TYPE_HEADSET:
+		g_object_set (cell, "icon-name", "stock_headphones", NULL);
+		break;
+	case BLUETOOTH_TYPE_KEYBOARD:
+		g_object_set (cell, "icon-name", "input-keyboard", NULL);
+		break;
+	case BLUETOOTH_TYPE_MOUSE:
+		g_object_set (cell, "icon-name", "input-mouse", NULL);
+		break;
+	case BLUETOOTH_TYPE_CAMERA:
+		g_object_set (cell, "icon-name", "camera-photo", NULL);
+		break;
+	case BLUETOOTH_TYPE_PRINTER:
+		g_object_set (cell, "icon-name", "printer", NULL);
+		break;
+	default:
+		g_object_set (cell, "icon-name", "stock_bluetooth", NULL);
+		break;
+	}
+}
+
+static void type_to_text (GtkTreeViewColumn *column, GtkCellRenderer *cell,
+			  GtkTreeModel *model, GtkTreeIter *iter, gpointer data)
+{
+	guint type;
+
+	gtk_tree_model_get (model, iter, COLUMN_TYPE, &type, -1);
+
+	g_object_set (cell, "text", bluetooth_type_to_string (type), NULL);
+}
+
+static void select_browse_device_callback (GtkTreeSelection *selection, gpointer user_data)
+{
+	BluetoothDeviceSelection *self = user_data;
+
+	g_object_notify (G_OBJECT(self), "device-selected");
+}
+
+static void bluetooth_device_selection_init(BluetoothDeviceSelection *self)
+{
+	BluetoothDeviceSelectionPrivate *priv = BLUETOOTH_DEVICE_SELECTION_GET_PRIVATE(self);
+	GtkWidget *tree, *scrolled;
+	GtkCellRenderer *renderer;
+	GtkTreeViewColumn *column;
+
+	gtk_box_set_spacing (GTK_BOX(self), 6);
+	gtk_box_set_homogeneous (GTK_BOX(self), FALSE);
+	gtk_container_set_border_width (GTK_CONTAINER(self), 8);
+
+	priv->label = gtk_label_new (NULL);
+	gtk_misc_set_alignment (GTK_MISC(priv->label), 0, 0);
+	gtk_box_pack_start (GTK_BOX(self), priv->label, FALSE, FALSE, 0);
+	gtk_widget_show (priv->label);
+
+	priv->client = bluetooth_client_new ();
+
+	//FIXME add a frame around it
+	/* Create the scrolled window */
+	scrolled = gtk_scrolled_window_new (NULL, NULL);
+
+	gtk_scrolled_window_set_policy (GTK_SCROLLED_WINDOW(scrolled),
+					GTK_POLICY_AUTOMATIC, GTK_POLICY_AUTOMATIC);
+
+	gtk_scrolled_window_set_shadow_type (GTK_SCROLLED_WINDOW(scrolled),
+					     GTK_SHADOW_OUT);
+
+	/* Create the tree view */
+	tree = gtk_tree_view_new ();
+
+	gtk_tree_view_set_headers_visible (GTK_TREE_VIEW(tree), TRUE);
+
+	gtk_tree_view_set_rules_hint (GTK_TREE_VIEW(tree), TRUE);
+
+	g_object_set (tree, "show-expanders", FALSE, NULL);
+
+	column = gtk_tree_view_column_new ();
+
+	gtk_tree_view_column_set_title (column, _("Device"));
+
+	renderer = gtk_cell_renderer_pixbuf_new ();
+	gtk_tree_view_column_set_spacing (column, 4);
+	gtk_tree_view_column_pack_start (column, renderer, FALSE);
+
+	gtk_tree_view_column_set_cell_data_func (column, renderer,
+						 type_to_icon, NULL, NULL);
+
+	renderer = gtk_cell_renderer_text_new ();
+	gtk_tree_view_column_pack_start (column, renderer, TRUE);
+
+	gtk_tree_view_column_set_cell_data_func (column, renderer,
+						 name_to_text, NULL, NULL);
+
+	gtk_tree_view_append_column (GTK_TREE_VIEW(tree), column);
+
+	gtk_tree_view_column_set_min_width (GTK_TREE_VIEW_COLUMN(column), 280);
+
+	gtk_tree_view_insert_column_with_data_func (GTK_TREE_VIEW(tree), -1,
+						    "Type", gtk_cell_renderer_text_new(),
+						    type_to_text, NULL, NULL);
+
+	priv->selection = gtk_tree_view_get_selection (GTK_TREE_VIEW(tree));
+
+	gtk_tree_selection_set_mode (priv->selection, GTK_SELECTION_SINGLE);
+
+	g_signal_connect (G_OBJECT(priv->selection), "changed",
+			  G_CALLBACK(select_browse_device_callback), self);
+
+	priv->model = bluetooth_client_get_model_for_adapter (priv->client, NULL);
+	if (priv->model) {
+		gtk_tree_view_set_model (GTK_TREE_VIEW(tree), priv->model);
+		g_object_unref (priv->model);
+	}
+
+	bluetooth_client_discover_devices (priv->client, NULL);
+
+	gtk_container_add (GTK_CONTAINER(scrolled), tree);
+	gtk_container_add (GTK_CONTAINER(self), scrolled);
+	gtk_widget_show_all (scrolled);
+}
+
+static void bluetooth_device_selection_finalize (GObject *object)
+{
+	BluetoothDeviceSelectionPrivate *priv = BLUETOOTH_DEVICE_SELECTION_GET_PRIVATE(object);
+
+	bluetooth_client_cancel_discovery (priv->client, NULL);
+}
+
+enum {
+	PROP_0,
+	PROP_TITLE,
+	PROP_DEVICE_SELECTED
+};
+
+static void bluetooth_device_selection_set_property (GObject *object, guint prop_id,
+						     const GValue *value, GParamSpec *pspec)
+{
+	BluetoothDeviceSelectionPrivate *priv = BLUETOOTH_DEVICE_SELECTION_GET_PRIVATE(object);
+
+	switch (prop_id) {
+	case PROP_TITLE:
+		{
+			char *str;
+			str = g_strdup_printf ("<b>%s</b>", g_value_get_string(value));
+			gtk_label_set_markup (GTK_LABEL(priv->label), str);
+			g_free (str);
+		}
+		break;
+	default:
+		G_OBJECT_WARN_INVALID_PROPERTY_ID(object, prop_id, pspec);
+		break;
+	}
+}
+
+static void bluetooth_device_selection_get_property (GObject *object, guint prop_id,
+						     GValue *value, GParamSpec *pspec)
+{
+	BluetoothDeviceSelectionPrivate *priv = BLUETOOTH_DEVICE_SELECTION_GET_PRIVATE(object);
+
+	switch (prop_id) {
+	case PROP_DEVICE_SELECTED:
+		{
+			GtkTreeIter iter;
+			gboolean selected;
+
+			selected = gtk_tree_selection_get_selected (priv->selection, NULL, &iter);
+			if (selected == FALSE) {
+				g_value_set_string (value, NULL);
+			} else {
+				char *address;
+
+				gtk_tree_model_get (priv->model, &iter, COLUMN_ADDRESS, &address, -1);
+				g_value_take_string (value, address);
+			}
+		}
+		break;
+	default:
+		G_OBJECT_WARN_INVALID_PROPERTY_ID(object, prop_id, pspec);
+		break;
+	}
+}
+
+static void bluetooth_device_selection_class_init (BluetoothDeviceSelectionClass *klass)
+{
+	g_type_class_add_private(klass, sizeof(BluetoothDeviceSelectionPrivate));
+
+	G_OBJECT_CLASS(klass)->finalize = bluetooth_device_selection_finalize;
+
+	G_OBJECT_CLASS(klass)->set_property = bluetooth_device_selection_set_property;
+	G_OBJECT_CLASS(klass)->get_property = bluetooth_device_selection_get_property;
+
+	g_object_class_install_property (G_OBJECT_CLASS(klass),
+					 PROP_TITLE, g_param_spec_string ("title",
+									  NULL, NULL, NULL, G_PARAM_WRITABLE));
+	g_object_class_install_property (G_OBJECT_CLASS(klass),
+					 PROP_DEVICE_SELECTED, g_param_spec_string ("device-selected",
+										    NULL, NULL, NULL, G_PARAM_READABLE));
+}
+
+GtkWidget *bluetooth_device_selection_new (const gchar *title)
+{
+	return g_object_new(BLUETOOTH_TYPE_DEVICE_SELECTOR,
+			    "title", title,
+			    NULL);
+}
+

--=-1r57R1hgsX1HSTdAKN8g
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
--=-1r57R1hgsX1HSTdAKN8g
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--=-1r57R1hgsX1HSTdAKN8g--
