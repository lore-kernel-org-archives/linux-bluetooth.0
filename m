Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 07/10] build: Add option to disable HoG profile
Date: Fri, 11 Nov 2016 19:22:41 +0200
Message-Id: <1478884964-7543-8-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1478884964-7543-1-git-send-email-luiz.dentz@gmail.com>
References: <1478884964-7543-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds --disable-hog option to configure which make HoG plugin
to not be build thus reducing the build time and binary size of
bluetoothd in systems where HID over GATT profile is not supported.
---
 Makefile.plugins | 2 ++
 configure.ac     | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/Makefile.plugins b/Makefile.plugins
index c6951b1..ba58518 100644
--- a/Makefile.plugins
+++ b/Makefile.plugins
@@ -64,6 +64,7 @@ builtin_sources += profiles/input/manager.c \
 			profiles/input/hidp_defs.h
 endif
 
+if HOG
 builtin_modules += hog
 builtin_sources += profiles/input/hog.c profiles/input/uhid_copy.h \
 			profiles/input/hog-lib.c profiles/input/hog-lib.h \
@@ -73,6 +74,7 @@ builtin_sources += profiles/input/hog.c profiles/input/uhid_copy.h \
 			profiles/input/suspend.h profiles/input/suspend-none.c
 
 EXTRA_DIST += profiles/input/suspend-dummy.c
+endif
 
 if EXPERIMENTAL
 builtin_modules += health
diff --git a/configure.ac b/configure.ac
index e63579e..3c2dc4d 100644
--- a/configure.ac
+++ b/configure.ac
@@ -164,6 +164,10 @@ AC_ARG_ENABLE(test, AC_HELP_STRING([--disable-hid],
 		[disable HID profile]), [enable_hid=${enableval}])
 AM_CONDITIONAL(HID, test "${enable_hid}" != "no")
 
+AC_ARG_ENABLE(test, AC_HELP_STRING([--disable-hog],
+		[disable HoG profile]), [enable_hog=${enableval}])
+AM_CONDITIONAL(HOG, test "${enable_hog}" != "no")
+
 AC_ARG_ENABLE(tools, AC_HELP_STRING([--disable-tools],
 		[disable Bluetooth tools]), [enable_tools=${enableval}])
 AM_CONDITIONAL(TOOLS, test "${enable_tools}" != "no")
-- 
2.7.4

