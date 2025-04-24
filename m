Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6763B9479
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Apr 2025 02:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745460917; cv=none; b=HXwGmEf91tdY3pegwvJyOpHBlUXRlinYs9v4GU/Y98uvDNOviOvEVjc/l2Yqgu+unEagx46RQAkHzPV9FoT7BjjbH1Wbn27IkmjSA6anE64MmLOu4jNXwvwxgERYPE1/4hbCJWmFYJDqbCvSl4OGgTzqF61e/5jsq2GB44FTHlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745460917; c=relaxed/simple;
	bh=dRx+U2/PyeCG9E+GmWdqY+fJma5hUIY3y1yhJwAswSk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fzY86pm9Yk0EGSvsmBnSgqPBYLkNq03kHVvy7H8zpsjXjm4Euyr4l6uxgJwqVj/BgcpwZTNB87bsNLJTFUEjXlwphwM8XDLIO2imwmF6AnYws4+6LVpcN95odYxWbfY/cEX5j55fCzPoGV8zLLrHRaykuWMHwrX8docL45aUFgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m6fSnp0V; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m6fSnp0V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745460916; x=1776996916;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=dRx+U2/PyeCG9E+GmWdqY+fJma5hUIY3y1yhJwAswSk=;
  b=m6fSnp0VsGueRjW53ArnnguU5LO46Ms0SmhwP6P0BzlKfyMeK7YadqFX
   1PCu2t2JxC6ExcR/4sBemIArFsdKMrInQ90tdMNec8S7hxJ2dbE02KLCV
   w8wg1Nlv+0hfb1Az909GtnBZF+gfyGLQMcnsUs+CHHPUY5cSmz4lQndUg
   LRIkL6cUzUiwIhnds8aVqaP4Xm7u03XDe8liSxEKA00tleeZZEJgb6hpq
   GpTtXddv9NX2N9+Kc7KDvoAqGd7fURcKdY3vnQFUOkQjrt8YUkv72RQPU
   iJCnPQw19EBkyQamklO9q8tcDCvsj11Rtyx9Qv2LDZ8l0pRHevxll2xSU
   A==;
X-CSE-ConnectionGUID: Sg0L3IJ1SHK7Xmykxj4cuA==
X-CSE-MsgGUID: +ofUhhd7Rwi03XLsjc5J2Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11412"; a="34689039"
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="34689039"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 19:15:15 -0700
X-CSE-ConnectionGUID: LtS42MsrSymChMYXIKu4Pw==
X-CSE-MsgGUID: TiLVu13xTF63Oo9QOm5vmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="163450424"
Received: from unknown (HELO intel-Lenovo-Legion-Y540-15IRH-PG0.iind.intel.com) ([10.224.186.95])
  by orviesa002.jf.intel.com with ESMTP; 23 Apr 2025 19:15:12 -0700
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com,
	chandrashekar.devegowda@intel.com,
	vijay.satija@intel.com,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH v2] Bluetooth: btintel_pcie: Dump debug registers on error
Date: Thu, 24 Apr 2025 08:01:47 +0530
Message-ID: <20250424023147.257095-1-kiran.k@intel.com>
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

HCI traces:
= Vendor Diagnostic (len 199)
        2d 2d 2d 2d 20 44 75 6d 70 20 6f 66 20 64 65 62  ---- Dump of deb
        75 67 20 72 65 67 69 73 74 65 72 73 20 2d 2d 2d  ug registers ---
        62 6f 6f 74 20 73 74 61 67 65 3a 20 30 78 61 30  boot stage: 0xa0
        66 61 30 30 34 37 69 70 63 20 73 74 61 74 75 73  fa0047ipc status
        3a 20 30 78 30 30 30 30 30 30 30 34 69 70 63 20  : 0x00000004ipc
        63 6f 6e 74 72 6f 6c 3a 20 30 78 30 30 30 30 30  control: 0x00000
        30 30 30 69 70 63 20 73 6c 65 65 70 20 63 6f 6e  000ipc sleep con
        74 72 6f 6c 3a 20 30 78 30 30 30 30 30 30 30 30  trol: 0x00000000
        6d 62 6f 78 20 73 74 61 74 75 73 3a 20 30 78 30  mbox status: 0x0
        30 30 30 30 30 30 30 72 78 71 3a 20 63 72 5f 74  0000000rxq: cr_t
        69 61 3a 20 37 20 63 72 5f 68 69 61 3a 20 37 74  ia: 7 cr_hia: 7t
        78 71 3a 20 63 72 5f 74 69 61 3a 20 36 20 63 72  xq: cr_tia: 6 cr
        5f 68 69 61 3a 20 36                             _hia: 6

