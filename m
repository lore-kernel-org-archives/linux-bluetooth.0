Return-Path: <cyrus@holtmann.org>
From: Alon Bar-Lev <alon.barlev@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Alon Bar-Lev <alon.barlev@gmail.com>
Subject: [PATCH 2/2] Automake AM_CFLAGS, AM_LDFLAGS fixups
Date: Sun, 13 Nov 2011 01:48:50 +0200
Message-Id: <1321141730-20943-2-git-send-email-alon.barlev@gmail.com>
In-Reply-To: <1321141730-20943-1-git-send-email-alon.barlev@gmail.com>
References: <1321141730-20943-1-git-send-email-alon.barlev@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Reference: "Flag Variables Ordering"[1]

In automake, if you modify CFLAGS or LDFLAGS of a target you
actually override the autoconf supplied flags. This is highly
none standard and may lead to undesired results, as some
targets will be compiled with the autoconf supplied flags and
some won't.

This patch adds AM_LDFLAGS to any flags overridden.

[1] http://www.gnu.org/software/automake/manual/automake.html#Flag-Variables-Ordering
---
 Makefile.am |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index fdc58f6..80a3984 100644
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
 
@@ -319,7 +319,7 @@ src_bluetoothd_LDADD = lib/libbluetooth-private.la @GLIB_LIBS@ @DBUS_LIBS@ \
 							@CAPNG_LIBS@ -ldl -lrt
 src_bluetoothd_CFLAGS = $(AM_CFLAGS) \
 		-DBLUETOOTH_PLUGIN_BUILTIN -DPLUGINDIR=\""$(build_plugindir)"\"
-src_bluetoothd_LDFLAGS = -Wl,--export-dynamic \
+src_bluetoothd_LDFLAGS = $(AM_LDFLAGS) -Wl,--export-dynamic \
 				-Wl,--version-script=$(srcdir)/src/bluetooth.ver
 
 src_bluetoothd_DEPENDENCIES = lib/libbluetooth-private.la
@@ -352,14 +352,14 @@ alsa_LTLIBRARIES = audio/libasound_module_pcm_bluetooth.la \
 
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
 audio_libasound_module_ctl_bluetooth_la_CFLAGS = $(AM_CFLAGS) @ALSA_CFLAGS@
@@ -386,7 +386,7 @@ audio_libgstbluetooth_la_SOURCES = audio/gstbluetooth.c audio/gstpragma.h \
 				audio/gstsbcutil.h audio/gstsbcutil.c \
 				audio/gstrtpsbcpay.h audio/gstrtpsbcpay.c \
 				audio/rtp.h audio/ipc.h audio/ipc.c
-audio_libgstbluetooth_la_LDFLAGS = -module -avoid-version
+audio_libgstbluetooth_la_LDFLAGS = $(AM_LDFLAGS) -module -avoid-version
 audio_libgstbluetooth_la_LIBADD = sbc/libsbc.la lib/libbluetooth-private.la \
 				@DBUS_LIBS@ @GSTREAMER_LIBS@ -lgstaudio-0.10 -lgstrtp-0.10
 audio_libgstbluetooth_la_CFLAGS = $(AM_CFLAGS) -fvisibility=hidden -fno-strict-aliasing \
-- 
1.7.3.4

