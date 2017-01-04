Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/3] build: Hide deprecated tools under --enable-deprecated
Date: Wed,  4 Jan 2017 15:33:59 +0200
Message-Id: <20170104133401.3636-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This marks the following tools as deprecated as they are not longer
maintained or have been replaced by other tools:

  hciattach hciconfig hcitool hcidump rfcomm sdptool ciptool gatttool
---
 Makefile.tools | 86 ++++++++++++++++++++++++++++++++--------------------------
 README         | 11 ++++++++
 configure.ac   |  2 +-
 3 files changed, 59 insertions(+), 40 deletions(-)

diff --git a/Makefile.tools b/Makefile.tools
index 7706dc7..9841d31 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -154,11 +154,35 @@ tools_userchan_tester_LDADD = lib/libbluetooth-internal.la \
 endif
 
 if TOOLS
-bin_PROGRAMS += tools/hciattach tools/hciconfig tools/hcitool tools/hcidump \
-			tools/rfcomm tools/rctest tools/l2test tools/l2ping \
-			tools/sdptool tools/ciptool tools/bccmd \
+bin_PROGRAMS += tools/rctest tools/l2test tools/l2ping tools/bccmd \
 			tools/bluemoon tools/hex2hcd tools/mpris-proxy
 
+tools_rctest_LDADD = lib/libbluetooth-internal.la
+
+tools_l2test_LDADD = lib/libbluetooth-internal.la
+
+tools_l2ping_LDADD = lib/libbluetooth-internal.la
+
+tools_bccmd_SOURCES = tools/bccmd.c tools/csr.h tools/csr.c \
+			tools/csr_hci.c tools/csr_usb.c \
+			tools/csr_h4.c tools/csr_3wire.c \
+			tools/csr_bcsp.c tools/ubcsp.h tools/ubcsp.c
+tools_bccmd_LDADD = lib/libbluetooth-internal.la
+
+tools_bluemoon_SOURCES = tools/bluemoon.c monitor/bt.h
+tools_bluemoon_LDADD = src/libshared-mainloop.la
+
+tools_hex2hcd_SOURCES = tools/hex2hcd.c
+
+tools_mpris_proxy_SOURCES = tools/mpris-proxy.c
+tools_mpris_proxy_LDADD = gdbus/libgdbus-internal.la @GLIB_LIBS@ @DBUS_LIBS@
+
+dist_man_MANS += tools/rctest.1 tools/l2ping.1 tools/bccmd.1
+
+if DEPRECATED
+bin_PROGRAMS += tools/hciattach tools/hciconfig tools/hcitool tools/hcidump \
+			tools/rfcomm tools/sdptool tools/ciptool
+
 tools_hciattach_SOURCES = tools/hciattach.c tools/hciattach.h \
 						tools/hciattach_st.c \
 						tools/hciattach_ti.c \
@@ -200,44 +224,25 @@ tools_hcidump_SOURCES = tools/hcidump.c \
 				tools/parser/ericsson.c \
 				tools/parser/csr.c \
 				tools/parser/bpa.c
-tools_hcidump_LDADD = lib/libbluetooth-internal.la
-
-tools_rfcomm_LDADD = lib/libbluetooth-internal.la
-
-tools_rctest_LDADD = lib/libbluetooth-internal.la
-
-tools_l2test_LDADD = lib/libbluetooth-internal.la
-
-tools_l2ping_LDADD = lib/libbluetooth-internal.la
 
 tools_sdptool_SOURCES = tools/sdptool.c src/sdp-xml.h src/sdp-xml.c
 tools_sdptool_LDADD = lib/libbluetooth-internal.la @GLIB_LIBS@
 
 tools_ciptool_LDADD = lib/libbluetooth-internal.la
+tools_hcidump_LDADD = lib/libbluetooth-internal.la
 
-tools_bccmd_SOURCES = tools/bccmd.c tools/csr.h tools/csr.c \
-			tools/csr_hci.c tools/csr_usb.c \
-			tools/csr_h4.c tools/csr_3wire.c \
-			tools/csr_bcsp.c tools/ubcsp.h tools/ubcsp.c
-tools_bccmd_LDADD = lib/libbluetooth-internal.la
-
-tools_bluemoon_SOURCES = tools/bluemoon.c monitor/bt.h
-tools_bluemoon_LDADD = src/libshared-mainloop.la
-
-tools_hex2hcd_SOURCES = tools/hex2hcd.c
-
-tools_mpris_proxy_SOURCES = tools/mpris-proxy.c
-tools_mpris_proxy_LDADD = gdbus/libgdbus-internal.la @GLIB_LIBS@ @DBUS_LIBS@
+tools_rfcomm_LDADD = lib/libbluetooth-internal.la
 
 dist_man_MANS += tools/hciattach.1 tools/hciconfig.1 \
 			tools/hcitool.1 tools/hcidump.1 \
