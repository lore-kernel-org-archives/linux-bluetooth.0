Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ v2 09/10] build: Update experimental documentation
Date: Thu, 17 Nov 2016 14:20:00 +0200
Message-Id: <1479385201-10559-10-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1479385201-10559-1-git-send-email-luiz.dentz@gmail.com>
References: <1479385201-10559-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Reflect the build changes to only leave experimental tools being
--enable-experimental.
---
 README       | 8 ++++----
 configure.ac | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/README b/README
index 823a204..7b6001b 100644
--- a/README
+++ b/README
@@ -157,14 +157,14 @@ For a working system, certain configuration options need to be enabled:
 
 	--enable-experimental
 
-		Enable experimental plugins
+		Enable experimental tools
 
-		By default all plugins that are still in development
+		By default all tools that are still in development
 		are disabled. This option can be used to enable them.
 
 		It is not recommended to enable this option for production
-		systems. The APIs or behavior of the experimental plugins
-		is unstable and might still change.
+		systems. The behavior of the experimental tools is unstable
+		and might still change.
 
 	--enable-nfc
 
diff --git a/configure.ac b/configure.ac
index 24d7589..768a20c 100644
--- a/configure.ac
+++ b/configure.ac
@@ -275,7 +275,7 @@ AC_ARG_ENABLE(manpages, AC_HELP_STRING([--enable-manpages],
 AM_CONDITIONAL(MANPAGES, test "${enable_manpages}" = "yes")
 
 AC_ARG_ENABLE(experimental, AC_HELP_STRING([--enable-experimental],
-			[enable experimental plugins (SAP, NFC, ...)]),
+			[enable experimental tools]),
 					[enable_experimental=${enableval}])
 AM_CONDITIONAL(EXPERIMENTAL, test "${enable_experimental}" = "yes")
 
-- 
2.7.4

