Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@codecoup.pl>
Subject: [PATCH 1/2] tools/btpclient: Use address convertion function from libbluetooth
Date: Tue, 16 Jan 2018 15:03:32 +0100
Message-Id: <20180116140333.10745-1-szymon.janc@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

There is no need for internal helper.
---
 Makefile.tools    |  2 +-
 tools/btpclient.c | 12 ++++--------
 2 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/Makefile.tools b/Makefile.tools
index 651ff00ca..71d083e71 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -450,5 +450,5 @@ noinst_PROGRAMS += tools/btpclient
 
 tools_btpclient_SOURCES = tools/btpclient.c src/shared/btp.c src/shared/btp.h
 tools_btpclient_CFLAGS = $(AM_CFLAGS) @ELL_CFLAGS@
-tools_btpclient_LDADD = @ELL_LIBS@
+tools_btpclient_LDADD = @ELL_LIBS@ lib/libbluetooth-internal.la
 endif
diff --git a/tools/btpclient.c b/tools/btpclient.c
index 806403f6a..4d4475a07 100644
--- a/tools/btpclient.c
+++ b/tools/btpclient.c
@@ -32,6 +32,7 @@
 
 #include <ell/ell.h>
 
+#include "lib/bluetooth.h"
 #include "src/shared/btp.h"
 
 struct btp_adapter {
@@ -53,12 +54,6 @@ static struct btp *btp;
 
 static bool gap_service_registered;
 
-static bool str2addr(const char *str, uint8_t *addr)
-{
-	return sscanf(str, "%hhx:%hhx:%hhx:%hhx:%hhx:%hhx", &addr[5], &addr[4],
-				&addr[3], &addr[2], &addr[1], &addr[0]) == 6;
-}
-
 static struct btp_adapter *find_adapter_by_proxy(struct l_dbus_proxy *proxy)
 {
 	const struct l_queue_entry *entry;
@@ -181,7 +176,8 @@ static void btp_gap_read_info(uint8_t index, const void *param, uint16_t length,
 	if (!l_dbus_proxy_get_property(adapter->proxy, "Address", "s", &str))
 		goto failed;
 
-	if (!str2addr(str, rp.address))
+
+	if (str2ba(str, (bdaddr_t *)rp.address) < 0)
 		goto failed;
 
 	if (!l_dbus_proxy_get_property(adapter->proxy, "Name", "s", &str)) {
@@ -674,7 +670,7 @@ static void btp_gap_device_found_ev(struct l_dbus_proxy *proxy)
 	int16_t rssi;
 
 	if (!l_dbus_proxy_get_property(proxy, "Address", "s", &str) ||
-						!str2addr(str, ev.address))
+						str2ba(str, (bdaddr_t *)ev.address) < 0)
 		return;
 
 	if (!l_dbus_proxy_get_property(proxy, "AddressType", "s", &str))
-- 
2.14.3

