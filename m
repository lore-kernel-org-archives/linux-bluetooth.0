Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B657420D51A
	for <linux-bluetooth@vger.kernel.org>; Mon, 21 Apr 2025 09:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745226671; cv=none; b=qzscvAhNl4SiORNL+o18P6rTt4isXz584gl5yL1wmrwMBWsH6KGgiu7YbIr8oElG1LIf6el5N4tiAsrkac3qUYQJpxsdfytqwkWZPG3QqAojlr9X94DqImC5rMvDYq151BgBxmq8rUaQiRENDVYfXKiFN0FfRTgs8nneGnEMiqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745226671; c=relaxed/simple;
	bh=W8PfmZXr+stIzOAs177og1UoSf7rJw1n8KspjlzS7UY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=efmg+3WbQpVfLZA0ngb2QZ+hoODx1KC60dG+ToaW2PXZkTW3S1LUHgU1zqd42/vEubGutJaldX3UakHg13+7TVE2vIYVMo/QSMJKGMlMBVX6hvGo32GErqD+80wrfoghzofjP+k9yzMRwNmlUMmxrx/vXhLlLfHDYb61kJ08e3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bOA3hjye; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bOA3hjye"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745226669; x=1776762669;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=W8PfmZXr+stIzOAs177og1UoSf7rJw1n8KspjlzS7UY=;
  b=bOA3hjyepIifs7Aeo+MEehK5lApqtE9jG+N0Evmemfw3c0bpLf9MgFNb
   qmwZkGvjKgaMNwK3qPahmIWtM0uAWhLSGfNe4Ne0MxWneVs4KZhPudCH/
   cZyjcTKhrH0NBDhWmcKuHoWb+kkhcjdEIge7mGCZGugqvIeATJVc2E33a
   uR6YU8JYhx03Pw0MFbOmvXKkTJBNw5xRcp/G471WzmZw8IO6t9iXpBK0u
   AXXTypJJSNMW04CK52p/0HB2PsdUhS0YbVsxNZa129XI4OsjCXONIziqY
   ArbW4xuHqTx5NnXirWkYmQeFw9LRYkw4xYN9K4U8QekJeQ+S3vOhwn0cY
   Q==;
X-CSE-ConnectionGUID: /tCFsBVVSTu6Cu3tzj8Wjw==
X-CSE-MsgGUID: prcNASl4TjCfr2H0toXB4g==
X-IronPort-AV: E=McAfee;i="6700,10204,11409"; a="50418670"
X-IronPort-AV: E=Sophos;i="6.15,227,1739865600"; 
   d="scan'208";a="50418670"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2025 02:11:09 -0700
X-CSE-ConnectionGUID: C4/5ULzhQZm8+NXh+rWj3A==
X-CSE-MsgGUID: VXMmTX6kRzGBLgRux3pamQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,227,1739865600"; 
   d="scan'208";a="132638262"
Received: from unknown (HELO intel-Lenovo-Legion-Y540-15IRH-PG0.iind.intel.com) ([10.224.186.95])
  by orviesa008.jf.intel.com with ESMTP; 21 Apr 2025 02:11:06 -0700
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com,
	chandrashekar.devegowda@intel.com,
	vijay.satija@intel.com,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH v1] Bluetooth: btintel_pcie: Dump debug registers on error
Date: Mon, 21 Apr 2025 14:57:44 +0530
Message-ID: <20250421092744.219097-1-kiran.k@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>

Dumping debug registers on GP1 MSIx and error conditions, such as TX
completion timeout, aiding in understanding the controller's state
during errors. The register dump includes:
- Boot stage
- IPC control
- IPC status
- Mailbox registers

Signed-off-by: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
Signed-off-by: Kiran K <kiran.k@intel.com>
---
 drivers/bluetooth/btintel_pcie.c | 98 +++++++++++++++++++++++++++++++-
 drivers/bluetooth/btintel_pcie.h | 19 +++++++
 2 files changed, 116 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index b73928e38d34..9b0629a1053f 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -208,6 +208,63 @@ static void btintel_pcie_prepare_tx(struct txq *txq, u16 tfd_index,
 	memcpy(buf->data, skb->data, tfd->size);
 }
 
