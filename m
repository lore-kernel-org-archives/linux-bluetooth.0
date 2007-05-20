Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Dick <dick@mrns.nl>
To: bluez-devel@lists.sourceforge.net
Content-Type: multipart/mixed; boundary="=-bohHmh0a/CaWvm+Fwk6l"
Date: Sun, 20 May 2007 15:01:45 +0200
Message-Id: <1179666105.9244.9.camel@dick.marinus>
Mime-Version: 1.0
Subject: [Bluez-devel] bluez-gnome patch to disable/enable schemes-install
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


--=-bohHmh0a/CaWvm+Fwk6l
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi all,
        
I've created this small patch for bluez-gnome to be able to configure
with --disable-schemes-install. I hope it's okay.

greetings,
Dick

--=-bohHmh0a/CaWvm+Fwk6l
Content-Disposition: attachment;
	filename=bluez-gnome-cvs-0-schemes-install.patch
Content-Type: text/x-patch; name=bluez-gnome-cvs-0-schemes-install.patch;
	charset=us-ascii
Content-Transfer-Encoding: 7bit

--- configure.in	15 May 2007 10:00:47 -0000	1.38
+++ configure.in	19 May 2007 11:02:28 -0000
@@ -75,6 +75,8 @@
 AC_SUBST(OPENOBEX_CFLAGS)
 AC_SUBST(OPENOBEX_LIBS)
 
+AM_GCONF_SOURCE_2
+
 AC_ARG_BLUEZ
 
 AC_OUTPUT(Makefile compat/Makefile common/Makefile applet/Makefile properties/Makefile sendto/Makefile wizard/Makefile proximity/Makefile po/Makefile.in)
--- properties/Makefile.am	3 Apr 2007 08:44:24 -0000	1.10
+++ properties/Makefile.am	19 May 2007 11:02:30 -0000
@@ -30,6 +30,7 @@
 
 MAINTAINERCLEANFILES = Makefile.in
 
+if GCONF_SCHEMAS_INSTALL
 install-data-local:
 	-GCONF_CONFIG_SOURCE=$(GCONF_SCHEMA_CONFIG_SOURCE) \
 	$(GCONFTOOL) --makefile-install-rule $(schema_DATA)
@@ -37,3 +38,7 @@
 uninstall-local:
 	-GCONF_CONFIG_SOURCE=$(GCONF_SCHEMA_CONFIG_SOURCE) \
 	$(GCONFTOOL) --makefile-uninstall-rule $(schema_DATA)
+else
+install-data-local:
+uninstall-local:
+endif

--=-bohHmh0a/CaWvm+Fwk6l
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--=-bohHmh0a/CaWvm+Fwk6l
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--=-bohHmh0a/CaWvm+Fwk6l--
