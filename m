Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DBCAC433B4
	for <linux-bluetooth@archiver.kernel.org>; Thu, 13 May 2021 00:46:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62A0E61405
	for <linux-bluetooth@archiver.kernel.org>; Thu, 13 May 2021 00:46:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236441AbhEMArM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 12 May 2021 20:47:12 -0400
Received: from mga05.intel.com ([192.55.52.43]:60845 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345535AbhEMAqv (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 12 May 2021 20:46:51 -0400
IronPort-SDR: ZTY4aglVU43ZyFnnElfL1MNAOy/ruGRTDeV9t3P3K6/P06VQBgK4HK22ceksMBP92srk792Ci2
 mJY1PoRHwirQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9982"; a="285341982"
X-IronPort-AV: E=Sophos;i="5.82,295,1613462400"; 
   d="scan'208";a="285341982"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2021 17:39:18 -0700
IronPort-SDR: 9dTMm1KKhnLv0ijM/aKMA2o3EOHEmQ3HmADHiwHdpa1rdjW8KOonG9R8e0NWwY1sjqKxQ7DlqC
 Yy85gL2BUHjg==
X-IronPort-AV: E=Sophos;i="5.82,295,1613462400"; 
   d="scan'208";a="623015197"
Received: from scmahvi-mobl.amr.corp.intel.com (HELO istotlan-desk.intel.com) ([10.254.1.126])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2021 17:39:16 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ] shared/shell: Print help info for individual commands
Date:   Wed, 12 May 2021 17:39:09 -0700
Message-Id: <20210513003909.104379-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

For menus with long list of entries, it is useful to be able invoke
help message for an individual entry to look up command description and
synopsis.
Can be invoked by entering "<command> help" or "<command> --help".
---
 src/shared/shell.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/src/shared/shell.c b/src/shared/shell.c
index c0de1640d..07eaa1702 100644
--- a/src/shared/shell.c
+++ b/src/shared/shell.c
@@ -352,6 +352,16 @@ static int cmd_exec(const struct bt_shell_menu_entry *entry,
 	int flags = WRDE_NOCMD;
 	bool optargs = false;
 
+	if (argc == 2 && (!memcmp(argv[1], "help", 4) ||
+				!memcmp(argv[1], "--help", 6))) {
+		printf("%s\n", entry->desc);
+		printf(COLOR_HIGHLIGHT "Usage:" COLOR_OFF "\n");
+		printf("\t %s %-*s\n", entry->cmd,
+				(int)(CMD_LENGTH - strlen(entry->cmd)),
+					!entry->arg ? "" : entry->arg);
+		return 0;
+	}
+
 	if (!entry->arg || entry->arg[0] == '\0') {
 		if (argc > 1) {
 			print_text(COLOR_HIGHLIGHT, "Too many arguments");
-- 
2.26.3

