Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ v2 01/10] build: Add option to enable NFC pairing
Date: Thu, 17 Nov 2016 14:19:52 +0200
Message-Id: <1479385201-10559-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1479385201-10559-1-git-send-email-luiz.dentz@gmail.com>
References: <1479385201-10559-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds --enable-nfc option dedicated to enabled neard plugin
so it is no longer enabled with --enable-experimental since that
enables other plugins that might not be relevant for the system.
---
 Makefile.plugins | 4 +++-
 README           | 9 +++++++++
 configure.ac     | 4 ++++
 3 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/Makefile.plugins b/Makefile.plugins
index 4ad2103..495cb88 100644
--- a/Makefile.plugins
+++ b/Makefile.plugins
@@ -11,10 +11,12 @@ builtin_sources += plugins/autopair.c
 builtin_modules += policy
 builtin_sources += plugins/policy.c
 
-if EXPERIMENTAL
+if NFC
 builtin_modules += neard
 builtin_sources += plugins/neard.c
+endif
 
+if EXPERIMENTAL
 builtin_modules += sap
 builtin_sources += profiles/sap/main.c profiles/sap/manager.h \
 			profiles/sap/manager.c profiles/sap/server.h \
diff --git a/README b/README
index c991ab0..23405f3 100644
--- a/README
+++ b/README
@@ -116,6 +116,15 @@ For a working system, certain configuration options need to be enabled:
 		systems. The APIs or behavior of the experimental plugins
 		is unstable and might still change.
 
+	--enable-nfc
+
+		This option enable NFC pairing support.
+
+		By default the integration with neard is disabled, this gives
+		the option to enable it in system where neard is supported.
+
+		The plugin is built into bluetoothd therefore it does not need
+		to be package separately.
 
 Information
 ===========
diff --git a/configure.ac b/configure.ac
index 530d512..e1aa20a 100644
--- a/configure.ac
+++ b/configure.ac
@@ -140,6 +140,10 @@ AC_ARG_ENABLE(test, AC_HELP_STRING([--enable-test],
 		[enable test/example scripts]), [enable_test=${enableval}])
 AM_CONDITIONAL(TEST, test "${enable_test}" = "yes")
 
+AC_ARG_ENABLE(test, AC_HELP_STRING([--enable-nfc],
+		[enable NFC paring]), [enable_nfc=${enableval}])
+AM_CONDITIONAL(NFC, test "${enable_nfc}" = "yes")
+
 AC_ARG_ENABLE(tools, AC_HELP_STRING([--disable-tools],
 		[disable Bluetooth tools]), [enable_tools=${enableval}])
 AM_CONDITIONAL(TOOLS, test "${enable_tools}" != "no")
-- 
2.7.4