-			tools/rfcomm.1 tools/rctest.1 tools/l2ping.1 \
-			tools/sdptool.1 tools/ciptool.1 tools/bccmd.1
+			tools/rfcomm.1 tools/sdptool.1 tools/ciptool.1
 else
 EXTRA_DIST += tools/hciattach.1 tools/hciconfig.1 \
 			tools/hcitool.1 tools/hcidump.1 \
-			tools/rfcomm.1 tools/rctest.1 tools/l2ping.1 \
-			tools/sdptool.1 tools/ciptool.1 tools/bccmd.1
+			tools/rfcomm.1 tools/sdptool.1 tools/ciptool.1
+endif
+else
+EXTRA_DIST += tools/rctest.1 tools/l2ping.1 tools/bccmd.1
 endif
 
 if HID2HCI
@@ -343,18 +348,9 @@ EXTRA_DIST += tools/btattach.1
 endif
 
 if READLINE
-noinst_PROGRAMS += attrib/gatttool tools/btmgmt \
-			tools/obex-client-tool tools/obex-server-tool \
+noinst_PROGRAMS += tools/btmgmt tools/obex-client-tool tools/obex-server-tool \
 			tools/bluetooth-player tools/obexctl
 
-attrib_gatttool_SOURCES = attrib/gatttool.c attrib/att.c attrib/gatt.c \
-				attrib/gattrib.c btio/btio.c \
-				attrib/gatttool.h attrib/interactive.c \
-				attrib/utils.c src/log.c client/display.c \
-				client/display.h
-attrib_gatttool_LDADD = lib/libbluetooth-internal.la \
-			src/libshared-glib.la @GLIB_LIBS@ -lreadline
-
 tools_obex_client_tool_SOURCES = $(gobex_sources) $(btio_sources) \
 						tools/obex-client-tool.c
 tools_obex_client_tool_LDADD = lib/libbluetooth-internal.la \
@@ -377,6 +373,18 @@ tools_obexctl_LDADD = gdbus/libgdbus-internal.la \
 tools_btmgmt_SOURCES = tools/btmgmt.c src/uuid-helper.c client/display.c
 tools_btmgmt_LDADD = lib/libbluetooth-internal.la src/libshared-mainloop.la \
 				-lreadline
+if DEPRECATED
+noinst_PROGRAMS += attrib/gatttool
+
+attrib_gatttool_SOURCES = attrib/gatttool.c attrib/att.c attrib/gatt.c \
+				attrib/gattrib.c btio/btio.c \
+				attrib/gatttool.h attrib/interactive.c \
+				attrib/utils.c src/log.c client/display.c \
+				client/display.h
+attrib_gatttool_LDADD = lib/libbluetooth-internal.la \
+			src/libshared-glib.la @GLIB_LIBS@ -lreadline
+
+endif
 endif
 
 if EXPERIMENTAL
diff --git a/README b/README
index 7b6001b..c42a113 100644
--- a/README
+++ b/README
@@ -166,6 +166,17 @@ For a working system, certain configuration options need to be enabled:
 		systems. The behavior of the experimental tools is unstable
 		and might still change.
 
+	--enable-deprecated
+
+		Enable deprecated tools
+
+		By defauld all tools that are no longer maintained are
+		disabled. This option can be used to enable them.
+
+		It is not recommended to enable this option for production
+		systems. The behavior of the deprecated tools may be unstable
+		or simply don't work anymore.
+
 	--enable-nfc
 
 		This option enable NFC pairing support.
diff --git a/configure.ac b/configure.ac
index 2b0363c..fb8deab 100644
--- a/configure.ac
+++ b/configure.ac
@@ -291,7 +291,7 @@ AC_ARG_ENABLE(experimental, AC_HELP_STRING([--enable-experimental],
 AM_CONDITIONAL(EXPERIMENTAL, test "${enable_experimental}" = "yes")
 
 AC_ARG_ENABLE(deprecated, AC_HELP_STRING([--enable-deprecated],
-			[enable deprecated plugins (BLE services, ...)]),
+			[enable deprecated tools]),
 					[enable_deprecated=${enableval}])
 AM_CONDITIONAL(DEPRECATED, test "${enable_deprecated}" = "yes")
 
-- 
2.9.3

