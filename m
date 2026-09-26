Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103567478
	for <linux-bluetooth@vger.kernel.org>; Sat, 26 Sep 2026 08:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790412630; cv=none; b=hfO6k3wjxJ3JSij1BSnEMzi0yvEv97yvRieF9z+BNnMABFJC/Sm0cAGIt821+0hMI9vOLrruUnXM/o1GVeF/DwTIVr5UgNhu/Ul3frnr+/21vbDIiCWyV928wVhfhElWLWMwG+5FiMKmwlWHQAr0AYvm8BWcdE58ADvRIe1eaYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790412630; c=relaxed/simple;
	bh=oZil0vRLdVl+Orqq5d8PnMWTRJTHtrlz+ex7TNO2M4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YmfOVxO3uWsge9wio69lOaWRCoX32MUl5xKabz6w9k+SBO7HnxK2iV1zbF2eW1Mk8OlTxh+8d4lrZ+PfWiP627VhtMmKOXMJBZOqN3HiIEL8vEToKCxf8jPFg4HqEFQWd9pFZPKBEdOTuIDtUrQsXrMcpbseI9D8EqaUlJqd730=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q87xSTbZ; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q87xSTbZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790412628; x=1821948628;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=oZil0vRLdVl+Orqq5d8PnMWTRJTHtrlz+ex7TNO2M4Q=;
  b=Q87xSTbZK0ajrAruhM0oNg3ZyG9H7L/C/SzYKyMsPwbbehltFuHGZRQM
   VuGXts9r+ewbvHcEt/OPNPmWUtKtl6JQNgLzow68yGVa7Jx+modiG5xaz
   qBCIDsIZTucRvi8hnwlYK+IQ06MMycSK1YAix71PwqHdYTvN2tOxrgTe6
   TCBvsBUt0G/n14f6n5DqbExQ+7fULt/V27LZt1spVdpXphAGCtKBn5Yyt
   CIcCpEXh25IfzfYZXk1igLLE02DSFanapLHSYfMTNYDCClfv7Qc3BS2JN
   hz8wfHT5AP3auS659WULIp3kI+TWHciT/u5OJ7QUxlIfWm4w3ALH6Fgfu
   Q==;
X-CSE-ConnectionGUID: y8Mx2TFITDGmX+h8QTLx6w==
X-CSE-MsgGUID: we6sFy92SRSNwAE2p/AXkA==
X-IronPort-AV: E=McAfee;i="6800,10657,11916"; a="89952803"
X-IronPort-AV: E=Sophos;i="6.27,124,1787036400"; 
   d="scan'208";a="89952803"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2026 01:50:27 -0700
X-CSE-ConnectionGUID: fFbDX0bGSxSKjMbaR/nWLg==
X-CSE-MsgGUID: EnqWI6GrSKmOt+5XrRbI1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,124,1787036400"; 
   d="scan'208";a="279264747"
Received: from unknown (HELO WEBA2062.iind.intel.com) ([10.66.228.2])
  by fmviesa004.fm.intel.com with ESMTP; 26 Sep 2026 01:50:25 -0700
From: Ravindra <ravindra@intel.com>
To: linux-bluetooth@vger.kernel.org,
	lsa.uz@pm.me,
	vladimirkondratyev2@gmail.com
Cc: chethan.tumkur.narayan@intel.com,
	kiran.k@intel.com,
	Paul Menzel <pmenzel@molgen.mpg.de>
Subject: [PATCH v4 1/4] Bluetooth: btintel_pcie: fix stale cache in set_dxstate fallback check
Date: Sat, 26 Sep 2026 14:22:59 +0530
Message-ID: <20260926085302.2879093-1-ravindra@intel.com>
X-Mailer: git-send-email 2.43.0
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

