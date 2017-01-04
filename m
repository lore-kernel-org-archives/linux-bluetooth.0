Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/3] build: Promote experiemental tools
Date: Wed,  4 Jan 2017 15:34:00 +0200
Message-Id: <20170104133401.3636-2-luiz.dentz@gmail.com>
In-Reply-To: <20170104133401.3636-1-luiz.dentz@gmail.com>
References: <20170104133401.3636-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This promotes many tools that were behind --enable-experimental which are
in fact used as stable tools for a while.
---
 Makefile.tools | 198 +++++++++++++++++++++++++++------------------------------
 1 file changed, 93 insertions(+), 105 deletions(-)

diff --git a/Makefile.tools b/Makefile.tools
index 9841d31..a6995a0 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -155,7 +155,89 @@ endif
 
 if TOOLS
 bin_PROGRAMS += tools/rctest tools/l2test tools/l2ping tools/bccmd \
-			tools/bluemoon tools/hex2hcd tools/mpris-proxy
+			tools/bluemoon tools/hex2hcd tools/mpris-proxy \
+			tools/btattach
+
+noinst_PROGRAMS += tools/bdaddr tools/avinfo tools/avtest \
+			tools/scotest tools/amptest tools/hwdb \
+			tools/hcieventmask tools/hcisecfilter \
+			tools/btinfo \
+			tools/btsnoop tools/btproxy \
+			tools/btiotest tools/bneptest tools/mcaptest \
+			tools/cltest tools/oobtest tools/seq2bseq \
+			tools/nokfw tools/create-image \
+			tools/eddystone tools/ibeacon \
+			tools/btgatt-client tools/btgatt-server \
+			tools/test-runner tools/check-selftest \
+			tools/gatt-service profiles/iap/iapd
+
+tools_bdaddr_SOURCES = tools/bdaddr.c src/oui.h src/oui.c
+tools_bdaddr_LDADD = lib/libbluetooth-internal.la @UDEV_LIBS@
+
+tools_avinfo_LDADD = lib/libbluetooth-internal.la
+
+tools_avtest_LDADD = lib/libbluetooth-internal.la
+
+tools_scotest_LDADD = lib/libbluetooth-internal.la
+
+tools_amptest_LDADD = lib/libbluetooth-internal.la
+
+tools_hwdb_LDADD = lib/libbluetooth-internal.la
+
+tools_hcieventmask_LDADD = lib/libbluetooth-internal.la
+
+tools_btinfo_SOURCES = tools/btinfo.c monitor/bt.h
+tools_btinfo_LDADD = src/libshared-mainloop.la
+
+tools_btattach_SOURCES = tools/btattach.c monitor/bt.h
+tools_btattach_LDADD = src/libshared-mainloop.la
+
+tools_btsnoop_SOURCES = tools/btsnoop.c
+tools_btsnoop_LDADD = src/libshared-mainloop.la
+
+tools_btproxy_SOURCES = tools/btproxy.c monitor/bt.h
+tools_btproxy_LDADD = src/libshared-mainloop.la
+
+tools_btiotest_SOURCES = tools/btiotest.c btio/btio.h btio/btio.c
+tools_btiotest_LDADD = lib/libbluetooth-internal.la @GLIB_LIBS@
+
+tools_mcaptest_SOURCES = tools/mcaptest.c \
+				btio/btio.h btio/btio.c \
+				src/log.c src/log.h \
+				profiles/health/mcap.h profiles/health/mcap.c
+tools_mcaptest_LDADD = lib/libbluetooth-internal.la @GLIB_LIBS@ -lrt
+
+tools_bneptest_SOURCES = tools/bneptest.c \
+				btio/btio.h btio/btio.c \
+				src/log.h src/log.c \
+				profiles/network/bnep.h profiles/network/bnep.c
+tools_bneptest_LDADD = lib/libbluetooth-internal.la @GLIB_LIBS@
+
+tools_cltest_SOURCES = tools/cltest.c
+tools_cltest_LDADD = lib/libbluetooth-internal.la src/libshared-mainloop.la
+
+tools_oobtest_SOURCES = tools/oobtest.c
+tools_oobtest_LDADD = lib/libbluetooth-internal.la src/libshared-mainloop.la
+
+tools_seq2bseq_SOURCES = tools/seq2bseq.c
+
+tools_nokfw_SOURCES = tools/nokfw.c
+
+tools_create_image_SOURCES = tools/create-image.c
+
+tools_eddystone_SOURCES = tools/eddystone.c monitor/bt.h
+tools_eddystone_LDADD = src/libshared-mainloop.la
+
+tools_ibeacon_SOURCES = tools/ibeacon.c monitor/bt.h
+tools_ibeacon_LDADD = src/libshared-mainloop.la
+
+tools_btgatt_client_SOURCES = tools/btgatt-client.c src/uuid-helper.c
+tools_btgatt_client_LDADD = src/libshared-mainloop.la \
+						lib/libbluetooth-internal.la
+
+tools_btgatt_server_SOURCES = tools/btgatt-server.c src/uuid-helper.c
+tools_btgatt_server_LDADD = src/libshared-mainloop.la \
+						lib/libbluetooth-internal.la
 
 tools_rctest_LDADD = lib/libbluetooth-internal.la
 
