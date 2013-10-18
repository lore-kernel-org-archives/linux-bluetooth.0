Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] build: Libify btio
Date: Fri, 18 Oct 2013 13:16:20 +0300
Message-Id: <1382091380-31518-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1382091380-31518-1-git-send-email-luiz.dentz@gmail.com>
References: <1382091380-31518-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This enables tools/binaries to link directly with libbtio-internal.la
so btio only need to be compiled once.
---
 Makefile.am    | 13 ++++++++-----
 Makefile.obexd |  3 ++-
 Makefile.tools | 24 ++++++++++++++----------
 3 files changed, 24 insertions(+), 16 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 816c071..f73176c 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -100,7 +100,9 @@ attrib_sources = attrib/att.h attrib/att-database.h attrib/att.c \
 		attrib/gattrib.h attrib/gattrib.c \
 		attrib/gatt-service.h attrib/gatt-service.c
 
-btio_sources = btio/btio.h btio/btio.c
+noinst_LTLIBRARIES += btio/libbtio-internal.la
+
+btio_libbtio_internal_la_SOURCES = btio/btio.h btio/btio.c
 
 noinst_LTLIBRARIES += gobex/libgobex-internal.la
 
@@ -127,8 +129,7 @@ endif
 
 libexec_PROGRAMS += src/bluetoothd
 
-src_bluetoothd_SOURCES = $(builtin_sources) \
-			$(attrib_sources) $(btio_sources) \
+src_bluetoothd_SOURCES = $(builtin_sources) $(attrib_sources) \
 			src/bluetooth.ver \
 			src/main.c src/log.h src/log.c \
 			src/systemd.h src/systemd.c \
@@ -154,12 +155,14 @@ src_bluetoothd_SOURCES = $(builtin_sources) \
 			src/shared/util.h src/shared/util.c \
 			src/shared/mgmt.h src/shared/mgmt.c
 src_bluetoothd_LDADD = lib/libbluetooth-internal.la gdbus/libgdbus-internal.la \
-			@GLIB_LIBS@ @DBUS_LIBS@ -ldl -lrt
+			btio/libbtio-internal.la @GLIB_LIBS@ @DBUS_LIBS@ -ldl \
+			-lrt
 src_bluetoothd_LDFLAGS = $(AM_LDFLAGS) -Wl,--export-dynamic \
 				-Wl,--version-script=$(srcdir)/src/bluetooth.ver
 
 src_bluetoothd_DEPENDENCIES = lib/libbluetooth-internal.la \
-				gdbus/libgdbus-internal.la src/bluetooth.service
+				gdbus/libgdbus-internal.la \
+				btio/libbtio-internal.la src/bluetooth.service
 
 src_bluetoothd_CFLAGS = $(AM_CFLAGS) -DBLUETOOTH_PLUGIN_BUILTIN \
 					-DPLUGINDIR=\""$(build_plugindir)"\"
diff --git a/Makefile.obexd b/Makefile.obexd
index 1aad9ce..922b1b4 100644
--- a/Makefile.obexd
+++ b/Makefile.obexd
@@ -54,7 +54,7 @@ obexd_builtin_sources += obexd/client/mns.c obexd/src/map_ap.h \
 
 libexec_PROGRAMS += obexd/src/obexd
 
-obexd_src_obexd_SOURCES = $(btio_sources) $(obexd_builtin_sources) \
+obexd_src_obexd_SOURCES = $(obexd_builtin_sources) \
 			obexd/src/main.c obexd/src/obexd.h \
 			obexd/src/plugin.h obexd/src/plugin.c \
 			obexd/src/log.h obexd/src/log.c \
@@ -81,6 +81,7 @@ obexd_src_obexd_SOURCES = $(btio_sources) $(obexd_builtin_sources) \
 obexd_src_obexd_LDADD = lib/libbluetooth-internal.la \
 			gdbus/libgdbus-internal.la \
 			gobex/libgobex-internal.la \
+			btio/libbtio-internal.la \
 			@ICAL_LIBS@ @DBUS_LIBS@ @GLIB_LIBS@ -ldl
 
 obexd_src_obexd_LDFLAGS = -Wl,--export-dynamic
diff --git a/Makefile.tools b/Makefile.tools
index 43bcf2e..c30b831 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -203,8 +203,9 @@ tools_btsnoop_SOURCES = tools/btsnoop.c \
 				src/shared/pcap.h src/shared/pcap.c \
 				src/shared/btsnoop.h src/shared/btsnoop.c
 
-tools_btiotest_SOURCES = tools/btiotest.c btio/btio.h btio/btio.c
-tools_btiotest_LDADD = lib/libbluetooth-internal.la @GLIB_LIBS@
+tools_btiotest_SOURCES = tools/btiotest.c
+tools_btiotest_LDADD = btio/libbtio-internal.la lib/libbluetooth-internal.la \
+			@GLIB_LIBS@
 
 tools_mpris_player_SOURCES = tools/mpris-player.c
 tools_mpris_player_LDADD = gdbus/libgdbus-internal.la @GLIB_LIBS@ @DBUS_LIBS@
@@ -221,19 +222,22 @@ noinst_PROGRAMS += attrib/gatttool \
 			tools/bluetooth-player tools/obexctl
 
 attrib_gatttool_SOURCES = attrib/gatttool.c attrib/att.c attrib/gatt.c \
-				attrib/gattrib.c btio/btio.c \
-				attrib/gatttool.h attrib/interactive.c \
-				attrib/utils.c src/log.c client/display.c \
+				attrib/gattrib.c  attrib/gatttool.h \
+				attrib/interactive.c attrib/utils.c \
+				src/log.c client/display.c \
 				client/display.h
-attrib_gatttool_LDADD = lib/libbluetooth-internal.la @GLIB_LIBS@ -lreadline
+attrib_gatttool_LDADD = lib/libbluetooth-internal.la btio/libbtio-internal.la \
+			@GLIB_LIBS@ -lreadline
 
-tools_obex_client_tool_SOURCES = $(btio_sources) tools/obex-client-tool.c
-tools_obex_client_tool_LDADD = lib/libbluetooth-internal.la \
+tools_obex_client_tool_SOURCES = tools/obex-client-tool.c
+tools_obex_client_tool_LDADD = btio/libbtio-internal.la \
+				lib/libbluetooth-internal.la \
 				gobex/libgobex-internal.la \
 				@GLIB_LIBS@ -lreadline
 
-tools_obex_server_tool_SOURCES = $(btio_sources) tools/obex-server-tool.c
-tools_obex_server_tool_LDADD = lib/libbluetooth-internal.la \
+tools_obex_server_tool_SOURCES = tools/obex-server-tool.c
+tools_obex_server_tool_LDADD = btio/libbtio-internal.la \
+				lib/libbluetooth-internal.la \
 				gobex/libgobex-internal.la \
 				@GLIB_LIBS@
 
-- 
1.8.3.1

