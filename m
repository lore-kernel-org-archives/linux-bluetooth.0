Return-Path: <cyrus@holtmann.org>
From: Alon Bar-Lev <alon.barlev@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Alon Bar-Lev <alon.barlev@gmail.com>
Subject: [PATCH 1/2] Automake AM_CFLAGS, AM_LDFLAGS fixups
Date: Sun, 13 Nov 2011 01:48:49 +0200
Message-Id: <1321141730-20943-1-git-send-email-alon.barlev@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Reference: "Flag Variables Ordering"[1]

In automake, if you modify CFLAGS or LDFLAGS of a target you
actually override the autoconf supplied flags. This is highly
none standard and may lead to undesired results, as some
targets will be compiled with the autoconf supplied flags and
some won't.

This patch adds AM_CFLAGS to any flags overridden.

Some notes:

1. Remove none common flags:
	-DBLUETOOTH_PLUGIN_BUILTIN -DPLUGINDIR=\""$(build_plugindir)"\"
Moved to bluetoothd only, as BLUETOOTH_PLUGIN_BUILTIN should
effect only sources compiled within it.
And PLUGINDIR is used only by the daemon.

2. More targets now will be compiled with:
	@DBUS_CFLAGS@ @GLIB_CFLAGS@ @CAPNG_CFLAGS@
If this is a problem I will add these to specific
targets.

3. I am not sure there is a reason to set specific
trivial CFLAGS for simple includes in target specific. Simpler
is to put all at AM_CFLAGS.

4. All @XXX_XXFLAGS@ can actually be used as make macros
$(XXX_XXFLAGS),
Since AC_SUBST are automatically generated as make
macros.

5. Why don't you split up the Makefile.am into smaller
by directory/library? It would be easier to control the
setup.

[1] http://www.gnu.org/software/automake/manual/automake.html#Flag-Variables-Ordering
---
 Makefile.am |   21 +++++++++++----------
 1 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 283af4d..fdc58f6 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -87,7 +87,7 @@ sbc_libsbc_la_SOURCES = sbc/sbc.h sbc/sbc.c sbc/sbc_math.h sbc/sbc_tables.h \
 			sbc/sbc_primitives_neon.h sbc/sbc_primitives_neon.c \
 			sbc/sbc_primitives_armv6.h sbc/sbc_primitives_armv6.c
 
-sbc_libsbc_la_CFLAGS = -finline-functions -fgcse-after-reload \
+sbc_libsbc_la_CFLAGS = $(AM_CFLAGS) -finline-functions -fgcse-after-reload \
 					-funswitch-loops -funroll-loops
 
 noinst_PROGRAMS += sbc/sbcinfo sbc/sbcdec sbc/sbcenc
@@ -102,7 +102,7 @@ if SNDFILE
 noinst_PROGRAMS += sbc/sbctester
 
 sbc_sbctester_LDADD = @SNDFILE_LIBS@ -lm
-sbc_sbctest_CFLAGS = @SNDFILE_CFLAGS@
+sbc_sbctest_CFLAGS = $(AM_CFLAGS) @SNDFILE_CFLAGS@
 endif
 endif
 
@@ -287,7 +287,7 @@ if MAINTAINER_MODE
 plugin_LTLIBRARIES += plugins/external-dummy.la
 plugins_external_dummy_la_SOURCES = plugins/external-dummy.c
 plugins_external_dummy_la_LDFLAGS = -module -avoid-version -no-undefined
-plugins_external_dummy_la_CFLAGS = -fvisibility=hidden
+plugins_external_dummy_la_CFLAGS = $(AM_CFLAGS) -fvisibility=hidden
 endif
 
 sbin_PROGRAMS += src/bluetoothd
@@ -317,6 +317,8 @@ src_bluetoothd_SOURCES = $(gdbus_sources) $(builtin_sources) \
 			src/oob.h src/oob.c src/eir.h src/eir.c
 src_bluetoothd_LDADD = lib/libbluetooth-private.la @GLIB_LIBS@ @DBUS_LIBS@ \
 							@CAPNG_LIBS@ -ldl -lrt
