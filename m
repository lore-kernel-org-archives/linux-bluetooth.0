Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Bastien Nocera <hadess@hadess.net>
To: BlueZ Hackers <bluez-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="=-Z1vXXrArJdUGS4NPCCay"
Date: Wed, 25 Jul 2007 17:03:08 +0100
Message-Id: <1185379388.3641.253.camel@cookie.hadess.net>
Mime-Version: 1.0
Subject: [Bluez-devel] [PATCH] New version of obexftp_available
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


--=-Z1vXXrArJdUGS4NPCCay
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This uses the modulesdir variable in newer gnome-vfs to look for
configuration directories.

The code is still pretty ugly, but I guess we'll just use gvfs in a
couple of GNOME release cycles.

-- 
Bastien Nocera <hadess@hadess.net> 

--=-Z1vXXrArJdUGS4NPCCay
Content-Disposition: attachment; filename=bluez-gnome-obexftp-avail.patch
Content-Type: text/x-patch; name=bluez-gnome-obexftp-avail.patch;
	charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Index: configure.in
===================================================================
RCS file: /cvsroot/bluez/gnome/configure.in,v
retrieving revision 1.47
diff -u -p -r1.47 configure.in
--- configure.in	22 Jul 2007 16:06:02 -0000	1.47
+++ configure.in	25 Jul 2007 15:49:12 -0000
@@ -62,6 +62,11 @@ PKG_CHECK_MODULES(NOTIFY, libnotify >= 0
 AC_SUBST(NOTIFY_CFLAGS)
 AC_SUBST(NOTIFY_LIBS)
 
+MODULESDIR=`$PKG_CONFIG --variable=modulesdir gnome-vfs-2.0`
+if test x"$MODULESDIR" != "x" ; then
+	AC_DEFINE(MODULESDIR, [$MODULESDIR], [The location of gnome-vfs configuration files])
+fi
+
 dnl PKG_CHECK_MODULES(OPENOBEX, libopenobex-glib >= 1.4, dummy=yes, dummy=no)
 dnl AC_SUBST(OPENOBEX_CFLAGS)
 dnl AC_SUBST(OPENOBEX_LIBS)
Index: applet/main.c
===================================================================
RCS file: /cvsroot/bluez/gnome/applet/main.c,v
retrieving revision 1.70
diff -u -p -r1.70 main.c
--- applet/main.c	25 Jul 2007 14:03:50 -0000	1.70
+++ applet/main.c	25 Jul 2007 15:49:13 -0000
@@ -1396,6 +1398,43 @@ static void name_owner_changed(DBusGProx
 
 static gboolean obexftp_available(void)
 {
+	char *path;
+	gboolean retval = FALSE;
+
+	/* Look for nautilus in the PATH */
+	path = g_find_program_in_path("nautilus");
+	if (path == NULL)
+		return FALSE;
+	g_free(path);
+
+#ifdef MODULESDIR
+	/* Look for obex-module.conf in the system-wide dir */
+	path = g_build_filename(MODULESDIR, "obex-module.conf", NULL);
+	retval = g_file_test(path, G_FILE_TEST_IS_REGULAR);
+	g_free(path);
+	if (retval != FALSE)
+		return TRUE;
+#endif /* MODULESDIR */
+	/* Look in the home dir */
+	if (g_get_home_dir() != NULL) {
+		path = g_build_filename(g_get_home_dir(), ".gnome2", "vfs",
+					 "modules", "obex-module.conf", NULL);
+		retval = g_file_test(path, G_FILE_TEST_IS_REGULAR);
+		g_free(path);
+		if (retval != FALSE)
+			return TRUE;
+	}
+
+	/* Look in the envvar defined dir */
+	if (g_getenv("GNOME_VFS_MODULE_CONFIG_PATH") != NULL) {
+		path = g_build_filename(g_getenv("GNOME_VFS_MODULE_CONFIG_PATH"),
+					"obex-module.conf", NULL);
+		retval = g_file_test(path, G_FILE_TEST_IS_REGULAR);
+		g_free(path);
+		if (retval != FALSE)
+			return TRUE;
+	}
+
 	return FALSE;
 }
 

--=-Z1vXXrArJdUGS4NPCCay
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
--=-Z1vXXrArJdUGS4NPCCay
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--=-Z1vXXrArJdUGS4NPCCay--
