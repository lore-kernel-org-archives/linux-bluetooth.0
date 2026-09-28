Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7214C35675E
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Sep 2026 05:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790571675; cv=none; b=qSgQeIT/U7/6LEa2LD43WHro5GSbbbl9L1ZOuXZ2yzjwDVG436ppsU9MLEUmJeIx16XaMrGjxuz0tWsJ7Umn23Kwbn6RF7A+DKrNFuHS1hHtB98KclG9snizR0jhbBAf+dEGXFu5+fqNO6Zli+Z/it8Ta5MlrkPpJmNcqGIBN1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790571675; c=relaxed/simple;
	bh=oZil0vRLdVl+Orqq5d8PnMWTRJTHtrlz+ex7TNO2M4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cfh8KmBGRCgwFQhxPYBz5fxUV8hwVq1OsYYRTKlXxdmQUVkt1+KRvIShPs7yZAVi3LYns48O+1RMqpxhtHTmIraHRr+fTP9ImhTk301emuBy8oVWKpOgt6ioqNPzExTqSRGEwMeybEUaEOn9f+aIppHc/I+PrN984CNb9XJOsSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mony3P/e; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mony3P/e"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790571674; x=1822107674;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oZil0vRLdVl+Orqq5d8PnMWTRJTHtrlz+ex7TNO2M4Q=;
  b=mony3P/e4BJDDZDfHipovkK8Zm+hSZf4B6U3zBVZnlscK0uuB/ZLDx4z
   YD7z5EhfS6qwI3KzCq91EJVarIr9AfpQm3zVRj5jUcg4gLo6KT6cM8aX9
   k8Ld5aShXm6QOh9sjP8+OTKmb6bnwkt112jRVCHgmWE+jsobGeBO0zt+G
   saRHxOWUqNi2IkAYzXvXZ9pK+VjM84uGow08VvRSp3FEneHdPhCyjEVQ5
   p3sRCeuIvQAIT8KMCEYopV4U8afI0y90tnlafLmdNcAu+ZqY0t2C4eQXQ
   0TAQ3vsWVnMLguYJFmxVvN3kzYq5kXoifNFjP4HPM03uLAInqpn+jRvVs
   Q==;
X-CSE-ConnectionGUID: pL0gZ+shQfOfcvi00IepYQ==
X-CSE-MsgGUID: TOmMcuZ+RIeMh95+TKg3Kg==
X-IronPort-AV: E=McAfee;i="6800,10657,11918"; a="90127777"
X-IronPort-AV: E=Sophos;i="6.27,127,1787036400"; 
   d="scan'208";a="90127777"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2026 22:01:13 -0700
X-CSE-ConnectionGUID: TkyqQu37TsWnSlpY0lLzXw==
X-CSE-MsgGUID: qD+XDuneSaO9doNij/7mGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,127,1787036400"; 
   d="scan'208";a="312863717"
Received: from unknown (HELO WEBA2062.iind.intel.com) ([10.66.228.2])
  by orviesa001.jf.intel.com with ESMTP; 27 Sep 2026 22:01:11 -0700
From: Ravindra <ravindra@intel.com>
To: linux-bluetooth@vger.kernel.org,
	lsa.uz@pm.me,
	vladimirkondratyev2@gmail.com
Cc: chethan.tumkur.narayan@intel.com,
	kiran.k@intel.com,
	pmenzel@molgen.mpg.de
Subject: [PATCH v5 1/4] Bluetooth: btintel_pcie: fix stale cache in set_dxstate fallback check
Date: Mon, 28 Sep 2026 10:33:41 +0530
Message-ID: <20260928050344.2893790-2-ravindra@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260928050344.2893790-1-ravindra@intel.com>
References: <20260928050344.2893790-1-ravindra@intel.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Vladimir V. Kondratyev" <vladimirkondratyev2@gmail.com>

