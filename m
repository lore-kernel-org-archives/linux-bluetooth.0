Return-Path: <cyrus@holtmann.org>
From: Bastien Nocera <hadess@hadess.net>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1202345972.3491.42.camel@cookie.hadess.net>
References: <1200566602.26259.89.camel@cookie.hadess.net>
	<1200663790.2676.3.camel@cookie.hadess.net>
	<1201871693.2389.326.camel@cookie.hadess.net>
	<1201882130.2389.334.camel@cookie.hadess.net>
	<1201882826.2389.337.camel@cookie.hadess.net>
	<1202300325.3491.21.camel@cookie.hadess.net>
	<1202303303.3491.30.camel@cookie.hadess.net>
	<1202345972.3491.42.camel@cookie.hadess.net>
Content-Type: multipart/mixed; boundary="=-nHm3Bvzb/Xkf9aTNYFm/"
Date: Sat, 23 Feb 2008 01:30:28 +0000
Message-Id: <1203730228.2754.105.camel@cookie.hadess.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] [PATCH] Updated sendto
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


--=-nHm3Bvzb/Xkf9aTNYFm/
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


On Thu, 2008-02-07 at 00:59 +0000, Bastien Nocera wrote:
<snip>
> And one that works with obex-data-server 0.1

Updated against current CVS, and fix a memleak when getting the adapters
list. New main.c file attached as well, for easier review.

Cheers

--=-nHm3Bvzb/Xkf9aTNYFm/
Content-Disposition: attachment; filename=bluez-gnome-new-sendto-8.patch
Content-Type: text/x-patch; name=bluez-gnome-new-sendto-8.patch;
	charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Index: po/POTFILES.in
===================================================================
RCS file: /cvsroot/bluez/gnome/po/POTFILES.in,v
retrieving revision 1.18
diff -u -p -u -p -r1.18 POTFILES.in
--- po/POTFILES.in	12 Feb 2008 02:50:33 -0000	1.18
+++ po/POTFILES.in	23 Feb 2008 01:23:51 -0000
@@ -21,3 +21,5 @@ analyzer/dialog.c
 analyzer/tracer.c
 analyzer/bluetooth-analyzer.desktop.in
 analyzer/bluetooth-manager.xml.in
+sendto/main.c
+sendto/utils.c
Index: sendto/Makefile.am
===================================================================
RCS file: /cvsroot/bluez/gnome/sendto/Makefile.am,v
retrieving revision 1.10
diff -u -p -u -p -r1.10 Makefile.am
--- sendto/Makefile.am	6 Feb 2008 01:53:17 -0000	1.10
+++ sendto/Makefile.am	23 Feb 2008 01:23:54 -0000
@@ -1,7 +1,7 @@
 
 bin_PROGRAMS = bluetooth-sendto
 
-bluetooth_sendto_SOURCES = main.c
+bluetooth_sendto_SOURCES = main.c utils.c utils.h
 
 bluetooth_sendto_LDADD = $(top_builddir)/common/libcommon.a \
 					@GTK_LIBS@ @DBUS_LIBS@
@@ -15,3 +15,4 @@ man_MANS = bluetooth-sendto.1
 EXTRA_DIST = $(man_MANS)
 
 MAINTAINERCLEANFILES = Makefile.in
+
Index: sendto/main.c
===================================================================
RCS file: /cvsroot/bluez/gnome/sendto/main.c,v
retrieving revision 1.23
diff -u -p -u -p -r1.23 main.c
--- sendto/main.c	11 Feb 2008 22:24:30 -0000	1.23
+++ sendto/main.c	23 Feb 2008 01:23:54 -0000
@@ -3,6 +3,8 @@
  *  BlueZ - Bluetooth protocol stack for Linux
  *
  *  Copyright (C) 2005-2008  Marcel Holtmann <marcel@holtmann.org>
+ *  Copyright (C) 2006-2007 Tadas Dailyda <tadas@dailyda.com>
+ *  Copyright (C) 2007 Bastien Nocera <hadess@hadess.net>
  *
  *
  *  This program is free software; you can redistribute it and/or modify
@@ -25,267 +27,621 @@
 #include <config.h>
 #endif
 
-#include <dbus/dbus-glib.h>
 
 #include <glib/gi18n.h>
-
 #include <gtk/gtk.h>
 
-#include "bluetooth-device-selection.h"
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/time.h>
+#include <sys/types.h>
+
+#include <dbus/dbus-glib.h>
+#include <glib.h>
+#include <glib/gi18n.h>
+#include <glib/gstdio.h>
+#include <gtk/gtk.h>
 
+#include "dbus-glue.h"
 #include "marshal.h"
+#include "utils.h"
 
-static DBusGConnection *conn = NULL;
+/* DBus */
+static DBusGConnection *connection = NULL;
+static DBusGProxy *manager_proxy = NULL;
+static DBusGProxy *session_proxy = NULL;
+/* GTK */
+static GtkWidget *main_dialog, *from_label, *operation_label, *progress_bar;
+/* sending related */
+static gsize file_length = 0;
+static guint file_count = 0;
+static guint current_file = 0;
+static GSList *file_list = NULL;
+static guint byte_count = 0;
+static guint bytes_sent = 0;
+static gint64 first_transfer_time = 0;
+static gint64 last_update_time = 0;
+
+typedef enum {
+	BUTTONS_OK,
+	BUTTONS_RETRY_CANCEL,
+	BUTTONS_RETRY_SKIP_CANCEL
+} ButtonSet;
+
+/* Command line options */
+static gchar **files_to_send = NULL;
+static gchar *bdaddrstr = NULL;
+static gchar *device_name = NULL;
+
+#define DIALOG_RESPONSE_SKIP 1
+#define DIALOG_RESPONSE_RETRY 2
+
+static void error_occurred_cb(DBusGProxy *proxy, const gchar *error_name,
+			      const gchar *error_message, gpointer user_data);
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
+static gint64 get_system_time(void)
+{
+	struct timeval tmp;
 
-static guint64 filesize = 0;
+	gettimeofday(&tmp, NULL);
+	return (gint64)tmp.tv_usec + (gint64)tmp.tv_sec * G_GINT64_CONSTANT(1000000);
+}
 
