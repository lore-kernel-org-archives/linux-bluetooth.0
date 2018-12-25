Return-Path: <SRS0=w8R0=PC=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NORMAL_HTTP_TO_IP,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 221CDC64E79
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 Dec 2018 02:36:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5E6D218B0
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 Dec 2018 02:36:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725817AbeLYCgo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 24 Dec 2018 21:36:44 -0500
Received: from mail.windriver.com ([147.11.1.11]:40126 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725806AbeLYCgo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 24 Dec 2018 21:36:44 -0500
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
        by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id wBP2aco6001788
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Dec 2018 18:36:38 -0800 (PST)
Received: from ala-blade47.wrs.com (147.11.105.67) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.50) with Microsoft SMTP Server id 14.3.408.0; Mon, 24 Dec 2018
 18:36:38 -0800
From:   Robert Yang <liezhi.yang@windriver.com>
To:     <linux-bluetooth@vger.kernel.org>
Subject: [PATCH] Makefile.am: Fix a race issue for tools
Date:   Mon, 24 Dec 2018 18:36:38 -0800
Message-ID: <20181225023638.3275-1-liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.10.2
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Fixed a race issue when do parallel build:
cp ../bluez-5.50/tools/hid2hci.rules tools/97-hid2hci.rules
cp: cannot create regular file tools/97-hid2hci.rules: No such file or directory
make[1]: *** [tools/97-hid2hci.rules] Error 1

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 Makefile.am | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Makefile.am b/Makefile.am
index f84a1fa..9db1573 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -570,6 +570,7 @@ src/builtin.h: src/genbuiltin $(builtin_sources)
 	$(AM_V_GEN)$(srcdir)/src/genbuiltin $(builtin_modules) > $@
 
 tools/%.rules:
+	[ -e tools ] || $(MKDIR_P) tools
 	$(AM_V_GEN)cp $(srcdir)/$(subst 97-,,$@) $@
 
 $(lib_libbluetooth_la_OBJECTS): $(local_headers)
-- 
2.10.2