+src_bluetoothd_CFLAGS = $(AM_CFLAGS) \
+		-DBLUETOOTH_PLUGIN_BUILTIN -DPLUGINDIR=\""$(build_plugindir)"\"
 src_bluetoothd_LDFLAGS = -Wl,--export-dynamic \
 				-Wl,--version-script=$(srcdir)/src/bluetooth.ver
 
@@ -353,14 +355,14 @@ audio_libasound_module_pcm_bluetooth_la_SOURCES = audio/pcm_bluetooth.c \
 audio_libasound_module_pcm_bluetooth_la_LDFLAGS = -module -avoid-version #-export-symbols-regex [_]*snd_pcm_.*
 audio_libasound_module_pcm_bluetooth_la_LIBADD = sbc/libsbc.la \
 					lib/libbluetooth-private.la @ALSA_LIBS@
-audio_libasound_module_pcm_bluetooth_la_CFLAGS = @ALSA_CFLAGS@
+audio_libasound_module_pcm_bluetooth_la_CFLAGS = $(AM_CFLAGS) @ALSA_CFLAGS@
 
 audio_libasound_module_ctl_bluetooth_la_SOURCES = audio/ctl_bluetooth.c \
 					audio/rtp.h audio/ipc.h audio/ipc.c
 audio_libasound_module_ctl_bluetooth_la_LDFLAGS = -module -avoid-version #-export-symbols-regex [_]*snd_ctl_.*
 audio_libasound_module_ctl_bluetooth_la_LIBADD = \
 					lib/libbluetooth-private.la @ALSA_LIBS@
-audio_libasound_module_ctl_bluetooth_la_CFLAGS = @ALSA_CFLAGS@
+audio_libasound_module_ctl_bluetooth_la_CFLAGS = $(AM_CFLAGS) @ALSA_CFLAGS@
 
 if DATAFILES
 alsaconfdir = $(datadir)/alsa
@@ -387,8 +389,8 @@ audio_libgstbluetooth_la_SOURCES = audio/gstbluetooth.c audio/gstpragma.h \
 audio_libgstbluetooth_la_LDFLAGS = -module -avoid-version
 audio_libgstbluetooth_la_LIBADD = sbc/libsbc.la lib/libbluetooth-private.la \
 				@DBUS_LIBS@ @GSTREAMER_LIBS@ -lgstaudio-0.10 -lgstrtp-0.10
-audio_libgstbluetooth_la_CFLAGS = -fvisibility=hidden -fno-strict-aliasing \
-						$(AM_CFLAGS) @DBUS_CFLAGS@ @GSTREAMER_CFLAGS@
+audio_libgstbluetooth_la_CFLAGS = $(AM_CFLAGS) -fvisibility=hidden -fno-strict-aliasing \
+						@DBUS_CFLAGS@ @GSTREAMER_CFLAGS@
 endif
 endif
 
@@ -432,8 +434,7 @@ EXTRA_DIST += doc/manager-api.txt \
 
 AM_YFLAGS = -d
 
-AM_CFLAGS = @DBUS_CFLAGS@ @GLIB_CFLAGS@ @CAPNG_CFLAGS@ \
-		-DBLUETOOTH_PLUGIN_BUILTIN -DPLUGINDIR=\""$(build_plugindir)"\"
+AM_CFLAGS = @DBUS_CFLAGS@ @GLIB_CFLAGS@ @CAPNG_CFLAGS@
 
 INCLUDES = -I$(builddir)/lib -I$(builddir)/src -I$(srcdir)/src \
 			-I$(srcdir)/audio -I$(srcdir)/sbc -I$(srcdir)/gdbus \
@@ -450,7 +451,7 @@ unit_tests = unit/test-eir
 noinst_PROGRAMS += $(unit_tests)
 
 unit_test_eir_SOURCES = unit/test-eir.c src/eir.c src/glib-helper.c
-unit_test_eir_CFLAGS = @GLIB_CFLAGS@ @CHECK_CFLAGS@
+unit_test_eir_CFLAGS = $(AM_CFLAGS) @GLIB_CFLAGS@ @CHECK_CFLAGS@
 unit_test_eir_LDADD = lib/libbluetooth-private.la @GLIB_LIBS@ @CHECK_LIBS@
 unit_objects += $(unit_test_eir_OBJECTS)
 
-- 
1.7.3.4

