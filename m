Return-Path: <SRS0=5U9h=TX=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A57CC282DE
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 May 2019 12:28:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1033C20851
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 May 2019 12:28:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730046AbfEWM2O (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 23 May 2019 08:28:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:35108 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729902AbfEWM2O (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 23 May 2019 08:28:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 951E2ADDD
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 May 2019 12:28:13 +0000 (UTC)
From:   Ludwig Nussel <ludwig.nussel@suse.de>
To:     linux-bluetooth@vger.kernel.org
Cc:     Ludwig Nussel <ludwig.nussel@suse.de>
Subject: [PATCH v2] Fix cups backend location
Date:   Thu, 23 May 2019 14:28:05 +0200
Message-Id: <20190523122805.10235-1-ludwig.nussel@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The default upstream location for backends is
$exec_prefix/lib/cups/backend, see
https://github.com/apple/cups/blob/master/config-scripts/cups-directories.m4
https://github.com/apple/cups/blob/master/backend/Makefile
---
 Makefile.tools | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile.tools b/Makefile.tools
index 7d5361bcd..50cda54fb 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -436,7 +436,7 @@ endif
 endif
 
 if CUPS
-cupsdir = $(libdir)/cups/backend
+cupsdir = $(exec_prefix)/lib/cups/backend
 
 cups_PROGRAMS = profiles/cups/bluetooth
 
-- 
2.16.4

