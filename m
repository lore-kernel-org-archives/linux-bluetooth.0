Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ v2 04/10] build: Add option to disable AVRCP profile
Date: Thu, 17 Nov 2016 14:19:55 +0200
Message-Id: <1479385201-10559-5-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1479385201-10559-1-git-send-email-luiz.dentz@gmail.com>
References: <1479385201-10559-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds --disable-avrcp option to configure which make AVRCP plugin
to not be build thus reducing the build time and binary size of
bluetoothd in systems where AVRCP is not supported.
---
 Makefile.plugins |  3 +++
 README           | 10 ++++++++++
 configure.ac     |  4 ++++
 3 files changed, 17 insertions(+)

diff --git a/Makefile.plugins b/Makefile.plugins
index e69ffab..c9bc50c 100644
--- a/Makefile.plugins
+++ b/Makefile.plugins
@@ -38,11 +38,14 @@ builtin_sources += profiles/audio/source.h profiles/audio/source.c \
 			profiles/audio/a2dp-codecs.h
 endif
 
+
+if AVRCP
 builtin_modules += avrcp
 builtin_sources += profiles/audio/control.h profiles/audio/control.c \
 			profiles/audio/avctp.h profiles/audio/avctp.c \
 			profiles/audio/avrcp.h profiles/audio/avrcp.c \
 			profiles/audio/player.h profiles/audio/player.c
+endif
 
 builtin_modules += network
 builtin_sources += profiles/network/manager.c \
diff --git a/README b/README
index 9f6d4f1..ec3ed30 100644
--- a/README
+++ b/README
@@ -115,6 +115,16 @@ For a working system, certain configuration options need to be enabled:
 		This option is provided for distributions that do not have any
 		audio capabilities.
 
+	--disable-avrcp
+
+		Disable AVRCP profile
+
+		By default bluetoothd supports AVRCP profile using a built-in
+		plugin, this option disables it.
+
+		This option is provided for distributions that do not have any
+		audio capabilities.
+
 	--enable-experimental
 
 		Enable experimental plugins
diff --git a/configure.ac b/configure.ac
index 6761e29..99fbeb8 100644
--- a/configure.ac
+++ b/configure.ac
@@ -152,6 +152,10 @@ AC_ARG_ENABLE(test, AC_HELP_STRING([--disable-a2dp],
 		[disable A2DP profile]), [enable_a2dp=${enableval}])
 AM_CONDITIONAL(A2DP, test "${enable_a2dp}" != "no")
 
+AC_ARG_ENABLE(test, AC_HELP_STRING([--disable-avrcp],
+		[disable AVRCP profile]), [enable_avrcp=${enableval}])
+AM_CONDITIONAL(AVRCP, test "${enable_avrcp}" != "no")
+
 AC_ARG_ENABLE(tools, AC_HELP_STRING([--disable-tools],
 		[disable Bluetooth tools]), [enable_tools=${enableval}])
 AM_CONDITIONAL(TOOLS, test "${enable_tools}" != "no")
-- 
2.7.4

