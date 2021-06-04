Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E6A6C4743C
	for <linux-bluetooth@archiver.kernel.org>; Fri,  4 Jun 2021 17:59:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 005FD61402
	for <linux-bluetooth@archiver.kernel.org>; Fri,  4 Jun 2021 17:59:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbhFDSBX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 4 Jun 2021 14:01:23 -0400
Received: from mga04.intel.com ([192.55.52.120]:26404 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229810AbhFDSBX (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 4 Jun 2021 14:01:23 -0400
IronPort-SDR: GFQb5GoifLJKwh58PlWNmQRa3CzoafnPr4nM3rBwUfC43HT7fVwV8OXclwO+VAikvRUI9VaorP
 sZHo/Svrt68Q==
X-IronPort-AV: E=McAfee;i="6200,9189,10005"; a="202482061"
X-IronPort-AV: E=Sophos;i="5.83,248,1616482800"; 
   d="scan'208";a="202482061"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2021 10:59:20 -0700
IronPort-SDR: Qc5xrIB+TaOODrzXHuMI9qy/NoTtd7vlsA0jPT4pixx5PsYost8WdZ8qAnGFVgmMtn/mbII6mj
 xMIwt9WsAuCw==
X-IronPort-AV: E=Sophos;i="5.83,248,1616482800"; 
   d="scan'208";a="401033661"
Received: from beomtaek-mobl2.amr.corp.intel.com (HELO istotlan-desk.intel.com) ([10.212.156.80])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2021 10:59:20 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     luiz.dentz@gmail.com, tedd.an@intel.com,
        Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ v2] tools/mgmt-tester: Fix expected HCI command accounting
Date:   Fri,  4 Jun 2021 10:59:13 -0700
Message-Id: <20210604175913.256979-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This fixes test condition count in the expected HCI command
callback.

When the expected HCI opcode is detected, mark the condition
as done. Any subsequent HCI commands are ignored.

Without this fix, in couple of test cases where the expected HCI
command is detected more than once, the test may be erroneously
reported as a failure or prematurely declared as a success before
waiting on an expected MGMT event condition.

The test cases where this behavior is fixed:
Remove Ext Advertising - Success 1
Remove Ext Advertising - Success 2
---
 tools/mgmt-tester.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index c5073fe2b..6109883ad 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -52,6 +52,7 @@ struct test_data {
 	uint16_t mgmt_index;
 	struct hciemu *hciemu;
 	enum hciemu_type hciemu_type;
+	bool expect_hci_command_done;
 	int unmet_conditions;
 	int unmet_setup_conditions;
 	int sk;
@@ -7021,9 +7022,11 @@ static void command_hci_callback(uint16_t opcode, const void *param,
 
 	tester_print("HCI Command 0x%04x length %u", opcode, length);
 
-	if (opcode != test->expect_hci_command || data->unmet_conditions <= 0)
+	if (opcode != test->expect_hci_command || data->expect_hci_command_done)
 		return;
 
+	data->expect_hci_command_done = true;
+
 	if (test->expect_hci_func)
 		expect_hci_param = test->expect_hci_func(&expect_hci_len);
 
-- 
2.26.3

