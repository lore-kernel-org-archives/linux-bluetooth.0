Return-Path: <SRS0=IL+U=OA=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3093DC04EBA
	for <linux-bluetooth@archiver.kernel.org>; Wed, 21 Nov 2018 12:58:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0376820C01
	for <linux-bluetooth@archiver.kernel.org>; Wed, 21 Nov 2018 12:58:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0376820C01
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inai.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730657AbeKUXcV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 21 Nov 2018 18:32:21 -0500
Received: from a3.inai.de ([88.198.85.195]:34000 "EHLO a3.inai.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730644AbeKUXcV (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 21 Nov 2018 18:32:21 -0500
Received: by a3.inai.de (Postfix, from userid 65534)
        id E3D0F3BACCCA; Wed, 21 Nov 2018 13:58:03 +0100 (CET)
Received: from a4.inai.de (a4.inai.de [IPv6:2a01:4f8:222:6c9::f8])
        by a3.inai.de (Postfix) with ESMTP id 2F6943BACCD2;
        Wed, 21 Nov 2018 13:57:58 +0100 (CET)
From:   Jan Engelhardt <jengelh@inai.de>
To:     luiz.dentz@gmail.com
Cc:     linux-bluetooth@vger.kernel.org, jengelh@inai.de
Subject: [PATCH 7/7] build: add missing BACKTRACE_CFLAGS
Date:   Wed, 21 Nov 2018 13:57:53 +0100
Message-Id: <20181121125753.15476-8-jengelh@inai.de>
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

Some targets use BACKTRACE_LIBS, hence need BACKTRACE_CFLAGS.
---
 Makefile.am | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile.am b/Makefile.am
index 3af43e118..057dab7f8 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -219,7 +219,7 @@ src_bluetoothd_DEPENDENCIES = lib/libbluetooth-internal.la \
 
 src_bluetoothd_CPPFLAGS = $(AM_CPPFLAGS) -DBLUETOOTH_PLUGIN_BUILTIN \
 					-DPLUGINDIR=\""$(build_plugindir)"\" \
-					$(builtin_cppflags)
+					$(BACKTRACE_CFLAGS) $(builtin_cppflags)
 src_bluetoothd_SHORTNAME = bluetoothd
 
 builtin_files = src/builtin.h $(builtin_nodist)
-- 
2.19.1

