Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 2/9] android: Build Audio HAL with SBC
Date: Fri, 17 Jan 2014 16:40:06 +0100
Message-ID: <1389973213-30251-3-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1389973213-30251-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1389973213-30251-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Build for Android requires libsbc sources to be available in
external/bluetooth/sbc. Build for host requires libsbc package to be
installed.
---
 android/Android.mk  | 14 +++++++++++---
 android/Makefile.am |  2 ++
 configure.ac        |  7 +++++++
 3 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/android/Android.mk b/android/Android.mk
index 7e97ec8..63a4a24 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -3,8 +3,9 @@ LOCAL_PATH := $(call my-dir)
 # Retrieve BlueZ version from configure.ac file
 BLUEZ_VERSION := $(shell grep ^AC_INIT $(LOCAL_PATH)/../configure.ac | cpp -P -D'AC_INIT(_,v)=v')
 
-# Specify pathmap for glib
-pathmap_INCL += glib:external/bluetooth/glib
+# Specify pathmap for glib and sbc
+pathmap_INCL += glib:external/bluetooth/glib \
+	sbc:external/bluetooth/sbc
 
 # Specify common compiler flags
 BLUEZ_COMMON_CFLAGS := -DVERSION=\"$(BLUEZ_VERSION)\" \
@@ -220,11 +221,18 @@ include $(BUILD_EXECUTABLE)
 
 include $(CLEAR_VARS)
 
-LOCAL_SRC_FILES := hal-audio.c
+LOCAL_SRC_FILES := hal-audio.c \
+	../../sbc/sbc/sbc.c \
+	../../sbc/sbc/sbc_primitives.c \
+	../../sbc/sbc/sbc_primitives_armv6.c \
+	../../sbc/sbc/sbc_primitives_iwmmxt.c \
+	../../sbc/sbc/sbc_primitives_mmx.c \
+	../../sbc/sbc/sbc_primitives_neon.c \
 
 LOCAL_C_INCLUDES = \
 	$(call include-path-for, system-core) \
 	$(call include-path-for, libhardware) \
+	$(call include-path-for, sbc) \
 
 LOCAL_SHARED_LIBRARIES := \
 	libcutils \
diff --git a/android/Makefile.am b/android/Makefile.am
index 8d2714d..01d8996 100644
--- a/android/Makefile.am
+++ b/android/Makefile.am
@@ -130,6 +130,8 @@ android_audio_a2dp_default_la_SOURCES = android/audio-msg.h \
 
 android_audio_a2dp_default_la_CFLAGS = $(AM_CFLAGS) -I$(srcdir)/android
 
+android_audio_a2dp_default_la_LIBADD = @SBC_LIBS@
+
 android_audio_a2dp_default_la_LDFLAGS = $(AM_LDFLAGS) -module -avoid-version \
 					-no-undefined -pthread
 
diff --git a/configure.ac b/configure.ac
index c85f208..79c3705 100644
--- a/configure.ac
+++ b/configure.ac
@@ -252,6 +252,13 @@ AC_ARG_ENABLE(android, AC_HELP_STRING([--enable-android],
 					[enable_android=${enableval}])
 AM_CONDITIONAL(ANDROID, test "${enable_android}" = "yes")
 
+if (test "${enable_android}" = "yes"); then
+	PKG_CHECK_MODULES(SBC, sbc >= 1.0, dummy=yes,
+					AC_MSG_ERROR(libsbc1 >= 1.0 is required))
+	AC_SUBST(SBC_CFLAGS)
+	AC_SUBST(SBC_LIBS)
+fi
+
 AC_DEFINE_UNQUOTED(ANDROID_STORAGEDIR, "${storagedir}/android",
 			[Directory for the Android daemon storage files])
 
-- 
1.8.5.2

