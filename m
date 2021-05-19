Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAE16C433ED
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 May 2021 21:19:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC29D6124C
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 May 2021 21:19:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbhESVUj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 19 May 2021 17:20:39 -0400
Received: from mga12.intel.com ([192.55.52.136]:43278 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229465AbhESVUh (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 19 May 2021 17:20:37 -0400
IronPort-SDR: TASiqDj0fp8HaWeC8jBYDa2nhIRIg/r0vh5DOLvF+p6Xiqbm5gjpEKqFzrrwAnPXLRrT54B5oj
 vOtOqcRFneZw==
X-IronPort-AV: E=McAfee;i="6200,9189,9989"; a="180682519"
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="180682519"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2021 14:19:15 -0700
IronPort-SDR: 4NWBzmWhXBx2kWK1uLviTaboJSl8JQYZOdYmGvy5oN41Fv9mBtdxO57yrg+osHrkbUKFx0McxP
 32RDKLW5r3kA==
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="612576429"
Received: from akenaman-mobl.amr.corp.intel.com (HELO istotlan-desk.intel.com) ([10.212.181.147])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2021 14:19:15 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     luiz.dentz@gmail.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ] tools/mgmt-tester: Fix "Remove Ext Advertising" case
Date:   Wed, 19 May 2021 14:19:07 -0700
Message-Id: <20210519211907.157397-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This fixes the expected behavior of the following test case:
"Remove Ext Advertising - Success 1", when the fail status
was erroneously overwritten with success:

<log snip>
  New Advertising Removed event received
  Test condition complete, 2 left
  HCI Command 0x2039 length 6
  Invalid parameter size for HCI command
Remove Ext Advertising - Success 1 - test failed
  HCI Command 0x203c length 1
  HCI Command 0x2039 length 2
  Test condition complete, 1 left
  Remove Advertising (0x003f): Success (0x00)
  Test condition complete, 0 left
Remove Ext Advertising - Success 1 - test passed

The expected HCI command to disable extended advertisement for a
non-zero number of sets should contain the specified number the
advertising sets.
In this particular test case, number of sets is set to 1 and,
as a result, the expected HCI command should be:
"00      | 01             | 01 00 00 00"
 disable | number of sets | set info

Also, to avoid false positives/negatives, skip exmination of HCI
commands after the test conditions are met.
---
 tools/mgmt-tester.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index de35008ad..1b9dc0445 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -6671,7 +6671,7 @@ static void command_hci_callback(uint16_t opcode, const void *param,
 
 	tester_print("HCI Command 0x%04x length %u", opcode, length);
 
-	if (opcode != test->expect_hci_command)
+	if (opcode != test->expect_hci_command || data->unmet_conditions <= 0)
 		return;
 
 	if (test->expect_hci_func)
@@ -7720,6 +7720,10 @@ static const char set_ext_adv_disable_param[] = {
 	0x00, 0x00,
 };
 
+static const char set_ext_adv_disable_param_1[] = {
+	0x00, 0x01, 0x01, 0x00, 0x00, 0x00
+};
+
 static const struct generic_data add_ext_advertising_timeout_expired = {
 	.expect_alt_ev = MGMT_EV_ADVERTISING_REMOVED,
 	.expect_alt_ev_param = advertising_instance1_param,
@@ -7747,8 +7751,8 @@ static const struct generic_data remove_ext_advertising_success_1 = {
 	.expect_alt_ev_param = advertising_instance1_param,
 	.expect_alt_ev_len = sizeof(advertising_instance1_param),
 	.expect_hci_command = BT_HCI_CMD_LE_SET_EXT_ADV_ENABLE,
-	.expect_hci_param = set_ext_adv_disable_param,
-	.expect_hci_len = sizeof(set_ext_adv_disable_param),
+	.expect_hci_param = set_ext_adv_disable_param_1,
+	.expect_hci_len = sizeof(set_ext_adv_disable_param_1),
 };
 
 static const struct generic_data remove_ext_advertising_success_2 = {
-- 
2.26.3