-static gchar *open_file_dialog(void)
+static gboolean is_palm_device(const gchar *bdaddr)
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
+static gchar *normalise_filename(const gchar *filename, gint64 *size)
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
+static gchar *get_device_name(void)
 {
-	GtkWidget *dialog;
-	GtkWidget *selector;
-	gchar *address = NULL;
-
-	dialog = gtk_dialog_new_with_buttons(_("Select Device"),
-				NULL, GTK_DIALOG_NO_SEPARATOR,
-				GTK_STOCK_CANCEL, GTK_RESPONSE_REJECT,
-				GTK_STOCK_CONNECT, GTK_RESPONSE_ACCEPT, NULL);
-
-	gtk_dialog_set_response_sensitive(GTK_DIALOG(dialog),
-						GTK_RESPONSE_ACCEPT, FALSE);
+	DBusGConnection *connection;
+	DBusGProxy *manager;
+	GError *error = NULL;
+	gchar *name, **adapters;
+	guint i;
 
-	gtk_window_set_default_size(GTK_WINDOW(dialog), 450, 400);
+	name = NULL;
 
-	gtk_container_set_border_width(GTK_CONTAINER(dialog), 5);
-	gtk_box_set_spacing(GTK_BOX(GTK_DIALOG(dialog)->vbox), 2);
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
 
-	selector = bluetooth_device_selection_new(_("Select destination device"));
-	gtk_container_set_border_width(GTK_CONTAINER(selector), 5);
+	if (!manager_list_adapters(manager, &adapters, &error)) {
+		g_object_unref(manager);
+		dbus_g_connection_unref(connection);
+		return NULL;
+	}
 
-	gtk_container_add(GTK_CONTAINER(GTK_DIALOG(dialog)->vbox), selector);
+	for (i = 0; adapters[i] != NULL; i++) {
+		DBusGProxy *adapter;
 
-	g_signal_connect(selector, "selected-device-changed",
-				G_CALLBACK(selected_device_changed), dialog);
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
 
-	gtk_widget_show_all(selector);
+	g_strfreev(adapters);
+	g_object_unref(manager);
+	dbus_g_connection_unref(connection);
 
-	g_object_set(selector, "show-search", FALSE, NULL);
+	return name;
+}
 
-	bluetooth_device_selection_start_discovery(BLUETOOTH_DEVICE_SELECTION(selector));
+static gint show_error_dialog(GtkWindow *parent, ButtonSet buttons,
+			      const gchar *primary_text, const gchar *secondary_text)
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
+static gint show_connection_error_dialog(GtkWindow *parent, const gchar *bdaddr,
+					 const gchar *primary_text)
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
+static gint handle_file_sending_error(const gchar *error_text,
+				      const gchar *error_secondary_text)
 {
-	gtk_widget_destroy(dialog);
+	ButtonSet buttons;
+	gint response_id;
 
+	if (file_count > 1 && current_file < file_count - 1)
+		buttons = BUTTONS_RETRY_SKIP_CANCEL;
+	else
+		buttons = BUTTONS_RETRY_CANCEL;
+
+	response_id = show_error_dialog(GTK_WINDOW(main_dialog), buttons, 
+					error_text, error_secondary_text);
+
+	switch (response_id) {
+	case DIALOG_RESPONSE_SKIP:
+		current_file++;
+		bytes_sent += file_length;
+	case DIALOG_RESPONSE_RETRY:
+		return TRUE;
+	case GTK_RESPONSE_CANCEL:
+	default:
+		gtk_main_quit();
+		break;
+	}
+	return response_id;
+}
+
+static void cancel_clicked_cb(GtkWidget *button, gpointer user_data)
+{
 	gtk_main_quit();
 }
 
-static void create_window(const gchar *filename)
+static void ui_init(void)
 {
-	GtkWidget *vbox;
-	GtkWidget *label;
+	GtkWidget *vbox, *vbox_parent, *table;
+	GtkWidget *label1, *label2, *label3, *target_label;
+	GtkWidget *button;
 	gchar *text;
 
-	dialog = gtk_dialog_new_with_buttons(_("File Transfer"), NULL,
-				GTK_DIALOG_NO_SEPARATOR,
-				GTK_STOCK_CLOSE, GTK_RESPONSE_CLOSE, NULL);
-
-	gtk_window_set_default_size(GTK_WINDOW(dialog), 400, -1);
+	/* initialize UI */
 
-	gtk_container_set_border_width(GTK_CONTAINER(dialog), 6);
+	device_name = get_device_name();
 
-	vbox = gtk_vbox_new(FALSE, 6);
-	gtk_container_set_border_width(GTK_CONTAINER(vbox), 12);
-	gtk_container_add(GTK_CONTAINER(GTK_DIALOG(dialog)->vbox), vbox);
-
-	label = gtk_label_new(NULL);
-	gtk_misc_set_alignment(GTK_MISC(label), 0.0, 0.0);
-	gtk_box_pack_start(GTK_BOX(vbox), label, FALSE, FALSE, 0);
+	/* main dialog */
+	main_dialog = gtk_dialog_new();
+	gtk_dialog_set_has_separator(GTK_DIALOG(main_dialog), FALSE);
+	gtk_window_set_title(GTK_WINDOW(main_dialog),
+			     _("Bluetooth file transfer"));
+	gtk_window_set_icon_name(GTK_WINDOW(main_dialog), "stock_bluetooth");
+	gtk_window_set_type_hint(GTK_WINDOW(main_dialog),
+				 GDK_WINDOW_TYPE_HINT_NORMAL);
+	gtk_window_set_position(GTK_WINDOW(main_dialog), GTK_WIN_POS_CENTER);
+	gtk_window_set_resizable(GTK_WINDOW(main_dialog), FALSE);
+	gtk_widget_set(main_dialog, "width-request", 400, NULL);
+	button = gtk_dialog_add_button(GTK_DIALOG(main_dialog),
+				       GTK_STOCK_CANCEL,
+				       GTK_RESPONSE_CANCEL);
+	g_signal_connect(G_OBJECT(button), "clicked",
+			 G_CALLBACK(cancel_clicked_cb), NULL);
+	gtk_container_set_border_width(GTK_CONTAINER(main_dialog), 6);
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
 
-	label_filename = label;
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
+	g_free(text);
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
+	vbox_parent = gtk_bin_get_child(GTK_BIN(main_dialog));
+	gtk_box_pack_start_defaults(GTK_BOX(vbox_parent), vbox);
+
+	/* show it */
+	gtk_widget_show_all(main_dialog);
+}
+
+static gboolean send_one(gpointer user_data)
+{
+	const gchar *fname;
+	gint ret;
+	gchar *bname, *dirname;
+	GError *err = NULL;
+	gchar *operation_text, *operation_markup, *progressbar_text;
+
+	if ((fname = g_slist_nth_data(file_list, current_file))) {
+		/* there's a file to send */
+		dbus_g_proxy_call(session_proxy, "SendFile", &err,
+				  G_TYPE_STRING, fname, G_TYPE_INVALID, G_TYPE_INVALID);
+
+		if (err != NULL) {
+			ret = handle_file_sending_error(_("Unable to read file"),
+							err->message);
+			if (ret != GTK_RESPONSE_CANCEL) {
+				g_idle_add((GSourceFunc) send_one, NULL);
+			}
+			g_error_free(err);
+			return FALSE;
+		}
 
-	progress = gtk_progress_bar_new();
-	gtk_box_pack_start(GTK_BOX(vbox), progress, FALSE, FALSE, 0);
+		if (!first_transfer_time) {
+			first_transfer_time = get_system_time();
+		}
+		bname = g_path_get_basename(fname);
+		dirname = g_path_get_dirname(fname);
 
-	label = gtk_label_new(NULL);
-	gtk_label_set_line_wrap(GTK_LABEL(label), TRUE);
-	gtk_misc_set_alignment(GTK_MISC(label), 0.0, 0.0);
-	gtk_box_pack_start(GTK_BOX(vbox), label, FALSE, FALSE, 6);
+		operation_text = g_strdup_printf(_("Sending %s"), bname);
+		operation_markup = g_markup_printf_escaped("<i>%s</i>", operation_text);
+		progressbar_text = g_strdup_printf(_("Sending file: %d of %d"),
+						   current_file+1,
+						   file_count);
+		gtk_label_set_text(GTK_LABEL(from_label), dirname);
+		gtk_label_set_markup(GTK_LABEL(operation_label), operation_markup);
+		gtk_progress_bar_set_text(GTK_PROGRESS_BAR(progress_bar),
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
 
-	label_status = label;
+static void session_connected_cb(DBusGProxy *proxy, gpointer user_data)
+{
+	/* OBEX connect has succeeded, so start sending */
+	g_idle_add((GSourceFunc) send_one, NULL);
+}
 
-	text = g_strdup_printf("<b>%s</b>", filename);
-	gtk_label_set_markup(GTK_LABEL(label_filename), text);
-	g_free(text);
+static void transfer_started_cb(DBusGProxy *proxy, const gchar *filename,
+				const gchar *local_path, guint64 byte_count, gpointer user_data)
+{
+	file_length = byte_count;
+}
 
-	gtk_label_set_markup(GTK_LABEL(label_status), _("Connecting..."));
+static void transfer_cancelled_cb(DBusGProxy *proxy, gpointer user_data)
+{
+	gint ret;
+	gchar *error_text;
 
-	gtk_dialog_set_response_sensitive(GTK_DIALOG(dialog),
-						GTK_RESPONSE_CLOSE, FALSE);
+	error_text = g_strdup_printf(_("An error occured while sending file '%s'"),
+				     (gchar *)g_slist_nth_data(file_list, current_file));
+	ret = handle_file_sending_error(error_text,
+					_("The remote device cancelled the transfer"));
 
-	g_signal_connect(G_OBJECT(dialog), "response",
-				G_CALLBACK(response_callback), NULL);
+	if (ret != GTK_RESPONSE_CANCEL)
+		g_idle_add((GSourceFunc) send_one, NULL);
 
-	gtk_widget_show_all(dialog);
+	g_free(error_text);
 }
 
-static void transfer_started(DBusGProxy *proxy, gchar *a, gchar *b,
-					guint64 size, gpointer user_data)
+static void transfer_progress_cb(DBusGProxy *proxy, guint64 bytes_transferred, gpointer user_data)
 {
-	gchar *text;
+	gdouble frac;
+	guint actual_bytes_sent;
+	gint elapsed_time;
+	gint transfer_rate;
+	gint time_remaining;
+	gint64 current_time;
+	gchar *str, *str2;
+	gchar *progressbar_text;
 
-	filesize = size;
+	/* update progress bar fraction */
+	actual_bytes_sent = bytes_sent + bytes_transferred;
+	frac = (gdouble)actual_bytes_sent / byte_count;
+	gtk_progress_bar_set_fraction(GTK_PROGRESS_BAR(progress_bar), frac);
 
-	text = g_strdup_printf(_("Starting transfer of %jd bytes"), size);
-	gtk_label_set_markup(GTK_LABEL(label_status), text);
-	g_free(text);
+	/* update progress bar text (time remaining)
+	 * (only update once in a second) */
+	current_time = get_system_time();
+	elapsed_time = (current_time - first_transfer_time) / 1000000;
 
-	gtk_progress_bar_set_fraction(GTK_PROGRESS_BAR(progress), 0.0);
-}
+	if (last_update_time) {
+		if (current_time < last_update_time + 1000000)
+			return;
+		else
+			last_update_time = current_time;
+	} else {
+		last_update_time = current_time;
+	}
 
-static void transfer_progress(DBusGProxy *proxy,
-					guint64 bytes, gpointer user_data)
-{
-	gchar *text;
-	gdouble fraction;
+	if (!elapsed_time)
+		return;
 
-	text = g_strdup_printf(_("Transfered %jd of %jd bytes"),
-							bytes, filesize);
-	gtk_label_set_markup(GTK_LABEL(label_status), text);
-	g_free(text);
+	transfer_rate = actual_bytes_sent / elapsed_time;
+	if (transfer_rate == 0)
+		return;
 
-	fraction = (gdouble) bytes / (gdouble) filesize;
-	gtk_progress_bar_set_fraction(GTK_PROGRESS_BAR(progress), fraction);
-}
+	time_remaining = (byte_count - actual_bytes_sent) / transfer_rate;
 
-static void transfer_completed(DBusGProxy *proxy, gpointer user_data)
-{
-	gtk_label_set_markup(GTK_LABEL(label_status), _("Completed"));
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
 
-	gtk_progress_bar_set_fraction(GTK_PROGRESS_BAR(progress), 1.0);
+	/* Translators:
+	 * Sending file 1 of 3 */
+	str2 = g_strdup_printf(_("Sending file %d of %d"),
+			       current_file + 1,
+			       file_count);
+	progressbar_text = g_strconcat(str2, " ", str, NULL);
+	gtk_progress_bar_set_text(GTK_PROGRESS_BAR(progress_bar),
+				  progressbar_text);
+	g_free(str);
+	g_free(str2);
+	g_free(progressbar_text);
+}
 
-	dbus_g_proxy_call(proxy, "Disconnect", NULL, G_TYPE_INVALID,
-							G_TYPE_INVALID);
+static void transfer_completed_cb(DBusGProxy *proxy, gpointer user_data)
+{
+	current_file++;
+	bytes_sent += file_length;
 
-	gtk_dialog_set_response_sensitive(GTK_DIALOG(dialog),
-						GTK_RESPONSE_CLOSE, TRUE);
+	g_idle_add((GSourceFunc) send_one, NULL);
 }
 
-static void session_connected(DBusGProxy *proxy, gpointer user_data)
+static void session_created_cb(DBusGProxy *proxy, DBusGProxyCall *call, gpointer user_data)
 {
-	gchar *filename = user_data;
 	GError *error = NULL;
+	const gchar *path = NULL;
 
-	gtk_label_set_markup(GTK_LABEL(label_status), _("Connected"));
+	if (!dbus_g_proxy_end_call(proxy, call, &error,
+				   DBUS_TYPE_G_OBJECT_PATH, &path, G_TYPE_INVALID)) {
+		const gchar *error_name = NULL;
+		gint response_id;
+
+		if (error && error->code == DBUS_GERROR_REMOTE_EXCEPTION)
+			error_name = dbus_g_error_get_name(error);
+		if (error_name && !strcmp(error_name, "org.openobex.Error.ConnectionAttemptFailed")) {
+			response_id = show_connection_error_dialog(GTK_WINDOW(main_dialog), bdaddrstr, error->message);
+			if (response_id == DIALOG_RESPONSE_RETRY) {
+				/* Try to create Session again */
+				dbus_g_proxy_begin_call(manager_proxy,
+							"CreateBluetoothSession",
+							(DBusGProxyCallNotify) session_created_cb, NULL, NULL,
+							G_TYPE_STRING, bdaddrstr, G_TYPE_STRING, "opp",
+							G_TYPE_BOOLEAN, FALSE, G_TYPE_INVALID);
+				goto out;
+			}
+		} else {
+			show_error_dialog(GTK_WINDOW(main_dialog), BUTTONS_OK,
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
+	session_proxy = dbus_g_proxy_new_for_name(connection,
+						       "org.openobex",
+						       path,
+						       "org.openobex.Session");
 
-	if (dbus_g_proxy_end_call(proxy, call, &error,
-					DBUS_TYPE_G_OBJECT_PATH, &path,
-						G_TYPE_INVALID) == FALSE) {
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
+	dbus_g_proxy_add_signal(session_proxy, "Connected",
+				G_TYPE_INVALID);
 
-		g_free(message);
+	dbus_g_proxy_connect_signal(session_proxy, "Connected",
+				    G_CALLBACK(session_connected_cb), NULL, NULL);
 
-		gtk_dialog_set_response_sensitive(GTK_DIALOG(dialog),
-						GTK_RESPONSE_CLOSE, TRUE);
-		return;
-	}
+	dbus_g_proxy_add_signal(session_proxy, "TransferStarted",
+				G_TYPE_STRING, G_TYPE_STRING, G_TYPE_UINT64, G_TYPE_INVALID);
 
-	proxy = dbus_g_proxy_new_for_name(conn, "org.openobex",
-						path, "org.openobex.Session");
+	dbus_g_proxy_connect_signal(session_proxy, "TransferStarted",
+				    G_CALLBACK(transfer_started_cb), NULL, NULL);
 
-	dbus_g_proxy_add_signal(proxy, "Connected", G_TYPE_INVALID);
+	dbus_g_proxy_add_signal(session_proxy, "Cancelled",
+				G_TYPE_INVALID);
 
-	dbus_g_proxy_connect_signal(proxy, "Connected",
-				G_CALLBACK(session_connected), user_data, NULL);
+	dbus_g_proxy_connect_signal(session_proxy, "Cancelled",
+				    G_CALLBACK(transfer_cancelled_cb), NULL, NULL);
 
-	dbus_g_proxy_add_signal(proxy, "TransferStarted", G_TYPE_STRING,
-				G_TYPE_STRING, G_TYPE_UINT64, G_TYPE_INVALID);
+	dbus_g_proxy_add_signal(session_proxy, "ErrorOccurred",
+				G_TYPE_STRING, G_TYPE_STRING, G_TYPE_INVALID);
 
-	dbus_g_proxy_connect_signal(proxy, "TransferStarted",
-				G_CALLBACK(transfer_started), NULL, NULL);
+	dbus_g_proxy_connect_signal(session_proxy, "ErrorOccurred",
+				    G_CALLBACK(error_occurred_cb), NULL, NULL);
 
-	dbus_g_proxy_add_signal(proxy, "TransferProgress",
-						G_TYPE_UINT64, G_TYPE_INVALID);
+	dbus_g_proxy_add_signal(session_proxy, "TransferProgress",
+				G_TYPE_UINT64, G_TYPE_INVALID);
 
-	dbus_g_proxy_connect_signal(proxy, "TransferProgress",
-				G_CALLBACK(transfer_progress), NULL, NULL);
+	dbus_g_proxy_connect_signal(session_proxy, "TransferProgress",
+				    G_CALLBACK(transfer_progress_cb), NULL, NULL);
 
-	dbus_g_proxy_add_signal(proxy, "TransferCompleted", G_TYPE_INVALID);
+	dbus_g_proxy_add_signal(session_proxy, "TransferCompleted", 
+				G_TYPE_INVALID);
 
-	dbus_g_proxy_connect_signal(proxy, "TransferCompleted",
-				G_CALLBACK(transfer_completed), NULL, NULL);
+	dbus_g_proxy_connect_signal(session_proxy, "TransferCompleted",
+				    G_CALLBACK(transfer_completed_cb), NULL, NULL);
 
-	dbus_g_proxy_call(proxy, "Connect", NULL, G_TYPE_INVALID,
-							G_TYPE_INVALID);
+	dbus_g_proxy_call(session_proxy, "Connect", &error, G_TYPE_INVALID,
+			  G_TYPE_INVALID);
+
+out:
+	if (error)
+		g_error_free(error);
+}
+
+static void error_occurred_cb(DBusGProxy *proxy, const gchar *error_name, const gchar *error_message, gpointer user_data)
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
+				     (gchar *)g_slist_nth_data(file_list, current_file));
+	if (!strcmp(error_name, "org.openobex.Error.LinkError")) {
+		/* Connection to remote device was lost */
+		g_object_unref(G_OBJECT(session_proxy));
+		reason = _("Connection to remote device was lost");
+		link_error = TRUE;
+	} else if (!strcmp(error_name, "org.openobex.Error.Forbidden")) {
+		reason = _("Remote device rejected file");
+	} else {
+		reason = _("Unknown error");
+	}
+	ret = handle_file_sending_error(error_text, reason);
+
+	if (ret != GTK_RESPONSE_CANCEL) {
+		if (link_error) {
+			/* Need to reestablish connection */
+			dbus_g_proxy_begin_call(manager_proxy, "CreateBluetoothSession",
+						(DBusGProxyCallNotify) session_created_cb, NULL, NULL,
+						G_TYPE_STRING, bdaddrstr, G_TYPE_STRING, "opp",
+						G_TYPE_INVALID);
+		} else {
+			g_idle_add((GSourceFunc) send_one, NULL);
+		}
+	}
+
+
+	g_free(error_text);
+}
+
+static void free_mem(void)
+{
+	if (files_to_send)
+		g_strfreev(files_to_send);
+	g_free(bdaddrstr);
+
+	if (main_dialog)
+		gtk_widget_destroy (main_dialog);
+	if (G_IS_OBJECT(manager_proxy))
+		g_object_unref(G_OBJECT(manager_proxy));
+	if (G_IS_OBJECT(session_proxy))
+		g_object_unref (G_OBJECT(session_proxy));
+	g_slist_free(file_list);
 }
 
 static void name_owner_changed(DBusGProxy *proxy, const char *name,
@@ -295,98 +651,128 @@ static void name_owner_changed(DBusGProx
 		gtk_main_quit();
 }
 
-static gchar *option_device = NULL;
-
-static GOptionEntry options[] = {
-	{ "device", 0, 0, G_OPTION_ARG_STRING, &option_device,
-				N_("Remote device to use"), "ADDRESS" },
-	{ NULL },
-};
-
 int main(int argc, char *argv[])
 {
-	DBusGProxy *proxy;
+	GOptionContext *option_context;
 	GError *error = NULL;
-	gchar *filename, *address;
+	guint i;
 
+	/* initialize gettext */
 	bindtextdomain(GETTEXT_PACKAGE, LOCALEDIR);
 	bind_textdomain_codeset(GETTEXT_PACKAGE, "UTF-8");
 	textdomain(GETTEXT_PACKAGE);
 
-	error = NULL;
+	/* parse command line arguments */
+	option_context = g_option_context_new("<file list>");
+	g_option_context_add_main_entries(option_context, options, GETTEXT_PACKAGE);
+	g_option_context_add_group(option_context, gtk_get_option_group(TRUE));
+	g_option_context_parse(option_context, &argc, &argv, &error);
+	g_option_context_free(option_context);
+	if (error) {
+		printf("Usage:\n");
+		printf("  %s [--dest=BDADDR] <file list>\n", g_get_prgname());
+		g_error_free(error);
+		free_mem();
+		return 0;
+	}
 
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
-	gtk_window_set_default_icon_name("bluetooth");
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
+	gtk_init(&argc, &argv);
 
-	conn = dbus_g_bus_get(DBUS_BUS_SESSION, &error);
-	if (conn == NULL) {
-		if (error != NULL) {
-			g_printerr("Connecting to session bus failed: %s\n",
-							error->message);
-			g_error_free(error);
-		} else
-			g_print("An unknown error occured\n");
+	/* init DBus connection */
+	connection = dbus_g_bus_get(DBUS_BUS_SESSION, &error);
+	if (!connection) {
+		show_error_dialog(NULL, GTK_BUTTONS_OK,
+				  _("Please verify that D-Bus is correctly installed and setup."), error->message);
+		g_error_free(error);
+		return 1;
+	}
 
-		gtk_exit(1);
+	main_dialog = NULL;
+	from_label = NULL;
+	operation_label = NULL;
+	progress_bar = NULL;
+
+	/* get a list of files to send from command-line */
+	if (files_to_send)
+		file_count = g_strv_length(files_to_send);
+	else
+		file_count = 0;
+	for (i = 0; i < file_count; i++) {
+		file_list = g_slist_append(file_list,
+						g_strdup(*(files_to_send + i)));
+	}
+	/* show file chooser if no files were specified */
+	if (!file_count) {
+		file_list = select_files_dialog();
+		file_count = g_slist_length(file_list);
+	}
+	/* Check if there are some files to send */
+	if (!file_count) {
+		free_mem();
+		return 0;
+	}
+	/* Check for non regular and non existand files and
+	 * determine total bytes to send */
+	for (i = 0; i < file_count; i++) {
+		GSList *item;
+		gchar *path, *filename;
+		gint64 size;
+
+		item = g_slist_nth(file_list, i);
+		path = (gchar *) item->data;
+		filename = normalise_filename(path, &size);
+		if (filename == NULL) {
+			g_free(path);
+			file_list = g_slist_remove_link(file_list, item);
+			continue;
+		}
+		g_free(item->data);
+		item->data = filename;
+		byte_count += size;
 	}
 
-	dbus_g_object_register_marshaller(marshal_VOID__STRING_STRING_UINT64,
-				G_TYPE_NONE, G_TYPE_STRING,
-				G_TYPE_STRING, G_TYPE_UINT64, G_TYPE_INVALID);
+	/* determine Bluetooth device to send to */
+	if (!bdaddrstr) {
+		bdaddrstr = browse_device_dialog();
+		if (!bdaddrstr) {
+			free_mem();
+			return 0;
+		}
+	}
 
+	dbus_g_object_register_marshaller(marshal_VOID__STRING_STRING_UINT64,
+					  G_TYPE_NONE, G_TYPE_STRING,
+					  G_TYPE_STRING, G_TYPE_UINT64, G_TYPE_INVALID);
+	dbus_g_object_register_marshaller(marshal_VOID__STRING_STRING,
+					  G_TYPE_NONE, G_TYPE_STRING,
+					  G_TYPE_STRING, G_TYPE_INVALID);
 	dbus_g_object_register_marshaller(marshal_VOID__UINT64,
-				G_TYPE_NONE, G_TYPE_UINT64, G_TYPE_INVALID);
-
-	create_window(filename);
-
-	proxy = dbus_g_proxy_new_for_name(conn, "org.openobex",
-				"/org/openobex", "org.openobex.Manager");
-
-	dbus_g_proxy_add_signal(proxy, "NameOwnerChanged",
-		G_TYPE_STRING, G_TYPE_STRING, G_TYPE_STRING, G_TYPE_INVALID);
+					  G_TYPE_NONE, G_TYPE_UINT64, G_TYPE_INVALID);
 
-	dbus_g_proxy_connect_signal(proxy, "NameOwnerChanged",
-				G_CALLBACK(name_owner_changed), NULL, NULL);
+	/* init UI */
+	ui_init();
 
-	dbus_g_proxy_begin_call(proxy, "CreateBluetoothSession",
-				create_notify, filename, NULL,
-				G_TYPE_STRING, address, G_TYPE_STRING, "opp",
+	/* init DBus proxy, create Session */
+	manager_proxy = dbus_g_proxy_new_for_name(connection,
+						       "org.openobex",
+						       "/org/openobex",
+						       "org.openobex.Manager");
+	dbus_g_proxy_add_signal(manager_proxy, "NameOwnerChanged",
+				G_TYPE_STRING, G_TYPE_STRING, G_TYPE_STRING, G_TYPE_INVALID);
+	dbus_g_proxy_connect_signal(manager_proxy, "NameOwnerChanged",
+				    G_CALLBACK(name_owner_changed), NULL, NULL);
+
+	dbus_g_proxy_begin_call(manager_proxy, "CreateBluetoothSession",
+				(DBusGProxyCallNotify) session_created_cb, NULL, NULL,
+				G_TYPE_STRING, bdaddrstr, G_TYPE_STRING, "opp",
 				G_TYPE_INVALID);
 
+	/* Go into main loop */
 	gtk_main();
 
-	g_object_unref(proxy);
-
-	dbus_g_connection_unref(conn);
-
-	g_free(address);
-	g_free(filename);
+	/* done sending, free memory */
+	free_mem();
 
 	return 0;
 }
+
--- /dev/null	2008-02-19 13:52:26.315003021 +0000
+++ sendto/utils.c	2008-02-06 13:05:42.000000000 +0000
@@ -0,0 +1,112 @@
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
+static void selected_device_changed_cb(BluetoothDeviceSelection *selector,
+				       gchar *address, gpointer user_data)
+{
+	GtkWidget *dialog = user_data;
+
+	gtk_dialog_set_response_sensitive(GTK_DIALOG(dialog),
+					  GTK_RESPONSE_ACCEPT, address != NULL);
+}
+
+gchar *browse_device_dialog(void)
+{
+	GtkWidget *dialog;
+	GtkWidget *selector;
+	gchar *address = NULL;
+
+	dialog = gtk_dialog_new_with_buttons(_("Select Destination Device"),
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
+GSList *select_files_dialog(void)
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
--- /dev/null	2008-02-19 13:52:26.315003021 +0000
+++ sendto/utils.h	2008-02-06 13:05:42.000000000 +0000
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

--=-nHm3Bvzb/Xkf9aTNYFm/
Content-Disposition: attachment; filename=main.c
Content-Type: text/x-csrc; name=main.c; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

/*
 *
 *  BlueZ - Bluetooth protocol stack for Linux
 *
 *  Copyright (C) 2005-2008  Marcel Holtmann <marcel@holtmann.org>
 *  Copyright (C) 2006-2007 Tadas Dailyda <tadas@dailyda.com>
 *  Copyright (C) 2007 Bastien Nocera <hadess@hadess.net>
 *
 *
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program; if not, write to the Free Software
 *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
 *
 */

#ifdef HAVE_CONFIG_H
#include <config.h>
#endif


#include <glib/gi18n.h>
#include <gtk/gtk.h>

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/time.h>
#include <sys/types.h>

#include <dbus/dbus-glib.h>
#include <glib.h>
#include <glib/gi18n.h>
#include <glib/gstdio.h>
#include <gtk/gtk.h>

#include "dbus-glue.h"
#include "marshal.h"
#include "utils.h"

/* DBus */
static DBusGConnection *connection = NULL;
static DBusGProxy *manager_proxy = NULL;
static DBusGProxy *session_proxy = NULL;
/* GTK */
static GtkWidget *main_dialog, *from_label, *operation_label, *progress_bar;
/* sending related */
static gsize file_length = 0;
static guint file_count = 0;
static guint current_file = 0;
static GSList *file_list = NULL;
static guint byte_count = 0;
static guint bytes_sent = 0;
static gint64 first_transfer_time = 0;
static gint64 last_update_time = 0;

typedef enum {
	BUTTONS_OK,
	BUTTONS_RETRY_CANCEL,
	BUTTONS_RETRY_SKIP_CANCEL
} ButtonSet;

/* Command line options */
static gchar **files_to_send = NULL;
static gchar *bdaddrstr = NULL;
static gchar *device_name = NULL;

#define DIALOG_RESPONSE_SKIP 1
#define DIALOG_RESPONSE_RETRY 2

static void error_occurred_cb(DBusGProxy *proxy, const gchar *error_name,
			      const gchar *error_message, gpointer user_data);

static const GOptionEntry options[] = {
	{"dest", 'd', 0, G_OPTION_ARG_STRING, &bdaddrstr, 
		"Bluetooth address of destination device", "BDADDR"},
	{G_OPTION_REMAINING, '\0', 0, G_OPTION_ARG_FILENAME_ARRAY, &files_to_send},
	{NULL}
};

static gint64 get_system_time(void)
{
	struct timeval tmp;

	gettimeofday(&tmp, NULL);
	return (gint64)tmp.tv_usec + (gint64)tmp.tv_sec * G_GINT64_CONSTANT(1000000);
}

static gboolean is_palm_device(const gchar *bdaddr)
{
	return (g_str_has_prefix(bdaddr, "00:04:6B")
		|| g_str_has_prefix(bdaddr, "00:07:E0")
		|| g_str_has_prefix(bdaddr, "00:0E:20"));
}

/* Return the local absolute filename for the file, and its size
 * if the file exists and is stat()'able */
static gchar *normalise_filename(const gchar *filename, gint64 *size)
{
	char *ret;
	struct stat file_stat;

	g_return_val_if_fail(filename != NULL, NULL);
	g_return_val_if_fail(size != NULL, NULL);

	if (g_str_has_prefix(filename, "file://")) {
		ret = g_filename_from_uri(filename, NULL, NULL);
		if (ret == NULL)
			return NULL;
	} else if (filename[0] == '/') {
		ret = g_strdup(filename);
	} else {
		gchar *curdir;

		curdir = g_get_current_dir();
		ret = g_build_filename(curdir, filename, NULL);
		g_free(curdir);
	}

	if (!g_file_test(ret, G_FILE_TEST_IS_REGULAR)) {
		g_free(ret);
		return NULL;
	}

	if (!g_stat(ret, &file_stat)) {
		*size = file_stat.st_size;
	} else {
		g_free(ret);
		return NULL;
	}

	return ret;
}

static gchar *get_device_name(void)
{
	DBusGConnection *connection;
	DBusGProxy *manager;
	GError *error = NULL;
	gchar *name, **adapters;
	guint i;

	name = NULL;

	connection = dbus_g_bus_get(DBUS_BUS_SYSTEM, NULL);
	if (connection == NULL)
		return NULL;

	manager = dbus_g_proxy_new_for_name(connection, "org.bluez",
					    "/org/bluez", "org.bluez.Manager");
	if (!manager) {
		dbus_g_connection_unref(connection);
		return NULL;
	}

	if (!manager_list_adapters(manager, &adapters, &error)) {
		g_object_unref(manager);
		dbus_g_connection_unref(connection);
		return NULL;
	}

	for (i = 0; adapters[i] != NULL; i++) {
		DBusGProxy *adapter;

		adapter = dbus_g_proxy_new_for_name(connection, "org.bluez",
						    adapters[i], "org.bluez.Adapter");
		if (dbus_g_proxy_call(adapter, "GetRemoteName", NULL,
				      G_TYPE_STRING, bdaddrstr, G_TYPE_INVALID,
				      G_TYPE_STRING, &name, G_TYPE_INVALID)) {
			if (name != NULL && name[0] != '\0') {
				g_object_unref(adapter);
				break;
			}
		}
		g_object_unref(adapter);
	}

	g_strfreev(adapters);
	g_object_unref(manager);
	dbus_g_connection_unref(connection);

	return name;
}

static gint show_error_dialog(GtkWindow *parent, ButtonSet buttons,
			      const gchar *primary_text, const gchar *secondary_text)
{
	GtkWidget *dialog;
	gchar *primary_text_markup;
	gint ret;

	primary_text_markup = g_strdup_printf("<span weight=\"bold\" size=\"larger\">%s</span>", 
					      primary_text);
	dialog = gtk_message_dialog_new_with_markup(parent, 0, GTK_MESSAGE_ERROR, 
						    buttons==BUTTONS_OK? GTK_BUTTONS_OK: GTK_BUTTONS_CANCEL, 
						    primary_text_markup);
	gtk_message_dialog_format_secondary_text(GTK_MESSAGE_DIALOG(dialog),
						 secondary_text);
	if (buttons == BUTTONS_RETRY_SKIP_CANCEL) {
		gtk_dialog_add_button(GTK_DIALOG(dialog), _("Skip"),
				      DIALOG_RESPONSE_SKIP);
	}
	if (buttons != BUTTONS_OK) {
		gtk_dialog_add_button(GTK_DIALOG(dialog), _("Retry"),
				      DIALOG_RESPONSE_RETRY);
	}
	ret = gtk_dialog_run(GTK_DIALOG(dialog));

	gtk_widget_destroy(dialog);
	g_free(primary_text_markup);
	return ret;
}

static gint show_connection_error_dialog(GtkWindow *parent, const gchar *bdaddr,
					 const gchar *primary_text)
{
	if (!is_palm_device(bdaddrstr)) {
		return show_error_dialog(parent,
					 BUTTONS_RETRY_CANCEL,
					 primary_text,
					 _("Make sure that remote device is on and that it accepts Bluetooth connections."));
	} else {
		return show_error_dialog(parent,
					 BUTTONS_RETRY_CANCEL,
					 primary_text,
					 _("Make sure \"Beam receive\" is enabled in the Power preferences, and Bluetooth is enabled, on your Palm device."));
	}
}

static gint handle_file_sending_error(const gchar *error_text,
				      const gchar *error_secondary_text)
{
	ButtonSet buttons;
	gint response_id;

	if (file_count > 1 && current_file < file_count - 1)
		buttons = BUTTONS_RETRY_SKIP_CANCEL;
	else
		buttons = BUTTONS_RETRY_CANCEL;

	response_id = show_error_dialog(GTK_WINDOW(main_dialog), buttons, 
					error_text, error_secondary_text);

	switch (response_id) {
	case DIALOG_RESPONSE_SKIP:
		current_file++;
		bytes_sent += file_length;
	case DIALOG_RESPONSE_RETRY:
		return TRUE;
	case GTK_RESPONSE_CANCEL:
	default:
		gtk_main_quit();
		break;
	}
	return response_id;
}

static void cancel_clicked_cb(GtkWidget *button, gpointer user_data)
{
	gtk_main_quit();
}

static void ui_init(void)
{
	GtkWidget *vbox, *vbox_parent, *table;
	GtkWidget *label1, *label2, *label3, *target_label;
	GtkWidget *button;
	gchar *text;

	/* initialize UI */

	device_name = get_device_name();

	/* main dialog */
	main_dialog = gtk_dialog_new();
	gtk_dialog_set_has_separator(GTK_DIALOG(main_dialog), FALSE);
	gtk_window_set_title(GTK_WINDOW(main_dialog),
			     _("Bluetooth file transfer"));
	gtk_window_set_icon_name(GTK_WINDOW(main_dialog), "stock_bluetooth");
	gtk_window_set_type_hint(GTK_WINDOW(main_dialog),
				 GDK_WINDOW_TYPE_HINT_NORMAL);
	gtk_window_set_position(GTK_WINDOW(main_dialog), GTK_WIN_POS_CENTER);
	gtk_window_set_resizable(GTK_WINDOW(main_dialog), FALSE);
	gtk_widget_set(main_dialog, "width-request", 400, NULL);
	button = gtk_dialog_add_button(GTK_DIALOG(main_dialog),
				       GTK_STOCK_CANCEL,
				       GTK_RESPONSE_CANCEL);
	g_signal_connect(G_OBJECT(button), "clicked",
			 G_CALLBACK(cancel_clicked_cb), NULL);
	gtk_container_set_border_width(GTK_CONTAINER(main_dialog), 6);

	/* table elements */
	from_label = gtk_label_new(NULL);
	gtk_misc_set_alignment(GTK_MISC(from_label), 0, 0.5);
	gtk_label_set_ellipsize(GTK_LABEL(from_label), PANGO_ELLIPSIZE_MIDDLE);
	target_label = gtk_label_new(NULL);
	gtk_misc_set_alignment(GTK_MISC(target_label), 0, 0.5);
	gtk_label_set_ellipsize(GTK_LABEL(target_label), PANGO_ELLIPSIZE_END);
	gtk_label_set_text(GTK_LABEL(target_label), device_name ? device_name : bdaddrstr);
	label2 = gtk_label_new(NULL);
	text = g_markup_printf_escaped("<b>%s</b>", _("From:"));
	gtk_label_set_markup(GTK_LABEL(label2), text);
	g_free(text);
	label3 = gtk_label_new(NULL);
	gtk_misc_set_alignment(GTK_MISC(label3), 1, 0.5);
	text = g_markup_printf_escaped("<b>%s</b>", _("To:"));
	gtk_label_set_markup(GTK_LABEL(label3), text);
	g_free(text);

	/* table */
	table = gtk_table_new(2, 2, FALSE);
	gtk_table_set_col_spacings(GTK_TABLE(table), 4);
	gtk_table_set_row_spacings(GTK_TABLE(table), 4);
	gtk_table_attach_defaults(GTK_TABLE(table), from_label, 1, 2, 0, 1);
	gtk_table_attach_defaults(GTK_TABLE(table), target_label, 1, 2, 1, 2);
	gtk_table_attach(GTK_TABLE(table), label2, 0, 1, 0, 1, GTK_FILL, 0, 0, 0);
	gtk_table_attach(GTK_TABLE(table), label3, 0, 1, 1, 2, GTK_FILL, 0, 0, 0);

	/* vbox elements */
	label1 = gtk_label_new(NULL);
	gtk_misc_set_alignment(GTK_MISC(label1), 0, 0.5);
	text = g_markup_printf_escaped("<span weight=\"bold\" size=\"larger\">%s</span>",
				       _("Sending files via bluetooth"));
	gtk_label_set_markup(GTK_LABEL(label1), text);
	g_free(text);
	progress_bar = gtk_progress_bar_new();
	gtk_progress_bar_set_ellipsize(GTK_PROGRESS_BAR(progress_bar),
				       PANGO_ELLIPSIZE_END);
	gtk_progress_bar_set_text(GTK_PROGRESS_BAR(progress_bar),
				  _("Connecting..."));
	operation_label = gtk_label_new(NULL);
	gtk_misc_set_alignment(GTK_MISC(operation_label), 0, 0.5);
	gtk_label_set_ellipsize(GTK_LABEL(operation_label), PANGO_ELLIPSIZE_END);

	/* vbox */
	vbox = gtk_vbox_new(FALSE, 0);
	gtk_box_set_spacing(GTK_BOX(vbox), 6);
	gtk_container_set_border_width(GTK_CONTAINER(vbox), 6);
	gtk_box_pack_start_defaults(GTK_BOX(vbox), label1);
	gtk_box_pack_start(GTK_BOX(vbox), table, TRUE, TRUE, 9);
	gtk_box_pack_start_defaults(GTK_BOX(vbox), progress_bar);
	gtk_box_pack_start(GTK_BOX(vbox), operation_label, TRUE, TRUE, 2);
	vbox_parent = gtk_bin_get_child(GTK_BIN(main_dialog));
	gtk_box_pack_start_defaults(GTK_BOX(vbox_parent), vbox);

	/* show it */
	gtk_widget_show_all(main_dialog);
}

static gboolean send_one(gpointer user_data)
{
	const gchar *fname;
	gint ret;
	gchar *bname, *dirname;
	GError *err = NULL;
	gchar *operation_text, *operation_markup, *progressbar_text;

	if ((fname = g_slist_nth_data(file_list, current_file))) {
		/* there's a file to send */
		dbus_g_proxy_call(session_proxy, "SendFile", &err,
				  G_TYPE_STRING, fname, G_TYPE_INVALID, G_TYPE_INVALID);

		if (err != NULL) {
			ret = handle_file_sending_error(_("Unable to read file"),
							err->message);
			if (ret != GTK_RESPONSE_CANCEL) {
				g_idle_add((GSourceFunc) send_one, NULL);
			}
			g_error_free(err);
			return FALSE;
		}

		if (!first_transfer_time) {
			first_transfer_time = get_system_time();
		}
		bname = g_path_get_basename(fname);
		dirname = g_path_get_dirname(fname);

		operation_text = g_strdup_printf(_("Sending %s"), bname);
		operation_markup = g_markup_printf_escaped("<i>%s</i>", operation_text);
		progressbar_text = g_strdup_printf(_("Sending file: %d of %d"),
						   current_file+1,
						   file_count);
		gtk_label_set_text(GTK_LABEL(from_label), dirname);
		gtk_label_set_markup(GTK_LABEL(operation_label), operation_markup);
		gtk_progress_bar_set_text(GTK_PROGRESS_BAR(progress_bar),
					  progressbar_text);

		g_free(bname);
		g_free(dirname);
		g_free(operation_text);
		g_free(operation_markup);
		g_free(progressbar_text);
	} else {
		/* nothing left to send, time to quit */
		gtk_main_quit();
	}
	return FALSE;
}

static void session_connected_cb(DBusGProxy *proxy, gpointer user_data)
{
	/* OBEX connect has succeeded, so start sending */
	g_idle_add((GSourceFunc) send_one, NULL);
}

static void transfer_started_cb(DBusGProxy *proxy, const gchar *filename,
				const gchar *local_path, guint64 byte_count, gpointer user_data)
{
	file_length = byte_count;
}

static void transfer_cancelled_cb(DBusGProxy *proxy, gpointer user_data)
{
	gint ret;
	gchar *error_text;

	error_text = g_strdup_printf(_("An error occured while sending file '%s'"),
				     (gchar *)g_slist_nth_data(file_list, current_file));
	ret = handle_file_sending_error(error_text,
					_("The remote device cancelled the transfer"));

	if (ret != GTK_RESPONSE_CANCEL)
		g_idle_add((GSourceFunc) send_one, NULL);

	g_free(error_text);
}

static void transfer_progress_cb(DBusGProxy *proxy, guint64 bytes_transferred, gpointer user_data)
{
	gdouble frac;
	guint actual_bytes_sent;
	gint elapsed_time;
	gint transfer_rate;
	gint time_remaining;
	gint64 current_time;
	gchar *str, *str2;
	gchar *progressbar_text;

	/* update progress bar fraction */
	actual_bytes_sent = bytes_sent + bytes_transferred;
	frac = (gdouble)actual_bytes_sent / byte_count;
	gtk_progress_bar_set_fraction(GTK_PROGRESS_BAR(progress_bar), frac);

	/* update progress bar text (time remaining)
	 * (only update once in a second) */
	current_time = get_system_time();
	elapsed_time = (current_time - first_transfer_time) / 1000000;

	if (last_update_time) {
		if (current_time < last_update_time + 1000000)
			return;
		else
			last_update_time = current_time;
	} else {
		last_update_time = current_time;
	}

	if (!elapsed_time)
		return;

	transfer_rate = actual_bytes_sent / elapsed_time;
	if (transfer_rate == 0)
		return;

	time_remaining = (byte_count - actual_bytes_sent) / transfer_rate;

	if (time_remaining >= 3600) {
		str = g_strdup_printf(_("(%d:%02d:%d Remaining)"), 
				      time_remaining / 3600,
				      (time_remaining % 3600) / 60,
				      (time_remaining % 3600) % 60);
	} else {
		str = g_strdup_printf(_("(%d:%02d Remaining)"), 
				      time_remaining / 60,
				      time_remaining % 60);
	}

	/* Translators:
	 * Sending file 1 of 3 */
	str2 = g_strdup_printf(_("Sending file %d of %d"),
			       current_file + 1,
			       file_count);
	progressbar_text = g_strconcat(str2, " ", str, NULL);
	gtk_progress_bar_set_text(GTK_PROGRESS_BAR(progress_bar),
				  progressbar_text);
	g_free(str);
	g_free(str2);
	g_free(progressbar_text);
}

static void transfer_completed_cb(DBusGProxy *proxy, gpointer user_data)
{
	current_file++;
	bytes_sent += file_length;

	g_idle_add((GSourceFunc) send_one, NULL);
}

static void session_created_cb(DBusGProxy *proxy, DBusGProxyCall *call, gpointer user_data)
{
	GError *error = NULL;
	const gchar *path = NULL;

	if (!dbus_g_proxy_end_call(proxy, call, &error,
				   DBUS_TYPE_G_OBJECT_PATH, &path, G_TYPE_INVALID)) {
		const gchar *error_name = NULL;
		gint response_id;

		if (error && error->code == DBUS_GERROR_REMOTE_EXCEPTION)
			error_name = dbus_g_error_get_name(error);
		if (error_name && !strcmp(error_name, "org.openobex.Error.ConnectionAttemptFailed")) {
			response_id = show_connection_error_dialog(GTK_WINDOW(main_dialog), bdaddrstr, error->message);
			if (response_id == DIALOG_RESPONSE_RETRY) {
				/* Try to create Session again */
				dbus_g_proxy_begin_call(manager_proxy,
							"CreateBluetoothSession",
							(DBusGProxyCallNotify) session_created_cb, NULL, NULL,
							G_TYPE_STRING, bdaddrstr, G_TYPE_STRING, "opp",
							G_TYPE_BOOLEAN, FALSE, G_TYPE_INVALID);
				goto out;
			}
		} else {
			show_error_dialog(GTK_WINDOW(main_dialog), BUTTONS_OK,
					  error->message, "");
		}

		/* Failed, quit main loop */
		gtk_main_quit();
		goto out;
	}

	session_proxy = dbus_g_proxy_new_for_name(connection,
						       "org.openobex",
						       path,
						       "org.openobex.Session");

	dbus_g_proxy_add_signal(session_proxy, "Connected",
				G_TYPE_INVALID);

	dbus_g_proxy_connect_signal(session_proxy, "Connected",
				    G_CALLBACK(session_connected_cb), NULL, NULL);

	dbus_g_proxy_add_signal(session_proxy, "TransferStarted",
				G_TYPE_STRING, G_TYPE_STRING, G_TYPE_UINT64, G_TYPE_INVALID);

	dbus_g_proxy_connect_signal(session_proxy, "TransferStarted",
				    G_CALLBACK(transfer_started_cb), NULL, NULL);

	dbus_g_proxy_add_signal(session_proxy, "Cancelled",
				G_TYPE_INVALID);

	dbus_g_proxy_connect_signal(session_proxy, "Cancelled",
				    G_CALLBACK(transfer_cancelled_cb), NULL, NULL);

	dbus_g_proxy_add_signal(session_proxy, "ErrorOccurred",
				G_TYPE_STRING, G_TYPE_STRING, G_TYPE_INVALID);

	dbus_g_proxy_connect_signal(session_proxy, "ErrorOccurred",
				    G_CALLBACK(error_occurred_cb), NULL, NULL);

	dbus_g_proxy_add_signal(session_proxy, "TransferProgress",
				G_TYPE_UINT64, G_TYPE_INVALID);

	dbus_g_proxy_connect_signal(session_proxy, "TransferProgress",
				    G_CALLBACK(transfer_progress_cb), NULL, NULL);

	dbus_g_proxy_add_signal(session_proxy, "TransferCompleted", 
				G_TYPE_INVALID);

	dbus_g_proxy_connect_signal(session_proxy, "TransferCompleted",
				    G_CALLBACK(transfer_completed_cb), NULL, NULL);

	dbus_g_proxy_call(session_proxy, "Connect", &error, G_TYPE_INVALID,
			  G_TYPE_INVALID);

out:
	if (error)
		g_error_free(error);
}

static void error_occurred_cb(DBusGProxy *proxy, const gchar *error_name, const gchar *error_message, gpointer user_data)
{
	gint ret;
	gboolean link_error = FALSE;
	gchar *error_text;
	const gchar *reason;

	g_message("ErrorOccurred");
	g_message("Error name: %s", error_name);
	g_message("Error message: %s", error_message);

	error_text = g_strdup_printf(_("An error occured while sending file '%s'"),
				     (gchar *)g_slist_nth_data(file_list, current_file));
	if (!strcmp(error_name, "org.openobex.Error.LinkError")) {
		/* Connection to remote device was lost */
		g_object_unref(G_OBJECT(session_proxy));
		reason = _("Connection to remote device was lost");
		link_error = TRUE;
	} else if (!strcmp(error_name, "org.openobex.Error.Forbidden")) {
		reason = _("Remote device rejected file");
	} else {
		reason = _("Unknown error");
	}
	ret = handle_file_sending_error(error_text, reason);

	if (ret != GTK_RESPONSE_CANCEL) {
		if (link_error) {
			/* Need to reestablish connection */
			dbus_g_proxy_begin_call(manager_proxy, "CreateBluetoothSession",
						(DBusGProxyCallNotify) session_created_cb, NULL, NULL,
						G_TYPE_STRING, bdaddrstr, G_TYPE_STRING, "opp",
						G_TYPE_INVALID);
		} else {
			g_idle_add((GSourceFunc) send_one, NULL);
		}
	}


	g_free(error_text);
}

static void free_mem(void)
{
	if (files_to_send)
		g_strfreev(files_to_send);
	g_free(bdaddrstr);

	if (main_dialog)
		gtk_widget_destroy (main_dialog);
	if (G_IS_OBJECT(manager_proxy))
		g_object_unref(G_OBJECT(manager_proxy));
	if (G_IS_OBJECT(session_proxy))
		g_object_unref (G_OBJECT(session_proxy));
	g_slist_free(file_list);
}

static void name_owner_changed(DBusGProxy *proxy, const char *name,
			const char *prev, const char *new, gpointer user_data)
{
	if (g_str_equal(name, "org.openobex") == TRUE && *new == '\0')
		gtk_main_quit();
}

int main(int argc, char *argv[])
{
	GOptionContext *option_context;
	GError *error = NULL;
	guint i;

	/* initialize gettext */
	bindtextdomain(GETTEXT_PACKAGE, LOCALEDIR);
	bind_textdomain_codeset(GETTEXT_PACKAGE, "UTF-8");
	textdomain(GETTEXT_PACKAGE);

	/* parse command line arguments */
	option_context = g_option_context_new("<file list>");
	g_option_context_add_main_entries(option_context, options, GETTEXT_PACKAGE);
	g_option_context_add_group(option_context, gtk_get_option_group(TRUE));
	g_option_context_parse(option_context, &argc, &argv, &error);
	g_option_context_free(option_context);
	if (error) {
		printf("Usage:\n");
		printf("  %s [--dest=BDADDR] <file list>\n", g_get_prgname());
		g_error_free(error);
		free_mem();
		return 0;
	}

	gtk_init(&argc, &argv);

	/* init DBus connection */
	connection = dbus_g_bus_get(DBUS_BUS_SESSION, &error);
	if (!connection) {
		show_error_dialog(NULL, GTK_BUTTONS_OK,
				  _("Please verify that D-Bus is correctly installed and setup."), error->message);
		g_error_free(error);
		return 1;
	}

	main_dialog = NULL;
	from_label = NULL;
	operation_label = NULL;
	progress_bar = NULL;

	/* get a list of files to send from command-line */
	if (files_to_send)
		file_count = g_strv_length(files_to_send);
	else
		file_count = 0;
	for (i = 0; i < file_count; i++) {
		file_list = g_slist_append(file_list,
						g_strdup(*(files_to_send + i)));
	}
	/* show file chooser if no files were specified */
	if (!file_count) {
		file_list = select_files_dialog();
		file_count = g_slist_length(file_list);
	}
	/* Check if there are some files to send */
	if (!file_count) {
		free_mem();
		return 0;
	}
	/* Check for non regular and non existand files and
	 * determine total bytes to send */
	for (i = 0; i < file_count; i++) {
		GSList *item;
		gchar *path, *filename;
		gint64 size;

		item = g_slist_nth(file_list, i);
		path = (gchar *) item->data;
		filename = normalise_filename(path, &size);
		if (filename == NULL) {
			g_free(path);
			file_list = g_slist_remove_link(file_list, item);
			continue;
		}
		g_free(item->data);
		item->data = filename;
		byte_count += size;
	}

	/* determine Bluetooth device to send to */
	if (!bdaddrstr) {
		bdaddrstr = browse_device_dialog();
		if (!bdaddrstr) {
			free_mem();
			return 0;
		}
	}

	dbus_g_object_register_marshaller(marshal_VOID__STRING_STRING_UINT64,
					  G_TYPE_NONE, G_TYPE_STRING,
					  G_TYPE_STRING, G_TYPE_UINT64, G_TYPE_INVALID);
	dbus_g_object_register_marshaller(marshal_VOID__STRING_STRING,
					  G_TYPE_NONE, G_TYPE_STRING,
					  G_TYPE_STRING, G_TYPE_INVALID);
	dbus_g_object_register_marshaller(marshal_VOID__UINT64,
					  G_TYPE_NONE, G_TYPE_UINT64, G_TYPE_INVALID);

	/* init UI */
	ui_init();

	/* init DBus proxy, create Session */
	manager_proxy = dbus_g_proxy_new_for_name(connection,
						       "org.openobex",
						       "/org/openobex",
						       "org.openobex.Manager");
	dbus_g_proxy_add_signal(manager_proxy, "NameOwnerChanged",
				G_TYPE_STRING, G_TYPE_STRING, G_TYPE_STRING, G_TYPE_INVALID);
	dbus_g_proxy_connect_signal(manager_proxy, "NameOwnerChanged",
				    G_CALLBACK(name_owner_changed), NULL, NULL);

	dbus_g_proxy_begin_call(manager_proxy, "CreateBluetoothSession",
				(DBusGProxyCallNotify) session_created_cb, NULL, NULL,
				G_TYPE_STRING, bdaddrstr, G_TYPE_STRING, "opp",
				G_TYPE_INVALID);

	/* Go into main loop */
	gtk_main();

	/* done sending, free memory */
	free_mem();

	return 0;
}


--=-nHm3Bvzb/Xkf9aTNYFm/
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--=-nHm3Bvzb/Xkf9aTNYFm/
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--=-nHm3Bvzb/Xkf9aTNYFm/--
