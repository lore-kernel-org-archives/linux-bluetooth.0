Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Fix linkage failure for bluetoothd
Date: Fri, 15 Oct 2010 16:46:11 -0300
Message-Id: <1287171971-32246-1-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Adding -lrt fix the following errors in one of my systems:

health/mcap_sync.o: In function `initialize_caps':
/root/bluez/health/mcap_sync.c:341: undefined reference to `clock_getres'
/root/bluez/health/mcap_sync.c:350: undefined reference to `clock_gettime'
/root/bluez/health/mcap_sync.c:358: undefined reference to `clock_gettime'
/root/bluez/health/mcap_sync.c:363: undefined reference to `clock_gettime'
health/mcap_sync.o: In function `reset_tmstamp':
/root/bluez/health/mcap_sync.c:163: undefined reference to `clock_gettime'
health/mcap_sync.o: In function `mcap_get_timestamp':
/root/bluez/health/mcap_sync.c:309: undefined reference to `clock_gettime'
health/mcap_sync.o:/root/bluez/health/mcap_sync.c:514: more undefined references to `clock_gettime' follow
collect2: ld returned 1 exit status
make[1]: *** [src/bluetoothd] Error 1
make: *** [all] Error 2
---
 Makefile.am |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 8f9f5d3..6e8fc7d 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -240,7 +240,7 @@ src_bluetoothd_SOURCES = $(gdbus_sources) $(builtin_sources) \
 			src/dbus-common.c src/dbus-common.h \
 			src/dbus-hci.h src/dbus-hci.c
 src_bluetoothd_LDADD = lib/libbluetooth.la @GLIB_LIBS@ @DBUS_LIBS@ \
-							@CAPNG_LIBS@ -ldl
+							@CAPNG_LIBS@ -ldl -lrt
 src_bluetoothd_LDFLAGS = -Wl,--export-dynamic \
 				-Wl,--version-script=$(srcdir)/src/bluetooth.ver
 
-- 
1.7.3.1

