Return-Path: <SRS0=NumT=SO=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC7D7C10F0E
	for <linux-bluetooth@archiver.kernel.org>; Fri, 12 Apr 2019 14:08:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 867612186A
	for <linux-bluetooth@archiver.kernel.org>; Fri, 12 Apr 2019 14:08:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbfDLOIK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 12 Apr 2019 10:08:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:52794 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726327AbfDLOIK (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 12 Apr 2019 10:08:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id F33C0AD72
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 Apr 2019 14:08:08 +0000 (UTC)
From:   Ludwig Nussel <ludwig.nussel@suse.de>
To:     linux-bluetooth@vger.kernel.org
Cc:     Ludwig Nussel <ludwig.nussel@suse.de>
Subject: [PATCH] Fix cups backend location
Date:   Fri, 12 Apr 2019 16:08:03 +0200
Message-Id: <20190412140803.28622-1-ludwig.nussel@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 Makefile.tools | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Makefile.tools b/Makefile.tools
index 7d5361bcd..9f8a0b87b 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -436,7 +436,10 @@ endif
 endif
 
 if CUPS
-cupsdir = $(libdir)/cups/backend
+# need to use upstream location here which is $exec_prefix/lib/cups/backend, see
+# https://github.com/apple/cups/blob/master/config-scripts/cups-directories.m4
+# https://github.com/apple/cups/blob/master/backend/Makefile
+cupsdir = $(exec_prefix)/lib/cups/backend
 
 cups_PROGRAMS = profiles/cups/bluetooth
 
-- 
2.16.4

