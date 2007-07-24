Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Bastien Nocera <hadess@hadess.net>
To: BlueZ Hackers <bluez-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="=-D/kdSBEvVX2x1jRaUGH5"
Date: Tue, 24 Jul 2007 17:27:35 +0100
Message-Id: <1185294455.3641.141.camel@cookie.hadess.net>
Mime-Version: 1.0
Subject: [Bluez-devel] [PATCH] add device selector widget
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


--=-D/kdSBEvVX2x1jRaUGH5
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

It's a first draft of the device selector widget, which I'd like to use
in the applet for gnome-vfs obexftp browsing, and in the wizard. Tadas
can probably use it for the obex sending program as well.

The test program shows how to use it. The API is dead simple.

I also want to add a "Search" button, to restart a discovery, and combo
boxes at the top of it to filter the type/class of device (known,
recently used, recently discovered, and printer/phone/etc.).

Big patch, but not really any other way to do it...

-- 
Bastien Nocera <hadess@hadess.net> 

--=-D/kdSBEvVX2x1jRaUGH5
Content-Disposition: attachment;
	filename=bluez-gnome-add-device-selector-widget.patch
Content-Type: text/x-patch; name=bluez-gnome-add-device-selector-widget.patch;
	charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

diff --git a/common/Makefile.am b/common/Makefile.am
index 4795991..2242e79 100644
--- a/common/Makefile.am
+++ b/common/Makefile.am
@@ -2,7 +2,8 @@
 noinst_LIBRARIES = libcommon.a
 
 libcommon_a_SOURCES = client.h client.c \
-		device-store.h device-store.c
+		device-store.h device-store.c \
+		device-selector.c device-selector.h
 
 AM_CFLAGS = @DBUS_CFLAGS@ @GTK_CFLAGS@
 
@@ -13,12 +14,14 @@ nodist_libcommon_a_SOURCES = $(BUILT_SOURCES)
 
 CLEANFILES = $(BUILT_SOURCES)
 
-noinst_PROGRAMS = test-client test-agent
+noinst_PROGRAMS = test-client test-agent test-deviceselector
 
 test_client_LDADD = libcommon.a @GTK_LIBS@ @DBUS_LIBS@
 
 test_agent_LDADD = libcommon.a @DBUS_LIBS@
 
+test_deviceselector_LDADD = libcommon.a @GTK_LIBS@ @DBUS_LIBS@
+
 EXTRA_DIST = marshal.list dbus.xml passkey-agent.xml auth-agent.xml
 
 MAINTAINERCLEANFILES = Makefile.in
