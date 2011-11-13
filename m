Return-Path: <cyrus@holtmann.org>
From: Alon Bar-Lev <alon.barlev@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Alon Bar-Lev <alon.barlev@gmail.com>
Subject: [PATCH] Support libtool-2
Date: Sun, 13 Nov 2011 11:45:15 +0200
Message-Id: <1321177515-2908-1-git-send-email-alon.barlev@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Replace now obsolete AC_PROG_LIBTOOL with LT_INIT if available.
Add m4 aclocal directory where libtool will place its macros.
---
 .gitignore   |    6 ++++++
 Makefile.am  |    1 +
 configure.ac |    3 ++-
 m4/.keep     |    1 +
 4 files changed, 10 insertions(+), 1 deletions(-)
 create mode 100644 m4/.keep

diff --git a/.gitignore b/.gitignore
index badd1a0..7cce775 100644
--- a/.gitignore
+++ b/.gitignore
@@ -25,6 +25,12 @@ missing
 stamp-h1
 autom4te.cache
 
+m4/libtool.m4
+m4/ltoptions.m4
+m4/ltsugar.m4
+m4/ltversion.m4
+m4/lt~obsolete.m4
+
 ylwrap
 lexer.c
 parser.h
diff --git a/Makefile.am b/Makefile.am
index 57aa33c..3479d4e 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -1,4 +1,5 @@
 
+ACLOCAL_AMFLAGS = -I m4
 AM_MAKEFLAGS = --no-print-directory
 
 lib_LTLIBRARIES =
diff --git a/configure.ac b/configure.ac
index 2f07167..c1397f0 100644
--- a/configure.ac
+++ b/configure.ac
@@ -3,6 +3,7 @@ AC_INIT(bluez, 4.96)
 
 AM_INIT_AUTOMAKE([foreign subdir-objects color-tests])
 AM_CONFIG_HEADER(config.h)
+AC_CONFIG_MACRO_DIR([m4])
 
 m4_ifdef([AM_SILENT_RULES], [AM_SILENT_RULES([yes])])
 
@@ -30,7 +31,7 @@ m4_define([_LT_AC_TAGCONFIG], [])
 m4_ifdef([AC_LIBTOOL_TAGS], [AC_LIBTOOL_TAGS([])])
 
 AC_DISABLE_STATIC
-AC_PROG_LIBTOOL
+ifdef([LT_INIT],[LT_INIT], [AC_PROG_LIBTOOL])
 
 AC_FUNC_PPOLL
 
diff --git a/m4/.keep b/m4/.keep
new file mode 100644
index 0000000..2fa992c
--- /dev/null
+++ b/m4/.keep
@@ -0,0 +1 @@
+keep
-- 
1.7.3.4

