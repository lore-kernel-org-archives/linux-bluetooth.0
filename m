Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C751F22F173
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Jun 2025 13:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749563052; cv=none; b=gPlHBoiLib/mKFZsB+qbLKIxyGF+MFoAEjDrtdfSJ3vpVgZBPccJ2KAJXc134xRJjHGEIZBQAL8T/k7v8C9JYKIpkuZVWh36hd4jtRlYYjGTyfYRgWmKXO55K7zCfFNIBMHwHhDtCqBE2NeEf8UJpbCqW36nihDqexGKLwz2Z8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749563052; c=relaxed/simple;
	bh=9guK9FLVhYjtxY6iGfWoaeWfxbcnSvsPqbtLiiiaJvo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rhY83ZYuaNGGPeRldzJB+dRAcyzpkEQtfTIrSCRU/d7NFCXYAT9tuU7vY+aSUOzRaFx61klaCqGFLgPe5O+OqWhP9akb8OQ1lqx7l1xaPRemk+Q+kY5Gbl/YmbxKfsS4tnPZHBnfzYKq+SbHf1RZN/A7LKOz5k9E7lPgma6JTTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LvuLHHj8; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LvuLHHj8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749563051; x=1781099051;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9guK9FLVhYjtxY6iGfWoaeWfxbcnSvsPqbtLiiiaJvo=;
  b=LvuLHHj8VhGAwWxKzaRCLl3iVBvNRpLw7Qz4xZJdS0Bn4hGolt/k5WlR
   BnNx9FrfQf0OtUzHte01orfLg5cck5MZKsIlB2klTBB0p/HhJis/OAkkb
   oUmEbi012gyDvPSHZScKB7wqXhTDzLNFYBypMvvsP4WCHR3niTYRipgfo
   0zStEhE72wYime7Cx707uSvQ5ex2WLbb0Tv8S38HMf2u8yom4QaDbNGsZ
   RI6rhb8YsKjiZ0l1cBJspyA8y2hAMx+Y8nQV0bSngKupi5FQZxcg+SMwi
   e9P6Xp4Ivw7wkul7TN8sG1Dp0EpSd+WNVP42BXD8Okg1PRIYV+LaOszI/
   Q==;
X-CSE-ConnectionGUID: 6qAuk93VTHG9yn33s0b1KQ==
X-CSE-MsgGUID: aANwzbaURaifXVuqw0ROAQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11460"; a="62328968"
X-IronPort-AV: E=Sophos;i="6.16,225,1744095600"; 
   d="scan'208";a="62328968"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 06:44:10 -0700
X-CSE-ConnectionGUID: 58NWmO3ET4yJ2pE53wPhMA==
X-CSE-MsgGUID: vdQ785JDQBCdS5zjsrcvkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,225,1744095600"; 
   d="scan'208";a="146748875"
Received: from unknown (HELO intel-Lenovo-Legion-Y540-15IRH-PG0.iind.intel.com) ([10.224.186.95])
  by orviesa006.jf.intel.com with ESMTP; 10 Jun 2025 06:44:08 -0700
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com,
	chandrashekar.devegowda@intel.com,
	aluvala.sai.teja@intel.com,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH v3 1/2] Bluetooth: btintel_pcie: Fix potential race condition in firmware download
Date: Tue, 10 Jun 2025 19:30:37 +0530
Message-ID: <20250610140038.696091-1-kiran.k@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During firmware download, if an error occurs, interrupts must be
disabled, synchronized, and re-enabled before retrying the download.
This change ensures proper interrupt handling to prevent race
conditions.

Signed-off-by: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
Signed-off-by: Kiran K <kiran.k@intel.com>
---
 drivers/bluetooth/btintel_pcie.c | 33 ++++++++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index 563165c5efae..e1c688dd2d45 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -2033,6 +2033,28 @@ static void btintel_pcie_release_hdev(struct btintel_pcie_data *data)
 	data->hdev = NULL;
 }
 
+static void btintel_pcie_disable_interrupts(struct btintel_pcie_data *data)
+{
+	spin_lock(&data->irq_lock);
+	btintel_pcie_wr_reg32(data, BTINTEL_PCIE_CSR_MSIX_FH_INT_MASK, data->fh_init_mask);
+	btintel_pcie_wr_reg32(data, BTINTEL_PCIE_CSR_MSIX_HW_INT_MASK, data->hw_init_mask);
+	spin_unlock(&data->irq_lock);
+}
+
+static void btintel_pcie_enable_interrupts(struct btintel_pcie_data *data)
+{
+	spin_lock(&data->irq_lock);
+	btintel_pcie_wr_reg32(data, BTINTEL_PCIE_CSR_MSIX_FH_INT_MASK, ~data->fh_init_mask);
+	btintel_pcie_wr_reg32(data, BTINTEL_PCIE_CSR_MSIX_HW_INT_MASK, ~data->hw_init_mask);
+	spin_unlock(&data->irq_lock);
+}
+
+static void btintel_pcie_synchronize_irqs(struct btintel_pcie_data *data)
+{
+	for (int i = 0; i < data->alloc_vecs; i++)
+		synchronize_irq(data->msix_entries[i].vector);
+}
+
 static int btintel_pcie_setup_internal(struct hci_dev *hdev)
 {
 	struct btintel_pcie_data *data = hci_get_drvdata(hdev);
@@ -2152,6 +2174,8 @@ static int btintel_pcie_setup(struct hci_dev *hdev)
 		bt_dev_err(hdev, "Firmware download retry count: %d",
 			   fw_dl_retry);
 		btintel_pcie_dump_debug_registers(hdev);
+		btintel_pcie_disable_interrupts(data);
+		btintel_pcie_synchronize_irqs(data);
 		err = btintel_pcie_reset_bt(data);
 		if (err) {
 			bt_dev_err(hdev, "Failed to do shr reset: %d", err);
@@ -2159,6 +2183,7 @@ static int btintel_pcie_setup(struct hci_dev *hdev)
 		}
 		usleep_range(10000, 12000);
 		btintel_pcie_reset_ia(data);
+		btintel_pcie_enable_interrupts(data);
 		btintel_pcie_config_msix(data);
 		err = btintel_pcie_enable_bt(data);
 		if (err) {
@@ -2291,6 +2316,12 @@ static void btintel_pcie_remove(struct pci_dev *pdev)
 
 	data = pci_get_drvdata(pdev);
 
+	btintel_pcie_disable_interrupts(data);
+
+	btintel_pcie_synchronize_irqs(data);
+
+	flush_work(&data->rx_work);
+
 	btintel_pcie_reset_bt(data);
 	for (int i = 0; i < data->alloc_vecs; i++) {
 		struct msix_entry *msix_entry;
@@ -2303,8 +2334,6 @@ static void btintel_pcie_remove(struct pci_dev *pdev)
 
 	btintel_pcie_release_hdev(data);
 
-	flush_work(&data->rx_work);
-
 	destroy_workqueue(data->workqueue);
 
 	btintel_pcie_free(data);
-- 
2.43.0