Signed-off-by: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
Signed-off-by: Kiran K <kiran.k@intel.com>
---
changes in v2:
- convert bt_dev_info to bt_dev_dbg
- send traces to monitor

 drivers/bluetooth/btintel_pcie.c | 131 ++++++++++++++++++++++++++++++-
 drivers/bluetooth/btintel_pcie.h |  19 +++++
 2 files changed, 149 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index b73928e38d34..6f7b4d964bc6 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -208,6 +208,96 @@ static void btintel_pcie_prepare_tx(struct txq *txq, u16 tfd_index,
 	memcpy(buf->data, skb->data, tfd->size);
 }
 
+static inline void btintel_pcie_dump_debug_registers(struct hci_dev *hdev)
+{
+	struct btintel_pcie_data *data = hci_get_drvdata(hdev);
+	u16 cr_hia, cr_tia;
+	u32 reg, mbox_reg;
+	struct sk_buff *skb;
+	u8 buf[80];
+
+	skb = alloc_skb(1024, GFP_ATOMIC);
+	if (!skb)
+		return;
+
+	snprintf(buf, sizeof(buf), "%s", "---- Dump of debug registers ---");
+	bt_dev_dbg(hdev, "%s", buf);
+	skb_put_data(skb, buf, strlen(buf));
+
+	reg = btintel_pcie_rd_reg32(data, BTINTEL_PCIE_CSR_BOOT_STAGE_REG);
+	snprintf(buf, sizeof(buf), "boot stage: 0x%8.8x", reg);
+	bt_dev_dbg(hdev, "%s", buf);
+	skb_put_data(skb, buf, strlen(buf));
+	data->boot_stage_cache = reg;
+
+	reg = btintel_pcie_rd_reg32(data, BTINTEL_PCIE_CSR_IPC_STATUS_REG);
+	snprintf(buf, sizeof(buf), "ipc status: 0x%8.8x", reg);
+	skb_put_data(skb, buf, strlen(buf));
+	bt_dev_dbg(hdev, "%s", buf);
+
+	reg = btintel_pcie_rd_reg32(data, BTINTEL_PCIE_CSR_IPC_CONTROL_REG);
+	snprintf(buf, sizeof(buf), "ipc control: 0x%8.8x", reg);
+	skb_put_data(skb, buf, strlen(buf));
+	bt_dev_dbg(hdev, "%s", buf);
+
+	reg = btintel_pcie_rd_reg32(data, BTINTEL_PCIE_CSR_IPC_SLEEP_CTL_REG);
+	snprintf(buf, sizeof(buf), "ipc sleep control: 0x%8.8x", reg);
+	skb_put_data(skb, buf, strlen(buf));
+	bt_dev_dbg(hdev, "%s", buf);
+
+	/*Read the Mail box status and registers*/
+	reg = btintel_pcie_rd_reg32(data, BTINTEL_PCIE_CSR_MBOX_STATUS_REG);
+	snprintf(buf, sizeof(buf), "mbox status: 0x%8.8x", reg);
+	skb_put_data(skb, buf, strlen(buf));
+	if (reg & BTINTEL_PCIE_CSR_MBOX_STATUS_MBOX1) {
+		mbox_reg = btintel_pcie_rd_reg32(data,
+						 BTINTEL_PCIE_CSR_MBOX_1_REG);
+		snprintf(buf, sizeof(buf), "mbox_1: 0x%8.8x", mbox_reg);
+		skb_put_data(skb, buf, strlen(buf));
+		bt_dev_dbg(hdev, "%s", buf);
+	}
+
+	if (reg & BTINTEL_PCIE_CSR_MBOX_STATUS_MBOX2) {
+		mbox_reg = btintel_pcie_rd_reg32(data,
+						 BTINTEL_PCIE_CSR_MBOX_2_REG);
+		snprintf(buf, sizeof(buf), "mbox_2: 0x%8.8x", mbox_reg);
+		skb_put_data(skb, buf, strlen(buf));
+		bt_dev_dbg(hdev, "%s", buf);
+	}
+
+	if (reg & BTINTEL_PCIE_CSR_MBOX_STATUS_MBOX3) {
+		mbox_reg = btintel_pcie_rd_reg32(data,
+						 BTINTEL_PCIE_CSR_MBOX_3_REG);
+		snprintf(buf, sizeof(buf), "mbox_3: 0x%8.8x", mbox_reg);
+		skb_put_data(skb, buf, strlen(buf));
+		bt_dev_dbg(hdev, "%s", buf);
+	}
+
+	if (reg & BTINTEL_PCIE_CSR_MBOX_STATUS_MBOX4) {
+		mbox_reg = btintel_pcie_rd_reg32(data,
+						 BTINTEL_PCIE_CSR_MBOX_4_REG);
+		snprintf(buf, sizeof(buf), "mbox_4: 0x%8.8x", mbox_reg);
+		skb_put_data(skb, buf, strlen(buf));
+		bt_dev_dbg(hdev, "%s", buf);
+	}
+
+	cr_hia = data->ia.cr_hia[BTINTEL_PCIE_RXQ_NUM];
+	cr_tia = data->ia.cr_tia[BTINTEL_PCIE_RXQ_NUM];
+	snprintf(buf, sizeof(buf), "rxq: cr_tia: %u cr_hia: %u", cr_tia, cr_hia);
+	skb_put_data(skb, buf, strlen(buf));
+	bt_dev_dbg(hdev, "%s", buf);
+
+	cr_hia = data->ia.cr_hia[BTINTEL_PCIE_TXQ_NUM];
+	cr_tia = data->ia.cr_tia[BTINTEL_PCIE_TXQ_NUM];
+	snprintf(buf, sizeof(buf), "txq: cr_tia: %u cr_hia: %u", cr_tia, cr_hia);
+	skb_put_data(skb, buf, strlen(buf));
+	bt_dev_dbg(hdev, "%s", buf);
+	snprintf(buf, sizeof(buf), "--------------------------------");
+	bt_dev_dbg(hdev, "%s", buf);
+
+	hci_recv_diag(hdev, skb);
+}
+
 static int btintel_pcie_send_sync(struct btintel_pcie_data *data,
 				  struct sk_buff *skb)
 {
@@ -237,8 +327,11 @@ static int btintel_pcie_send_sync(struct btintel_pcie_data *data,
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
@@ -756,6 +849,26 @@ static int btintel_pcie_read_device_mem(struct btintel_pcie_data *data,
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
@@ -779,6 +892,18 @@ static void btintel_pcie_msix_gp0_handler(struct btintel_pcie_data *data)
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
@@ -1325,6 +1450,9 @@ static irqreturn_t btintel_pcie_irq_msix_handler(int irq, void *dev_id)
 	if (intr_hw & BTINTEL_PCIE_MSIX_HW_INT_CAUSES_HWEXP)
 		btintel_pcie_msix_hw_exp_handler(data);
 
+	if (intr_hw & BTINTEL_PCIE_MSIX_HW_INT_CAUSES_GP1)
+		btintel_pcie_msix_gp1_handler(data);
+
 	/* This interrupt is triggered by the firmware after updating
 	 * boot_stage register and image_response register
 	 */
@@ -2004,6 +2132,7 @@ static int btintel_pcie_setup(struct hci_dev *hdev)
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

