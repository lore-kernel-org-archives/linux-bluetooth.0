Return-Path: <SRS0=IL+U=OA=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E982C43441
	for <linux-bluetooth@archiver.kernel.org>; Wed, 21 Nov 2018 12:58:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D310D20C01
	for <linux-bluetooth@archiver.kernel.org>; Wed, 21 Nov 2018 12:58:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D310D20C01
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inai.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730649AbeKUXcT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 21 Nov 2018 18:32:19 -0500
Received: from a3.inai.de ([88.198.85.195]:33980 "EHLO a3.inai.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730643AbeKUXcT (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 21 Nov 2018 18:32:19 -0500
Received: by a3.inai.de (Postfix, from userid 65534)
        id 9B8623BACCD7; Wed, 21 Nov 2018 13:58:01 +0100 (CET)
Received: from a4.inai.de (a4.inai.de [IPv6:2a01:4f8:222:6c9::f8])
        by a3.inai.de (Postfix) with ESMTP id D53E43BACCB2;
        Wed, 21 Nov 2018 13:57:57 +0100 (CET)
From:   Jan Engelhardt <jengelh@inai.de>
To:     luiz.dentz@gmail.com
Cc:     linux-bluetooth@vger.kernel.org, jengelh@inai.de
Subject: [PATCH 2/7] build: -l arguments to belong into LDADD/LIBADD not LDFLAGS
Date:   Wed, 21 Nov 2018 13:57:48 +0100
Message-Id: <20181121125753.15476-3-jengelh@inai.de>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181121125753.15476-1-jengelh@inai.de>
References: <CABBYNZ+pLp5W0_sNC4ih_KuW2WmX5drBL2bPX4rG4fHQ4kyecg@mail.gmail.com>
 <20181121125753.15476-1-jengelh@inai.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

It is an error to put -l arguments into LDFLAGS, because the linker
command line is order-sensitive and libs must appear in certain
places. For this, automake has the LDADD/LIBADD.
---
 Makefile.plugins    |  3 ++-
 android/Makefile.am | 15 ++++++++-------
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/Makefile.plugins b/Makefile.plugins
index 1c9919d71..d3cf5cab8 100644
--- a/Makefile.plugins
+++ b/Makefile.plugins
@@ -107,6 +107,7 @@ if SIXAXIS
 plugin_LTLIBRARIES += plugins/sixaxis.la
 plugins_sixaxis_la_SOURCES = plugins/sixaxis.c
 plugins_sixaxis_la_LDFLAGS = $(AM_LDFLAGS) -module -avoid-version \
-						-no-undefined $(UDEV_LIBS)
+						-no-undefined
+plugins_sixaxis_la_LIBADD = $(UDEV_LIBS)
 plugins_sixaxis_la_CFLAGS = $(AM_CFLAGS) -fvisibility=hidden $(UDEV_CFLAGS)
 endif
diff --git a/android/Makefile.am b/android/Makefile.am
index d09a52d69..282bc0e7c 100644
--- a/android/Makefile.am
+++ b/android/Makefile.am
@@ -142,7 +142,8 @@ android_haltest_SOURCES = android/client/haltest.c \
 				android/hal-utils.h android/hal-utils.c
 android_haltest_CFLAGS = $(AM_CFLAGS) -I$(srcdir)/android \
 				-DPLUGINDIR=\""$(android_plugindir)"\"
-android_haltest_LDFLAGS = -pthread -ldl -lm
+android_haltest_LDFLAGS = -pthread
+android_haltest_LIBS = -ldl -lm
 
 noinst_PROGRAMS += android/android-tester
 
@@ -165,8 +166,8 @@ android_android_tester_SOURCES = emulator/hciemu.h emulator/hciemu.c \
 android_android_tester_CFLAGS = $(AM_CFLAGS) -I$(srcdir)/android \
 				-DPLUGINDIR=\""$(android_plugindir)"\"
 android_android_tester_LDADD = lib/libbluetooth-internal.la \
-				src/libshared-glib.la $(GLIB_LIBS)
-android_android_tester_LDFLAGS = -pthread -ldl
+				src/libshared-glib.la $(GLIB_LIBS) -ldl
+android_android_tester_LDFLAGS = -pthread
 
 noinst_PROGRAMS += android/ipc-tester
 
@@ -194,9 +195,9 @@ android_audio_a2dp_default_la_SOURCES = android/audio-msg.h \
 					android/system/audio.h
 android_audio_a2dp_default_la_CFLAGS = $(AM_CFLAGS) -I$(srcdir)/android \
 					$(SBC_CFLAGS)
-android_audio_a2dp_default_la_LIBADD = $(SBC_LIBS)
+android_audio_a2dp_default_la_LIBADD = $(SBC_LIBS) -lrt
 android_audio_a2dp_default_la_LDFLAGS = $(AM_LDFLAGS) -module -avoid-version \
-					-no-undefined -pthread -lrt
+					-no-undefined -pthread
 
 plugin_LTLIBRARIES += android/audio.sco.default.la
 
@@ -210,9 +211,9 @@ android_audio_sco_default_la_SOURCES = android/hal-log.h \
 					android/audio_utils/resampler.h \
 					android/system/audio.h
 android_audio_sco_default_la_CFLAGS = $(AM_CFLAGS) -I$(srcdir)/android
-android_audio_sco_default_la_LIBADD = $(SPEEXDSP_LIBS)
+android_audio_sco_default_la_LIBADD = $(SPEEXDSP_LIBS) -lrt
 android_audio_sco_default_la_LDFLAGS = $(AM_LDFLAGS) -module -avoid-version \
-					-no-undefined -lrt
+					-no-undefined
 unit_tests += android/test-ipc
 
 android_test_ipc_SOURCES = android/test-ipc.c \
-- 
2.19.1