+static inline void btintel_pcie_dump_debug_registers(struct hci_dev *hdev)
+{
+	struct btintel_pcie_data *data = hci_get_drvdata(hdev);
+	u16 cr_hia, cr_tia;
+	u32 reg, mbox_reg;
+
+	bt_dev_info(hdev, "---- Dump of debug registers ---");
+	reg = btintel_pcie_rd_reg32(data, BTINTEL_PCIE_CSR_BOOT_STAGE_REG);
+	bt_dev_info(hdev, "boot stage: 0x%8.8x", reg);
+	data->boot_stage_cache = reg;
+
+	reg = btintel_pcie_rd_reg32(data, BTINTEL_PCIE_CSR_IPC_STATUS_REG);
+	bt_dev_info(hdev, "ipc status: 0x%8.8x", reg);
+
+	reg = btintel_pcie_rd_reg32(data, BTINTEL_PCIE_CSR_IPC_CONTROL_REG);
+	bt_dev_info(hdev, "ipc control: 0x%8.8x", reg);
+
+	reg = btintel_pcie_rd_reg32(data, BTINTEL_PCIE_CSR_IPC_SLEEP_CTL_REG);
+	bt_dev_info(hdev, "ipc sleep control: 0x%8.8x", reg);
+
+	/*Read the Mail box status and registers*/
+	reg = btintel_pcie_rd_reg32(data, BTINTEL_PCIE_CSR_MBOX_STATUS_REG);
+	bt_dev_info(hdev, "mbox status: 0x%8.8x", reg);
+	if (reg & BTINTEL_PCIE_CSR_MBOX_STATUS_MBOX1) {
+		mbox_reg = btintel_pcie_rd_reg32(data,
+						 BTINTEL_PCIE_CSR_MBOX_1_REG);
+		bt_dev_info(hdev, "mbox_1: 0x%8.8x", mbox_reg);
+	}
+
+	if (reg & BTINTEL_PCIE_CSR_MBOX_STATUS_MBOX2) {
+		mbox_reg = btintel_pcie_rd_reg32(data,
+						 BTINTEL_PCIE_CSR_MBOX_2_REG);
+		bt_dev_info(hdev, "mbox_2: 0x%8.8x", mbox_reg);
+	}
+
+	if (reg & BTINTEL_PCIE_CSR_MBOX_STATUS_MBOX3) {
+		mbox_reg = btintel_pcie_rd_reg32(data,
+						 BTINTEL_PCIE_CSR_MBOX_3_REG);
+		bt_dev_info(hdev, "mbox_3: 0x%8.8x", mbox_reg);
+	}
+
+	if (reg & BTINTEL_PCIE_CSR_MBOX_STATUS_MBOX4) {
+		mbox_reg = btintel_pcie_rd_reg32(data,
+						 BTINTEL_PCIE_CSR_MBOX_4_REG);
+		bt_dev_info(hdev, "mbox_4: 0x%8.8x", mbox_reg);
+	}
+
+	cr_hia = data->ia.cr_hia[BTINTEL_PCIE_RXQ_NUM];
+	cr_tia = data->ia.cr_tia[BTINTEL_PCIE_RXQ_NUM];
+	bt_dev_info(hdev, "rxq: cr_tia: %u cr_hia: %u", cr_tia, cr_hia);
+
+	cr_hia = data->ia.cr_hia[BTINTEL_PCIE_TXQ_NUM];
+	cr_tia = data->ia.cr_tia[BTINTEL_PCIE_TXQ_NUM];
+	bt_dev_info(hdev, "txq: cr_tia: %u cr_hia: %u", cr_tia, cr_hia);
+	bt_dev_info(hdev, "--------------------------------");
+}
+
 static int btintel_pcie_send_sync(struct btintel_pcie_data *data,
 				  struct sk_buff *skb)
 {
@@ -237,8 +294,11 @@ static int btintel_pcie_send_sync(struct btintel_pcie_data *data,
 	/* Wait for the complete interrupt - URBD0 */
 	ret = wait_event_timeout(data->tx_wait_q, data->tx_wait_done,
 				 msecs_to_jiffies(BTINTEL_PCIE_TX_WAIT_TIMEOUT_MS));
-	if (!ret)
+	if (!ret) {
+		bt_dev_err(data->hdev, "tx completion timeout");
+		btintel_pcie_dump_debug_registers(data->hdev);
 		return -ETIME;
+	}
 
 	return 0;
 }
@@ -756,6 +816,26 @@ static int btintel_pcie_read_device_mem(struct btintel_pcie_data *data,
 	return 0;
 }
 
+static inline bool btintel_pcie_in_lockdown(struct btintel_pcie_data *data)
+{
+	return (data->boot_stage_cache &
+		BTINTEL_PCIE_CSR_BOOT_STAGE_ROM_LOCKDOWN) ||
+		(data->boot_stage_cache &
+		 BTINTEL_PCIE_CSR_BOOT_STAGE_IML_LOCKDOWN);
+}
+
+static inline bool btintel_pcie_in_error(struct btintel_pcie_data *data)
+{
+	return (data->boot_stage_cache & BTINTEL_PCIE_CSR_BOOT_STAGE_DEVICE_ERR) ||
+		(data->boot_stage_cache & BTINTEL_PCIE_CSR_BOOT_STAGE_ABORT_HANDLER);
+}
+
+static void btintel_pcie_msix_gp1_handler(struct btintel_pcie_data *data)
+{
+	bt_dev_err(data->hdev, "Received gp1 mailbox interrupt");
+	btintel_pcie_dump_debug_registers(data->hdev);
+}
+
 /* This function handles the MSI-X interrupt for gp0 cause (bit 0 in
  * BTINTEL_PCIE_CSR_MSIX_HW_INT_CAUSES) which is sent for boot stage and image response.
  */
@@ -779,6 +859,18 @@ static void btintel_pcie_msix_gp0_handler(struct btintel_pcie_data *data)
 	if (reg != data->img_resp_cache)
 		data->img_resp_cache = reg;
 
+	if (btintel_pcie_in_error(data)) {
+		bt_dev_err(data->hdev, "Controller in error state");
+		btintel_pcie_dump_debug_registers(data->hdev);
+		return;
+	}
+
+	if (btintel_pcie_in_lockdown(data)) {
+		bt_dev_err(data->hdev, "Controller in lockdown state");
+		btintel_pcie_dump_debug_registers(data->hdev);
+		return;
+	}
+
 	data->gp0_received = true;
 
 	old_ctxt = data->alive_intr_ctxt;
@@ -1325,6 +1417,9 @@ static irqreturn_t btintel_pcie_irq_msix_handler(int irq, void *dev_id)
 	if (intr_hw & BTINTEL_PCIE_MSIX_HW_INT_CAUSES_HWEXP)
 		btintel_pcie_msix_hw_exp_handler(data);
 
+	if (intr_hw & BTINTEL_PCIE_MSIX_HW_INT_CAUSES_GP1)
+		btintel_pcie_msix_gp1_handler(data);
+
 	/* This interrupt is triggered by the firmware after updating
 	 * boot_stage register and image_response register
 	 */
@@ -2004,6 +2099,7 @@ static int btintel_pcie_setup(struct hci_dev *hdev)
 	while ((err = btintel_pcie_setup_internal(hdev)) && fw_dl_retry++ < 1) {
 		bt_dev_err(hdev, "Firmware download retry count: %d",
 			   fw_dl_retry);
+		btintel_pcie_dump_debug_registers(hdev);
 		err = btintel_pcie_reset_bt(data);
 		if (err) {
 			bt_dev_err(hdev, "Failed to do shr reset: %d", err);
diff --git a/drivers/bluetooth/btintel_pcie.h b/drivers/bluetooth/btintel_pcie.h
index 873178019cad..21b964b15c1c 100644
--- a/drivers/bluetooth/btintel_pcie.h
+++ b/drivers/bluetooth/btintel_pcie.h
@@ -12,10 +12,17 @@
 #define BTINTEL_PCIE_CSR_HW_REV_REG		(BTINTEL_PCIE_CSR_BASE + 0x028)
 #define BTINTEL_PCIE_CSR_RF_ID_REG		(BTINTEL_PCIE_CSR_BASE + 0x09C)
 #define BTINTEL_PCIE_CSR_BOOT_STAGE_REG		(BTINTEL_PCIE_CSR_BASE + 0x108)
+#define BTINTEL_PCIE_CSR_IPC_CONTROL_REG	(BTINTEL_PCIE_CSR_BASE + 0x10C)
+#define BTINTEL_PCIE_CSR_IPC_STATUS_REG		(BTINTEL_PCIE_CSR_BASE + 0x110)
 #define BTINTEL_PCIE_CSR_IPC_SLEEP_CTL_REG	(BTINTEL_PCIE_CSR_BASE + 0x114)
 #define BTINTEL_PCIE_CSR_CI_ADDR_LSB_REG	(BTINTEL_PCIE_CSR_BASE + 0x118)
 #define BTINTEL_PCIE_CSR_CI_ADDR_MSB_REG	(BTINTEL_PCIE_CSR_BASE + 0x11C)
 #define BTINTEL_PCIE_CSR_IMG_RESPONSE_REG	(BTINTEL_PCIE_CSR_BASE + 0x12C)
+#define BTINTEL_PCIE_CSR_MBOX_1_REG		(BTINTEL_PCIE_CSR_BASE + 0x170)
+#define BTINTEL_PCIE_CSR_MBOX_2_REG		(BTINTEL_PCIE_CSR_BASE + 0x174)
+#define BTINTEL_PCIE_CSR_MBOX_3_REG		(BTINTEL_PCIE_CSR_BASE + 0x178)
+#define BTINTEL_PCIE_CSR_MBOX_4_REG		(BTINTEL_PCIE_CSR_BASE + 0x17C)
+#define BTINTEL_PCIE_CSR_MBOX_STATUS_REG	(BTINTEL_PCIE_CSR_BASE + 0x180)
 #define BTINTEL_PCIE_PRPH_DEV_ADDR_REG		(BTINTEL_PCIE_CSR_BASE + 0x440)
 #define BTINTEL_PCIE_PRPH_DEV_RD_REG		(BTINTEL_PCIE_CSR_BASE + 0x458)
 #define BTINTEL_PCIE_CSR_HBUS_TARG_WRPTR	(BTINTEL_PCIE_CSR_BASE + 0x460)
@@ -41,6 +48,9 @@
 #define BTINTEL_PCIE_CSR_BOOT_STAGE_OPFW		(BIT(2))
 #define BTINTEL_PCIE_CSR_BOOT_STAGE_ROM_LOCKDOWN	(BIT(10))
 #define BTINTEL_PCIE_CSR_BOOT_STAGE_IML_LOCKDOWN	(BIT(11))
+#define BTINTEL_PCIE_CSR_BOOT_STAGE_DEVICE_ERR		(BIT(12))
+#define BTINTEL_PCIE_CSR_BOOT_STAGE_ABORT_HANDLER	(BIT(13))
+#define BTINTEL_PCIE_CSR_BOOT_STAGE_DEVICE_HALTED	(BIT(14))
 #define BTINTEL_PCIE_CSR_BOOT_STAGE_MAC_ACCESS_ON	(BIT(16))
 #define BTINTEL_PCIE_CSR_BOOT_STAGE_ALIVE		(BIT(23))
 #define BTINTEL_PCIE_CSR_BOOT_STAGE_D3_STATE_READY	(BIT(24))
@@ -89,6 +99,7 @@ enum msix_fh_int_causes {
 /* Causes for the HW register interrupts */
 enum msix_hw_int_causes {
 	BTINTEL_PCIE_MSIX_HW_INT_CAUSES_GP0	= BIT(0),	/* cause 32 */
+	BTINTEL_PCIE_MSIX_HW_INT_CAUSES_GP1	= BIT(1),	/* cause 33 */
 	BTINTEL_PCIE_MSIX_HW_INT_CAUSES_HWEXP	= BIT(3),	/* cause 35 */
 };
 
@@ -121,6 +132,14 @@ enum btintel_pcie_tlv_type {
 	BTINTEL_FW_BUILD,
 };
 
+/* causes for the MBOX interrupts */
+enum msix_mbox_int_causes {
+	BTINTEL_PCIE_CSR_MBOX_STATUS_MBOX1 = BIT(0), /* cause MBOX1 */
+	BTINTEL_PCIE_CSR_MBOX_STATUS_MBOX2 = BIT(1), /* cause MBOX2 */
+	BTINTEL_PCIE_CSR_MBOX_STATUS_MBOX3 = BIT(2), /* cause MBOX3 */
+	BTINTEL_PCIE_CSR_MBOX_STATUS_MBOX4 = BIT(3), /* cause MBOX4 */
+};
+
 #define BTINTEL_PCIE_MSIX_NON_AUTO_CLEAR_CAUSE	BIT(7)
 
 /* Minimum and Maximum number of MSI-X Vector
-- 
2.43.0

