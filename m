Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH] build: Move Makefile.android to android/Makefile.am
Date: Mon, 28 Oct 2013 17:37:06 +0100
Message-ID: <1382978226-28073-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This will keep all Android related changes within android directory.
---

Will also fix messing with Marcel's tab completion habits :-)

 Makefile.am         |   2 +-
 Makefile.android    | 113 ----------------------------------------------------
 android/Makefile.am | 113 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 114 insertions(+), 114 deletions(-)
 delete mode 100644 Makefile.android
 create mode 100644 android/Makefile.am

diff --git a/Makefile.am b/Makefile.am
index 8aed6f7..69a2805 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -179,7 +179,7 @@ test_scripts =
 
 include Makefile.tools
 include Makefile.obexd
-include Makefile.android
+include android/Makefile.am
 
 if HID2HCI
 rulesdir = @UDEV_DIR@/rules.d
diff --git a/Makefile.android b/Makefile.android
deleted file mode 100644
index 2b57daa..0000000
--- a/Makefile.android
+++ /dev/null
@@ -1,113 +0,0 @@
-if ANDROID
-noinst_PROGRAMS += android/bluetoothd
-
-android_bluetoothd_SOURCES =	android/main.c \
-				src/log.c \
-				android/hal-msg.h \
-				android/utils.h \
-				src/sdpd-database.c src/sdpd-server.c \
-				src/sdpd-service.c src/sdpd-request.c \
-				src/shared/util.h src/shared/util.c \
-				src/shared/mgmt.h src/shared/mgmt.c \
-				android/adapter.h android/adapter.c \
-				android/hid.h android/hid.c \
-				android/ipc.h android/ipc.c \
-				android/socket.h android/socket.c
-
-android_bluetoothd_LDADD = lib/libbluetooth-internal.la @GLIB_LIBS@
-
-noinst_LTLIBRARIES += android/libhal-internal.la
-
-android_libhal_internal_la_SOURCES = android/hal.h android/hal-bluetooth.c \
-					android/hal-sock.c \
-					android/hal-hidhost.c \
-					android/hal-pan.c \
-					android/hal-av.c \
-					android/hardware/bluetooth.h \
-					android/hardware/bt_av.h \
-					android/hardware/bt_gatt.h \
-					android/hardware/bt_gatt_client.h \
-					android/hardware/bt_gatt_server.h \
-					android/hardware/bt_gatt_types.h \
-					android/hardware/bt_hf.h \
-					android/hardware/bt_hh.h \
-					android/hardware/bt_hl.h \
-					android/hardware/bt_pan.h \
-					android/hardware/bt_rc.h \
-					android/hardware/bt_sock.h \
-					android/hardware/hardware.h \
-					android/cutils/properties.h \
-					android/hal-log.h \
-					android/hal-ipc.h android/hal-ipc.c
-
-android_libhal_internal_la_CPPFLAGS = -I$(srcdir)/android
-
-noinst_PROGRAMS += android/haltest
-
-android_haltest_SOURCES = android/client/haltest.c \
-				android/client/pollhandler.c \
-				android/client/terminal.c \
-				android/client/history.c \
-				android/client/textconv.c \
-				android/client/tabcompletion.c \
-				android/client/if-av.c \
-				android/client/if-bt.c \
-				android/client/if-hf.c \
-				android/client/if-hh.c \
-				android/client/if-pan.c \
-				android/client/if-sock.c \
-				android/client/hwmodule.c
-
-android_haltest_LDADD = android/libhal-internal.la
-
-android_haltest_CFLAGS = $(AM_CFLAGS) -I$(srcdir)/android
-
-android_haltest_LDFLAGS = -pthread
-
-endif
-
-EXTRA_DIST += android/Android.mk android/device.c android/adapter.c\
-		android/main.c android/hal-msg.h android/hal.h
-
-EXTRA_DIST += android/hal-bluetooth.c \
-		android/hal-sock.c \
-		android/hal-hidhost.c \
-		android/hal-pan.c \
-		android/hal-av.c \
-		android/hal-log.h
-
-EXTRA_DIST += android/client/terminal.c \
-		android/client/haltest.c \
-		android/client/hwmodule.c \
-		android/client/pollhandler.c \
-		android/client/history.c \
-		android/client/if-av.c \
-		android/client/if-bt.c \
-		android/client/if-hf.c \
-		android/client/if-hh.c \
-		android/client/if-pan.c \
-		android/client/if-sock.c \
-		android/client/textconv.c \
-		android/client/tabcompletion.c \
-		android/client/textconv.h \
-		android/client/if-main.h \
-		android/client/pollhandler.h \
-		android/client/history.h \
-		android/client/terminal.h
-
-EXTRA_DIST += android/hal-ipc-api.txt
-
-EXTRA_DIST += android/hardware/bluetooth.h \
-		android/hardware/bt_av.h \
-		android/hardware/bt_gatt.h \
-		android/hardware/bt_gatt_client.h \
-		android/hardware/bt_gatt_server.h \
-		android/hardware/bt_gatt_types.h \
-		android/hardware/bt_hf.h \
-		android/hardware/bt_hh.h \
-		android/hardware/bt_hl.h \
-		android/hardware/bt_pan.h \
-		android/hardware/bt_rc.h \
-		android/hardware/bt_sock.h \
-		android/hardware/hardware.h \
-		android/cutils/properties.h
diff --git a/android/Makefile.am b/android/Makefile.am
new file mode 100644
index 0000000..2b57daa
--- /dev/null
+++ b/android/Makefile.am
@@ -0,0 +1,113 @@
+if ANDROID
+noinst_PROGRAMS += android/bluetoothd
+
+android_bluetoothd_SOURCES =	android/main.c \
+				src/log.c \
+				android/hal-msg.h \
+				android/utils.h \
+				src/sdpd-database.c src/sdpd-server.c \
+				src/sdpd-service.c src/sdpd-request.c \
+				src/shared/util.h src/shared/util.c \
+				src/shared/mgmt.h src/shared/mgmt.c \
+				android/adapter.h android/adapter.c \
+				android/hid.h android/hid.c \
+				android/ipc.h android/ipc.c \
+				android/socket.h android/socket.c
+
+android_bluetoothd_LDADD = lib/libbluetooth-internal.la @GLIB_LIBS@
+
+noinst_LTLIBRARIES += android/libhal-internal.la
+
+android_libhal_internal_la_SOURCES = android/hal.h android/hal-bluetooth.c \
+					android/hal-sock.c \
+					android/hal-hidhost.c \
+					android/hal-pan.c \
+					android/hal-av.c \
+					android/hardware/bluetooth.h \
+					android/hardware/bt_av.h \
+					android/hardware/bt_gatt.h \
+					android/hardware/bt_gatt_client.h \
+					android/hardware/bt_gatt_server.h \
+					android/hardware/bt_gatt_types.h \
+					android/hardware/bt_hf.h \
+					android/hardware/bt_hh.h \
+					android/hardware/bt_hl.h \
+					android/hardware/bt_pan.h \
+					android/hardware/bt_rc.h \
+					android/hardware/bt_sock.h \
+					android/hardware/hardware.h \
+					android/cutils/properties.h \
+					android/hal-log.h \
+					android/hal-ipc.h android/hal-ipc.c
+
+android_libhal_internal_la_CPPFLAGS = -I$(srcdir)/android
+
+noinst_PROGRAMS += android/haltest
+
+android_haltest_SOURCES = android/client/haltest.c \
+				android/client/pollhandler.c \
+				android/client/terminal.c \
+				android/client/history.c \
+				android/client/textconv.c \
+				android/client/tabcompletion.c \
+				android/client/if-av.c \
+				android/client/if-bt.c \
+				android/client/if-hf.c \
+				android/client/if-hh.c \
+				android/client/if-pan.c \
+				android/client/if-sock.c \
+				android/client/hwmodule.c
+
+android_haltest_LDADD = android/libhal-internal.la
+
+android_haltest_CFLAGS = $(AM_CFLAGS) -I$(srcdir)/android
+
+android_haltest_LDFLAGS = -pthread
+
+endif
+
+EXTRA_DIST += android/Android.mk android/device.c android/adapter.c\
+		android/main.c android/hal-msg.h android/hal.h
+
+EXTRA_DIST += android/hal-bluetooth.c \
+		android/hal-sock.c \
+		android/hal-hidhost.c \
+		android/hal-pan.c \
+		android/hal-av.c \
+		android/hal-log.h
+
+EXTRA_DIST += android/client/terminal.c \
+		android/client/haltest.c \
+		android/client/hwmodule.c \
+		android/client/pollhandler.c \
+		android/client/history.c \
+		android/client/if-av.c \
+		android/client/if-bt.c \
+		android/client/if-hf.c \
+		android/client/if-hh.c \
+		android/client/if-pan.c \
+		android/client/if-sock.c \
+		android/client/textconv.c \
+		android/client/tabcompletion.c \
+		android/client/textconv.h \
+		android/client/if-main.h \
+		android/client/pollhandler.h \
+		android/client/history.h \
+		android/client/terminal.h
+
+EXTRA_DIST += android/hal-ipc-api.txt
+
+EXTRA_DIST += android/hardware/bluetooth.h \
+		android/hardware/bt_av.h \
+		android/hardware/bt_gatt.h \
+		android/hardware/bt_gatt_client.h \
+		android/hardware/bt_gatt_server.h \
+		android/hardware/bt_gatt_types.h \
+		android/hardware/bt_hf.h \
+		android/hardware/bt_hh.h \
+		android/hardware/bt_hl.h \
+		android/hardware/bt_pan.h \
+		android/hardware/bt_rc.h \
+		android/hardware/bt_sock.h \
+		android/hardware/hardware.h \
+		android/cutils/properties.h
-- 
1.8.4.1