@@ -177,7 +259,15 @@ tools_hex2hcd_SOURCES = tools/hex2hcd.c
 tools_mpris_proxy_SOURCES = tools/mpris-proxy.c
 tools_mpris_proxy_LDADD = gdbus/libgdbus-internal.la @GLIB_LIBS@ @DBUS_LIBS@
 
-dist_man_MANS += tools/rctest.1 tools/l2ping.1 tools/bccmd.1
+tools_gatt_service_SOURCES = tools/gatt-service.c
+tools_gatt_service_LDADD = @GLIB_LIBS@ @DBUS_LIBS@ gdbus/libgdbus-internal.la
+
+profiles_iap_iapd_SOURCES = profiles/iap/main.c
+profiles_iap_iapd_LDADD = gdbus/libgdbus-internal.la @GLIB_LIBS@ @DBUS_LIBS@
+
+dist_man_MANS += tools/rctest.1 tools/l2ping.1 tools/bccmd.1 tools/btattach.1
+
+EXTRA_DIST += tools/bdaddr.1
 
 if DEPRECATED
 bin_PROGRAMS += tools/hciattach tools/hciconfig tools/hcitool tools/hcidump \
@@ -242,7 +332,7 @@ EXTRA_DIST += tools/hciattach.1 tools/hciconfig.1 \
 			tools/rfcomm.1 tools/sdptool.1 tools/ciptool.1
 endif
 else
-EXTRA_DIST += tools/rctest.1 tools/l2ping.1 tools/bccmd.1
+EXTRA_DIST += tools/rctest.1 tools/l2ping.1 tools/bccmd.1 tools/btattach.1
 endif
 
 if HID2HCI
@@ -257,96 +347,6 @@ else
 EXTRA_DIST += tools/hid2hci.1
 endif
 
