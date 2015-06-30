Return-Path: <cyrus@holtmann.org>
From: Alexis Ballier <aballier@gentoo.org>
To: linux-bluetooth@vger.kernel.org
Cc: Alexis Ballier <aballier@gentoo.org>
Subject: [PATCH] Fix build with experimental enabled but no readline.
Date: Tue, 30 Jun 2015 14:40:00 +0200
Message-Id: <1435668000-26875-1-git-send-email-aballier@gentoo.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

btmgmt requires readline. Protect it under if READLINE.
---
 Makefile.tools | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Makefile.tools b/Makefile.tools
index 1899fcb..64a3e13 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -249,7 +249,7 @@ if EXPERIMENTAL
 noinst_PROGRAMS += tools/bdaddr tools/avinfo tools/avtest \
 			tools/scotest tools/amptest tools/hwdb \
 			tools/hcieventmask tools/hcisecfilter \
-			tools/btmgmt tools/btinfo tools/btattach \
+			tools/btinfo tools/btattach \
 			tools/btsnoop tools/btproxy \
 			tools/btiotest tools/bneptest tools/mcaptest \
 			tools/cltest tools/oobtest tools/seq2bseq \
@@ -272,9 +272,12 @@ tools_hwdb_LDADD = lib/libbluetooth-internal.la
 
 tools_hcieventmask_LDADD = lib/libbluetooth-internal.la
 
+if READLINE
+noinst_PROGRAMS += tools/btmgmt
 tools_btmgmt_SOURCES = tools/btmgmt.c src/uuid-helper.c client/display.c
 tools_btmgmt_LDADD = lib/libbluetooth-internal.la src/libshared-mainloop.la \
 				-lreadline
+endif
 
 tools_btinfo_SOURCES = tools/btinfo.c monitor/bt.h
 tools_btinfo_LDADD = src/libshared-mainloop.la
-- 
2.4.5

