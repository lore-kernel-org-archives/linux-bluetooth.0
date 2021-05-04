Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB5CAC433B4
	for <linux-bluetooth@archiver.kernel.org>; Tue,  4 May 2021 11:06:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EC54610FC
	for <linux-bluetooth@archiver.kernel.org>; Tue,  4 May 2021 11:06:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbhEDLG7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 4 May 2021 07:06:59 -0400
Received: from mga11.intel.com ([192.55.52.93]:57952 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229903AbhEDLG6 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 4 May 2021 07:06:58 -0400
IronPort-SDR: ndKkjOH7D7Str6gbMyEgkXG1WHjaP+hAfi3mVvugSJpTkwOGMu3Sd6+wsHtz0Apl2Tce2lrzEy
 EBPZ9T7zFrUQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9973"; a="194814517"
X-IronPort-AV: E=Sophos;i="5.82,272,1613462400"; 
   d="scan'208";a="194814517"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2021 04:06:04 -0700
IronPort-SDR: z3eQjJ+te1szCfAkCrisRYL3Rm2cm04mHTjCtPi1Xu4H2jlMbxY1fvwaiFlA53wL1J/6z7Wom6
 Gb3j0VgDS8gQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,272,1613462400"; 
   d="scan'208";a="457846740"
Received: from nsathish-latitude-7480.iind.intel.com ([10.224.186.105])
  by FMSMGA003.fm.intel.com with ESMTP; 04 May 2021 04:06:02 -0700
From:   Sathish Narasimman <sathish.narasimman@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     chethan.tumkur.narayan@intel.com, ravishankar.srivatsa@intel.com,
        Sathish Narasimman <sathish.narasimman@intel.com>
Subject: [Bluez PATCH v2] btmgmt: Fix enable adding irk when turining privacy on
Date:   Tue,  4 May 2021 16:44:54 +0530
Message-Id: <20210504111454.29697-1-sathish.narasimman@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Unable to add the IRK in btmgmt when need to be updated. The option is
enabled now.

Signed-off-by: Sathish Narasimman <sathish.narasimman@intel.com>
---
 tools/btmgmt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/btmgmt.c b/tools/btmgmt.c
index 02fec1dca184..bf3b460d0f04 100644
--- a/tools/btmgmt.c
+++ b/tools/btmgmt.c
@@ -5277,7 +5277,7 @@ static const struct bt_shell_menu main_menu = {
 	cmd_advertising,		"Toggle LE advertising",	},
 	{ "bredr",		"<on/off>",
 		cmd_bredr,		"Toggle BR/EDR support",	},
-	{ "privacy",		"<on/off>",
+	{ "privacy",		"<on/off> [irk]",
 		cmd_privacy,		"Toggle privacy support"	},
 	{ "class",		"<major> <minor>",
 		cmd_class,		"Set device major/minor class"	},
-- 
2.17.1

