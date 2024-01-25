Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FDB537156
	for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jan 2024 12:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706186386; cv=none; b=ZT19SpB1VeKv15iQI9bJzVXNCEnSsV726L7R7Pikcgr+EqcgBXm9Sjvsy2DcoVV0r7uvSmnVEcTdpH0qiHlig9Jk6hbKnkw9FZcRv1LhGPF5s5Jx0tjmasRYoyUuqCut4ieugpcSfgSKXOF+Q0fQRq7eAxfMfpudbNovVGPlRFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706186386; c=relaxed/simple;
	bh=wzr0TASYNztIqq/P3j3q+NAQchW2xJw3crle8Sot/nE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UmjkcRhmrYWvheBfi5OsibPaZ4ke6AFwjvIeiF/M31SbqTdx0aIn4igGn0FjoUSZ+uJRF0aTe8ipd+f6Z8uvxUxOeBI99nmM5r2sZRU3ZWrpPXVwzDCmXsTVlf1YsD4lTcbNk3FxV+/HjKKd3hLd8HN+/BT/UvRMbZwLlE9/TQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RLQ3Q/aq; arc=none smtp.client-ip=134.134.136.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RLQ3Q/aq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706186385; x=1737722385;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wzr0TASYNztIqq/P3j3q+NAQchW2xJw3crle8Sot/nE=;
  b=RLQ3Q/aqnBGDLdyIXN+XRCJqTNGFB6Vlu1dagOAKb8Gr2nGcMElenvJ7
   ps2HNIVoxpHZF9muIp/x1kcSBmn+xcDcjtEdPfgR8m4fuxCCUeUhWFEFv
   W2HLnFbMvKKSiRTNiw92sX0fVw+xZDgMu1q1608bQ735waF5R9YD30+p4
   xfI/oww5fhwtpiGc024kUaRYeX6W7hvyV/Og2dG/freL9iaI8bbw4+gw2
   VQh+gUffTjnvvFc2vB6mJPjKM6VzCPZgUl4TGyc719pPNsbovQtkZ/lGi
   DXOQBgzYKAr+0NrakN4qiBQIuGk18lWwk8apGtMn/9BICuEN4cI+yxWCM
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="405898690"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="405898690"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 04:39:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="1117934204"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="1117934204"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by fmsmga005.fm.intel.com with ESMTP; 25 Jan 2024 04:39:42 -0800
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH] bap: Fix update of context
Date: Thu, 25 Jan 2024 18:21:56 +0530
Message-Id: <20240125125156.1679513-1-kiran.k@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix context getting updated with support_context.
---
 src/shared/bap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index d56911e6b9ef..06cac5bb34fe 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -2628,7 +2628,7 @@ static void pacs_add_source_supported_context(struct bt_pacs *pacs,
 
 static void pacs_add_source_context(struct bt_pacs *pacs, uint16_t context)
 {
-	context |= pacs->supported_source_context_value;
+	context |= pacs->source_context_value;
 
 	/* Check if context value needs updating */
 	if (context == pacs->source_context_value)
-- 
2.34.1

