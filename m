Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 3/3] build: Remove mpris-proxy from experimental
Date: Fri,  1 Aug 2014 14:49:14 +0300
Message-Id: <1406893754-11650-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1406893754-11650-1-git-send-email-luiz.dentz@gmail.com>
References: <1406893754-11650-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes mpris-proxy tool to be compiled without --enable-experimental
---
 Makefile.tools | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/Makefile.tools b/Makefile.tools
index bf38b5d..3616a46 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -178,7 +178,8 @@ endif
 if TOOLS
 bin_PROGRAMS += tools/hciattach tools/hciconfig tools/hcitool tools/hcidump \
 			tools/rfcomm tools/rctest tools/l2test tools/l2ping \
-			tools/sdptool tools/ciptool tools/bccmd tools/bluemoon
+			tools/sdptool tools/ciptool tools/bccmd \
+			tools/bluemoon tools/mpris-proxy
 
 tools_hciattach_SOURCES = tools/hciattach.c tools/hciattach.h \
 						tools/hciattach_st.c \
@@ -250,6 +251,9 @@ tools_bluemoon_SOURCES = tools/bluemoon.c monitor/bt.h \
 				src/shared/queue.h src/shared/queue.c \
 				src/shared/ringbuf.h src/shared/ringbuf.c
 
+tools_mpris_proxy_SOURCES = tools/mpris-proxy.c
+tools_mpris_proxy_LDADD = gdbus/libgdbus-internal.la @GLIB_LIBS@ @DBUS_LIBS@
+
 dist_man_MANS += tools/hciattach.1 tools/hciconfig.1 \
 			tools/hcitool.1 tools/hcidump.1 \
 			tools/rfcomm.1 tools/rctest.1 tools/l2ping.1 \
@@ -279,8 +283,8 @@ noinst_PROGRAMS += tools/bdaddr tools/avinfo tools/avtest \
 			tools/hcieventmask tools/hcisecfilter \
 			tools/btmgmt tools/btinfo tools/btattach \
 			tools/btsnoop tools/btproxy tools/btiotest \
-			tools/mpris-proxy tools/cltest tools/seq2bseq \
-			tools/hex2hcd tools/ibeacon
+			tools/cltest tools/seq2bseq tools/hex2hcd \
+			tools/ibeacon
 
 tools_bdaddr_SOURCES = tools/bdaddr.c src/oui.h src/oui.c
 tools_bdaddr_LDADD = lib/libbluetooth-internal.la @UDEV_LIBS@
@@ -336,9 +340,6 @@ tools_btproxy_SOURCES = tools/btproxy.c monitor/bt.h \
 tools_btiotest_SOURCES = tools/btiotest.c btio/btio.h btio/btio.c
 tools_btiotest_LDADD = lib/libbluetooth-internal.la @GLIB_LIBS@
 
-tools_mpris_proxy_SOURCES = tools/mpris-proxy.c
-tools_mpris_proxy_LDADD = gdbus/libgdbus-internal.la @GLIB_LIBS@ @DBUS_LIBS@
-
 tools_cltest_SOURCES = tools/cltest.c monitor/mainloop.h monitor/mainloop.c
 tools_cltest_LDADD = lib/libbluetooth-internal.la
 
-- 
1.9.3

