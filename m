Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/3] build: Add testing config option
Date: Wed,  4 Jan 2017 15:34:01 +0200
Message-Id: <20170104133401.3636-3-luiz.dentz@gmail.com>
In-Reply-To: <20170104133401.3636-1-luiz.dentz@gmail.com>
References: <20170104133401.3636-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds --enable-testing that can be used to enable emulator and tester
which are no longer experimental but also are not meant for production.
---
 Makefile.tools      |  2 +-
 README              | 11 +++++++++++
 bootstrap-configure |  1 +
 configure.ac        |  5 +++++
 4 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/Makefile.tools b/Makefile.tools
index a6995a0..55d392e 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -44,7 +44,7 @@ monitor_btmon_LDADD = lib/libbluetooth-internal.la \
 				src/libshared-mainloop.la @UDEV_LIBS@
 endif
 
-if EXPERIMENTAL
+if TESTING
 noinst_PROGRAMS += emulator/btvirt emulator/b1ee emulator/hfp \
 					peripheral/btsensor tools/3dsp \
 					tools/mgmt-tester tools/gap-tester \
diff --git a/README b/README
index c42a113..b4908ad 100644
--- a/README
+++ b/README
@@ -155,6 +155,17 @@ For a working system, certain configuration options need to be enabled:
 		This option is provided for distributions that do not have any
 		input capabilities.
 
+	--enable-testing
+
+		Enable testing tools
+
+		By default tools used only for testing emulation are disabled.
+		This option can be used to enable them.
+
+		It is not recommended to enable this option for production
+		systems. These tools may contain tests that depend on specific
+		environment or kernel features in development.
+
 	--enable-experimental
 
 		Enable experimental tools
diff --git a/bootstrap-configure b/bootstrap-configure
index ffc16ac..c7f7b04 100755
--- a/bootstrap-configure
+++ b/bootstrap-configure
@@ -13,6 +13,7 @@ fi
 		--localstatedir=/var \
 		--enable-manpages \
 		--enable-backtrace \
+		--enable-testing \
 		--enable-experimental \
 		--enable-nfc \
 		--enable-sap \
diff --git a/configure.ac b/configure.ac
index fb8deab..91b4955 100644
--- a/configure.ac
+++ b/configure.ac
@@ -285,6 +285,11 @@ AC_ARG_ENABLE(manpages, AC_HELP_STRING([--enable-manpages],
 					[enable_manpages=${enableval}])
 AM_CONDITIONAL(MANPAGES, test "${enable_manpages}" = "yes")
 
+AC_ARG_ENABLE(testing, AC_HELP_STRING([--enable-testing],
+			[enable testing tools]),
+					[enable_testing=${enableval}])
+AM_CONDITIONAL(TESTING, test "${enable_testing}" = "yes")
+
 AC_ARG_ENABLE(experimental, AC_HELP_STRING([--enable-experimental],
 			[enable experimental tools]),
 					[enable_experimental=${enableval}])
-- 
2.9.3

