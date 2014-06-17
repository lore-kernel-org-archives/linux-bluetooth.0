Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/3] build: Remove mpris-proxy from experimental
Date: Tue, 17 Jun 2014 11:22:02 +0300
Message-Id: <1402993322-8392-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1402993322-8392-1-git-send-email-luiz.dentz@gmail.com>
References: <1402993322-8392-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes mpris-proxy tool to be compiled without --enable-experimental
---
 Makefile.tools | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Makefile.tools b/Makefile.tools
index ce04dfc..b410999 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -176,7 +176,8 @@ endif
 if TOOLS
 bin_PROGRAMS += tools/hciattach tools/hciconfig tools/hcitool tools/hcidump \
 			tools/rfcomm tools/rctest tools/l2test tools/l2ping \
-			tools/sdptool tools/ciptool tools/bccmd tools/bluemoon
+			tools/sdptool tools/ciptool tools/bccmd \
+			tools/bluemoon tools/mpris-proxy
 
 tools_hciattach_SOURCES = tools/hciattach.c tools/hciattach.h \
 						tools/hciattach_st.c \
@@ -277,8 +278,8 @@ noinst_PROGRAMS += tools/bdaddr tools/avinfo tools/avtest \
 			tools/hcieventmask tools/hcisecfilter \
 			tools/btmgmt tools/btinfo tools/btattach \
 			tools/btsnoop tools/btproxy tools/btiotest \
-			tools/mpris-proxy tools/cltest tools/seq2bseq \
-			tools/hex2hcd tools/ibeacon
+			tools/cltest tools/seq2bseq tools/hex2hcd \
+			tools/ibeacon
 
 tools_bdaddr_SOURCES = tools/bdaddr.c src/oui.h src/oui.c
 tools_bdaddr_LDADD = lib/libbluetooth-internal.la @UDEV_LIBS@
-- 
1.9.3

