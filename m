Return-Path: <SRS0=NtgA=26=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8902BC282DD
	for <linux-bluetooth@archiver.kernel.org>; Thu,  9 Jan 2020 17:44:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67FED20678
	for <linux-bluetooth@archiver.kernel.org>; Thu,  9 Jan 2020 17:44:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388250AbgAIRoQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 9 Jan 2020 12:44:16 -0500
Received: from mga11.intel.com ([192.55.52.93]:29106 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731894AbgAIRoP (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 9 Jan 2020 12:44:15 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Jan 2020 09:44:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,414,1571727600"; 
   d="scan'208";a="211967107"
Received: from ingas-nuc1.sea.intel.com ([10.254.104.252])
  by orsmga007.jf.intel.com with ESMTP; 09 Jan 2020 09:44:15 -0800
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ] tools/mesh: Fix check condition for model ID
Date:   Thu,  9 Jan 2020 09:44:09 -0800
Message-Id: <20200109174409.18135-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Use the value of VENDOR_ID_MASK to set/check vendor model
and SIG model IDs
---
 tools/mesh/cfgcli.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/mesh/cfgcli.c b/tools/mesh/cfgcli.c
index 1fcf82035..2403c9293 100644
--- a/tools/mesh/cfgcli.c
+++ b/tools/mesh/cfgcli.c
@@ -247,7 +247,7 @@ static uint32_t print_mod_id(uint8_t *data, bool vid, const char *offset)
 	if (!vid) {
 		mod_id = get_le16(data);
 		bt_shell_printf("%sModel Id\t%4.4x\n", offset, mod_id);
-		mod_id = 0xffff0000 | mod_id;
+		mod_id = VENDOR_ID_MASK | mod_id;
 	} else {
 		mod_id = get_le16(data + 2);
 		bt_shell_printf("%sModel Id\t%4.4x %4.4x\n", offset,
@@ -327,7 +327,7 @@ static void print_pub(uint16_t ele_addr, uint32_t mod_id,
 	bt_shell_printf("\tElement: %4.4x\n", ele_addr);
 	bt_shell_printf("\tPub Addr: %4.4x\n", pub->u.addr16);
 
-	if (mod_id > 0xffff0000)
+	if (mod_id < VENDOR_ID_MASK)
 		bt_shell_printf("\tModel: %8.8x\n", mod_id);
 	else
 		bt_shell_printf("\tModel: %4.4x\n",
-- 
2.21.1

