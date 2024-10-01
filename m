Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A4C3209
	for <linux-bluetooth@vger.kernel.org>; Tue,  1 Oct 2024 10:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727778587; cv=none; b=mY84vtex2Tub0TvWI98Q3CwaxbJOMiyk/b83gKYa2EJ5GQ6W3SXGUiEYzNOlLFgs+49NTSZ6XASEEfzhLijQC2//e1YmWnSOJhA3sD2aNEfQspiOqVtx7VzyjIQkgmospQF2bUR09gl5OSQk5P57zSSlWgNYWLEMpeeUUigATX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727778587; c=relaxed/simple;
	bh=BnbnuGQ4k8jEK8qmv1/SQG8XmxbwRhylaFZH599IM7s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y5qAOyvYdIobydF4Jk/FLBCIFkhLri33ZKX21/LEH1Y4QieyUqRWlo8Zraz8Xj+Hn1L3HkMUfihpvB/4oNsRzyZT0hyN6G6V0RIfO/JzmonAkxtqIBPhVUCLyXfPjXARGciSBTwzaEbLyvkXGrrMyHi1Nr1dAxlWZ+F74FcGJDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BkJGhISN; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BkJGhISN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727778585; x=1759314585;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BnbnuGQ4k8jEK8qmv1/SQG8XmxbwRhylaFZH599IM7s=;
  b=BkJGhISNBMeMzXmiISYELxlAHXIaYKXf0FMwk1hoJPFOhclrMXJrUtMv
   5p53d1gjxRQADrSEgO3xSV2v79hX3YMjT8BYh3TsSKMVaszaSL6k5LjU8
   OJByu3GUHQZVM/u6LIRBp7HA1cdqX0FG/KrWekHqt24MZpRMPjGhki2Zl
   Bt5jkINaE1KSTOpgImnst6OUr7StGi7bE1RZtZQApmjqPRa+Ky6nA1CuP
   H7woB1iRYeiCJwnEszn8Ls9szdWxTdcyNa0/ew+fxDjuLOGf+vn5ZDu8l
   e9hTjm8DzxWGQWtg00EI2e6nPhk4mPg6Es5+CR8AA/YB/TSWLxjP71SWk
   A==;
X-CSE-ConnectionGUID: 6+w6Vg6jTK+x7btCYpWQjw==
X-CSE-MsgGUID: a/cQ5PewQXyqiL05lFAy3A==
X-IronPort-AV: E=McAfee;i="6700,10204,11211"; a="26780144"
X-IronPort-AV: E=Sophos;i="6.11,167,1725346800"; 
   d="scan'208";a="26780144"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2024 03:29:44 -0700
X-CSE-ConnectionGUID: Huz0b2GkQlqYk1R/UqZQzw==
X-CSE-MsgGUID: ZRy/BfuHRoWs29sHGCgYYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,167,1725346800"; 
   d="scan'208";a="73274516"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by fmviesa007.fm.intel.com with ESMTP; 01 Oct 2024 03:29:43 -0700
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com,
	chandrashekar.devegowda@intel.com,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH v1 2/2] Bluetooth: btintel_pcie: Add recovery mechanism
Date: Tue,  1 Oct 2024 16:14:51 +0530
Message-Id: <20241001104451.626964-2-kiran.k@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20241001104451.626964-1-kiran.k@intel.com>
References: <20241001104451.626964-1-kiran.k@intel.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds a recovery mechanism to recover controller if firmware
download fails due to unresponsive controller, command timeout, firmware
signature verification failure etc. Driver attmepts maximum of 5 times
before giving up.

