Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ v2 02/10] build: Add option to enable SAP profile
Date: Thu, 17 Nov 2016 14:19:53 +0200
Message-Id: <1479385201-10559-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1479385201-10559-1-git-send-email-luiz.dentz@gmail.com>
References: <1479385201-10559-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds --enable-sap option dedicated to enabled sap plugin
so it is no longer enabled with --enable-experimental leaving it to just
enable experimental tools.
---
 Makefile.plugins |  2 +-
 README           | 10 ++++++++++
 configure.ac     |  4 ++++
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/Makefile.plugins b/Makefile.plugins
index 495cb88..39eb3a0 100644
--- a/Makefile.plugins
+++ b/Makefile.plugins
@@ -16,7 +16,7 @@ builtin_modules += neard
 builtin_sources += plugins/neard.c
 endif
 
-if EXPERIMENTAL
+if SAP
 builtin_modules += sap
 builtin_sources += profiles/sap/main.c profiles/sap/manager.h \
 			profiles/sap/manager.c profiles/sap/server.h \
diff --git a/README b/README
index 23405f3..f084a74 100644
--- a/README
+++ b/README
@@ -126,6 +126,16 @@ For a working system, certain configuration options need to be enabled:
 		The plugin is built into bluetoothd therefore it does not need
 		to be package separately.
 
+	--enable-sap
+
+		This option enable SAP profile using sap plugin.
+
+		By default sap plugin is disabled since it requires tight
+		integration with systems and is very rarely required.
+
+		The plugin is built into bluetoothd therefore it does not need
+		to be package separately.
+
 Information
 ===========
 
diff --git a/configure.ac b/configure.ac
index e1aa20a..ce57b63 100644
--- a/configure.ac
+++ b/configure.ac
@@ -144,6 +144,10 @@ AC_ARG_ENABLE(test, AC_HELP_STRING([--enable-nfc],
 		[enable NFC paring]), [enable_nfc=${enableval}])
 AM_CONDITIONAL(NFC, test "${enable_nfc}" = "yes")
 
+AC_ARG_ENABLE(test, AC_HELP_STRING([--enable-sap],
+		[enable SAP profile]), [enable_sap=${enableval}])
+AM_CONDITIONAL(SAP, test "${enable_sap}" = "yes")
+
 AC_ARG_ENABLE(tools, AC_HELP_STRING([--disable-tools],
 		[disable Bluetooth tools]), [enable_tools=${enableval}])
 AM_CONDITIONAL(TOOLS, test "${enable_tools}" != "no")
-- 
2.7.4

