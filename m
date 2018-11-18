Return-Path: <SRS0=E1HW=N5=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15E30C18DF5
	for <linux-bluetooth@archiver.kernel.org>; Sun, 18 Nov 2018 16:14:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB59620869
	for <linux-bluetooth@archiver.kernel.org>; Sun, 18 Nov 2018 16:14:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB59620869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inai.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727360AbeKSCfB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 18 Nov 2018 21:35:01 -0500
Received: from a3.inai.de ([88.198.85.195]:54166 "EHLO a3.inai.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726746AbeKSCfB (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 18 Nov 2018 21:35:01 -0500
Received: by a3.inai.de (Postfix, from userid 65534)
        id 98FBB13267CA; Sun, 18 Nov 2018 17:08:12 +0100 (CET)
Received: from a4.inai.de (a4.inai.de [IPv6:2a01:4f8:222:6c9::f8])
        by a3.inai.de (Postfix) with ESMTP id 120D113267D9;
        Sun, 18 Nov 2018 17:08:08 +0100 (CET)
From:   Jan Engelhardt <jengelh@inai.de>
To:     linux-bluetooth@vger.kernel.org
Cc:     jengelh@inai.de
Subject: [PATCH 8/8] build: add missing BACKTRACE_CFLAGS
Date:   Sun, 18 Nov 2018 17:08:02 +0100
Message-Id: <20181118160802.11087-9-jengelh@inai.de>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181118160802.11087-1-jengelh@inai.de>
References: <20181118160802.11087-1-jengelh@inai.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Some targets use BACKTRACE_LIBS, hence need BACKTRACE_CFLAGS.
---
 Makefile.am | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile.am b/Makefile.am
index d9f42f2d2..a573b1041 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -218,7 +218,7 @@ src_bluetoothd_DEPENDENCIES = lib/libbluetooth-internal.la \
 
 src_bluetoothd_CPPFLAGS = $(AM_CPPFLAGS) -DBLUETOOTH_PLUGIN_BUILTIN \
 					-DPLUGINDIR=\""$(build_plugindir)"\" \
-					$(builtin_cppflags)
+					$(BACKTRACE_CFLAGS) $(builtin_cppflags)
 src_bluetoothd_SHORTNAME = bluetoothd
 
 builtin_files = src/builtin.h $(builtin_nodist)
-- 
2.19.1

