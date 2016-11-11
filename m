Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 05/10] build: Add option to disable network profiles
Date: Fri, 11 Nov 2016 19:22:39 +0200
Message-Id: <1478884964-7543-6-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1478884964-7543-1-git-send-email-luiz.dentz@gmail.com>
References: <1478884964-7543-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds --disable-network option to configure which make network plugin
to not be build thus reducing the build time and binary size of
bluetoothd in systems where those profiles are not supported.
---
 Makefile.plugins | 2 ++
 configure.ac     | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/Makefile.plugins b/Makefile.plugins
index c9bc50c..533922d 100644
--- a/Makefile.plugins
+++ b/Makefile.plugins
@@ -47,12 +47,14 @@ builtin_sources += profiles/audio/control.h profiles/audio/control.c \
 			profiles/audio/player.h profiles/audio/player.c
 endif
 
+if NETWORK
 builtin_modules += network
 builtin_sources += profiles/network/manager.c \
 			profiles/network/bnep.h profiles/network/bnep.c \
 			profiles/network/server.h profiles/network/server.c \
 			profiles/network/connection.h \
 			profiles/network/connection.c
+endif
 
 builtin_modules += input
 builtin_sources += profiles/input/manager.c \
diff --git a/configure.ac b/configure.ac
index 99fbeb8..63a5dfb 100644
--- a/configure.ac
+++ b/configure.ac
@@ -156,6 +156,10 @@ AC_ARG_ENABLE(test, AC_HELP_STRING([--disable-avrcp],
 		[disable AVRCP profile]), [enable_avrcp=${enableval}])
 AM_CONDITIONAL(AVRCP, test "${enable_avrcp}" != "no")
 
+AC_ARG_ENABLE(test, AC_HELP_STRING([--disable-network],
+		[disable network profiles]), [enable_network=${enableval}])
+AM_CONDITIONAL(NETWORK, test "${enable_network}" != "no")
+
 AC_ARG_ENABLE(tools, AC_HELP_STRING([--disable-tools],
 		[disable Bluetooth tools]), [enable_tools=${enableval}])
 AM_CONDITIONAL(TOOLS, test "${enable_tools}" != "no")
-- 
2.7.4

