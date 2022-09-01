Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F1F7ECAAD2
	for <linux-bluetooth@archiver.kernel.org>; Thu,  1 Sep 2022 21:07:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234971AbiIAVHb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 1 Sep 2022 17:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231326AbiIAVHa (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 1 Sep 2022 17:07:30 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 344A97B291
        for <linux-bluetooth@vger.kernel.org>; Thu,  1 Sep 2022 14:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662066449; x=1693602449;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=cHd5b5ltfjOadtLJIyeuaCdABdvIpSn1/sVZ4x2Cb8g=;
  b=RgfmZiawl+l03XBkuWTBbMVhKlm7fEXpQyStZywwUHGCHRuCgCiHiyZj
   mxo7xrAqPrH1uA0RE1E1ID51Ndj0ENtHiz0qiuR9QbQ5pjyBx70IXzt1w
   OFEnYe0rLUO6axBlLBkQX+1t/O0aoyfqD2wqin8crvnd8WaJjI5/xcqNF
   4z5BP4mH7RVooZB+lw7x37ne3aVAIhWZczohRLFz03/Xv3LkfoVgjewF4
   Dl5W35OfFKGCJ+MEJD17yzAeu6B9Ma6SdXRIfDasb1rrbkEUgkOo9rkNc
   LIjHTKEPtg2oAHLociYoGO9ujTwNdgDYdg9tCY4bS5OxKKfISJWPEPbSP
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10457"; a="294568833"
X-IronPort-AV: E=Sophos;i="5.93,281,1654585200"; 
   d="scan'208";a="294568833"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 14:07:29 -0700
X-IronPort-AV: E=Sophos;i="5.93,281,1654585200"; 
   d="scan'208";a="674047798"
Received: from mkounkel-mobl.amr.corp.intel.com (HELO bgi1-mobl2.amr.corp.intel.com) ([10.212.37.120])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 14:07:28 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     marcel@holtmann.org, luiz.dentz@gmail.com, brian.gix@intel.com
Subject: [PATCH BlueZ v2] mgmt-tester: Adds turning on Mesh Experimental feature
Date:   Thu,  1 Sep 2022 14:07:22 -0700
Message-Id: <20220901210722.73044-1-brian.gix@intel.com>
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
 tools/mgmt-tester.c | 40 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 38 insertions(+), 2 deletions(-)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index 02ddfd844..5747ab84b 100644
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
@@ -7390,7 +7421,8 @@ static void command_generic_callback(uint8_t status, uint16_t length,
 			expect_param = test->expect_func(&expect_len);
 
 		if (length != expect_len) {
-			tester_warn("Invalid cmd response parameter size");
+			tester_warn("Invalid cmd response parameter size %d %d",
+					length, expect_len);
 			tester_test_failed();
 			return;
 		}
@@ -9858,7 +9890,7 @@ static const struct generic_data set_dev_flags_fail_3 = {
 };
 
 static const uint8_t read_exp_feat_param_success[] = {
-	0x04, 0x00,				/* Feature Count */
+	0x05, 0x00,				/* Feature Count */
 	0xd6, 0x49, 0xb0, 0xd1, 0x28, 0xeb,	/* UUID - Simultaneous */
 	0x27, 0x92, 0x96, 0x46, 0xc0, 0x42,	/* Central Peripheral */
 	0xb5, 0x10, 0x1b, 0x67,
@@ -9875,6 +9907,10 @@ static const uint8_t read_exp_feat_param_success[] = {
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

