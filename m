Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E14F1E0B67
	for <linux-bluetooth@vger.kernel.org>; Fri,  8 Nov 2024 08:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731056033; cv=none; b=qtOP3klbrM5gtyomgJXiloCOHzTeS3SrmATzGYfareIICjIzr/jt+fZbgyscp64KP6TrdvTqiAEBkOQ30KzUvIXR1lDC/67/vlTol0M75uRxHyoXDv4dZGshpqtER8Y1d+aY0iFfajZKzizzTzTBR8SBFGgL2B/SH643kfnH5DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731056033; c=relaxed/simple;
	bh=57Bdm0d2A360agOcbxEocWypC1x7qEkttD6y9eh8mJc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=T34kgGhQw0NxW1SgwGdYe8KLqi0AOEd4bGr6U6yZXO7ASlb7xYkmSQgKUfW3wTMnCXCTitQH92n3IUtE87iJiRFLiicS/7hdE7vDZ2EUinhaUDUaRZ3mBznYqOrg70BCYzaWEEY8aMibusZ9rWENAov3vPpA/xZn1fMMptYGQE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e3u7ySa/; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e3u7ySa/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731056032; x=1762592032;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=57Bdm0d2A360agOcbxEocWypC1x7qEkttD6y9eh8mJc=;
  b=e3u7ySa/ttWAHAkNjdSZ1AKkoS543myfdvV/vCLBe55rHBkfwNaYeUs+
   u2cXni4XC5aha0k5G9bVXmHMKMBIEfDh9i3ICkqesIa4TuAI+QoUPTChQ
   8D2p3U8Sj2QRHvPeFXCQwNCkMvoAxD8AsMYd1Eph54yacYC4ErScI0w5G
   Fw2KrDNwhFXT+Sx/g5+IMoM21WHoYpgPALi/XLnmgvcjwTTT6fwpr1hbs
   cltTW7mEv5MKKaT2rFgO74s+DAB6EZyP2W8WB3rRZj/avqi0M3l5pF3mw
   r0DjwRjM7kkWLKOI2OJYcXvWeNs0Aev1bO9TkT2pmgK19LbOwVMi96M4E
   g==;
X-CSE-ConnectionGUID: QJwKQgtLTimXk415FTiwGw==
X-CSE-MsgGUID: ANwlCrbqR224GZbvD/EeWQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="31098320"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="31098320"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2024 00:53:51 -0800
X-CSE-ConnectionGUID: 56pdFxV7SN6mSQ3ug191cg==
X-CSE-MsgGUID: U+LI7bEIQBKDkZgluxNrew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,137,1728975600"; 
   d="scan'208";a="85076186"
Received: from bsinu234.iind.intel.com ([10.66.226.187])
  by fmviesa007.fm.intel.com with ESMTP; 08 Nov 2024 00:53:49 -0800
From: ChandraShekar Devegowda <chandrashekar.devegowda@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com,
	ChandraShekar Devegowda <chandrashekar.devegowda@intel.com>,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH v2] Bluetooth: btintel_pcie: Support suspend-resume
Date: Fri,  8 Nov 2024 16:39:31 +0200
Message-Id: <20241108143931.2422947-1-chandrashekar.devegowda@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch contains the changes in driver for vendor specific handshake
during enter of D3 and D0 exit.
Command to test host initiated wake up after 60seconds
    sudo rtcwake -m mem-s 60
logs from testing:
    Bluetooth: hci0: BT device resumed to D0 in 1016 usecs

Signed-off-by: Kiran K <kiran.k@intel.com>
Signed-off-by: ChandraShekar Devegowda <chandrashekar.devegowda@intel.com>
---
 drivers/bluetooth/btintel_pcie.c | 58 ++++++++++++++++++++++++++++++++
 drivers/bluetooth/btintel_pcie.h |  4 +++
 2 files changed, 62 insertions(+)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index 2b79952f3628..49b78d3ecdf9 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -273,6 +273,12 @@ static int btintel_pcie_reset_bt(struct btintel_pcie_data *data)
 	return reg == 0 ? 0 : -ENODEV;
 }
 
+static void btintel_pcie_set_persistence_mode(struct btintel_pcie_data *data)
+{
+	btintel_pcie_set_reg_bits(data, BTINTEL_PCIE_CSR_HW_BOOT_CONFIG,
+				  BTINTEL_PCIE_CSR_HW_BOOT_CONFIG_KEEP_ON);
+}
+
 /* This function enables BT function by setting BTINTEL_PCIE_CSR_FUNC_CTRL_MAC_INIT bit in
  * BTINTEL_PCIE_CSR_FUNC_CTRL_REG register and wait for MSI-X with
  * BTINTEL_PCIE_MSIX_HW_INT_CAUSES_GP0.
@@ -297,6 +303,8 @@ static int btintel_pcie_enable_bt(struct btintel_pcie_data *data)
 	 */
 	data->boot_stage_cache = 0x0;
 
