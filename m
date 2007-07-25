Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Bastien Nocera <hadess@hadess.net>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1185314064.3641.186.camel@cookie.hadess.net>
References: <1185295124.3641.148.camel@cookie.hadess.net>
	<1185311973.7111.77.camel@violet>
	<1185314064.3641.186.camel@cookie.hadess.net>
Content-Type: multipart/mixed; boundary="=-xP2R/bcm/OYdOg3cwckB"
Date: Wed, 25 Jul 2007 14:43:01 +0100
Message-Id: <1185370981.3641.243.camel@cookie.hadess.net>
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


--=-xP2R/bcm/OYdOg3cwckB
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, 2007-07-24 at 22:54 +0100, Bastien Nocera wrote:
> On Tue, 2007-07-24 at 23:19 +0200, Marcel Holtmann wrote:
<snip>
> I guess the actual browse menu item implementation will have to wait for
> the other patches to be done. This patch should apply with some fuzz.

Same one with a global instead of a static. Should apply with extra fuzz
as well.

-- 
Bastien Nocera <hadess@hadess.net> 

--=-xP2R/bcm/OYdOg3cwckB
Content-Disposition: attachment; filename=bluez-gnome-fix-menu-leak-2.patch
Content-Type: text/x-patch; name=bluez-gnome-fix-menu-leak-2.patch;
	charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Index: main.c
===================================================================
RCS file: /cvsroot/bluez/gnome/applet/main.c,v
retrieving revision 1.69
diff -u -p -r1.69 main.c
--- main.c	25 Jul 2007 11:18:09 -0000	1.69
+++ main.c	25 Jul 2007 13:39:33 -0000
@@ -60,6 +62,9 @@ static gboolean use_hal = FALSE;
 
 static GList *adapter_list = NULL;
 
+static GtkWidget *menu = NULL;
+static GtkWidget *browse_item = NULL;
+
 struct adapter_data {
 	char *path;
 	int attached;
@@ -1510,9 +1560,11 @@ static void activate_callback(GObject *w
 static void popup_callback(GObject *widget, guint button,
 				guint activate_time, gpointer user_data)
 {
-	GtkWidget *menu;
 	GtkWidget *item;
 
+	if (menu != NULL)
+		goto popup;
+
 	menu = gtk_menu_new();
 
 	item = gtk_image_menu_item_new_from_stock(GTK_STOCK_PREFERENCES, NULL);
@@ -1531,14 +1583,11 @@ static void popup_callback(GObject *widg
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
@@ -1552,6 +1601,10 @@ static void popup_callback(GObject *widg
 	gtk_menu_shell_append(GTK_MENU_SHELL(menu), item);
 #endif
 
+popup:
+	gtk_widget_set_sensitive(browse_item, obexftp_available() &&
+						attached_adapters() > 0);
+
 	gtk_menu_popup(GTK_MENU(menu), NULL, NULL,
 			gtk_status_icon_position_menu,
 			GTK_STATUS_ICON(widget), button, activate_time);
@@ -1685,6 +1738,10 @@ int main(int argc, char *argv[])
 	gtk_main();
 
 	g_object_unref(gconf);
+	if (menu)
+		g_object_unref(menu);
+	if (browse_item)
+		g_object_unref(browse_item);
 
 	close_notification();
 

--=-xP2R/bcm/OYdOg3cwckB
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
--=-xP2R/bcm/OYdOg3cwckB
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--=-xP2R/bcm/OYdOg3cwckB--
