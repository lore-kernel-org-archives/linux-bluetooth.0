Return-Path: <cyrus@holtmann.org>
From: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
To: linux-bluetooth@vger.kernel.org
Cc: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
Subject: [PATCH 1/3] Add libtracker-sparql to obexd dependencies
Date: Wed,  2 Feb 2011 10:15:29 +0200
Message-Id: <1296634531-32164-1-git-send-email-ext-jablonski.radoslaw@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In PBAP tracker is used only for reading and returns rather big
parts of data, so using direct access libtracker-sparql is better
solution than tracker D-Bus API(libtracker-sparql in most PBAP
scenarios should be faster).
---
 Makefile.am  |    4 +++-
 configure.ac |    7 +++++++
 2 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index a317556..fc996ec 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -79,7 +79,8 @@ src_obexd_SOURCES = $(gdbus_sources) $(builtin_sources) $(btio_sources) \
 
 src_obexd_LDADD = @DBUS_LIBS@ @GLIB_LIBS@ @GTHREAD_LIBS@ \
 					@EBOOK_LIBS@ @OPENOBEX_LIBS@ \
-					@BLUEZ_LIBS@ @LIBICAL_LIBS@ -ldl
+					@BLUEZ_LIBS@ @LIBICAL_LIBS@ \
+					@TRACKER_SPARQL_LIBS@ -ldl
 
 src_obexd_LDFLAGS = -Wl,--export-dynamic
 
@@ -124,6 +125,7 @@ service_DATA = $(service_in_files:.service.in=.service)
 AM_CFLAGS = @OPENOBEX_CFLAGS@ @BLUEZ_CFLAGS@ @EBOOK_CFLAGS@ \
 			@GTHREAD_CFLAGS@ @GLIB_CFLAGS@ @DBUS_CFLAGS@ \
 			@LIBICAL_CFLAGS@ -D_FILE_OFFSET_BITS=64 \
+			@TRACKER_SPARQL_CFLAGS@ \
 			-DOBEX_PLUGIN_BUILTIN -DPLUGINDIR=\""$(plugindir)"\"
 
 INCLUDES = -I$(builddir)/src -I$(srcdir)/src -I$(srcdir)/plugins \
diff --git a/configure.ac b/configure.ac
index e48a3cc..aa8bfb0 100644
--- a/configure.ac
+++ b/configure.ac
@@ -136,6 +136,13 @@ if (test "${phonebook_driver}" = "ebook"); then
 	AC_SUBST(GTHREAD_LIBS)
 fi
 
+if (test "${phonebook_driver}" = "tracker"); then
+	PKG_CHECK_MODULES(TRACKER_SPARQL, tracker-sparql-0.9, dummy=yes,
+				AC_MSG_ERROR(libtracker-sparql is required))
+	AC_SUBST(TRACKER_SPARQL_CFLAGS)
+	AC_SUBST(TRACKER_SPARQL_LIBS)
+fi
+
 AC_SUBST([PHONEBOOK_DRIVER], [phonebook-${phonebook_driver}.c])
 
 AC_ARG_ENABLE(server, AC_HELP_STRING([--disable-server],
-- 
1.7.0.4

