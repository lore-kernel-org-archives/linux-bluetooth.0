Return-Path: <cyrus@holtmann.org>
From: Bastien Nocera <hadess@hadess.net>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="=-qmSz/twJvdbJiX9XqKDi"
Date: Thu, 17 Jan 2008 10:43:22 +0000
Message-Id: <1200566602.26259.89.camel@cookie.hadess.net>
Mime-Version: 1.0
Subject: [Bluez-devel] [PATCH] Allow multiple files to be sent
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


--=-qmSz/twJvdbJiX9XqKDi
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Heya,

Another for bluetooth-sento feature parity with gnome-obex-send.

This one adds support for sending multiple files, change the
command-line option to match those of gnome-obex-send, as well as add a
TODO list at the top of the file.

Cheers

--=-qmSz/twJvdbJiX9XqKDi
Content-Disposition: attachment;
	filename=bluez-gnome-sendto-multiple-files.patch
Content-Type: text/x-patch; name=bluez-gnome-sendto-multiple-files.patch;
	charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Index: main.c
===================================================================
RCS file: /cvsroot/bluez/gnome/sendto/main.c,v
retrieving revision 1.11
diff -u -p -r1.11 main.c
--- main.c	22 Dec 2007 00:09:17 -0000	1.11
+++ main.c	17 Jan 2008 10:43:01 -0000
@@ -21,6 +21,15 @@
  *
  */
 
+/* TODO
+ * - Fix passing URIs and relative paths as options
+ * - Special nice error for Palm Pilots
+ * - Support cancelling a transfer from the phone
+ * - Show the remote device name if possible
+ * - Truncate long filenames nicely for remote devices
+ * - Close button should be "Cancel" during operations
+ */
+
 #ifdef HAVE_CONFIG_H
 #include <config.h>
 #endif
@@ -42,24 +51,40 @@ static GtkWidget *label_filename;
 static GtkWidget *label_status;
 static GtkWidget *progress;
 
-static gint filesize = -1;
+static guint64 filesize = -1;
+static guint current_file = 0;
 
