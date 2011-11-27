Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 6/6 v2] Remove dependency on OpenOBEX
Date: Sun, 27 Nov 2011 23:12:11 +0200
Message-Id: <1322428331-28204-6-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1322428331-28204-1-git-send-email-luiz.dentz@gmail.com>
References: <1322428331-28204-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Now that the server also uses gobex there is no need to depend on
OpenOBEX anymore.
---
 Makefile.am  |   14 ++++++--------
 configure.ac |    5 -----
 2 files changed, 6 insertions(+), 13 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 2582651..af03f2e 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -85,9 +85,8 @@ src_obexd_SOURCES = $(gdbus_sources) $(builtin_sources) $(btio_sources) \
 			src/server.h src/server.c
 
 src_obexd_LDADD = @DBUS_LIBS@ @GLIB_LIBS@ @GTHREAD_LIBS@ \
-					@EBOOK_LIBS@ @OPENOBEX_LIBS@ \
-					@BLUEZ_LIBS@ @LIBICAL_LIBS@ \
-					@TRACKER_LIBS@ -ldl
+					@EBOOK_LIBS@ @BLUEZ_LIBS@ \
+					@LIBICAL_LIBS@ @TRACKER_LIBS@ -ldl
 
 src_obexd_LDFLAGS = -Wl,--export-dynamic
 
@@ -129,11 +128,10 @@ endif
 
 service_DATA = $(service_in_files:.service.in=.service)
 
-AM_CFLAGS = @OPENOBEX_CFLAGS@ @BLUEZ_CFLAGS@ @EBOOK_CFLAGS@ \
-			@GTHREAD_CFLAGS@ @GLIB_CFLAGS@ @DBUS_CFLAGS@ \
-			@LIBICAL_CFLAGS@ -D_FILE_OFFSET_BITS=64 \
-			@TRACKER_CFLAGS@ \
-			-DOBEX_PLUGIN_BUILTIN -DPLUGINDIR=\""$(plugindir)"\"
+AM_CFLAGS = @BLUEZ_CFLAGS@ @EBOOK_CFLAGS@ @GTHREAD_CFLAGS@ @GLIB_CFLAGS@ \
+			@DBUS_CFLAGS@ @LIBICAL_CFLAGS@ @TRACKER_CFLAGS@ \
+			-DOBEX_PLUGIN_BUILTIN -DPLUGINDIR=\""$(plugindir)"\" \
+			-D_FILE_OFFSET_BITS=64
 
 INCLUDES = -I$(builddir)/src -I$(srcdir)/src -I$(srcdir)/plugins \
 				-I$(srcdir)/gdbus \
diff --git a/configure.ac b/configure.ac
index 962e2e7..fca284e 100644
--- a/configure.ac
+++ b/configure.ac
@@ -89,11 +89,6 @@ AC_CHECK_LIB(dbus-1, dbus_connection_can_send_type, dummy=yes,
 AC_SUBST(DBUS_CFLAGS)
 AC_SUBST(DBUS_LIBS)
 
-PKG_CHECK_MODULES(OPENOBEX, openobex, dummy=yes,
-				AC_MSG_ERROR(libopenobex is required))
-AC_SUBST(OPENOBEX_CFLAGS)
-AC_SUBST(OPENOBEX_LIBS)
-
 PKG_CHECK_MODULES(BLUEZ, bluez, dummy=yes,
 				AC_MSG_ERROR(libbluetooth is required))
 AC_SUBST(BLUEZ_CFLAGS)
-- 
1.7.7.3

