Return-Path: <cyrus@holtmann.org>
From: Bastien Nocera <hadess@hadess.net>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1201871693.2389.326.camel@cookie.hadess.net>
References: <1200566602.26259.89.camel@cookie.hadess.net>
	<1200663790.2676.3.camel@cookie.hadess.net>
	<1201871693.2389.326.camel@cookie.hadess.net>
Content-Type: multipart/mixed; boundary="=-JGhenognbsXTZgRvSjU9"
Date: Fri, 01 Feb 2008 16:08:50 +0000
Message-Id: <1201882130.2389.334.camel@cookie.hadess.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] [PATCH] Allow multiple files to be sent
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


--=-JGhenognbsXTZgRvSjU9
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


On Fri, 2008-02-01 at 13:14 +0000, Bastien Nocera wrote:
> On Fri, 2008-01-18 at 13:43 +0000, Bastien Nocera wrote:
> > Hello again,
> > 
> > On Thu, 2008-01-17 at 10:43 +0000, Bastien Nocera wrote: 
> > > Heya,
> > > 
> > > Another for bluetooth-sento feature parity with gnome-obex-send.
> > 
> > Another patch, based on Tadas' gnome-obex-send port.
> > 
> > - Fix to run with the latest obex-data-server (in 2 places)
> > - Add an appropriate error when the target device is a Palm
> > - Accept relative local paths and URIs as well as absolute filenames as
> > arguments (needed for ease of use and nautilus-sendto, respectively)
> > - Gather the name of the Bluetooth device from hcid to show in the UI
> 
> Updated patch to use the marshal file in common/ instead of our own.

Updated patch:
- follow coding style
- move the helper dialogues in another file

Cheers

--=-JGhenognbsXTZgRvSjU9
Content-Disposition: attachment; filename=bluez-gnome-new-sendto-3.patch
Content-Type: text/x-patch; name=bluez-gnome-new-sendto-3.patch;
	charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Index: Makefile.am
===================================================================
RCS file: /cvsroot/bluez/gnome/sendto/Makefile.am,v
retrieving revision 1.8
diff -u -p -r1.8 Makefile.am
--- Makefile.am	1 Feb 2008 14:03:47 -0000	1.8
+++ Makefile.am	1 Feb 2008 16:04:22 -0000
@@ -1,7 +1,7 @@
 
 noinst_PROGRAMS = bluetooth-sendto
 
-bluetooth_sendto_SOURCES = main.c
+bluetooth_sendto_SOURCES = main.c utils.c utils.h
 
 bluetooth_sendto_LDADD = $(top_builddir)/common/libcommon.a \
 					@GTK_LIBS@ @DBUS_LIBS@
@@ -15,3 +15,4 @@ noinst_MANS = bluetooth-sendto.1
 EXTRA_DIST = $(noinst_MANS)
 
 MAINTAINERCLEANFILES = Makefile.in
+
Index: main.c
===================================================================
RCS file: /cvsroot/bluez/gnome/sendto/main.c,v
retrieving revision 1.12
diff -u -p -r1.12 main.c
--- main.c	16 Jan 2008 19:13:39 -0000	1.12
+++ main.c	1 Feb 2008 16:04:22 -0000
@@ -1,9 +1,11 @@
 /*
+ * bluetooth-sendto
  *
  *  BlueZ - Bluetooth protocol stack for Linux
  *
  *  Copyright (C) 2005-2007  Marcel Holtmann <marcel@holtmann.org>
- *
+ *  Copyright (C) 2006-2007 Tadas Dailyda <tadas@dailyda.com>
+ *  Copyright (C) 2007 Bastien Nocera <hadess@hadess.net>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
@@ -25,342 +27,765 @@
 #include <config.h>
 #endif
 
-#include <dbus/dbus-glib.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/time.h>
+#include <sys/types.h>
 
+#include <dbus/dbus-glib.h>
+#include <glib.h>
 #include <glib/gi18n.h>
-
+#include <glib/gstdio.h>
 #include <gtk/gtk.h>
 
-#include "bluetooth-device-selection.h"
-
+#include "dbus-glue.h"
 #include "marshal.h"
+#include "utils.h"
 
-static DBusGConnection *conn = NULL;
+typedef struct _appinfo {
+	/* DBus */
+	DBusGConnection *connection;
+	DBusGProxy *manager_proxy;
+	DBusGProxy *session_proxy;
+	/* GTK */
+	GtkWidget *main_dialog;
+	GtkWidget *from_label;
+	GtkWidget *operation_label;
+	GtkWidget *progress_bar;
+	/* sending related */
+	gsize file_length;
+	guint file_count;
+	guint current_file;
+	GSList *file_list;
+	guint byte_count;
+	guint bytes_sent;
+	gint64 first_transfer_time;
+	gint64 last_update_time;
+} BluetoothSendto;
+
+typedef enum {
+	BUTTONS_OK,
+	BUTTONS_RETRY_CANCEL,
+	BUTTONS_RETRY_SKIP_CANCEL
+} ButtonSet;
+
+static gchar **files_to_send = NULL;
+static gchar *bdaddrstr = NULL;
+static gchar *device_name = NULL;
+
+#define DIALOG_RESPONSE_SKIP 1
+#define DIALOG_RESPONSE_RETRY 2
+
+static void error_occurred_cb(DBusGProxy *proxy, const gchar *error_name,
+			      const gchar *error_message, BluetoothSendto *app);
+
+static const GOptionEntry options[] = {
+	{"dest", 'd', 0, G_OPTION_ARG_STRING, &bdaddrstr, 
+		"Bluetooth address of destination device", "BDADDR"},
+	{G_OPTION_REMAINING, '\0', 0, G_OPTION_ARG_FILENAME_ARRAY, &files_to_send},
+	{NULL}
+};
 
-static GtkWidget *dialog;
-static GtkWidget *label_filename;
-static GtkWidget *label_status;
-static GtkWidget *progress;
+static gint64
+get_system_time(void)
+{
+	struct timeval tmp;
 
-static gint filesize = -1;
+	gettimeofday(&tmp, NULL);
+	return (gint64)tmp.tv_usec + (gint64)tmp.tv_sec * G_GINT64_CONSTANT(1000000);
+}
 
