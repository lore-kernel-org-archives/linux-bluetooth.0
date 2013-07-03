Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2] build-sys: Rename lib suffix to -internal
Date: Wed,  3 Jul 2013 09:29:19 -0300
Message-Id: <1372854560-8731-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Lucas De Marchi <lucas.demarchi@intel.com>

libbluetooth-private -> libbluetooth-internal
---
 Makefile.am    | 16 ++++++++--------
 Makefile.obexd |  2 +-
 Makefile.tools | 52 ++++++++++++++++++++++++++--------------------------
 3 files changed, 35 insertions(+), 35 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 1f0788f..df1b61b 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -84,9 +84,9 @@ lib_libbluetooth_la_LDFLAGS = $(AM_LDFLAGS) -version-info 19:4:16
 lib_libbluetooth_la_DEPENDENCIES = $(local_headers)
 endif
 
-noinst_LTLIBRARIES += lib/libbluetooth-private.la
+noinst_LTLIBRARIES += lib/libbluetooth-internal.la
 
-lib_libbluetooth_private_la_SOURCES = $(lib_headers) $(lib_sources) \
+lib_libbluetooth_internal_la_SOURCES = $(lib_headers) $(lib_sources) \
 					$(extra_headers) $(extra_sources)
 
 attrib_sources = attrib/att.h attrib/att-database.h attrib/att.c \
@@ -148,12 +148,12 @@ src_bluetoothd_SOURCES = $(gdbus_sources) $(builtin_sources) \
 			src/eir.h src/eir.c \
 			src/shared/util.h src/shared/util.c \
 			src/shared/mgmt.h src/shared/mgmt.c
-src_bluetoothd_LDADD = lib/libbluetooth-private.la @GLIB_LIBS@ @DBUS_LIBS@ \
+src_bluetoothd_LDADD = lib/libbluetooth-internal.la @GLIB_LIBS@ @DBUS_LIBS@ \
 								-ldl -lrt
 src_bluetoothd_LDFLAGS = $(AM_LDFLAGS) -Wl,--export-dynamic \
 				-Wl,--version-script=$(srcdir)/src/bluetooth.ver
 
-src_bluetoothd_DEPENDENCIES = lib/libbluetooth-private.la \
+src_bluetoothd_DEPENDENCIES = lib/libbluetooth-internal.la \
 						src/bluetooth.service
 
 src_bluetoothd_CFLAGS = $(AM_CFLAGS) -DBLUETOOTH_PLUGIN_BUILTIN \
@@ -220,10 +220,10 @@ AM_CPPFLAGS = -I$(builddir)/lib -I$(builddir)/src -I$(srcdir)/src \
 unit_tests = unit/test-eir unit/test-uuid unit/test-textfile
 
 unit_test_eir_SOURCES = unit/test-eir.c src/eir.c src/glib-helper.c
-unit_test_eir_LDADD = lib/libbluetooth-private.la @GLIB_LIBS@
+unit_test_eir_LDADD = lib/libbluetooth-internal.la @GLIB_LIBS@
 
 unit_test_uuid_SOURCES = unit/test-uuid.c
-unit_test_uuid_LDADD = lib/libbluetooth-private.la @GLIB_LIBS@
+unit_test_uuid_LDADD = lib/libbluetooth-internal.la @GLIB_LIBS@
 
 unit_test_textfile_SOURCES = unit/test-textfile.c src/textfile.h src/textfile.c
 unit_test_textfile_LDADD = @GLIB_LIBS@
@@ -241,7 +241,7 @@ unit_test_sdp_SOURCES = unit/test-sdp.c \
 				src/shared/util.h src/shared/util.c \
 				src/sdpd.h src/sdpd-database.c \
 				src/sdpd-service.c src/sdpd-request.c
-unit_test_sdp_LDADD = lib/libbluetooth-private.la @GLIB_LIBS@
+unit_test_sdp_LDADD = lib/libbluetooth-internal.la @GLIB_LIBS@
 
 unit_tests += unit/test-gdbus-client
 
@@ -274,7 +274,7 @@ unit_test_gobex_apparam_LDADD = @GLIB_LIBS@
 unit_tests += unit/test-lib
 
 unit_test_lib_SOURCES = unit/test-lib.c
-unit_test_lib_LDADD = lib/libbluetooth-private.la @GLIB_LIBS@
+unit_test_lib_LDADD = lib/libbluetooth-internal.la @GLIB_LIBS@
 
 noinst_PROGRAMS += $(unit_tests)
 
diff --git a/Makefile.obexd b/Makefile.obexd
index 4937e0c..0d9b4c6 100644
--- a/Makefile.obexd
+++ b/Makefile.obexd
@@ -79,7 +79,7 @@ obexd_src_obexd_SOURCES = $(gdbus_sources) $(btio_sources) $(gobex_sources) \
 			obexd/client/dbus.h obexd/client/dbus.c \
 			obexd/client/driver.h obexd/client/driver.c \
 			obexd/src/map_ap.h
