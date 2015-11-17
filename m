Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: John Keeping <john@metanate.com>
To: linux-bluetooth@vger.kernel.org
Cc: John Keeping <john@metanate.com>
Subject: [PATCH] build: Link mcaptest with -lrt
Date: Tue, 17 Nov 2015 15:21:11 +0000
Message-Id: <1447773671-22497-1-git-send-email-john@metanate.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

profiles/health/mcap.c uses clock_gettime(3) so it needs to be linked
with -lrt on some systems.
---
 Makefile.tools | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile.tools b/Makefile.tools
index d849bd9..6ebbe9f 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -294,7 +294,7 @@ tools_mcaptest_SOURCES = tools/mcaptest.c \
 				btio/btio.h btio/btio.c \
 				src/log.c src/log.h \
 				profiles/health/mcap.h profiles/health/mcap.c
-tools_mcaptest_LDADD = lib/libbluetooth-internal.la @GLIB_LIBS@
+tools_mcaptest_LDADD = lib/libbluetooth-internal.la @GLIB_LIBS@ -lrt
 
 tools_bneptest_SOURCES = tools/bneptest.c \
 				btio/btio.h btio/btio.c \
-- 
2.6.3.462.gbe2c914

