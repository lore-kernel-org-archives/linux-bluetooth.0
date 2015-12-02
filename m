Return-Path: <john@metanate.com>
From: John Keeping <john@metanate.com>
To: linux-bluetooth@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>,
	John Keeping <john@metanate.com>
Subject: [PATCH 2/2] tools/btattach: install during "make install"
Date: Wed,  2 Dec 2015 10:35:00 +0000
Message-Id: <1449052500-10755-3-git-send-email-john@metanate.com>
In-Reply-To: <1449052500-10755-1-git-send-email-john@metanate.com>
References: <1449052500-10755-1-git-send-email-john@metanate.com>
List-ID: <linux-bluetooth.vger.kernel.org>

btattach provides access to some line disciplines that are supported by
hciattach, so allow it to be installed and not reserved for developer
use.  For now it is still considered an experimental feature.
---
 Makefile.tools | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/Makefile.tools b/Makefile.tools
index 034790a..e79b53b 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -250,10 +250,12 @@ EXTRA_DIST += tools/hid2hci.1
 endif
 
 if EXPERIMENTAL
+bin_PROGRAMS += tools/btattach
+
 noinst_PROGRAMS += tools/bdaddr tools/avinfo tools/avtest \
 			tools/scotest tools/amptest tools/hwdb \
 			tools/hcieventmask tools/hcisecfilter \
-			tools/btinfo tools/btattach \
+			tools/btinfo \
 			tools/btsnoop tools/btproxy \
 			tools/btiotest tools/bneptest tools/mcaptest \
 			tools/cltest tools/oobtest tools/seq2bseq \
@@ -330,7 +332,11 @@ tools_btgatt_server_SOURCES = tools/btgatt-server.c src/uuid-helper.c
 tools_btgatt_server_LDADD = src/libshared-mainloop.la \
 						lib/libbluetooth-internal.la
 
+dist_man_MANS += tools/btattach.1
+
 EXTRA_DIST += tools/bdaddr.1
+else
+EXTRA_DIST += tools/btattach.1
 endif
 
 if READLINE
-- 
2.6.3.462.gbe2c914
