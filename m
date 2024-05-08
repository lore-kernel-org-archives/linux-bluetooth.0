Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4619A79F6
	for <linux-bluetooth@vger.kernel.org>; Wed,  8 May 2024 00:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715129405; cv=none; b=glFdG1XIhmODRHa0hpk3Q2R90452J8/lLdonL6+1AXjGR4AwkN84sabQI5ezZCR4gA38fZt9/ubUGMVIXcQlsxhnQnE9N5HOS/ZXuLNRyOK73SI1zrblup0NpxbwdWbVcuBz0aQe4/SQHaDRP3H7N3qVv3nM233oGRC8CG9IEUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715129405; c=relaxed/simple;
	bh=2xUbuw7RH488C/jqE6ZEa+R9HjbuQ/2thRQUWOPgqpc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ECymOb2yi6jZtBO3WD/5ugbPjuCi3mmnDxrjFjQ8dB2JyUlmJk5MCbplG4ZRxjGvxMV7iaQRpWVHLFcelUxpjUEgqd/oExsmIQrBssjPPah4j65PVKCmBa7vvIynUuw/6DBdFZH1c/U+Sm2ceo0jbR50aUYxdY/koJOWUT0e2AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NTLZaWJC; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NTLZaWJC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715129404; x=1746665404;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2xUbuw7RH488C/jqE6ZEa+R9HjbuQ/2thRQUWOPgqpc=;
  b=NTLZaWJCDjoClMEezLlqOAuAWMvouTH296Sh4Q5XqsPmB+W7U9Qw8llN
   FTxShs0Zu4EHtQJTgIC4oCnpbp+vsb6YBe4hZ6HY++xRtVvtPjAdoyR2h
   C15b/Zr32cgypdPtdBCp3Chmrmtylq9GmX1czi8TzvRxOqPiHALt15Adw
   9raXQfmhh2H//bvWyCTpBp52bc+6AZa1ihVWQzbrREHCVyUT74HabFqEc
   k1oUHggq0w2PSwUz02nPXXKR8SCnXxTBvBqvpdZ1wwCEQGPkif/ZAv6mX
   qQAj9EsTcUKhqtW5KoRf4NBdWJ8cZnQAqn20VSS87OSIMnKTdELYCGpCx
   w==;
X-CSE-ConnectionGUID: Yfb1N09nTAS99d9rO9DX/w==
X-CSE-MsgGUID: J5EV+dedTf6lWLr66h0h3g==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="10830771"
X-IronPort-AV: E=Sophos;i="6.08,143,1712646000"; 
   d="scan'208";a="10830771"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 17:50:04 -0700
X-CSE-ConnectionGUID: jSwYZyziS2ON+Fn2SMOt2A==
X-CSE-MsgGUID: dTccEUmERd+pyWhwxjx04Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,143,1712646000"; 
   d="scan'208";a="28658263"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by fmviesa008.fm.intel.com with ESMTP; 07 May 2024 17:50:02 -0700
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com,
	chandrashekar.devegowda@intel.com,
	Kiran K <kiran.k@intel.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH v1] Bluetooth: btintel_pcie: Fix compiler warnings
Date: Wed,  8 May 2024 06:34:31 +0530
Message-Id: <20240508010431.25687-1-kiran.k@intel.com>
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

