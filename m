Return-Path: <cyrus@holtmann.org>
From: Bastien Nocera <hadess@hadess.net>
To: BlueZ Hackers <bluez-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="=-Z77TXD4yehVL2j5iAGxw"
Date: Fri, 01 Feb 2008 15:28:55 +0000
Message-Id: <1201879735.2389.332.camel@cookie.hadess.net>
Mime-Version: 1.0
Subject: [Bluez-devel] [PATCH] Require libnotify
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


--=-Z77TXD4yehVL2j5iAGxw
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Heya,

Patch to make libnotify be required for the applet, which means we can
be sure that the applet will have UI for the agents.

Cheers

--=-Z77TXD4yehVL2j5iAGxw
Content-Disposition: attachment; filename=bluez-gnome-require-libnotify.patch
Content-Type: text/x-patch; name=bluez-gnome-require-libnotify.patch;
	charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Index: README
===================================================================
RCS file: /cvsroot/bluez/gnome/README,v
retrieving revision 1.7
diff -u -p -u -p -r1.7 README
--- README	5 Aug 2007 14:37:11 -0000	1.7
+++ README	1 Feb 2008 15:25:40 -0000
@@ -14,6 +14,7 @@ In order to compile Bluetooth helpers yo
 	- GCC compiler
 	- D-Bus library
 	- GTK+ library
+	- libnotify
 
 To configure run:
 	./configure --prefix=/usr --mandir=/usr/share/man --sysconfdir=/etc
Index: configure.in
===================================================================
RCS file: /cvsroot/bluez/gnome/configure.in,v
retrieving revision 1.57
diff -u -p -u -p -r1.57 configure.in
--- configure.in	26 Dec 2007 12:02:30 -0000	1.57
+++ configure.in	1 Feb 2008 15:25:40 -0000
@@ -62,9 +62,7 @@ PKG_CHECK_MODULES(GCONF, gconf-2.0 >= 2.
 AC_SUBST(GCONF_CFLAGS)
 AC_SUBST(GCONF_LIBS)
 
-PKG_CHECK_MODULES(NOTIFY, libnotify >= 0.3.2, [
-	AC_DEFINE(HAVE_LIBNOTIFY, 1, [Define to 1 if you have libnotify support.])
-], dummy=no)
+PKG_CHECK_MODULES(NOTIFY, libnotify >= 0.3.2, dummy=yes, AC_MSG_ERROR(libnotify is required))
 AC_SUBST(NOTIFY_CFLAGS)
 AC_SUBST(NOTIFY_LIBS)
 
Index: applet/main.c
===================================================================
RCS file: /cvsroot/bluez/gnome/applet/main.c,v
retrieving revision 1.97
diff -u -p -u -p -r1.97 main.c
--- applet/main.c	1 Feb 2008 12:51:35 -0000	1.97
+++ applet/main.c	1 Feb 2008 15:25:40 -0000
@@ -43,10 +43,7 @@
 #include <glib/gi18n.h>
 
 #include <gtk/gtk.h>
-
-#ifdef HAVE_LIBNOTIFY
 #include <libnotify/notify.h>
-#endif
 
 #include "bluetooth-instance.h"
 #include "bluetooth-device-selection.h"
@@ -640,19 +637,16 @@ static void show_dialog(gpointer data, g
 	gtk_window_present(GTK_WINDOW(input->dialog));
 }
 
-#ifdef HAVE_LIBNOTIFY
 static NotifyNotification *notify = NULL;
 
 static void notify_action(NotifyNotification *notify,
 					gchar *action, gpointer user_data)
 {
 }
-#endif
 
 static void show_notification(const gchar *summary, const gchar *message,
 			      const gchar *action, gint timeout, GCallback handler)
 {
-#ifdef HAVE_LIBNOTIFY
 	NotifyActionCallback callback;
 	GdkScreen *screen;
 	GdkRectangle area;
@@ -687,18 +681,15 @@ static void show_notification(const gcha
 					       callback, NULL, NULL);
 
 	notify_notification_show(notify, NULL);
-#endif
 }
 
 static void close_notification(void)
 {
-#ifdef HAVE_LIBNOTIFY
 	if (notify) {
 		g_signal_handlers_destroy(notify);
 		notify_notification_close(notify, NULL);
 		notify = NULL;
 	}
-#endif
 }
 
 typedef struct {
@@ -1830,9 +1821,7 @@ int main(int argc, char *argv[])
 
 	gtk_window_set_default_icon_name("stock_bluetooth");
 
-#ifdef HAVE_LIBNOTIFY
 	notify_init("bluetooth-manager");
-#endif
 
 	conn = dbus_g_bus_get(DBUS_BUS_SYSTEM, &error);
 	if (error != NULL) {

--=-Z77TXD4yehVL2j5iAGxw
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--=-Z77TXD4yehVL2j5iAGxw
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--=-Z77TXD4yehVL2j5iAGxw--
