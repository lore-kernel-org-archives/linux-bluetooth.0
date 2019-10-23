Return-Path: <SRS0=9nGc=YQ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14F5BCA9EAE
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Oct 2019 05:41:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC2312064A
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Oct 2019 05:41:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731524AbfJWFlV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 23 Oct 2019 01:41:21 -0400
Received: from mga04.intel.com ([192.55.52.120]:29048 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727885AbfJWFlV (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 23 Oct 2019 01:41:21 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Oct 2019 22:41:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,219,1569308400"; 
   d="scan'208";a="203863305"
Received: from afignato-mobl1.amr.corp.intel.com (HELO ingas-nuc1.sea.intel.com) ([10.252.128.87])
  by FMSMGA003.fm.intel.com with ESMTP; 22 Oct 2019 22:41:21 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     luiz.dentz@gmail.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ] shared/shell: Add prompt item to bt_shell_menu structure
Date:   Tue, 22 Oct 2019 22:41:19 -0700
Message-Id: <20191023054119.7712-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This allows to associate specific prompts with main menu
and submenus thus providing for better navigation when
submenus are in use.
---
 src/shared/shell.c | 3 +++
 src/shared/shell.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/src/shared/shell.c b/src/shared/shell.c
index cfdcc76c4..a821c8d0a 100644
--- a/src/shared/shell.c
+++ b/src/shared/shell.c
@@ -1226,6 +1226,9 @@ bool bt_shell_set_menu(const struct bt_shell_menu *menu)
 	if (!data.main)
 		data.main = menu;
 
+	if (menu->prompt)
+		bt_shell_set_prompt(menu->prompt);
+
 	return true;
 }
 
diff --git a/src/shared/shell.h b/src/shared/shell.h
index e14d58381..a9eee506f 100644
--- a/src/shared/shell.h
+++ b/src/shared/shell.h
@@ -53,6 +53,7 @@ struct bt_shell_menu_entry {
 struct bt_shell_menu {
 	const char *name;
 	const char *desc;
+	const char *prompt;
 	const struct bt_shell_menu_entry entries[];
 };
 
-- 
2.21.0

