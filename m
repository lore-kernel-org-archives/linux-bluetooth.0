Return-Path: <cyrus@holtmann.org>
From: Bastien Nocera <hadess@hadess.net>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="=-78eV+lJnfIzEJ2iyNBo+"
Date: Fri, 12 Sep 2008 18:25:07 +0100
Message-Id: <1221240307.24928.279.camel@cookie.hadess.net>
Mime-Version: 1.0
Subject: [Bluez-devel] Couple of patches for bluez/bluez-gnome
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


--=-78eV+lJnfIzEJ2iyNBo+
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Cheers

--=-78eV+lJnfIzEJ2iyNBo+
Content-Disposition: attachment;
	filename=0001-Reorder-popup-menu-and-clarify-some-menu-items.patch
Content-Type: application/mbox;
	name=0001-Reorder-popup-menu-and-clarify-some-menu-items.patch
Content-Transfer-Encoding: 7bit

>>From 61e758711e81804514c999bf08d278858aa01705 Mon Sep 17 00:00:00 2001
From: Bastien Nocera <hadess@hadess.net>
Date: Fri, 12 Sep 2008 17:32:00 +0100
Subject: [PATCH] Reorder popup menu, and clarify some menu items

* Reorder the menu to have the about menu item at the bottom (I'd remove
it completely, as the properties window should already have credits in
the UI itself)
* Add ellipsis for menu items that open up new dialogues
* Make sure that "browse device" is clarified as browsing for files, all
the users seem to be mistaken thinking it might pairing their audio
headsets...
* Remove a separator, there's enough of them as it is
---
 applet/main.c |   20 +++++++++-----------
 1 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/applet/main.c b/applet/main.c
index 8dec5a6..5cf6a18 100644
--- a/applet/main.c
+++ b/applet/main.c
@@ -183,7 +183,7 @@ static void browse_callback(GObject *widget, gpointer user_data)
 	GtkWidget *dialog;
 	GtkWidget *selector;
 
-	dialog = gtk_dialog_new_with_buttons(_("Browse Devices"),
+	dialog = gtk_dialog_new_with_buttons(_("Browse Files on Device"),
 				NULL, GTK_DIALOG_NO_SEPARATOR,
 				GTK_STOCK_CANCEL, GTK_RESPONSE_REJECT,
 				GTK_STOCK_CONNECT, GTK_RESPONSE_ACCEPT, NULL);
@@ -285,12 +285,6 @@ static GtkWidget *create_popupmenu(void)
 	gtk_widget_show(item);
 	gtk_menu_shell_append(GTK_MENU_SHELL(menu), item);
 
-	item = gtk_image_menu_item_new_from_stock(GTK_STOCK_ABOUT, NULL);
-	g_signal_connect(item, "activate",
-				G_CALLBACK(about_callback), NULL);
-	gtk_widget_show(item);
-	gtk_menu_shell_append(GTK_MENU_SHELL(menu), item);
-
 	item = gtk_separator_menu_item_new();
 	gtk_widget_show(item);
 	gtk_menu_shell_append(GTK_MENU_SHELL(menu), item);
@@ -302,9 +296,8 @@ static GtkWidget *create_popupmenu(void)
 	gtk_menu_shell_append(GTK_MENU_SHELL(menu), item);
 
 	menuitem_sendto = item;
-
 #if 0
-	item = gtk_image_menu_item_new_with_label(_("Browse Device..."));
+	item = gtk_image_menu_item_new_with_label(_("Browse files on device..."));
 	g_signal_connect(item, "activate",
 				G_CALLBACK(browse_callback), NULL);
 	gtk_widget_show(item);
@@ -312,14 +305,19 @@ static GtkWidget *create_popupmenu(void)
 
 	menuitem_browse = item;
 #endif
+	item = gtk_menu_item_new_with_label(_("Setup new device.."));
+	g_signal_connect(item, "activate",
+				G_CALLBACK(wizard_callback), NULL);
+	gtk_widget_show(item);
+	gtk_menu_shell_append(GTK_MENU_SHELL(menu), item);
 
 	item = gtk_separator_menu_item_new();
 	gtk_widget_show(item);
 	gtk_menu_shell_append(GTK_MENU_SHELL(menu), item);
 
-	item = gtk_menu_item_new_with_label(_("Setup New Device"));
+	item = gtk_image_menu_item_new_from_stock(GTK_STOCK_ABOUT, NULL);
 	g_signal_connect(item, "activate",
-				G_CALLBACK(wizard_callback), NULL);
+				G_CALLBACK(about_callback), NULL);
 	gtk_widget_show(item);
 	gtk_menu_shell_append(GTK_MENU_SHELL(menu), item);
 
-- 
1.6.0.1


--=-78eV+lJnfIzEJ2iyNBo+
Content-Disposition: attachment;
	filename=0001-Fix-the-adapter-name-never-getting-saved.patch
Content-Type: application/mbox;
	name=0001-Fix-the-adapter-name-never-getting-saved.patch
Content-Transfer-Encoding: 7bit

>>From dfc9c609513799087f506fa7d236033a79dac407 Mon Sep 17 00:00:00 2001
From: Bastien Nocera <hadess@hadess.net>
Date: Fri, 12 Sep 2008 17:15:01 +0100
Subject: [PATCH] Fix the adapter name never getting saved

Unless you modify the adapter name, it will never be saved on startup,
and bluez-gnome will get an empty adapter name.
---
 src/adapter.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 301fb36..ac41c7e 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2401,6 +2401,8 @@ int adapter_start(struct btd_adapter *adapter)
 
 	memcpy(dev->name, name, 248);
 
+	write_local_name(&di.bdaddr, name);
+
 	if (!(features[6] & LMP_SIMPLE_PAIR))
 		goto setup;
 
-- 
1.6.0.1


--=-78eV+lJnfIzEJ2iyNBo+
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
--=-78eV+lJnfIzEJ2iyNBo+
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--=-78eV+lJnfIzEJ2iyNBo+--
