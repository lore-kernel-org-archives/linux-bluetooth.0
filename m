Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: David Woodhouse <dwmw2@infradead.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Date: Sun, 23 Sep 2007 00:38:49 +0100
Message-Id: <1190504329.7150.277.camel@pmac.infradead.org>
Mime-Version: 1.0
Subject: [Bluez-devel] Serial service support for bluez-gnome
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

This needs a little more work in the support for adding devices -- we
probably want another page in the dialog which shows the services
available on the selected device, and lets you choose which one to
connect to. I've hard-coded it to DUN for now.

It would be nicer if we could print the service ident string, and also
the friendly name of the device we're connecting to. But the former
isn't available, and for the latter I think I need to select a local
adapter to query even if I only want to take it from the cache? I
suppose I could hard-code it to hci0 but that seems a bit wrong.

diff --git a/properties/Makefile.am b/properties/Makefile.am
index 717fc16..f30b11e 100644
--- a/properties/Makefile.am
+++ b/properties/Makefile.am
@@ -4,7 +4,8 @@ bin_PROGRAMS = bluetooth-properties
 bluetooth_properties_SOURCES = main.c \
 			dialog.h dialog.c general.h general.c \
 			adapter.h adapter.c service.h service.c \
-			network.h network.c input.h input.c audio.h audio.c
+			network.h network.c input.h input.c \
+			audio.h audio.c serial.h serial.c
 
 bluetooth_properties_LDADD = $(top_builddir)/common/libcommon.a \
 			@GCONF_LIBS@ @GTK_LIBS@ @DBUS_LIBS@
diff --git a/properties/service.c b/properties/service.c
index 4a828b3..d2a52de 100644
--- a/properties/service.c
+++ b/properties/service.c
@@ -37,6 +37,7 @@
 #include "network.h"
 #include "input.h"
 #include "audio.h"
+#include "serial.h"
 
 static DBusGConnection *connection = NULL;
 static DBusGProxy *manager = NULL;
@@ -45,6 +46,7 @@ static GtkWidget *notebook;
 static GtkWidget *page_network;
 static GtkWidget *page_input;
 static GtkWidget *page_audio;
+static GtkWidget *page_serial;
 
 static GtkListStore *service_store;
 
@@ -71,6 +73,9 @@ static void show_service(const gchar *identifier)
 	if (g_ascii_strcasecmp(identifier, "audio") == 0)
 		widget = page_audio;
 
+	if (g_ascii_strcasecmp(identifier, "serial") == 0)
+		widget = page_serial;
+
 	page = gtk_notebook_page_num(GTK_NOTEBOOK(notebook), widget);
 	if (page < 0) {
 		gtk_widget_hide(notebook);
@@ -284,6 +289,9 @@ GtkWidget *create_service(void)
 	page_audio = create_audio();
 	gtk_notebook_append_page(GTK_NOTEBOOK(notebook), page_audio, NULL);
 
+	page_serial = create_serial();
+	gtk_notebook_append_page(GTK_NOTEBOOK(notebook), page_serial, NULL);
+
 	selection = gtk_tree_view_get_selection(GTK_TREE_VIEW(tree));
 	gtk_tree_selection_set_mode(selection, GTK_SELECTION_SINGLE);
 	g_signal_connect(G_OBJECT(selection), "changed",
@@ -352,6 +360,9 @@ static void service_started(DBusGProxy *object, gpointer user_data)
 
 	if (g_ascii_strcasecmp(service->identifier, "audio") == 0)
 		enable_audio(connection, busname);
+
+	if (g_ascii_strcasecmp(service->identifier, "serial") == 0)
+		enable_serial(connection, busname);
 }
 
 static void service_stopped(DBusGProxy *object, gpointer user_data)
@@ -369,6 +380,9 @@ static void service_stopped(DBusGProxy *object, gpointer user_data)
 
 	if (g_ascii_strcasecmp(service->identifier, "audio") == 0)
 		disable_audio();
+
+	if (g_ascii_strcasecmp(service->identifier, "serial") == 0)
+		disable_serial();
 }
 
 static void add_service(const char *path)
