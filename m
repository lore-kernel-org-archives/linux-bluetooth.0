Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92AAD2820CC
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Jun 2025 09:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748944123; cv=none; b=LtOm/nWEzwKkhU5wN68xzmxjQYNviYm6D9jiAUY1xR5grP9AumVaMpzclv/cIcFqCem6C2mpG6rAhpJjcGS5BdypOD93hoInUGr+PSrYb19j1yMWCBk5poOiZjUQjPc09xND7/T+3+NQ/yUhcvjDyDksQHEnv6pFD93XieKoNog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748944123; c=relaxed/simple;
	bh=IJPhWqaNTSxKNPUWN1P53aWmP6+Y8OGAePdwSSquysg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l3TXasz5eDcC9CGPZ5z4cHw6SDcEeOmgwuQLRX1c3k4ssyqyGOQhSjW2rOwEe3g7yqWwuKZBJhybE75C99X8B5hHCclFTziEZLvJ7cbzF1/DOYiHKIKcC9OFwl1+BtlUbjj4vr36xjo2GKJncBK434s8kIjgcaEMRrMhwIt9fSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UNMHUE0H; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UNMHUE0H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748944121; x=1780480121;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IJPhWqaNTSxKNPUWN1P53aWmP6+Y8OGAePdwSSquysg=;
  b=UNMHUE0HbeCfSQN7aZrKv9A03xJFnDYdBO8mLoxuFOXHO41C7Egp7lyN
   Uuy13frPa2AjqU5O6s/dcFNc3MjtrtQXo1rXWhAFAqQV1HyCyG75FpdIG
   jY3W9FF171ovAmiCO0u9vVsU2ThkOmS5tm+qzA4vXBtW/zqbm/kolr6TR
   811m34/7aIDOdWcz39PpZ87gKJEN5nO7hc0B1p3NwfXALHu+Z6FzBZPAw
   uNtJpmjtnuzuwyXM50pAz1K3XkrndzbX2rR+jcrpdILLhtNTvWUWwTS6B
   rLsE6905qj+zxADgMdlmwBl8inzEpESHhVAIg13BVSdW1mg1iIbLybdQb
   Q==;
X-CSE-ConnectionGUID: REV8T7yeTtStzYuLYCqg1g==
X-CSE-MsgGUID: ZWwnehGGQH6uD/ZqIfmZ7A==
X-IronPort-AV: E=McAfee;i="6700,10204,11451"; a="61594865"
X-IronPort-AV: E=Sophos;i="6.16,205,1744095600"; 
   d="scan'208";a="61594865"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 02:48:32 -0700
X-CSE-ConnectionGUID: J1UJHTFeRPuTeu72usVOTA==
X-CSE-MsgGUID: j73M0n4MQ4+Z2PJzhgsK9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,205,1744095600"; 
   d="scan'208";a="175759086"
Received: from unknown (HELO intel-Lenovo-Legion-Y540-15IRH-PG0.iind.intel.com) ([10.224.186.95])
  by orviesa002.jf.intel.com with ESMTP; 03 Jun 2025 02:48:29 -0700
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com,
	chandrashekar.devegowda@intel.com,
	vijay.satija@intel.com,
	aluvala.sai.teja@intel.com,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH v3] Bluetooth: btintel_pcie: Reduce driver buffer posting to prevent race condition
Date: Tue,  3 Jun 2025 15:34:40 +0530
Message-ID: <20250603100440.600346-3-kiran.k@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250603100440.600346-1-kiran.k@intel.com>
References: <20250603100440.600346-1-kiran.k@intel.com>
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
Fixes: c2b636b3f788 ("Bluetooth: btintel_pcie: Add support for PCIe transport")
---
changes in v3:
 - Remove reference to JIRA link
 - Add Fixes tag

 drivers/bluetooth/btintel_pcie.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index 03f13de4a723..563165c5efae 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -398,7 +398,11 @@ static int btintel_pcie_start_rx(struct btintel_pcie_data *data)
 	int i, ret;
 	struct rxq *rxq = &data->rxq;
 
-	for (i = 0; i < rxq->count; i++) {
+	/* Post (BTINTEL_PCIE_RX_DESCS_COUNT - 3) buffers to overcome the
+	 * hardware issues leading to race condition at the firmware.
+	 */
+
+	for (i = 0; i < rxq->count - 3; i++) {
 		ret = btintel_pcie_submit_rx(data);
 		if (ret)
 			return ret;
-- 
2.43.0

