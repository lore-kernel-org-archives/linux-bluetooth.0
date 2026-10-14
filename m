Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E8A4A49A5
	for <linux-bluetooth@vger.kernel.org>; Wed, 14 Oct 2026 08:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791966925; cv=none; b=KivnpgM5pI0nwCzviazJvBLDT+oWvv8+loK+kLctliOGQdzNrXpYVGTwNWvUWMXnEL6hZ1F8flXnYTNdKRMECqNWYi9QhHRj26RIB0YRrFYrO34hDpBc8M7+KTPL5/1sggckzlnOhtj6m66yAuYEcb4xJrvib49NYnZ3OPpyjik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791966925; c=relaxed/simple;
	bh=IOJ3kKSmi6APpDQQkw2Rez2HeIy8D5nUnQATTDdKki8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cCeBmp+APXN8zBRELGLkhaXA1jP44VFRJZqPtxpvmpXf7DoeOkFxa7gMIrjhc+XJmFOAf7QHy/UxYqfk/Y8OKLp4ecE9lU+GHyDb8RJp3Ivya6DUgpnGipAg/j5GDxuMOWgQRQEMvPxVjBCdtxBBUVmFSLA7mCmi+FwiNsn2a9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jw63SoEz; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jw63SoEz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791966921; x=1823502921;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IOJ3kKSmi6APpDQQkw2Rez2HeIy8D5nUnQATTDdKki8=;
  b=jw63SoEzd+zATnBPGDcRn/L+fIekTFOPSksAUroLLPqhlc9BdAaLn28R
   qbATsxeJpegKYqCGwiDgNsBcfh/7qWR91rL8MU2zkTick5jjqpPb6h6rj
   GPyXknwfhAPqHYcB5k33e7cnlFxNsMAVkFL8LGBbWRmSBfxBkEyqDooAl
   mAXmsPgrUOv4FFR7a9avvMvrMEFnN6ZGDwCLjgKprUic1oECNMRrBILGv
   IYylk+aNW8Rk7sesS9w9kyMyAYXHQgVqo2jwpOJ/vATIawOyttNYVdAj1
   F/yOJBIUrHgdCQZEGPeYOh4Aa1nf7wMTi3uXC+PQtp63cgVNnAvUXv/Xg
   A==;
X-CSE-ConnectionGUID: uKcNlHxBTkm8d85Y9E6fFQ==
X-CSE-MsgGUID: 6WnQU4FwSBWch2alMw5KUA==
X-IronPort-AV: E=McAfee;i="6800,10657,11934"; a="593403"
X-IronPort-AV: E=Sophos;i="6.27,157,1787036400"; 
   d="scan'208";a="593403"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2026 01:35:21 -0700
X-CSE-ConnectionGUID: 6Z/5weY6QlCjkDPfo+SqLw==
X-CSE-MsgGUID: AiPXpTBHS2e3wgmGzK6CWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,157,1787036400"; 
   d="scan'208";a="1704438"
Received: from weba0534.iind.intel.com ([10.66.226.131])
  by fmviesa008.fm.intel.com with ESMTP; 14 Oct 2026 01:35:20 -0700
From: Sai Teja Aluvala <aluvala.sai.teja@intel.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org
Cc: kiran.k@intel.com,
	chethan.tumkur.narayan@intel.com,
	Sai Teja Aluvala <aluvala.sai.teja@intel.com>
Subject: [PATCH v4 2/2] Bluetooth: btintel_pcie: add HW rfkill interrupt/doorbell flow
Date: Wed, 14 Oct 2026 13:56:50 +0530
Message-ID: <20261014082650.1270679-3-aluvala.sai.teja@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261014082650.1270679-1-aluvala.sai.teja@intel.com>
References: <20261014082650.1270679-1-aluvala.sai.teja@intel.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add host-driven HW rfkill handling for Intel PCIe Bluetooth
controllers and report state changes to the Bluetooth stack through
hci_rfkill_set_hw_state(). The GP2 and HW_RFKILL MSI-X hardware
causes are enabled so that the host can detect a HW rfkill assertion
and hand its acknowledgment back to firmware.

