Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2] build: Libify gobex
Date: Fri, 18 Oct 2013 13:16:19 +0300
Message-Id: <1382091380-31518-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This enables tools/binaries to link directly with libgobex-internal.la
so gobex only need to be compiled once.
---
 Makefile.am    | 35 ++++++++++++++++++-----------------
 Makefile.obexd |  4 ++--
 Makefile.tools | 13 +++++++------
 3 files changed, 27 insertions(+), 25 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 8aed6f7..816c071 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -102,12 +102,14 @@ attrib_sources = attrib/att.h attrib/att-database.h attrib/att.c \
 
 btio_sources = btio/btio.h btio/btio.c
 
-gobex_sources = gobex/gobex.h gobex/gobex.c \
-			gobex/gobex-defs.h gobex/gobex-defs.c \
-			gobex/gobex-packet.c gobex/gobex-packet.h \
-			gobex/gobex-header.c gobex/gobex-header.h \
-			gobex/gobex-transfer.c gobex/gobex-debug.h \
-			gobex/gobex-apparam.c gobex/gobex-apparam.h
+noinst_LTLIBRARIES += gobex/libgobex-internal.la
+
+gobex_libgobex_internal_la_SOURCES = gobex/gobex.h gobex/gobex.c \
+				gobex/gobex-defs.h gobex/gobex-defs.c \
+				gobex/gobex-packet.c gobex/gobex-packet.h \
+				gobex/gobex-header.c gobex/gobex-header.h \
+				gobex/gobex-transfer.c gobex/gobex-debug.h \
+				gobex/gobex-apparam.c gobex/gobex-apparam.h
 
 builtin_modules =
 builtin_sources =
@@ -258,25 +260,24 @@ unit_test_gdbus_client_LDADD = gdbus/libgdbus-internal.la \
 unit_tests += unit/test-gobex-header unit/test-gobex-packet unit/test-gobex \
 			unit/test-gobex-transfer unit/test-gobex-apparam
 
-unit_test_gobex_SOURCES = $(gobex_sources) unit/util.c unit/util.h \
-						unit/test-gobex.c
-unit_test_gobex_LDADD = @GLIB_LIBS@
+unit_test_gobex_SOURCES = unit/util.c unit/util.h unit/test-gobex.c
+unit_test_gobex_LDADD = gobex/libgobex-internal.la @GLIB_LIBS@
 
-unit_test_gobex_packet_SOURCES = $(gobex_sources) unit/util.c unit/util.h \
+unit_test_gobex_packet_SOURCES = unit/util.c unit/util.h \
 						unit/test-gobex-packet.c
-unit_test_gobex_packet_LDADD = @GLIB_LIBS@
+unit_test_gobex_packet_LDADD = gobex/libgobex-internal.la @GLIB_LIBS@
 
-unit_test_gobex_header_SOURCES = $(gobex_sources) unit/util.c unit/util.h \
+unit_test_gobex_header_SOURCES = unit/util.c unit/util.h \
 						unit/test-gobex-header.c
-unit_test_gobex_header_LDADD = @GLIB_LIBS@
+unit_test_gobex_header_LDADD = gobex/libgobex-internal.la @GLIB_LIBS@
 
-unit_test_gobex_transfer_SOURCES = $(gobex_sources) unit/util.c unit/util.h \
+unit_test_gobex_transfer_SOURCES = unit/util.c unit/util.h \
 						unit/test-gobex-transfer.c
-unit_test_gobex_transfer_LDADD = @GLIB_LIBS@
+unit_test_gobex_transfer_LDADD = gobex/libgobex-internal.la @GLIB_LIBS@
 
-unit_test_gobex_apparam_SOURCES = $(gobex_sources) unit/util.c unit/util.h \
+unit_test_gobex_apparam_SOURCES = unit/util.c unit/util.h \
 						unit/test-gobex-apparam.c
-unit_test_gobex_apparam_LDADD = @GLIB_LIBS@
+unit_test_gobex_apparam_LDADD = gobex/libgobex-internal.la @GLIB_LIBS@
 
 unit_tests += unit/test-lib
 
diff --git a/Makefile.obexd b/Makefile.obexd
index 3760867..1aad9ce 100644
--- a/Makefile.obexd
+++ b/Makefile.obexd
@@ -54,8 +54,7 @@ obexd_builtin_sources += obexd/client/mns.c obexd/src/map_ap.h \
 
 libexec_PROGRAMS += obexd/src/obexd
 
-obexd_src_obexd_SOURCES = $(btio_sources) $(gobex_sources) \
-			$(obexd_builtin_sources) \
+obexd_src_obexd_SOURCES = $(btio_sources) $(obexd_builtin_sources) \
 			obexd/src/main.c obexd/src/obexd.h \
 			obexd/src/plugin.h obexd/src/plugin.c \
 			obexd/src/log.h obexd/src/log.c \
@@ -81,6 +80,7 @@ obexd_src_obexd_SOURCES = $(btio_sources) $(gobex_sources) \
 			obexd/src/map_ap.h
 obexd_src_obexd_LDADD = lib/libbluetooth-internal.la \
 			gdbus/libgdbus-internal.la \
+			gobex/libgobex-internal.la \
 			@ICAL_LIBS@ @DBUS_LIBS@ @GLIB_LIBS@ -ldl
 
 obexd_src_obexd_LDFLAGS = -Wl,--export-dynamic
diff --git a/Makefile.tools b/Makefile.tools
index 840b95c..43bcf2e 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -227,14 +227,15 @@ attrib_gatttool_SOURCES = attrib/gatttool.c attrib/att.c attrib/gatt.c \
 				client/display.h
 attrib_gatttool_LDADD = lib/libbluetooth-internal.la @GLIB_LIBS@ -lreadline
 
-tools_obex_client_tool_SOURCES = $(gobex_sources) $(btio_sources) \
-						tools/obex-client-tool.c
+tools_obex_client_tool_SOURCES = $(btio_sources) tools/obex-client-tool.c
 tools_obex_client_tool_LDADD = lib/libbluetooth-internal.la \
-						@GLIB_LIBS@ -lreadline
+				gobex/libgobex-internal.la \
+				@GLIB_LIBS@ -lreadline
 
-tools_obex_server_tool_SOURCES = $(gobex_sources) $(btio_sources) \
-						tools/obex-server-tool.c
-tools_obex_server_tool_LDADD = lib/libbluetooth-internal.la @GLIB_LIBS@
+tools_obex_server_tool_SOURCES = $(btio_sources) tools/obex-server-tool.c
+tools_obex_server_tool_LDADD = lib/libbluetooth-internal.la \
+				gobex/libgobex-internal.la \
+				@GLIB_LIBS@
 
 tools_bluetooth_player_SOURCES = tools/bluetooth-player.c \
 				client/display.h client/display.c
-- 
1.8.3.1

