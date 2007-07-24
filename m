Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Bastien Nocera <hadess@hadess.net>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1185295124.3641.148.camel@cookie.hadess.net>
References: <1185295124.3641.148.camel@cookie.hadess.net>
Content-Type: multipart/mixed; boundary="=-vmsN9yvQ1hT3/TJGR1MD"
Date: Tue, 24 Jul 2007 17:44:28 +0100
Message-Id: <1185295468.3641.153.camel@cookie.hadess.net>
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


--=-vmsN9yvQ1hT3/TJGR1MD
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, 2007-07-24 at 17:38 +0100, Bastien Nocera wrote:
<snip>
> It also fixes a popup menu being created _each time_ someone
> right-clicks on the bluetooth applet.

Updated version with the above fixed properly.

-- 
Bastien Nocera <hadess@hadess.net> 

--=-vmsN9yvQ1hT3/TJGR1MD
Content-Disposition: attachment;
	filename=bluez-gnome-implement-browse-callback-2.patch
Content-Type: text/x-patch; name=bluez-gnome-implement-browse-callback-2.patch;
	charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Index: Makefile.am
===================================================================
RCS file: /cvsroot/bluez/gnome/applet/Makefile.am,v
retrieving revision 1.19
diff -u -p -r1.19 Makefile.am
--- Makefile.am	22 Jul 2007 16:06:05 -0000	1.19
+++ Makefile.am	24 Jul 2007 16:43:25 -0000
@@ -4,7 +4,8 @@ bin_PROGRAMS = bluetooth-applet
 bluetooth_applet_SOURCES = main.c
 
 bluetooth_applet_LDADD = @NOTIFY_LIBS@ @GCONF_LIBS@ \
-		@GTK_LIBS@ @HAL_LIBS@ @DBUS_LIBS@
+		@GTK_LIBS@ @HAL_LIBS@ @DBUS_LIBS@ \
+		$(top_builddir)/common/libcommon.a
 
 nodist_bluetooth_applet_SOURCES = \
 		$(top_builddir)/common/passkey-agent-glue.h \
Index: main.c
===================================================================
RCS file: /cvsroot/bluez/gnome/applet/main.c,v
retrieving revision 1.67
diff -u -p -r1.67 main.c
--- main.c	24 Jul 2007 15:19:33 -0000	1.67
+++ main.c	24 Jul 2007 16:43:26 -0000
@@ -47,6 +47,8 @@
 #include <libnotify/notify.h>
 #endif
 
+#include "device-selector.h"
+
 #define PASSKEY_AGENT_PATH	"/org/bluez/passkey"
 #define AUTH_AGENT_PATH		"/org/bluez/auth"
 
@@ -1229,6 +1231,7 @@ static char *get_form_factor(void)
 
 	return formfactor;
 }
+
 static void adapter_setup(gpointer data, gpointer user_data)
 {
 	struct adapter_data *adapter = data;
@@ -1481,8 +1484,53 @@ static void settings_callback(GObject *w
 		g_printerr("Couldn't execute command: %s\n", command);
 }
 
+static void device_selected_callback(GObject *object, GParamSpec *spec, gpointer user_data)
+{
+	GtkDialog *dialog = user_data;
+	char *address;
+
+	g_object_get(object, "device-selected", &address, NULL);
+	gtk_dialog_set_response_sensitive(dialog, GTK_RESPONSE_ACCEPT, address != NULL);
+	g_free(address);
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
+	selector = bluetooth_device_selector_new(_("Select device to browse."));
+	gtk_container_add(GTK_CONTAINER(GTK_DIALOG(dialog)->vbox), selector);
+	gtk_widget_show(selector);
+	g_signal_connect(selector, "notify::device-selected",
+			 G_CALLBACK(device_selected_callback), dialog);
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
@@ -1507,9 +1555,13 @@ static void activate_callback(GObject *w
 static void popup_callback(GObject *widget, guint button,
 				guint activate_time, gpointer user_data)
 {
-	GtkWidget *menu;
+	static GtkWidget *menu = NULL;
+	static GtkWidget *browse_item = NULL;
 	GtkWidget *item;
 
+	if (menu != NULL)
+		goto popup;
+
 	menu = gtk_menu_new();
 
 	item = gtk_image_menu_item_new_from_stock(GTK_STOCK_PREFERENCES, NULL);
@@ -1528,14 +1580,11 @@ static void popup_callback(GObject *widg
 	gtk_widget_show(item);
 	gtk_menu_shell_append(GTK_MENU_SHELL(menu), item);
 
-	item = gtk_image_menu_item_new_with_label(_("Browse device..."));
-	g_signal_connect(item, "activate",
+	browse_item = gtk_image_menu_item_new_with_label(_("Browse device..."));
+	g_signal_connect(browse_item, "activate",
 				G_CALLBACK(browse_callback), NULL);
-	gtk_widget_show(item);
-	gtk_menu_shell_append(GTK_MENU_SHELL(menu), item);
-
-	gtk_widget_set_sensitive(item, obexftp_available() &&
-						attached_adapters() > 0);
+	gtk_widget_show(browse_item);
+	gtk_menu_shell_append(GTK_MENU_SHELL(menu), browse_item);
 
 #if 0
 	item = gtk_separator_menu_item_new();
@@ -1549,6 +1598,10 @@ static void popup_callback(GObject *widg
 	gtk_menu_shell_append(GTK_MENU_SHELL(menu), item);
 #endif
 
+popup:
+	gtk_widget_set_sensitive(browse_item, obexftp_available() &&
+						attached_adapters() > 0);
+
 	gtk_menu_popup(GTK_MENU(menu), NULL, NULL,
 			gtk_status_icon_position_menu,
 			GTK_STATUS_ICON(widget), button, activate_time);

--=-vmsN9yvQ1hT3/TJGR1MD
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
--=-vmsN9yvQ1hT3/TJGR1MD
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--=-vmsN9yvQ1hT3/TJGR1MD--
