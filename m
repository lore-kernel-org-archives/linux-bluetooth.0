Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 06/10] build: Add option to disable HID profile
Date: Fri, 11 Nov 2016 19:22:40 +0200
Message-Id: <1478884964-7543-7-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1478884964-7543-1-git-send-email-luiz.dentz@gmail.com>
References: <1478884964-7543-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds --disable-hid option to configure which make input plugin
to not be build thus reducing the build time and binary size of
bluetoothd in systems where HID profile is not supported.
---
 Makefile.plugins | 2 ++
 configure.ac     | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/Makefile.plugins b/Makefile.plugins
index 533922d..c6951b1 100644
--- a/Makefile.plugins
+++ b/Makefile.plugins
@@ -56,11 +56,13 @@ builtin_sources += profiles/network/manager.c \
 			profiles/network/connection.c
 endif
 
+if HID
 builtin_modules += input
 builtin_sources += profiles/input/manager.c \
 			profiles/input/server.h profiles/input/server.c \
 			profiles/input/device.h profiles/input/device.c \
 			profiles/input/hidp_defs.h
+endif
 
 builtin_modules += hog
 builtin_sources += profiles/input/hog.c profiles/input/uhid_copy.h \
diff --git a/configure.ac b/configure.ac
index 63a5dfb..e63579e 100644
--- a/configure.ac
+++ b/configure.ac
@@ -160,6 +160,10 @@ AC_ARG_ENABLE(test, AC_HELP_STRING([--disable-network],
 		[disable network profiles]), [enable_network=${enableval}])
 AM_CONDITIONAL(NETWORK, test "${enable_network}" != "no")
 
+AC_ARG_ENABLE(test, AC_HELP_STRING([--disable-hid],
+		[disable HID profile]), [enable_hid=${enableval}])
+AM_CONDITIONAL(HID, test "${enable_hid}" != "no")
+
 AC_ARG_ENABLE(tools, AC_HELP_STRING([--disable-tools],
 		[disable Bluetooth tools]), [enable_tools=${enableval}])
 AM_CONDITIONAL(TOOLS, test "${enable_tools}" != "no")
-- 
2.7.4

