Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH v2 2/9] android: Build Audio HAL with SBC
Date: Mon, 20 Jan 2014 15:58:56 +0100
Message-ID: <1390229943-29609-3-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1390229943-29609-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1390229943-29609-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Build for Android requires libsbc to be built as shared library and
includes to be available in external/bluetooth/sbc. Build for host
requires libsbc package to be installed.
---
 android/Android.mk  | 7 +++++--
 android/Makefile.am | 2 ++
 configure.ac        | 7 +++++++
 3 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/android/Android.mk b/android/Android.mk
index afa3a51..cf7a224 100644
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
@@ -225,9 +226,11 @@ LOCAL_SRC_FILES := hal-audio.c
 LOCAL_C_INCLUDES = \
 	$(call include-path-for, system-core) \
 	$(call include-path-for, libhardware) \
+	$(call include-path-for, sbc) \
 
 LOCAL_SHARED_LIBRARIES := \
 	libcutils \
+	libsbc \
 
 LOCAL_CFLAGS := $(BLUEZ_COMMON_CFLAGS) \
 
diff --git a/android/Makefile.am b/android/Makefile.am
index 924917a..69ea6d5 100644
--- a/android/Makefile.am
+++ b/android/Makefile.am
@@ -130,6 +130,8 @@ android_audio_a2dp_default_la_SOURCES = android/audio-msg.h \
 
 android_audio_a2dp_default_la_CFLAGS = $(AM_CFLAGS) -I$(srcdir)/android
 
+android_audio_a2dp_default_la_LIBADD = @SBC_LIBS@
+
 android_audio_a2dp_default_la_LDFLAGS = $(AM_LDFLAGS) -module -avoid-version \
 					-no-undefined -pthread
 
diff --git a/configure.ac b/configure.ac
index c85f208..8e4053f 100644
--- a/configure.ac
+++ b/configure.ac
@@ -252,6 +252,13 @@ AC_ARG_ENABLE(android, AC_HELP_STRING([--enable-android],
 					[enable_android=${enableval}])
 AM_CONDITIONAL(ANDROID, test "${enable_android}" = "yes")
 
+if (test "${enable_android}" = "yes"); then
+	PKG_CHECK_MODULES(SBC, sbc >= 1.2, dummy=yes,
+					AC_MSG_ERROR(SBC library >= 1.2 is required))
+	AC_SUBST(SBC_CFLAGS)
+	AC_SUBST(SBC_LIBS)
+fi
+
 AC_DEFINE_UNQUOTED(ANDROID_STORAGEDIR, "${storagedir}/android",
 			[Directory for the Android daemon storage files])
 
-- 
1.8.5.2

