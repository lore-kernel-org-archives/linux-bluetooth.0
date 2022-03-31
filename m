Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A03CDC433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 31 Mar 2022 18:27:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234311AbiCaS25 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 31 Mar 2022 14:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233699AbiCaS24 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 31 Mar 2022 14:28:56 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD62013E3D
        for <linux-bluetooth@vger.kernel.org>; Thu, 31 Mar 2022 11:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648751228; x=1680287228;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LcfR5UXD/v4QWZxPx+c2UlqvgDRa+5hDv+XNCt9r9Xw=;
  b=XsVDO6gpqrYmA4tax6eR0WGXAbq4SeOC7pSBRD9t8FIkQf3uSQPMNu0n
   52ctPLLtixw7JE43tqaIBhoLbUuUYCk3MRG1nNCsY0Ptzc5/DdyXh6s4y
   rWqMZvrtVDskoZThQST18IUBxI8KUaG67SXelC81NRWFPu3WHaiZR2qaU
   ybwwLfaom6ifqgcDyoU87BiMuPNz3w8W7yYVVRW9qelfcC9msP2SMgZ1J
   PqdvCv7kvCGNN+ZI6F9nwAHkl7KyzVn3beYjR2E7sdwr2KISfCdsLSHwk
   1FEK1oMu3NaPOgTPyxQLy4C/S1CqXxHsD8SudsNvoqX4wZf8Gsxia/TZw
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10302"; a="239843230"
X-IronPort-AV: E=Sophos;i="5.90,225,1643702400"; 
   d="scan'208";a="239843230"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2022 11:27:04 -0700
X-IronPort-AV: E=Sophos;i="5.90,225,1643702400"; 
   d="scan'208";a="520744393"
Received: from vpareek-mobl1.amr.corp.intel.com (HELO bgi1-mobl2.amr.corp.intel.com) ([10.212.135.212])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2022 11:27:03 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     marcel@holtmann.org, luiz.dentz@gmail.com, brian.gix@intel.com
Subject: [PATCH BlueZ 2/2] mgmt-tester: Adds turning on Mesh Experimental feature
Date:   Thu, 31 Mar 2022 11:26:53 -0700
Message-Id: <20220331182653.465828-2-brian.gix@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220331182653.465828-1-brian.gix@intel.com>
References: <20220331182653.465828-1-brian.gix@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Turns on experimental Mesh feature, and expects it in report when
querying which experimental features are supported and have been
enabled.
---
 tools/mgmt-tester.c | 41 ++++++++++++++++++++++++++++++++++++++---
 1 file changed, 38 insertions(+), 3 deletions(-)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index e5319d123..475a4d43e 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -221,6 +221,32 @@ static void read_info_callback(uint8_t status, uint16_t length,
 	bthost_notify_ready(bthost, tester_pre_setup_complete);
 }
 
+static const uint8_t set_exp_feat_param_mesh[] = {
+	0x76, 0x6e, 0xf3, 0xe8, 0x24, 0x5f, 0x05, 0xbf, /* UUID - Mesh */
+	0x8d, 0x4d, 0x03, 0x7a, 0xd7, 0x63, 0xe4, 0x2c,
+	0x01,						/* Action - enable */
+};
+
+static void mesh_exp_callback(uint8_t status, uint16_t length,
+					const void *param, void *user_data)
+{
+	if (status != MGMT_STATUS_SUCCESS) {
+		tester_print("Mesh feature could not be enabled");
+		return;
+	}
+
+	tester_print("Mesh feature is enabled");
+}
+
+static void mesh_exp_feature(struct test_data *data, uint16_t index)
+{
+	tester_print("Enabling Mesh feature");
+
+	mgmt_send(data->mgmt, MGMT_OP_SET_EXP_FEATURE, index,
+		  sizeof(set_exp_feat_param_mesh), set_exp_feat_param_mesh,
+		  mesh_exp_callback, NULL, NULL);
+}
+
 static void index_added_callback(uint16_t index, uint16_t length,
 					const void *param, void *user_data)
 {
@@ -233,6 +259,10 @@ static void index_added_callback(uint16_t index, uint16_t length,
 
 	mgmt_send(data->mgmt, MGMT_OP_READ_INFO, data->mgmt_index, 0, NULL,
 					read_info_callback, NULL, NULL);
+
+	tester_warn("Enable management Mesh interface");
+	mesh_exp_feature(data, data->mgmt_index);
+
 }
 
 static void index_removed_callback(uint16_t index, uint16_t length,
@@ -387,6 +417,7 @@ static void read_index_list_callback(uint8_t status, uint16_t length,
 
 	if (test && test->setup_le_states)
 		hciemu_set_central_le_states(data->hciemu, test->le_states);
+
 }
 
 static void test_pre_setup(const void *test_data)
@@ -7324,7 +7355,7 @@ static void command_generic_callback(uint8_t status, uint16_t length,
 			expect_param = test->expect_func(&expect_len);
 
 		if (length != expect_len) {
-			tester_warn("Invalid cmd response parameter size");
+			tester_warn("Invalid cmd response parameter size %d %d", length, expect_len);
 			tester_test_failed();
 			return;
 		}
@@ -9798,7 +9829,7 @@ static const struct generic_data set_dev_flags_fail_3 = {
 };
 
 static const uint8_t read_exp_feat_param_success[] = {
-	0x03, 0x00,				/* Feature Count */
+	0x04, 0x00,				/* Feature Count */
 	0xd6, 0x49, 0xb0, 0xd1, 0x28, 0xeb,	/* UUID - Simultaneous */
 	0x27, 0x92, 0x96, 0x46, 0xc0, 0x42,	/* Central Peripheral */
 	0xb5, 0x10, 0x1b, 0x67,
@@ -9810,7 +9841,11 @@ static const uint8_t read_exp_feat_param_success[] = {
 	0xaf, 0x29, 0xc6, 0x66, 0xac, 0x5f,	/* UUID - Codec Offload */
 	0x1a, 0x88, 0xb9, 0x4f, 0x7f, 0xee,
 	0xce, 0x5a, 0x69, 0xa6,
-	0x00, 0x00, 0x00, 0x00			/* Flags */
+	0x00, 0x00, 0x00, 0x00,			/* Flags */
+	0x76, 0x6e, 0xf3, 0xe8, 0x24, 0x5f,	/* UUID - Mesh support */
+	0x05, 0xbf, 0x8d, 0x4d, 0x03, 0x7a,
+	0xd7, 0x63, 0xe4, 0x2c,
+	0x01, 0x00, 0x00, 0x00,			/* Flags */
 };
 
 static const struct generic_data read_exp_feat_success = {
-- 
2.35.1

