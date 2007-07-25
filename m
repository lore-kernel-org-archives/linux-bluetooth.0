Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Bastien Nocera <hadess@hadess.net>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1185311973.7111.77.camel@violet>
References: <1185295124.3641.148.camel@cookie.hadess.net>
	<1185311973.7111.77.camel@violet>
Content-Type: multipart/mixed; boundary="=-31R9vfZz8YK/DMmXItiA"
Date: Wed, 25 Jul 2007 17:09:47 +0100
Message-Id: <1185379787.3641.260.camel@cookie.hadess.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] [PATCH] Implement browse callback in the applet
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


--=-31R9vfZz8YK/DMmXItiA
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, 2007-07-24 at 23:19 +0200, Marcel Holtmann wrote:
> Hi Bastien,
> 
> > The patch implements the browse callback for the applet. It hardcodes
> > the use of nautilus, but we should probably also check for nautilus in
> > the obexftp_available().
> > 
> > It also fixes a popup menu being created _each time_ someone
> > right-clicks on the bluetooth applet.
> 
> can you split this into two patches. They are both two independent
> things.

And the left-over of that patch. Uses the new functionality from the
BluetoothDeviceSelection widget.

-- 
Bastien Nocera <hadess@hadess.net> 

--=-31R9vfZz8YK/DMmXItiA
Content-Disposition: attachment;
	filename=bluez-gnome-implement-browse-callback-3.patch
Content-Type: text/x-patch; name=bluez-gnome-implement-browse-callback-3.patch;
	charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Index: applet/Makefile.am
===================================================================
RCS file: /cvsroot/bluez/gnome/applet/Makefile.am,v
retrieving revision 1.19
diff -u -p -r1.19 Makefile.am
--- applet/Makefile.am	22 Jul 2007 16:06:05 -0000	1.19
+++ applet/Makefile.am	25 Jul 2007 15:49:12 -0000
@@ -4,7 +4,8 @@ bin_PROGRAMS = bluetooth-applet
 bluetooth_applet_SOURCES = main.c
 
 bluetooth_applet_LDADD = @NOTIFY_LIBS@ @GCONF_LIBS@ \
-		@GTK_LIBS@ @HAL_LIBS@ @DBUS_LIBS@
+		@GTK_LIBS@ @HAL_LIBS@ @DBUS_LIBS@ \
+		$(top_builddir)/common/libcommon.a
 
 nodist_bluetooth_applet_SOURCES = \
 		$(top_builddir)/common/passkey-agent-glue.h \
Index: applet/main.c
===================================================================
RCS file: /cvsroot/bluez/gnome/applet/main.c,v
retrieving revision 1.70
diff -u -p -r1.70 main.c
--- applet/main.c	25 Jul 2007 14:03:50 -0000	1.70
+++ applet/main.c	25 Jul 2007 15:49:13 -0000
@@ -48,6 +48,8 @@
 #include <libnotify/notify.h>
 #endif
 
+#include "bluetooth-device-selection.h"
+
 #define PASSKEY_AGENT_PATH	"/org/bluez/passkey"
 #define AUTH_AGENT_PATH		"/org/bluez/auth"
 
@@ -1486,8 +1525,50 @@ static void settings_callback(GObject *w
 		g_printerr("Couldn't execute command: %s\n", command);
 }
 
+static void selected_device_changed(BluetoothDeviceSelection *sel, gchar *address, gpointer user_data)
+{
+	GtkDialog *dialog = user_data;
+
+	gtk_dialog_set_response_sensitive(dialog, GTK_RESPONSE_ACCEPT, address != NULL);
+}
+
 static void browse_callback(GObject *widget, gpointer user_data)
 {
+	GtkWidget *dialog, *selector;
+	char *address, *command;
+
+	dialog = gtk_dialog_new_with_buttons(_("Browse devices"),
+					     NULL,
+					     GTK_DIALOG_NO_SEPARATOR,
+					     GTK_STOCK_CANCEL,
+					     GTK_RESPONSE_REJECT,
+					     GTK_STOCK_CONNECT,
+					     GTK_RESPONSE_ACCEPT,
+					     NULL);
+	gtk_dialog_set_response_sensitive(GTK_DIALOG(dialog), GTK_RESPONSE_ACCEPT, FALSE);
+	gtk_window_set_default_size(GTK_WINDOW(dialog), 400, 300);
+
+	/* Add the selector widget */
+	selector = bluetooth_device_selection_new(_("Select device to browse."));
+	gtk_container_add(GTK_CONTAINER(GTK_DIALOG(dialog)->vbox), selector);
+	gtk_widget_show(selector);
+	g_signal_connect(selector, "selected-device-changed",
+			 G_CALLBACK(selected_device_changed), dialog);
+
+	if (gtk_dialog_run(GTK_DIALOG(dialog)) != GTK_RESPONSE_ACCEPT) {
+		gtk_widget_destroy(dialog);
+		return;
+	}
+
+	g_object_get(selector, "device-selected", &address, NULL);
+	gtk_widget_destroy(dialog);
+
+	command = g_strdup_printf("nautilus --no-default-window \"obex://[%s]\"", address);
+	g_free(address);
+
+	if (!g_spawn_command_line_async(command, NULL))
+		g_printerr(_("Couldn't execute command: %s\n"), command);
+	g_free(command);
 }
 
 #if 0

--=-31R9vfZz8YK/DMmXItiA
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
--=-31R9vfZz8YK/DMmXItiA
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--=-31R9vfZz8YK/DMmXItiA--
