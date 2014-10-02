Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH 2/2] mcaptest: Move it from android to tools
Date: Thu,  2 Oct 2014 15:25:17 +0300
Message-Id: <1412252717-11671-2-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1412252717-11671-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1412252717-11671-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 .gitignore                    | 2 +-
 Makefile.tools                | 8 +++++++-
 android/Android.mk            | 2 +-
 android/Makefile.am           | 9 ---------
 {android => tools}/mcaptest.c | 0
 5 files changed, 9 insertions(+), 12 deletions(-)
 rename {android => tools}/mcaptest.c (100%)

diff --git a/.gitignore b/.gitignore
index e22274f..65d77a5 100644
--- a/.gitignore
+++ b/.gitignore
@@ -75,6 +75,7 @@ tools/3dsp
 tools/obexctl
 tools/gatt-service
 tools/btgatt-client
+tools/mcaptest
 test/sap_client.pyc
 test/bluezutils.pyc
 unit/test-ringbuf
@@ -127,7 +128,6 @@ doc/btmon.1
 android/system-emulator
 android/bluetoothd
 android/avdtptest
-android/mcaptest
 android/haltest
 android/android-tester
 android/ipc-tester
diff --git a/Makefile.tools b/Makefile.tools
index d901284..42cccc6 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -119,7 +119,7 @@ if TOOLS
 bin_PROGRAMS += tools/hciattach tools/hciconfig tools/hcitool tools/hcidump \
 			tools/rfcomm tools/rctest tools/l2test tools/l2ping \
 			tools/sdptool tools/ciptool tools/bccmd \
-			tools/bluemoon tools/mpris-proxy
+			tools/bluemoon tools/mpris-proxy tools/mcaptest
 
 tools_hciattach_SOURCES = tools/hciattach.c tools/hciattach.h \
 						tools/hciattach_st.c \
@@ -189,6 +189,12 @@ tools_bluemoon_LDADD = src/libshared-mainloop.la
 tools_mpris_proxy_SOURCES = tools/mpris-proxy.c
 tools_mpris_proxy_LDADD = gdbus/libgdbus-internal.la @GLIB_LIBS@ @DBUS_LIBS@
 
+tools_mcaptest_SOURCES = tools/mcaptest.c \
+				btio/btio.h btio/btio.c \
+				src/log.c src/log.h \
+				profiles/health/mcap.h profiles/health/mcap.c
+tools_mcaptest_LDADD = lib/libbluetooth-internal.la @GLIB_LIBS@
+
 dist_man_MANS += tools/hciattach.1 tools/hciconfig.1 \
 			tools/hcitool.1 tools/hcidump.1 \
 			tools/rfcomm.1 tools/rctest.1 tools/l2ping.1 \
diff --git a/android/Android.mk b/android/Android.mk
index eb67690..3daa260 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -212,7 +212,7 @@ LOCAL_SRC_FILES := \
 	bluez/lib/bluetooth.c \
 	bluez/lib/hci.c \
 	bluez/profiles/health/mcap.c \
-	bluez/android/mcaptest.c \
+	bluez/tools/mcaptest.c \
 
 LOCAL_C_INCLUDES := \
 	$(call include-path-for, glib) \
diff --git a/android/Makefile.am b/android/Makefile.am
index 75802dd..7ae2c76 100644
--- a/android/Makefile.am
+++ b/android/Makefile.am
@@ -90,15 +90,6 @@ android_bluetooth_default_la_CFLAGS = $(AM_CFLAGS) -I$(srcdir)/android
 android_bluetooth_default_la_LDFLAGS = $(AM_LDFLAGS) -module -avoid-version \
 					-no-undefined
 
-noinst_PROGRAMS += android/mcaptest
-
-android_mcaptest_SOURCES = android/mcaptest.c \
-				src/log.h src/log.c \
-				btio/btio.h btio/btio.c \
-				profiles/health/mcap.h profiles/health/mcap.c
-android_mcaptest_CFLAGS = $(AM_CFLAGS)
-android_mcaptest_LDADD = lib/libbluetooth-internal.la @GLIB_LIBS@
-
 noinst_PROGRAMS += android/avdtptest
 
 android_avdtptest_SOURCES = android/avdtptest.c \
diff --git a/android/mcaptest.c b/tools/mcaptest.c
similarity index 100%
rename from android/mcaptest.c
rename to tools/mcaptest.c
-- 
1.9.1

