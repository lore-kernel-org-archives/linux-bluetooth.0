Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Cristian=20Rodr=C3=ADguez?= <crrodriguez@opensuse.org>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Cristian=20Rodr=C3=ADguez?= <crrodriguez@opensuse.org>
Subject: [PATCH 3/3] configure.ac: build system improvements
Date: Mon, 24 Dec 2012 15:10:34 -0300
Message-Id: <1356372634-20108-1-git-send-email-crrodriguez@opensuse.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Use AC_SYS_LARGEFILE so proper flags are set on systems
that require special settings for large file support

Use AC_PROG_CC_STDC, this macro picks the latest recommended
C standard flags for the compiler.
---
 configure.ac | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index 522e349..614bf1f 100644
--- a/configure.ac
+++ b/configure.ac
@@ -5,6 +5,7 @@ AM_INIT_AUTOMAKE([foreign subdir-objects color-tests silent-rules
 					tar-pax no-dist-gzip dist-xz])
 AM_CONFIG_HEADER(config.h)
 AC_USE_SYSTEM_EXTENSIONS
+AC_SYS_LARGEFILE
 
 m4_ifdef([AM_SILENT_RULES], [AM_SILENT_RULES([yes])])
 
@@ -20,7 +21,7 @@ AC_LANG_C
 
 AC_C_RESTRICT
 
-AC_PROG_CC
+AC_PROG_CC_STDC
 AM_PROG_CC_C_O
 AC_PROG_CC_PIE
 AC_PROG_INSTALL
-- 
1.8.0.2

