Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ v2 03/10] build: Add option to disable A2DP profile
Date: Thu, 17 Nov 2016 14:19:54 +0200
Message-Id: <1479385201-10559-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1479385201-10559-1-git-send-email-luiz.dentz@gmail.com>
References: <1479385201-10559-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds --disable-a2dp option to configure which make A2DP plugin
to not be build thus reducing the build time and binary size of
bluetoothd in systems where A2DP is not supported.
---
 Makefile.plugins |  2 ++
 README           | 10 ++++++++++
 configure.ac     |  4 ++++
 3 files changed, 16 insertions(+)

diff --git a/Makefile.plugins b/Makefile.plugins
index 39eb3a0..e69ffab 100644
--- a/Makefile.plugins
+++ b/Makefile.plugins
@@ -27,6 +27,7 @@ noinst_LIBRARIES += profiles/sap/libsap.a
 profiles_sap_libsap_a_SOURCES = profiles/sap/sap.h profiles/sap/sap-u8500.c
 endif
 
+if A2DP
 builtin_modules += a2dp
 builtin_sources += profiles/audio/source.h profiles/audio/source.c \
 			profiles/audio/sink.h profiles/audio/sink.c \
@@ -35,6 +36,7 @@ builtin_sources += profiles/audio/source.h profiles/audio/source.c \
 			profiles/audio/media.h profiles/audio/media.c \
 			profiles/audio/transport.h profiles/audio/transport.c \
 			profiles/audio/a2dp-codecs.h
+endif
 
 builtin_modules += avrcp
 builtin_sources += profiles/audio/control.h profiles/audio/control.c \
diff --git a/README b/README
index f084a74..9f6d4f1 100644
--- a/README
+++ b/README
@@ -105,6 +105,16 @@ For a working system, certain configuration options need to be enabled:
 		support systemd. In that case all integration with the
 		init system is up to the package.
 
+	--disable-a2dp
+
+		Disable A2DP profile
+
+		By default bluetoothd supports A2DP profile using a built-in
+		plugin, this option disables it.
+
+		This option is provided for distributions that do not have any
+		audio capabilities.
+
 	--enable-experimental
 
 		Enable experimental plugins
diff --git a/configure.ac b/configure.ac
index ce57b63..6761e29 100644
--- a/configure.ac
+++ b/configure.ac
@@ -148,6 +148,10 @@ AC_ARG_ENABLE(test, AC_HELP_STRING([--enable-sap],
 		[enable SAP profile]), [enable_sap=${enableval}])
 AM_CONDITIONAL(SAP, test "${enable_sap}" = "yes")
 
+AC_ARG_ENABLE(test, AC_HELP_STRING([--disable-a2dp],
+		[disable A2DP profile]), [enable_a2dp=${enableval}])
+AM_CONDITIONAL(A2DP, test "${enable_a2dp}" != "no")
+
 AC_ARG_ENABLE(tools, AC_HELP_STRING([--disable-tools],
 		[disable Bluetooth tools]), [enable_tools=${enableval}])
 AM_CONDITIONAL(TOOLS, test "${enable_tools}" != "no")
-- 
2.7.4

