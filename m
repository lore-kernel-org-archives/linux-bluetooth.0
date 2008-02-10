Return-Path: <cyrus@holtmann.org>
Date: Sun, 10 Feb 2008 19:33:44 +0100
From: Filippo Giunchedi <filippo@esaurito.net>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Message-ID: <20080210183344.GA2605@esaurito.net>
MIME-Version: 1.0
Subject: [Bluez-devel] [PATCH] account for non-existant update-*-database
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

Hi,
I've noticed a bug in bluez-gnome when update-*-database programs are not
present (i.e. $UPDATE_*_DATABASE is "" thus install-data-hook fails), the
following patch (or something similar) should work:

--- gnome/configure.in	10 Feb 2008 17:46:50 -0000	1.63
+++ gnome/configure.in	10 Feb 2008 18:31:57 -0000
@@ -27,15 +27,15 @@
 
 AC_PATH_PROG(UPDATE_DESKTOP_DATABASE, [update-desktop-database])
 AC_ARG_ENABLE(desktop-update, AC_HELP_STRING([--disable-desktop-update], [Disable desktop database update]))
-AM_CONDITIONAL([DESKTOP_UPDATE], [test "$enable_desktop_update" != no])
+AM_CONDITIONAL([DESKTOP_UPDATE], [test "$enable_desktop_update" != no -a ! -z "$UPDATE_DESKTOP_DATABASE"])
 
 AC_PATH_PROG(UPDATE_MIME_DATABASE, [update-mime-database])
 AC_ARG_ENABLE(mime-update, AC_HELP_STRING([--disable-mime-update], [Disable mime database update]))
-AM_CONDITIONAL([MIME_UPDATE], [test "$enable_mime_update" != no])
+AM_CONDITIONAL([MIME_UPDATE], [test "$enable_mime_update" != no -a ! -z "$UPDATE_MIME_DATABASE"])
 
 AC_PATH_PROG(UPDATE_ICON_CACHE, [gtk-update-icon-cache])
 AC_ARG_ENABLE(icon-update, AC_HELP_STRING([--disable-icon-update], [Disable icon cache update]))
-AM_CONDITIONAL([ICON_UPDATE], [test "$enable_icon_update" != no])
+AM_CONDITIONAL([ICON_UPDATE], [test "$enable_icon_update" != no -a ! -z "$UPDATE_ICON_CACHE"])
 
 PKG_CHECK_MODULES(DBUS, dbus-glib-1 >= 0.60, dummy=yes, AC_MSG_ERROR(dbus-glib >= 0.60 is required))
 m4_ifdef([PKG_CHECK_EXISTS], [

thanks,
filippo
--
Filippo Giunchedi - http://esaurito.net
PGP key: 0x6B79D401
random quote follows:

I worked myself up from nothing to a state of extreme poverty.
-- Groucho Marx

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
