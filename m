Return-Path: <SRS0=E1HW=N5=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8336C4161B
	for <linux-bluetooth@archiver.kernel.org>; Sun, 18 Nov 2018 16:14:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79AD420869
	for <linux-bluetooth@archiver.kernel.org>; Sun, 18 Nov 2018 16:14:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79AD420869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inai.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727352AbeKSCfB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 18 Nov 2018 21:35:01 -0500
Received: from a3.inai.de ([88.198.85.195]:54164 "EHLO a3.inai.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726995AbeKSCfB (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 18 Nov 2018 21:35:01 -0500
Received: by a3.inai.de (Postfix, from userid 65534)
        id 8CD9A1409B1D; Sun, 18 Nov 2018 17:08:11 +0100 (CET)
Received: from a4.inai.de (a4.inai.de [IPv6:2a01:4f8:222:6c9::f8])
        by a3.inai.de (Postfix) with ESMTP id CA1201337BC8;
        Sun, 18 Nov 2018 17:08:07 +0100 (CET)
From:   Jan Engelhardt <jengelh@inai.de>
To:     linux-bluetooth@vger.kernel.org
Cc:     jengelh@inai.de
Subject: [PATCH 4/8] build: -D/-I arguments go into CPPFLAGS
Date:   Sun, 18 Nov 2018 17:07:58 +0100
Message-Id: <20181118160802.11087-5-jengelh@inai.de>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181118160802.11087-1-jengelh@inai.de>
References: <20181118160802.11087-1-jengelh@inai.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

-D and -I are preprocessor directives, they are therefore to appear
in CPPFLAGS, not CFLAGS. (It is unfortunate that pkg-config does not
make the distinction / or it was misnamed, because only -D/-I make
sense to be emitted by pkg-config in the first place — anything else
(-f/-m) has the potential to mess up someone's compilation. So
pkg-config's Cflags is actually used to convery Cppflags.)
---
 Makefile.am         |  9 ++++-----
 Makefile.obexd      |  7 ++++---
 Makefile.plugins    |  3 ++-
 Makefile.tools      |  2 +-
 android/Makefile.am | 14 +++++++-------
 5 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 33f4f3b98..4e320602c 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -1,5 +1,6 @@
 
 AM_MAKEFLAGS = --no-print-directory
+AM_CPPFLAGS =
 
 lib_LTLIBRARIES =
 
@@ -213,7 +214,7 @@ src_bluetoothd_DEPENDENCIES = lib/libbluetooth-internal.la \
 				src/libshared-glib.la \
 				src/bluetooth.service
 
-src_bluetoothd_CFLAGS = $(AM_CFLAGS) -DBLUETOOTH_PLUGIN_BUILTIN \
+src_bluetoothd_CPPFLAGS = $(AM_CPPFLAGS) -DBLUETOOTH_PLUGIN_BUILTIN \
 					-DPLUGINDIR=\""$(build_plugindir)"\"
 src_bluetoothd_SHORTNAME = bluetoothd
 
@@ -277,9 +278,7 @@ EXTRA_DIST += doc/btsnoop.txt
 
 EXTRA_DIST += tools/magic.btsnoop
 
-AM_CFLAGS += $(DBUS_CFLAGS) $(GLIB_CFLAGS)
-
-AM_CPPFLAGS = -I$(builddir)/lib
+AM_CPPFLAGS += $(DBUS_CFLAGS) $(GLIB_CFLAGS) -I$(builddir)/lib
 
 
 unit_tests += unit/test-eir
@@ -435,7 +434,7 @@ unit_test_gattrib_LDADD = lib/libbluetooth-internal.la \
 
 if MIDI
 unit_tests += unit/test-midi
-unit_test_midi_CFLAGS = $(AM_CFLAGS) $(ALSA_CFLAGS) -DMIDI_TEST
+unit_test_midi_CPPFLAGS = $(AM_CPPFLAGS) $(ALSA_CFLAGS) -DMIDI_TEST
 unit_test_midi_SOURCES = unit/test-midi.c \
 			profiles/midi/libmidi.h \
 			profiles/midi/libmidi.c
diff --git a/Makefile.obexd b/Makefile.obexd
index 9180d7eea..22a4977ef 100644
--- a/Makefile.obexd
+++ b/Makefile.obexd
@@ -83,12 +83,13 @@ obexd_src_obexd_LDADD = lib/libbluetooth-internal.la \
 
 obexd_src_obexd_LDFLAGS = -Wl,--export-dynamic
 
-obexd_src_obexd_CFLAGS = $(AM_CFLAGS) $(GLIB_CFLAGS) $(DBUS_CFLAGS) \
+obexd_src_obexd_CPPFLAGS = $(AM_CFLAGS) $(GLIB_CFLAGS) $(DBUS_CFLAGS) \
 				$(ICAL_CFLAGS) -DOBEX_PLUGIN_BUILTIN \
 				-DPLUGINDIR=\""$(obex_plugindir)"\" \
-				-fPIC -D_FILE_OFFSET_BITS=64
+				-D_FILE_OFFSET_BITS=64 \
+				-I$(builddir)/lib -I$(builddir)/obexd/src
 
-obexd_src_obexd_CPPFLAGS = -I$(builddir)/lib -I$(builddir)/obexd/src
+obexd_src_obexd_CFLAGS = -fPIC
 
 endif
 
diff --git a/Makefile.plugins b/Makefile.plugins
index d3cf5cab8..2aaeb7450 100644
--- a/Makefile.plugins
+++ b/Makefile.plugins
@@ -109,5 +109,6 @@ plugins_sixaxis_la_SOURCES = plugins/sixaxis.c
 plugins_sixaxis_la_LDFLAGS = $(AM_LDFLAGS) -module -avoid-version \
 						-no-undefined
 plugins_sixaxis_la_LIBADD = $(UDEV_LIBS)
-plugins_sixaxis_la_CFLAGS = $(AM_CFLAGS) -fvisibility=hidden $(UDEV_CFLAGS)
+plugins_sixaxis_la_CPPFLAGS = $(AM_CPPFLAGS) $(UDEV_CFLAGS)
+plugins_sixaxis_la_CFLAGS = $(AM_CFLAGS) -fvisibility=hidden
 endif
diff --git a/Makefile.tools b/Makefile.tools
index aadb4c8c0..cb43a92b2 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -467,6 +467,6 @@ if BTPCLIENT
 noinst_PROGRAMS += tools/btpclient
 
 tools_btpclient_SOURCES = tools/btpclient.c src/shared/btp.c src/shared/btp.h
-tools_btpclient_CFLAGS = $(AM_CFLAGS) $(ELL_CFLAGS)
+tools_btpclient_CPPFLAGS = $(AM_CPPFLAGS) $(ELL_CFLAGS)
 tools_btpclient_LDADD = $(ELL_LIBS) lib/libbluetooth-internal.la
 endif
diff --git a/android/Makefile.am b/android/Makefile.am
index dbf7e4408..dded113e2 100644
--- a/android/Makefile.am
+++ b/android/Makefile.am
@@ -1,6 +1,6 @@
 if ANDROID
 
-AM_CFLAGS += -DANDROID_VERSION=0x050100
+AM_CPPFLAGS += -DANDROID_VERSION=0x050100
 
 android_plugindir = $(abs_top_srcdir)/android/.libs
 
@@ -96,7 +96,7 @@ android_bluetooth_default_la_SOURCES = android/hal.h android/hal-bluetooth.c \
 					android/hal-log.h \
 					android/hal-ipc.h android/hal-ipc.c \
 					android/hal-utils.h android/hal-utils.c
-android_bluetooth_default_la_CFLAGS = $(AM_CFLAGS) -I$(srcdir)/android
+android_bluetooth_default_la_CPPFLAGS = $(AM_CPPFLAGS) -I$(srcdir)/android
 android_bluetooth_default_la_LDFLAGS = $(AM_LDFLAGS) -module -avoid-version \
 					-no-undefined
 
@@ -139,7 +139,7 @@ android_haltest_SOURCES = android/client/haltest.c \
 				android/client/if-mce.c \
 				android/hardware/hardware.c \
 				android/hal-utils.h android/hal-utils.c
-android_haltest_CFLAGS = $(AM_CFLAGS) -I$(srcdir)/android \
+android_haltest_CPPFLAGS = $(AM_CPPFLAGS) -I$(srcdir)/android \
 				-DPLUGINDIR=\""$(android_plugindir)"\"
 android_haltest_LDFLAGS = -pthread
 android_haltest_LIBS = -ldl -lm
@@ -162,7 +162,7 @@ android_android_tester_SOURCES = emulator/hciemu.h emulator/hciemu.c \
 				android/tester-gatt.c \
 				android/tester-map-client.c \
 				android/tester-main.h android/tester-main.c
-android_android_tester_CFLAGS = $(AM_CFLAGS) -I$(srcdir)/android \
+android_android_tester_CPPFLAGS = $(AM_CPPFLAGS) -I$(srcdir)/android \
 				-DPLUGINDIR=\""$(android_plugindir)"\"
 android_android_tester_LDADD = lib/libbluetooth-internal.la \
 				src/libshared-glib.la $(GLIB_LIBS) -ldl
@@ -176,7 +176,7 @@ android_ipc_tester_SOURCES = emulator/hciemu.h emulator/hciemu.c \
 				emulator/smp.c \
 				android/hal-utils.h android/hal-utils.c \
 				android/ipc-common.h android/ipc-tester.c
-android_ipc_tester_CFLAGS = $(AM_CFLAGS) -I$(srcdir)/android
+android_ipc_tester_CPPFLAGS = $(AM_CPPFLAGS) -I$(srcdir)/android
 android_ipc_tester_LDADD = lib/libbluetooth-internal.la \
 				src/libshared-glib.la $(GLIB_LIBS)
 
@@ -192,7 +192,7 @@ android_audio_a2dp_default_la_SOURCES = android/audio-msg.h \
 					android/hardware/audio_effect.h \
 					android/hardware/hardware.h \
 					android/system/audio.h
-android_audio_a2dp_default_la_CFLAGS = $(AM_CFLAGS) -I$(srcdir)/android \
+android_audio_a2dp_default_la_CPPFLAGS = $(AM_CPPFLAGS) -I$(srcdir)/android \
 					$(SBC_CFLAGS)
 android_audio_a2dp_default_la_LIBADD = $(SBC_LIBS) -lrt
 android_audio_a2dp_default_la_LDFLAGS = $(AM_LDFLAGS) -module -avoid-version \
@@ -209,7 +209,7 @@ android_audio_sco_default_la_SOURCES = android/hal-log.h \
 					android/audio_utils/resampler.c \
 					android/audio_utils/resampler.h \
 					android/system/audio.h
-android_audio_sco_default_la_CFLAGS = $(AM_CFLAGS) -I$(srcdir)/android
+android_audio_sco_default_la_CPPFLAGS = $(AM_CPPFLAGS) -I$(srcdir)/android
 android_audio_sco_default_la_LIBADD = $(SPEEXDSP_LIBS) -lrt
 android_audio_sco_default_la_LDFLAGS = $(AM_LDFLAGS) -module -avoid-version \
 					-no-undefined
-- 
2.19.1

