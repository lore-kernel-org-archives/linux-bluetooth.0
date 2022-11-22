Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8314CC4332F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Nov 2022 10:10:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232923AbiKVKKx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 22 Nov 2022 05:10:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232372AbiKVKKu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 22 Nov 2022 05:10:50 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 898D553EE1
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Nov 2022 02:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669111848; x=1700647848;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JBZpnua/8DqZ73tVLUeRtSCjqc6C0VrbUO9cyeMoA/4=;
  b=W8yP4FFdW2f5O2QwSvFH3Htc5PvUfWvLuCZp9o4Zo2MlyZfAx21rKaBq
   E1x825khUO3snXHNj4VX/sVRC5gj6kBwMyT06eQSfIPNm7gkBLnM4vQPC
   inlCCTxPm0PE3wOAfMqKjB1fVKTysq7lHECyYGAMmxa1b9nixzHRU3Eip
   OcRDiQgj6eK0EAtDyRmVgYTuQgbdSPIIoX4OEvfcA/kiHNV1iUNOmKpv8
   VGBkIAbvnCHeFf+NYYgJ7ehIfJ7oHbhm+7b+qQctDCbCYHY4E2+9SUjXO
   lIkx8a+4hbSd8Mq4dp+JoafEeSYM/f69nECX1ptT9iZWyPiDZLy8LWnCV
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="378039340"
X-IronPort-AV: E=Sophos;i="5.96,183,1665471600"; 
   d="scan'208";a="378039340"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2022 02:10:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="672431875"
X-IronPort-AV: E=Sophos;i="5.96,183,1665471600"; 
   d="scan'208";a="672431875"
Received: from intel-latitude-e5450.iind.intel.com ([10.224.186.32])
  by orsmga008.jf.intel.com with ESMTP; 22 Nov 2022 02:10:47 -0800
From:   Sathish Narasimman <sathish.narasimman@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Sathish Narasimman <sathish.narasimman@intel.com>
Subject: [PATCH BlueZ v3 1/7] shared/util: Update UUID database for Csip services
Date:   Tue, 22 Nov 2022 15:42:26 +0530
Message-Id: <20221122101232.45320-2-sathish.narasimman@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221122101232.45320-1-sathish.narasimman@intel.com>
References: <20221122101232.45320-1-sathish.narasimman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This updates UUID database with the values from assigned numbers for
co-ordinated set identification services.
---
 src/shared/util.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/shared/util.c b/src/shared/util.c
index 333023e0dcac..d7fbd2322f7b 100644
--- a/src/shared/util.c
+++ b/src/shared/util.c
@@ -695,6 +695,9 @@ static const struct {
 	{ 0x2b82, "Volume Offset Control Point"			},
 	{ 0x2b83, "Audio Output Description"			},
 	{ 0x2b84, "Set Identity Resolving Key"			},
+	{ 0x2b85, "Csis Size"					},
+	{ 0x2b86, "Csis Lock"					},
+	{ 0x2b87, "Csis Rank"					},
 	{ 0x2b93, "Media Player Name"				},
 	{ 0x2b94, "Media Player Icon Object ID"			},
 	{ 0x2b95, "Media Player Icon URL"			},
-- 
2.25.1

