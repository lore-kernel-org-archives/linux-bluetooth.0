Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Fix compiler flags when CFLAGS is set in the environment
Date: Thu,  9 Dec 2010 15:38:16 +0200
Message-Id: <1291901896-19906-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

D_FILE_OFFSET_BITS need to be set even if CFLAGS is not empty
---
 Makefile.am  |    4 ++--
 acinclude.m4 |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 175747c..fad4eb5 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -123,8 +123,8 @@ service_DATA = $(service_in_files:.service.in=.service)
 
 AM_CFLAGS = @OPENOBEX_CFLAGS@ @BLUEZ_CFLAGS@ @EBOOK_CFLAGS@ \
 			@GTHREAD_CFLAGS@ @GLIB_CFLAGS@ @DBUS_CFLAGS@ \
-			@LIBICAL_CFLAGS@ \
-			-DOBEX_PLUGIN_BUILTIN -DPLUGINDIR=\""$(plugindir)"\"
+			@LIBICAL_CFLAGS@ -D_FILE_OFFSET_BITS=64 \
+			-DOBEX_PLUGIN_BUILTIN -DPLUGINDIR=\""$(plugindir)"\" \
 
 INCLUDES = -I$(builddir)/src -I$(srcdir)/src -I$(srcdir)/plugins \
 				-I$(srcdir)/gdbus -I$(srcdir)/gwobex \
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

