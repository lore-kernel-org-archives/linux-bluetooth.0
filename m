Return-Path: <SRS0=yWLZ=OE=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E9E6C18E01
	for <linux-bluetooth@archiver.kernel.org>; Sun, 25 Nov 2018 09:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA83E20989
	for <linux-bluetooth@archiver.kernel.org>; Sun, 25 Nov 2018 09:20:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA83E20989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inai.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727576AbeKYUK5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 25 Nov 2018 15:10:57 -0500
Received: from a3.inai.de ([88.198.85.195]:54034 "EHLO a3.inai.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727554AbeKYUK5 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 25 Nov 2018 15:10:57 -0500
Received: by a3.inai.de (Postfix, from userid 65534)
        id 34BFBF8B1B; Sun, 25 Nov 2018 10:20:18 +0100 (CET)
Received: from a4.inai.de (a4.inai.de [IPv6:2a01:4f8:222:6c9::f8])
        by a3.inai.de (Postfix) with ESMTP id 3941BF8B1C;
        Sun, 25 Nov 2018 10:20:14 +0100 (CET)
From:   Jan Engelhardt <jengelh@inai.de>
To:     luiz.dentz@gmail.com
Cc:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 7/8] build: add missing ALSA_CFLAGS
Date:   Sun, 25 Nov 2018 10:20:11 +0100
Message-Id: <20181125092012.8001-8-jengelh@inai.de>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181125092012.8001-1-jengelh@inai.de>
References: <CABBYNZL0jgnZTYSQ+c+54_fHudK+0fg-GwS_-LUzw7gde_aMyA@mail.gmail.com>
 <20181125092012.8001-1-jengelh@inai.de>
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
index 5d7bc06b9..26e03b46f 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -160,6 +160,7 @@ gobex_sources = gobex/gobex.h gobex/gobex.c \
 
 builtin_modules =
 builtin_sources =
+builtin_cppflags =
 builtin_nodist =
 builtin_ldadd =
 
@@ -217,7 +218,8 @@ src_bluetoothd_DEPENDENCIES = lib/libbluetooth-internal.la \
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

