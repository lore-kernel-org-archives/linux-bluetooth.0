Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.de.marchi@gmail.com>
Subject: [PATCH BlueZ 1/2] build-sys: Don't use deprecated AM_PROG_MKDIR_P
Date: Thu,  4 Oct 2012 03:37:09 -0300
Message-Id: <1349332630-8901-1-git-send-email-lucas.de.marchi@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

AM_PROG_MKDIR_P is deprecated since:

configure.ac:23: warning: The 'AM_PROG_MKDIR_P' macro is deprecated, and will soon be removed.
configure.ac:23: You should use the Autoconf-provided 'AC_PROG_MKDIR_P' macro instead,
configure.ac:23: and use '$(MKDIR_P)' instead of '$(mkdir_p)'in your Makefile.am files.

We are already using $(MKDIR_P) so we just need to call the right macro.
---
 configure.ac | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index 7d9a34d..deab9e9 100644
--- a/configure.ac
+++ b/configure.ac
@@ -20,7 +20,7 @@ AC_PROG_CC
 AM_PROG_CC_C_O
 AC_PROG_CC_PIE
 AC_PROG_INSTALL
-AM_PROG_MKDIR_P
+AC_PROG_MKDIR_P
 
 m4_define([_LT_AC_TAGCONFIG], [])
 m4_ifdef([AC_LIBTOOL_TAGS], [AC_LIBTOOL_TAGS([])])
-- 
1.7.12.2

