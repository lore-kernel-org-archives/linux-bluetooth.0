Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 4/4] build: Move unit tests build rules to Makefile.unit
Date: Tue, 18 Feb 2014 16:40:35 +0200
Message-Id: <1392734435-2182-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1392734435-2182-1-git-send-email-luiz.dentz@gmail.com>
References: <1392734435-2182-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 Makefile.am   | 99 +----------------------------------------------------------
 Makefile.unit | 98 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 99 insertions(+), 98 deletions(-)
 create mode 100644 Makefile.unit

diff --git a/Makefile.am b/Makefile.am
index 0697c14..9bffa0f 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -179,10 +179,10 @@ EXTRA_DIST += src/genbuiltin src/bluetooth.conf \
 			profiles/input/input.conf profiles/proximity/proximity.conf
 
 test_scripts =
-unit_tests =
 
 include Makefile.tools
 include Makefile.obexd
+include Makefile.unit
 include android/Makefile.am
 
 if HID2HCI
@@ -224,103 +224,6 @@ AM_CFLAGS += @DBUS_CFLAGS@ @GLIB_CFLAGS@
 AM_CPPFLAGS = -I$(builddir)/lib -I$(srcdir)/gdbus
 
 
-unit_tests += unit/test-eir unit/test-uuid unit/test-textfile unit/test-crc
-
-unit_test_eir_SOURCES = unit/test-eir.c src/eir.c src/uuid-helper.c
-unit_test_eir_LDADD = lib/libbluetooth-internal.la @GLIB_LIBS@
-
-unit_test_uuid_SOURCES = unit/test-uuid.c
-unit_test_uuid_LDADD = lib/libbluetooth-internal.la @GLIB_LIBS@
-
-unit_test_textfile_SOURCES = unit/test-textfile.c src/textfile.h src/textfile.c
-unit_test_textfile_LDADD = @GLIB_LIBS@
-
-unit_test_crc_SOURCES = unit/test-crc.c monitor/crc.h monitor/crc.c
-unit_test_crc_LDADD = @GLIB_LIBS@
-
-unit_tests += unit/test-ringbuf unit/test-queue
-
-unit_test_ringbuf_SOURCES = unit/test-ringbuf.c \
-				src/shared/util.h src/shared/util.c \
-				src/shared/ringbuf.h src/shared/ringbuf.c
-unit_test_ringbuf_LDADD = @GLIB_LIBS@
-
-unit_test_queue_SOURCES = unit/test-queue.c \
-				src/shared/util.h src/shared/util.c \
-				src/shared/queue.h src/shared/queue.c
-unit_test_queue_LDADD = @GLIB_LIBS@
-
-unit_tests += unit/test-mgmt
-
-unit_test_mgmt_SOURCES = unit/test-mgmt.c \
-				src/shared/io.h src/shared/io-glib.c \
-				src/shared/queue.h src/shared/queue.c \
-				src/shared/util.h src/shared/util.c \
-				src/shared/mgmt.h src/shared/mgmt.c
-unit_test_mgmt_LDADD = @GLIB_LIBS@
-
-unit_tests += unit/test-sdp
-
-unit_test_sdp_SOURCES = unit/test-sdp.c \
-				src/shared/util.h src/shared/util.c \
-				src/sdpd.h src/sdpd-database.c \
-				src/sdpd-service.c src/sdpd-request.c
-unit_test_sdp_LDADD = lib/libbluetooth-internal.la @GLIB_LIBS@
-
-unit_tests += unit/test-avdtp
-
-unit_test_avdtp_SOURCES = unit/test-avdtp.c \
-				src/shared/util.h src/shared/util.c \
-				src/log.h src/log.c \
-				src/shared/avdtp.c src/shared/avdtp.h
-unit_test_avdtp_LDADD = @GLIB_LIBS@
-
-unit_tests += unit/test-avctp
-
-unit_test_avctp_SOURCES = unit/test-avctp.c \
-				src/shared/util.h src/shared/util.c \
-				src/log.h src/log.c \
-				src/shared/avctp.c src/shared/avctp.h
-unit_test_avctp_LDADD = @GLIB_LIBS@
-
-unit_tests += unit/test-gdbus-client
-
-unit_test_gdbus_client_SOURCES = unit/test-gdbus-client.c
-unit_test_gdbus_client_LDADD = gdbus/libgdbus-internal.la \
-				@GLIB_LIBS@ @DBUS_LIBS@
-
-unit_tests += unit/test-gobex-header unit/test-gobex-packet unit/test-gobex \
-			unit/test-gobex-transfer unit/test-gobex-apparam
-
-unit_test_gobex_SOURCES = $(gobex_sources) unit/util.c unit/util.h \
-						unit/test-gobex.c
-unit_test_gobex_LDADD = @GLIB_LIBS@
-
-unit_test_gobex_packet_SOURCES = $(gobex_sources) unit/util.c unit/util.h \
-						unit/test-gobex-packet.c
-unit_test_gobex_packet_LDADD = @GLIB_LIBS@
-
-unit_test_gobex_header_SOURCES = $(gobex_sources) unit/util.c unit/util.h \
-						unit/test-gobex-header.c
-unit_test_gobex_header_LDADD = @GLIB_LIBS@
-
-unit_test_gobex_transfer_SOURCES = $(gobex_sources) unit/util.c unit/util.h \
-						unit/test-gobex-transfer.c
-unit_test_gobex_transfer_LDADD = @GLIB_LIBS@
-
-unit_test_gobex_apparam_SOURCES = $(gobex_sources) unit/util.c unit/util.h \
-						unit/test-gobex-apparam.c
-unit_test_gobex_apparam_LDADD = @GLIB_LIBS@
-
-unit_tests += unit/test-lib
-
-unit_test_lib_SOURCES = unit/test-lib.c
-unit_test_lib_LDADD = lib/libbluetooth-internal.la @GLIB_LIBS@
-
-noinst_PROGRAMS += $(unit_tests)
-
-TESTS = $(unit_tests)
-
 pkgconfigdir = $(libdir)/pkgconfig
 
 if LIBRARY