Signed-off-by: Kiran K <kiran.k@intel.com>
---
 drivers/bluetooth/btintel.c      |  14 ++++
 drivers/bluetooth/btintel_pcie.c | 109 +++++++++++++++++++++----------
 drivers/bluetooth/btintel_pcie.h |   2 +
 3 files changed, 91 insertions(+), 34 deletions(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index fed1a939aad6..c14ec6c6120b 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -1252,6 +1252,12 @@ static void btintel_reset_to_bootloader(struct hci_dev *hdev)
 	struct intel_reset params;
 	struct sk_buff *skb;
 
+	/* PCIe transport uses shared hardware reset mechanism for recovery
+	 * which gets triggered in pcie *setup* function on error.
+	 */
+	if (hdev->bus == HCI_PCI)
+		return;
+
 	/* Send Intel Reset command. This will result in
 	 * re-enumeration of BT controller.
 	 *
@@ -1267,6 +1273,7 @@ static void btintel_reset_to_bootloader(struct hci_dev *hdev)
 	 * boot_param:    Boot address
 	 *
 	 */
+
 	params.reset_type = 0x01;
 	params.patch_enable = 0x01;
 	params.ddc_reload = 0x01;
@@ -2796,6 +2803,13 @@ int btintel_bootloader_setup_tlv(struct hci_dev *hdev,
 	 */
 	boot_param = 0x00000000;
 
+	/* In case of PCIe, this function might get called multiple times with
+	 * same hdev instance if there is any error on firmware download.
+	 * Need to clear stale bits of previous firmware download attempt.
+	 */
+	for (int i = 0; i < __INTEL_NUM_FLAGS; i++)
+		btintel_clear_flag(hdev, i);
+
 	btintel_set_flag(hdev, INTEL_BOOTLOADER);
 
 	err = btintel_prepare_fw_download_tlv(hdev, ver, &boot_param);
diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index cff3e7afdff9..a525c15c47b0 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -75,24 +75,6 @@ static inline void ipc_print_urbd1(struct hci_dev *hdev, struct urbd1 *urbd1,
 		   index, urbd1->frbd_tag, urbd1->status, urbd1->fixed);
 }
 
-static int btintel_pcie_poll_bit(struct btintel_pcie_data *data, u32 offset,
-				 u32 bits, u32 mask, int timeout_us)
-{
-	int t = 0;
-	u32 reg;
-
-	do {
-		reg = btintel_pcie_rd_reg32(data, offset);
-
-		if ((reg & mask) == (bits & mask))
-			return t;
-		udelay(POLL_INTERVAL_US);
-		t += POLL_INTERVAL_US;
-	} while (t < timeout_us);
-
-	return -ETIMEDOUT;
-}
-
 static struct btintel_pcie_data *btintel_pcie_get_data(struct msix_entry *entry)
 {
 	u8 queue = entry->entry;
@@ -248,10 +230,47 @@ static void btintel_pcie_reset_ia(struct btintel_pcie_data *data)
 	memset(data->ia.cr_tia, 0, sizeof(u16) * BTINTEL_PCIE_NUM_QUEUES);
 }
 
-static void btintel_pcie_reset_bt(struct btintel_pcie_data *data)
+static int btintel_pcie_reset_bt(struct btintel_pcie_data *data)
 {
-	btintel_pcie_wr_reg32(data, BTINTEL_PCIE_CSR_FUNC_CTRL_REG,
-			      BTINTEL_PCIE_CSR_FUNC_CTRL_SW_RESET);
+	u32 reg;
+	int retry = 3;
+
+	reg = btintel_pcie_rd_reg32(data, BTINTEL_PCIE_CSR_FUNC_CTRL_REG);
+
+	reg &= ~(BTINTEL_PCIE_CSR_FUNC_CTRL_FUNC_ENA |
+			BTINTEL_PCIE_CSR_FUNC_CTRL_MAC_INIT |
+			BTINTEL_PCIE_CSR_FUNC_CTRL_FUNC_INIT);
+	reg |= BTINTEL_PCIE_CSR_FUNC_CTRL_BUS_MASTER_DISCON;
+
+	btintel_pcie_wr_reg32(data, BTINTEL_PCIE_CSR_FUNC_CTRL_REG, reg);
+
+	do {
+		reg = btintel_pcie_rd_reg32(data, BTINTEL_PCIE_CSR_FUNC_CTRL_REG);
+		if (reg & BTINTEL_PCIE_CSR_FUNC_CTRL_BUS_MASTER_STS)
+			break;
+		usleep_range(10000, 12000);
+
+	} while (--retry > 0);
+	usleep_range(10000, 12000);
+
+	reg = btintel_pcie_rd_reg32(data, BTINTEL_PCIE_CSR_FUNC_CTRL_REG);
+
+	reg &= ~(BTINTEL_PCIE_CSR_FUNC_CTRL_FUNC_ENA |
+			BTINTEL_PCIE_CSR_FUNC_CTRL_MAC_INIT |
+			BTINTEL_PCIE_CSR_FUNC_CTRL_FUNC_INIT);
+	reg |= BTINTEL_PCIE_CSR_FUNC_CTRL_SW_RESET;
+	btintel_pcie_wr_reg32(data, BTINTEL_PCIE_CSR_FUNC_CTRL_REG, reg);
+	usleep_range(10000, 12000);
+
+	reg = btintel_pcie_rd_reg32(data, BTINTEL_PCIE_CSR_FUNC_CTRL_REG);
+	bt_dev_dbg(data->hdev, "csr register after reset: 0x%8.8x", reg);
+
+	reg = btintel_pcie_rd_reg32(data, BTINTEL_PCIE_CSR_BOOT_STAGE_REG);
+
+	/* If shared hardware reset is success then boot stage register shall be
+	 * set to 0
+	 */
+	return reg == 0 ? 0 : -ENODEV;
 }
 
 /* This function enables BT function by setting BTINTEL_PCIE_CSR_FUNC_CTRL_MAC_INIT bit in
@@ -263,6 +282,7 @@ static void btintel_pcie_reset_bt(struct btintel_pcie_data *data)
 static int btintel_pcie_enable_bt(struct btintel_pcie_data *data)
 {
 	int err;
+	u32 reg;
 
 	data->gp0_received = false;
 
@@ -278,22 +298,17 @@ static int btintel_pcie_enable_bt(struct btintel_pcie_data *data)
 	data->boot_stage_cache = 0x0;
 
 	/* Set MAC_INIT bit to start primary bootloader */
-	btintel_pcie_rd_reg32(data, BTINTEL_PCIE_CSR_FUNC_CTRL_REG);
+	reg = btintel_pcie_rd_reg32(data, BTINTEL_PCIE_CSR_FUNC_CTRL_REG);
+	reg &= ~(BTINTEL_PCIE_CSR_FUNC_CTRL_FUNC_INIT |
+			BTINTEL_PCIE_CSR_FUNC_CTRL_BUS_MASTER_DISCON |
+			BTINTEL_PCIE_CSR_FUNC_CTRL_SW_RESET);
+	reg |= (BTINTEL_PCIE_CSR_FUNC_CTRL_FUNC_ENA |
+			BTINTEL_PCIE_CSR_FUNC_CTRL_MAC_INIT);
 
-	btintel_pcie_set_reg_bits(data, BTINTEL_PCIE_CSR_FUNC_CTRL_REG,
-				  BTINTEL_PCIE_CSR_FUNC_CTRL_MAC_INIT);
-
-	/* Wait until MAC_ACCESS is granted */
-	err = btintel_pcie_poll_bit(data, BTINTEL_PCIE_CSR_FUNC_CTRL_REG,
-				    BTINTEL_PCIE_CSR_FUNC_CTRL_MAC_ACCESS_STS,
-				    BTINTEL_PCIE_CSR_FUNC_CTRL_MAC_ACCESS_STS,
-				    BTINTEL_DEFAULT_MAC_ACCESS_TIMEOUT_US);
-	if (err < 0)
-		return -ENODEV;
+	btintel_pcie_wr_reg32(data, BTINTEL_PCIE_CSR_FUNC_CTRL_REG, reg);
 
 	/* MAC is ready. Enable BT FUNC */
 	btintel_pcie_set_reg_bits(data, BTINTEL_PCIE_CSR_FUNC_CTRL_REG,
-				  BTINTEL_PCIE_CSR_FUNC_CTRL_FUNC_ENA |
 				  BTINTEL_PCIE_CSR_FUNC_CTRL_FUNC_INIT);
 
 	btintel_pcie_rd_reg32(data, BTINTEL_PCIE_CSR_FUNC_CTRL_REG);
@@ -1376,7 +1391,7 @@ static void btintel_pcie_release_hdev(struct btintel_pcie_data *data)
 	data->hdev = NULL;
 }
 
