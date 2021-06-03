Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 863AEC4708F
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Jun 2021 00:04:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C5E960E0C
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Jun 2021 00:04:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbhFCAGM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 2 Jun 2021 20:06:12 -0400
Received: from mga09.intel.com ([134.134.136.24]:50742 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229541AbhFCAGL (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 2 Jun 2021 20:06:11 -0400
IronPort-SDR: ePayiVbc+qnbr0DtkDts9Th8k6f185Da0XP4Oe6xDBi1qMknNHrtv+XwKulgKH47HzVohFDfF8
 zOw+0NsKvPsQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10003"; a="203920483"
X-IronPort-AV: E=Sophos;i="5.83,244,1616482800"; 
   d="scan'208";a="203920483"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2021 17:04:27 -0700
IronPort-SDR: yPFhDkBr8ewiakuM7PgT6g4dRkLA8HcmCehbxIrCKKSuLbojVj3l+ao2lNdTmDVQEewvk+Xwom
 SJv60VsZBPtQ==
X-IronPort-AV: E=Sophos;i="5.83,244,1616482800"; 
   d="scan'208";a="483240058"
Received: from rsurapan-mobl2.amr.corp.intel.com (HELO istotlan-desk.intel.com) ([10.209.86.49])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2021 17:04:26 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     luiz.dentz@gmail.com, tedd.an@linux.intel.com,
        Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 2/2] tools/mgmt-tester: Add setup condition to resolve list
Date:   Wed,  2 Jun 2021 17:04:16 -0700
Message-Id: <20210603000416.171392-2-inga.stotland@intel.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210603000416.171392-1-inga.stotland@intel.com>
References: <20210603000416.171392-1-inga.stotland@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds expected setup HCI command condition to
"Start Discovery - Disable Resolve List" case.

Check that on setup HCI command Set LE Resolve Enable is complete
with "enable" parameter set to 1.
---
 tools/mgmt-tester.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index 657b7aaa0..d659d7eb0 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -2076,6 +2076,9 @@ static const struct generic_data start_discovery_ll_privacy_disable_resolv = {
 	.expect_status = MGMT_STATUS_SUCCESS,
 	.expect_param = start_discovery_le_param,
 	.expect_len = sizeof(start_discovery_le_param),
+	.setup_expect_hci_command = BT_HCI_CMD_LE_SET_RESOLV_ENABLE,
+	.setup_expect_hci_param = set_resolv_on_param,
+	.setup_expect_hci_len = sizeof(set_resolv_on_param),
 	.expect_hci_command = BT_HCI_CMD_LE_SET_RESOLV_ENABLE,
 	.expect_hci_param = set_resolv_off_param,
 	.expect_hci_len = sizeof(set_resolv_off_param),
@@ -9442,6 +9445,7 @@ static void setup_add_device_callback(uint8_t status, uint16_t length,
 static void setup_ll_privacy_device(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
+	const struct generic_data *test = data->test_data;
 	unsigned char param[] = { 0x01 };
 	const uint8_t *ext_feat_param;
 	size_t ext_feat_len;
@@ -9453,6 +9457,12 @@ static void setup_ll_privacy_device(const void *test_data)
 			0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08,
 			0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08 };
 
+	tester_print("Setup expected HCI command 0x%04x",
+					 test->setup_expect_hci_command);
+	hciemu_add_master_post_command_hook(data->hciemu,
+					command_setup_hci_callback, data);
+	test_add_setup_condition(data);
+
 	tester_print("Enabling LL Privacy feature");
 
 	ext_feat_param = set_exp_feat_param_ll_privacy;
-- 
2.26.3

