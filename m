Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ v2 08/10] build: Add option to enable health profiles
Date: Thu, 17 Nov 2016 14:19:59 +0200
Message-Id: <1479385201-10559-9-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1479385201-10559-1-git-send-email-luiz.dentz@gmail.com>
References: <1479385201-10559-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds--enable-health option dedicated to enabled health plugin
so it is no longer enabled with --enable-experimental since that
enables other plugins that might not be relevant for the system.
---
 Makefile.plugins |  2 +-
 README           | 10 ++++++++++
 configure.ac     |  4 ++++
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/Makefile.plugins b/Makefile.plugins
index ba58518..59342c0 100644
--- a/Makefile.plugins
+++ b/Makefile.plugins
@@ -76,7 +76,7 @@ builtin_sources += profiles/input/hog.c profiles/input/uhid_copy.h \
 EXTRA_DIST += profiles/input/suspend-dummy.c
 endif
 
-if EXPERIMENTAL
+if HEALTH
 builtin_modules += health
 builtin_sources += profiles/health/mcap.h profiles/health/mcap.c \
 			profiles/health/hdp_main.c profiles/health/hdp_types.h \
diff --git a/README b/README
index 08c0ab4..823a204 100644
--- a/README
+++ b/README
@@ -186,6 +186,16 @@ For a working system, certain configuration options need to be enabled:
 		The plugin is built into bluetoothd therefore it does not need
 		to be package separately.
 
+	--enable-health
+
+		This option enable health profiles.
+
+		By default health plugin is disabled since its profiles are
+		target for the health industry.
+
+		The plugin is built into bluetoothd therefore it does not need
+		to be package separately.
+
 Information
 ===========
 
diff --git a/configure.ac b/configure.ac
index 3c2dc4d..24d7589 100644
--- a/configure.ac
+++ b/configure.ac
@@ -168,6 +168,10 @@ AC_ARG_ENABLE(test, AC_HELP_STRING([--disable-hog],
 		[disable HoG profile]), [enable_hog=${enableval}])
 AM_CONDITIONAL(HOG, test "${enable_hog}" != "no")
 
+AC_ARG_ENABLE(test, AC_HELP_STRING([--enable-health],
+		[enable health profiles]), [enable_health=${enableval}])
+AM_CONDITIONAL(HEALTH, test "${enable_health}" = "yes")
+
 AC_ARG_ENABLE(tools, AC_HELP_STRING([--disable-tools],
 		[disable Bluetooth tools]), [enable_tools=${enableval}])
 AM_CONDITIONAL(TOOLS, test "${enable_tools}" != "no")
-- 
2.7.4

