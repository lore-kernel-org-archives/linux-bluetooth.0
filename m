Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C524E06ED;
	Mon, 28 Sep 2026 17:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790615257; cv=none; b=U7SmOydZPUmCl3UWH5WOFeQ0R0s55lKKLSnziQbZe5flAU8jsCyzpayjySxIzisb9fjknmt+2Bt8M2ymQNxu7643R3d9iDKRWATATzHhynqcjfBO4XPAkwADaW9aa3gYaTGDjSHCUj6SASjrbHi9dJ0icINMK2qCOe5tp6UG3no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790615257; c=relaxed/simple;
	bh=Xu09CmVFiyp79uCkuYog95d3+HKJ5lgfkK1W4SC3/sk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VGR7msNNkLcoVyW13eMHNqErQHdKGbo0Sy2JEBxzcf9nmTy4xaesOAQEreAQO7REBy1CYtgip4FUcb7wPkXvdBhr4WJywS/1heoewQkRS0m0ATp3VjtWgzeLRU3kflBLgNvhor000aIGX3+YX4lBZ2CDQgw9Cm14ngR3ZrCJQw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eLvcmjak; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eLvcmjak"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790615253; x=1822151253;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Xu09CmVFiyp79uCkuYog95d3+HKJ5lgfkK1W4SC3/sk=;
  b=eLvcmjakvQoOFZYtVUIRj9ETHwg8wFKgD8eKuh3JvjRp0wHvYorjaOcF
   ATEwI+NdXvVt5O1z9X5sq1OeMhys++qgEIqLXzpXY7tIYjhH6HkFEXrAQ
   f3uawrfMArOyMfs2GT8wq4YGZBLxDIjn61CzyQ+s1xIvDo0lwVBvo0y0X
   Dct3AwMO8xR+vYo2IUb8NnrL+1WxXwqPt1ogwSx6qsiuOFLJ0aBG5zB6b
   /FOEHqNfkBtEBzUt1tEWCLP8EltqezR5d4m/8L6kwQ58SWjbu8l7tdtzr
   Ed8lNt/vAki4pqnWZ1fVUOxWyU4SskJrDOR5D6Vmr75VG4AVpaHS0xXS9
   Q==;
X-CSE-ConnectionGUID: nekFH57ERiGw/IyTuo2nyw==
X-CSE-MsgGUID: dPV/+LDZQH2q29TLM81cRg==
X-IronPort-AV: E=McAfee;i="6800,10657,11919"; a="116847868"
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="116847868"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 10:07:30 -0700
X-CSE-ConnectionGUID: tojJ3WrtSzasE8ZqeOwLQg==
X-CSE-MsgGUID: swpDCeVSQVeqKwEtDbp53Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="275222323"
Received: from unknown (HELO WEBA2062.iind.intel.com) ([10.66.228.2])
  by fmviesa008.fm.intel.com with ESMTP; 28 Sep 2026 10:07:28 -0700
From: Ravindra <ravindra@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: lsa.uz@pm.me,
	pmenzel@molgen.mpg.de,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	kiran.k@intel.com,
	chethan.tumkur.narayan@intel.com,
	linux-kernel@vger.kernel.org,
	"Vladimir V. Kondratyev" <vladimirkondratyev2@gmail.com>,
	Ravindra <ravindra@intel.com>
Subject: [PATCH v6 1/4] Bluetooth: btintel_pcie: fix stale cache in set_dxstate fallback check
Date: Mon, 28 Sep 2026 22:40:00 +0530
Message-ID: <20260928171003.2925480-2-ravindra@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260928171003.2925480-1-ravindra@intel.com>
References: <20260928171003.2925480-1-ravindra@intel.com>
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
Signed-off-by: Ravindra <ravindra@intel.com>
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

