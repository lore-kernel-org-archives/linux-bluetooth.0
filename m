Return-Path: <cyrus@holtmann.org>
From: Sheldon Demario <sheldon.demario@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH 6/7] Add autoconf macro for interactive gatttool
Date: Fri, 21 Jan 2011 10:46:25 -0300
Message-Id: <1295617586-3398-6-git-send-email-sheldon.demario@openbossa.org>
In-Reply-To: <1295617586-3398-1-git-send-email-sheldon.demario@openbossa.org>
References: <1295617586-3398-1-git-send-email-sheldon.demario@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Claudio Takahasi <claudio.takahasi@openbossa.org>

Interactive gatttool will be built automatically if readline library
is found and attribute plugin is enabled.
---
 Makefile.am  |    8 ++++++--
 acinclude.m4 |    8 ++++++++
 configure.ac |    1 +
 3 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 79365ad..f9e05fd 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -175,7 +175,7 @@ builtin_sources += plugins/service.c
 endif
 
 if ATTRIBPLUGIN
-bin_PROGRAMS += attrib/gatttool attrib/igatttool
+bin_PROGRAMS += attrib/gatttool
 
 attrib_gatttool_SOURCES = attrib/gatttool.c attrib/att.c attrib/gatt.c \
 			  attrib/gattrib.c btio/btio.c \
@@ -183,10 +183,14 @@ attrib_gatttool_SOURCES = attrib/gatttool.c attrib/att.c attrib/gatt.c \
 			  attrib/gtcommon.h attrib/gtcommon.c
 attrib_gatttool_LDADD = lib/libbluetooth.la @GLIB_LIBS@
 
+if IGATTTOOL
+bin_PROGRAMS += attrib/igatttool
+
 attrib_igatttool_SOURCES = attrib/igatttool.c btio/btio.c \
 			   attrib/gtcommon.h attrib/gtcommon.c \
 			  src/glib-helper.h src/glib-helper.c
-attrib_igatttool_LDADD =  lib/libbluetooth.la @GLIB_LIBS@ -lreadline
+attrib_igatttool_LDADD =  lib/libbluetooth.la @GLIB_LIBS@ @READLINE_LIBS@
+endif
 
 builtin_modules += attrib
 builtin_sources += attrib/main.c \
diff --git a/acinclude.m4 b/acinclude.m4
index ecf4b4b..2b4b515 100644
--- a/acinclude.m4
+++ b/acinclude.m4
@@ -153,6 +153,13 @@ AC_DEFUN([AC_PATH_SNDFILE], [
 	AC_SUBST(SNDFILE_LIBS)
 ])
 
+AC_DEFUN([AC_PATH_READLINE], [
+	AC_CHECK_LIB(readline, main,
+		[ readline_found=yes
+		 AC_SUBST(READLINE_LIBS, "-lreadline")
+		], readline_found=no)
+])
+
 AC_DEFUN([AC_PATH_OUI], [
 	AC_ARG_WITH(ouifile,
 		    AS_HELP_STRING([--with-ouifile=PATH],[Path to the oui.txt file @<:@auto@:>@]),
@@ -357,6 +364,7 @@ AC_DEFUN([AC_ARG_BLUEZ], [
 	AM_CONDITIONAL(MCAP, test "${health_enable}" = "yes")
 	AM_CONDITIONAL(HAL, test "${hal_enable}" = "yes")
 	AM_CONDITIONAL(ATTRIBPLUGIN, test "${attrib_enable}" = "yes")
+	AM_CONDITIONAL(IGATTTOOL, test "${attrib_enable}" = "yes" && test "${readline_found}" = "yes")
 	AM_CONDITIONAL(ECHOPLUGIN, test "no" = "yes")
 	AM_CONDITIONAL(PNATPLUGIN, test "${pnat_enable}" = "yes")
 	AM_CONDITIONAL(TRACER, test "${tracer_enable}" = "yes")
diff --git a/configure.ac b/configure.ac
index 4a979f0..6925344 100644
--- a/configure.ac
+++ b/configure.ac
@@ -41,6 +41,7 @@ AC_PATH_ALSA
 AC_PATH_GSTREAMER
 AC_PATH_USB
 AC_PATH_SNDFILE
+AC_PATH_READLINE
 AC_PATH_OUI
 
 AC_ARG_BLUEZ
-- 
1.7.1

