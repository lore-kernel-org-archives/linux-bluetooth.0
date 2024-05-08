Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C036D3613C
	for <linux-bluetooth@vger.kernel.org>; Wed,  8 May 2024 09:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715161504; cv=none; b=nkB5NIawrM4YS8QiW6NdJUB7Qlxnz7z9vjggQLWZA8JE5DE3qL3HybPiapfXUcxxXQBgYpyhx03PQ7VGkxCPb6aLxSaLUCBxta6jilliUl2JNRJtDi6X4E7SqDd01Kp92p8j47+41CrwTYW6XclnEFt6S/Y7iT30+1U+o0mZ82k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715161504; c=relaxed/simple;
	bh=2xUbuw7RH488C/jqE6ZEa+R9HjbuQ/2thRQUWOPgqpc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=o/XtsVZ4wEhRa1sCj3wNMSHbqrkocxHbO80f5djSNq1KK4L7cOl7rv5P25uUwmXyvYcCSd5qBECxtT3tnm66w55XWHBGTVybS33PSzsXauLnPEAKPLJfEja0T2D9HVsjBkp9u1On79nkWd2yTilHf+VSgDADd9mCcd3lAseEXWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dDZiNGkg; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dDZiNGkg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715161502; x=1746697502;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2xUbuw7RH488C/jqE6ZEa+R9HjbuQ/2thRQUWOPgqpc=;
  b=dDZiNGkglzc+fQuNssGbh9Hm+veP40Ts3DWQX5GEbCUuB3P4oP458nUR
   MOLyNupXM0rxUSbftbCFsYoJkpfJIXJ8xhEleJTK8H4nCyt3Px/K5EWsD
   0BpqaKd6rF8ZhbTCjaYOvNLySbaaANHLycaag7dC6CJ1siPTwko4rri+t
   UeWl7wO9hFEcjYgxhtTN+PimJOATp8zH7hKDlHzbxjmm72t7XqxF6vXAD
   HdrEdojme69oX2ny7GPA78M4UYwwzhwkvyHXZ8pvlbjh+ZEw1umjpo/Ry
   1UUN+yIZiI06pTMCHwvtcqPM/+cA91k6G4+K5Y3iCoC07b9jKhGu7Qvrr
   g==;
X-CSE-ConnectionGUID: r12hlSqeRTCgvQfSNLFhgg==
X-CSE-MsgGUID: fSZK3xYISM+n7hrXx+ghAQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="22416901"
X-IronPort-AV: E=Sophos;i="6.08,144,1712646000"; 
   d="scan'208";a="22416901"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 02:45:02 -0700
X-CSE-ConnectionGUID: Ign8QkNzSqORXw/dYv//cA==
X-CSE-MsgGUID: XzC6pEfQQuamwWpwuR9L4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,144,1712646000"; 
   d="scan'208";a="33384554"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by fmviesa004.fm.intel.com with ESMTP; 08 May 2024 02:45:01 -0700
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com,
	chandrashekar.devegowda@intel.com,
	Kiran K <kiran.k@intel.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH v1 1/2] Bluetooth: btintel_pcie: Fix compiler warnings
Date: Wed,  8 May 2024 15:29:26 +0530
Message-Id: <20240508095927.155528-1-kiran.k@intel.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix compiler warnings reported by kernel bot.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202405080647.VRBej6fA-lkp@intel.com/
Signed-off-by: Kiran K <kiran.k@intel.com>
---
 drivers/bluetooth/btintel_pcie.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index e9bc4b673424..2853ab80079d 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -251,7 +251,6 @@ static void btintel_pcie_reset_bt(struct btintel_pcie_data *data)
 static int btintel_pcie_enable_bt(struct btintel_pcie_data *data)
 {
 	int err;
-	u32 reg;
 
 	data->gp0_received = false;
 
@@ -259,7 +258,7 @@ static int btintel_pcie_enable_bt(struct btintel_pcie_data *data)
 	btintel_pcie_wr_reg32(data, BTINTEL_PCIE_CSR_CI_ADDR_LSB_REG,
 			      data->ci_p_addr & 0xffffffff);
 	btintel_pcie_wr_reg32(data, BTINTEL_PCIE_CSR_CI_ADDR_MSB_REG,
-			      data->ci_p_addr >> 32);
+			      (u64)data->ci_p_addr >> 32);
 
 	/* Reset the cached value of boot stage. it is updated by the MSI-X
 	 * gp0 interrupt handler.
@@ -267,7 +266,7 @@ static int btintel_pcie_enable_bt(struct btintel_pcie_data *data)
 	data->boot_stage_cache = 0x0;
 
 	/* Set MAC_INIT bit to start primary bootloader */
-	reg = btintel_pcie_rd_reg32(data, BTINTEL_PCIE_CSR_FUNC_CTRL_REG);
+	btintel_pcie_rd_reg32(data, BTINTEL_PCIE_CSR_FUNC_CTRL_REG);
 
 	btintel_pcie_set_reg_bits(data, BTINTEL_PCIE_CSR_FUNC_CTRL_REG,
 				  BTINTEL_PCIE_CSR_FUNC_CTRL_MAC_INIT);
@@ -285,7 +284,7 @@ static int btintel_pcie_enable_bt(struct btintel_pcie_data *data)
 				  BTINTEL_PCIE_CSR_FUNC_CTRL_FUNC_ENA |
 				  BTINTEL_PCIE_CSR_FUNC_CTRL_FUNC_INIT);
 
-	reg = btintel_pcie_rd_reg32(data, BTINTEL_PCIE_CSR_FUNC_CTRL_REG);
+	btintel_pcie_rd_reg32(data, BTINTEL_PCIE_CSR_FUNC_CTRL_REG);
 
 	/* wait for interrupt from the device after booting up to primary
 	 * bootloader.
@@ -525,7 +524,6 @@ static void btintel_pcie_msix_rx_handle(struct btintel_pcie_data *data)
 	u16 cr_hia, cr_tia;
 	struct rxq *rxq;
 	struct urbd1 *urbd1;
-	struct frbd *frbd;
 	struct data_buf *buf;
 	int ret;
 	struct hci_dev *hdev = data->hdev;
@@ -550,8 +548,6 @@ static void btintel_pcie_msix_rx_handle(struct btintel_pcie_data *data)
 		urbd1 = &rxq->urbd1s[cr_tia];
 		ipc_print_urbd1(data->hdev, urbd1, cr_tia);
 
-		frbd = &rxq->frbds[urbd1->frbd_tag];
-
 		buf = &rxq->bufs[urbd1->frbd_tag];
 		if (!buf) {
 			bt_dev_err(hdev, "RXQ: failed to get the DMA buffer for %d",
-- 
2.40.1

