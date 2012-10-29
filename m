Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
Subject: [PATCH BlueZ] hog: Fix selecting suspend backend
Date: Mon, 29 Oct 2012 17:33:57 -0300
Message-Id: <1351542837-2635-1-git-send-email-jprvita@openbossa.org>
In-Reply-To: <1351263933-21676-1-git-send-email-jprvita@openbossa.org>
References: <1351263933-21676-1-git-send-email-jprvita@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The dummy backend was always being compiled and the --with-hog-suspend
option was not being accepted by configure. Now the backend can be
selected with --with-hog-suspend and the suspend implementation file is
generated during compile time.
---
 .gitignore   | 1 +
 Makefile.am  | 5 ++++-
 acinclude.m4 | 2 +-
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/.gitignore b/.gitignore
index b5c7356..27c4687 100644
--- a/.gitignore
+++ b/.gitignore
@@ -35,6 +35,7 @@ scripts/bluetooth.rules
 scripts/97-bluetooth.rules
 scripts/97-bluetooth-hid2hci.rules
 
+profiles/input/suspend.c
 profiles/sap/sap.c
 profiles/cups/bluetooth
 
diff --git a/Makefile.am b/Makefile.am
index 35b1520..291f75a 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -184,9 +184,12 @@ if HOGPLUGIN
 builtin_modules += hog
 builtin_sources += profiles/input/hog_manager.c profiles/input/hog_device.h \
 			profiles/input/hog_device.c profiles/input/uhid_copy.h \
-			profiles/input/suspend-dummy.c profiles/input/suspend.h
+			profiles/input/suspend.h
+builtin_nodist += profiles/input/suspend.c
 endif
 
+EXTRA_DIST += profiles/input/suspend-dummy.c
+
 if NETWORKPLUGIN
 builtin_modules += network
 builtin_sources += profiles/network/main.c \
diff --git a/acinclude.m4 b/acinclude.m4
index 4bac3f0..ddc8183 100644
--- a/acinclude.m4
+++ b/acinclude.m4
@@ -290,7 +290,7 @@ AC_DEFUN([AC_ARG_BLUEZ], [
 		wiimote_enable=${enableval}
 	])
 
-	AC_ARG_WITH(gatt, AC_HELP_STRING([--with-hog-suspend=DRIVER], [select HoG suspend driver]), [
+	AC_ARG_WITH(hog_suspend, AC_HELP_STRING([--with-hog-suspend=DRIVER], [select HoG suspend driver]), [
 		hog_suspend_driver=${withval}
 	])
 
-- 
1.7.11.7

