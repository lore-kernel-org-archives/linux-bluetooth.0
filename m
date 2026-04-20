Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6B33793D4
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Apr 2026 17:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776705553; cv=none; b=iYgR1P7kG2t60WAtcJhzgXMYhoiQyRd0gVb2usgKkiEbFRYhj61IliUMPA4Oh2v3pk4ZTMxDztIjlqAbie0bQyYhg62dOosMeVqrK+8PFviBZL//38OnAeis9xgj+Jf71QvsBlT0ryEOUUCH27ZIUrw0XVrNnFHuR7m/8H+WuMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776705553; c=relaxed/simple;
	bh=AozOIqrG/q+E2LQW8jJH9J10O3WOMvyHmgBIDzwMG/A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u5SIk0mI74rGOHoWEfqhTKzZQhZ38zEsXSf8axeV04G9/9h54B4/RB4HRbH9semFVVZcv1gfrG3FAAZScLXHCzcCwFHuPcgjtwMdpHIOHzK/XLdR3oXrC+1OOW+fnUAlsC9vfC2Ym7Pkf3zM7wdgmLfBrg9g4lDVHUXXwwJ/T8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BnvC64ns; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BnvC64ns"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776705551; x=1808241551;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=AozOIqrG/q+E2LQW8jJH9J10O3WOMvyHmgBIDzwMG/A=;
  b=BnvC64nswYdfX0JzJboCst6NW6yDxGfDg035zh+jzc7LL5mn90lpmKgY
   pMYGhHHnGTdxjlhg9EfaAPg40PWgI8mkVL8nwsYvGUNzDmLlyM9thn6cx
   s/64+JoI8wLjR1FARfCii4+7K+2rVuE8NgquZmhWXY071zGg0X1Rf/6oX
   CfywNLUm4PkhdSoyE2BZvNmmWoFSUgfwCYlL0lfkgAsx/knEEgMo188rK
   sKWRGzzY7IKlBxtDeMXrWmaTaNH/zF/1OTy+DggR9UgfCjMzEJZJ05Gy+
   te7pE3a+I+IPR8XH7XPBQT7KgOc2N8X0yefBwLSdThLktlUjXYbuCJNaZ
   A==;
X-CSE-ConnectionGUID: idmhEZPeS+aI6wO9bx4s1Q==
X-CSE-MsgGUID: tIzpnb82SgGtVfGt36+vwQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="81497154"
X-IronPort-AV: E=Sophos;i="6.23,190,1770624000"; 
   d="scan'208";a="81497154"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2026 10:19:10 -0700
X-CSE-ConnectionGUID: 6Td+Q5WeS1ePajiwP2CAPw==
X-CSE-MsgGUID: B4WhNlCTQJ+q/75K1wfGKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,190,1770624000"; 
   d="scan'208";a="236757218"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by fmviesa005.fm.intel.com with ESMTP; 20 Apr 2026 10:19:08 -0700
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com,
	aluvala.sai.teja@intel.com,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH v2] Bluetooth: btintel_pcie: treat boot stage bit 12 as warning
Date: Mon, 20 Apr 2026 23:07:35 +0530
Message-ID: <20260420173735.950706-1-kiran.k@intel.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sai Teja Aluvala <aluvala.sai.teja@intel.com>

CSR boot stage register bit 12 is documented as a device warning,
not a fatal error. Rename the bit definition accordingly and stop
including it in btintel_pcie_in_error().

This keeps warning-only boot stage values from being classified as
errors while preserving abort-handler state as the actual error
condition.