diff --git a/Makefile.unit b/Makefile.unit
new file mode 100644
index 0000000..1d1893e
--- /dev/null
+++ b/Makefile.unit
@@ -0,0 +1,98 @@
+unit_tests =
+
+unit_tests += unit/test-eir unit/test-uuid unit/test-textfile unit/test-crc
+
+unit_test_eir_SOURCES = unit/test-eir.c src/eir.c src/uuid-helper.c
+unit_test_eir_LDADD = lib/libbluetooth-internal.la @GLIB_LIBS@
+
+unit_test_uuid_SOURCES = unit/test-uuid.c
+unit_test_uuid_LDADD = lib/libbluetooth-internal.la @GLIB_LIBS@
+
+unit_test_textfile_SOURCES = unit/test-textfile.c src/textfile.h src/textfile.c
+unit_test_textfile_LDADD = @GLIB_LIBS@
+
+unit_test_crc_SOURCES = unit/test-crc.c monitor/crc.h monitor/crc.c
+unit_test_crc_LDADD = @GLIB_LIBS@
+
+unit_tests += unit/test-ringbuf unit/test-queue
+
+unit_test_ringbuf_SOURCES = unit/test-ringbuf.c \
+				src/shared/util.h src/shared/util.c \
+				src/shared/ringbuf.h src/shared/ringbuf.c
+unit_test_ringbuf_LDADD = @GLIB_LIBS@
+
+unit_test_queue_SOURCES = unit/test-queue.c \
+				src/shared/util.h src/shared/util.c \
+				src/shared/queue.h src/shared/queue.c
+unit_test_queue_LDADD = @GLIB_LIBS@
+
+unit_tests += unit/test-mgmt
+
+unit_test_mgmt_SOURCES = unit/test-mgmt.c \
+				src/shared/io.h src/shared/io-glib.c \
+				src/shared/queue.h src/shared/queue.c \
+				src/shared/util.h src/shared/util.c \
+				src/shared/mgmt.h src/shared/mgmt.c
+unit_test_mgmt_LDADD = @GLIB_LIBS@
+
+unit_tests += unit/test-sdp
+
+unit_test_sdp_SOURCES = unit/test-sdp.c \
+				src/shared/util.h src/shared/util.c \
+				src/sdpd.h src/sdpd-database.c \
+				src/sdpd-service.c src/sdpd-request.c
+unit_test_sdp_LDADD = lib/libbluetooth-internal.la @GLIB_LIBS@
+
+unit_tests += unit/test-avdtp
+
+unit_test_avdtp_SOURCES = unit/test-avdtp.c \
+				src/shared/util.h src/shared/util.c \
+				src/log.h src/log.c \
+				src/shared/avdtp.c src/shared/avdtp.h
+unit_test_avdtp_LDADD = @GLIB_LIBS@
+
+unit_tests += unit/test-avctp
+
+unit_test_avctp_SOURCES = unit/test-avctp.c \
+				src/shared/util.h src/shared/util.c \
+				src/log.h src/log.c \
+				src/shared/avctp.c src/shared/avctp.h
+unit_test_avctp_LDADD = @GLIB_LIBS@
+
+unit_tests += unit/test-gdbus-client
+
+unit_test_gdbus_client_SOURCES = unit/test-gdbus-client.c
+unit_test_gdbus_client_LDADD = gdbus/libgdbus-internal.la \
+				@GLIB_LIBS@ @DBUS_LIBS@
+
+unit_tests += unit/test-gobex-header unit/test-gobex-packet unit/test-gobex \
+			unit/test-gobex-transfer unit/test-gobex-apparam
+
+unit_test_gobex_SOURCES = $(gobex_sources) unit/util.c unit/util.h \
+						unit/test-gobex.c
+unit_test_gobex_LDADD = @GLIB_LIBS@
+
+unit_test_gobex_packet_SOURCES = $(gobex_sources) unit/util.c unit/util.h \
+						unit/test-gobex-packet.c
+unit_test_gobex_packet_LDADD = @GLIB_LIBS@
+
+unit_test_gobex_header_SOURCES = $(gobex_sources) unit/util.c unit/util.h \
+						unit/test-gobex-header.c
+unit_test_gobex_header_LDADD = @GLIB_LIBS@
+
+unit_test_gobex_transfer_SOURCES = $(gobex_sources) unit/util.c unit/util.h \
+						unit/test-gobex-transfer.c
+unit_test_gobex_transfer_LDADD = @GLIB_LIBS@
+
+unit_test_gobex_apparam_SOURCES = $(gobex_sources) unit/util.c unit/util.h \
+						unit/test-gobex-apparam.c
+unit_test_gobex_apparam_LDADD = @GLIB_LIBS@
+
+unit_tests += unit/test-lib
+
+unit_test_lib_SOURCES = unit/test-lib.c
+unit_test_lib_LDADD = lib/libbluetooth-internal.la @GLIB_LIBS@
+
+noinst_PROGRAMS += $(unit_tests)
+
+TESTS = $(unit_tests)
-- 
1.8.5.3

