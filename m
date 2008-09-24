Return-Path: <cyrus@holtmann.org>
Subject: Port sendto to GIO
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-E36boShSmFtL6R3m4+Ta"
Date: Wed, 24 Sep 2008 14:49:50 -0700
Message-Id: <1222292990.10497.185.camel@snoogens.fab.redhat.com>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-E36boShSmFtL6R3m4+Ta
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Done! Enjoy

--=-E36boShSmFtL6R3m4+Ta
Content-Disposition: attachment; filename="0001-Move-filename-conversion-to-a-separate-function.patch"
Content-Type: text/x-patch; name="0001-Move-filename-conversion-to-a-separate-function.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

>From c581c3a1dbe21004b508463786c0059e231f0017 Mon Sep 17 00:00:00 2001
From: Bastien Nocera <hadess@hadess.net>
Date: Wed, 24 Sep 2008 14:42:50 -0700
Subject: [PATCH] Move filename conversion to a separate function

Just half the work to start using GIO
---
 configure.ac       |    5 +++++
 sendto/Makefile.am |    4 ++--
 sendto/main.c      |   26 +++++++++++++++++---------
 3 files changed, 24 insertions(+), 11 deletions(-)

diff --git a/configure.ac b/configure.ac
index 9219262..680c682 100644
--- a/configure.ac
+++ b/configure.ac
@@ -73,6 +73,11 @@ PKG_CHECK_MODULES(NOTIFY, libnotify >= 0.4.3, dummy=yes,
 AC_SUBST(NOTIFY_CFLAGS)
 AC_SUBST(NOTIFY_LIBS)
 
+PKG_CHECK_MODULES(GIO, gio-2.0, dummy=yes,
+				AC_MSG_ERROR(gio, part of glib, is required))
+AC_SUBST(GIO_CFLAGS)
+AC_SUBST(GIO_LIBS)
+
 dnl PKG_CHECK_MODULES(OPENOBEX, libopenobex-glib >= 1.4, dummy=yes, dummy=no)
 dnl AC_SUBST(OPENOBEX_CFLAGS)
 dnl AC_SUBST(OPENOBEX_LIBS)
diff --git a/sendto/Makefile.am b/sendto/Makefile.am
index 9d3addf..7bcc21c 100644
--- a/sendto/Makefile.am
+++ b/sendto/Makefile.am
@@ -4,9 +4,9 @@ bin_PROGRAMS = bluetooth-sendto
 bluetooth_sendto_SOURCES = main.c
 
 bluetooth_sendto_LDADD = $(top_builddir)/common/libcommon.a \
-						@GTK_LIBS@ @DBUS_LIBS@
+						@GTK_LIBS@ @DBUS_LIBS@ @GIO_LIBS@
 
-AM_CFLAGS = @DBUS_CFLAGS@ @GTK_CFLAGS@
+AM_CFLAGS = @DBUS_CFLAGS@ @GTK_CFLAGS@ @GIO_CFLAGS@
 
 INCLUDES = -I$(top_srcdir)/common -I$(top_builddir)/common
 
diff --git a/sendto/main.c b/sendto/main.c
index 0972ac8..8e8d3fc 100644
--- a/sendto/main.c
+++ b/sendto/main.c
@@ -109,6 +109,21 @@ static gchar *format_time(int seconds)
 					 hours), hours);
 }
 
+static gchar *filename_to_path(const gchar *filename)
+{
+	if (g_str_has_prefix(filename, "file://") == TRUE) {
+		return g_filename_from_uri(filename, NULL, NULL);
+	} else if (filename[0] != '/') {
+		gchar *dir = g_get_current_dir();
+		gchar *output;
+		output = g_build_filename(dir, filename, NULL);
+		g_free(dir);
+		return output;
+	}
+
+	return NULL;
+}
+
 static void response_callback(GtkWidget *dialog,
 					gint response, gpointer user_data)
 {
@@ -581,17 +596,10 @@ int main(int argc, char *argv[])
 	file_count = g_strv_length(option_files);
 
 	for (i = 0; i < file_count; i++) {
-		gchar *filename = NULL;
+		gchar *filename;
 		struct stat st;
 
-		if (g_str_has_prefix(option_files[i], "file://") == TRUE) {
-			filename = g_filename_from_uri(option_files[i],
-								NULL, NULL);
-		} else if (option_files[i][0] != '/') {
-			gchar *dir = g_get_current_dir();
-			filename = g_build_filename(dir, option_files[i], NULL);
-			g_free(dir);
-		}
+		filename = filename_to_path (option_files[i]);
 
 		if (filename != NULL) {
 			g_free(option_files[i]);
-- 
1.6.0.1


--=-E36boShSmFtL6R3m4+Ta
Content-Disposition: attachment; filename="0002-Use-GIO-to-normalise-paths.patch"
Content-Type: text/x-patch; name="0002-Use-GIO-to-normalise-paths.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

>From 744caed0d2bbef0d21e2fbe8bdec2ec80dbbc2f6 Mon Sep 17 00:00:00 2001
From: Bastien Nocera <hadess@hadess.net>
Date: Wed, 24 Sep 2008 14:48:15 -0700
Subject: [PATCH] Use GIO to normalise paths

This means that we remove crummy ways of transforming the URI,
filename, or whatever into a local path, and also get support
for remote files automatically
---
 sendto/main.c |   18 ++++++++----------
 1 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/sendto/main.c b/sendto/main.c
index 8e8d3fc..d8f7e7c 100644
--- a/sendto/main.c
+++ b/sendto/main.c
@@ -29,6 +29,7 @@
 
 #include <glib/gi18n.h>
 #include <glib/gstdio.h>
+#include <gio/gio.h>
 #include <gtk/gtk.h>
 
 #include <dbus/dbus-glib.h>
@@ -111,17 +112,14 @@ static gchar *format_time(int seconds)
 
 static gchar *filename_to_path(const gchar *filename)
 {
-	if (g_str_has_prefix(filename, "file://") == TRUE) {
-		return g_filename_from_uri(filename, NULL, NULL);
-	} else if (filename[0] != '/') {
-		gchar *dir = g_get_current_dir();
-		gchar *output;
-		output = g_build_filename(dir, filename, NULL);
-		g_free(dir);
-		return output;
-	}
+	GFile *file;
+	gchar *ret;
 
-	return NULL;
+	file = g_file_new_for_commandline_arg (filename);
+	ret = g_file_get_path (file);
+	g_object_unref (file);
+
+	return ret;
 }
 
 static void response_callback(GtkWidget *dialog,
-- 
1.6.0.1


--=-E36boShSmFtL6R3m4+Ta--

