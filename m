Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA9FBC47083
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Jun 2021 00:04:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B5F8613EC
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Jun 2021 00:04:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbhFCAGM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 2 Jun 2021 20:06:12 -0400
Received: from mga09.intel.com ([134.134.136.24]:50742 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229553AbhFCAGM (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 2 Jun 2021 20:06:12 -0400
IronPort-SDR: 5qMFaoqgB+P2kZqOs9kVQcDFnkImPSVcaWnQh5qKTK0yCswgtFZFSrI5igQ5eis7V0z9PtYxBd
 12A8s4IWe0vg==
X-IronPort-AV: E=McAfee;i="6200,9189,10003"; a="203920475"
X-IronPort-AV: E=Sophos;i="5.83,244,1616482800"; 
   d="scan'208";a="203920475"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2021 17:04:25 -0700
IronPort-SDR: G8jZFPImMsuxZ5EZloRymovYIcCOmEE2B4vHXPZ7oJXaJLJRIT7cuqFSe7/hFnHJH9oayAVEhQ
 EQomb5ZGoQHw==
X-IronPort-AV: E=Sophos;i="5.83,244,1616482800"; 
   d="scan'208";a="483240053"
Received: from rsurapan-mobl2.amr.corp.intel.com (HELO istotlan-desk.intel.com) ([10.209.86.49])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2021 17:04:24 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     luiz.dentz@gmail.com, tedd.an@linux.intel.com,
        Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 1/2] tools/mgmt-tester: Adjust test setup complete check
Date:   Wed,  2 Jun 2021 17:04:15 -0700
Message-Id: <20210603000416.171392-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This changes check for setup complete in client_cmd_complete() callback
from tester_setup_complete() to test_setup_condition_complete(). This
allows for combining setup conditions when setup_bthost() is called.
---
 tools/mgmt-tester.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index 4dd3490c2..657b7aaa0 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -5831,7 +5831,7 @@ static void client_cmd_complete(uint16_t opcode, uint8_t status,
 	if (status)
 		tester_setup_failed();
 	else
-		tester_setup_complete();
+		test_setup_condition_complete(data);
 }
 
 static void setup_bthost(void)
@@ -5842,6 +5842,7 @@ static void setup_bthost(void)
 
 	bthost = hciemu_client_get_host(data->hciemu);
 	bthost_set_cmd_complete_cb(bthost, client_cmd_complete, data);
+	test_add_setup_condition(data);
 
 	if (data->hciemu_type == HCIEMU_TYPE_LE ||
 		test->client_enable_adv) {
-- 
2.26.3

