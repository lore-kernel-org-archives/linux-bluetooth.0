Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2E67ECAAD3
	for <linux-bluetooth@archiver.kernel.org>; Thu,  1 Sep 2022 20:05:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232332AbiIAUFM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 1 Sep 2022 16:05:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231650AbiIAUFM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 1 Sep 2022 16:05:12 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A65B246DB9
        for <linux-bluetooth@vger.kernel.org>; Thu,  1 Sep 2022 13:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662062710; x=1693598710;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=fHFIo3DN93J2bq97ZMY4/7VqYXOFBrGYFMEZf0Q9Mss=;
  b=oEpsqurYd+7yCb3ym0qHkGShj2xn4sBM+pfhGkwluS+53uOo7e9pKkrE
   n3W9IXqI6pk8KOcbrJOjIQebtBLoSVpa0yoHMiPgaP+sPvnsYy1JlEbAE
   ZPUoIF8fZpEpbWACNR4n195J1Lz6pvFTgfzHsz8krRSHO56HTmuue6qOC
   TO1hz4+KTw/VK+5QTkIFBMm04QJfZ2O00aOzt7bkMSkfaSOFNtaaFi7VD
   8XJZRGYREvdGnKN93TRy/6erCbH2FTwc6FVV6cdYkBU2w4FgTX7myB+GJ
   eB4kWGdcRjY0mZBjSTrM1tpCGgTBVojNHwiRrcpwo++4knc2QBr7uOG/c
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10457"; a="282801955"
X-IronPort-AV: E=Sophos;i="5.93,281,1654585200"; 
   d="scan'208";a="282801955"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 13:05:10 -0700
X-IronPort-AV: E=Sophos;i="5.93,281,1654585200"; 
   d="scan'208";a="612641097"
Received: from ghonawax-mobl.amr.corp.intel.com (HELO bgi1-mobl2.amr.corp.intel.com) ([10.212.58.197])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 13:05:10 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     marcel@holtmann.org, luiz.dentz@gmail.com, brian.gix@intel.com
Subject: [PATCH BlueZ] mgmt-tester: Adds turning on Mesh Experimental feature
Date:   Thu,  1 Sep 2022 13:05:01 -0700
Message-Id: <20220901200501.27858-1-brian.gix@intel.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Turns on experimental Mesh feature, and expects it in report when
querying which experimental features are supported and have been
enabled.
---
 tools/mgmt-tester.c | 39 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 37 insertions(+), 2 deletions(-)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index 02ddfd844..04890ba6f 100644
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
@@ -388,6 +418,7 @@ static void read_index_list_callback(uint8_t status, uint16_t length,
 
 	if (test && test->setup_le_states)
 		hciemu_set_central_le_states(data->hciemu, test->le_states);
+
 }
 
 static void test_pre_setup(const void *test_data)
@@ -7390,7 +7421,7 @@ static void command_generic_callback(uint8_t status, uint16_t length,
 			expect_param = test->expect_func(&expect_len);
 
 		if (length != expect_len) {
-			tester_warn("Invalid cmd response parameter size");
+			tester_warn("Invalid cmd response parameter size %d %d", length, expect_len);
 			tester_test_failed();
 			return;
 		}
@@ -9858,7 +9889,7 @@ static const struct generic_data set_dev_flags_fail_3 = {
 };
 
 static const uint8_t read_exp_feat_param_success[] = {
-	0x04, 0x00,				/* Feature Count */
+	0x05, 0x00,				/* Feature Count */
 	0xd6, 0x49, 0xb0, 0xd1, 0x28, 0xeb,	/* UUID - Simultaneous */
 	0x27, 0x92, 0x96, 0x46, 0xc0, 0x42,	/* Central Peripheral */
 	0xb5, 0x10, 0x1b, 0x67,
@@ -9875,6 +9906,10 @@ static const uint8_t read_exp_feat_param_success[] = {
 	0x85, 0x98, 0x6a, 0x49, 0xe0, 0x05,
 	0x88, 0xf1, 0xba, 0x6f,
 	0x00, 0x00, 0x00, 0x00,			/* Flags */
+	0x76, 0x6e, 0xf3, 0xe8, 0x24, 0x5f,	/* UUID - Mesh support */
+	0x05, 0xbf, 0x8d, 0x4d, 0x03, 0x7a,
+	0xd7, 0x63, 0xe4, 0x2c,
+	0x01, 0x00, 0x00, 0x00,			/* Flags */
 };
 
 static const struct generic_data read_exp_feat_success = {
-- 
2.37.2

