Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1278E13AA31
	for <linux-bluetooth@vger.kernel.org>; Wed, 23 Oct 2024 06:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729663291; cv=none; b=ltcHNuUTcfzfWAU4EZL1Nez5dCNLjz2ed8hJYIoyj5mJs+pzrYpKoM769qN4JJerabh031PDPA9F0fVjJuiklU6BpUZvifdvK6ukc3HWhVh719EHi0PtZ7viTYoDuYQ4JS6KuyXANhDdEaxS3g4UgJInZkz13k1xUy2zk0cZURs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729663291; c=relaxed/simple;
	bh=hE9n/MYDtAexfsn6RSpH/vmdsBpaMD9/hirvMxFl5To=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WZ/FAfFzQdqIp8mYdhR8pZ8PYbu4IahJBT7xXKCU6NRlCsvVX9NdpOXD9S3VC0gv5eD8dExeJ4YG8DnnHwnKj7bOzm5qqkg0pVV4MdA/vMWNeo7h9MlnQh0ZN/EsVNZNkzKaiBcaO2iQAXitEOsza8vI0Ul/9vl2F9DmfT0ig2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DktmZioN; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DktmZioN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729663289; x=1761199289;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=hE9n/MYDtAexfsn6RSpH/vmdsBpaMD9/hirvMxFl5To=;
  b=DktmZioNtZ9k4hv2rs2M+8g+9EngbKsxTHFlJmK3wcEiX3Ll3HqRbHW4
   YFCdwkXue0YorsbeXjymM7yLPX9JUwexlLAW3zlgc9YK05OSTq70aZtLi
   VYNZYO/KZKagVxMa/UpJj4UzGq2G2jHW6xIJUGRKMUITbFXPesvUrxd/6
   8ME7SBbEZSnzSTmFUCXZfDHvd7KqJ7ztaWYJqMF2uVRen/CYSDUCQyuwf
   m7uuT3ZVQ5Dvg0oJ4SD3dIXgxmWlnVjoF2ZVUIeJsx6riIxyfzvNYIa9J
   kmwEkjar7itiLYYe1Wxy60hX2cnFDhKCshLURWlqIuZdRjsSZpIVrIlOv
   w==;
X-CSE-ConnectionGUID: q2VTrk/jRZCXH769A70aCg==
X-CSE-MsgGUID: oVcisCJbQIiiCOxkMlH69A==
X-IronPort-AV: E=McAfee;i="6700,10204,11233"; a="54631293"
X-IronPort-AV: E=Sophos;i="6.11,225,1725346800"; 
   d="scan'208";a="54631293"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 23:01:26 -0700
X-CSE-ConnectionGUID: KOJz/gAOTmCCGxrA9ufdVw==
X-CSE-MsgGUID: vwkd7GA4RvWfx6ardCLOiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,225,1725346800"; 
   d="scan'208";a="80896194"
Received: from bsinu234.iind.intel.com ([10.66.226.187])
  by orviesa008.jf.intel.com with ESMTP; 22 Oct 2024 23:01:24 -0700
From: ChandraShekar <chandrashekar.devegowda@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com,
	ChandraShekar <chandrashekar.devegowda@intel.com>,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH v1] Bluetooth: btintel_pcie: Device suspend-resume support added
Date: Wed, 23 Oct 2024 14:46:47 +0300
Message-Id: <20241023114647.1011886-1-chandrashekar.devegowda@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch contains the changes in driver to support the suspend and
resume i.e move the controller to D3 state when the platform is entering
into suspend and move the controller to D0 on resume.

Signed-off-by: Kiran K <kiran.k@intel.com>
Signed-off-by: ChandraShekar <chandrashekar.devegowda@intel.com>
---
 drivers/bluetooth/btintel_pcie.c | 52 ++++++++++++++++++++++++++++++++
 drivers/bluetooth/btintel_pcie.h |  4 +++
 2 files changed, 56 insertions(+)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index fd4a8bd056fa..f2c44b9d7328 100644
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
@@ -1653,11 +1661,55 @@ static void btintel_pcie_remove(struct pci_dev *pdev)
 	pci_set_drvdata(pdev, NULL);
 }
 
+static int btintel_pcie_suspend(struct device *dev)
+{
+	struct btintel_pcie_data *data;
+	int err;
+	struct  pci_dev *pdev = to_pci_dev(dev);
+
+	data = pci_get_drvdata(pdev);
+	btintel_pcie_wr_sleep_cntrl(data, BTINTEL_PCIE_STATE_D3_HOT);
+	data->gp0_received = false;
+	err = wait_event_timeout(data->gp0_wait_q, data->gp0_received,
+				 msecs_to_jiffies(BTINTEL_DEFAULT_INTR_TIMEOUT_MS));
+	if (!err) {
+		bt_dev_err(data->hdev, "failed to receive gp0 interrupt for suspend");
+		goto fail;
+	}
+	return 0;
+fail:
+	return -EBUSY;
+}
+
+static int btintel_pcie_resume(struct device *dev)
+{
+	struct btintel_pcie_data *data;
+	struct  pci_dev *pdev = to_pci_dev(dev);
+	int err;
+
+	data = pci_get_drvdata(pdev);
+	btintel_pcie_wr_sleep_cntrl(data, BTINTEL_PCIE_STATE_D0);
+	data->gp0_received = false;
+	err = wait_event_timeout(data->gp0_wait_q, data->gp0_received,
+				 msecs_to_jiffies(BTINTEL_DEFAULT_INTR_TIMEOUT_MS));
+	if (!err) {
+		bt_dev_err(data->hdev, "failed to receive gp0 interrupt for resume");
+		goto fail;
+	}
+	return 0;
+fail:
+	return -EBUSY;
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

