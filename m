Return-Path: <SRS0=yWLZ=OE=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47FD6C43610
	for <linux-bluetooth@archiver.kernel.org>; Sun, 25 Nov 2018 09:20:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 194B720865
	for <linux-bluetooth@archiver.kernel.org>; Sun, 25 Nov 2018 09:20:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 194B720865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inai.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727551AbeKYUKy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 25 Nov 2018 15:10:54 -0500
Received: from a3.inai.de ([88.198.85.195]:54008 "EHLO a3.inai.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727536AbeKYUKy (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 25 Nov 2018 15:10:54 -0500
Received: by a3.inai.de (Postfix, from userid 65534)
        id EDE10F8B21; Sun, 25 Nov 2018 10:20:14 +0100 (CET)
Received: from a4.inai.de (a4.inai.de [IPv6:2a01:4f8:222:6c9::f8])
        by a3.inai.de (Postfix) with ESMTP id CDDDBF8B16;
        Sun, 25 Nov 2018 10:20:13 +0100 (CET)
From:   Jan Engelhardt <jengelh@inai.de>
To:     luiz.dentz@gmail.com
Cc:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/8] build: rename includedir to pkgincludedir
Date:   Sun, 25 Nov 2018 10:20:05 +0100
Message-Id: <20181125092012.8001-2-jengelh@inai.de>
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

This change is similar to commit 5.50-130-g78bce4800 and does the
same, but for includedir.
---
 Makefile.am | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index d4f4572d5..e63c72def 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -23,9 +23,9 @@ pkglibexecdir = @libexecdir@/bluetooth
 
 libexec_PROGRAMS =
 
-includedir = @includedir@/bluetooth
+pkgincludedir = @includedir@/bluetooth
 
-include_HEADERS =
+pkginclude_HEADERS =
 
 AM_CFLAGS = $(WARNING_CFLAGS) $(MISC_CFLAGS)
 AM_LDFLAGS = $(MISC_LDFLAGS)
@@ -75,7 +75,7 @@ local_headers = $(foreach file,$(lib_headers), lib/bluetooth/$(notdir $(file)))
 BUILT_SOURCES = $(local_headers) src/builtin.h
 
 if LIBRARY
-include_HEADERS += $(lib_headers)
+pkginclude_HEADERS += $(lib_headers)
 
 lib_LTLIBRARIES += lib/libbluetooth.la
 
-- 
2.19.1

