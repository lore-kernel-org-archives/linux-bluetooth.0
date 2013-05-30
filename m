Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@gmail.com>
Subject: [PATCH 3/5] build: Fix generating bluetoothd manpage
Date: Fri, 31 May 2013 00:01:55 +0200
Message-Id: <1369951317-16789-3-git-send-email-szymon.janc@gmail.com>
In-Reply-To: <1369951317-16789-1-git-send-email-szymon.janc@gmail.com>
References: <1369951317-16789-1-git-send-email-szymon.janc@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

CONFIGDIR was not properly substituted in bluetoothd.8 manpage.
---
 configure.ac |    1 +
 1 file changed, 1 insertion(+)

diff --git a/configure.ac b/configure.ac
index f3c58be..cdc9200 100644
--- a/configure.ac
+++ b/configure.ac
@@ -253,5 +253,6 @@ else
 fi
 AC_DEFINE_UNQUOTED(CONFIGDIR, "${configdir}",
 			[Directory for the configuration files])
+AC_SUBST(CONFIGDIR, "${configdir}")
 
 AC_OUTPUT(Makefile src/bluetoothd.8 lib/bluez.pc)
-- 
1.7.10.4