diff --git a/common/device-selector.c b/common/device-selector.c
new file mode 100644
index 0000000..607a46f
--- /dev/null
+++ b/common/device-selector.c
@@ -0,0 +1,294 @@
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
+#include "device-selector.h"
+
+#define BLUETOOTH_DEVICE_SELECTOR_GET_PRIVATE(obj) (G_TYPE_INSTANCE_GET_PRIVATE((obj), \
+				BLUETOOTH_TYPE_DEVICE_SELECTOR, BluetoothDeviceSelectorPrivate))
+
+typedef struct _BluetoothDeviceSelectorPrivate BluetoothDeviceSelectorPrivate;
+
+struct _BluetoothDeviceSelectorPrivate {
+	BluetoothClient *client;
+	GtkTreeSelection *selection;
+	GtkTreeModel *model;
+	GtkWidget *label;
+};
+
+G_DEFINE_TYPE(BluetoothDeviceSelector, bluetooth_device_selector, GTK_TYPE_VBOX)
+
+static void name_to_text(GtkTreeViewColumn *column, GtkCellRenderer *cell,
+			GtkTreeModel *model, GtkTreeIter *iter, gpointer data)
+{
+	gchar *address;
+	gchar *name;
+
+	gtk_tree_model_get(model, iter, COLUMN_ADDRESS, &address,
+			   COLUMN_NAME, &name, -1);
+
+	if (name == NULL) {
+		//FIXME see below
+		name = g_strdup(address);
+	}
+
+	//FIXME modify address to have "-" instead of ":"
+	g_object_set(cell, "text", name ? name : address, NULL);
+
+	g_free(name);
+	g_free(address);
+}
+
+static void type_to_icon(GtkTreeViewColumn *column, GtkCellRenderer *cell,
+			GtkTreeModel *model, GtkTreeIter *iter, gpointer data)
+{
+	guint type;
+
+	gtk_tree_model_get(model, iter, COLUMN_TYPE, &type, -1);
+
+	switch (type) {
+	case BLUETOOTH_TYPE_PHONE:
+		g_object_set(cell, "icon-name", "stock_cell-phone", NULL);
+		break;
+	case BLUETOOTH_TYPE_MODEM:
+		g_object_set(cell, "icon-name", "modem", NULL);
+		break;
+	case BLUETOOTH_TYPE_COMPUTER:
+		g_object_set(cell, "icon-name", "computer", NULL);
+		break;
+	case BLUETOOTH_TYPE_NETWORK:
+		g_object_set(cell, "icon-name", "network-wireless", NULL);
+		break;
+	case BLUETOOTH_TYPE_HEADSET:
+		g_object_set(cell, "icon-name", "stock_headphones", NULL);
+		break;
+	case BLUETOOTH_TYPE_KEYBOARD:
+		g_object_set(cell, "icon-name", "input-keyboard", NULL);
+		break;
+	case BLUETOOTH_TYPE_MOUSE:
+		g_object_set(cell, "icon-name", "input-mouse", NULL);
+		break;
+	case BLUETOOTH_TYPE_CAMERA:
+		g_object_set(cell, "icon-name", "camera-photo", NULL);
+		break;
+	case BLUETOOTH_TYPE_PRINTER:
+		g_object_set(cell, "icon-name", "printer", NULL);
+		break;
+	default:
+		g_object_set(cell, "icon-name", "stock_bluetooth", NULL);
+		break;
+	}
+}
+
+static void type_to_text(GtkTreeViewColumn *column, GtkCellRenderer *cell,
+			GtkTreeModel *model, GtkTreeIter *iter, gpointer data)
+{
+	guint type;
+
+	gtk_tree_model_get(model, iter, COLUMN_TYPE, &type, -1);
+
+	g_object_set(cell, "text", bluetooth_type_to_string(type), NULL);
+}
+
+static void select_browse_device_callback(GtkTreeSelection *selection, gpointer user_data)
+{
+	BluetoothDeviceSelector *self = user_data;
+
+	g_object_notify(G_OBJECT(self), "device-selected");
+}
+
+static void bluetooth_device_selector_init(BluetoothDeviceSelector *self)
+{
+	BluetoothDeviceSelectorPrivate *priv = BLUETOOTH_DEVICE_SELECTOR_GET_PRIVATE(self);
+	GtkWidget *tree, *scrolled;
+	GtkCellRenderer *renderer;
+	GtkTreeViewColumn *column;
+
+	gtk_box_set_spacing(GTK_BOX(self), 6);
+	gtk_box_set_homogeneous(GTK_BOX(self), FALSE);
+	gtk_container_set_border_width(GTK_CONTAINER(self), 8);
+
+	priv->label = gtk_label_new(NULL);
+	gtk_misc_set_alignment(GTK_MISC(priv->label), 0, 0);
+	gtk_box_pack_start(GTK_BOX(self), priv->label, FALSE, FALSE, 0);
+	gtk_widget_show(priv->label);
+
+	priv->client = bluetooth_client_new();
+
+	//FIXME add a frame around it
+	/* Create the scrolled window */
+	scrolled = gtk_scrolled_window_new(NULL, NULL);
+
+	gtk_scrolled_window_set_policy(GTK_SCROLLED_WINDOW(scrolled),
+				       GTK_POLICY_AUTOMATIC, GTK_POLICY_AUTOMATIC);
+
+	gtk_scrolled_window_set_shadow_type(GTK_SCROLLED_WINDOW(scrolled),
+					    GTK_SHADOW_OUT);
+
+	/* Create the tree view */
+	tree = gtk_tree_view_new();
+
+	gtk_tree_view_set_headers_visible(GTK_TREE_VIEW(tree), TRUE);
+
+	gtk_tree_view_set_rules_hint(GTK_TREE_VIEW(tree), TRUE);
+
+	g_object_set(tree, "show-expanders", FALSE, NULL);
+
+	column = gtk_tree_view_column_new();
+
+	gtk_tree_view_column_set_title(column, _("Device"));
+
+	renderer = gtk_cell_renderer_pixbuf_new();
+	gtk_tree_view_column_set_spacing(column, 4);
+	gtk_tree_view_column_pack_start(column, renderer, FALSE);
+
+	gtk_tree_view_column_set_cell_data_func(column, renderer,
+						type_to_icon, NULL, NULL);
+
+	renderer = gtk_cell_renderer_text_new();
+	gtk_tree_view_column_pack_start(column, renderer, TRUE);
+
+	gtk_tree_view_column_set_cell_data_func(column, renderer,
+						name_to_text, NULL, NULL);
+
+	gtk_tree_view_append_column(GTK_TREE_VIEW(tree), column);
+
+	gtk_tree_view_column_set_min_width(GTK_TREE_VIEW_COLUMN(column), 280);
+
+	gtk_tree_view_insert_column_with_data_func(GTK_TREE_VIEW(tree), -1,
+					"Type", gtk_cell_renderer_text_new(),
+						type_to_text, NULL, NULL);
+
+	priv->selection = gtk_tree_view_get_selection(GTK_TREE_VIEW(tree));
+
+	gtk_tree_selection_set_mode(priv->selection, GTK_SELECTION_SINGLE);
+
+	g_signal_connect(G_OBJECT(priv->selection), "changed",
+			 G_CALLBACK(select_browse_device_callback), self);
+
+	priv->model = bluetooth_client_get_model_for_adapter(priv->client, NULL);
+
+	gtk_tree_view_set_model(GTK_TREE_VIEW(tree), priv->model);
+
+	g_object_unref(priv->model);
+
+	bluetooth_client_discover_devices(priv->client, NULL);
+
+	gtk_container_add(GTK_CONTAINER(scrolled), tree);
+	gtk_container_add(GTK_CONTAINER(self), scrolled);
+	gtk_widget_show_all(scrolled);
+}
+
+static void bluetooth_device_selector_finalize(GObject *object)
+{
+	BluetoothDeviceSelectorPrivate *priv = BLUETOOTH_DEVICE_SELECTOR_GET_PRIVATE(object);
+
+	bluetooth_client_cancel_discovery(priv->client, NULL);
+}
+
+enum {
+	PROP_0,
+	PROP_TITLE,
+	PROP_DEVICE_SELECTED
+};
+
+static void bluetooth_device_selector_set_property(GObject *object, guint prop_id,
+					const GValue *value, GParamSpec *pspec)
+{
+	BluetoothDeviceSelectorPrivate *priv = BLUETOOTH_DEVICE_SELECTOR_GET_PRIVATE(object);
+
+	switch (prop_id) {
+	case PROP_TITLE:
+		{
+			char *str;
+			str = g_strdup_printf("<b>%s</b>", g_value_get_string(value));
+			gtk_label_set_markup(GTK_LABEL(priv->label), str);
+			g_free(str);
+		}
+		break;
+	default:
+		G_OBJECT_WARN_INVALID_PROPERTY_ID(object, prop_id, pspec);
+		break;
+	}
+}
+
+static void bluetooth_device_selector_get_property(GObject *object, guint prop_id,
+					GValue *value, GParamSpec *pspec)
+{
+	BluetoothDeviceSelectorPrivate *priv = BLUETOOTH_DEVICE_SELECTOR_GET_PRIVATE(object);
+
+	switch (prop_id) {
+	case PROP_DEVICE_SELECTED:
+		{
+			GtkTreeIter iter;
+			gboolean selected;
+
+			selected = gtk_tree_selection_get_selected(priv->selection, NULL, &iter);
+			if (selected == FALSE) {
+				g_value_set_string(value, NULL);
+			} else {
+				char *address;
+
+				gtk_tree_model_get(priv->model, &iter, COLUMN_ADDRESS, &address, -1);
+				g_value_take_string(value, address);
+			}
+		}
+		break;
+	default:
+		G_OBJECT_WARN_INVALID_PROPERTY_ID(object, prop_id, pspec);
+		break;
+	}
+}
+
+static void bluetooth_device_selector_class_init(BluetoothDeviceSelectorClass *klass)
+{
+	g_type_class_add_private(klass, sizeof(BluetoothDeviceSelectorPrivate));
+
+	G_OBJECT_CLASS(klass)->finalize = bluetooth_device_selector_finalize;
+
+	G_OBJECT_CLASS(klass)->set_property = bluetooth_device_selector_set_property;
+	G_OBJECT_CLASS(klass)->get_property = bluetooth_device_selector_get_property;
+
+	g_object_class_install_property(G_OBJECT_CLASS(klass),
+				PROP_TITLE, g_param_spec_string("title",
+					NULL, NULL, NULL, G_PARAM_WRITABLE));
+	g_object_class_install_property(G_OBJECT_CLASS(klass),
+				PROP_DEVICE_SELECTED, g_param_spec_string("device-selected",
+					NULL, NULL, NULL, G_PARAM_READABLE));
+}
+
+GtkWidget *bluetooth_device_selector_new(const gchar *title)
+{
+	return g_object_new(BLUETOOTH_TYPE_DEVICE_SELECTOR,
+			    "title", title,
+			    NULL);
+}
+
diff --git a/common/device-selector.h b/common/device-selector.h
new file mode 100644
index 0000000..c30138b
--- /dev/null
+++ b/common/device-selector.h
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
+#ifndef __BLUETOOTH_DEVICE_SELECTOR_H
+#define __BLUETOOTH_DEVICE_SELECTOR_H
+
+#include <gtk/gtkvbox.h>
+
+G_BEGIN_DECLS
+
+#define BLUETOOTH_TYPE_DEVICE_SELECTOR (bluetooth_device_selector_get_type())
+#define BLUETOOTH_DEVICE_SELECTOR(obj) (G_TYPE_CHECK_INSTANCE_CAST((obj), \
+				BLUETOOTH_TYPE_DEVICE_SELECTOR, BluetoothDeviceSelector))
+#define BLUETOOTH_DEVICE_SELECTOR_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST((klass), \
+				BLUETOOTH_TYPE_DEVICE_SELECTOR, BluetoothDeviceSelectorClass))
+#define BLUETOOTH_IS_DEVICE_SELECTOR(obj) (G_TYPE_CHECK_INSTANCE_TYPE((obj), \
+						BLUETOOTH_TYPE_DEVICE_SELECTOR))
+#define BLUETOOTH_IS_DEVICE_SELECTOR_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE((klass), \
+						BLUETOOTH_TYPE_DEVICE_SELECTOR))
+#define BLUETOOTH_GET_DEVICE_SELECTOR_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS((obj), \
+				BLUETOOTH_TYPE_DEVICE_SELECTOR, BluetoothDeviceSelectorClass))
+
+typedef struct _BluetoothDeviceSelector BluetoothDeviceSelector;
+typedef struct _BluetoothDeviceSelectorClass BluetoothDeviceSelectorClass;
+
+struct _BluetoothDeviceSelector {
+	GtkVBox parent;
+};
+
+struct _BluetoothDeviceSelectorClass {
+	GtkVBoxClass parent_class;
+};
+
+GType bluetooth_device_selector_get_type(void);
+
+GtkWidget *bluetooth_device_selector_new(const gchar *title);
+
+G_END_DECLS
+
+#endif /* __BLUETOOTH_DEVICE_SELECTOR_H */
diff --git a/common/test-deviceselector.c b/common/test-deviceselector.c
new file mode 100644
index 0000000..fff93cf
--- /dev/null
+++ b/common/test-deviceselector.c
@@ -0,0 +1,53 @@
+
+#include <gtk/gtk.h>
+#include "device-selector.h"
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
+	selector = bluetooth_device_selector_new("Select a device to setup");
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
diff --git a/po/POTFILES.in b/po/POTFILES.in
index 6b352f8..eb98361 100644
--- a/po/POTFILES.in
+++ b/po/POTFILES.in
@@ -1,5 +1,6 @@
 applet/main.c
 applet/bluetooth-applet.desktop.in
+common/device-selector.c
 properties/main.c
 properties/bluetooth-properties.desktop.in
 wizard/main.c


--=-D/kdSBEvVX2x1jRaUGH5
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
--=-D/kdSBEvVX2x1jRaUGH5
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--=-D/kdSBEvVX2x1jRaUGH5--