On a HW_RFKILL interrupt, a delayed worker reads the FUNC_CTRL and
IPC_CONTROL registers to determine whether the switch is asserted or
released. On assertion, the worker marks HW rfkill as active and
reports a blocked state directly. On release, it clears the
IPC_CONTROL HW rfkill doorbell bit, waits for the firmware's GP2
acknowledgment that matches the requested transition, and reports
an unblocked state to the stack only once that acknowledgment
arrives. IPC_CONTROL register read-modify-write updates are
serialized with a new ipc_lock, and the wait state/done flags use
READ_ONCE()/WRITE_ONCE() since they are shared between the worker
and the MSI-X handler.

After a successful setup or resume, an initial state check is
scheduled. That check reports an already-asserted HW rfkill state,
and also reports a release if rfkill was asserted before suspend and
cleared while the controller was asleep; otherwise it is a no-op so
it cannot suppress a later genuine transition.

The HW_RFKILL MSI-X cause is masked before synchronizing interrupts
and canceling or draining the worker across setup retry, reset,
shutdown, probe failure, remove, and suspend, and is unmasked again
after setup and resume succeed. GP2 is left enabled throughout so
that the shutdown path can still wait for the firmware's doorbell
acknowledgment when re-asserting rfkill before the controller is
powered down. If the shutdown is itself caused by an active HW
rfkill assertion, monitoring is left enabled instead, so a later
de-assertion can still be detected.

Since a masked cause still latches, the MSI-X handler only queues the
worker while HW_RFKILL is unmasked, and remove and probe failure
disable the worker so it cannot be requeued after data is freed.

Signed-off-by: Sai Teja Aluvala <aluvala.sai.teja@intel.com>
---
 drivers/bluetooth/btintel_pcie.c | 202 +++++++++++++++++++++++++++++--
 drivers/bluetooth/btintel_pcie.h |  30 +++++
 2 files changed, 224 insertions(+), 8 deletions(-)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index 91b1ee9d6010..6c5665a9a10d 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -2710,15 +2710,126 @@ static inline bool btintel_pcie_is_txackq_empty(struct btintel_pcie_data *data)
 	return data->ia.cr_tia[BTINTEL_PCIE_TXQ_NUM] == data->ia.cr_hia[BTINTEL_PCIE_TXQ_NUM];
 }
 
