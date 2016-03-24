Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] build: Make old GATT plugins deprecated
Date: Thu, 24 Mar 2016 11:31:10 +0200
Message-Id: <1458811870-7213-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This disables building plugins that are no longer supported by the core
since the transition to gatt-db. In the future these plugins will have to
be ported to use gatt-db or be removed if the profile can be implemented
using the GATT D-Bus APIs.
---
 Makefile.plugins | 2 +-
 configure.ac     | 5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/Makefile.plugins b/Makefile.plugins
index f85b642..8a3605c 100644
--- a/Makefile.plugins
+++ b/Makefile.plugins
@@ -87,7 +87,7 @@ builtin_sources += profiles/scanparam/scan.c
 builtin_modules += deviceinfo
 builtin_sources += profiles/deviceinfo/deviceinfo.c
 
-if EXPERIMENTAL
+if DEPRECATED
 builtin_modules += alert
 builtin_sources += profiles/alert/server.c
 
diff --git a/configure.ac b/configure.ac
index bf40126..1679a47 100644
--- a/configure.ac
+++ b/configure.ac
@@ -247,6 +247,11 @@ AC_ARG_ENABLE(experimental, AC_HELP_STRING([--enable-experimental],
 					[enable_experimental=${enableval}])
 AM_CONDITIONAL(EXPERIMENTAL, test "${enable_experimental}" = "yes")
 
+AC_ARG_ENABLE(deprecated, AC_HELP_STRING([--enable-deprecated],
+			[enable deprecated plugins (BLE services, ...)]),
+					[enable_deprecated=${enableval}])
+AM_CONDITIONAL(DEPRECATED, test "${enable_deprecated}" = "yes")
+
 AC_ARG_ENABLE(sixaxis, AC_HELP_STRING([--enable-sixaxis],
 		[enable sixaxis plugin]), [enable_sixaxis=${enableval}])
 AM_CONDITIONAL(SIXAXIS, test "${enable_sixaxis}" = "yes" &&
-- 
2.5.0

