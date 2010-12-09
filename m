Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] Fix compiler flags when CFLAGS is set in the environment
Date: Thu,  9 Dec 2010 15:41:38 +0200
Message-Id: <1291902098-20765-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

D_FILE_OFFSET_BITS need to be set even if CFLAGS is not empty
---
 Makefile.am  |    2 +-
 acinclude.m4 |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 175747c..a317556 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -123,7 +123,7 @@ service_DATA = $(service_in_files:.service.in=.service)
 
 AM_CFLAGS = @OPENOBEX_CFLAGS@ @BLUEZ_CFLAGS@ @EBOOK_CFLAGS@ \
 			@GTHREAD_CFLAGS@ @GLIB_CFLAGS@ @DBUS_CFLAGS@ \
-			@LIBICAL_CFLAGS@ \
+			@LIBICAL_CFLAGS@ -D_FILE_OFFSET_BITS=64 \
 			-DOBEX_PLUGIN_BUILTIN -DPLUGINDIR=\""$(plugindir)"\"
 
 INCLUDES = -I$(builddir)/src -I$(srcdir)/src -I$(srcdir)/plugins \
diff --git a/acinclude.m4 b/acinclude.m4
index 3d1f511..4594073 100644
--- a/acinclude.m4
+++ b/acinclude.m4
@@ -12,7 +12,7 @@ AC_DEFUN([AC_PROG_CC_PIE], [
 
 AC_DEFUN([COMPILER_FLAGS], [
 	if (test "${CFLAGS}" = ""); then
-		CFLAGS="-Wall -O2 -D_FORTIFY_SOURCE=2 -D_FILE_OFFSET_BITS=64"
+		CFLAGS="-Wall -O2 -D_FORTIFY_SOURCE=2"
 	fi
 	if (test "$USE_MAINTAINER_MODE" = "yes"); then
 		CFLAGS+=" -Werror -Wextra"
-- 
1.7.1

