Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEDA8292B4B
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Oct 2025 09:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760522292; cv=none; b=YkEH6Sky1IdIopna65RRmKAD6I2my5NagGW+Guw7X4aXeCmHp36lexeNVn4zjmV0jGWQWPVE7Ezwdya9ZHPD1CHMDcitKm0HY9RMNa6DHlJw/eJFhEP090tQ0qXuLOBlOi4slpmvZIt8nFzqbPsfFWNvFmmh7QGwuy3XyKu5GEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760522292; c=relaxed/simple;
	bh=1W19hU7gHNkmU6LqjY3NEGrx5t4oyeI7IdrXaoZYJ/k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AM1wtoTkpzl0cyO2SQf5X3ngWfe9YD4g/hwVUwHHFMfHPXNfXPd/z5I/icr4xz8quOv5WV517mRocPJsK7f0344ztBjVVh5/ywaYnAGfjmsIJK9E092+TWT10UYqzeMqoOD+ABHq5mjZodmSZC4NN8JZz6daFyY9Ywj3SRM02nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BkmjM+xj; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BkmjM+xj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760522291; x=1792058291;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1W19hU7gHNkmU6LqjY3NEGrx5t4oyeI7IdrXaoZYJ/k=;
  b=BkmjM+xjQEZpvUjlu+4GL47/+ptzlAlPtToMPI7F/mb7GCF2pRXe4T49
   gjuSuQTVeUpyRoOppXnVEXpxOwagJb/u7OtnIFNsUkju+jt413vg/HEnq
   aphSTUVwa+TLw5IAQQ9lXeDpRUagjWtfFZ+Uoqwyt4/BE7wBxd3CygpM3
   1Ybho/afOetH9Z3x3qbiGHMvHdHFHYmuhGN+E2EwJKm9MSBZO4GXhBWrL
   mOo69jgC2gR+8JsuSSUDLhasNaAzlsXkadvQwZpJ2FDZPWPzCM8A9TO8k
   qE4+hpHY25uYO8sxMbaN1ZQ6D5WsKQR48Cwa4U1E6USAdJ5yXCegKs0C0
   g==;
X-CSE-ConnectionGUID: JP4TziF6QnG7eqBMo7nmfw==
X-CSE-MsgGUID: YB0lcRCfQZem2EVlWf6k7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11582"; a="62588604"
X-IronPort-AV: E=Sophos;i="6.19,231,1754982000"; 
   d="scan'208";a="62588604"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 02:58:10 -0700
X-CSE-ConnectionGUID: nZT+oalbQpyXejdLwstNNg==
X-CSE-MsgGUID: Pm6pNWKCQx+394xOM3WTEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,231,1754982000"; 
   d="scan'208";a="182914820"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by fmviesa010.fm.intel.com with ESMTP; 15 Oct 2025 02:58:08 -0700
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com,
	Kiran K <kiran.k@intel.com>,
	Sai Teja Aluvala <aluvala.sai.teja@intel.com>
Subject: [PATCH v1] Bluetooth: btintel_pcie: Fix event packet loss issue
Date: Wed, 15 Oct 2025 15:44:36 +0530
Message-ID: <20251015101436.2579377-1-kiran.k@intel.com>
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

Signed-off-by: Kiran K <kiran.k@intel.com>
Signed-off-by: Sai Teja Aluvala <aluvala.sai.teja@intel.com>
Fixes: c2b636b3f788 ("Bluetooth: btintel_pcie: Add support for PCIe transport")
---
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

