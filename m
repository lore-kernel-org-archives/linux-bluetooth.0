Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 09/10] build: Update experimental documentation
Date: Fri, 11 Nov 2016 19:22:43 +0200
Message-Id: <1478884964-7543-10-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1478884964-7543-1-git-send-email-luiz.dentz@gmail.com>
References: <1478884964-7543-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Reflect the build changes to only leave experimental tools being
--enable-experimental.
---
 configure.ac | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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