-static int btintel_pcie_setup(struct hci_dev *hdev)
+static int btintel_pcie_setup_internal(struct hci_dev *hdev)
 {
 	const u8 param[1] = { 0xFF };
 	struct intel_version_tlv ver_tlv;
@@ -1467,6 +1482,32 @@ static int btintel_pcie_setup(struct hci_dev *hdev)
 	return err;
 }
 
+static int btintel_pcie_setup(struct hci_dev *hdev)
+{
+	int err, fw_dl_retry = 0;
+	struct btintel_pcie_data *data = hci_get_drvdata(hdev);
+
+	while ((err = btintel_pcie_setup_internal(hdev)) && fw_dl_retry++ < 5) {
+		bt_dev_err(hdev, "Firmware download retry count: %d",
+			   fw_dl_retry);
+		err = btintel_pcie_reset_bt(data);
+		if (err) {
+			bt_dev_err(hdev, "Failed to do shr reset: %d", err);
+			break;
+		}
+		usleep_range(10000, 12000);
+		btintel_pcie_reset_ia(data);
+		btintel_pcie_config_msix(data);
+		err = btintel_pcie_enable_bt(data);
+		if (err) {
+			bt_dev_err(hdev, "Failed to enable hardware: %d", err);
+			break;
+		}
+		btintel_pcie_start_rx(data);
+	}
+	return err;
+}
+
 static int btintel_pcie_setup_hdev(struct btintel_pcie_data *data)
 {
 	int err;
diff --git a/drivers/bluetooth/btintel_pcie.h b/drivers/bluetooth/btintel_pcie.h
index 8b7824ad005a..f9aada0543c4 100644
--- a/drivers/bluetooth/btintel_pcie.h
+++ b/drivers/bluetooth/btintel_pcie.h
@@ -23,6 +23,8 @@
 #define BTINTEL_PCIE_CSR_FUNC_CTRL_MAC_INIT		(BIT(6))
 #define BTINTEL_PCIE_CSR_FUNC_CTRL_FUNC_INIT		(BIT(7))
 #define BTINTEL_PCIE_CSR_FUNC_CTRL_MAC_ACCESS_STS	(BIT(20))
+#define BTINTEL_PCIE_CSR_FUNC_CTRL_BUS_MASTER_STS	(BIT(28))
+#define BTINTEL_PCIE_CSR_FUNC_CTRL_BUS_MASTER_DISCON	(BIT(29))
 #define BTINTEL_PCIE_CSR_FUNC_CTRL_SW_RESET		(BIT(31))
 
 /* Value for BTINTEL_PCIE_CSR_BOOT_STAGE register */
-- 
2.40.1