-static gchar *open_file_dialog(void)
+static gchar **open_file_dialog(void)
 {
 	GtkWidget *dialog;
-	gchar *filename = NULL;
+	GSList *list, *l;
+	gchar **filenames = NULL;
 
 	dialog = gtk_file_chooser_dialog_new(_("Select File"), NULL,
 				GTK_FILE_CHOOSER_ACTION_OPEN,
 				GTK_STOCK_CANCEL, GTK_RESPONSE_CANCEL,
 				GTK_STOCK_OPEN, GTK_RESPONSE_ACCEPT, NULL);
+	gtk_file_chooser_set_select_multiple(GTK_FILE_CHOOSER(dialog), TRUE);
 
-	if (gtk_dialog_run(GTK_DIALOG(dialog)) == GTK_RESPONSE_ACCEPT)
-		filename = gtk_file_chooser_get_filename(GTK_FILE_CHOOSER(dialog));
+	if (gtk_dialog_run(GTK_DIALOG(dialog)) == GTK_RESPONSE_ACCEPT) {
+		GPtrArray *array;
+
+		list = gtk_file_chooser_get_filenames(GTK_FILE_CHOOSER(dialog));
+		if (list == NULL) {
+			gtk_widget_destroy(dialog);
+			return NULL;
+		}
+		array = g_ptr_array_new();
+		for (l = list; l != NULL; l = l->next)
+			g_ptr_array_add(array, l->data);
+		g_slist_free(list);
+
+		filenames = (char **) array;
+	}
 
 	gtk_widget_destroy(dialog);
 
-	return filename;
+	return filenames;
 }
 
 static void selected_device_changed(BluetoothDeviceSelection *selector,
@@ -114,11 +139,32 @@ static void response_callback(GtkWidget 
 	gtk_main_quit();
 }
 
+static void set_filename(GtkWidget *label, const gchar *filename)
+{
+	gchar *display, *text;
+
+	if (g_str_has_prefix(filename, "file:///") != FALSE) {
+		gchar *local;
+
+		local = g_filename_from_uri(filename, NULL, NULL);
+		display = g_filename_display_basename(local);
+		g_free (local);
+	} else if (filename[0] == '/') {
+		display = g_filename_display_basename(filename);
+	} else {
+		display = g_filename_display_name(filename);
+	}
+
+	text = g_strdup_printf("<b>%s</b>", display);
+	g_free(display);
+	gtk_label_set_markup(GTK_LABEL(label), text);
+	g_free(text);
+}
+
 static void create_window(const gchar *filename)
 {
 	GtkWidget *vbox;
 	GtkWidget *label;
-	gchar *text;
 
 	dialog = gtk_dialog_new_with_buttons(_("File Transfer"), NULL,
 				GTK_DIALOG_NO_SEPARATOR,
@@ -147,9 +193,7 @@ static void create_window(const gchar *f
 
 	label_status = label;
 
-	text = g_strdup_printf("<b>%s</b>", filename);
-	gtk_label_set_markup(GTK_LABEL(label_filename), text);
-	g_free(text);
+	set_filename(label_filename, filename);
 
 	gtk_label_set_markup(GTK_LABEL(label_status), _("Connecting..."));
 
@@ -181,7 +225,7 @@ static void transfer_progress(DBusGProxy
 	gchar *text;
 	gdouble fraction;
 
-	text = g_strdup_printf(_("Transfered %d of %d bytes"), bytes, filesize);
+	text = g_strdup_printf(_("Transfered %d of %"G_GUINT64_FORMAT" bytes"), bytes, filesize);
 	gtk_label_set_markup(GTK_LABEL(label_status), text);
 	g_free(text);
 
@@ -191,30 +235,51 @@ static void transfer_progress(DBusGProxy
 
 static void transfer_completed(DBusGProxy *proxy, gpointer user_data)
 {
+	gchar **filenames = user_data;
+
 	gtk_label_set_markup(GTK_LABEL(label_status), _("Completed"));
 
 	gtk_progress_bar_set_fraction(GTK_PROGRESS_BAR(progress), 1.0);
 
-	dbus_g_proxy_call(proxy, "Disconnect", NULL, G_TYPE_INVALID,
-							G_TYPE_INVALID);
+	current_file++;
 
-	gtk_dialog_set_response_sensitive(GTK_DIALOG(dialog),
+	/* Any more files to process? */
+	if (filenames[current_file] != NULL) {
+		GError *error = NULL;
+
+		//FIXME process filename to a proper local path
+		set_filename(label_filename, filenames[current_file]);
+		dbus_g_proxy_call(proxy, "SendFile", &error,
+					G_TYPE_STRING, filenames[current_file], G_TYPE_INVALID,
+								G_TYPE_INVALID);
+
+		if (error != NULL) {
+			g_printerr("Sending of file %s failed: %s\n", filenames[current_file],
+							error->message);
+			g_error_free(error);
+			gtk_main_quit();
+		}
+	} else {
+		dbus_g_proxy_call(proxy, "Disconnect", NULL, G_TYPE_INVALID,
+						G_TYPE_INVALID);
+		gtk_dialog_set_response_sensitive(GTK_DIALOG(dialog),
 						GTK_RESPONSE_CLOSE, TRUE);
+	}
 }
 
 static void session_connected(DBusGProxy *proxy, gpointer user_data)
 {
-	gchar *filename = user_data;
+	gchar **filenames = user_data;
 	GError *error = NULL;
 
 	gtk_label_set_markup(GTK_LABEL(label_status), _("Connected"));
 
 	dbus_g_proxy_call(proxy, "SendFile", &error,
-				G_TYPE_STRING, filename, G_TYPE_INVALID,
+				G_TYPE_STRING, filenames[current_file], G_TYPE_INVALID,
 							G_TYPE_INVALID);
 
 	if (error != NULL) {
-		g_printerr("Sending of file %s failed: %s\n", filename,
+		g_printerr("Sending of file %s failed: %s\n", filenames[current_file],
 							error->message);
 		g_error_free(error);
 		gtk_main_quit();
@@ -261,7 +326,7 @@ static void create_notify(DBusGProxy *pr
 				G_TYPE_STRING, G_TYPE_INT, G_TYPE_INVALID);
 
 	dbus_g_proxy_connect_signal(proxy, "TransferStarted",
-				G_CALLBACK(transfer_started), NULL, NULL);
+				G_CALLBACK(transfer_started), user_data, NULL);
 
 	dbus_g_proxy_add_signal(proxy, "TransferProgress",
 						G_TYPE_UINT, G_TYPE_INVALID);
@@ -272,17 +337,20 @@ static void create_notify(DBusGProxy *pr
 	dbus_g_proxy_add_signal(proxy, "TransferCompleted", G_TYPE_INVALID);
 
 	dbus_g_proxy_connect_signal(proxy, "TransferCompleted",
-				G_CALLBACK(transfer_completed), NULL, NULL);
+				G_CALLBACK(transfer_completed), user_data, NULL);
 
 	dbus_g_proxy_call(proxy, "Connect", NULL, G_TYPE_INVALID,
 							G_TYPE_INVALID);
 }
 
 static gchar *option_device = NULL;
+static gchar **filenames = NULL;
 
 static GOptionEntry options[] = {
-	{ "device", 0, 0, G_OPTION_ARG_STRING, &option_device,
-				N_("Remote device to use"), "ADDRESS" },
+	{ "dest", 'd', 0, G_OPTION_ARG_STRING, &option_device,
+		N_("Remote device to use"), "ADDRESS" },
+	{ G_OPTION_REMAINING, '\0', 0, G_OPTION_ARG_FILENAME_ARRAY, &filenames,
+		N_("Files to send"), NULL},
 	{ NULL },
 };
 
@@ -290,7 +358,7 @@ int main(int argc, char *argv[])
 {
 	DBusGProxy *proxy;
 	GError *error;
-	gchar *filename, *address;
+	gchar *address;
 
 	bindtextdomain(GETTEXT_PACKAGE, LOCALEDIR);
 	bind_textdomain_codeset(GETTEXT_PACKAGE, "UTF-8");
@@ -298,7 +366,7 @@ int main(int argc, char *argv[])
 
 	error = NULL;
 
-	if (gtk_init_with_args(&argc, &argv, "[FILE...]",
+	if (gtk_init_with_args(&argc, &argv, "[FILENAMES...]",
 				options, GETTEXT_PACKAGE, &error) == FALSE) {
 		if (error != NULL) {
 			g_printerr("%s\n", error->message);
@@ -311,17 +379,15 @@ int main(int argc, char *argv[])
 
 	gtk_window_set_default_icon_name("stock_bluetooth");
 
-	if (argc < 2) {
-		filename = open_file_dialog();
-		if (filename == NULL)
+	if (filenames == NULL) {
+		filenames = open_file_dialog();
+		if (filenames == NULL)
 			gtk_exit(1);
-	} else
-		filename = g_strdup(argv[1]);
+	}
 
 	if (option_device == NULL) {
 		address = browse_device_dialog();
 		if (address == NULL) {
-			g_free(filename);
 			gtk_exit(1);
 		}
 	} else
@@ -345,22 +411,22 @@ int main(int argc, char *argv[])
 		gtk_exit(1);
 	}
 
-	create_window(filename);
+	create_window(filenames[0]);
 
 	proxy = dbus_g_proxy_new_for_name(conn, "org.openobex",
 				"/org/openobex", "org.openobex.Manager");
 
 	dbus_g_proxy_begin_call(proxy, "CreateBluetoothSession",
-				create_notify, filename, NULL,
+				create_notify, filenames, NULL,
 				G_TYPE_STRING, address, G_TYPE_STRING, "opp",
-				G_TYPE_BOOLEAN, FALSE, G_TYPE_INVALID);
+				G_TYPE_INVALID);
 
 	gtk_main();
 
 	dbus_g_connection_unref(conn);
 
 	g_free(address);
-	g_free(filename);
+	g_strfreev(filenames);
 
 	return 0;
 }

--=-qmSz/twJvdbJiX9XqKDi
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--=-qmSz/twJvdbJiX9XqKDi
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--=-qmSz/twJvdbJiX9XqKDi--
