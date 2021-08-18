Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E463C4338F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 18 Aug 2021 18:31:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B55060E90
	for <linux-bluetooth@archiver.kernel.org>; Wed, 18 Aug 2021 18:31:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbhHRScE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 18 Aug 2021 14:32:04 -0400
Received: from mga18.intel.com ([134.134.136.126]:61249 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229448AbhHRScD (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 18 Aug 2021 14:32:03 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10080"; a="203544286"
X-IronPort-AV: E=Sophos;i="5.84,332,1620716400"; 
   d="scan'208";a="203544286"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2021 11:31:23 -0700
X-IronPort-AV: E=Sophos;i="5.84,332,1620716400"; 
   d="scan'208";a="441966658"
Received: from shebburs-mobl1.amr.corp.intel.com (HELO bgi1-mobl2.amr.corp.intel.com) ([10.209.60.53])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2021 11:31:22 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     luiz.dentz@gmail.com, brian.gix@intel.com,
        luiz.von.dentz@intel.com, hj.tedd.an@gmail.com
Subject: [PATCH BlueZ] tools/mgmt-tester: Add Read OOB Ext Data test cases
Date:   Wed, 18 Aug 2021 11:31:08 -0700
Message-Id: <20210818183108.1636030-1-brian.gix@intel.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Read Local OOB Ext Data - Invalid index
Read Local OOB Ext Data - Legacy pairing
Read Local OOB Ext Data - Success SSP
Read Local OOB Ext Data - Success SC
---
 tools/mgmt-tester.c | 50 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index 504dc1497..3dcf4f319 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -5238,6 +5238,44 @@ static const struct generic_data read_local_oob_success_sc_test = {
 	.expect_hci_command = BT_HCI_CMD_READ_LOCAL_OOB_EXT_DATA,
 };
 
+static const uint8_t oob_type_bredr[] = { 0x01 };
+static const struct generic_data read_local_oob_ext_invalid_index_test = {
+	.send_index_none = true,
+	.send_opcode = MGMT_OP_READ_LOCAL_OOB_EXT_DATA,
+	.send_param = oob_type_bredr,
+	.send_len = sizeof(oob_type_bredr),
+	.expect_status = MGMT_STATUS_INVALID_INDEX,
+};
+
+static const struct generic_data read_local_oob_ext_legacy_pairing_test = {
+	.setup_settings = settings_powered,
+	.send_opcode = MGMT_OP_READ_LOCAL_OOB_EXT_DATA,
+	.send_param = oob_type_bredr,
+	.send_len = sizeof(oob_type_bredr),
+	.expect_ignore_param = true,
+	.expect_status = MGMT_STATUS_NOT_SUPPORTED,
+};
+
+static const struct generic_data read_local_oob_ext_success_ssp_test = {
+	.setup_settings = settings_powered_ssp,
+	.send_opcode = MGMT_OP_READ_LOCAL_OOB_EXT_DATA,
+	.send_param = oob_type_bredr,
+	.send_len = sizeof(oob_type_bredr),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_ignore_param = true,
+	.expect_hci_command = BT_HCI_CMD_READ_LOCAL_OOB_DATA,
+};
+
+static const struct generic_data read_local_oob_ext_success_sc_test = {
+	.setup_settings = settings_powered_sc,
+	.send_opcode = MGMT_OP_READ_LOCAL_OOB_EXT_DATA,
+	.send_param = oob_type_bredr,
+	.send_len = sizeof(oob_type_bredr),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_ignore_param = true,
+	.expect_hci_command = BT_HCI_CMD_READ_LOCAL_OOB_EXT_DATA,
+};
+
 static const uint8_t le_states_conn_slave_adv_connectable[] = {
 			0x00, 0x00, 0x20, 0x00, 0x40, 0x00, 0x00, 0x00};
 static const uint8_t le_states_conn_slave_adv_non_connectable[] = {
@@ -12026,6 +12064,18 @@ int main(int argc, char *argv[])
 	test_bredrle("Read Local OOB Data - Success SC",
 				&read_local_oob_success_sc_test,
 				NULL, test_command_generic);
+	test_bredrle("Read Local OOB Ext Data - Invalid index",
+				&read_local_oob_ext_invalid_index_test,
+				NULL, test_command_generic);
+	test_bredr20("Read Local OOB Ext Data - Legacy pairing",
+				&read_local_oob_ext_legacy_pairing_test,
+				NULL, test_command_generic);
+	test_bredrle("Read Local OOB Ext Data - Success SSP",
+				&read_local_oob_ext_success_ssp_test,
+				NULL, test_command_generic);
+	test_bredrle("Read Local OOB Ext Data - Success SC",
+				&read_local_oob_ext_success_sc_test,
+				NULL, test_command_generic);
 
 	test_bredrle("Device Found - Advertising data - Zero padded",
 				&device_found_gtag,
-- 
2.31.1