--- /dev/null	2007-09-21 01:30:37.492000000 +0100
+++ b/properties/serial.h	2007-09-23 00:13:56.000000000 +0100
@@ -0,0 +1,28 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2005-2007  Marcel Holtmann <marcel@holtmann.org>
+ *  Copyright (C) 2006-2007  Bastien Nocera <hadess@hadess.net>
+ *  Copyright (C) 2007       David Woodhouse <dwmw2@infradead.org>
+ *
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+GtkWidget *create_serial(void);
+void enable_serial(DBusGConnection *conn, const char *busname);
+void disable_serial(void);
--- /dev/null	2007-09-21 01:30:37.492000000 +0100
+++ b/properties/serial.c	2007-09-23 00:13:30.000000000 +0100
@@ -0,0 +1,387 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2005-2007  Marcel Holtmann <marcel@holtmann.org>
+ *  Copyright (C) 2006-2007  Bastien Nocera <hadess@hadess.net>
+ *  Copyright (C) 2007       David Woodhouse <dwmw2@infradead.org>
+ *
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <dbus/dbus-glib.h>
+
+#include <glib/gi18n.h>
+
+#include <gtk/gtk.h>
+
+#include "client.h"
+
+#include "general.h"
+#include "adapter.h"
+#include "dialog.h"
+#include "serial.h"
+
+static DBusGConnection *connection = NULL;
+static DBusGProxy *manager = NULL;
+static DBusGProxy *serialdevice = NULL;
+
+static GtkListStore *store = NULL;
+static GtkWidget *tree = NULL;
+static GtkWidget *button_remove;
+
+static void proxy_callback(DBusGProxy *proxy,
+				DBusGProxyCall *call, void *user_data)
+{
+	GError *error = NULL;
+	GtkWidget *notebook = user_data;
+	GtkWidget *button;
+	GtkWidget *label;
+	DBusGProxy *client;
+	const char *path, *busname;
+	const char *address = NULL, *device = NULL;
+	gchar *text;
+
+	g_object_set_data(G_OBJECT(notebook), "call", NULL);
+
+	dbus_g_proxy_end_call(proxy, call, &error,
+			      G_TYPE_STRING, &path, G_TYPE_INVALID);
+
+	button = g_object_get_data(G_OBJECT(notebook), "cancel");
+	gtk_widget_hide(button);
+
+	button = g_object_get_data(G_OBJECT(notebook), "close");
+	gtk_widget_set_sensitive(button, TRUE);
+
+	label = g_object_get_data(G_OBJECT(notebook), "label");
+
+	if (error) {
+		text = g_strdup_printf("<b>%s: %s</b>",
+				       _("Connection failed"), error->message);
+		gtk_label_set_markup(GTK_LABEL(label), text);
+		g_free(text);
+		return;
+	}
+
+	busname = dbus_g_proxy_get_bus_name(proxy);
+
+	client = dbus_g_proxy_new_for_name(connection, busname,
+					path, "org.bluez.serial.Port");
+
+	dbus_g_proxy_call(client, "GetAddress", NULL, G_TYPE_INVALID,
+				G_TYPE_STRING, &address, G_TYPE_INVALID);
+
+	dbus_g_proxy_call(client, "GetDevice", NULL, G_TYPE_INVALID,
+				G_TYPE_STRING, &device, G_TYPE_INVALID);
+
+	text = g_strdup_printf("<b>%s %s %s</b>",
+			       address, _("connected as"), device);
+	gtk_label_set_markup(GTK_LABEL(label), text);
+	g_free(text);
+
+	//	set_trusted(adapter, address);
+
+	g_object_unref(client);
+}
+
+static void connect_callback(const gchar *address, gpointer user_data)
+{
+	DBusGProxyCall *call;
+
+	call = dbus_g_proxy_begin_call(manager, "CreatePort",
+				proxy_callback, user_data, NULL,
+				G_TYPE_STRING, address, 
+			        G_TYPE_STRING, "dun", G_TYPE_INVALID);
+
+	g_object_set_data(G_OBJECT(user_data), "call", call);
+}
+
+static void cleanup_callback(gpointer user_data)
+{
+	DBusGProxyCall *call;
+
+	call = g_object_get_data(G_OBJECT(user_data), "call");
+	if (call != NULL)
+		dbus_g_proxy_cancel_call(manager, call);
+
+	g_object_set_data(G_OBJECT(user_data), "call", NULL);
+}
+
+static gboolean device_filter(GtkTreeModel *model,
+				GtkTreeIter *iter, gpointer user_data)
+{
+	gboolean active;
+	guint type;
+
+	gtk_tree_model_get(model, iter, COLUMN_ACTIVE, &active,
+						COLUMN_TYPE, &type, -1);
+
+	if (active == FALSE)
+		return FALSE;
+
+	if (type == BLUETOOTH_TYPE_PHONE || type == BLUETOOTH_TYPE_MODEM)
+		return TRUE;
+
+	return FALSE;
+}
+
+static void create_callback(GtkWidget *button, gpointer user_data)
+{
+	show_device_dialog(connect_callback, cleanup_callback, device_filter);
+}
+
+static void remove_callback(GtkWidget *button, gpointer user_data)
+{
+	GtkTreeSelection *selection = user_data;
+	GtkTreeModel *model;
+	GtkTreeIter iter;
+	gchar *path;
+
+	if (show_remove_dialog() == FALSE)
+		return;
+
+	gtk_tree_selection_get_selected(selection, &model, &iter);
+
+	gtk_tree_model_get(model, &iter, 0, &path, -1);
+
+	dbus_g_proxy_call(manager, "RemovePort", NULL,
+			G_TYPE_STRING, path, G_TYPE_INVALID, G_TYPE_INVALID);
+
+	g_free(path);
+}
+
+static void select_callback(GtkTreeSelection *selection, gpointer user_data)
+{
+	gboolean selected;
+
+	selected = gtk_tree_selection_get_selected(selection, NULL, NULL);
+
+	gtk_widget_set_sensitive(button_remove, selected);
+}
+
+GtkWidget *create_serial(void)
+{
+	GtkWidget *vbox;
+	GtkWidget *label;
+	GtkWidget *scrolled;
+	GtkTreeViewColumn *column;
+	GtkTreeSelection *selection;
+	GtkWidget *buttonbox;
+	GtkWidget *button;
+
+	vbox = gtk_vbox_new(FALSE, 6);
+
+	label = create_label(_("Serial devices"));
+	gtk_box_pack_start(GTK_BOX(vbox), label, FALSE, FALSE, 0);
+
+	scrolled = gtk_scrolled_window_new(NULL, NULL);
+	gtk_scrolled_window_set_policy(GTK_SCROLLED_WINDOW(scrolled),
+				GTK_POLICY_AUTOMATIC, GTK_POLICY_AUTOMATIC);
+	gtk_scrolled_window_set_shadow_type(GTK_SCROLLED_WINDOW(scrolled),
+							GTK_SHADOW_OUT);
+	gtk_container_add(GTK_CONTAINER(vbox), scrolled);
+
+	tree = gtk_tree_view_new();
+	gtk_tree_view_set_headers_visible(GTK_TREE_VIEW(tree), FALSE);
+	gtk_tree_view_set_rules_hint(GTK_TREE_VIEW(tree), TRUE);
+	gtk_tree_view_set_model(GTK_TREE_VIEW(tree), GTK_TREE_MODEL(store));
+
+	gtk_tree_view_insert_column_with_attributes(GTK_TREE_VIEW(tree), 0,
+					"Name", gtk_cell_renderer_text_new(),
+							"text", 1, NULL);
+	gtk_tree_view_insert_column_with_attributes(GTK_TREE_VIEW(tree), 0,
+					"Name", gtk_cell_renderer_text_new(),
+							"text", 2, NULL);
+	column = gtk_tree_view_get_column(GTK_TREE_VIEW(tree), 0);
+	gtk_tree_view_column_set_expand(GTK_TREE_VIEW_COLUMN(column), TRUE);
+
+	gtk_container_add(GTK_CONTAINER(scrolled), tree);
+
+	selection = gtk_tree_view_get_selection(GTK_TREE_VIEW(tree));
+	gtk_tree_selection_set_mode(selection, GTK_SELECTION_SINGLE);
+	g_signal_connect(G_OBJECT(selection), "changed",
+				G_CALLBACK(select_callback), NULL);
+
+	buttonbox = gtk_hbutton_box_new();
+	gtk_button_box_set_layout(GTK_BUTTON_BOX(buttonbox),
+						GTK_BUTTONBOX_START);
+	gtk_box_set_spacing(GTK_BOX(buttonbox), 6);
+	gtk_box_set_homogeneous(GTK_BOX(buttonbox), FALSE);
+	gtk_box_pack_start(GTK_BOX(vbox), buttonbox, FALSE, FALSE, 0);
+
+	button = gtk_button_new_from_stock(GTK_STOCK_ADD);
+	gtk_container_add(GTK_CONTAINER(buttonbox), button);
+
+	g_signal_connect(G_OBJECT(button), "clicked",
+				G_CALLBACK(create_callback), NULL);
+
+	button = gtk_button_new_from_stock(GTK_STOCK_REMOVE);
+	gtk_widget_set_sensitive(GTK_WIDGET(button), FALSE);
+	gtk_container_add(GTK_CONTAINER(buttonbox), button);
+
+	button_remove = button;
+
+	g_signal_connect(G_OBJECT(button), "clicked",
+				G_CALLBACK(remove_callback), selection);
+
+	gtk_widget_show_all(vbox);
+
+	return vbox;
+}
+
+static void add_device(const char *busname, const char *path)
+{
+	DBusGProxy *proxy;
+	const char *address = NULL, *device = NULL;
+	GtkTreeIter iter;
+
+	proxy = dbus_g_proxy_new_for_name(connection, busname,
+					path, "org.bluez.serial.Port");
+
+	dbus_g_proxy_call(proxy, "GetAddress", NULL, G_TYPE_INVALID,
+				G_TYPE_STRING, &address, G_TYPE_INVALID);
+
+	dbus_g_proxy_call(proxy, "GetDevice", NULL, G_TYPE_INVALID,
+				G_TYPE_STRING, &device, G_TYPE_INVALID);
+
+	gtk_list_store_insert_with_values(store, &iter, -1,
+					  0, path, 1, address, 2, device,
+					  -1);
+
+	g_object_unref(proxy);
+}
+
+static void device_created(DBusGProxy *object,
+				const char *path, gpointer user_data)
+{
+	const char *busname;
+
+	busname = dbus_g_proxy_get_bus_name(object);
+
+	add_device(busname, path);
+}
+
+static void device_removed(DBusGProxy *object,
+				const char *path, gpointer user_data)
+{
+	GtkTreeIter iter;
+	gboolean cont;
+
+	cont = gtk_tree_model_get_iter_first(GTK_TREE_MODEL(store), &iter);
+
+	while (cont == TRUE) {
+		gchar *temp;
+
+		gtk_tree_model_get(GTK_TREE_MODEL(store), &iter, 0, &temp, -1);
+
+		if (g_ascii_strcasecmp(path, temp) == 0) {
+			gtk_list_store_remove(store, &iter);
+			g_free(temp);
+			break;
+		}
+
+		g_free(temp);
+
+		cont = gtk_tree_model_iter_next(GTK_TREE_MODEL(store), &iter);
+	}
+}
+
+static void list_devices(DBusGProxy *object,
+				DBusGProxyCall *call, void *user_data)
+{
+	GError *error = NULL;
+	const gchar **array = NULL;
+	const char *busname;
+
+	dbus_g_proxy_end_call(object, call, &error,
+					G_TYPE_STRV, &array, G_TYPE_INVALID);
+
+	if (error == NULL) {
+		busname = dbus_g_proxy_get_bus_name(object);
+
+		while (*array) {
+			add_device(busname, *array);
+			array++;
+		}
+	} else
+		g_error_free(error);
+}
+
+void enable_serial(DBusGConnection *conn, const char *busname)
+{
+	store = gtk_list_store_new(3, G_TYPE_STRING, G_TYPE_STRING,
+				   G_TYPE_STRING);
+	if (store == NULL)
+		return;
+
+	if (tree != NULL)
+		gtk_tree_view_set_model(GTK_TREE_VIEW(tree),
+						GTK_TREE_MODEL(store));
+
+	manager = dbus_g_proxy_new_for_name(conn, busname,
+				"/org/bluez/serial", "org.bluez.serial.Manager");
+
+	if (manager == NULL)
+		return;
+
+	connection = dbus_g_connection_ref(conn);
+
+	dbus_g_proxy_add_signal(manager, "PortCreated",
+					G_TYPE_STRING, G_TYPE_INVALID);
+
+	dbus_g_proxy_connect_signal(manager, "PortCreated",
+				G_CALLBACK(device_created), NULL, NULL);
+
+	dbus_g_proxy_add_signal(manager, "PortRemoved",
+					G_TYPE_STRING, G_TYPE_INVALID);
+
+	dbus_g_proxy_connect_signal(manager, "PortRemoved",
+				G_CALLBACK(device_removed), NULL, NULL);
+
+	dbus_g_proxy_begin_call(manager, "ListPorts", list_devices,
+						NULL, NULL, G_TYPE_INVALID);
+}
+
+void disable_serial(void)
+{
+	if (tree != NULL)
+		gtk_tree_view_set_model(GTK_TREE_VIEW(tree), NULL);
+
+	if (store != NULL) {
+		g_object_unref(store);
+		store = NULL;
+	}
+
+	if (manager != NULL) {
+		g_object_unref(manager);
+		manager = NULL;
+	}
+
+	if (serialdevice != NULL) {
+		g_object_unref(serialdevice);
+		serialdevice = NULL;
+	}
+
+	if (connection != NULL) {
+		dbus_g_connection_unref(connection);
+		connection = NULL;
+	}
+}


-- 
dwmw2


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