-obexd_src_obexd_LDADD = lib/libbluetooth-private.la \
+obexd_src_obexd_LDADD = lib/libbluetooth-internal.la \
 				@ICAL_LIBS@ @DBUS_LIBS@ @GLIB_LIBS@ -ldl
 
 obexd_src_obexd_LDFLAGS = -Wl,--export-dynamic
diff --git a/Makefile.tools b/Makefile.tools
index 8f245e0..e59420f 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -22,7 +22,7 @@ monitor_btmon_SOURCES = monitor/main.c monitor/bt.h \
 					monitor/l2cap.h monitor/l2cap.c \
 					monitor/uuid.h monitor/uuid.c \
 					monitor/sdp.h monitor/sdp.c
-monitor_btmon_LDADD = lib/libbluetooth-private.la
+monitor_btmon_LDADD = lib/libbluetooth-internal.la
 endif
 
 if EXPERIMENTAL
@@ -46,7 +46,7 @@ tools_mgmt_tester_SOURCES = tools/mgmt-tester.c monitor/bt.h \
 				src/shared/mgmt.h src/shared/mgmt.c \
 				src/shared/hciemu.h src/shared/hciemu.c \
 				src/shared/tester.h src/shared/tester.c
-tools_mgmt_tester_LDADD = lib/libbluetooth-private.la @GLIB_LIBS@
+tools_mgmt_tester_LDADD = lib/libbluetooth-internal.la @GLIB_LIBS@
 
 tools_l2cap_tester_SOURCES = tools/l2cap-tester.c monitor/bt.h \
 				emulator/btdev.h emulator/btdev.c \
@@ -55,7 +55,7 @@ tools_l2cap_tester_SOURCES = tools/l2cap-tester.c monitor/bt.h \
 				src/shared/mgmt.h src/shared/mgmt.c \
 				src/shared/hciemu.h src/shared/hciemu.c \
 				src/shared/tester.h src/shared/tester.c
-tools_l2cap_tester_LDADD = lib/libbluetooth-private.la @GLIB_LIBS@
+tools_l2cap_tester_LDADD = lib/libbluetooth-internal.la @GLIB_LIBS@
 
 tools_gap_tester_SOURCES = $(gdbus_sources) \
 				tools/gap-tester.c monitor/bt.h \
@@ -79,13 +79,13 @@ tools_hciattach_SOURCES = tools/hciattach.c tools/hciattach.h \
 						tools/hciattach_ath3k.c \
 						tools/hciattach_qualcomm.c \
 						tools/hciattach_intel.c
-tools_hciattach_LDADD = lib/libbluetooth-private.la
+tools_hciattach_LDADD = lib/libbluetooth-internal.la
 
 tools_hciconfig_SOURCES = tools/hciconfig.c tools/csr.h tools/csr.c
-tools_hciconfig_LDADD = lib/libbluetooth-private.la
+tools_hciconfig_LDADD = lib/libbluetooth-internal.la
 
 tools_hcitool_SOURCES = tools/hcitool.c src/oui.h src/oui.c
-tools_hcitool_LDADD = lib/libbluetooth-private.la @GLIB_LIBS@ @UDEV_LIBS@
+tools_hcitool_LDADD = lib/libbluetooth-internal.la @GLIB_LIBS@ @UDEV_LIBS@
 
 tools_hcidump_SOURCES = tools/hcidump.c \
 				tools/parser/parser.h tools/parser/parser.c \
@@ -112,25 +112,25 @@ tools_hcidump_SOURCES = tools/hcidump.c \
 				tools/parser/ericsson.c \
 				tools/parser/csr.c \
 				tools/parser/bpa.c
-tools_hcidump_LDADD = lib/libbluetooth-private.la
+tools_hcidump_LDADD = lib/libbluetooth-internal.la
 
-tools_rfcomm_LDADD = lib/libbluetooth-private.la
+tools_rfcomm_LDADD = lib/libbluetooth-internal.la
 
-tools_rctest_LDADD = lib/libbluetooth-private.la
+tools_rctest_LDADD = lib/libbluetooth-internal.la
 
-tools_l2test_LDADD = lib/libbluetooth-private.la
+tools_l2test_LDADD = lib/libbluetooth-internal.la
 
-tools_l2ping_LDADD = lib/libbluetooth-private.la
+tools_l2ping_LDADD = lib/libbluetooth-internal.la
 
 tools_sdptool_SOURCES = tools/sdptool.c src/sdp-xml.h src/sdp-xml.c
