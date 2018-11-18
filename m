Return-Path: <SRS0=E1HW=N5=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CA1DC4161D
	for <linux-bluetooth@archiver.kernel.org>; Sun, 18 Nov 2018 16:14:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13EA42080F
	for <linux-bluetooth@archiver.kernel.org>; Sun, 18 Nov 2018 16:14:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13EA42080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inai.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbeKSCfC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 18 Nov 2018 21:35:02 -0500
Received: from a3.inai.de ([88.198.85.195]:54168 "EHLO a3.inai.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727277AbeKSCfB (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 18 Nov 2018 21:35:01 -0500
Received: by a3.inai.de (Postfix, from userid 65534)
        id 812A1130158B; Sun, 18 Nov 2018 17:08:12 +0100 (CET)
Received: from a4.inai.de (a4.inai.de [IPv6:2a01:4f8:222:6c9::f8])
        by a3.inai.de (Postfix) with ESMTP id 037B713267CA;
        Sun, 18 Nov 2018 17:08:08 +0100 (CET)
From:   Jan Engelhardt <jengelh@inai.de>
To:     linux-bluetooth@vger.kernel.org
Cc:     jengelh@inai.de
Subject: [PATCH 7/8] build: add missing ALSA_CFLAGS
Date:   Sun, 18 Nov 2018 17:08:01 +0100
Message-Id: <20181118160802.11087-8-jengelh@inai.de>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181118160802.11087-1-jengelh@inai.de>
References: <20181118160802.11087-1-jengelh@inai.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Some targets use ALSA_LIBS, hence need ALSA_CFLAGS.
---
 Makefile.am      | 4 +++-
 Makefile.plugins | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/Makefile.am b/Makefile.am
index e5d19682b..d9f42f2d2 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -159,6 +159,7 @@ gobex_sources = gobex/gobex.h gobex/gobex.c \
 
 builtin_modules =
 builtin_sources =
+builtin_cppflags =
 builtin_nodist =
 builtin_ldadd =
 
@@ -216,7 +217,8 @@ src_bluetoothd_DEPENDENCIES = lib/libbluetooth-internal.la \
 				src/bluetooth.service
 
 src_bluetoothd_CPPFLAGS = $(AM_CPPFLAGS) -DBLUETOOTH_PLUGIN_BUILTIN \
-					-DPLUGINDIR=\""$(build_plugindir)"\"
+					-DPLUGINDIR=\""$(build_plugindir)"\" \
+					$(builtin_cppflags)
 src_bluetoothd_SHORTNAME = bluetoothd
 
 builtin_files = src/builtin.h $(builtin_nodist)
diff --git a/Makefile.plugins b/Makefile.plugins
index 2aaeb7450..47bf317cb 100644
--- a/Makefile.plugins
+++ b/Makefile.plugins
@@ -97,6 +97,7 @@ builtin_modules += midi
 builtin_sources += profiles/midi/midi.c \
 			profiles/midi/libmidi.h \
 			profiles/midi/libmidi.c
+builtin_cppflags += $(ALSA_CFLAGS)
 builtin_ldadd += $(ALSA_LIBS)
 endif
 
-- 
2.19.1

