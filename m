Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56BBA323E
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Oct 2025 04:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760588058; cv=none; b=q/tisfrf7cWFeEQYXkVLrjxEHfUmOdbuvSTEHGVIp/lx5RFdpkg21CU0502sEvI2HKciXBVjXnRveP2gyddxYQbNKXKEUBxQ19DQc0sBhfowYO+MUAB9URWnW1FeBdOX5ZOtITCfZ+GlpXXSzp0y6203viylcfLLvxkCGXM3a5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760588058; c=relaxed/simple;
	bh=TQkMk1eC8FnHMd8vHLXqQPK3DcHSP9vOwpFkgHTI+X8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UjBZ917Be7GoYO89AfYmebm4RAX/aIGIuN/e63NGRCGxOKmEIJGJ2LRY+9FMMx+RDrhkb34FGxkpngH/+LFJSQXJTZaZ7eLTQt/EXCg5fJJXrG9cOfSqv4mWoa55uqCx3IX39xanCO29dHPCsKsci19uVQm4OtEgv6JSdvcG97I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Af4Km3UJ; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Af4Km3UJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760588057; x=1792124057;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=TQkMk1eC8FnHMd8vHLXqQPK3DcHSP9vOwpFkgHTI+X8=;
  b=Af4Km3UJXU4BK0rfKstjZWNC1G42JUAyGLyVn0TD+sxh9a0i2uqmEhch
   4mhSXuZNzSRv+pWjnFWFxwvDCbgZblEoriLvr52SYalDWIeSLiChUguxS
   aD8ZYS+KI7g/uTIfmvWPvfq+cg7QWmrqFm23g+YMksgJqzsmRywZbX4S/
   C61cHj//ICCrEfyyxgeuvknQPWVKXTJSkyXF4OZxq8BeWJXezApuLmOKx
   GnrfNwPhLlg+hm2tKuybJ4bK9Fq43UIuFrruw10Q6dHmwThEbSzswTAri
   gNtLV/K1ID5bp7U0PG4JUWdKtIjaxQX02AWaI+xbkLsug1z2EmZmpWKT9
   Q==;
X-CSE-ConnectionGUID: t3WYghlOTjKnSKiaqOfI8g==
X-CSE-MsgGUID: vARFsWnfRACkZYjSPrycbg==
X-IronPort-AV: E=McAfee;i="6800,10657,11583"; a="73052561"
X-IronPort-AV: E=Sophos;i="6.19,233,1754982000"; 
   d="scan'208";a="73052561"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 21:14:16 -0700
X-CSE-ConnectionGUID: bYYtYPYZS9WIN4H2KLZDZg==
X-CSE-MsgGUID: kf0t2fhwTheOuJ+TZutkHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,233,1754982000"; 
   d="scan'208";a="206047687"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by fmviesa002.fm.intel.com with ESMTP; 15 Oct 2025 21:14:13 -0700
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com,
	Kiran K <kiran.k@intel.com>,
	Sai Teja Aluvala <aluvala.sai.teja@intel.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>
Subject: [PATCH v2] Bluetooth: btintel_pcie: Fix event packet loss issue
Date: Thu, 16 Oct 2025 10:00:43 +0530
Message-ID: <20251016043043.2582230-1-kiran.k@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the current btintel_pcie driver implementation, when an interrupt is
received, the driver checks for the alive cause before the TX/RX cause.
Handling the alive cause involves resetting the TX/RX queue indices.
This flow works correctly when the causes are mutually exclusive.
However, if both cause bits are set simultaneously, the alive cause
resets the queue indices, resulting in an event packet drop and a
command timeout. To fix this issue, the driver is modified to handle all
other causes before checking for the alive cause.

Test case:
Issue is seen with stress reboot scenario - 50x run

[20.337589] Bluetooth: hci0: Device revision is 0
[20.346750] Bluetooth: hci0: Secure boot is enabled
[20.346752] Bluetooth: hci0: OTP lock is disabled
[20.346752] Bluetooth: hci0: API lock is enabled
[20.346752] Bluetooth: hci0: Debug lock is disabled
[20.346753] Bluetooth: hci0: Minimum firmware build 1 week 10 2014
[20.346754] Bluetooth: hci0: Bootloader timestamp 2023.43 buildtype 1 build 11631
[20.359070] Bluetooth: hci0: Found device firmware: intel/ibt-00a0-00a1-iml.sfi
[20.371499] Bluetooth: hci0: Boot Address: 0xb02ff800
[20.385769] Bluetooth: hci0: Firmware Version: 166-34.25
[20.538257] Bluetooth: hci0: Waiting for firmware download to complete
[20.554424] Bluetooth: hci0: Firmware loaded in 178651 usecs
[21.081588] Bluetooth: hci0: Timeout (500 ms) on tx completion
[21.096541] Bluetooth: hci0: Failed to send frame (-62)
[21.110240] Bluetooth: hci0: sending frame failed (-62)
[21.138551] Bluetooth: hci0: Failed to send Intel Reset command
[21.170153] Bluetooth: hci0: Intel Soft Reset failed (-62)

Signed-off-by: Kiran K <kiran.k@intel.com>
Signed-off-by: Sai Teja Aluvala <aluvala.sai.teja@intel.com>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Fixes: c2b636b3f788 ("Bluetooth: btintel_pcie: Add support for PCIe transport")
---
changes in v2:
- Update commit message with test case details and dmesg.

 drivers/bluetooth/btintel_pcie.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index 6d3963bd56a9..a075d8ec4677 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -1467,11 +1467,6 @@ static irqreturn_t btintel_pcie_irq_msix_handler(int irq, void *dev_id)
 	if (intr_hw & BTINTEL_PCIE_MSIX_HW_INT_CAUSES_GP1)
 		btintel_pcie_msix_gp1_handler(data);
 
-	/* This interrupt is triggered by the firmware after updating
-	 * boot_stage register and image_response register
-	 */
-	if (intr_hw & BTINTEL_PCIE_MSIX_HW_INT_CAUSES_GP0)
-		btintel_pcie_msix_gp0_handler(data);
 
 	/* For TX */
 	if (intr_fh & BTINTEL_PCIE_MSIX_FH_INT_CAUSES_0) {
@@ -1487,6 +1482,12 @@ static irqreturn_t btintel_pcie_irq_msix_handler(int irq, void *dev_id)
 			btintel_pcie_msix_tx_handle(data);
 	}
 
+	/* This interrupt is triggered by the firmware after updating
+	 * boot_stage register and image_response register
+	 */
+	if (intr_hw & BTINTEL_PCIE_MSIX_HW_INT_CAUSES_GP0)
+		btintel_pcie_msix_gp0_handler(data);
+
 	/*
 	 * Before sending the interrupt the HW disables it to prevent a nested
 	 * interrupt. This is done by writing 1 to the corresponding bit in
-- 
2.43.0