+static bool btintel_pcie_hw_rfkill_doorbell(struct btintel_pcie_data *data,
+					    bool state)
+{
+	unsigned long flags;
+	u32 reg;
+	int err;
+
+	WRITE_ONCE(data->rfkill_wait_done, false);
+	WRITE_ONCE(data->rfkill_wait_state, state);
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
+	err = wait_event_timeout(data->rfkill_wait_q,
+				 READ_ONCE(data->rfkill_wait_done),
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
+	if (!data->hdev)
+		return;
+
+	/* Do not report an initial clear when rfkill was never asserted.
+	 * After resume, however, a previously asserted rfkill must be
+	 * cleared and reported to the HCI stack.
+	 */
+	first_check = test_and_clear_bit(BTINTEL_PCIE_HW_RFKILL_STATE_CHECK,
+					 &data->flags);
+
+	func_ctrl = btintel_pcie_rd_reg32(data, BTINTEL_PCIE_CSR_FUNC_CTRL_REG);
+	ipc_ctrl = btintel_pcie_rd_reg32(data, BTINTEL_PCIE_CSR_IPC_CONTROL_REG);
+
+	set_rfkill = !(func_ctrl & BTINTEL_PCIE_CSR_FUNC_CTRL_HW_RFKILL) &&
+		     !(ipc_ctrl & BTINTEL_PCIE_CSR_IPC_CONTROL_HW_RFKILL);
+	if (set_rfkill) {
+		bt_dev_dbg(data->hdev, "hw rfkill on");
+		set_bit(BTINTEL_PCIE_HWRFKILL_ON, &data->flags);
+		hci_rfkill_set_hw_state(data->hdev, true);
+	} else {
+		bt_dev_dbg(data->hdev, "hw rfkill off");
+		/* Nothing changed at the initial post-setup check, so there
+		 * is no transition to report.
+		 */
+		if (first_check &&
+		    !test_bit(BTINTEL_PCIE_HWRFKILL_ON, &data->flags))
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
+	bool state;
+
+	boot_stage_reg = btintel_pcie_rd_reg32(data,
+					       BTINTEL_PCIE_CSR_BOOT_STAGE_REG);
+	reg = btintel_pcie_rd_reg32(data, BTINTEL_PCIE_CSR_IPC_STATUS_REG);
+	state = READ_ONCE(data->rfkill_wait_state);
+
+	if (state &&
+	    (reg & BTINTEL_PCIE_CSR_IPC_STATUS_HW_RFKILL) &&
+	    (boot_stage_reg & BTINTEL_PCIE_CSR_BOOT_STAGE_HW_RFKILL_STATE)) {
+		bt_dev_dbg(data->hdev,
+			   "firmware done handling HW RF-KILL SET state update");
+		WRITE_ONCE(data->rfkill_wait_done, true);
+	}
+
+	if (!state &&
+	    !(reg & BTINTEL_PCIE_CSR_IPC_STATUS_HW_RFKILL) &&
+	    !(boot_stage_reg & BTINTEL_PCIE_CSR_BOOT_STAGE_HW_RFKILL_STATE)) {
+		bt_dev_dbg(data->hdev,
+			   "firmware done handling HW RF-KILL CLEAR state update");
+		WRITE_ONCE(data->rfkill_wait_done, true);
+	}
+
+	if (READ_ONCE(data->rfkill_wait_done))
+		wake_up(&data->rfkill_wait_q);
+}
+
 static irqreturn_t btintel_pcie_irq_msix_handler(int irq, void *dev_id)
 {
 	struct msix_entry *entry = dev_id;
 	struct btintel_pcie_data *data = btintel_pcie_get_data(entry);
-	u32 intr_fh, intr_hw;
+	u32 intr_fh, intr_hw, hw_mask;
 
 	spin_lock(&data->irq_lock);
 	intr_fh = btintel_pcie_rd_reg32(data, BTINTEL_PCIE_CSR_MSIX_FH_INT_CAUSES);
 	intr_hw = btintel_pcie_rd_reg32(data, BTINTEL_PCIE_CSR_MSIX_HW_INT_CAUSES);
+	hw_mask = btintel_pcie_rd_reg32(data, BTINTEL_PCIE_CSR_MSIX_HW_INT_MASK);
 
 	/* Clear causes registers to avoid being handling the same cause */
 	btintel_pcie_wr_reg32(data, BTINTEL_PCIE_CSR_MSIX_FH_INT_CAUSES, intr_fh);
@@ -2740,6 +2851,8 @@ static irqreturn_t btintel_pcie_irq_msix_handler(int irq, void *dev_id)
 	if (intr_hw & BTINTEL_PCIE_MSIX_HW_INT_CAUSES_GP1)
 		btintel_pcie_msix_gp1_handler(data);
 
+	if (intr_hw & BTINTEL_PCIE_MSIX_HW_INT_CAUSES_GP2)
+		btintel_pcie_msix_gp2_handler(data);
 
 	/* For TX */
 	if (intr_fh & BTINTEL_PCIE_MSIX_FH_INT_CAUSES_0) {
@@ -2758,6 +2871,11 @@ static irqreturn_t btintel_pcie_irq_msix_handler(int irq, void *dev_id)
 	if (intr_hw & BTINTEL_PCIE_MSIX_HW_INT_CAUSES_FWTRIG)
 		btintel_pcie_msix_fw_trigger_handler(data);
 
+	/* A masked cause still latches; ignore it once masked. */
+	if ((intr_hw & BTINTEL_PCIE_MSIX_HW_INT_CAUSES_HW_RFKILL) &&
+	    !(hw_mask & BTINTEL_PCIE_MSIX_HW_INT_CAUSES_HW_RFKILL))
+		btintel_delayed_hw_rfkill(data, false);
+
 	/* This interrupt is triggered by the firmware after updating
 	 * boot_stage register and image_response register
 	 */
@@ -2835,8 +2953,10 @@ static struct btintel_pcie_causes_list causes_list[] = {
 	{ BTINTEL_PCIE_MSIX_FH_INT_CAUSES_0,	BTINTEL_PCIE_CSR_MSIX_FH_INT_MASK,	0x00 },
 	{ BTINTEL_PCIE_MSIX_FH_INT_CAUSES_1,	BTINTEL_PCIE_CSR_MSIX_FH_INT_MASK,	0x01 },
 	{ BTINTEL_PCIE_MSIX_HW_INT_CAUSES_GP0,	BTINTEL_PCIE_CSR_MSIX_HW_INT_MASK,	0x20 },
+	{ BTINTEL_PCIE_MSIX_HW_INT_CAUSES_GP2,	BTINTEL_PCIE_CSR_MSIX_HW_INT_MASK,	0x22 },
 	{ BTINTEL_PCIE_MSIX_HW_INT_CAUSES_HWEXP, BTINTEL_PCIE_CSR_MSIX_HW_INT_MASK,	0x23 },
 	{ BTINTEL_PCIE_MSIX_HW_INT_CAUSES_FWTRIG, BTINTEL_PCIE_CSR_MSIX_HW_INT_MASK,	0x25 },
+	{ BTINTEL_PCIE_MSIX_HW_INT_CAUSES_HW_RFKILL, BTINTEL_PCIE_CSR_MSIX_HW_INT_MASK,	0x27 },
 };
 
 /* This function configures the interrupt masks for both HW_INT_CAUSES and
@@ -3353,6 +3473,22 @@ static void btintel_pcie_disable_interrupts(struct btintel_pcie_data *data)
 	spin_unlock(&data->irq_lock);
 }
 
+static void btintel_pcie_mask_hw_rfkill(struct btintel_pcie_data *data)
+{
+	spin_lock(&data->irq_lock);
+	btintel_pcie_set_reg_bits(data, BTINTEL_PCIE_CSR_MSIX_HW_INT_MASK,
+				  BTINTEL_PCIE_MSIX_HW_INT_CAUSES_HW_RFKILL);
+	spin_unlock(&data->irq_lock);
+}
+
+static void btintel_pcie_unmask_hw_rfkill(struct btintel_pcie_data *data)
+{
+	spin_lock(&data->irq_lock);
+	btintel_pcie_clr_reg_bits(data, BTINTEL_PCIE_CSR_MSIX_HW_INT_MASK,
+				  BTINTEL_PCIE_MSIX_HW_INT_CAUSES_HW_RFKILL);
+	spin_unlock(&data->irq_lock);
+}
+
 static void btintel_pcie_enable_interrupts(struct btintel_pcie_data *data)
 {
 	spin_lock(&data->irq_lock);
@@ -3535,8 +3671,10 @@ static int btintel_pcie_setup(struct hci_dev *hdev)
 		bt_dev_err(hdev, "Firmware download retry count: %d",
 			   fw_dl_retry);
 		btintel_pcie_dump_debug_registers(hdev);
-		btintel_pcie_disable_interrupts(data);
+		btintel_pcie_mask_hw_rfkill(data);
 		btintel_pcie_synchronize_irqs(data);
+		cancel_delayed_work_sync(&data->hw_rfkill_work);
+		btintel_pcie_disable_interrupts(data);
 		err = btintel_pcie_reset_bt(data);
 		if (err) {
 			bt_dev_err(hdev, "Failed to do shr reset: %d", err);
@@ -3554,8 +3692,12 @@ static int btintel_pcie_setup(struct hci_dev *hdev)
 		btintel_pcie_start_rx(data);
 	}
 
-	if (!err)
+	if (!err) {
 		set_bit(BTINTEL_PCIE_SETUP_DONE, &data->flags);
+		set_bit(BTINTEL_PCIE_HW_RFKILL_STATE_CHECK, &data->flags);
+		btintel_pcie_unmask_hw_rfkill(data);
+		btintel_delayed_hw_rfkill(data, true);
+	}
 	return err;
 }
 
@@ -3783,18 +3925,20 @@ static void btintel_pcie_reset_work(struct work_struct *wk)
 	if (!data)
 		goto out;
 
+	btintel_pcie_mask_hw_rfkill(data);
+	btintel_pcie_synchronize_irqs(data);
+	disable_delayed_work_sync(&data->hw_rfkill_work);
 	btintel_pcie_disable_interrupts(data);
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
-
 	bt_dev_dbg(data->hdev, "Release bluetooth interface");
 
 	/* Both reset paths follow the same contract: on success they
@@ -3819,6 +3963,7 @@ static void btintel_pcie_reset_work(struct work_struct *wk)
 		enable_work(&data->hwexp_work);
 		enable_work(&data->fwtrigger_work);
 		enable_work(&data->mbox_work);
+		enable_delayed_work(&data->hw_rfkill_work);
 	}
 
 out:
@@ -4009,6 +4154,24 @@ static struct hci_drv btintel_pcie_hci_drv = {
 	.specific_handlers      = btintel_pcie_hci_drv_specific_handlers,
 };
 
+static int btintel_pcie_shutdown(struct hci_dev *hdev)
+{
+	struct btintel_pcie_data *data = hci_get_drvdata(hdev);
+
+	/* Keep monitoring if shutting down due to an active HW rfkill
+	 * assertion, so a later de-assertion can still be detected.
+	 */
+	if (test_bit(BTINTEL_PCIE_HWRFKILL_ON, &data->flags)) {
+		btintel_pcie_hw_rfkill_doorbell(data, true);
+	} else {
+		btintel_pcie_mask_hw_rfkill(data);
+		btintel_pcie_synchronize_irqs(data);
+		cancel_delayed_work_sync(&data->hw_rfkill_work);
+	}
+
+	return btintel_shutdown_combined(hdev);
+}
+
 static int btintel_pcie_setup_hdev(struct btintel_pcie_data *data)
 {
 	int err;
@@ -4028,7 +4191,7 @@ static int btintel_pcie_setup_hdev(struct btintel_pcie_data *data)
 	hdev->close = btintel_pcie_close;
 	hdev->send = btintel_pcie_send_frame;
 	hdev->setup = btintel_pcie_setup;
-	hdev->shutdown = btintel_shutdown_combined;
+	hdev->shutdown = btintel_pcie_shutdown;
 	hdev->hw_error = btintel_pcie_hw_error;
 	hdev->set_diag = btintel_set_diag;
 	hdev->set_bdaddr = btintel_set_bdaddr;
@@ -4069,6 +4232,7 @@ static int btintel_pcie_probe(struct pci_dev *pdev,
 
 	spin_lock_init(&data->irq_lock);
 	spin_lock_init(&data->hci_rx_lock);
+	spin_lock_init(&data->ipc_lock);
 
 	init_waitqueue_head(&data->gp0_wait_q);
 	data->gp0_received = false;
@@ -4076,6 +4240,9 @@ static int btintel_pcie_probe(struct pci_dev *pdev,
 	init_waitqueue_head(&data->tx_wait_q);
 	data->tx_wait_done = false;
 
+	init_waitqueue_head(&data->rfkill_wait_q);
+	data->rfkill_wait_done = false;
+
 	init_waitqueue_head(&data->mbox_parse_wait_q);
 
 	data->workqueue = alloc_ordered_workqueue(KBUILD_MODNAME, WQ_HIGHPRI);
@@ -4090,6 +4257,8 @@ static int btintel_pcie_probe(struct pci_dev *pdev,
 
 	skb_queue_head_init(&data->rx_skb_q);
 	INIT_WORK(&data->rx_work, btintel_pcie_rx_work);
+	INIT_DELAYED_WORK(&data->hw_rfkill_work,
+			  btintel_pcie_hw_rfkill_delay_work);
 	INIT_WORK(&data->reset_work, btintel_pcie_reset_work);
 	INIT_WORK(&data->coredump_work, btintel_pcie_coredump_worker);
 	INIT_WORK(&data->hwexp_work, btintel_pcie_hwexp_worker);
@@ -4135,6 +4304,10 @@ static int btintel_pcie_probe(struct pci_dev *pdev,
 	return 0;
 
 exit_error:
+	btintel_pcie_mask_hw_rfkill(data);
+	btintel_pcie_synchronize_irqs(data);
+	disable_delayed_work_sync(&data->hw_rfkill_work);
+
 	/* reset device before exit */
 	btintel_pcie_reset_bt(data);
 
@@ -4175,8 +4348,11 @@ static void btintel_pcie_remove(struct pci_dev *pdev)
 	if (current_work() != &data->reset_work)
 		disable_work_sync(&data->reset_work);
 
-	btintel_pcie_disable_interrupts(data);
+	btintel_pcie_mask_hw_rfkill(data);
+	btintel_pcie_synchronize_irqs(data);
+	disable_delayed_work_sync(&data->hw_rfkill_work);
 
+	btintel_pcie_disable_interrupts(data);
 	btintel_pcie_synchronize_irqs(data);
 
 	flush_work(&data->rx_work);
@@ -4317,6 +4493,10 @@ static int btintel_pcie_suspend_late(struct device *dev, pm_message_t mesg)
 
 	data = pci_get_drvdata(pdev);
 
+	btintel_pcie_mask_hw_rfkill(data);
+	btintel_pcie_synchronize_irqs(data);
+	cancel_delayed_work_sync(&data->hw_rfkill_work);
+
 	/* S0ix (s2idle) uses D3_HOT; S3, freeze and hibernate use D3_COLD. */
 	if (mesg.event == PM_EVENT_SUSPEND &&
 	    pm_suspend_target_state == PM_SUSPEND_TO_IDLE)
@@ -4330,6 +4510,9 @@ static int btintel_pcie_suspend_late(struct device *dev, pm_message_t mesg)
 	err = btintel_pcie_set_dxstate(data, dxstate);
 
 	if (err) {
+		btintel_pcie_unmask_hw_rfkill(data);
+		set_bit(BTINTEL_PCIE_HW_RFKILL_STATE_CHECK, &data->flags);
+		btintel_delayed_hw_rfkill(data, true);
 		bt_dev_err(data->hdev, "Failed to set dxstate:%u (%d)",
 			   dxstate, err);
 		return err;
@@ -4384,6 +4567,9 @@ static int btintel_pcie_resume_event(struct device *dev, pm_message_t mesg)
 	if (err) {
 		bt_dev_err(data->hdev, "Failed to set D0 state (%d)", err);
 	} else {
+		btintel_pcie_unmask_hw_rfkill(data);
+		set_bit(BTINTEL_PCIE_HW_RFKILL_STATE_CHECK, &data->flags);
+		btintel_delayed_hw_rfkill(data, true);
 		bt_dev_dbg(data->hdev,
 			   "device entered into d0 state from d3 in %lld us",
 			   ktime_to_us(ktime_get() - start));
diff --git a/drivers/bluetooth/btintel_pcie.h b/drivers/bluetooth/btintel_pcie.h
index 3030b4e8b750..dda711f7755d 100644
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
@@ -696,6 +715,10 @@ struct btintel_pcie_ini_dump_info {
  * @gp0_wait_q: wait_q for gp0 interrupt
  * @tx_wait_done: condition for tx interrupt
  * @tx_wait_q: wait_q for tx interrupt
+ * @rfkill_wait_done: condition for HW rfkill GP2 interrupt
+ * @rfkill_wait_state: requested HW rfkill transition (set or clear)
+ *	being waited on, used to validate the GP2 acknowledgment
+ * @rfkill_wait_q: wait_q for HW rfkill GP2 interrupt
  * @workqueue: workqueue for RX work
  * @rx_skb_q: SKB queue for RX packet
  * @rx_work: RX work struct to process the RX packet in @rx_skb_q
@@ -723,6 +746,8 @@ struct btintel_pcie_data {
 	spinlock_t	irq_lock;
 	/* lock to serialize rx events */
 	spinlock_t	hci_rx_lock;
+	/* lock to serialize IPC control register updates */
+	spinlock_t	ipc_lock;
 
 	void __iomem	*base_addr;
 
@@ -747,9 +772,14 @@ struct btintel_pcie_data {
 	bool	tx_wait_done;
 	wait_queue_head_t	tx_wait_q;
 
+	bool	rfkill_wait_done;
+	bool	rfkill_wait_state;
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