-static gchar *open_file_dialog(void)
+static gboolean
+is_palm_device(const gchar *bdaddr)
 {
-	GtkWidget *dialog;
-	gchar *filename = NULL;
+	return (g_str_has_prefix(bdaddr, "00:04:6B")
+		|| g_str_has_prefix(bdaddr, "00:07:E0")
+		|| g_str_has_prefix(bdaddr, "00:0E:20"));
+}
 
-	dialog = gtk_file_chooser_dialog_new(_("Select File"), NULL,
-				GTK_FILE_CHOOSER_ACTION_OPEN,
-				GTK_STOCK_CANCEL, GTK_RESPONSE_CANCEL,
-				GTK_STOCK_OPEN, GTK_RESPONSE_ACCEPT, NULL);
+/* Return the local absolute filename for the file, and its size
+ * if the file exists and is stat()'able */
+static gchar *
+normalise_filename(const gchar *filename, gint64 *size)
+{
+	char *ret;
+	struct stat file_stat;
 
-	if (gtk_dialog_run(GTK_DIALOG(dialog)) == GTK_RESPONSE_ACCEPT)
-		filename = gtk_file_chooser_get_filename(GTK_FILE_CHOOSER(dialog));
+	g_return_val_if_fail(filename != NULL, NULL);
+	g_return_val_if_fail(size != NULL, NULL);
 
-	gtk_widget_destroy(dialog);
+	if (g_str_has_prefix(filename, "file://")) {
+		ret = g_filename_from_uri(filename, NULL, NULL);
+		if (ret == NULL)
+			return NULL;
+	} else if (filename[0] == '/') {
+		ret = g_strdup(filename);
+	} else {
+		gchar *curdir;
 
-	return filename;
-}
+		curdir = g_get_current_dir();
+		ret = g_build_filename(curdir, filename, NULL);
+		g_free(curdir);
+	}
 
-static void selected_device_changed(BluetoothDeviceSelection *selector,
-					gchar *address, gpointer user_data)
-{
-	GtkWidget *dialog = user_data;
+	if (!g_file_test(ret, G_FILE_TEST_IS_REGULAR)) {
+		g_free(ret);
+		return NULL;
+	}
+
+	if (!g_stat(ret, &file_stat)) {
+		*size = file_stat.st_size;
+	} else {
+		g_free(ret);
+		return NULL;
+	}
 
-	gtk_dialog_set_response_sensitive(GTK_DIALOG(dialog),
-				GTK_RESPONSE_ACCEPT, address != NULL);
+	return ret;
 }
 
-static gchar *browse_device_dialog(void)
+static gchar *
+get_device_name(BluetoothSendto *app)
 {
-	GtkWidget *dialog;
-	GtkWidget *selector;
-	gchar *address = NULL;
+	DBusGConnection *connection;
+	DBusGProxy *manager;
+	GError *error = NULL;
+	gchar *name, **adapters;
+	guint i;
 
-	dialog = gtk_dialog_new_with_buttons(_("Select Device"),
-				NULL, GTK_DIALOG_NO_SEPARATOR,
-				GTK_STOCK_CANCEL, GTK_RESPONSE_REJECT,
-				GTK_STOCK_CONNECT, GTK_RESPONSE_ACCEPT, NULL);
+	name = NULL;
 
-	gtk_dialog_set_response_sensitive(GTK_DIALOG(dialog),
-						GTK_RESPONSE_ACCEPT, FALSE);
+	connection = dbus_g_bus_get(DBUS_BUS_SYSTEM, NULL);
+	if (connection == NULL)
+		return NULL;
+
+	manager = dbus_g_proxy_new_for_name(connection, "org.bluez",
+					    "/org/bluez", "org.bluez.Manager");
+	if (!manager) {
+		dbus_g_connection_unref(connection);
+		return NULL;
+	}
 
-	gtk_window_set_default_size(GTK_WINDOW(dialog), 450, 300);
+	if (!manager_list_adapters(manager, &adapters, &error)) {
+		g_object_unref(manager);
+		dbus_g_connection_unref(connection);
+		return NULL;
+	}
 
-	gtk_container_set_border_width(GTK_CONTAINER(dialog), 6);
+	for (i = 0; adapters[i] != NULL; i++) {
+		DBusGProxy *adapter;
 
-	selector = bluetooth_device_selection_new(_("Select destination device"));
+		adapter = dbus_g_proxy_new_for_name(connection, "org.bluez",
+						    adapters[i], "org.bluez.Adapter");
+		if (dbus_g_proxy_call(adapter, "GetRemoteName", NULL,
+				      G_TYPE_STRING, bdaddrstr, G_TYPE_INVALID,
+				      G_TYPE_STRING, &name, G_TYPE_INVALID)) {
+			if (name != NULL && name[0] != '\0') {
+				g_object_unref(adapter);
+				break;
+			}
+		}
+		g_object_unref(adapter);
+	}
 
-	gtk_container_add(GTK_CONTAINER(GTK_DIALOG(dialog)->vbox), selector);
+	g_object_unref(manager);
+	dbus_g_connection_unref(connection);
 
-	g_signal_connect(selector, "selected-device-changed",
-				G_CALLBACK(selected_device_changed), dialog);
+	return name;
+}
 
-	gtk_widget_show_all(selector);
+static gint
+show_error_dialog(GtkWindow *parent, ButtonSet buttons,
+		  const gchar *primary_text, const gchar *secondary_text)
+{
+	GtkWidget *dialog;
+	gchar *primary_text_markup;
+	gint ret;
 
-	if (gtk_dialog_run(GTK_DIALOG(dialog)) == GTK_RESPONSE_ACCEPT)
-		g_object_get(selector, "device-selected", &address, NULL);
+	primary_text_markup = g_strdup_printf("<span weight=\"bold\" size=\"larger\">%s</span>", 
+					      primary_text);
+	dialog = gtk_message_dialog_new_with_markup(parent, 0, GTK_MESSAGE_ERROR, 
+						    buttons==BUTTONS_OK? GTK_BUTTONS_OK: GTK_BUTTONS_CANCEL, 
+						    primary_text_markup);
+	gtk_message_dialog_format_secondary_text(GTK_MESSAGE_DIALOG(dialog),
+						 secondary_text);
+	if (buttons == BUTTONS_RETRY_SKIP_CANCEL) {
+		gtk_dialog_add_button(GTK_DIALOG(dialog), _("Skip"),
+				      DIALOG_RESPONSE_SKIP);
+	}
+	if (buttons != BUTTONS_OK) {
+		gtk_dialog_add_button(GTK_DIALOG(dialog), _("Retry"),
+				      DIALOG_RESPONSE_RETRY);
+	}
+	ret = gtk_dialog_run(GTK_DIALOG(dialog));
 
 	gtk_widget_destroy(dialog);
+	g_free(primary_text_markup);
+	return ret;
+}
 
