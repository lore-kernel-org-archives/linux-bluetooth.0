Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0691D0DEE
	for <linux-bluetooth@vger.kernel.org>; Sat,  6 Jun 2026 00:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780705033; cv=none; b=Rb+abB/hjtZPgilb2bsrgWvVWU5/hKeO5pmoIRiRuyGcaRY+fEnYJha4zYK5mqZIzRFbI9eyBiN/mOgAdxPwV1wJwshuIx9qWn9YI2X0JwaIplfHbO1HOW3r9YlB9SfDFC6RgwQQcmq220sCBZw49PMQvcpT2M9D9AOqJdBBZK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780705033; c=relaxed/simple;
	bh=q5y43Zu/SkNREXt+ZPWx/AARwYfDd/w4NtbhBczKEkI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t0NoR/PK4Abcc3sKvlNp6BvF9AOTWQDMBajNim+P5zgZVbuVNmt/wsNOyUnABBFZ+jaO5NDaEGYQArHJe+aTQ6uoCbTUMTVA7xuaBH208sEKeO1NX97+rN3ecQMGnDWcTl58hYWsT0NnCPD9k1LDCXrPfplwN6NmK1B4p9jKU2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I9RJemCS; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I9RJemCS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780705030; x=1812241030;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=q5y43Zu/SkNREXt+ZPWx/AARwYfDd/w4NtbhBczKEkI=;
  b=I9RJemCS4NEgoA2pzqrs0jjSgx7hMJuGbhkZ+AUaDOfJbEkQ42z+rWDR
   HY26ClB7xdsK4hgSeg/sqZDMJbAvpJzaBSYfuerxjHoZKXONGDWXkvQoC
   /TPewzUueYlygYpl0VNkEeGfp6FIXlpoqE0IsRQCaUTKtF9jKl4xQHt9r
   sdY3Kyp6lPXyZMW2jgSuemYbPStAVSwLjsvdOiJ9olmQt1fkA6jbxxwSu
   iiB5vX9RbNoXQrtvJFhY+7xA41ZaoQsvsKVR4oGaghzckZ55267UoTp2C
   tdhG1oeGrzR5OohqvBrhZl972LRUkF30NIA0+gE5Na0tie/WrhhQPCw4n
   Q==;
X-CSE-ConnectionGUID: OsKW72WlSlW6vOTK2EBw1Q==
X-CSE-MsgGUID: 3Pwgy/LXR+qjiCckNmiGnA==
X-IronPort-AV: E=McAfee;i="6800,10657,11808"; a="81288988"
X-IronPort-AV: E=Sophos;i="6.24,189,1774335600"; 
   d="scan'208";a="81288988"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2026 17:17:10 -0700
X-CSE-ConnectionGUID: +DQrjPX3RMOfdtQZ+Q/aKA==
X-CSE-MsgGUID: vHC9BsgpQzOjlPBpTZJTQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,189,1774335600"; 
   d="scan'208";a="238623960"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by fmviesa009.fm.intel.com with ESMTP; 05 Jun 2026 17:17:05 -0700
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com,
	chandrashekar.devegowda@intel.com,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH v1] Bluetooth: btintel_pcie: Add 50 ms delay before MAC init on BlazarIW
Date: Sat,  6 Jun 2026 06:06:37 +0530
Message-ID: <20260606003637.94628-1-kiran.k@intel.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On BlazarIW, fast restart cycles fail because the D0 entry to MAC
init does not complete in time. As a result, MAC initialization
does not proceed and the controller fails to transition past the
ROM boot stage.

Add a 50 ms delay (worst case as per HW analysis) before doing MAC
init in btintel_pcie_enable_bt() so the shared hardware reset flow
has time to complete. The delay is gated on the BlazarIW PCI device
id 0x4D76 so other Intel BT PCIe controllers are unaffected.

Signed-off-by: Kiran K <kiran.k@intel.com>
---
 drivers/bluetooth/btintel_pcie.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index 2baef130d101..b09878d71025 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -799,6 +799,11 @@ static void btintel_pcie_dump_traces(struct hci_dev *hdev)
 		bt_dev_err(hdev, "Failed to dump traces: (%d)", ret);
 }
 
+static bool btintel_pcie_is_blazariw(struct pci_dev *pdev)
+{
+	return pdev->device == 0x4D76;
+}
+
 /* This function enables BT function by setting BTINTEL_PCIE_CSR_FUNC_CTRL_MAC_INIT bit in
  * BTINTEL_PCIE_CSR_FUNC_CTRL_REG register and wait for MSI-X with
  * BTINTEL_PCIE_MSIX_HW_INT_CAUSES_GP0.
@@ -818,6 +823,14 @@ static int btintel_pcie_enable_bt(struct btintel_pcie_data *data)
 	btintel_pcie_wr_reg32(data, BTINTEL_PCIE_CSR_CI_ADDR_MSB_REG,
 			      (u64)data->ci_p_addr >> 32);
 
+	/* On BlazarIW, the D0 entry to MAC init does not complete in
+	 * time. Wait 50 ms (worst case as per HW analysis) for the
+	 * shared hardware reset flow to complete before proceeding with
+	 * MAC init.
+	 */
+	if (btintel_pcie_is_blazariw(data->pdev))
+		msleep(50);
+
 	/* Reset the cached value of boot stage. it is updated by the MSI-X
 	 * gp0 interrupt handler.
 	 */
-- 
2.54.0

