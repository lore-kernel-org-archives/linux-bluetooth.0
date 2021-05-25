Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE6AFC2B9F8
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 May 2021 05:39:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88B346140E
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 May 2021 05:39:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbhEYFkm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 25 May 2021 01:40:42 -0400
Received: from mga04.intel.com ([192.55.52.120]:58412 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229621AbhEYFkm (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 25 May 2021 01:40:42 -0400
IronPort-SDR: 0J69OhRUvN6Xl26D7n6N3SibisoyWAwk7HRWLnE+wt7Qoh/+ivfTF6Kl1rpC87AiIaPOyQnSR8
 ZG+Rw8XBekkg==
X-IronPort-AV: E=McAfee;i="6200,9189,9994"; a="200207907"
X-IronPort-AV: E=Sophos;i="5.82,327,1613462400"; 
   d="scan'208";a="200207907"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2021 22:39:13 -0700
IronPort-SDR: srCLdOGQ/quM8mSMRWEgSVtuE5Wyu+EXg7mmUVLa6CP1ZSIoePwSH70d/lormDAzyyADHkrwC0
 T9O004OyIaKg==
X-IronPort-AV: E=Sophos;i="5.82,327,1613462400"; 
   d="scan'208";a="443175071"
Received: from rsiyer-mobl2.amr.corp.intel.com (HELO istotlan-desk.intel.com) ([10.212.132.70])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2021 22:39:13 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     luiz.dentz@gmail.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ] tools/mgmt-tester: Fix expected HCI command accounting
Date:   Mon, 24 May 2021 22:39:05 -0700
Message-Id: <20210525053905.53138-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This fixes test condition accounting in the expected HCI command
callback.

When the expected opcode has been detected, the test condition
is either marked as completed in case of passing the checks or the
test failure is reported. Any subsequent HCI commandis logged only as
informational and does not contribute towards test accounting.

Without the fix, in number of test cases where the expected HCI command
is detected more than once, the test condition countdown goes into
negative numbers or the test is erroneously reported as failed.
---
 tools/mgmt-tester.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index c9de770c1..22b6a3387 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -6882,6 +6882,22 @@ static void command_setup_hci_callback(uint16_t opcode, const void *param,
 	test_setup_condition_complete(data);
 }
 
+static void command_hci_plus_callback(uint16_t opcode, const void *param,
+					uint8_t length, void *user_data)
+{
+	tester_print("Post HCI Command 0x%04x length %u", opcode, length);
+}
+
+static gboolean hci_command_idle(void *user_data)
+{
+	struct test_data *data = user_data;
+
+	hciemu_clear_master_post_command_hooks(data->hciemu);
+	hciemu_add_master_post_command_hook(data->hciemu,
+					command_hci_plus_callback, data);
+	return FALSE;
+}
+
 static void command_hci_callback(uint16_t opcode, const void *param,
 					uint8_t length, void *user_data)
 {
@@ -6896,6 +6912,8 @@ static void command_hci_callback(uint16_t opcode, const void *param,
 	if (opcode != test->expect_hci_command || data->unmet_conditions <= 0)
 		return;
 
+	g_idle_add(hci_command_idle, data);
+
 	if (test->expect_hci_func)
 		expect_hci_param = test->expect_hci_func(&expect_hci_len);
 
-- 
2.26.3