-	return address;
+static gint
+show_connection_error_dialog(GtkWindow *parent, const gchar *bdaddr,
+			     const gchar *primary_text)
+{
+	if (!is_palm_device(bdaddrstr)) {
+		return show_error_dialog(parent,
+					 BUTTONS_RETRY_CANCEL,
+					 primary_text,
+					 _("Make sure that remote device is on and that it accepts Bluetooth connections."));
+	} else {
+		return show_error_dialog(parent,
+					 BUTTONS_RETRY_CANCEL,
+					 primary_text,
+					 _("Make sure \"Beam receive\" is enabled in the Power preferences, and Bluetooth is enabled, on your Palm device."));
+	}
 }
 
-static void response_callback(GtkWidget *dialog,
-					gint response, gpointer user_data)
-{
-	gtk_widget_destroy(dialog);
+static gint
+handle_file_sending_error(const gchar *error_text,
+			  const gchar *error_secondary_text, BluetoothSendto *app)
+{
+	ButtonSet buttons;
+	gint response_id;
+
+	if (app->file_count > 1 && app->current_file < app->file_count - 1)
+		buttons = BUTTONS_RETRY_SKIP_CANCEL;
+	else
+		buttons = BUTTONS_RETRY_CANCEL;
+
+	response_id = show_error_dialog(GTK_WINDOW(app->main_dialog), buttons, 
+					error_text, error_secondary_text);
+
+	switch (response_id) {
+	case DIALOG_RESPONSE_SKIP:
+		app->current_file++;
+		app->bytes_sent += app->file_length;
+	case DIALOG_RESPONSE_RETRY:
+		return TRUE;
+	case GTK_RESPONSE_CANCEL:
+	default:
+		gtk_main_quit();
+		break;
+	}
+	return response_id;
+}
 
+static void
+cancel_clicked_cb(GtkWidget *button, BluetoothSendto *app)
+{
 	gtk_main_quit();
 }
 
-static void create_window(const gchar *filename)
+static void
+ui_init(BluetoothSendto *app)
 {
-	GtkWidget *vbox;
-	GtkWidget *label;
+	GtkWidget *vbox, *vbox_parent, *table;
+	GtkWidget *label1, *label2, *label3, *target_label, *from_label, *operation_label;
+	GtkWidget *progress_bar, *button;
 	gchar *text;
 
-	dialog = gtk_dialog_new_with_buttons(_("File Transfer"), NULL,
-				GTK_DIALOG_NO_SEPARATOR,
-				GTK_STOCK_CLOSE, GTK_RESPONSE_CLOSE, NULL);
-
-	gtk_window_set_default_size(GTK_WINDOW(dialog), 400, -1);
-
-	gtk_container_set_border_width(GTK_CONTAINER(dialog), 6);
-
-	vbox = gtk_vbox_new(FALSE, 6);
-	gtk_container_set_border_width(GTK_CONTAINER(vbox), 12);
-	gtk_container_add(GTK_CONTAINER(GTK_DIALOG(dialog)->vbox), vbox);
-
-	label = gtk_label_new(NULL);
-	gtk_misc_set_alignment(GTK_MISC(label), 0.0, 0.0);
-	gtk_box_pack_start(GTK_BOX(vbox), label, FALSE, FALSE, 0);
+	/* initialize UI */
 
-	label_filename = label;
+	device_name = get_device_name(app);
 
-	progress = gtk_progress_bar_new();
-	gtk_box_pack_start(GTK_BOX(vbox), progress, FALSE, FALSE, 0);
-
-	label = gtk_label_new(NULL);
-	gtk_misc_set_alignment(GTK_MISC(label), 0.0, 0.0);
-	gtk_box_pack_start(GTK_BOX(vbox), label, FALSE, FALSE, 6);
-
-	label_status = label;
+	/* main dialog */
+	app->main_dialog = gtk_dialog_new();
+	gtk_dialog_set_has_separator(GTK_DIALOG(app->main_dialog), FALSE);
+	gtk_window_set_title(GTK_WINDOW(app->main_dialog),
+			     _("Bluetooth file transfer"));
+	gtk_window_set_icon_name(GTK_WINDOW(app->main_dialog), "stock_bluetooth");
+	gtk_window_set_type_hint(GTK_WINDOW(app->main_dialog),
+				 GDK_WINDOW_TYPE_HINT_NORMAL);
+	gtk_window_set_position(GTK_WINDOW(app->main_dialog), GTK_WIN_POS_CENTER);
+	gtk_window_set_resizable(GTK_WINDOW(app->main_dialog), FALSE);
+	gtk_widget_set(app->main_dialog, "width-request", 400, NULL);
+	button = gtk_dialog_add_button(GTK_DIALOG(app->main_dialog),
+				       GTK_STOCK_CANCEL,
+				       GTK_RESPONSE_CANCEL);
+	g_signal_connect(G_OBJECT(button), "clicked",
+			 G_CALLBACK(cancel_clicked_cb), app);
+	gtk_container_set_border_width(GTK_CONTAINER(app->main_dialog), 6);
+
+	/* table elements */
+	from_label = gtk_label_new(NULL);
+	gtk_misc_set_alignment(GTK_MISC(from_label), 0, 0.5);
+	gtk_label_set_ellipsize(GTK_LABEL(from_label), PANGO_ELLIPSIZE_MIDDLE);
+	target_label = gtk_label_new(NULL);
+	gtk_misc_set_alignment(GTK_MISC(target_label), 0, 0.5);
+	gtk_label_set_ellipsize(GTK_LABEL(target_label), PANGO_ELLIPSIZE_END);
+	gtk_label_set_text(GTK_LABEL(target_label), device_name ? device_name : bdaddrstr);
+	label2 = gtk_label_new(NULL);
+	text = g_markup_printf_escaped("<b>%s</b>", _("From:"));
+	gtk_label_set_markup(GTK_LABEL(label2), text);
+	g_free(text);
+	label3 = gtk_label_new(NULL);
+	gtk_misc_set_alignment(GTK_MISC(label3), 1, 0.5);
+	text = g_markup_printf_escaped("<b>%s</b>", _("To:"));
+	gtk_label_set_markup(GTK_LABEL(label3), text);
+	g_free(text);
 
-	text = g_strdup_printf("<b>%s</b>", filename);
-	gtk_label_set_markup(GTK_LABEL(label_filename), text);
+	/* table */
+	table = gtk_table_new(2, 2, FALSE);
+	gtk_table_set_col_spacings(GTK_TABLE(table), 4);
+	gtk_table_set_row_spacings(GTK_TABLE(table), 4);
+	gtk_table_attach_defaults(GTK_TABLE(table), from_label, 1, 2, 0, 1);
+	gtk_table_attach_defaults(GTK_TABLE(table), target_label, 1, 2, 1, 2);
+	gtk_table_attach(GTK_TABLE(table), label2, 0, 1, 0, 1, GTK_FILL, 0, 0, 0);
+	gtk_table_attach(GTK_TABLE(table), label3, 0, 1, 1, 2, GTK_FILL, 0, 0, 0);
+
+	/* vbox elements */
+	label1 = gtk_label_new(NULL);
+	gtk_misc_set_alignment(GTK_MISC(label1), 0, 0.5);
+	text = g_markup_printf_escaped("<span weight=\"bold\" size=\"larger\">%s</span>",
+				       _("Sending files via bluetooth"));
+	gtk_label_set_markup(GTK_LABEL(label1), text);
 	g_free(text);
+	progress_bar = gtk_progress_bar_new();
+	gtk_progress_bar_set_ellipsize(GTK_PROGRESS_BAR(progress_bar),
+				       PANGO_ELLIPSIZE_END);
+	gtk_progress_bar_set_text(GTK_PROGRESS_BAR(progress_bar),
+				  _("Connecting..."));
+	operation_label = gtk_label_new(NULL);
+	gtk_misc_set_alignment(GTK_MISC(operation_label), 0, 0.5);
+	gtk_label_set_ellipsize(GTK_LABEL(operation_label), PANGO_ELLIPSIZE_END);
+
+	/* vbox */
+	vbox = gtk_vbox_new(FALSE, 0);
+	gtk_box_set_spacing(GTK_BOX(vbox), 6);
+	gtk_container_set_border_width(GTK_CONTAINER(vbox), 6);
+	gtk_box_pack_start_defaults(GTK_BOX(vbox), label1);
+	gtk_box_pack_start(GTK_BOX(vbox), table, TRUE, TRUE, 9);
+	gtk_box_pack_start_defaults(GTK_BOX(vbox), progress_bar);
+	gtk_box_pack_start(GTK_BOX(vbox), operation_label, TRUE, TRUE, 2);
+	vbox_parent = gtk_bin_get_child(GTK_BIN(app->main_dialog));
+	gtk_box_pack_start_defaults(GTK_BOX(vbox_parent), vbox);
+
+	/* Set widget variables in app */
+	app->from_label = from_label;
+	app->operation_label = operation_label;
+	app->progress_bar = progress_bar;
+
+	/* show it */
+	gtk_widget_show_all(app->main_dialog);
+}
+
+static gboolean
+send_one(BluetoothSendto *app)
+{
+	const gchar *fname;
+	gint ret;
+	gchar *bname, *dirname;
+	GError *err = NULL;
+	gchar *operation_text, *operation_markup, *progressbar_text;
+
+	if ((fname = g_slist_nth_data(app->file_list, app->current_file))) {
+		/* there's a file to send */
+		dbus_g_proxy_call(app->session_proxy, "SendFile", &err,
+				  G_TYPE_STRING, fname, G_TYPE_INVALID, G_TYPE_INVALID);
+
+		if (err != NULL) {
+			ret = handle_file_sending_error(_("Unable to read file"),
+							err->message, app);
+			if (ret != GTK_RESPONSE_CANCEL) {
+				g_idle_add((GSourceFunc) send_one, app);
+			}
+			g_error_free(err);
+			return FALSE;
+		}
 
-	gtk_label_set_markup(GTK_LABEL(label_status), _("Connecting..."));
+		if (!app->first_transfer_time) {
+			app->first_transfer_time = get_system_time();
+		}
+		bname = g_path_get_basename(fname);
+		dirname = g_path_get_dirname(fname);
 
-	gtk_dialog_set_response_sensitive(GTK_DIALOG(dialog),
-						GTK_RESPONSE_CLOSE, FALSE);
+		operation_text = g_strdup_printf(_("Sending %s"), bname);
+		operation_markup = g_markup_printf_escaped("<i>%s</i>", operation_text);
+		progressbar_text = g_strdup_printf(_("Sending file: %d of %d"),
+						   app->current_file+1,
+						   app->file_count);
+		gtk_label_set_text(GTK_LABEL(app->from_label), dirname);
+		gtk_label_set_markup(GTK_LABEL(app->operation_label), operation_markup);
+		gtk_progress_bar_set_text(GTK_PROGRESS_BAR(app->progress_bar),
+					  progressbar_text);
+
+		g_free(bname);
+		g_free(dirname);
+		g_free(operation_text);
+		g_free(operation_markup);
+		g_free(progressbar_text);
+	} else {
+		/* nothing left to send, time to quit */
+		gtk_main_quit();
+	}
+	return FALSE;
+}
 
-	g_signal_connect(G_OBJECT(dialog), "response",
-				G_CALLBACK(response_callback), NULL);
+static void
+session_connected_cb(DBusGProxy *proxy, BluetoothSendto *app)
+{
+	/* OBEX connect has succeeded, so start sending */
+	g_idle_add((GSourceFunc) send_one, app);
+}
 
-	gtk_widget_show_all(dialog);
+static void
+transfer_started_cb(DBusGProxy *proxy, const gchar *filename,
+		    const gchar *local_path, gint byte_count, BluetoothSendto *app)
+{
+	app->file_length = byte_count;
 }
 
-static void transfer_started(DBusGProxy *proxy, gchar *a, gchar *b,
-						gint size, gpointer user_data)
+static void
+transfer_cancelled_cb(DBusGProxy *proxy, BluetoothSendto *app)
 {
-	gchar *text;
+	gint ret;
+	gchar *error_text;
 
-	filesize = size;
+	error_text = g_strdup_printf(_("An error occured while sending file '%s'"),
+				     (gchar *)g_slist_nth_data(app->file_list, app->current_file));
+	ret = handle_file_sending_error(error_text,
+					_("The remote device cancelled the transfer"), app);
 
-	text = g_strdup_printf(_("Starting transfer of %d bytes"), size);
-	gtk_label_set_markup(GTK_LABEL(label_status), text);
-	g_free(text);
+	if (ret != GTK_RESPONSE_CANCEL)
+		g_idle_add((GSourceFunc) send_one, app);
 
-	gtk_progress_bar_set_fraction(GTK_PROGRESS_BAR(progress), 0.0);
+	g_free(error_text);
 }
 
-static void transfer_progress(DBusGProxy *proxy, guint bytes, gpointer user_data)
+static void
+transfer_progress_cb(DBusGProxy *proxy, gint bytes_transferred, BluetoothSendto *app)
 {
-	gchar *text;
-	gdouble fraction;
+	gdouble frac;
+	guint actual_bytes_sent;
+	gint elapsed_time;
+	gint transfer_rate;
+	gint time_remaining;
+	gint64 current_time;
+	gchar *str, *str2;
+	gchar *progressbar_text;
 
-	text = g_strdup_printf(_("Transfered %d of %d bytes"), bytes, filesize);
-	gtk_label_set_markup(GTK_LABEL(label_status), text);
-	g_free(text);
+	/* update progress bar fraction */
+	actual_bytes_sent = app->bytes_sent + bytes_transferred;
+	frac = (gdouble)actual_bytes_sent / app->byte_count;
+	gtk_progress_bar_set_fraction(GTK_PROGRESS_BAR(app->progress_bar), frac);
 
-	fraction = (gdouble) bytes / (gdouble) filesize;
-	gtk_progress_bar_set_fraction(GTK_PROGRESS_BAR(progress), fraction);
-}
+	/* update progress bar text (time remaining)
+	 * (only update once in a second) */
+	current_time = get_system_time();
+	elapsed_time = (current_time - app->first_transfer_time) / 1000000;
 
-static void transfer_completed(DBusGProxy *proxy, gpointer user_data)
-{
-	gtk_label_set_markup(GTK_LABEL(label_status), _("Completed"));
+	if (app->last_update_time) {
+		if (current_time < app->last_update_time + 1000000)
+			return;
+		else
+			app->last_update_time = current_time;
+	} else {
+		app->last_update_time = current_time;
+	}
+
+	if (!elapsed_time)
+		return;
+
+	transfer_rate = actual_bytes_sent / elapsed_time;
+	if (transfer_rate == 0)
+		return;
 
-	gtk_progress_bar_set_fraction(GTK_PROGRESS_BAR(progress), 1.0);
+	time_remaining = (app->byte_count - actual_bytes_sent) / transfer_rate;
 
-	dbus_g_proxy_call(proxy, "Disconnect", NULL, G_TYPE_INVALID,
-							G_TYPE_INVALID);
+	if (time_remaining >= 3600) {
+		str = g_strdup_printf(_("(%d:%02d:%d Remaining)"), 
+				      time_remaining / 3600,
+				      (time_remaining % 3600) / 60,
+				      (time_remaining % 3600) % 60);
+	} else {
+		str = g_strdup_printf(_("(%d:%02d Remaining)"), 
+				      time_remaining / 60,
+				      time_remaining % 60);
+	}
 
-	gtk_dialog_set_response_sensitive(GTK_DIALOG(dialog),
-						GTK_RESPONSE_CLOSE, TRUE);
+	/* Translators:
+	 * Sending file 1 of 3 */
+	str2 = g_strdup_printf(_("Sending file %d of %d"),
+			       app->current_file + 1,
+			       app->file_count);
+	progressbar_text = g_strconcat(str2, " ", str, NULL);
+	gtk_progress_bar_set_text(GTK_PROGRESS_BAR(app->progress_bar),
+				  progressbar_text);
+	g_free(str);
+	g_free(str2);
+	g_free(progressbar_text);
+}
+
+static void
+transfer_completed_cb(DBusGProxy *proxy, BluetoothSendto *app)
+{
+	app->current_file++;
+	app->bytes_sent += app->file_length;
+
+	g_idle_add((GSourceFunc) send_one, app);
 }
 
-static void session_connected(DBusGProxy *proxy, gpointer user_data)
+static void session_created_cb(DBusGProxy *proxy, DBusGProxyCall *call,
+			       BluetoothSendto *app)
 {
-	gchar *filename = user_data;
 	GError *error = NULL;
+	const gchar *path = NULL;
 
-	gtk_label_set_markup(GTK_LABEL(label_status), _("Connected"));
+	if (!dbus_g_proxy_end_call(proxy, call, &error,
+				  G_TYPE_STRING, &path, G_TYPE_INVALID)) {
+		const gchar *error_name = NULL;
+		gint response_id;
+
+		if (error && error->code == DBUS_GERROR_REMOTE_EXCEPTION)
+			error_name = dbus_g_error_get_name(error);
+		if (error_name && !strcmp(error_name, "org.openobex.Error.ConnectionAttemptFailed")) {
+			response_id = show_connection_error_dialog(GTK_WINDOW(app->main_dialog), bdaddrstr, error->message);
+			if (response_id == DIALOG_RESPONSE_RETRY) {
+				/* Try to create Session again */
+				dbus_g_proxy_begin_call(app->manager_proxy,
+							"CreateBluetoothSession",
+							(DBusGProxyCallNotify) session_created_cb, app, NULL,
+							G_TYPE_STRING, bdaddrstr, G_TYPE_STRING, "opp",
+							G_TYPE_BOOLEAN, FALSE, G_TYPE_INVALID);
+				goto out;
+			}
+		} else {
+			show_error_dialog(GTK_WINDOW(app->main_dialog), BUTTONS_OK,
+					  error->message, "");
+		}
 
-	dbus_g_proxy_call(proxy, "SendFile", &error,
-				G_TYPE_STRING, filename, G_TYPE_INVALID,
-							G_TYPE_INVALID);
-
-	if (error != NULL) {
-		g_printerr("Sending of file %s failed: %s\n", filename,
-							error->message);
-		g_error_free(error);
+		/* Failed, quit main loop */
 		gtk_main_quit();
+		goto out;
 	}
-}
 
-static void create_notify(DBusGProxy *proxy,
-				DBusGProxyCall *call, void *user_data)
-{
-	GError *error = NULL;
-	const gchar *path = NULL;
+	app->session_proxy = dbus_g_proxy_new_for_name(app->connection,
+						       "org.openobex",
+						       path,
+						       "org.openobex.Session");
 
-	if (dbus_g_proxy_end_call(proxy, call, &error,
-			G_TYPE_STRING, &path, G_TYPE_INVALID) == FALSE) {
-		gchar *text, *message;
-
-		if (error != NULL) {
-			message = g_strdup(error->message);
-			g_error_free(error);
-		} else
-			message = g_strdup(_("An unknown error occured"));
-
-		text = g_strdup_printf("<span foreground=\"red\">%s</span>",
-								message);
-		gtk_label_set_markup(GTK_LABEL(label_status), text);
-		g_free(text);
+	dbus_g_proxy_add_signal(app->session_proxy, "Connected",
+				G_TYPE_INVALID);
 
-		g_free(message);
+	dbus_g_proxy_connect_signal(app->session_proxy, "Connected",
+				    G_CALLBACK(session_connected_cb), app, NULL);
 
-		gtk_dialog_set_response_sensitive(GTK_DIALOG(dialog),
-						GTK_RESPONSE_CLOSE, TRUE);
-		return;
-	}
+	dbus_g_proxy_add_signal(app->session_proxy, "TransferStarted",
+				G_TYPE_STRING, G_TYPE_STRING, G_TYPE_INT, G_TYPE_INVALID);
+
+	dbus_g_proxy_connect_signal(app->session_proxy, "TransferStarted",
+				    G_CALLBACK(transfer_started_cb), app, NULL);
 
-	proxy = dbus_g_proxy_new_for_name(conn, "org.openobex",
-						path, "org.openobex.Session");
+	dbus_g_proxy_add_signal(app->session_proxy, "Cancelled",
+				G_TYPE_INVALID);
 
-	dbus_g_proxy_add_signal(proxy, "Connected", G_TYPE_INVALID);
+	dbus_g_proxy_connect_signal(app->session_proxy, "Cancelled",
+				    G_CALLBACK(transfer_cancelled_cb), app, NULL);
 
-	dbus_g_proxy_connect_signal(proxy, "Connected",
-				G_CALLBACK(session_connected), user_data, NULL);
+	dbus_g_proxy_add_signal(app->session_proxy, "ErrorOccurred",
+				G_TYPE_STRING, G_TYPE_STRING, G_TYPE_INVALID);
 
-	dbus_g_proxy_add_signal(proxy, "TransferStarted", G_TYPE_STRING,
-				G_TYPE_STRING, G_TYPE_INT, G_TYPE_INVALID);
+	dbus_g_proxy_connect_signal(app->session_proxy, "ErrorOccurred",
+				    G_CALLBACK(error_occurred_cb), app, NULL);
 
-	dbus_g_proxy_connect_signal(proxy, "TransferStarted",
-				G_CALLBACK(transfer_started), NULL, NULL);
+	dbus_g_proxy_add_signal(app->session_proxy, "TransferProgress",
+				G_TYPE_UINT, G_TYPE_INVALID);
 
-	dbus_g_proxy_add_signal(proxy, "TransferProgress",
-						G_TYPE_UINT, G_TYPE_INVALID);
+	dbus_g_proxy_connect_signal(app->session_proxy, "TransferProgress",
+				    G_CALLBACK(transfer_progress_cb), app, NULL);
 
-	dbus_g_proxy_connect_signal(proxy, "TransferProgress",
-				G_CALLBACK(transfer_progress), NULL, NULL);
+	dbus_g_proxy_add_signal(app->session_proxy, "TransferCompleted", 
+				G_TYPE_INVALID);
 
-	dbus_g_proxy_add_signal(proxy, "TransferCompleted", G_TYPE_INVALID);
+	dbus_g_proxy_connect_signal(app->session_proxy, "TransferCompleted",
+				    G_CALLBACK(transfer_completed_cb), app, NULL);
 
-	dbus_g_proxy_connect_signal(proxy, "TransferCompleted",
-				G_CALLBACK(transfer_completed), NULL, NULL);
+	dbus_g_proxy_call(app->session_proxy, "Connect", &error, G_TYPE_INVALID,
+			  G_TYPE_INVALID);
 
-	dbus_g_proxy_call(proxy, "Connect", NULL, G_TYPE_INVALID,
-							G_TYPE_INVALID);
+out:
+	if (error)
+		g_error_free(error);
 }
 
-static gchar *option_device = NULL;
+static void
+error_occurred_cb(DBusGProxy *proxy, const gchar *error_name,	
+		  const gchar *error_message, BluetoothSendto *app)
+{
+	gint ret;
+	gboolean link_error = FALSE;
+	gchar *error_text;
+	const gchar *reason;
+
+	g_message("ErrorOccurred");
+	g_message("Error name: %s", error_name);
+	g_message("Error message: %s", error_message);
+
+	error_text = g_strdup_printf(_("An error occured while sending file '%s'"),
+				     (gchar *)g_slist_nth_data(app->file_list, app->current_file));
+	if (!strcmp(error_name, "org.openobex.Error.LinkError")) {
+		/* Connection to remote device was lost */
+		g_object_unref(G_OBJECT(app->session_proxy));
+		reason = _("Connection to remote device was lost");
+		link_error = TRUE;
+	} else if (!strcmp(error_name, "org.openobex.Error.Forbidden")) {
+		reason = _("Remote device rejected file");
+	} else {
+		reason = _("Unknown error");
+	}
+	ret = handle_file_sending_error(error_text, reason, app);
 
-static GOptionEntry options[] = {
-	{ "device", 0, 0, G_OPTION_ARG_STRING, &option_device,
-				N_("Remote device to use"), "ADDRESS" },
-	{ NULL },
-};
+	if (ret != GTK_RESPONSE_CANCEL) {
+		if (link_error) {
+			/* Need to reestablish connection */
+			dbus_g_proxy_begin_call(app->manager_proxy, "CreateBluetoothSession",
+						(DBusGProxyCallNotify) session_created_cb, app, NULL,
+						G_TYPE_STRING, bdaddrstr, G_TYPE_STRING, "opp",
+						G_TYPE_INVALID);
+		} else {
+			g_idle_add((GSourceFunc) send_one, app);
+		}
+	}
+
+
+	g_free(error_text);
+}
 
-int main(int argc, char *argv[])
+static void
+free_mem(BluetoothSendto *app)
 {
-	DBusGProxy *proxy;
-	GError *error;
-	gchar *filename, *address;
+	if (files_to_send)
+		g_strfreev(files_to_send);
+	g_free(bdaddrstr);
+
+	if (app) {
+		if (G_IS_OBJECT(app->manager_proxy))
+			g_object_unref(G_OBJECT(app->manager_proxy));
+		if (G_IS_OBJECT(app->session_proxy))
+			g_object_unref (G_OBJECT(app->session_proxy));
+		g_slist_free(app->file_list);
+		g_free(app);
+	}
+}
+
+int
+main(int argc, char *argv[])
+{
+	GOptionContext *option_context;
+	GError *err = NULL;
+	guint i;
+	BluetoothSendto *app;
+
+	app = g_new0(BluetoothSendto, 1);
 
+	/* initialize gettext */
 	bindtextdomain(GETTEXT_PACKAGE, LOCALEDIR);
 	bind_textdomain_codeset(GETTEXT_PACKAGE, "UTF-8");
 	textdomain(GETTEXT_PACKAGE);
 
-	error = NULL;
-
-	if (gtk_init_with_args(&argc, &argv, "[FILE...]",
-				options, GETTEXT_PACKAGE, &error) == FALSE) {
-		if (error != NULL) {
-			g_printerr("%s\n", error->message);
-			g_error_free(error);
-		} else
-			g_printerr("An unknown error occurred\n");
-
-		gtk_exit(1);
-	}
-
-	gtk_window_set_default_icon_name("stock_bluetooth");
-
-	if (argc < 2) {
-		filename = open_file_dialog();
-		if (filename == NULL)
-			gtk_exit(1);
-	} else
-		filename = g_strdup(argv[1]);
-
-	if (option_device == NULL) {
-		address = browse_device_dialog();
-		if (address == NULL) {
-			g_free(filename);
-			gtk_exit(1);
-		}
-	} else
-		address = g_strdup(option_device);
-
-	dbus_g_object_register_marshaller(marshal_VOID__STRING_STRING_INT,
-				G_TYPE_NONE, G_TYPE_STRING,
-				G_TYPE_STRING, G_TYPE_INT, G_TYPE_INVALID);
+	/* parse command line arguments */
+	option_context = g_option_context_new("<file list>");
+	g_option_context_add_main_entries(option_context, options, GETTEXT_PACKAGE);
+	g_option_context_add_group(option_context, gtk_get_option_group(TRUE));
+	g_option_context_parse(option_context, &argc, &argv, &err);
+	g_option_context_free(option_context);
+	if (err) {
+		printf("Usage:\n");
+		printf("  %s [--dest=BDADDR] <file list>\n", g_get_prgname());
+		g_error_free(err);
+		free_mem(app);
+		return 0;
+	}
 
-	error = NULL;
+	gtk_init(&argc, &argv);
 
-	conn = dbus_g_bus_get(DBUS_BUS_SESSION, &error);
-	if (conn == NULL) {
-		if (error != NULL) {
-			g_printerr("Connecting to session bus failed: %s\n",
-							error->message);
-			g_error_free(error);
-		} else
-			g_print("An unknown error occured\n");
+	/* get a list of files to send from command-line */
+	if (files_to_send)
+		app->file_count = g_strv_length(files_to_send);
+	else
+		app->file_count = 0;
+	for (i = 0; i < app->file_count; i++) {
+		app->file_list = g_slist_append(app->file_list,
+						g_strdup(*(files_to_send + i)));
+	}
+	/* show file chooser if no files were specified */
+	if (!app->file_count) {
+		app->file_list = select_files_dialog();
+		app->file_count = g_slist_length(app->file_list);
+	}
+	/* Check if there are some files to send */
+	if (!app->file_count) {
+		free_mem(app);
+		return 0;
+	}
+	/* Check for non regular and non existand files and
+	 * determine total bytes to send */
+	for (i = 0; i < app->file_count; i++) {
+		GSList *item;
+		gchar *path, *filename;
+		gint64 size;
+
+		item = g_slist_nth(app->file_list, i);
+		path = (gchar *) item->data;
+		filename = normalise_filename(path, &size);
+		if (filename == NULL) {
+			g_free(path);
+			app->file_list = g_slist_remove_link(app->file_list, item);
+			continue;
+		}
+		g_free(item->data);
+		item->data = filename;
+		app->byte_count += size;
+	}
 
-		gtk_exit(1);
+	/* determine Bluetooth device to send to */
+	if (!bdaddrstr) {
+		bdaddrstr = browse_device_dialog();
+		if (!bdaddrstr) {
+			free_mem(app);
+			return 0;
+		}
 	}
 
-	create_window(filename);
+	dbus_g_object_register_marshaller(marshal_VOID__STRING_STRING_INT,
+					  G_TYPE_NONE, G_TYPE_STRING,
+					  G_TYPE_STRING, G_TYPE_INT, G_TYPE_INVALID);
+	dbus_g_object_register_marshaller(marshal_VOID__STRING_STRING,
+					  G_TYPE_NONE, G_TYPE_STRING,
+					  G_TYPE_STRING, G_TYPE_INVALID);
+
+	/* init DBus connection */
+	app->connection = dbus_g_bus_get(DBUS_BUS_SESSION, &err);
+	if (!app->connection) {
+		g_printerr("Connecting to session bus failed: %s\n",
+			   err->message);
+		g_error_free(err);
+		free_mem(app);
+		return 1;
+	}
 
-	proxy = dbus_g_proxy_new_for_name(conn, "org.openobex",
-				"/org/openobex", "org.openobex.Manager");
+	/* init UI */
+	ui_init(app);
 
-	dbus_g_proxy_begin_call(proxy, "CreateBluetoothSession",
-				create_notify, filename, NULL,
-				G_TYPE_STRING, address, G_TYPE_STRING, "opp",
+	/* init DBus proxy, create Session */
+	app->manager_proxy = dbus_g_proxy_new_for_name(app->connection,
+						       "org.openobex",
+						       "/org/openobex",
+						       "org.openobex.Manager");
+
+	dbus_g_proxy_begin_call(app->manager_proxy, "CreateBluetoothSession",
+				(DBusGProxyCallNotify) session_created_cb, app, NULL,
+				G_TYPE_STRING, bdaddrstr, G_TYPE_STRING, "opp",
 				G_TYPE_INVALID);
 
+	/* Go into main loop */
 	gtk_main();
 
-	dbus_g_connection_unref(conn);
+	gtk_widget_destroy(app->main_dialog);
 
-	g_free(address);
-	g_free(filename);
+	/* done sending, free memory */
+	free_mem(app);
 
 	return 0;
 }
+
--- /dev/null	2008-01-24 17:45:36.352009045 +0000
+++ utils.c	2008-02-01 16:00:39.000000000 +0000
@@ -0,0 +1,115 @@
+/*
+ * bluetooth-sendto
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2005-2007  Marcel Holtmann <marcel@holtmann.org>
+ *  Copyright (C) 2006-2007 Tadas Dailyda <tadas@dailyda.com>
+ *  Copyright (C) 2007 Bastien Nocera <hadess@hadess.net>
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
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/time.h>
+#include <sys/types.h>
+
+#include <glib.h>
+#include <glib/gi18n.h>
+#include <glib/gstdio.h>
+#include <gtk/gtk.h>
+
+#include "bluetooth-device-selection.h"
+
+static void
+selected_device_changed_cb(BluetoothDeviceSelection *selector,
+			   gchar *address, gpointer user_data)
+{
+	GtkWidget *dialog = user_data;
+
+	gtk_dialog_set_response_sensitive(GTK_DIALOG(dialog),
+					  GTK_RESPONSE_ACCEPT, address != NULL);
+}
+
+gchar *
+browse_device_dialog(void)
+{
+	GtkWidget *dialog;
+	GtkWidget *selector;
+	gchar *address = NULL;
+
+	dialog = gtk_dialog_new_with_buttons(_("Select Device"),
+					     NULL, GTK_DIALOG_NO_SEPARATOR,
+					     GTK_STOCK_CANCEL, GTK_RESPONSE_REJECT,
+					     GTK_STOCK_CONNECT, GTK_RESPONSE_ACCEPT, NULL);
+
+	gtk_window_set_icon_name(GTK_WINDOW(dialog), "stock_bluetooth");
+
+	gtk_dialog_set_response_sensitive(GTK_DIALOG(dialog),
+					  GTK_RESPONSE_ACCEPT, FALSE);
+
+	gtk_window_set_default_size(GTK_WINDOW(dialog), 450, 300);
+
+	gtk_container_set_border_width(GTK_CONTAINER(dialog), 6);
+
+	selector = bluetooth_device_selection_new(_("Select destination device"));
+	bluetooth_device_selection_start_discovery(
+	    BLUETOOTH_DEVICE_SELECTION(selector));
+
+	gtk_container_add(GTK_CONTAINER(GTK_DIALOG(dialog)->vbox), selector);
+
+	g_signal_connect(selector, "selected-device-changed",
+			 G_CALLBACK(selected_device_changed_cb), dialog);
+
+	gtk_widget_show_all(selector);
+
+	if (gtk_dialog_run(GTK_DIALOG(dialog)) == GTK_RESPONSE_ACCEPT)
+		g_object_get(selector, "device-selected", &address, NULL);
+
+	gtk_widget_destroy(dialog);
+
+	return address;
+}
+
+GSList *
+select_files_dialog(void)
+{
+	GtkWidget *dialog;
+	GSList *file_list;
+
+	file_list = NULL;
+	dialog = gtk_file_chooser_dialog_new(_("Choose files to send"), NULL,
+					     GTK_FILE_CHOOSER_ACTION_OPEN,
+					     GTK_STOCK_CANCEL, GTK_RESPONSE_CANCEL,
+					     _("Send"), GTK_RESPONSE_ACCEPT,
+					     NULL);
+	gtk_window_set_icon_name(GTK_WINDOW(dialog), "stock_bluetooth");
+	gtk_file_chooser_set_select_multiple(GTK_FILE_CHOOSER(dialog), TRUE);
+
+	if (gtk_dialog_run(GTK_DIALOG(dialog)) == GTK_RESPONSE_ACCEPT) {
+		file_list = gtk_file_chooser_get_filenames(GTK_FILE_CHOOSER(dialog));
+	}
+	gtk_widget_destroy(dialog);
+
+	return file_list;
+}
+
--- /dev/null	2008-01-24 17:45:36.352009045 +0000
+++ utils.h	2008-02-01 16:00:15.000000000 +0000
@@ -0,0 +1,30 @@
+/*
+ * bluetooth-sendto
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2005-2007  Marcel Holtmann <marcel@holtmann.org>
+ *  Copyright (C) 2006-2007 Tadas Dailyda <tadas@dailyda.com>
+ *  Copyright (C) 2007 Bastien Nocera <hadess@hadess.net>
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
+#include <glib.h>
+
+gchar *browse_device_dialog(void);
+GSList *select_files_dialog(void);
+

--=-JGhenognbsXTZgRvSjU9
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--=-JGhenognbsXTZgRvSjU9
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--=-JGhenognbsXTZgRvSjU9--
