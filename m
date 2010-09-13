Return-Path: <cyrus@holtmann.org>
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH V2 2/2] btio: Seperate btio.[ch] into btio directory
Date: Mon, 13 Sep 2010 16:17:31 +0800
Message-Id: <1284365851-8066-3-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1284365851-8066-1-git-send-email-zhenhua.zhang@intel.com>
References: <1284365851-8066-1-git-send-email-zhenhua.zhang@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Seperate btio.[ch] from src directory to btio sub-folder.
---
 Makefile.am          |    8 +++++---
 Makefile.tools       |    2 +-
 {src => btio}/btio.c |    0
 {src => btio}/btio.h |    0
 4 files changed, 6 insertions(+), 4 deletions(-)
 rename {src => btio}/btio.c (100%)
 rename {src => btio}/btio.h (100%)

diff --git a/Makefile.am b/Makefile.am
index 7895be2..a8829d9 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -102,6 +102,8 @@ endif
 gdbus_sources = gdbus/gdbus.h gdbus/mainloop.c gdbus/watch.c \
 					gdbus/object.c gdbus/polkit.c
 
+btio_sources = btio/btio.h btio/btio.c
+
 builtin_modules =
 builtin_sources =
 builtin_nodist =
@@ -216,14 +218,14 @@ endif
 sbin_PROGRAMS += src/bluetoothd
 
 src_bluetoothd_SOURCES = $(gdbus_sources) $(builtin_sources) \
-			$(attrib_sources) \
+			$(attrib_sources) $(btio_sources) \
 			$(mcap_sources) \
 			src/main.c src/log.h src/log.c \
 			src/security.c src/rfkill.c src/hcid.h src/sdpd.h \
 			src/sdpd-server.c src/sdpd-request.c \
 			src/sdpd-service.c src/sdpd-database.c \
 			src/attrib-server.h src/attrib-server.c \
-			src/sdp-xml.h src/sdp-xml.c src/btio.h src/btio.c \
+			src/sdp-xml.h src/sdp-xml.c \
 			src/textfile.h src/textfile.c \
 			src/glib-helper.h src/glib-helper.c \
 			src/oui.h src/oui.c src/uinput.h src/ppoll.h \
@@ -357,7 +359,7 @@ AM_CFLAGS = @DBUS_CFLAGS@ @GLIB_CFLAGS@ @CAPNG_CFLAGS@ \
 
 INCLUDES = -I$(builddir)/lib -I$(builddir)/src -I$(srcdir)/src \
 			-I$(srcdir)/audio -I$(srcdir)/sbc -I$(srcdir)/gdbus \
-			-I$(srcdir)/attrib
+			-I$(srcdir)/attrib -I$(srcdir)/btio
 
 if MCAP
 	INCLUDES += -I$(builddir)/health
diff --git a/Makefile.tools b/Makefile.tools
index 1c46542..14ecf31 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -170,7 +170,7 @@ test_bdaddr_LDADD = lib/libbluetooth.la
 
 test_agent_LDADD = @DBUS_LIBS@
 
-test_btiotest_SOURCES = test/btiotest.c src/btio.h src/btio.c
+test_btiotest_SOURCES = test/btiotest.c btio/btio.h btio/btio.c
 test_btiotest_LDADD = @GLIB_LIBS@ lib/libbluetooth.la
 
 test_test_textfile_SOURCES = test/test-textfile.c src/textfile.h src/textfile.c
diff --git a/src/btio.c b/btio/btio.c
similarity index 100%
rename from src/btio.c
rename to btio/btio.c
diff --git a/src/btio.h b/btio/btio.h
similarity index 100%
rename from src/btio.h
rename to btio/btio.h
-- 
1.7.0.4