+	btintel_pcie_set_persistence_mode(data);
+
 	/* Set MAC_INIT bit to start primary bootloader */
 	reg = btintel_pcie_rd_reg32(data, BTINTEL_PCIE_CSR_FUNC_CTRL_REG);
 	reg &= ~(BTINTEL_PCIE_CSR_FUNC_CTRL_FUNC_INIT |
@@ -1647,11 +1655,61 @@ static void btintel_pcie_remove(struct pci_dev *pdev)
 	pci_set_drvdata(pdev, NULL);
 }
 
+static int btintel_pcie_suspend(struct device *dev)
+{
+	struct btintel_pcie_data *data;
+	int err;
+	struct  pci_dev *pdev = to_pci_dev(dev);
+
+	data = pci_get_drvdata(pdev);
+	data->gp0_received = false;
+	btintel_pcie_wr_sleep_cntrl(data, BTINTEL_PCIE_STATE_D3_HOT);
+	err = wait_event_timeout(data->gp0_wait_q, data->gp0_received,
+				 msecs_to_jiffies(BTINTEL_DEFAULT_INTR_TIMEOUT_MS));
+	if (!err) {
+		bt_dev_err(data->hdev, "failed to receive gp0 interrupt for suspend in %lu msecs",
+			   BTINTEL_DEFAULT_INTR_TIMEOUT_MS);
+		return -EBUSY;
+	}
+	return 0;
+}
+
+static int btintel_pcie_resume(struct device *dev)
+{
+	struct btintel_pcie_data *data;
+	struct  pci_dev *pdev = to_pci_dev(dev);
+	ktime_t calltime, delta, rettime;
+	unsigned long long duration;
+	int err;
+
+	data = pci_get_drvdata(pdev);
+	data->gp0_received = false;
+	calltime = ktime_get();
+	btintel_pcie_wr_sleep_cntrl(data, BTINTEL_PCIE_STATE_D0);
+	err = wait_event_timeout(data->gp0_wait_q, data->gp0_received,
+				 msecs_to_jiffies(BTINTEL_DEFAULT_INTR_TIMEOUT_MS));
+	if (!err) {
+		bt_dev_err(data->hdev, "failed to receive gp0 interrupt for resume in %lu msecs",
+			   BTINTEL_DEFAULT_INTR_TIMEOUT_MS);
+		return -EBUSY;
+	}
+	rettime = ktime_get();
+	delta = ktime_sub(rettime, calltime);
+	duration = (unsigned long long)ktime_to_ns(delta) >> 10;
+	bt_dev_info(data->hdev, "BT device resumed to D0 in %llu usecs", duration);
+
+	return 0;
+}
+
+static SIMPLE_DEV_PM_OPS(btintel_pcie_pm_ops, btintel_pcie_suspend,
+		btintel_pcie_resume);
+
 static struct pci_driver btintel_pcie_driver = {
 	.name = KBUILD_MODNAME,
 	.id_table = btintel_pcie_table,
 	.probe = btintel_pcie_probe,
 	.remove = btintel_pcie_remove,
+	.driver.pm = &btintel_pcie_pm_ops,
 };
 module_pci_driver(btintel_pcie_driver);
 
diff --git a/drivers/bluetooth/btintel_pcie.h b/drivers/bluetooth/btintel_pcie.h
index f9aada0543c4..38d0c8ea2b6f 100644
--- a/drivers/bluetooth/btintel_pcie.h
+++ b/drivers/bluetooth/btintel_pcie.h
@@ -8,6 +8,7 @@
 
 /* Control and Status Register(BTINTEL_PCIE_CSR) */
 #define BTINTEL_PCIE_CSR_BASE			(0x000)
+#define BTINTEL_PCIE_CSR_HW_BOOT_CONFIG		(BTINTEL_PCIE_CSR_BASE + 0x000)
 #define BTINTEL_PCIE_CSR_FUNC_CTRL_REG		(BTINTEL_PCIE_CSR_BASE + 0x024)
 #define BTINTEL_PCIE_CSR_HW_REV_REG		(BTINTEL_PCIE_CSR_BASE + 0x028)
 #define BTINTEL_PCIE_CSR_RF_ID_REG		(BTINTEL_PCIE_CSR_BASE + 0x09C)
@@ -48,6 +49,9 @@
 #define BTINTEL_PCIE_CSR_MSIX_IVAR_BASE		(BTINTEL_PCIE_CSR_MSIX_BASE + 0x0880)
 #define BTINTEL_PCIE_CSR_MSIX_IVAR(cause)	(BTINTEL_PCIE_CSR_MSIX_IVAR_BASE + (cause))
 
+/* CSR HW BOOT CONFIG Register */
+#define BTINTEL_PCIE_CSR_HW_BOOT_CONFIG_KEEP_ON		(BIT(31))
+
 /* Causes for the FH register interrupts */
 enum msix_fh_int_causes {
 	BTINTEL_PCIE_MSIX_FH_INT_CAUSES_0	= BIT(0),	/* cause 0 */
-- 
2.34.1

