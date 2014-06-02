Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] android: Fix compile error
Date: Mon,  2 Jun 2014 11:49:39 -0300
Message-Id: <1401720579-18551-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

During configure, if SBC is not installed in the system, we may use
SBC_CFLAGS and SBC_LIBS variables to indicate where SBC headers and
binaries can be found.

However, SBC_CFLAGS variable is not used in android/Makefile.am,
causing the following compile error:

$ ./bootstrap-configure SBC_CFLAGS=-I../sbc SBC_LIBS=-L../sbc/src/
$ make

(...)

android/hal-audio-sbc.c:22:21: fatal error: sbc/sbc.h: No such file or directory
 #include <sbc/sbc.h>
^
compilation terminated.
make[1]: *** [android/android_audio_a2dp_default_la-hal-audio-sbc.lo] Error 1

This patch fixes this error by appending SBC_CFLAGS to android_audio_
a2dp_default_la_CFLAGS.
---
 android/Makefile.am | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/android/Makefile.am b/android/Makefile.am
index bcaec4c..08e6a95 100644
--- a/android/Makefile.am
+++ b/android/Makefile.am
@@ -205,7 +205,8 @@ android_test_ipc_LDADD = @GLIB_LIBS@
 
 plugin_LTLIBRARIES += android/audio.a2dp.default.la
 
-android_audio_a2dp_default_la_CFLAGS = $(AM_CFLAGS) -I$(srcdir)/android
+android_audio_a2dp_default_la_CFLAGS = $(AM_CFLAGS) -I$(srcdir)/android \
+					@SBC_CFLAGS@
 
 android_audio_a2dp_default_la_LIBADD = @SBC_LIBS@
 
-- 
1.9.1

