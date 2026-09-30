Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA56A4582F6
	for <linux-bluetooth@vger.kernel.org>; Wed, 30 Sep 2026 07:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790754649; cv=none; b=f50k548bUXAONWloDJHZ2/bERBSikQvegJ7tPt9AwOiisjjecAakQ8wLb9SJYuXEcMYYudi3AjS+2ESvlrysa0VvzWxcRG3UMf6tZZQduCd8mE0v1cXFRs8aJQCkC0fGQp8v8KB7FI0MVF3wYQMXI/lpnO341lS7RC+xo83Jasw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790754649; c=relaxed/simple;
	bh=w4KPFc2ybFvhkq+5NL35pJUxFHS7/gLo7j/3bIAnXMM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rBGS0TUtEgOLeIPGIYuOh89YsM6lY3pQNphOU1ZavOoX07suyukqLex3o2PpJ1Yy447uLatkGpyv+PtfC0ro9mOi1Jr/0qHl6YbY0z2X3KHSBipxliCzo6jqS/tV8I0IfwtZ75m1vPhEltzl1hjuMs2h0wQn36mvV8oUP/ZDTBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kGTTXar6; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kGTTXar6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790754647; x=1822290647;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=w4KPFc2ybFvhkq+5NL35pJUxFHS7/gLo7j/3bIAnXMM=;
  b=kGTTXar6Rx/ThqEeEd6vBalTt4XSt8xQ3Oy1VNZ2fE7xifOMvaduTT3l
   RT44BG4BM88YQZbvkxWG3lNQdkz/EZ05XXLz5vdzfDqpge0RrGek3FHRd
   Tk7r9jLsfElV38ImDoEHyaKB3/8WjJ1koXeBgdiL73rr2yLof+EjhzwNC
   4e9VPltNsdBiuIfOAZWmoMWChtQzMOxOt14ptcSVSxjzWCmmiaNLFy8dO
   4+S0In0SOhSLvEYLeERt3daCQN80Pg48gbbGIvu7l7Z/LRsiZVeh0zDsR
   Fa5G9lhWAA61xRSZoQqRdL4pO5TfGwipKSVk7H8/lZJRXX1OsdhM2mQAG
   w==;
X-CSE-ConnectionGUID: pkxExKHWT+uEof0L+wIu8A==
X-CSE-MsgGUID: +AxKUkd5QcKk5a6K6OO4ig==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="90386155"
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; 
   d="scan'208";a="90386155"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 00:50:46 -0700
X-CSE-ConnectionGUID: m6f+Z6VxQbWl3PudDr10Kw==
X-CSE-MsgGUID: dnhwaj+4R8ySotPmt3szaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; 
   d="scan'208";a="274816280"
Received: from weba0534.iind.intel.com ([10.66.226.131])
  by fmviesa010.fm.intel.com with ESMTP; 30 Sep 2026 00:50:44 -0700
From: Sai Teja Aluvala <aluvala.sai.teja@intel.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org
Cc: kiran.k@intel.com,
	chethan.tumkur.narayan@intel.com,
	Sai Teja Aluvala <aluvala.sai.teja@intel.com>
Subject: [PATCH v1 3/4] Bluetooth: btintel_pcie: add HW rfkill interrupt/doorbell flow
Date: Wed, 30 Sep 2026 13:12:19 +0530
Message-ID: <36e0f0a0d2ca076ef961a3f40bcac5955212a592.1790752799.git.aluvala.sai.teja@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1790752799.git.aluvala.sai.teja@intel.com>
References: <cover.1790752799.git.aluvala.sai.teja@intel.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add host-driven HW rfkill handling for Intel PCIe controllers and report
state changes to the Bluetooth stack with hci_rfkill_set_hw_state().

Enable the GP2 and HW_RFKILL MSI-X hardware causes. A HW_RFKILL
interrupt schedules a delayed worker that reads the FUNC_CTRL and
IPC_CONTROL registers to determine the HW rfkill state. On assertion,
the worker marks HW rfkill as active and reports a blocked state. On
release, it clears the IPC_CONTROL HW rfkill doorbell, waits for the
firmware GP2 acknowledgment, and reports an unblocked state only after
the acknowledgment is received. IPC_CONTROL updates are serialized with
a new ipc_lock.

