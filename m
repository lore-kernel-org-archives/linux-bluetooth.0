Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 2/3] tools/mpris-player: Rename to mpris-proxy
Date: Fri,  1 Aug 2014 14:49:13 +0300
Message-Id: <1406893754-11650-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1406893754-11650-1-git-send-email-luiz.dentz@gmail.com>
References: <1406893754-11650-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 Makefile.tools                          | 6 +++---
 tools/{mpris-player.c => mpris-proxy.c} | 0
 2 files changed, 3 insertions(+), 3 deletions(-)
 rename tools/{mpris-player.c => mpris-proxy.c} (100%)

diff --git a/Makefile.tools b/Makefile.tools
index 9226386..bf38b5d 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -279,7 +279,7 @@ noinst_PROGRAMS += tools/bdaddr tools/avinfo tools/avtest \
 			tools/hcieventmask tools/hcisecfilter \
 			tools/btmgmt tools/btinfo tools/btattach \
 			tools/btsnoop tools/btproxy tools/btiotest \
-			tools/mpris-player tools/cltest tools/seq2bseq \
+			tools/mpris-proxy tools/cltest tools/seq2bseq \
 			tools/hex2hcd tools/ibeacon
 
 tools_bdaddr_SOURCES = tools/bdaddr.c src/oui.h src/oui.c
@@ -336,8 +336,8 @@ tools_btproxy_SOURCES = tools/btproxy.c monitor/bt.h \
 tools_btiotest_SOURCES = tools/btiotest.c btio/btio.h btio/btio.c
 tools_btiotest_LDADD = lib/libbluetooth-internal.la @GLIB_LIBS@
 
-tools_mpris_player_SOURCES = tools/mpris-player.c
-tools_mpris_player_LDADD = gdbus/libgdbus-internal.la @GLIB_LIBS@ @DBUS_LIBS@
+tools_mpris_proxy_SOURCES = tools/mpris-proxy.c
+tools_mpris_proxy_LDADD = gdbus/libgdbus-internal.la @GLIB_LIBS@ @DBUS_LIBS@
 
 tools_cltest_SOURCES = tools/cltest.c monitor/mainloop.h monitor/mainloop.c
 tools_cltest_LDADD = lib/libbluetooth-internal.la
diff --git a/tools/mpris-player.c b/tools/mpris-proxy.c
similarity index 100%
rename from tools/mpris-player.c
rename to tools/mpris-proxy.c
-- 
1.9.3

