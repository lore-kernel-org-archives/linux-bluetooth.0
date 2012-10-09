Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Micha=C5=82=20Poczwardowski?= <dmp0x7c5@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Micha=C5=82=20Poczwardowski?= <dmp0x7c5@gmail.com>
Subject: [RFC obexd 02/11] build: Add --enable-fuse for gobexfuse
Date: Tue,  9 Oct 2012 20:15:47 +0200
Message-Id: <1349806556-1978-2-git-send-email-dmp0x7c5@gmail.com>
In-Reply-To: <1349806556-1978-1-git-send-email-dmp0x7c5@gmail.com>
References: <1349806556-1978-1-git-send-email-dmp0x7c5@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 Makefile.am  |    9 +++++++++
 configure.ac |   15 +++++++++++++++
 2 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 724dd5d..95b99a6 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -132,6 +132,15 @@ client_obex_client_SOURCES = $(gdbus_sources) $(gobex_sources) \
 client_obex_client_LDADD = @GLIB_LIBS@ @DBUS_LIBS@ @BLUEZ_LIBS@
 endif
 
+if FUSE
+bin_PROGRAMS = fuse/gobexfuse
+
+fuse_gobexfuse_SOURCES = $(gobex_sources) $(btio_sources) \
+		fuse/helpers.c fuse/gobexfuse.c
+
+fuse_gobexfuse_LDADD = @GLIB_LIBS@ @GTHREAD_LIBS@ @BLUEZ_LIBS@ @FUSE_LIBS@
+endif
+
 service_DATA = $(service_in_files:.service.in=.service)
 
 AM_CFLAGS = @BLUEZ_CFLAGS@ @EBOOK_CFLAGS@ @GTHREAD_CFLAGS@ @GLIB_CFLAGS@ \
diff --git a/configure.ac b/configure.ac
index c8e61ac..7190f3f 100644
--- a/configure.ac
+++ b/configure.ac
@@ -180,4 +180,19 @@ AM_CONDITIONAL(CLIENT, test "${enable_client}" != "no")
 
 AM_CONDITIONAL(READLINE, test "${readline_found}" = "yes")
 
+AC_ARG_ENABLE(fuse, AC_HELP_STRING([--enable-fuse],
+			[Build gobexfuse]), [
+	PKG_CHECK_MODULES(FUSE, fuse, dummy=yes,
+				      AC_MSG_ERROR(FUSE is required))
+	AC_SUBST(FUSE_CFLAGS)
+	AC_SUBST(FUSE_LIBS)
+	enable_fuse=${enableval}
+
+	PKG_CHECK_MODULES(GTHREAD, gthread-2.0, dummy=yes,
+					AC_MSG_ERROR(libgthread is required))
+	AC_SUBST(GTHREAD_CFLAGS)
+	AC_SUBST(GTHREAD_LIBS)
+])
+AM_CONDITIONAL(FUSE, test "${enable_fuse}" != "no")
+
 AC_OUTPUT(Makefile)
-- 
1.7.8.6

