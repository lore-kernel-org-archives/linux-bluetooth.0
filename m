Return-Path: <SRS0=c51M=WD=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D449C32751
	for <linux-bluetooth@archiver.kernel.org>; Wed,  7 Aug 2019 06:47:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 159C321BF2
	for <linux-bluetooth@archiver.kernel.org>; Wed,  7 Aug 2019 06:47:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbfHGGrx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 7 Aug 2019 02:47:53 -0400
Received: from mga06.intel.com ([134.134.136.31]:3495 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727105AbfHGGrx (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 7 Aug 2019 02:47:53 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Aug 2019 23:47:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,356,1559545200"; 
   d="scan'208";a="182194363"
Received: from ingas-nuc1.sea.intel.com ([10.254.176.241])
  by FMSMGA003.fm.intel.com with ESMTP; 06 Aug 2019 23:47:53 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, luiz.dentz@gmail.com,
        Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 2/2] shared/shell: Add "clear-history" API
Date:   Tue,  6 Aug 2019 23:47:47 -0700
Message-Id: <20190807064747.6725-3-inga.stotland@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190807064747.6725-1-inga.stotland@intel.com>
References: <20190807064747.6725-1-inga.stotland@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Thsi adds a new API function bt_shell_clear_history(). The
function can be used to clear up the command history, when
it gets too cluttered.
---
 src/shared/shell-ell.c | 5 +++++
 src/shared/shell.c     | 7 ++++++-
 src/shared/shell.h     | 1 +
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/src/shared/shell-ell.c b/src/shared/shell-ell.c
index 1b481e04e..1e3de521c 100644
--- a/src/shared/shell-ell.c
+++ b/src/shared/shell-ell.c
@@ -1318,3 +1318,8 @@ void *bt_shell_get_env(const char *name)
 
 	return env->value;
 }
+
+void bt_shell_clear_history(void)
+{
+	rl_clear_history();
+}
diff --git a/src/shared/shell.c b/src/shared/shell.c
index eac654f40..86f9b71df 100644
--- a/src/shared/shell.c
+++ b/src/shared/shell.c
@@ -2,7 +2,7 @@
  *
  *  BlueZ - Bluetooth protocol stack for Linux
  *
- *  Copyright (C) 2017  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2017-2019  Intel Corporation. All rights reserved.
  *
  *
  *  This library is free software; you can redistribute it and/or
@@ -1328,3 +1328,8 @@ void *bt_shell_get_env(const char *name)
 
 	return env->value;
 }
+
+void bt_shell_clear_history(void)
+{
+	rl_clear_history();
+}
diff --git a/src/shared/shell.h b/src/shared/shell.h
index e14d58381..9ba4a20c8 100644
--- a/src/shared/shell.h
+++ b/src/shared/shell.h
@@ -94,4 +94,5 @@ bool bt_shell_detach(void);
 void bt_shell_set_env(const char *name, void *value);
 void *bt_shell_get_env(const char *name);
 
+void bt_shell_clear_history(void);
 void bt_shell_cleanup(void);
-- 
2.21.0

