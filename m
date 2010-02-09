Return-Path: <cyrus@holtmann.org>
Subject: [PATCH] osso-gwobex export
From: Bastien Nocera <hadess@hadess.net>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Cc: Johan Hedberg <johan.hedberg@gmail.com>
Content-Type: multipart/mixed; boundary="=-dhSH/ypxhXWPbuWcKqs9"
Date: Tue, 09 Feb 2010 18:06:47 +0000
Message-ID: <1265738807.2383.6336.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-dhSH/ypxhXWPbuWcKqs9
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

Heya,

Here's a patch to fix libgwobex not using a soname, and fixing a few
build problems.

I couldn't run the test suite, as gnome-bluetooth's ancient btctl Python
module isn't around any more.

Could I bribe someone into making a release that I could use for gvfs'
ObexFTP module[1]?

Cheers

[1]: https://bugzilla.gnome.org/show_bug.cgi?id=609340

--=-dhSH/ypxhXWPbuWcKqs9
Content-Disposition: attachment; filename="0001-Export-libgwobex.patch"
Content-Type: text/x-patch; name="0001-Export-libgwobex.patch"; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

>From 8d430811bd39c025e30a2b32370cce426a85f796 Mon Sep 17 00:00:00 2001
From: Bastien Nocera <hadess@hadess.net>
Date: Tue, 9 Feb 2010 18:03:24 +0000
Subject: [PATCH] Export libgwobex

Set the soname for the library, and fix some distchecking problems.
---
 Makefile.am      |    2 ++
 configure.ac     |   15 +++++++++++++++
 libgwobex.pc.in  |    2 +-
 src/Makefile.am  |    4 ++++
 test/Makefile.am |    4 ++--
 5 files changed, 24 insertions(+), 3 deletions(-)
 mode change 100644 => 100755 test/coverage.py

diff --git a/Makefile.am b/Makefile.am
index f604eb8..58d017d 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -16,6 +16,8 @@ EXTRA_DIST =                        \
 pkgconfigdir = $(libdir)/pkgconfig
 pkgconfig_DATA = libgwobex.pc
 
+CLEANFILES = libgwobex.pc
+
 if DOXYGEN_DOCS_ENABLED
   DOXYGEN_LINE = $(DOXYGEN) doxygen.cfg
 else 
diff --git a/configure.ac b/configure.ac
index aca038f..2b2b12a 100644
--- a/configure.ac
+++ b/configure.ac
@@ -13,6 +13,17 @@ AC_PROG_LIBTOOL
 GWOBEX_COMPILE_WARNINGS
 GWOBEX_CHECK_TIMEZONE
 
+# Before making a release, the CHEESE_LT_VERSION string should be modified.
+# The string is of the form C:R:A.
+# - If interfaces have been changed or added, but binary compatibility has
+#   been preserved, change to C+1:0:A+1
+# - If binary compatibility has been broken (eg removed or changed interfaces)
+#   change to C+1:0:0
+# - If the interface is the same as the previous version, change to C:R+1:A
+GWOBEX_LT_VERSION=0:0:0
+AC_SUBST(GWOBEX_LT_VERSION)
+
+
 changequote(,)dnl
 if test "x$GCC" = "xyes"; then
     CFLAGS="$CFLAGS $WARN_CFLAGS"
@@ -46,6 +57,10 @@ PKG_CHECK_MODULES(GW_OBEX, [
 AC_SUBST(GW_OBEX_CFLAGS)
 AC_SUBST(GW_OBEX_LIBS)
 
+PKG_CHECK_MODULES(TESTS, bluez >= 4.0)
+AC_SUBST(TESTS_CFLAGS)
+AC_SUBST(TESTS_LIBS)
+
 ### Doxygen Documentation
 AC_PATH_PROG(DOXYGEN, doxygen, no)
 
diff --git a/libgwobex.pc.in b/libgwobex.pc.in
index 22c9eee..316fcb2 100644
--- a/libgwobex.pc.in
+++ b/libgwobex.pc.in
@@ -5,7 +5,7 @@ includedir=@includedir@
  
 Name: libgwobex
 Description: libgwobex
-Requires: glib-2.0 openobex
+Requires: glib-2.0 gthread-2.0 openobex
 Version: @VERSION@
 Libs: -L${libdir} -lgwobex
 Cflags: -I${includedir}
diff --git a/src/Makefile.am b/src/Makefile.am
index a58ce3b..916cd37 100644
--- a/src/Makefile.am
+++ b/src/Makefile.am
@@ -24,6 +24,10 @@ libgwobex_la_SOURCES =               \
 libgwobexinclude_HEADERS = gw-obex.h
 
 libgwobex_la_LIBADD = $(GW_OBEX_LIBS)
+libgwobex_la_LDFLAGS =                     \
+	-version-info $(GWOBEX_LT_VERSION) \
+	-no-undefined                      \
+	$(AM_LDFLAGS)
 
 libgwobexincludedir = $(includedir)
 
diff --git a/test/Makefile.am b/test/Makefile.am
index 5822d59..4910d96 100644
--- a/test/Makefile.am
+++ b/test/Makefile.am
@@ -1,5 +1,5 @@
-LDADD = ../src/libgwobex.la
-INCLUDES := -I$(top_srcdir)/src  $(shell pkg-config --cflags glib-2.0)
+AM_LDFLAGS = $(TESTS_LIBS) $(top_builddir)/src/libgwobex.la
+INCLUDES := -I$(top_srcdir)/src  $(GW_OBEX_CFLAGS) $(TESTS_CFLAGS)
 
 check_PROGRAMS = setup callback capability getfile putfile getfd putfd getbuf \
 putbuf chdir mkdir readdir delete move move2 copy putasync  xfercb objtime \
diff --git a/test/coverage.py b/test/coverage.py
old mode 100644
new mode 100755
-- 
1.6.6


--=-dhSH/ypxhXWPbuWcKqs9--

