Return-Path: <cyrus@holtmann.org>
From: Frederic Danis <frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 1/7] build: Add skeleton for BlueZ Android
Date: Tue,  1 Oct 2013 14:58:33 +0200
Message-Id: <1380632319-7701-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Retrieve Bluetooth version from configure.ac.
---
 Makefile.am         |    4 +++-
 Makefile.android    |    1 +
 android/Android.mk  |    4 ++++
 bootstrap-configure |    1 +
 configure.ac        |    5 +++++
 5 files changed, 14 insertions(+), 1 deletion(-)
 create mode 100644 Makefile.android
 create mode 100644 android/Android.mk

diff --git a/Makefile.am b/Makefile.am
index 4e4b1c5..51204f4 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -179,6 +179,7 @@ test_scripts =
 
 include Makefile.tools
 include Makefile.obexd
+include Makefile.android
 
 if HID2HCI
 rulesdir = @UDEV_DIR@/rules.d
@@ -293,7 +294,8 @@ pkgconfig_DATA = lib/bluez.pc
 endif
 
 DISTCHECK_CONFIGURE_FLAGS = --disable-datafiles --enable-library \
-					--disable-systemd --disable-udev
+					--disable-systemd --disable-udev \
+					--enable-android
 
 DISTCLEANFILES = $(pkgconfig_DATA)
 
diff --git a/Makefile.android b/Makefile.android
new file mode 100644
index 0000000..56fa9a7
--- /dev/null
+++ b/Makefile.android
@@ -0,0 +1 @@
+EXTRA_DIST += android/Android.mk
diff --git a/android/Android.mk b/android/Android.mk
new file mode 100644
index 0000000..183f7e2
--- /dev/null
+++ b/android/Android.mk
@@ -0,0 +1,4 @@
+LOCAL_PATH := $(call my-dir)
+
+# Retrieve BlueZ version from configure.ac file
+BLUEZ_VERSION := $(shell grep ^AC_INIT $(LOCAL_PATH)/../configure.ac | cpp -P -D'AC_INIT(_,v)=v')
diff --git a/bootstrap-configure b/bootstrap-configure
index 7a6e7d1..dc36311 100755
--- a/bootstrap-configure
+++ b/bootstrap-configure
@@ -12,4 +12,5 @@ fi
 		--sysconfdir=/etc \
 		--localstatedir=/var \
 		--enable-experimental \
+		--enable-android \
 		--disable-datafiles $*
diff --git a/configure.ac b/configure.ac
index 41c2935..7b1f64a 100644
--- a/configure.ac
+++ b/configure.ac
@@ -242,4 +242,9 @@ AC_DEFINE_UNQUOTED(CONFIGDIR, "${configdir}",
 			[Directory for the configuration files])
 AC_SUBST(CONFIGDIR, "${configdir}")
 
+AC_ARG_ENABLE(android, AC_HELP_STRING([--enable-android],
+			[enable BlueZ for Android]),
+					[enable_android=${enableval}])
+AM_CONDITIONAL(ANDROID, test "${enable_android}" = "yes")
+
 AC_OUTPUT(Makefile src/bluetoothd.8 lib/bluez.pc)
-- 
1.7.9.5

