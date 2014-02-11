Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 7/7] android: Add test-ipc to "make check"
Date: Tue, 11 Feb 2014 14:32:32 -0400
Message-Id: <1392143552-11395-7-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1392143552-11395-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1392143552-11395-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 Makefile.am         |    3 ++-
 android/Makefile.am |    2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 1a44a9f..11f2aa1 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -178,6 +178,7 @@ EXTRA_DIST += src/genbuiltin src/bluetooth.conf \
 			profiles/input/input.conf profiles/proximity/proximity.conf
 
 test_scripts =
+unit_tests =
 
 include Makefile.tools
 include Makefile.obexd
@@ -222,7 +223,7 @@ AM_CFLAGS += @DBUS_CFLAGS@ @GLIB_CFLAGS@
 AM_CPPFLAGS = -I$(builddir)/lib -I$(srcdir)/gdbus
 
 
-unit_tests = unit/test-eir unit/test-uuid unit/test-textfile unit/test-crc
+unit_tests += unit/test-eir unit/test-uuid unit/test-textfile unit/test-crc
 
 unit_test_eir_SOURCES = unit/test-eir.c src/eir.c src/uuid-helper.c
 unit_test_eir_LDADD = lib/libbluetooth-internal.la @GLIB_LIBS@
diff --git a/android/Makefile.am b/android/Makefile.am
index 5baa8db..1913b42 100644
--- a/android/Makefile.am
+++ b/android/Makefile.am
@@ -153,7 +153,7 @@ android_audio_a2dp_default_la_SOURCES = android/audio-msg.h \
 					android/hardware/hardware.h \
 					android/system/audio.h
 
-noinst_PROGRAMS += android/test-ipc
+unit_tests += android/test-ipc
 
 android_test_ipc_SOURCES = android/test-ipc.c \
 				src/shared/util.h src/shared/util.c \
-- 
1.7.9.5