Fixes: 190377500fde ("Bluetooth: btintel_pcie: Dump debug registers on error")
Signed-off-by: Kiran K <kiran.k@intel.com>
Signed-off-by: Sai Teja Aluvala <aluvala.sai.teja@intel.com>
---
v2: - Add warning log in btintel_pcie_in_error() when bit 12 is set,
      including the boot_stage register value for diagnostics
    - Add warning log in btintel_pcie_dump_debug_registers() to cover
      paths that update boot_stage_cache without going through
      btintel_pcie_in_error() (gp1 handler, hw_error, TX timeout)
    - Use consistent "(boot_stage: 0x%8.8x)" format across all
      boot_stage log messages

 drivers/bluetooth/btintel_pcie.c | 13 ++++++++++---
 drivers/bluetooth/btintel_pcie.h |  2 +-
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index 076beb45c410..fda474406003 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -301,6 +301,9 @@ static inline void btintel_pcie_dump_debug_registers(struct hci_dev *hdev)
 	skb_put_data(skb, buf, strlen(buf));
 	data->boot_stage_cache = reg;
 
+	if (reg & BTINTEL_PCIE_CSR_BOOT_STAGE_DEVICE_WARNING)
+		bt_dev_warn(hdev, "Controller device warning (boot_stage: 0x%8.8x)", reg);
+
 	reg = btintel_pcie_rd_reg32(data, BTINTEL_PCIE_CSR_IPC_STATUS_REG);
 	snprintf(buf, sizeof(buf), "ipc status: 0x%8.8x", reg);
 	skb_put_data(skb, buf, strlen(buf));
@@ -892,8 +895,11 @@ static inline bool btintel_pcie_in_lockdown(struct btintel_pcie_data *data)
 
 static inline bool btintel_pcie_in_error(struct btintel_pcie_data *data)
 {
-	return (data->boot_stage_cache & BTINTEL_PCIE_CSR_BOOT_STAGE_DEVICE_ERR) ||
-		(data->boot_stage_cache & BTINTEL_PCIE_CSR_BOOT_STAGE_ABORT_HANDLER);
+	if (data->boot_stage_cache & BTINTEL_PCIE_CSR_BOOT_STAGE_DEVICE_WARNING)
+		bt_dev_warn(data->hdev, "Controller device warning (boot_stage: 0x%8.8x)",
+			    data->boot_stage_cache);
+
+	return	data->boot_stage_cache & BTINTEL_PCIE_CSR_BOOT_STAGE_ABORT_HANDLER;
 }
 
 static void btintel_pcie_msix_gp1_handler(struct btintel_pcie_data *data)
@@ -926,7 +932,8 @@ static void btintel_pcie_msix_gp0_handler(struct btintel_pcie_data *data)
 		data->img_resp_cache = reg;
 
 	if (btintel_pcie_in_error(data)) {
-		bt_dev_err(data->hdev, "Controller in error state");
+		bt_dev_err(data->hdev, "Controller in error state (boot_stage: 0x%8.8x)",
+			   data->boot_stage_cache);
 		btintel_pcie_dump_debug_registers(data->hdev);
 		return;
 	}
diff --git a/drivers/bluetooth/btintel_pcie.h b/drivers/bluetooth/btintel_pcie.h
index d5b6d5121548..2db85f71b2f8 100644
--- a/drivers/bluetooth/btintel_pcie.h
+++ b/drivers/bluetooth/btintel_pcie.h
@@ -48,7 +48,7 @@
 #define BTINTEL_PCIE_CSR_BOOT_STAGE_OPFW		(BIT(2))
 #define BTINTEL_PCIE_CSR_BOOT_STAGE_ROM_LOCKDOWN	(BIT(10))
 #define BTINTEL_PCIE_CSR_BOOT_STAGE_IML_LOCKDOWN	(BIT(11))
-#define BTINTEL_PCIE_CSR_BOOT_STAGE_DEVICE_ERR		(BIT(12))
+#define BTINTEL_PCIE_CSR_BOOT_STAGE_DEVICE_WARNING	(BIT(12))
 #define BTINTEL_PCIE_CSR_BOOT_STAGE_ABORT_HANDLER	(BIT(13))
 #define BTINTEL_PCIE_CSR_BOOT_STAGE_DEVICE_HALTED	(BIT(14))
 #define BTINTEL_PCIE_CSR_BOOT_STAGE_MAC_ACCESS_ON	(BIT(16))
-- 
2.53.0

