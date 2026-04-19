Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3362874FB
	for <linux-bluetooth@vger.kernel.org>; Sun, 19 Apr 2026 08:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776586519; cv=none; b=qu6UVX1h5l21Qq0KBGZpFIMTT3Er5SYL/5JcjfaPsKkThoavLaHisye+Befa3DZmfc+wIJrp7JfiNvgw9TDvi1vy2E3pF0C4zp9gH+gc0kOLr95x+a0Iw7KbJlD3kVeBDnI3Z1F285ueoEaoI3CaBg4lhrV58Ul6MAwBkevCdYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776586519; c=relaxed/simple;
	bh=CFY2vV0rIvr6Rd5hHCHomlESp8YUu/EGppFObZBe5pw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N4dZyiFMLQqQG8lDgsJ3SLNGQQOiqgaXOBOzRWz4xDwn1J9S9DowUA2CNv3iJ46qDZy/NMRJEsBXqWURcSc+og7ItXvNxgvmRzsbdniQ5WVqPbjFf4MGWpkOkFb2rI5TabPYmtxhC/8u34pa36PxZRBNNbXFPlTUK+28q1C5oVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oFSWL/T7; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oFSWL/T7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776586516; x=1808122516;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CFY2vV0rIvr6Rd5hHCHomlESp8YUu/EGppFObZBe5pw=;
  b=oFSWL/T7XzuXeXXGSCYI3YbzVgY0xvtFz7ooBy11phZMjSNZSOPeDmtY
   V8A7sYRMrdX+pSOHdTEtrkb3ih7mvWrxxmdh6AZBtHqTbr0kwmmyNCxM0
   MmVmFYdtp7g9zRkVJTrwa4lybhHsDfyS6SlB4uFTZ6Qrsi3X8qIhc+36b
   DisZWdw6CUj6BamnX0Lzxa5z/4geXrr/5QFKZVz78Cy6t3Ml6CQASUJD6
   bnBnIXXFx7ETNJgpzYQD+2QHs9D0oKmFzI+D5u29GOO6kvw4H5xYbgCWQ
   IHp0o0MuxTZZeAc4GH0tBQ1MalWzZUbRS7ixNgqwNL2MLhALIyhtIeM+V
   w==;
X-CSE-ConnectionGUID: CxmQr5ymRZ+tqmVFFcZ7gA==
X-CSE-MsgGUID: qk8tmNI2R1W3DiclgJr/dg==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="81137108"
X-IronPort-AV: E=Sophos;i="6.23,188,1770624000"; 
   d="scan'208";a="81137108"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2026 01:15:16 -0700
X-CSE-ConnectionGUID: l6gGfPkrRRusFO/v0WErFw==
X-CSE-MsgGUID: zldbOnz3Rq2WbOX4p/UeNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,188,1770624000"; 
   d="scan'208";a="228762859"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by fmviesa008.fm.intel.com with ESMTP; 19 Apr 2026 01:15:14 -0700
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com,
	Sai Teja Aluvala <aluvala.sai.teja@intel.com>,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH v1] Bluetooth: btintel_pcie: treat boot stage bit 12 as warning
Date: Sun, 19 Apr 2026 14:03:44 +0530
Message-ID: <20260419083345.894658-1-kiran.k@intel.com>
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

Signed-off-by: Kiran K <kiran.k@intel.com>
Signed-off-by: Sai Teja Aluvala <aluvala.sai.teja@intel.com>
---
 drivers/bluetooth/btintel_pcie.c | 6 +++---
 drivers/bluetooth/btintel_pcie.h | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index 076beb45c410..46b2637b64aa 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -892,8 +892,7 @@ static inline bool btintel_pcie_in_lockdown(struct btintel_pcie_data *data)
 
 static inline bool btintel_pcie_in_error(struct btintel_pcie_data *data)
 {
-	return (data->boot_stage_cache & BTINTEL_PCIE_CSR_BOOT_STAGE_DEVICE_ERR) ||
-		(data->boot_stage_cache & BTINTEL_PCIE_CSR_BOOT_STAGE_ABORT_HANDLER);
+	return	data->boot_stage_cache & BTINTEL_PCIE_CSR_BOOT_STAGE_ABORT_HANDLER;
 }
 
 static void btintel_pcie_msix_gp1_handler(struct btintel_pcie_data *data)
@@ -926,7 +925,8 @@ static void btintel_pcie_msix_gp0_handler(struct btintel_pcie_data *data)
 		data->img_resp_cache = reg;
 
 	if (btintel_pcie_in_error(data)) {
-		bt_dev_err(data->hdev, "Controller in error state");
+		bt_dev_err(data->hdev, "Controller in error state: boot_stage: 0x%8.8x",
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

