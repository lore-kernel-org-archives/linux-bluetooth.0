Return-Path: <cyrus@holtmann.org>
From: Alon Bar-Lev <alon.barlev@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Alon Bar-Lev <alon.barlev@gmail.com>
Subject: [PATCH] Automake - do not override LDFLAGS
Date: Sun, 13 Nov 2011 09:40:50 +0200
Message-Id: <1321170050-18323-1-git-send-email-alon.barlev@gmail.com>
In-Reply-To: <1321159852.15441.449.camel@aeonflux>
References: <1321159852.15441.449.camel@aeonflux>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add AM_LDFLAGS to every _LDFLAGS, so that autoconf's
LDFLAGS won't be overridden.
---
 Makefile.am |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 57aa33c..344699e 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -70,7 +70,7 @@ lib_LTLIBRARIES += lib/libbluetooth.la
 
 lib_libbluetooth_la_SOURCES = $(lib_headers) \
 				lib/bluetooth.c lib/hci.c lib/sdp.c lib/uuid.c
-lib_libbluetooth_la_LDFLAGS = -version-info 14:4:11
+lib_libbluetooth_la_LDFLAGS = $(AM_LDFLAGS) -version-info 14:4:11
 lib_libbluetooth_la_DEPENDENCIES = $(local_headers)
 
 noinst_LTLIBRARIES += lib/libbluetooth-private.la
@@ -286,7 +286,7 @@ endif
 if MAINTAINER_MODE
 plugin_LTLIBRARIES += plugins/external-dummy.la
 plugins_external_dummy_la_SOURCES = plugins/external-dummy.c
-plugins_external_dummy_la_LDFLAGS = -module -avoid-version -no-undefined
+plugins_external_dummy_la_LDFLAGS = $(AM_LDFLAGS) -module -avoid-version -no-undefined
 plugins_external_dummy_la_CFLAGS = $(AM_CFLAGS) -fvisibility=hidden
 endif
 
@@ -317,7 +317,7 @@ src_bluetoothd_SOURCES = $(gdbus_sources) $(builtin_sources) \
 			src/oob.h src/oob.c src/eir.h src/eir.c
 src_bluetoothd_LDADD = lib/libbluetooth-private.la @GLIB_LIBS@ @DBUS_LIBS@ \
 							@CAPNG_LIBS@ -ldl -lrt
-src_bluetoothd_LDFLAGS = -Wl,--export-dynamic \
+src_bluetoothd_LDFLAGS = $(AM_LDFLAGS) -Wl,--export-dynamic \
 				-Wl,--version-script=$(srcdir)/src/bluetooth.ver
 
 src_bluetoothd_DEPENDENCIES = lib/libbluetooth-private.la
@@ -354,14 +354,14 @@ alsa_LTLIBRARIES = audio/libasound_module_pcm_bluetooth.la \
 
 audio_libasound_module_pcm_bluetooth_la_SOURCES = audio/pcm_bluetooth.c \
 					audio/rtp.h audio/ipc.h audio/ipc.c
-audio_libasound_module_pcm_bluetooth_la_LDFLAGS = -module -avoid-version #-export-symbols-regex [_]*snd_pcm_.*
+audio_libasound_module_pcm_bluetooth_la_LDFLAGS = $(AM_LDFLAGS) -module -avoid-version #-export-symbols-regex [_]*snd_pcm_.*
 audio_libasound_module_pcm_bluetooth_la_LIBADD = sbc/libsbc.la \
 					lib/libbluetooth-private.la @ALSA_LIBS@
 audio_libasound_module_pcm_bluetooth_la_CFLAGS = $(AM_CFLAGS) @ALSA_CFLAGS@
 
 audio_libasound_module_ctl_bluetooth_la_SOURCES = audio/ctl_bluetooth.c \
 					audio/rtp.h audio/ipc.h audio/ipc.c
-audio_libasound_module_ctl_bluetooth_la_LDFLAGS = -module -avoid-version #-export-symbols-regex [_]*snd_ctl_.*
+audio_libasound_module_ctl_bluetooth_la_LDFLAGS = $(AM_LDFLAGS) -module -avoid-version #-export-symbols-regex [_]*snd_ctl_.*
 audio_libasound_module_ctl_bluetooth_la_LIBADD = \
 					lib/libbluetooth-private.la @ALSA_LIBS@
 audio_libasound_module_ctl_bluetooth_la_CFLAGS = $(AM_CLAGS) @ALSA_CFLAGS@
@@ -388,7 +388,7 @@ audio_libgstbluetooth_la_SOURCES = audio/gstbluetooth.c audio/gstpragma.h \
 				audio/gstsbcutil.h audio/gstsbcutil.c \
 				audio/gstrtpsbcpay.h audio/gstrtpsbcpay.c \
 				audio/rtp.h audio/ipc.h audio/ipc.c
-audio_libgstbluetooth_la_LDFLAGS = -module -avoid-version
+audio_libgstbluetooth_la_LDFLAGS = $(AM_LDFLAGS) -module -avoid-version
 audio_libgstbluetooth_la_LIBADD = sbc/libsbc.la lib/libbluetooth-private.la \
 						@DBUS_LIBS@ @GSTREAMER_LIBS@ \
 						-lgstaudio-0.10 -lgstrtp-0.10
-- 
1.7.3.4