After a successful setup, schedule an initial state check. That check
reports an already asserted HW rfkill state but does not report an
unblocked transition when rfkill was never asserted. The check flag is
consumed on every run so that it cannot suppress a later genuine
release.

On shutdown, cancel the worker and re-assert the doorbell if HW rfkill
is active before calling the common Intel shutdown handler. Cancel the
worker on remove, and disable it across PCIe FLR/PLDR recovery so that
it does not access registers while the device is being reset.

Signed-off-by: Sai Teja Aluvala <aluvala.sai.teja@intel.com>
---
 drivers/bluetooth/btintel_pcie.c | 140 ++++++++++++++++++++++++++++++-
 drivers/bluetooth/btintel_pcie.h |  27 ++++++
 2 files changed, 163 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index bcbfe2d5151a..d3c7842b3e43 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -2708,6 +2708,106 @@ static inline bool btintel_pcie_is_txackq_empty(struct btintel_pcie_data *data)
 	return data->ia.cr_tia[BTINTEL_PCIE_TXQ_NUM] == data->ia.cr_hia[BTINTEL_PCIE_TXQ_NUM];
 }
 
+static bool btintel_pcie_hw_rfkill_doorbell(struct btintel_pcie_data *data,
+					    bool state)
+{
+	unsigned long flags;
+	u32 reg;
+	int err;
+
+	data->rfkill_wait_done = false;
+
+	spin_lock_irqsave(&data->ipc_lock, flags);
+	reg = btintel_pcie_rd_reg32(data, BTINTEL_PCIE_CSR_IPC_CONTROL_REG);
+	if (state)
+		reg |= BTINTEL_PCIE_CSR_IPC_CONTROL_HW_RFKILL;
+	else
+		reg &= ~BTINTEL_PCIE_CSR_IPC_CONTROL_HW_RFKILL;
+	btintel_pcie_wr_reg32(data, BTINTEL_PCIE_CSR_IPC_CONTROL_REG, reg);
+	spin_unlock_irqrestore(&data->ipc_lock, flags);
+
+	err = wait_event_timeout(data->rfkill_wait_q, data->rfkill_wait_done,
+				 msecs_to_jiffies(BTINTEL_PCIE_HW_RFKILL_INTERRUPT_TIMEOUT));
+	if (!err) {
+		bt_dev_err(data->hdev, "Timeout (%u ms) on alive interrupt for RFKILL",
+			   BTINTEL_PCIE_HW_RFKILL_INTERRUPT_TIMEOUT);
+		return false;
+	}
+
+	return true;
+}
+
+static void btintel_pcie_hw_rfkill_delay_work(struct work_struct *wk)
+{
+	struct btintel_pcie_data *data =
+		container_of(wk, struct btintel_pcie_data, hw_rfkill_work.work);
+	u32 func_ctrl, ipc_ctrl;
+	bool set_rfkill, first_check;
+
+	/* Consume the initial post-setup state check unconditionally so it
+	 * cannot get stuck set after the "on" branch runs, which would
+	 * otherwise cause the next genuine "off" transition to be skipped.
+	 */
+	first_check = test_and_clear_bit(BTINTEL_PCIE_HW_RFKILL_STATE_CHECK,
+					 &data->flags);
+
+	func_ctrl = btintel_pcie_rd_reg32(data, BTINTEL_PCIE_CSR_FUNC_CTRL_REG);
+	ipc_ctrl = btintel_pcie_rd_reg32(data, BTINTEL_PCIE_CSR_IPC_CONTROL_REG);
+
+	set_rfkill = !(func_ctrl & BTINTEL_PCIE_CSR_FUNC_CTRL_HW_RFKILL) &&
+			    !(ipc_ctrl & BTINTEL_PCIE_CSR_IPC_CONTROL_HW_RFKILL);
+	if (set_rfkill) {
+		bt_dev_dbg(data->hdev, "hw rfkill on");
+		set_bit(BTINTEL_PCIE_HWRFKILL_ON, &data->flags);
+		hci_rfkill_set_hw_state(data->hdev, true);
+	} else {
+		bt_dev_dbg(data->hdev, "hw rfkill off");
+		/* Nothing changed at the initial post-setup check, so there
+		 * is no transition to report.
+		 */
+		if (first_check)
+			return;
+
+		if (btintel_pcie_hw_rfkill_doorbell(data, false)) {
+			clear_bit(BTINTEL_PCIE_HWRFKILL_ON, &data->flags);
+			hci_rfkill_set_hw_state(data->hdev, false);
+		}
+	}
+}
+
+static void btintel_delayed_hw_rfkill(struct btintel_pcie_data *data,
+				      bool delay)
+{
+	mod_delayed_work(system_wq, &data->hw_rfkill_work,
+			 delay ? msecs_to_jiffies(BTINTEL_PCIE_HW_RFKILL_DELAY) : 0);
+}
+
+static void btintel_pcie_msix_gp2_handler(struct btintel_pcie_data *data)
+{
+	u32 reg, boot_stage_reg;
+
+	boot_stage_reg = btintel_pcie_rd_reg32(data,
+					       BTINTEL_PCIE_CSR_BOOT_STAGE_REG);
+	reg = btintel_pcie_rd_reg32(data, BTINTEL_PCIE_CSR_IPC_STATUS_REG);
+
+	if ((reg & BTINTEL_PCIE_CSR_IPC_STATUS_HW_RFKILL) &&
+	    (boot_stage_reg & BTINTEL_PCIE_CSR_BOOT_STAGE_HW_RFKILL_STATE)) {
+		bt_dev_dbg(data->hdev,
+			   "firmware done handling HW RF-KILL SET state update");
+		data->rfkill_wait_done = true;
+	}
+
+	if (!(reg & BTINTEL_PCIE_CSR_IPC_STATUS_HW_RFKILL) &&
+	    !(boot_stage_reg & BTINTEL_PCIE_CSR_BOOT_STAGE_HW_RFKILL_STATE)) {
+		bt_dev_dbg(data->hdev,
+			   "firmware done handling HW RF-KILL CLEAR state update");
+		data->rfkill_wait_done = true;
+	}
+
+	if (data->rfkill_wait_done)
+		wake_up(&data->rfkill_wait_q);
+}
+
 static irqreturn_t btintel_pcie_irq_msix_handler(int irq, void *dev_id)
 {
 	struct msix_entry *entry = dev_id;
@@ -2738,6 +2838,8 @@ static irqreturn_t btintel_pcie_irq_msix_handler(int irq, void *dev_id)
 	if (intr_hw & BTINTEL_PCIE_MSIX_HW_INT_CAUSES_GP1)
 		btintel_pcie_msix_gp1_handler(data);
 
+	if (intr_hw & BTINTEL_PCIE_MSIX_HW_INT_CAUSES_GP2)
+		btintel_pcie_msix_gp2_handler(data);
 
 	/* For TX */
 	if (intr_fh & BTINTEL_PCIE_MSIX_FH_INT_CAUSES_0) {
@@ -2756,6 +2858,9 @@ static irqreturn_t btintel_pcie_irq_msix_handler(int irq, void *dev_id)
 	if (intr_hw & BTINTEL_PCIE_MSIX_HW_INT_CAUSES_FWTRIG)
 		btintel_pcie_msix_fw_trigger_handler(data);
 
+	if (intr_hw & BTINTEL_PCIE_MSIX_HW_INT_CAUSES_HW_RFKILL)
+		btintel_delayed_hw_rfkill(data, false);
+
 	/* This interrupt is triggered by the firmware after updating
 	 * boot_stage register and image_response register
 	 */
@@ -2829,8 +2934,10 @@ static struct btintel_pcie_causes_list causes_list[] = {
 	{ BTINTEL_PCIE_MSIX_FH_INT_CAUSES_0,	BTINTEL_PCIE_CSR_MSIX_FH_INT_MASK,	0x00 },
 	{ BTINTEL_PCIE_MSIX_FH_INT_CAUSES_1,	BTINTEL_PCIE_CSR_MSIX_FH_INT_MASK,	0x01 },
 	{ BTINTEL_PCIE_MSIX_HW_INT_CAUSES_GP0,	BTINTEL_PCIE_CSR_MSIX_HW_INT_MASK,	0x20 },
+	{ BTINTEL_PCIE_MSIX_HW_INT_CAUSES_GP2,	BTINTEL_PCIE_CSR_MSIX_HW_INT_MASK,	0x22 },
 	{ BTINTEL_PCIE_MSIX_HW_INT_CAUSES_HWEXP, BTINTEL_PCIE_CSR_MSIX_HW_INT_MASK,	0x23 },
 	{ BTINTEL_PCIE_MSIX_HW_INT_CAUSES_FWTRIG, BTINTEL_PCIE_CSR_MSIX_HW_INT_MASK,	0x25 },
+	{ BTINTEL_PCIE_MSIX_HW_INT_CAUSES_HW_RFKILL, BTINTEL_PCIE_CSR_MSIX_HW_INT_MASK,	0x27 },
 };
 
 /* This function configures the interrupt masks for both HW_INT_CAUSES and
@@ -3548,8 +3655,11 @@ static int btintel_pcie_setup(struct hci_dev *hdev)
 		btintel_pcie_start_rx(data);
 	}
 
-	if (!err)
+	if (!err) {
 		set_bit(BTINTEL_PCIE_SETUP_DONE, &data->flags);
+		set_bit(BTINTEL_PCIE_HW_RFKILL_STATE_CHECK, &data->flags);
+		btintel_delayed_hw_rfkill(data, true);
+	}
 	return err;
 }
 
@@ -3781,13 +3891,14 @@ static void btintel_pcie_reset_work(struct work_struct *wk)
 	btintel_pcie_synchronize_irqs(data);
 
 	flush_work(&data->rx_work);
-	/* Drain any in-flight dump workers and block new ones across reset.
-	 * Safe from self-deadlock: they all run on a separate wq.
+	/* Drain any in-flight dump/rfkill workers and block new ones across
+	 * reset. Safe from self-deadlock: they all run on a separate wq.
 	 */
 	disable_work_sync(&data->coredump_work);
 	disable_work_sync(&data->hwexp_work);
 	disable_work_sync(&data->fwtrigger_work);
 	disable_work_sync(&data->mbox_work);
+	disable_delayed_work_sync(&data->hw_rfkill_work);
 
 	bt_dev_dbg(data->hdev, "Release bluetooth interface");
 
@@ -3813,6 +3924,7 @@ static void btintel_pcie_reset_work(struct work_struct *wk)
 		enable_work(&data->hwexp_work);
 		enable_work(&data->fwtrigger_work);
 		enable_work(&data->mbox_work);
+		enable_delayed_work(&data->hw_rfkill_work);
 	}
 
 out:
@@ -4003,6 +4115,18 @@ static struct hci_drv btintel_pcie_hci_drv = {
 	.specific_handlers      = btintel_pcie_hci_drv_specific_handlers,
 };
 
+static int btintel_pcie_shutdown(struct hci_dev *hdev)
+{
+	struct btintel_pcie_data *data = hci_get_drvdata(hdev);
+
+	cancel_delayed_work_sync(&data->hw_rfkill_work);
+
+	if (test_bit(BTINTEL_PCIE_HWRFKILL_ON, &data->flags))
+		btintel_pcie_hw_rfkill_doorbell(data, true);
+
+	return btintel_shutdown_combined(hdev);
+}
+
 static int btintel_pcie_setup_hdev(struct btintel_pcie_data *data)
 {
 	int err;
@@ -4022,7 +4146,7 @@ static int btintel_pcie_setup_hdev(struct btintel_pcie_data *data)
 	hdev->close = btintel_pcie_close;
 	hdev->send = btintel_pcie_send_frame;
 	hdev->setup = btintel_pcie_setup;
-	hdev->shutdown = btintel_shutdown_combined;
+	hdev->shutdown = btintel_pcie_shutdown;
 	hdev->hw_error = btintel_pcie_hw_error;
 	hdev->set_diag = btintel_set_diag;
 	hdev->set_bdaddr = btintel_set_bdaddr;
@@ -4063,6 +4187,7 @@ static int btintel_pcie_probe(struct pci_dev *pdev,
 
 	spin_lock_init(&data->irq_lock);
 	spin_lock_init(&data->hci_rx_lock);
+	spin_lock_init(&data->ipc_lock);
 
 	init_waitqueue_head(&data->gp0_wait_q);
 	data->gp0_received = false;
@@ -4070,6 +4195,9 @@ static int btintel_pcie_probe(struct pci_dev *pdev,
 	init_waitqueue_head(&data->tx_wait_q);
 	data->tx_wait_done = false;
 
+	init_waitqueue_head(&data->rfkill_wait_q);
+	data->rfkill_wait_done = false;
+
 	init_waitqueue_head(&data->mbox_parse_wait_q);
 
 	data->workqueue = alloc_ordered_workqueue(KBUILD_MODNAME, WQ_HIGHPRI);
@@ -4084,6 +4212,8 @@ static int btintel_pcie_probe(struct pci_dev *pdev,
 
 	skb_queue_head_init(&data->rx_skb_q);
 	INIT_WORK(&data->rx_work, btintel_pcie_rx_work);
+	INIT_DELAYED_WORK(&data->hw_rfkill_work,
+			  btintel_pcie_hw_rfkill_delay_work);
 	INIT_WORK(&data->reset_work, btintel_pcie_reset_work);
 	INIT_WORK(&data->coredump_work, btintel_pcie_coredump_worker);
 	INIT_WORK(&data->hwexp_work, btintel_pcie_hwexp_worker);
@@ -4173,6 +4303,8 @@ static void btintel_pcie_remove(struct pci_dev *pdev)
 
 	btintel_pcie_synchronize_irqs(data);
 
+	cancel_delayed_work_sync(&data->hw_rfkill_work);
+
 	flush_work(&data->rx_work);
 
 	btintel_pcie_reset_bt(data);
diff --git a/drivers/bluetooth/btintel_pcie.h b/drivers/bluetooth/btintel_pcie.h
index 3030b4e8b750..55f08d6b621c 100644
--- a/drivers/bluetooth/btintel_pcie.h
+++ b/drivers/bluetooth/btintel_pcie.h
@@ -33,6 +33,7 @@
 #define BTINTEL_PCIE_CSR_FUNC_CTRL_MAC_INIT		(BIT(6))
 #define BTINTEL_PCIE_CSR_FUNC_CTRL_FUNC_INIT		(BIT(7))
 #define BTINTEL_PCIE_CSR_FUNC_CTRL_MAC_ACCESS_STS	(BIT(20))
+#define BTINTEL_PCIE_CSR_FUNC_CTRL_HW_RFKILL		(BIT(27))
 
 #define BTINTEL_PCIE_CSR_FUNC_CTRL_MAC_ACCESS_REQ	(BIT(21))
 
@@ -40,6 +41,12 @@
 #define BTINTEL_PCIE_CSR_FUNC_CTRL_BUS_MASTER_DISCON	(BIT(29))
 #define BTINTEL_PCIE_CSR_FUNC_CTRL_SW_RESET		(BIT(31))
 
+/* BTINTEL PCIE CSR IPC Control Register */
+#define BTINTEL_PCIE_CSR_IPC_CONTROL_HW_RFKILL		(BIT(7))
+
+/* BTINTEL PCIE CSR IPC Status Register */
+#define BTINTEL_PCIE_CSR_IPC_STATUS_HW_RFKILL		(BIT(7))
+
 /* Value for BTINTEL_PCIE_CSR_BOOT_STAGE register */
 #define BTINTEL_PCIE_CSR_BOOT_STAGE_ROM		(BIT(0))
 #define BTINTEL_PCIE_CSR_BOOT_STAGE_IML		(BIT(1))
@@ -53,6 +60,7 @@
 #define BTINTEL_PCIE_CSR_BOOT_STAGE_ALIVE		(BIT(23))
 /* Reflects live D-state. Updated by hardware on every D-state transition. */
 #define BTINTEL_PCIE_CSR_BOOT_STAGE_D3_STATE_READY	(BIT(24))
+#define BTINTEL_PCIE_CSR_BOOT_STAGE_HW_RFKILL_STATE	(BIT(25))
 
 #define BTINTEL_PCIE_CSR_DOORBELL_MBOX_READ_CONFIRM	(BIT(4))
 
@@ -135,8 +143,10 @@ enum msix_fh_int_causes {
 enum msix_hw_int_causes {
 	BTINTEL_PCIE_MSIX_HW_INT_CAUSES_GP0	= BIT(0),	/* cause 32 */
 	BTINTEL_PCIE_MSIX_HW_INT_CAUSES_GP1	= BIT(1),	/* cause 33 */
+	BTINTEL_PCIE_MSIX_HW_INT_CAUSES_GP2	= BIT(2),	/* cause 34 */
 	BTINTEL_PCIE_MSIX_HW_INT_CAUSES_HWEXP	= BIT(3),	/* cause 35 */
 	BTINTEL_PCIE_MSIX_HW_INT_CAUSES_FWTRIG	= BIT(5),	/* cause 37 */
+	BTINTEL_PCIE_MSIX_HW_INT_CAUSES_HW_RFKILL	= BIT(7),	/* cause 39 */
 };
 
 /* PCIe device states
@@ -155,6 +165,8 @@ enum {
 	BTINTEL_PCIE_COREDUMP_INPROGRESS,
 	BTINTEL_PCIE_FWTRIGGER_DUMP_INPROGRESS,
 	BTINTEL_PCIE_RECOVERY_IN_PROGRESS,
+	BTINTEL_PCIE_HWRFKILL_ON,
+	BTINTEL_PCIE_HW_RFKILL_STATE_CHECK,
 	BTINTEL_PCIE_SETUP_DONE,
 	BTINTEL_PCIE_MAIL_BOX_INTR,
 	BTINTEL_PCIE_MBOX_PARSE_PENDING,
@@ -215,6 +227,12 @@ enum btintel_pcie_mbox_msg {
 
 #define BTINTEL_PCIE_DX_TRANSITION_MAX_RETRIES	3
 
+/* HW rfkill interrupt timeout */
+#define BTINTEL_PCIE_HW_RFKILL_INTERRUPT_TIMEOUT	200
+
+/* HW rfkill check timeout */
+#define BTINTEL_PCIE_HW_RFKILL_DELAY			1000
+
 /* The number of descriptors in TX queues */
 #define BTINTEL_PCIE_TX_DESCS_COUNT	32
 
@@ -680,6 +698,7 @@ struct btintel_pcie_ini_dump_info {
  * @flags: driver state
  * @irq_lock: spinlock for MSI-X
  * @hci_rx_lock: spinlock for HCI RX flow
+ * @ipc_lock: spinlock for IPC control register read-modify-write
  * @base_addr: pci base address (from BAR)
  * @msix_entries: array of MSI-X entries
  * @msix_enabled: true if MSI-X is enabled;
@@ -696,6 +715,8 @@ struct btintel_pcie_ini_dump_info {
  * @gp0_wait_q: wait_q for gp0 interrupt
  * @tx_wait_done: condition for tx interrupt
  * @tx_wait_q: wait_q for tx interrupt
+ * @rfkill_wait_done: condition for HW rfkill GP2 interrupt
+ * @rfkill_wait_q: wait_q for HW rfkill GP2 interrupt
  * @workqueue: workqueue for RX work
  * @rx_skb_q: SKB queue for RX packet
  * @rx_work: RX work struct to process the RX packet in @rx_skb_q
@@ -723,6 +744,8 @@ struct btintel_pcie_data {
 	spinlock_t	irq_lock;
 	/* lock to serialize rx events */
 	spinlock_t	hci_rx_lock;
+	/* lock to serialize IPC control register updates */
+	spinlock_t	ipc_lock;
 
 	void __iomem	*base_addr;
 
@@ -747,9 +770,13 @@ struct btintel_pcie_data {
 	bool	tx_wait_done;
 	wait_queue_head_t	tx_wait_q;
 
+	bool	rfkill_wait_done;
+	wait_queue_head_t	rfkill_wait_q;
+
 	struct workqueue_struct	*workqueue;
 	struct sk_buff_head	rx_skb_q;
 	struct work_struct	rx_work;
+	struct delayed_work	hw_rfkill_work;
 	struct work_struct      reset_work;
 
 	struct workqueue_struct	*dump_workqueue;
-- 
2.53.0