-if EXPERIMENTAL
-bin_PROGRAMS += tools/btattach
-
-noinst_PROGRAMS += tools/bdaddr tools/avinfo tools/avtest \
-			tools/scotest tools/amptest tools/hwdb \
-			tools/hcieventmask tools/hcisecfilter \
-			tools/btinfo \
-			tools/btsnoop tools/btproxy \
-			tools/btiotest tools/bneptest tools/mcaptest \
-			tools/cltest tools/oobtest tools/seq2bseq \
-			tools/nokfw tools/create-image \
-			tools/eddystone tools/ibeacon \
-			tools/btgatt-client tools/btgatt-server \
-			tools/test-runner tools/check-selftest
-
-tools_bdaddr_SOURCES = tools/bdaddr.c src/oui.h src/oui.c
-tools_bdaddr_LDADD = lib/libbluetooth-internal.la @UDEV_LIBS@
-
-tools_avinfo_LDADD = lib/libbluetooth-internal.la
-
-tools_avtest_LDADD = lib/libbluetooth-internal.la
-
-tools_scotest_LDADD = lib/libbluetooth-internal.la
-
-tools_amptest_LDADD = lib/libbluetooth-internal.la
-
-tools_hwdb_LDADD = lib/libbluetooth-internal.la
-
-tools_hcieventmask_LDADD = lib/libbluetooth-internal.la
-
-tools_btinfo_SOURCES = tools/btinfo.c monitor/bt.h
-tools_btinfo_LDADD = src/libshared-mainloop.la
-
-tools_btattach_SOURCES = tools/btattach.c monitor/bt.h
-tools_btattach_LDADD = src/libshared-mainloop.la
-
-tools_btsnoop_SOURCES = tools/btsnoop.c
-tools_btsnoop_LDADD = src/libshared-mainloop.la
-
-tools_btproxy_SOURCES = tools/btproxy.c monitor/bt.h
-tools_btproxy_LDADD = src/libshared-mainloop.la
-
-tools_btiotest_SOURCES = tools/btiotest.c btio/btio.h btio/btio.c
-tools_btiotest_LDADD = lib/libbluetooth-internal.la @GLIB_LIBS@
-
-tools_mcaptest_SOURCES = tools/mcaptest.c \
-				btio/btio.h btio/btio.c \
-				src/log.c src/log.h \
-				profiles/health/mcap.h profiles/health/mcap.c
-tools_mcaptest_LDADD = lib/libbluetooth-internal.la @GLIB_LIBS@ -lrt
-
-tools_bneptest_SOURCES = tools/bneptest.c \
-				btio/btio.h btio/btio.c \
-				src/log.h src/log.c \
-				profiles/network/bnep.h profiles/network/bnep.c
-tools_bneptest_LDADD = lib/libbluetooth-internal.la @GLIB_LIBS@
-
-tools_cltest_SOURCES = tools/cltest.c
-tools_cltest_LDADD = lib/libbluetooth-internal.la src/libshared-mainloop.la
-
-tools_oobtest_SOURCES = tools/oobtest.c
-tools_oobtest_LDADD = lib/libbluetooth-internal.la src/libshared-mainloop.la
-
-tools_seq2bseq_SOURCES = tools/seq2bseq.c
-
-tools_nokfw_SOURCES = tools/nokfw.c
-
-tools_create_image_SOURCES = tools/create-image.c
-
-tools_eddystone_SOURCES = tools/eddystone.c monitor/bt.h
-tools_eddystone_LDADD = src/libshared-mainloop.la
-
-tools_ibeacon_SOURCES = tools/ibeacon.c monitor/bt.h
-tools_ibeacon_LDADD = src/libshared-mainloop.la
-
-tools_btgatt_client_SOURCES = tools/btgatt-client.c src/uuid-helper.c
-tools_btgatt_client_LDADD = src/libshared-mainloop.la \
-						lib/libbluetooth-internal.la
-
-tools_btgatt_server_SOURCES = tools/btgatt-server.c src/uuid-helper.c
-tools_btgatt_server_LDADD = src/libshared-mainloop.la \
-						lib/libbluetooth-internal.la
-
-dist_man_MANS += tools/btattach.1
-
-EXTRA_DIST += tools/bdaddr.1
-else
-EXTRA_DIST += tools/btattach.1
-endif
-
 if READLINE
 noinst_PROGRAMS += tools/btmgmt tools/obex-client-tool tools/obex-server-tool \
 			tools/bluetooth-player tools/obexctl
@@ -387,18 +387,6 @@ attrib_gatttool_LDADD = lib/libbluetooth-internal.la \
 endif
 endif
 
-if EXPERIMENTAL
-noinst_PROGRAMS += tools/gatt-service
-
-tools_gatt_service_SOURCES = tools/gatt-service.c
-tools_gatt_service_LDADD = @GLIB_LIBS@ @DBUS_LIBS@ gdbus/libgdbus-internal.la
-
-noinst_PROGRAMS += profiles/iap/iapd
-
-profiles_iap_iapd_SOURCES = profiles/iap/main.c
-profiles_iap_iapd_LDADD = gdbus/libgdbus-internal.la @GLIB_LIBS@ @DBUS_LIBS@
-endif
-
 if CUPS
 cupsdir = $(libdir)/cups/backend
 
-- 
2.9.3