btintel_pcie returns -16 (EBUSY) during suspend, causing the entire
suspend operation to abort on Intel Lunar Lake hardware. The system
immediately resumes after every suspend attempt:

  Bluetooth: hci0: Timeout (200 ms) on alive interrupt for D2 entry, retry count 0
  Bluetooth: hci0: Timeout (200 ms) on alive interrupt for D2 entry, retry count 1
  Bluetooth: hci0: Timeout (200 ms) on alive interrupt for D2 entry, retry count 2
  btintel_pcie 0000:00:14.7: PM: pci_pm_suspend(): btintel_pcie_suspend [btintel_pcie] returns -16
  btintel_pcie 0000:00:14.7: PM: dpm_run_callback(): pci_pm_suspend returns -16
  btintel_pcie 0000:00:14.7: PM: failed to suspend async: error -16
  PM: Some devices failed to suspend, or early wake event detected

btintel_pcie_set_dxstate() falls back to checking the controller state via
btintel_pcie_in_d3/d0() when the alive interrupt is missed. However, these
helpers read boot_stage_cache, which is only updated by the interrupt
handler. As such, if the interrupt was missed, the cache is stale and the
fallback check always fails, exhausting all retries and returning -EBUSY,
causing suspend to abort.

The fix involves re-reading the hardware register before the fallback state
check, consistent with btintel_pcie_resume().

Fixes: 88c6216a52ea ("Bluetooth: btintel_pcie: Suspend/Resume: Controller doorbell interrupt handling")
Link: https://bugzilla.kernel.org/show_bug.cgi?id=221481
Link: https://lore.kernel.org/linux-bluetooth/20260830151550.44687-1-lsa.uz@pm.me/
Signed-off-by: Vladimir V. Kondratyev <vladimirkondratyev2@gmail.com>
Tested-by: Sergey Lebedev <lsa.uz@pm.me>
Signed-off-by: Sergey Lebedev <lsa.uz@pm.me>
---
 drivers/bluetooth/btintel_pcie.c | 8 +++++---
 drivers/bluetooth/btintel_pcie.h | 1 +
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index 59cf600014bb..677749903173 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -4222,10 +4222,12 @@ static int btintel_pcie_set_dxstate(struct btintel_pcie_data *data, u32 dxstate)
 					  BTINTEL_PCIE_CSR_MSIX_HW_INT_CAUSES,
 					  BTINTEL_PCIE_MSIX_HW_INT_CAUSES_GP0);
 
-		/* A hardware bug may cause the alive interrupt to be missed.
-		 * Check if the controller reached the expected state and retry
-		 * the operation only if it hasn't.
+		/* A hardware bug may cause the alive interrupt to be missed. Refresh
+		 * boot_stage_cache from hardware, since only the interrupt handler
+		 * updates it. Finally retry only if the state check still fails.
 		 */
+		data->boot_stage_cache = btintel_pcie_rd_reg32(data,
+							       BTINTEL_PCIE_CSR_BOOT_STAGE_REG);
 		if (dxstate == BTINTEL_PCIE_STATE_D0) {
 			if (btintel_pcie_in_d0(data))
 				return 0;
diff --git a/drivers/bluetooth/btintel_pcie.h b/drivers/bluetooth/btintel_pcie.h
index f35f80f800ed..016795fcbccc 100644
--- a/drivers/bluetooth/btintel_pcie.h
+++ b/drivers/bluetooth/btintel_pcie.h
@@ -51,6 +51,7 @@
 #define BTINTEL_PCIE_CSR_BOOT_STAGE_DEVICE_HALTED	(BIT(14))
 #define BTINTEL_PCIE_CSR_BOOT_STAGE_MAC_ACCESS_ON	(BIT(16))
 #define BTINTEL_PCIE_CSR_BOOT_STAGE_ALIVE		(BIT(23))
+/* Reflects live D-state. Updated by hardware on every D-state transition. */
 #define BTINTEL_PCIE_CSR_BOOT_STAGE_D3_STATE_READY	(BIT(24))
 
 #define BTINTEL_PCIE_CSR_DOORBELL_MBOX_READ_CONFIRM	(BIT(4))
-- 
2.43.0

