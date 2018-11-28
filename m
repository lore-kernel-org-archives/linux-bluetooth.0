Return-Path: <SRS0=9KbV=OH=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F210BC43441
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Nov 2018 15:45:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0E622146D
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Nov 2018 15:45:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0E622146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inai.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728262AbeK2CrX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 28 Nov 2018 21:47:23 -0500
Received: from a3.inai.de ([88.198.85.195]:37970 "EHLO a3.inai.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728102AbeK2CrX (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 28 Nov 2018 21:47:23 -0500
Received: by a3.inai.de (Postfix, from userid 65534)
        id AB99FE0B084; Wed, 28 Nov 2018 16:45:16 +0100 (CET)
Received: from a4.inai.de (a4.inai.de [IPv6:2a01:4f8:222:6c9::f8])
        by a3.inai.de (Postfix) with ESMTP id 102AB3BACCB1;
        Wed, 28 Nov 2018 16:45:15 +0100 (CET)
From:   Jan Engelhardt <jengelh@inai.de>
To:     luiz.dentz@gmail.com
Cc:     jengelh@inai.de, linux-bluetooth@vger.kernel.org
Subject: [PATCH] build: make building with --coverage work again
Date:   Wed, 28 Nov 2018 16:45:14 +0100
Message-Id: <20181128154514.17315-1-jengelh@inai.de>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <CABBYNZ+EmmyGU2_ktS237iCjrEa1d7=ODCy_nmNerXmCuX7tsg@mail.gmail.com>
References: <CABBYNZ+EmmyGU2_ktS237iCjrEa1d7=ODCy_nmNerXmCuX7tsg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

When `./configure --enable-coverage` is given and lcov is present,
MISC_CFLAGS and MISC_LDFLAGS will be set to --coverage. However,

1. obexd uses per-target LDFLAGS and, in doing so, forget to re-mention
$(AM_LDFLAGS). This problem existed for a long time.

2. obexd uses per-target CFLAGS and, in doing so, forgot to re-mention
$(AM_CFLAGS). This got broken in 06dbb223fbe50acc48b3ba1d33cb424275b4baaa.

This led to no --coverage showing up in the linker line for obexd,
causing a link failure indicating unresolved symbols like
__gcov_exit.
---
 Makefile.obexd      | 6 +++---
 android/Makefile.am | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Makefile.obexd b/Makefile.obexd
index 22a4977ef..1c1e500fe 100644
--- a/Makefile.obexd
+++ b/Makefile.obexd
@@ -81,15 +81,15 @@ obexd_src_obexd_LDADD = lib/libbluetooth-internal.la \
 			gdbus/libgdbus-internal.la \
 			$(ICAL_LIBS) $(DBUS_LIBS) $(GLIB_LIBS) -ldl
 
-obexd_src_obexd_LDFLAGS = -Wl,--export-dynamic
+obexd_src_obexd_LDFLAGS = $(AM_LDFLAGS) -Wl,--export-dynamic
 
-obexd_src_obexd_CPPFLAGS = $(AM_CFLAGS) $(GLIB_CFLAGS) $(DBUS_CFLAGS) \
+obexd_src_obexd_CPPFLAGS = $(AM_CPPFLAGS) $(GLIB_CFLAGS) $(DBUS_CFLAGS) \
 				$(ICAL_CFLAGS) -DOBEX_PLUGIN_BUILTIN \
 				-DPLUGINDIR=\""$(obex_plugindir)"\" \
 				-D_FILE_OFFSET_BITS=64 \
 				-I$(builddir)/lib -I$(builddir)/obexd/src
 
-obexd_src_obexd_CFLAGS = -fPIC
+obexd_src_obexd_CFLAGS = $(AM_CFLAGS) -fPIC
 
 endif
 
diff --git a/android/Makefile.am b/android/Makefile.am
index 5dd1adf9d..a370598a2 100644
--- a/android/Makefile.am
+++ b/android/Makefile.am
@@ -142,7 +142,7 @@ android_haltest_SOURCES = android/client/haltest.c \
 				android/hal-utils.h android/hal-utils.c
 android_haltest_CPPFLAGS = $(AM_CPPFLAGS) -I$(srcdir)/android \
 				-DPLUGINDIR=\""$(android_plugindir)"\"
-android_haltest_LDFLAGS = -pthread
+android_haltest_LDFLAGS = $(AM_LDFLAGS) -pthread
 android_haltest_LDADD = -ldl -lm
 
 noinst_PROGRAMS += android/android-tester
@@ -167,7 +167,7 @@ android_android_tester_CPPFLAGS = $(AM_CPPFLAGS) -I$(srcdir)/android \
 				-DPLUGINDIR=\""$(android_plugindir)"\"
 android_android_tester_LDADD = lib/libbluetooth-internal.la \
 				src/libshared-glib.la $(GLIB_LIBS) -ldl
-android_android_tester_LDFLAGS = -pthread
+android_android_tester_LDFLAGS = $(AM_LDFLAGS) -pthread
 
 noinst_PROGRAMS += android/ipc-tester
 
-- 
2.19.1

