Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AFA4C4332F
	for <linux-bluetooth@archiver.kernel.org>; Thu,  6 Oct 2022 22:53:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232329AbiJFWxq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 6 Oct 2022 18:53:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232101AbiJFWxj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 6 Oct 2022 18:53:39 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38110BB041
        for <linux-bluetooth@vger.kernel.org>; Thu,  6 Oct 2022 15:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665096816; x=1696632816;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=KxGva8Hq0yFDk903beVvGoYcVv2R0WmDMLI0cMDmIAA=;
  b=GgzK4wuKYDkA3ekIuD6nqZYTG3U2y483d/R3i/wx/WiLENj1Y2T1nKg9
   YZb/5V8TvycXX05IHWcltjZg5PtBHkCt4wgXG3jj67QvCdUmZadew6ilK
   z9llz8gFs/NCiP2sqTGHBwWltT5PinyhLUkF1sJLuiuMS8f6PJkNRtPCS
   smV08dL1YieYloLv9UkSAfxDaLDAoxQwMktH+GI4F5UAgNjrHyavhlO7x
   4lyD25H3GS0R262XYjsl5io/emRAyhfDrzIl0F2wJnPrRFbN82ec3xpGv
   J5Bl9e643so/v6QLKJNRhy1sFfVNLA3AWT+hwTfFyM6O7Th+jH2LkFwZr
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10492"; a="303573805"
X-IronPort-AV: E=Sophos;i="5.95,164,1661842800"; 
   d="scan'208";a="303573805"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2022 15:53:35 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10492"; a="693550129"
X-IronPort-AV: E=Sophos;i="5.95,164,1661842800"; 
   d="scan'208";a="693550129"
Received: from ctamayo-mobl2.amr.corp.intel.com (HELO bgi1-mobl2.amr.corp.intel.com) ([10.212.51.159])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2022 15:53:35 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     luiz.dentz@gmail.com, brian.gix@intel.com, tedd.an@intel.com
Subject: [PATCH BlueZ] tools: mgmt-tester - Test for HCI cmd after static addr set
Date:   Thu,  6 Oct 2022 15:53:26 -0700
Message-Id: <20221006225326.641765-1-brian.gix@intel.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This change checks for the expected HCI command after Static Address
change requested.
---
 tools/mgmt-tester.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index 5747ab84b..7bb219953 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -4065,6 +4065,9 @@ static const struct generic_data set_static_addr_success_test = {
 	.expect_param = set_static_addr_settings,
 	.expect_len = sizeof(set_static_addr_settings),
 	.expect_settings_set = MGMT_SETTING_STATIC_ADDRESS,
+	.expect_hci_command = BT_HCI_CMD_LE_SET_RANDOM_ADDRESS,
+	.expect_hci_param = set_static_addr_valid_param,
+	.expect_hci_len = sizeof(set_static_addr_valid_param),
 };
 
 static const char set_static_addr_settings_dual[] = { 0x80, 0x00, 0x00, 0x00 };
@@ -4076,6 +4079,9 @@ static const struct generic_data set_static_addr_success_test_2 = {
 	.expect_status = MGMT_STATUS_SUCCESS,
 	.expect_param = set_static_addr_settings_dual,
 	.expect_len = sizeof(set_static_addr_settings_dual),
+	.expect_hci_command = BT_HCI_CMD_LE_SET_RANDOM_ADDRESS,
+	.expect_hci_param = set_static_addr_valid_param,
+	.expect_hci_len = sizeof(set_static_addr_valid_param),
 };
 
 static const struct generic_data set_static_addr_failure_test = {
-- 
2.37.3

