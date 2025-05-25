Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E52415533F
	for <linux-bluetooth@vger.kernel.org>; Sun, 25 May 2025 05:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748150596; cv=none; b=bjHywvpo6wgtT/nBWeYZ6tClwKbS+92XMjDA1FwDyeOXJ3ntLNtjkQY8AaxjGxhapFD5pMQirrh81PFAnrVLj3gUdHamalEErllKcPea0YFxoO614UoFkAmCffUmVAiTPiP1kvO9zusOmj0Gerz8O/+Kt5Tts5ZEc3DMMZGlU9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748150596; c=relaxed/simple;
	bh=agEt3vemqiDf0fkw4RaDsfrJ76P9XBT32usEnO7NPrI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PMM+LcW5U5mpsg+goXQ+U1uUnvxzGsngtRuAukNtXCUmTg0vNH9T8fdYpCAlzX74+dWON/Jl0Pe5nRRJEZNgig/EY2ZXinyUFy8SiLhT/oSwV6YV++PD27J6SmEqvm3zg23OGCo/fYUpI6jOZ7rJ1mB98Smt+wgCxyT/N3SkrP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z+oAa9hK; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z+oAa9hK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748150596; x=1779686596;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=agEt3vemqiDf0fkw4RaDsfrJ76P9XBT32usEnO7NPrI=;
  b=Z+oAa9hKjeeFOtTRIiewVz+RVfgwFuitdUsplqSWH/hUYnTzD52jcLrs
   5elvfL41Z/GBvX4nirsdPpEEkMh9nIOgOHfs2oy2zmWqQZ6FCtyhnLGCp
   QtAU9wuOu1SZ3Bkk+DFgEDrkSmb8fTwBrNTFT1rl/bDatB9y9IkonbRjK
   W2FcJPGbwaQRSL0+U8738Py7f77Hrv3PxmtHsuGUtHm+uyMC5eUlrcdJJ
   ZQCW55LyRZtjNFMM+O90EJrEMJF4rulezqX3y0PTWXZ/eD8hy+EGoE/Wr
   tcqATFAjQEX0+1V+XvMoQybUvScHscDsXwdTbBfh6jxSDnwNx8wMP3u7F
   A==;
X-CSE-ConnectionGUID: Aubny44zRN28rvLEdMz4SQ==
X-CSE-MsgGUID: 6gVmskugRXWgm/kBwgFP/g==
X-IronPort-AV: E=McAfee;i="6700,10204,11443"; a="61208331"
X-IronPort-AV: E=Sophos;i="6.15,312,1739865600"; 
   d="scan'208";a="61208331"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2025 22:23:15 -0700
X-CSE-ConnectionGUID: i9WSQKP3S9uQKos32nCKQA==
X-CSE-MsgGUID: fQMCFzctRQ+0aojuyO2REg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,312,1739865600"; 
   d="scan'208";a="146656319"
Received: from unknown (HELO intel-Lenovo-Legion-Y540-15IRH-PG0.iind.intel.com) ([10.224.186.95])
  by fmviesa005.fm.intel.com with ESMTP; 24 May 2025 22:23:13 -0700
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com,
	chandrashekar.devegowda@intel.com,
	vijay.satija@intel.com,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH v1 3/3] Bluetooth: btintel_pcie: Reduce driver buffer posting to prevent race condition
Date: Sun, 25 May 2025 11:09:40 +0530
Message-ID: <20250525053940.520283-3-kiran.k@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250525053940.520283-1-kiran.k@intel.com>
References: <20250525053940.520283-1-kiran.k@intel.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>

Modify the driver to post 3 fewer buffers than the maximum rx buffers
(64) allowed for the firmware. This change mitigates a hardware issue
causing a race condition in the firmware, improving stability and data
handling.

Signed-off-by: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
Signed-off-by: Kiran K <kiran.k@intel.com>
---
 drivers/bluetooth/btintel_pcie.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index 03f13de4a723..14f000e08e1e 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -398,7 +398,10 @@ static int btintel_pcie_start_rx(struct btintel_pcie_data *data)
 	int i, ret;
 	struct rxq *rxq = &data->rxq;
 
-	for (i = 0; i < rxq->count; i++) {
+	/* Post (BTINTEL_PCIE_RX_DESCS_COUNT - 3) buffers to overcome the
+	 * hardware issues leading to race condition at the firmware.
+	 */
+	for (i = 0; i < rxq->count - 3; i++) {
 		ret = btintel_pcie_submit_rx(data);
 		if (ret)
 			return ret;
-- 
2.43.0

