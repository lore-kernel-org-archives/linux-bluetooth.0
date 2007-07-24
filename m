Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Bastien Nocera <hadess@hadess.net>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1185311973.7111.77.camel@violet>
References: <1185295124.3641.148.camel@cookie.hadess.net>
	<1185311973.7111.77.camel@violet>
Content-Type: multipart/mixed; boundary="=-aogqUny5bs6Y6/kgLGrA"
Date: Tue, 24 Jul 2007 22:54:24 +0100
Message-Id: <1185314064.3641.186.camel@cookie.hadess.net>
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


--=-aogqUny5bs6Y6/kgLGrA
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

I guess the actual browse menu item implementation will have to wait for
the other patches to be done. This patch should apply with some fuzz.

-- 
Bastien Nocera <hadess@hadess.net> 

--=-aogqUny5bs6Y6/kgLGrA
Content-Disposition: attachment; filename=bluez-gnome-fix-menu-leak.patch
Content-Type: text/x-patch; name=bluez-gnome-fix-menu-leak.patch;
	charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Index: main.c
===================================================================
RCS file: /cvsroot/bluez/gnome/applet/main.c,v
retrieving revision 1.67
diff -u -p -r1.67 main.c
--- main.c	24 Jul 2007 15:19:33 -0000	1.67
+++ main.c	24 Jul 2007 16:43:26 -0000
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

--=-aogqUny5bs6Y6/kgLGrA
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
--=-aogqUny5bs6Y6/kgLGrA
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--=-aogqUny5bs6Y6/kgLGrA--