-tools_sdptool_LDADD = lib/libbluetooth-private.la @GLIB_LIBS@
+tools_sdptool_LDADD = lib/libbluetooth-internal.la @GLIB_LIBS@
 
-tools_ciptool_LDADD = lib/libbluetooth-private.la
+tools_ciptool_LDADD = lib/libbluetooth-internal.la
 
 tools_bccmd_SOURCES = tools/bccmd.c tools/csr.h tools/csr.c \
 			tools/csr_hci.c tools/csr_h4.c tools/csr_3wire.c \
 			tools/csr_bcsp.c tools/ubcsp.h tools/ubcsp.c
-tools_bccmd_LDADD = lib/libbluetooth-private.la
+tools_bccmd_LDADD = lib/libbluetooth-internal.la
 
 if USB
 tools_bccmd_SOURCES += tools/csr_usb.c
@@ -168,25 +168,25 @@ noinst_PROGRAMS += tools/bdaddr tools/avinfo tools/avtest tools/scotest \
 			tools/bluetooth-player
 
 tools_bdaddr_SOURCES = tools/bdaddr.c src/oui.h src/oui.c
-tools_bdaddr_LDADD = lib/libbluetooth-private.la @UDEV_LIBS@
+tools_bdaddr_LDADD = lib/libbluetooth-internal.la @UDEV_LIBS@
 
-tools_avinfo_LDADD = lib/libbluetooth-private.la
+tools_avinfo_LDADD = lib/libbluetooth-internal.la
 
-tools_avtest_LDADD = lib/libbluetooth-private.la
+tools_avtest_LDADD = lib/libbluetooth-internal.la
 
-tools_scotest_LDADD = lib/libbluetooth-private.la
+tools_scotest_LDADD = lib/libbluetooth-internal.la
 
-tools_hcieventmask_LDADD = lib/libbluetooth-private.la
+tools_hcieventmask_LDADD = lib/libbluetooth-internal.la
 
-tools_hwdb_LDADD = lib/libbluetooth-private.la
+tools_hwdb_LDADD = lib/libbluetooth-internal.la
 
 tools_btmgmt_SOURCES = tools/btmgmt.c src/glib-helper.c src/eir.c \
 				src/shared/util.h src/shared/util.c \
 				src/shared/mgmt.h src/shared/mgmt.c
-tools_btmgmt_LDADD = lib/libbluetooth-private.la @GLIB_LIBS@
+tools_btmgmt_LDADD = lib/libbluetooth-internal.la @GLIB_LIBS@
 
 tools_btiotest_SOURCES = tools/btiotest.c btio/btio.h btio/btio.c
-tools_btiotest_LDADD = lib/libbluetooth-private.la @GLIB_LIBS@
+tools_btiotest_LDADD = lib/libbluetooth-internal.la @GLIB_LIBS@
 
 tools_mpris_player_SOURCES = $(gdbus_sources) tools/mpris-player.c
 tools_mpris_player_LDADD = @GLIB_LIBS@ @DBUS_LIBS@
@@ -207,16 +207,16 @@ attrib_gatttool_SOURCES = attrib/gatttool.c attrib/att.c attrib/gatt.c \
 				attrib/gatttool.h attrib/interactive.c \
 				attrib/utils.c src/log.c client/display.c \
 				client/display.h
-attrib_gatttool_LDADD = lib/libbluetooth-private.la @GLIB_LIBS@ -lreadline
+attrib_gatttool_LDADD = lib/libbluetooth-internal.la @GLIB_LIBS@ -lreadline
 
 tools_obex_client_tool_SOURCES = $(gobex_sources) $(btio_sources) \
 						tools/obex-client-tool.c
-tools_obex_client_tool_LDADD = lib/libbluetooth-private.la \
+tools_obex_client_tool_LDADD = lib/libbluetooth-internal.la \
 						@GLIB_LIBS@ -lreadline
 
 tools_obex_server_tool_SOURCES = $(gobex_sources) $(btio_sources) \
 						tools/obex-server-tool.c
-tools_obex_server_tool_LDADD = lib/libbluetooth-private.la @GLIB_LIBS@
+tools_obex_server_tool_LDADD = lib/libbluetooth-internal.la @GLIB_LIBS@
 endif
 
 if EXPERIMENTAL
@@ -238,7 +238,7 @@ profiles_cups_bluetooth_SOURCES = $(gdbus_sources) profiles/cups/main.c \
 					profiles/cups/hcrp.c
 
 profiles_cups_bluetooth_LDADD = @GLIB_LIBS@ @DBUS_LIBS@ \
-				lib/libbluetooth-private.la
+				lib/libbluetooth-internal.la
 endif
 
 test_scripts += test/sap_client.py test/bluezutils.py \
-- 
1.8.3.2

